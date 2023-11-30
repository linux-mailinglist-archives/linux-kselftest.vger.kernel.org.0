Return-Path: <linux-kselftest+bounces-877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC87A7FE8CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 06:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E98B210D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 05:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5764182C7;
	Thu, 30 Nov 2023 05:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RIJg4P/+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B9ED5C;
	Wed, 29 Nov 2023 21:49:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGMCLW+LrpC2HtACN+joMO1tWySEfYxAKvjI/98ix/HBAL2LC1ZDpHHHkrYl9KvKIJUiOmvONEP5WY6i6peAoxK9Or/mAoEekNdDADtJicbblNa41bcrz0wT1K1UkzJCsg1XCDWRyjOOhqpLwN2VrvWYQ0C2IuXdDfJkLmGi8LWtiNW5dVMIYSGaEp5cBUm/S2QIRKWmhzRKda4G5bSrRXh71NFvNqn+54B3epfkDJo2ZLGDNvBkCp5KVmqpFgABeop/OxW0CEPsiEfLvKKtpIh72xX3ajTZFqZ5GnfWqE1fqiJeFJeHBut7kVjl7gXBavechsd7NxTLiwGAEOaSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iZS0KQDvqoWZGtkGKaqQrfOAW5QkAvIo4BIR0FXjDQ=;
 b=HvJb/MFKFXCpto7UQNmV5c30sffzZh+k6gFagnOHHZxXEFiQinPlR8CS3PN9+E5X+/1xOu/VV8tNyAJmwSy3eY5OiXuR0xuxqRpIRxK2pQhRrmQ12xEiPeXJ6cJeD6FSIjtje7Hz+AICezdAfw2seQPbgXsQGYmWw9QT0jHZwKfnJd6isvCEOCa2eQxt41vhraJUsMrB12JKrbc4oGlByIbecE8+1VaMqE/dnAp5xsVSFKQm+Ml1SHWZYrGOKBDbEppf/a753RvzF2CfN/blib22iTxpnrLZTCtdIIDsim3D+lNfMC9Viqv+dlvMmLDNL645d8rhNQpVRpywX+GXrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iZS0KQDvqoWZGtkGKaqQrfOAW5QkAvIo4BIR0FXjDQ=;
 b=RIJg4P/+KwdKXTbXfynxXuU7HSugR2o8f17bI5MfPUs6eELq759JqZaUHcyAwY3H0KCxlrAurCMPcIXw8pLaWiCruSHdQzxJjqLUkT1Ni6yyrosEcPR1Ip86Ej8rXpIX+RlhD4+SNLa5mjojdBsf+LXzoXqFta37bK5OoUkoEYQ=
Received: from CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 05:49:12 +0000
Received: from CH3PR12MB8657.namprd12.prod.outlook.com
 ([fe80::466c:b6a0:f281:1e99]) by CH3PR12MB8657.namprd12.prod.outlook.com
 ([fe80::466c:b6a0:f281:1e99%7]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 05:49:12 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Meng, Li (Jassmine)" <Li.Meng@amd.com>, "Rafael J . Wysocki"
	<rafael.j.wysocki@intel.com>, "Huang, Ray" <Ray.Huang@amd.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>, "Sharma, Deepak"
	<Deepak.Sharma@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, Viresh Kumar
	<viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, Oleksandr
 Natalenko <oleksandr@natalenko.name>, "Karny, Wyes" <Wyes.Karny@amd.com>
Subject: RE: [PATCH V11 5/7] cpufreq: amd-pstate: Update amd-pstate preferred
 core ranking dynamically
Thread-Topic: [PATCH V11 5/7] cpufreq: amd-pstate: Update amd-pstate preferred
 core ranking dynamically
Thread-Index: AQHaIpEKjvWtP+SoH0ina49wOQKAGLCSXF8g
Date: Thu, 30 Nov 2023 05:49:11 +0000
Message-ID:
 <CH3PR12MB865722889AB91EF5CFDC11F29C82A@CH3PR12MB8657.namprd12.prod.outlook.com>
References: <20231129065437.290183-1-li.meng@amd.com>
 <20231129065437.290183-6-li.meng@amd.com>
In-Reply-To: <20231129065437.290183-6-li.meng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=154f5ba1-2df4-40ec-bacc-07b461fede1d;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-30T05:47:49Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8657:EE_|SA1PR12MB6799:EE_
x-ms-office365-filtering-correlation-id: 27108e2b-d567-4dd2-ae70-08dbf1681417
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Wsiml3HUDsDvck93QZx+MhvE70AlbJgUBz+SG4m2olIm8aeFSqnv2YoAJ7GAlILvtMLRhqmJGEArSkzCALUqV7yHF8zhTajEBpeTRVnU3YX8P9j1RepyZzQTf06U37G3ZwNOXIVdKBO0owczrGeqPEjepFlvTscPTscm5zrlxhzAvmjT+xmywevJJ2gpfXfJzFdbM+9i9o4UdYrCIt5ybfsOVAuj+lDelw45mVu0VZqLKeus/3sFG/htciH7/ZRGAZkH0Xj90OjlVzofWs63WDxr4N/g21Iz6717fIgEPMHMYQ3rRTU8LhLy/myWK8L7UUglupyMoC6rGnJ9+RAhOfAlP+a2PWfJkXEC2BDw8SppqCHqq66KAMYF2UWkXdoz0XTQS0GmGvmBbb4MNEq365UHk61QveaQE5/rtTUkhB1gVSalEbQyPsF3NQNEMleUkI2p8yXJSEfkes2ehAc345uhYAPgAAlAvVYY/QuahTsuCv0otnbvUu2R08TDrSsl9qzwaLoO2yi9zY/W+X6O6oX1/jpwnWytbT8UV+pF3sVhkdwrqhZUJ+T5MOSOt8fAw53Do89xz0tzYyq9E6umQwlWO1IKIGlGAM14Q642Lzp+zPW6kyZ4wNJju8uGf2qXSLmRR2mE4r2px9jvYi7BP990LN4Ypix7DCPWJPt4z4o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(9686003)(122000001)(64756008)(8936002)(38100700002)(478600001)(8676002)(7696005)(4326008)(41300700001)(110136005)(66556008)(66946007)(76116006)(6636002)(54906003)(316002)(66446008)(26005)(66476007)(86362001)(6506007)(53546011)(71200400001)(38070700009)(52536014)(202311291699003)(83380400001)(33656002)(2906002)(55016003)(15650500001)(5660300002)(66899024)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bOLPGq1V6qJCcgX0fubkRW0F5RbGcVrhwRpRmEagDH7F188FryHI2MCNluFP?=
 =?us-ascii?Q?VCbeVxMI6KfH+sg9v4UUcZaMQWlvCO1zYINpOZmoBFgVn/j9d8JlriiHTD5y?=
 =?us-ascii?Q?m0DKc9N2mwjapmgYhk6asOtpvQ+pDaBTdkmU5wln96La3ckYWuhnAU97IcOu?=
 =?us-ascii?Q?aXlx9NtJZlHtlMKfyfUeryaj21PL3NXMtn1tJNpfCvwcAdSBNtTR69/XWt6k?=
 =?us-ascii?Q?SWoj1kvr3V1KCJ3EUkD1PTpFuZ1TCGtJp3X2gcaAa1nHWyCDPFagM7LBKam4?=
 =?us-ascii?Q?ZmFyMppfVIaNgl3YSQfzIK3HCxhuIEDUhsmFUN2/TZlFqYpwLj9rkuoGinxc?=
 =?us-ascii?Q?PqUg06wuSP27dqjlrPJFChUxwODIkb64eeQMC/i2mzCWdcMPDjatDgMdUbKf?=
 =?us-ascii?Q?TRc7/QDtdrK74OiOHjTO1lulMNEoqxGRdIRpbM+D2ykxUkdR7kQiI3T/IAny?=
 =?us-ascii?Q?kHLJ6wLbmvld/RwW0eHAButCtmth0/36gbyIdf+5RzvXMsYiQbUZpRpq+sOk?=
 =?us-ascii?Q?TBjKEok3cO7PY7lzxnbIMY57HL+5uzSGN7qF8hFEpvXrtqSPzkGQ83OBZE87?=
 =?us-ascii?Q?mWpczFq3S0CSKsslvltVoI5b08z+DjCnQttpY4pbb7RMjDl6Odcgbt9Y+Lb5?=
 =?us-ascii?Q?QsyuQ8trlF5+BIqUbJbfjxVZrEXyH0GfFCUhHuRryG9y6+WrV9oLjrG5tlqq?=
 =?us-ascii?Q?csuDQFXFPA2237UBNp5na61QdWrVmx4iqXsr08neBHRLzk8J3Wq75Smn36sp?=
 =?us-ascii?Q?Pbu3I2NwQdYVFsuNXmF7YFMz7ElcwPQnFDrTvNdKvIyq8U5QoVgnJwzEFs9A?=
 =?us-ascii?Q?Q8FSGc6YbHyH0m5mbGoHzrisJXMsWj7zl9BtwHI2XgppFyYzAIPu5qqmNiah?=
 =?us-ascii?Q?/hYKXZHiDy451CdlFL7yyJa1XW71ywCljUioeX9aOCETkOcwx1z8F1+hGKCM?=
 =?us-ascii?Q?oOYVo2OpeGJVEVW+8Er4r8pWkR0tXAnkrRywjwtffGThA4UjEzrHjckhZgDc?=
 =?us-ascii?Q?14QZay1JSOSpMALjSEjeLht+nf8wjEykekVlDLzOm5t5qh01tMybyiD+Lygu?=
 =?us-ascii?Q?WbeInyA6AAYumOrxpfiMbiTTVzU/7ZQ7otXmq11J9UCQA5eY7YMS9iYrNV3K?=
 =?us-ascii?Q?5IfLv6G2NhkS4HOXkIdqFXg+2R17byfCUAg13HHx15i5Nd8bj2OdEVgiatOR?=
 =?us-ascii?Q?oMh0AZ9E8HK+GAmbs87KKWmo1krVaQG5+RgdQi+XdP1pkYkUI/GerQU11ff1?=
 =?us-ascii?Q?ho3Y/tIbFMYJ91bvEHwM26wJx9Pjg+Edfx6Eu6Ts4TMSwo2if3i+CBpSdW0s?=
 =?us-ascii?Q?yV1NDyAN1dZiI5V6bjdbdLFK5CjNY60Fu46nja5/5UuuL86ZpgqfJM5x+Rec?=
 =?us-ascii?Q?bSFr1m0dCQevbz93IUae6QzgT6RICXw11U9eMDO5I43IC+1vdPhv/Wu2Kw6V?=
 =?us-ascii?Q?pICCU1VHxPrulj3VaDU6Dy6ocdzukD19INMnbAzJkj7WmbzOHUYMhUGJ/ILZ?=
 =?us-ascii?Q?u4BN0DEMiqRfSluT2eUzblcoXY8buAfdYfyYYlu/ChrSZ2jjoXGuu5Uw4a6V?=
 =?us-ascii?Q?8Ju7o2+yZ0UNMez3rFo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27108e2b-d567-4dd2-ae70-08dbf1681417
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 05:49:11.8641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H216s7jp6TWmw6XSri+/OwF1tdpnx3+nWpU6xCZAETyfbxPpev9Shzv4faODAiALhRgN8JDpTcxHzpBc7ml69Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799

[AMD Official Use Only - General]

> -----Original Message-----
> From: Meng, Li (Jassmine) <Li.Meng@amd.com>
> Sent: Wednesday, November 29, 2023 2:55 PM
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
> Subject: [PATCH V11 5/7] cpufreq: amd-pstate: Update amd-pstate preferred
> core ranking dynamically
>
> Preferred core rankings can be changed dynamically by the platform based =
on
> the workload and platform conditions and accounting for thermals and agin=
g.
> When this occurs, cpu priority need to be set.
>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 46
> ++++++++++++++++++++++++++++++++++++
>  include/linux/amd-pstate.h   |  6 +++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 74dcf63d75f9..88df6510dcc0 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -312,6 +312,7 @@ static int pstate_init_perf(struct amd_cpudata
> *cpudata)
>       WRITE_ONCE(cpudata->nominal_perf,
> AMD_CPPC_NOMINAL_PERF(cap1));
>       WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> AMD_CPPC_LOWNONLIN_PERF(cap1));
>       WRITE_ONCE(cpudata->lowest_perf,
> AMD_CPPC_LOWEST_PERF(cap1));
> +     WRITE_ONCE(cpudata->prefcore_ranking,
> AMD_CPPC_HIGHEST_PERF(cap1));
>
>       return 0;
>  }
> @@ -333,6 +334,7 @@ static int cppc_init_perf(struct amd_cpudata
> *cpudata)
>       WRITE_ONCE(cpudata->lowest_nonlinear_perf,
>                  cppc_perf.lowest_nonlinear_perf);
>       WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
> +     WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
>
>       if (cppc_state =3D=3D AMD_PSTATE_ACTIVE)
>               return 0;
> @@ -749,6 +751,34 @@ static void amd_pstate_init_prefcore(struct
> amd_cpudata *cpudata)
>       schedule_work(&sched_prefcore_work);
>  }
>
> +static void amd_pstate_update_highest_perf(unsigned int cpu) {
> +     struct cpufreq_policy *policy;
> +     struct amd_cpudata *cpudata;
> +     u32 prev_high =3D 0, cur_high =3D 0;
> +     int ret;
> +
> +     if ((!amd_pstate_prefcore) || (!cpudata->hw_prefcore))
> +             return;
> +
> +     ret =3D amd_pstate_get_highest_perf(cpu, &cur_high);
> +     if (ret)
> +             return;
> +
> +     policy =3D cpufreq_cpu_get(cpu);
> +     cpudata =3D policy->driver_data;
> +     prev_high =3D READ_ONCE(cpudata->prefcore_ranking);
> +
> +     if (prev_high !=3D cur_high) {
> +             WRITE_ONCE(cpudata->prefcore_ranking, cur_high);
> +
> +             if (cur_high < CPPC_MAX_PERF)
> +                     sched_set_itmt_core_prio((int)cur_high, cpu);
> +     }
> +
> +     cpufreq_cpu_put(policy);
> +}
> +
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)  {
>       int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -920,6 +950,17 @@ static ssize_t show_amd_pstate_highest_perf(struct
> cpufreq_policy *policy,
>       return sysfs_emit(buf, "%u\n", perf);
>  }
>
> +static ssize_t show_amd_pstate_prefcore_ranking(struct cpufreq_policy
> *policy,
> +                                             char *buf)
> +{
> +     u32 perf;
> +     struct amd_cpudata *cpudata =3D policy->driver_data;
> +
> +     perf =3D READ_ONCE(cpudata->prefcore_ranking);
> +
> +     return sysfs_emit(buf, "%u\n", perf);
> +}
> +
>  static ssize_t show_amd_pstate_hw_prefcore(struct cpufreq_policy *policy=
,
>                                          char *buf)
>  {
> @@ -1133,6 +1174,7 @@ cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>
>  cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> +cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
>  cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
>  cpufreq_freq_attr_rw(energy_performance_preference);
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
> @@ -1143,6 +1185,7 @@ static struct freq_attr *amd_pstate_attr[] =3D {
>       &amd_pstate_max_freq,
>       &amd_pstate_lowest_nonlinear_freq,
>       &amd_pstate_highest_perf,
> +     &amd_pstate_prefcore_ranking,
>       &amd_pstate_hw_prefcore,
>       NULL,
>  };
> @@ -1151,6 +1194,7 @@ static struct freq_attr *amd_pstate_epp_attr[] =3D =
{
>       &amd_pstate_max_freq,
>       &amd_pstate_lowest_nonlinear_freq,
>       &amd_pstate_highest_perf,
> +     &amd_pstate_prefcore_ranking,
>       &amd_pstate_hw_prefcore,
>       &energy_performance_preference,
>       &energy_performance_available_preferences,
> @@ -1491,6 +1535,7 @@ static struct cpufreq_driver amd_pstate_driver =3D =
{
>       .suspend        =3D amd_pstate_cpu_suspend,
>       .resume         =3D amd_pstate_cpu_resume,
>       .set_boost      =3D amd_pstate_set_boost,
> +     .update_highest_perf    =3D amd_pstate_update_highest_perf,
>       .name           =3D "amd-pstate",
>       .attr           =3D amd_pstate_attr,
>  };
> @@ -1505,6 +1550,7 @@ static struct cpufreq_driver
> amd_pstate_epp_driver =3D {
>       .online         =3D amd_pstate_epp_cpu_online,
>       .suspend        =3D amd_pstate_epp_suspend,
>       .resume         =3D amd_pstate_epp_resume,
> +     .update_highest_perf    =3D amd_pstate_update_highest_perf,
>       .name           =3D "amd-pstate-epp",
>       .attr           =3D amd_pstate_epp_attr,
>  };
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h inde=
x
> 87e140e9e6db..426822612373 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -39,11 +39,16 @@ struct amd_aperf_mperf {
>   * @cppc_req_cached: cached performance request hints
>   * @highest_perf: the maximum performance an individual processor may
> reach,
>   *             assuming ideal conditions
> + *             For platforms that do not support the preferred core feat=
ure,
> the
> + *             highest_pef may be configured with 166 or 255, to avoid
> max frequency
> + *             calculated wrongly. we take the fixed value as the
> highest_perf.
>   * @nominal_perf: the maximum sustained performance level of the
> processor,
>   *             assuming ideal operating conditions
>   * @lowest_nonlinear_perf: the lowest performance level at which nonline=
ar
> power
>   *                      savings are achieved
>   * @lowest_perf: the absolute lowest performance level of the processor
> + * @prefcore_ranking: the preferred core ranking, the higher value indic=
ates a
> higher
> + *             priority.
>   * @max_freq: the frequency that mapped to highest_perf
>   * @min_freq: the frequency that mapped to lowest_perf
>   * @nominal_freq: the frequency that mapped to nominal_perf @@ -73,6
> +78,7 @@ struct amd_cpudata {
>       u32     nominal_perf;
>       u32     lowest_nonlinear_perf;
>       u32     lowest_perf;
> +     u32     prefcore_ranking;
>
>       u32     max_freq;
>       u32     min_freq;
> --
> 2.34.1

Reviewed-by: Perry Yuan <perry.yuan@amd.com>

