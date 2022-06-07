<?php

namespace Database\Seeders;

use Crater\Models\Company;
use Crater\Models\Setting;
use Crater\Models\User;
use Illuminate\Database\Seeder;
use Silber\Bouncer\BouncerFacade;
use Vinkla\Hashids\Facades\Hashids;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $user = User::create([
            'email' => 'superman@craterapp.com',
            'name' => 'Super Man',
            'role' => 'super admin',
            'password' => 'Admin!123',
        ]);

        $company = Company::create([
            'name' => 'Bahmni',
            'owner_id' => $user->id,
            'slug' => 'bahmni'
        ]);

        $company->unique_hash = Hashids::connection(Company::class)->encode($company->id);
        $company->save();
        $company->setupDefaultData();
        $user->companies()->attach($company->id);
        BouncerFacade::scope()->to($company->id);

        $user->assign('super admin');

        Setting::setSetting('profile_complete', 0);
    }
}
