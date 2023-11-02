Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792767DEE97
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 10:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjKBJFn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 05:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjKBJFm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 05:05:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3F5136;
        Thu,  2 Nov 2023 02:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRk42SNDJDcM/bJWPRmnXtU3P6eh92Poc4eHPopNZvUjdGj7VmewQIxHxpMFfjL+0HKc7BaNxRB5JJtvtfPZYFrtgPANIo+JyKiXHNO2HjG9WGfJnmuYoAIglXxbh/g5fhQLtTz94fIBg4Va+B8refzeD+2eYV5EVXia1mIzmhQnAvY75VjOdb9LZqY2Zr2XEnsUF33/c1UIjqTeT99/HsDqqIIHCfCtkwV3S+VWSUNH6EUaF/7rNObAeEqG8CtCf+r2No01CVVWYXYYeY2O98mCjQURL1sqQAwuhA9rs34N1hOtx9J4wDNZtLUxO/6Y5bvGziXwdb2JyVLo2QIurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYB3UOYGnHp0CH5CCgi3Bp+aFj/ABWRYGux7tTS6Ftc=;
 b=OjYySPCxW93iKJIPO8VyDET0EmSZ06rECJr0IwJZfXCL7fLlPqIsLRRQDrGFWzRFs6+WWKlSWMQIPEFA/UEkSF4Fv+hYSdGPdG6xbYWR0lwG5DREkfIz28XWB0vsIO2qS0YZhBFMcFoLFyvm33DS8Zw6WL3ps3yIO6NHgcTSmSg+fYIHfwHkSBkc7HkUrJ6QpSYU1SoImz+WYMXfN4mWQhgDcyfVy9WUrKjQ/Bn7ttaIsV5JmTh6I8B+9m/28S+xFtn3qondivqaJ8RdkgQFaFoZKr+ngfIGyWETizRto63/i+aPrPKMloq4mp8teKb3W0Lf/7d/woKp8iy0uJqjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYB3UOYGnHp0CH5CCgi3Bp+aFj/ABWRYGux7tTS6Ftc=;
 b=l2VgjHTD4pUTb6tuCldLh4DfTltlfJiGGhXqMPsCt6Q3U0tc3SmerRYmUQRWKKQ6yIJRJauBKkenzcdWdNxLezFsP3rQJhj/B9WVTH0mAGCs+6XKxcib4a94EgyOglhbAFCE4say9W8+QhIenqxHHTcRaLYVD/L0JN/MpM+aWz4=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 09:05:34 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::2f3f:cf6e:c3a5:90db]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::2f3f:cf6e:c3a5:90db%2]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 09:05:33 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
Subject: RE: [PATCH V10 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred
 core supporting.
Thread-Topic: [PATCH V10 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred
 core supporting.
Thread-Index: AQHaCvtFgLD/Z8mBTEyO9Wzi2Ra227Bmv2oA
Date:   Thu, 2 Nov 2023 09:05:33 +0000
Message-ID: <CYYPR12MB86553FEBDCEB730FF606D2549CA6A@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20231030063403.3502816-1-li.meng@amd.com>
 <20231030063403.3502816-4-li.meng@amd.com>
In-Reply-To: <20231030063403.3502816-4-li.meng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=962b80e8-47c8-4d0d-8d77-9d49e308844c;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-02T08:58:03Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CY8PR12MB8216:EE_
x-ms-office365-filtering-correlation-id: 18e599bd-8f43-4e4f-c471-08dbdb82df27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E16pKP8HVXrw64g7OZJpf9pMDJO8FVY+vlacXqK2xre+hFlR7T9D56tsdq7Fj3HNojK733rZFFOZiNkcMs5GA/16PqMvIdDYxaeRDEE7uexis4EGUBfx5ZSdV4ZpO7rKXD4SAj2s5EObYSJUwFeTEABQM/hecKU6+4SjFA9OmVn6cH6a1yM7q8YoElwGL95s1EP5ijMElrDDFzdxhMHpjBt5O2gEcnQ4t5csW5SWbdOidcQV0LVQuQzixOpK4JzIbwDpZ6AJkSxTzQERbK1CXqNg+sv+x2NY01xLCD157aQBbacWj5Fshnn0ic5z0WiOHqN7XTAzT1DCfLC0v93Lm/ruhiF5d8Ljb/tCAIxhm2uruSRO7WbnpJuuebMYUmGiF+8e1Cy4Q7prZztFmR9Kxvu5vSp8w4TI9BFn5nyz5ZnNNf5YEGjauOHA5XeZU7FxmZ+0fKh+lZyDDGV7Rj7+rh5oQnrRm972Z3hebpgZS+xEVgNog6L3zAWwYRey9qDLCaAgz/nEcz7NtkoMmp/cp/oZXoXZVssL6wNTLvyxdwW0ilPC7Su/nusvP8MGbNuE0Yn/QOZAPYz9p7apusQ9o7/Kapk7P9iM0v79JJqh6zTtUZogdPNgPk2LqmHrXOS5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(55016003)(7696005)(53546011)(478600001)(6506007)(38100700002)(38070700009)(122000001)(9686003)(76116006)(5660300002)(66446008)(66556008)(66476007)(52536014)(54906003)(86362001)(66946007)(110136005)(7416002)(6636002)(64756008)(41300700001)(71200400001)(26005)(8936002)(83380400001)(8676002)(4326008)(2906002)(30864003)(316002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?He5D9XlGWXO68MVjWVOmB8o/Jsf5MUc1N7FYO1FfPt0U4IotjGus95rqgO2J?=
 =?us-ascii?Q?SZaeP2GN+xAj9NAqwmSvJNK6+bNMUAZqpfeU6rOIO4IXv4/PP/BoZ8B4+6P5?=
 =?us-ascii?Q?I++QhW11H5xd8ZJa+C4JHc9QRjCoA//cKwORiRHmPZYgc3cKNH5Bx+ZZHuC1?=
 =?us-ascii?Q?JXPmEu+XbmLByYn7aemGyiArGphJQtlaIk2Jvy34Y3jI/fhY2z1r8ATEpkO2?=
 =?us-ascii?Q?2D7t2Li47v82nwhNxzfFbOxhXwoGd7xWwIMaf5nEBrAwUeSIZ2/ODNxHgY2X?=
 =?us-ascii?Q?RTiM8OCcBOvSu9/jjFCJRy14+ZMsuGUXcv7WALqd1haeyZWPkQIbY1Brcl5P?=
 =?us-ascii?Q?52kuY4ab9MuCRsF19MkZnL7IVOpSqtP9jyPhf2ePPNYeC8IyRBSVDmhgQc6j?=
 =?us-ascii?Q?hpL0ke/SU0h3K3wxJ12ISYTnYlwYdAOz3zaSP7fSL7BHyh9RCfj57PNA9+u6?=
 =?us-ascii?Q?sba/U9Ibv5Db/YerPdDydmmQ6bfQ6s+8unMOIP1qjXQZI2WpWkRcOKSssIPs?=
 =?us-ascii?Q?qnnm/+JiqMoEypbjDeFmUaw3mL39dsNuBRW884WRc0yGwAij4FquFYoBiMy9?=
 =?us-ascii?Q?CUWWhXiURaOtOdKGwmM5Nc7ihZ3ReMcZCsqPfnLQ3z7HAPClWq14H+Nl+MMp?=
 =?us-ascii?Q?YaMt9mxVTVOgCQAeX22zuCeSla8XH5aVFO2WHMIkvrZMphwYfjq5Qzx7HALG?=
 =?us-ascii?Q?8ECQfvPhJtRmvkwIJdcQynghOtzAW5h28wnIKGvC00SjlBiVkFwXpSW5roVj?=
 =?us-ascii?Q?ABnM1QqxlPduUl34m+OepVf7SUByGqdWTbGBhPNvW8z04oWoROv0mMjwuyiZ?=
 =?us-ascii?Q?zVD32/CMxA6j4TyeP2hWaHAE0LEqFH4mfQBzfG4gHXeEXyIwKRMDbMN7NWPX?=
 =?us-ascii?Q?DDd81FWtKNfLzH9ni0J1u+Ydqbmct1/fxD1dw4cGMi9dE1nBJsnkPY8MChj4?=
 =?us-ascii?Q?UaqW6vkzcmQfsshdxZwAoCWnrOW1mYEmnOzbneE7fitm1U52vju39jPQ6DJa?=
 =?us-ascii?Q?GIx1pUX12wHYgrq+aPHiXmDeO3QPxr91C3EJv8WHsUf7QYE2bVGVOKXBvSn4?=
 =?us-ascii?Q?0hNpAa5NDLYfUF0Vpeqqtwgydl1aKhcjG1UFzUmah1Eib11J1sBu8+ch1N2o?=
 =?us-ascii?Q?wW8YjTRLfr3XR7C3AlP8gGbWGYrMUIVu/AQmGLrwVtsk6YOlSuklm53TMvE/?=
 =?us-ascii?Q?4gn12j6XameiBAcASF2xxofy4QEpT3O6H7hAqp74QBABys4qmoYuZknLJlB7?=
 =?us-ascii?Q?UnqOH5LZgJU+tRn8dhB3iwl5/Bj181HknDDVRsBsvgqNgHOX07J18DaJanMy?=
 =?us-ascii?Q?LeQxLqzoPaFu7cnD6rDaY8DnBLcSe6xkjToiLVXdwENKis3c5VGoP5CL4FqT?=
 =?us-ascii?Q?/4OYLpz+7kXGud5nfWbVSJbXixyd20TdyPqh88RSd3dLIZsWAm7/J8W2L0yK?=
 =?us-ascii?Q?u76Y4wt4rTQZ5TIcOdcu51v06ksnt7uGYxqwMm7uJibjq/N28+U6r0DcxQFx?=
 =?us-ascii?Q?vtWP0Gc4E0UB3jhvsdEC4Nw9yWetZNgq1bj9JJ7DB/pSMuYlMFyg94ajgvDk?=
 =?us-ascii?Q?Ei0TvHJOOBTb2weOwpv3rmhSc7BREtWlXDBOS66s?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e599bd-8f43-4e4f-c471-08dbdb82df27
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 09:05:33.9190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lcVe3p0RFp/D82GUcXHkON5tws3EwFdTu5QpIjswbWg53cifjFZPv/uXZMG621aX/qJvXYvh2T3PPvPNT/ieSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8216
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[AMD Official Use Only - General]

Hi meng Li,


> -----Original Message-----
> From: Meng, Li (Jassmine) <Li.Meng@amd.com>
> Sent: Monday, October 30, 2023 2:34 PM
> To: Rafael J . Wysocki <rafael.j.wysocki@intel.com>; Huang, Ray
> <Ray.Huang@amd.com>
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; x86@kernel.or=
g;
> linux-acpi@vger.kernel.org; Shuah Khan <skhan@linuxfoundation.org>; linux=
-
> kselftest@vger.kernel.org; Fontenot, Nathan <Nathan.Fontenot@amd.com>;
> Sharma, Deepak <Deepak.Sharma@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Du,
> Xiaojian <Xiaojian.Du@amd.com>; Viresh Kumar <viresh.kumar@linaro.org>;
> Borislav Petkov <bp@alien8.de>; Oleksandr Natalenko
> <oleksandr@natalenko.name>; Meng, Li (Jassmine) <Li.Meng@amd.com>;
> Karny, Wyes <Wyes.Karny@amd.com>
> Subject: [PATCH V10 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred
> core supporting.
>
> amd-pstate driver utilizes the functions and data structures provided by =
the
> ITMT architecture to enable the scheduler to favor scheduling on cores wh=
ich
> can be get a higher frequency with lower voltage. We call it amd-pstate
> preferrred core.
>
> Here sched_set_itmt_core_prio() is called to set priorities and
> sched_set_itmt_support() is called to enable ITMT feature.
> amd-pstate driver uses the highest performance value to indicate the prio=
rity
> of CPU. The higher value has a higher priority.
>
> The initial core rankings are set up by amd-pstate when the system boots.
>
> Add a variable hw_prefcore in cpudata structure. It will check if the pro=
cessor
> and power firmware support preferred core feature.
>
> Add one new early parameter `disable` to allow user to disable the prefer=
red
> core.
>
> Only when hardware supports preferred core and user set `enabled` in earl=
y
> parameter, amd pstate driver supports preferred core featue.
>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Co-developed-by: Perry Yuan <Perry.Yuan@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 141
> +++++++++++++++++++++++++++++++----
>  include/linux/amd-pstate.h   |   4 +
>  2 files changed, 129 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9a1e194d5cf8..2033e5e70017 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -37,6 +37,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/static_call.h>
>  #include <linux/amd-pstate.h>
> +#include <linux/topology.h>
>
>  #include <acpi/processor.h>
>  #include <acpi/cppc_acpi.h>
> @@ -49,6 +50,7 @@
>
>  #define AMD_PSTATE_TRANSITION_LATENCY        20000
>  #define AMD_PSTATE_TRANSITION_DELAY  1000
> +#define AMD_PSTATE_PREFCORE_THRESHOLD        166
>
>  /*
>   * TODO: We need more time to fine tune processors with shared memory
> solution @@ -64,6 +66,7 @@ static struct cpufreq_driver amd_pstate_driver=
;
> static struct cpufreq_driver amd_pstate_epp_driver;  static int cppc_stat=
e =3D
> AMD_PSTATE_UNDEFINED;  static bool cppc_enabled;
> +static bool amd_pstate_prefcore =3D true;
>
>  /*
>   * AMD Energy Preference Performance (EPP) @@ -290,23 +293,21 @@
> static inline int amd_pstate_enable(bool enable)  static int
> pstate_init_perf(struct amd_cpudata *cpudata)  {
>       u64 cap1;
> -     u32 highest_perf;
>
>       int ret =3D rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>                                    &cap1);
>       if (ret)
>               return ret;
>
> -     /*
> -      * TODO: Introduce AMD specific power feature.
> -      *
> -      * CPPC entry doesn't indicate the highest performance in some ASIC=
s.
> +     /* For platforms that do not support the preferred core feature, th=
e
> +      * highest_pef may be configured with 166 or 255, to avoid max
> frequency
> +      * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1)
> value as
> +      * the default max perf.
>        */
> -     highest_perf =3D amd_get_highest_perf();
> -     if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
> -             highest_perf =3D AMD_CPPC_HIGHEST_PERF(cap1);
> -
> -     WRITE_ONCE(cpudata->highest_perf, highest_perf);
> +     if (cpudata->hw_prefcore)
> +             WRITE_ONCE(cpudata->highest_perf,
> AMD_PSTATE_PREFCORE_THRESHOLD);
> +     else
> +             WRITE_ONCE(cpudata->highest_perf,
> AMD_CPPC_HIGHEST_PERF(cap1));
>
>       WRITE_ONCE(cpudata->nominal_perf,
> AMD_CPPC_NOMINAL_PERF(cap1));
>       WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> AMD_CPPC_LOWNONLIN_PERF(cap1)); @@ -318,17 +319,15 @@ static int
> pstate_init_perf(struct amd_cpudata *cpudata)  static int
> cppc_init_perf(struct amd_cpudata *cpudata)  {
>       struct cppc_perf_caps cppc_perf;
> -     u32 highest_perf;
>
>       int ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>       if (ret)
>               return ret;
>
> -     highest_perf =3D amd_get_highest_perf();
> -     if (highest_perf > cppc_perf.highest_perf)
> -             highest_perf =3D cppc_perf.highest_perf;
> -
> -     WRITE_ONCE(cpudata->highest_perf, highest_perf);
> +     if (cpudata->hw_prefcore)
> +             WRITE_ONCE(cpudata->highest_perf,
> AMD_PSTATE_PREFCORE_THRESHOLD);
> +     else
> +             WRITE_ONCE(cpudata->highest_perf,
> cppc_perf.highest_perf);
>
>       WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
>       WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> @@ -676,6 +675,80 @@ static void amd_perf_ctl_reset(unsigned int cpu)
>       wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);  }
>
> +/*
> + * Set amd-pstate preferred core enable can't be done directly from
> +cpufreq callbacks
> + * due to locking, so queue the work for later.
> + */
> +static void amd_pstste_sched_prefcore_workfn(struct work_struct *work)
> +{
> +     sched_set_itmt_support();
> +}
> +static DECLARE_WORK(sched_prefcore_work,
> +amd_pstste_sched_prefcore_workfn);
> +
> +/*
> + * Get the highest performance register value.
> + * @cpu: CPU from which to get highest performance.
> + * @highest_perf: Return address.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +static int amd_pstate_get_highest_perf(int cpu, u32 *highest_perf) {
> +     int ret;
> +
> +     if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +             u64 cap1;
> +
> +             ret =3D rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1,
> &cap1);
> +             if (ret)
> +                     return ret;
> +             WRITE_ONCE(*highest_perf,
> AMD_CPPC_HIGHEST_PERF(cap1));
> +     } else {
> +             u64 cppc_highest_perf;
> +
> +             ret =3D cppc_get_highest_perf(cpu, &cppc_highest_perf);
> +             if (ret)
> +                     return ret;
> +             WRITE_ONCE(*highest_perf, cppc_highest_perf);
> +     }
> +
> +     return (ret);
> +}
> +
> +#define CPPC_MAX_PERF        U8_MAX
> +
> +static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata) {
> +     int ret, prio;
> +     u32 highest_perf;
> +
> +     ret =3D amd_pstate_get_highest_perf(cpudata->cpu, &highest_perf);
> +     if (ret)
> +             return;
> +
> +     cpudata->hw_prefcore =3D true;
> +     /* check if CPPC preferred core feature is enabled*/
> +     if (highest_perf < CPPC_MAX_PERF)
> +             prio =3D (int)highest_perf;
> +     else {
> +             pr_debug("AMD CPPC preferred core is unsupported!\n");
> +             cpudata->hw_prefcore =3D false;
> +             return;
> +     }
> +
> +     if (!amd_pstate_prefcore)
> +             return;

Move the feature state check to earlier before you call amd_pstate_get_high=
est_perf().
If the feature is not enabled, you have no need to read highest perf.


> +
> +     /*
> +      * The priorities can be set regardless of whether or not
> +      * sched_set_itmt_support(true) has been called and it is valid to
> +      * update them at any time after it has been called.
> +      */
> +     sched_set_itmt_core_prio(prio, cpudata->cpu);
> +
> +     schedule_work(&sched_prefcore_work);
> +}
> +
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)  {
>       int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -697,6 +770,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy
> *policy)
>
>       cpudata->cpu =3D policy->cpu;
>
> +     amd_pstate_init_prefcore(cpudata);
> +
>       ret =3D amd_pstate_init_perf(cpudata);
>       if (ret)
>               goto free_cpudata1;
> @@ -845,6 +920,17 @@ static ssize_t show_amd_pstate_highest_perf(struct
> cpufreq_policy *policy,
>       return sysfs_emit(buf, "%u\n", perf);
>  }
>
> +static ssize_t show_amd_pstate_hw_prefcore(struct cpufreq_policy *policy=
,
> +                                        char *buf)
> +{
> +     bool hw_prefcore;
> +     struct amd_cpudata *cpudata =3D policy->driver_data;
> +
> +     hw_prefcore =3D READ_ONCE(cpudata->hw_prefcore);
> +
> +     return sysfs_emit(buf, "%s\n", hw_prefcore ? "supported" :
> +"unsupported"); }

Replace the string with str_enabled_disabled() function that is defined as =
below.

include/linux/string_helpers.h

static inline const char *str_enabled_disabled(bool v)
{
        return v ? "enabled" : "disabled";
}

Perry.

> +
>  static ssize_t show_energy_performance_available_preferences(
>                               struct cpufreq_policy *policy, char *buf)
> { @@ -1037,18 +1123,27 @@ static ssize_t status_store(struct device *a,
> struct device_attribute *b,
>       return ret < 0 ? ret : count;
>  }
>
> +static ssize_t prefcore_show(struct device *dev,
> +                          struct device_attribute *attr, char *buf) {
> +     return sysfs_emit(buf, "%s\n", amd_pstate_prefcore ? "enabled" :
> +"disabled"); }

Replace the string with str_enabled_disabled() function that is defined as =
below.

include/linux/string_helpers.h


> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>
>  cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> +cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
>  cpufreq_freq_attr_rw(energy_performance_preference);
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
>  static DEVICE_ATTR_RW(status);
> +static DEVICE_ATTR_RO(prefcore);
>
>  static struct freq_attr *amd_pstate_attr[] =3D {
>       &amd_pstate_max_freq,
>       &amd_pstate_lowest_nonlinear_freq,
>       &amd_pstate_highest_perf,
> +     &amd_pstate_hw_prefcore,
>       NULL,
>  };
>
> @@ -1056,6 +1151,7 @@ static struct freq_attr *amd_pstate_epp_attr[] =3D =
{
>       &amd_pstate_max_freq,
>       &amd_pstate_lowest_nonlinear_freq,
>       &amd_pstate_highest_perf,
> +     &amd_pstate_hw_prefcore,
>       &energy_performance_preference,
>       &energy_performance_available_preferences,
>       NULL,
> @@ -1063,6 +1159,7 @@ static struct freq_attr *amd_pstate_epp_attr[] =3D =
{
>
>  static struct attribute *pstate_global_attributes[] =3D {
>       &dev_attr_status.attr,
> +     &dev_attr_prefcore.attr,
>       NULL
>  };
>
> @@ -1114,6 +1211,8 @@ static int amd_pstate_epp_cpu_init(struct
> cpufreq_policy *policy)
>       cpudata->cpu =3D policy->cpu;
>       cpudata->epp_policy =3D 0;
>
> +     amd_pstate_init_prefcore(cpudata);
> +
>       ret =3D amd_pstate_init_perf(cpudata);
>       if (ret)
>               goto free_cpudata1;
> @@ -1527,7 +1626,17 @@ static int __init amd_pstate_param(char *str)
>
>       return amd_pstate_set_driver(mode_idx);  }
> +
> +static int __init amd_prefcore_param(char *str) {
> +     if (!strcmp(str, "disable"))
> +             amd_pstate_prefcore =3D false;
> +
> +     return 0;
> +}
> +
>  early_param("amd_pstate", amd_pstate_param);
> +early_param("amd_prefcore", amd_prefcore_param);
>
>  MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
> MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver"); diff --git
> a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h index
> 446394f84606..87e140e9e6db 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -52,6 +52,9 @@ struct amd_aperf_mperf {
>   * @prev: Last Aperf/Mperf/tsc count value read from register
>   * @freq: current cpu frequency value
>   * @boost_supported: check whether the Processor or SBIOS supports boost
> mode
> + * @hw_prefcore: check whether HW supports preferred core featue.
> + *             Only when hw_prefcore and early prefcore param are true,
> + *             AMD P-State driver supports preferred core featue.
>   * @epp_policy: Last saved policy used to set energy-performance prefere=
nce
>   * @epp_cached: Cached CPPC energy-performance preference value
>   * @policy: Cpufreq policy value
> @@ -81,6 +84,7 @@ struct amd_cpudata {
>
>       u64     freq;
>       bool    boost_supported;
> +     bool    hw_prefcore;
>
>       /* EPP feature related attributes*/
>       s16     epp_policy;
> --
> 2.34.1

