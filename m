Return-Path: <linux-kselftest+bounces-881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E11B27FE8EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 07:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D26E282225
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 06:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B681C69D;
	Thu, 30 Nov 2023 06:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bjJuk8PM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9BB10C6;
	Wed, 29 Nov 2023 22:02:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XS5ZX5fj8SfgyvXJhzhXPSTIm/WAfk+VeXaPxPCN51ltU5/N7H3sCjPPcfFdgVV+9HblHg1t+tc0dz4sgHoFfiXOBcc5HzDRK4kLGmFmtnyUca2LFUGAEaseTiXW2wJo5uvd7FtBUBhyKbtHS4K5ao3lxPu1sUZT4Xjfea0vXeXI43+dmWvfKMTjpZfRbRBySEhcTqBrI7kM83UlrirfvYMhXdo9LiEn3iDRYlvNpsI+J/as88jXlPAkV9xRZ9/ScVPCDFDQ+K6BqhuTfwigY6rLJ+hxv7PufPwnFJTRPrs8yoUh3gCaMwdO4dyDQBPZSzXI+widORuX+gic7c8zSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiZnl92CuJeA8yDpVND7u8RuT1YNEEh5g/CP9KOv/+M=;
 b=frKwkb7ZCwJlX1mk4/baBwbnvdBQxhJehgsdQsLbVHaZT47ZQOfpJuHAlDgxHhUpO67Kvkwzym3czZAuBgaf90XWP8mGXjKxdO6aceGIkY+8QYlJeb2gzXq5MWje199t5oi6Er3fhIWcNgSbajtgnJu4ov0yKWkdv/StEs2B32rRI2pDNfH8DAXMX7Hx8HWPp+06TG4toVFEWEdO2aB4K6RiE1bC+LndftprMJdWv86OycS1omHTmKuIYoBhnU/UmkpJF+N+QQEN6+gICsfViL9r1P9K3QVfSNpzWBgMGrxoPZ5WHZ0JWwcGUZI5m1GaltwtgIOiL9o7er4rkfWoRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiZnl92CuJeA8yDpVND7u8RuT1YNEEh5g/CP9KOv/+M=;
 b=bjJuk8PM5uIBGQdPfo7k+IDTXgDC+4R+zb+yRQPSaeAH8zNJeR80C22KVEiN0FqEvM7DCo0bQVsuMcxOxGEaiqAgAcYEpIfeMo5a2VF6IJLMK0AYwzjgNPnOAf3jKHtyXUbpdTr2Be11kKmTjeNw4doBEyH4LLnnC80P3OhIAVs=
Received: from CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 06:02:02 +0000
Received: from CH3PR12MB8657.namprd12.prod.outlook.com
 ([fe80::466c:b6a0:f281:1e99]) by CH3PR12MB8657.namprd12.prod.outlook.com
 ([fe80::466c:b6a0:f281:1e99%7]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 06:02:02 +0000
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
Subject: RE: [PATCH V11 2/7] acpi: cppc: Add get the highest performance cppc
 control
Thread-Topic: [PATCH V11 2/7] acpi: cppc: Add get the highest performance cppc
 control
Thread-Index: AQHaIpEDwshT/HW1jUODqpCpgiY11LCSYAfQ
Date: Thu, 30 Nov 2023 06:02:02 +0000
Message-ID:
 <CH3PR12MB8657EC39154AC660F88E9EEE9C82A@CH3PR12MB8657.namprd12.prod.outlook.com>
References: <20231129065437.290183-1-li.meng@amd.com>
 <20231129065437.290183-3-li.meng@amd.com>
In-Reply-To: <20231129065437.290183-3-li.meng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7920d43e-65b1-4866-895b-41c861e54290;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-30T06:00:55Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8657:EE_|SA1PR12MB6799:EE_
x-ms-office365-filtering-correlation-id: f9fd4e18-dad5-4ab9-da87-08dbf169df38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Tkqehdyua2W3xHiXqbqG/dl/DHpCHVaiLSgo4jW2WtWr2sFexU/1k7PVibk64SLZYkmiI2g3jBrr/LbV4RWssQIp6+eSY+XGpe5oBfwKxNXvy0eXUlAeb+TOPNL9Gy5WNGBDRAWDFUAYZRaTLtRhLO//ln3eIEy2pG4B36xpZCWe66/FhoEHygLaljXn1qWWJZSqX1jCQ1xnc7a/Qxoesm0WGVRpg2AvqP7iFP37Ha4I0YoBAPjP/CGwrrDLFodcQvCEEqF9OVRobE4nvWw8aYIbiZ5I6YNF1iAE8wBDBY0QFC1LkxFc1eIknrPdOmZAkS+opaKhHwO/BflJmtU4ei6VrggrWJSFWowF9ceWXe43IIkH0I03v4k1KYa8c2y2xIQIyeTJYmM5ANA6c4SNxmGcwf2Ap+vmaiTKMJyAE4TbJSDgpOMJ+bj9C5LBxW2oW7pxkLPKVK26sW0IP+8OCHsBoeDhVaoZKI+gJqprZzpJEypRKgzY58uMLkfqqX1zZC48gG1KVt0gOyeC4q16+bJPM+KRqJgmk1C4yLPidOo3XT+0cIdgr8/+wEU7ecrXdK5FyxF/Pnpp4O8aC85oX0GkiN8yOyUDQYf87HqEUy6h9iLsi0mZGldwc8odxOavqyO2D/v25/omSRclplpF+hG50RuO1L1I6GheUr+r1+U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(9686003)(122000001)(64756008)(8936002)(38100700002)(478600001)(8676002)(7696005)(4326008)(41300700001)(110136005)(66556008)(66946007)(76116006)(6636002)(54906003)(316002)(66446008)(26005)(66476007)(86362001)(6506007)(53546011)(71200400001)(966005)(38070700009)(52536014)(202311291699003)(83380400001)(33656002)(2906002)(55016003)(5660300002)(7416002)(15583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3dGd75Cg6LHGEH0Rtb4bxdV29JzbbmtMeRabQpA2oYSh0eCgQBSJLEHz6Fsl?=
 =?us-ascii?Q?GQ0WJyTuWsTeR+Qq2Y1cqvukX4PBI1BW2Sod3QpY+4lewAZQ4rmAKDBktH41?=
 =?us-ascii?Q?LTxd8TU/L527ZYMgsZE1Fb925oKZjiswEYOZsctMZuZtcZcY1VrwhEZyvR04?=
 =?us-ascii?Q?6Hp0eztX6BHjB735c0Vct6Oui/3sIXo71Hh2akRjA19ofElbuCnkbaVWIw50?=
 =?us-ascii?Q?vhJLgcvtd+aEqRkj8GRdukbHE4LOdZKCVJj22RaXzjCKGbV9YOHabhOb4U6a?=
 =?us-ascii?Q?xBHqA0g4BNPX6DlVCSq88kA8UlsbznAHqg+K3XYrT5Qs1ek+gZXbLSq98Nok?=
 =?us-ascii?Q?dxB+jSixKpeiuJTfc88KIKJ14Cs9Iu98Pg4xjEW3FtbhZQCuDRab4zI04pNR?=
 =?us-ascii?Q?kkUymeBc6GjOmgukYUmUQCQ9BguaSQZm07lbb6XcwbXXTzChGAMqeLlKhRW2?=
 =?us-ascii?Q?Pkbu3zOePWOZTwiodJ6EkG17G3Ocf4rV6CbsnHL0ktrdCArOm4PXeEbhG5S6?=
 =?us-ascii?Q?yekmmxrP8h4AkqhVmnc/dFkpiJsUMJ8dC63OfoGDJYV9xgWnEC48gxGebkwa?=
 =?us-ascii?Q?YNR+xDptVK9AE+hWzdduiYc0KelFae0pPbkrgK0OSnFGLMXmluM20I6lxER2?=
 =?us-ascii?Q?rCD/aCfzldVdGpDkt/FA8VjYuaUiH8wr3UsJf+zJ71nCwJahy8Lq9oEPJckB?=
 =?us-ascii?Q?XtUCGe2kMjbVyaiqwFKQgfyYF/ELEa5o4ebIbFSEnd1SGnLuFwIIJKRhIgd/?=
 =?us-ascii?Q?6jwnwZZILGuF4Z/m15400RR6O2W9ddMiYTUrVIF+JXu6WjTemJ9w5YrsrVjo?=
 =?us-ascii?Q?OPsgGYkkUK5Stu23wVUO8tqz65DBBns8zYkLavAlHq7X/IOdz2r3XqEQobvZ?=
 =?us-ascii?Q?91YA1NEgjnoWrIXn6eJgMqHORIAxGjO5Xeazwd5ozceqy8S9zaW96PxN+RR+?=
 =?us-ascii?Q?SFxmBE0cpxYOJp+FN9UVFStudFPIYAkd5EL6LEhfEe01kGw0jNISNpiKNxBh?=
 =?us-ascii?Q?DRWMw4VSdg83Q0oCiP7dzxMonOQwXILBC7r7w7PIxbHYqc0k62LSLqc6UE/l?=
 =?us-ascii?Q?E3Nksp49TD0fUzCgOOsZnt92Yp/1ajTogT6tPo/su4P03zjpIm6ErppTLPg3?=
 =?us-ascii?Q?Y6uCywpIj+J+TqEgLTAvWKoViCQfJ546RXeFiblFyAf5hbjQ7IE0LHCApwyF?=
 =?us-ascii?Q?PGrAGBPvGrWaF4I21bygJGnXYsKPnf1ti2gDi5gvmmyOnK9cfFygkMOYMlCw?=
 =?us-ascii?Q?+pb4exfnxF8zm1fwHuhAOHnW74BZJRfIaCTVQK2QV0cS/Wfm+ciKO8lGhPT5?=
 =?us-ascii?Q?1NGU94aGtm9JV3BmA6C44JOkDy6Q90f2mv76jDAwtznaDa14aQ1IZITnzmgr?=
 =?us-ascii?Q?LZubrtJrUv/snQ1tbZaA3o91j9cpXuuvYjxTHHL8NgaGST0yMMnvzgyTKNuB?=
 =?us-ascii?Q?NIbc/gN0Oyw2JqlUF3ysViXTmbtiz0ZgAZLD8tOu5fRHjFxpZlQkOX9/lwBv?=
 =?us-ascii?Q?D12xP/TTdrTSoxfJSR4FIg4aX2fXbSArWeo0ddID5Hz4UbaGE4XzAVmvhhCV?=
 =?us-ascii?Q?dtnlMJGRBGoOHeqkjSw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fd4e18-dad5-4ab9-da87-08dbf169df38
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 06:02:02.1586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edST3CEhAs2CM7KbbVeLMcfN6j6LoprCRuTN+kpPAucjxsYIUwMPDFuBja2JNWtMsvpkHsV1oSZ6jEur41MlBw==
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
> <Mario.Limonciello@amd.com>; Huang, Shimmer <Shimmer.Huang@amd.com>;
> Yuan, Perry <Perry.Yuan@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> Viresh Kumar <viresh.kumar@linaro.org>; Borislav Petkov <bp@alien8.de>;
> Oleksandr Natalenko <oleksandr@natalenko.name>; Meng, Li (Jassmine)
> <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>
> Subject: [PATCH V11 2/7] acpi: cppc: Add get the highest performance cppc
> control
>
> Add support for getting the highest performance to the generic CPPC drive=
r. This
> enables downstream drivers such as amd-pstate to discover and use these
> values.
>
> Please refer to the ACPI_Spec for details on continuous performance contr=
ol of
> CPPC.
>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> Link:
> https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.ht=
ml?
> highlight=3Dcppc#highest-performance
> ---
>  drivers/acpi/cppc_acpi.c | 13 +++++++++++++  include/acpi/cppc_acpi.h | =
 5
> +++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c index
> 7ff269a78c20..ad388a0e8484 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1154,6 +1154,19 @@ int cppc_get_nominal_perf(int cpunum, u64
> *nominal_perf)
>       return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);  }
>
> +/**
> + * cppc_get_highest_perf - Get the highest performance register value.
> + * @cpunum: CPU from which to get highest performance.
> + * @highest_perf: Return address.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +int cppc_get_highest_perf(int cpunum, u64 *highest_perf) {
> +     return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf); }
> +EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
> +
>  /**
>   * cppc_get_epp_perf - Get the epp register value.
>   * @cpunum: CPU from which to get epp preference value.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h index
> 6126c977ece0..c0b69ffe7bdb 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -139,6 +139,7 @@ struct cppc_cpudata {  #ifdef CONFIG_ACPI_CPPC_LIB
> extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);  extern =
int
> cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
> +extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
>  extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb=
_ctrs);
> extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);  e=
xtern int
> cppc_set_enable(int cpu, bool enable); @@ -165,6 +166,10 @@ static inline=
 int
> cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)  {
>       return -ENOTSUPP;
>  }
> +static inline int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
> +{
> +     return -ENOTSUPP;
> +}
>  static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs
> *perf_fb_ctrs)  {
>       return -ENOTSUPP;
> --
> 2.34.1

Reviewed-by: Perry Yuan <perry.yuan@amd.com>

