Return-Path: <linux-kselftest+bounces-5005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 618E385B3DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 08:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B15283FB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 07:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1DF5A4CE;
	Tue, 20 Feb 2024 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c4PngH8T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10105A781;
	Tue, 20 Feb 2024 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413793; cv=fail; b=eZAsTLFcfw5fmRO0SWTF6wiOSKRROuS5O8VU9o/gv2vLNow4q35FEviUZq0DH1gavgcQeROuri2HNMekWWkzU1RsnUcV6mWM0mFs4tT+Y7bAm5Xz/+smwyCmttA2XRbyhC7Ps6GgarUGMaE8rHlFyKvsr05BiMjVsRcMO8eK8Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413793; c=relaxed/simple;
	bh=kadGgJtVhLaCj25u4P41WccEyOFrecEaPui9wSEzivI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HldGrXyUfp4EBVPLtqziV346uRWwdtZe/kK3TEvqis89HWhdKHfOmdfzgij+btEaw6zJDTUImpn4OqgpuH0tg8+HnxVjpsIPiazBByTYGFFExWxZltoyOwJpC7JRgMFAM3tSzlkyR2RMXo/R4lW9eq4TDH9rhSceX3WDFHVvU2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c4PngH8T; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjOHyUgIJPjS6VCE1kgzdeUcItMa+ypfSrvFr/2ezox32eePlkqIbVDH0mizJRi+XFh3jFFRpUFDZvJBL7/K64pNdfsTEgIFzDH35Y6zD7Y4YcC9eYNnLXnnZyGs3x5x95kBYxgS+idz/ToqdD0zGF4CC7P+aNKhzFO//KvK2kfB2slo/5o/k8TorAMWQV+sNFIC77AB5H0uKBAhxi8UAvlMZ7Tzkcy7C24s+4WtrccE1d4RPcq3T6AllHoynYYHQZ+6UgOYzxv2SFkYXWdkJg+DzKPS0v9iqQJ70pPdC91AVHTWU3OayGNBVi+lWwcDjzJZF3u3/4EWhTn9vVYWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U98VeIF5LkYwlQVGLh1sNZtj/ozVgnb76RfPpJFbczg=;
 b=Uv5JHwrByPtpCdomQzbxZ99A77s7qHCaY1QsHrY/9EVE95k4CIgS5oAJtvSW8byO6t9MSAdBuQr1EdY5b+8N6xOZjvYoi4BPioGI6ntYqBGndbP2Lmjp0FAMEID0DJ8MY3uVYpBsPbVo12joIDQtKZosOGh4A/+PUcv/0vsMP6vBOH6L2TUOh0nULTXVJwqxNVg36cFY8N0XlRzT1mcuIQTpYxByzCM8tNZOixEkq0UJEnDkExfXpxHb85NxtI7ynHwmoHB4mjxEX02bgj7aLcn57zWWNLXKHsnEg2pEBCBsSQeZmydnwCDF4c8T6wPlGFVKoRyAkWCO2+mqrGOtsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U98VeIF5LkYwlQVGLh1sNZtj/ozVgnb76RfPpJFbczg=;
 b=c4PngH8TEUK9BuSwMlpkQvlx7Grcv1pzmPNhtwz8MZbs3z+16GoOztTS/O10a95jY1Kvq4T7m9wuJuLyVTGSqxZ2JcQPQrmj3o8AXw76osnZXSplytsSWkDWXzH1oeDVXCLQLML3EIRN7zHorwS4FSjOx2aUNHEpz1w9/npIdWU=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 PH8PR12MB6722.namprd12.prod.outlook.com (2603:10b6:510:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 07:23:09 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::1b3:8ca1:e95b:22e5]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::1b3:8ca1:e95b:22e5%6]) with mapi id 15.20.7292.022; Tue, 20 Feb 2024
 07:23:09 +0000
From: "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To: Lucas Lee Jing Yi <lucasleeeeeeeee@gmail.com>, "rafael@kernel.org"
	<rafael@kernel.org>
CC: "Yuan, Perry" <Perry.Yuan@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, "bp@alien8.de"
	<bp@alien8.de>, "Sharma, Deepak" <Deepak.Sharma@amd.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: RE: [PATCH] [PATCH] amd_pstate: fix erroneous highest_perf value on
 some CPUs
Thread-Topic: [PATCH] [PATCH] amd_pstate: fix erroneous highest_perf value on
 some CPUs
Thread-Index: AQHaYoWn0TWdRH4q1EizfAdgioooG7ES1hWg
Date: Tue, 20 Feb 2024 07:23:09 +0000
Message-ID:
 <DM4PR12MB63518FB49F94A8445D32780AF7502@DM4PR12MB6351.namprd12.prod.outlook.com>
References:
 <CAJZ5v0hRk3tME7yeC+1r0RM4-oPPrnSu2=JCsOshBbJp_Nq2Hg@mail.gmail.com>
 <20240218161435.38312-1-lucasleeeeeeeee@gmail.com>
 <20240218161435.38312-2-lucasleeeeeeeee@gmail.com>
In-Reply-To: <20240218161435.38312-2-lucasleeeeeeeee@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8fdc9162-ecd9-4e7d-9570-7dc9c919dcee;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-20T07:22:30Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|PH8PR12MB6722:EE_
x-ms-office365-filtering-correlation-id: 57c22e72-c87a-42b7-aeb0-08dc31e4ca09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 56d2scx72z5zsmDTev9Q2dCvDNaPGh+ADPEY7Ft6MRJfrQ/76x19CIrsEv/Spz8akSzoPGifXWZMEKbYtdEhPX8TSFaAcci4H7TMA7zhisKZMYQnutUnotRJZMho33zrsLN1TWd5UiUYGCMMSbEdHU5tEN1vA0jMERUtkRjsl9TmusaK4lrqZPVvwu4cNHvJDcl0kyu6P8VyLocS8/XfThpAciGNsyu9EOqlc1HQ70gTtJK8EHjip+idmRPN6JbuXf3zNRzK4EP+HNFRGQveIKJ54uAxA82KJ8PglKFu8TrjaS0AsCbNgG38aMZ1Xt2EJ7Ov7rdjY1411wrXtvFctfJ59GHjs6lF7uhAMkU+CLnwXh3kFqV8fNjMO6Selq+JVcnLzoyjy821nugpywTPZe+B+Y+aL0ORx4AXLZ+X1W34pQ0Nt+v4VoL7mEyheOqPYErtKf3GtlzlsFS5Z0/wjKOV3fz3OrrWerk5ZCmHIzcnraSeP5A1kOh7PklTJSs9ZMHU87riHTOKnwIVujauBCz2wCF6Qw4yG7WoJwFpv5hkyZP2Agb7RzKRw7f9mQKCVj45fLYwZKVgDy+11GeoySlkBzsi2mHeJIIk57WeWuq6xlpLxcwbvXpwpFX0qWBZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IRVxHL8YIQdK3xGSFYWUSbPa9nHX/UXZv2wx4MvBggDx7Cm+pBse/R3iuSHv?=
 =?us-ascii?Q?2OXldHT2+mHCtaoPr1Fsxw3dDZFpb3uaR8V1EHWmbL3+XPh7mkuglylDsgvm?=
 =?us-ascii?Q?42uwb5aEP9rr95gPn+1JvPUatAuuT3bflUDXxE5KMFxGVUlTQ5k+toc7FOS8?=
 =?us-ascii?Q?B//X4U3A4QYLs5Chf0/4KP8bBMRYICiATShtcjbL8oRMlGHObfW1h4RF5N1k?=
 =?us-ascii?Q?cXXzIXVw4yVqSjjVsFwLi2s47LDgglsh4GNvsn4oZ3ZLkfQbr3GOBulQiFLH?=
 =?us-ascii?Q?MrDmXRF+S4j2ZvkacsaXeaEo17pnhJOoxhphD5eP0hrBAvho1SgshdWPmHC9?=
 =?us-ascii?Q?vZOG3VWKBsPpDcjrdPN/o2zE9J89RfZ9lotGb8uvnp7WmQeNueNjbgARwQee?=
 =?us-ascii?Q?1skrm97oLpM5OdfhnloP6TUQ6QcQRIt9UQaLd2oiKGr052S6U6ipFx/oo+xD?=
 =?us-ascii?Q?k6VCbNOVhZtlBtzOi96eOatAJZSpGrMNAe0vNiZZt2l29Id/+e9QhIyiw5DI?=
 =?us-ascii?Q?iDe1u3bTDwegepEDkK8F2Wo/OHz4reDnHXcXww0UOnI/oNi6UiGFsJ8oNdd2?=
 =?us-ascii?Q?OMGwBojxpBIoqPCBL+9ip9fdFfeJLjLTgrCp+iYG175ZdGtL0TUZfHdA1WMC?=
 =?us-ascii?Q?FT41NolloTwn48Z4vLwY/WgMQ0H+yJKTQB0oOGHTarkqLuednIgVHCOQq80/?=
 =?us-ascii?Q?WsQGD3+LcjRfr5pop9ukK2cS4bMTi4NAnN3xAbh/Qz9zwHcC4mN/MK8ol9uw?=
 =?us-ascii?Q?I9WtaG8+W5r6boE4J0lfE/kubZxW+jUwytwyClc2y6IokgaMXiRIJNyXwtdk?=
 =?us-ascii?Q?gOE3qSb7Jt5V0de7tROl6+E1NKs/a014mFlwPVBeVi+rletj8p167KLKorRB?=
 =?us-ascii?Q?+n8Im9ECg6OPvStsC/BhAW50okEVLEKxluQt+HuYUCtObDa60hjy9XtTorz7?=
 =?us-ascii?Q?FyfNBOw8WSZ/CTIVxkWUHW6mflzwk1hXiRmY18Ta607BimBq0Lwm9huuoOOG?=
 =?us-ascii?Q?eM9J85LbCOGCjECLqHZLCyWLxy3ca3faONvv3YQ068KYQoSJee62nIAaT3In?=
 =?us-ascii?Q?LC2+TTofQhUnKYMELIK5gvTWMiiDnROzPe1ZJ9yOlg3s04MprYPp8l9t15Ri?=
 =?us-ascii?Q?qdZ+AeTsYK9JKzwzBodp/ahJXBDiWOuG8jZJvb2aKmMhoNzsa+mSVy7Jvf7d?=
 =?us-ascii?Q?WA9NPdUpTnHPv+t3nYiYCUqB0e4VJtQqAb5b7KMPIliUyRCJ7c3vCEK4GUtu?=
 =?us-ascii?Q?iAEwD809uyeHneVq2IGpMqnh+p6bggAhPYsCX/AlmsIT7/UTR3YBRNKbBA92?=
 =?us-ascii?Q?31DLU5eof6x/FyGeFfcuDno3xDY+ddKrK/dCmEPXbIkleEvSPwatf79Gt9wB?=
 =?us-ascii?Q?KdSOtorNe3C8/F7i4HHirBemIIjKO4nh4tDFdTUHcJoGwvBTBhB2xi9SD+KK?=
 =?us-ascii?Q?emCbJdnRDla2D2i3f8A2Yn4jnLzgEc3lVQcM9udlU3IDYq7gUDtHT7ZRKBqm?=
 =?us-ascii?Q?NO9GGI/A3tC1++4cOwbt18lLiu2BuClM57u7w0qWQUoSvpIU5JYH7PD2wPyD?=
 =?us-ascii?Q?4Cx1M/NNPGdV7Ev46NU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c22e72-c87a-42b7-aeb0-08dc31e4ca09
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 07:23:09.1235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tx7R6sZw1X+lnNjSCwz08LQiLf6rZLSOoPGZJ5oNBaj2lFog0VPSwWv5CPYFFCqu1Y6nZsVa+gUC3r/JfLH+1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6722

[AMD Official Use Only - General]

Hi Lucas:

> -----Original Message-----
> From: Lucas Lee Jing Yi <lucasleeeeeeeee@gmail.com>
> Sent: Monday, February 19, 2024 12:11 AM
> To: rafael@kernel.org
> Cc: Yuan, Perry <Perry.Yuan@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; bp@alien8.de; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>;
> linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> kselftest@vger.kernel.org; linux-pm@vger.kernel.org; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; oleksandr@natalenko.name;
> rafael.j.wysocki@intel.com; Huang, Ray <Ray.Huang@amd.com>; Huang,
> Shimmer <Shimmer.Huang@amd.com>; skhan@linuxfoundation.org;
> viresh.kumar@linaro.org; x86@kernel.org; Lucas Lee Jing Yi
> <lucasleeeeeeeee@gmail.com>
> Subject: [PATCH] [PATCH] amd_pstate: fix erroneous highest_perf value on
> some CPUs
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On a Ryzen 7840HS the highest_perf value is 196, not 166 as AMD assumed.
> This leads to the advertised max clock speed to only be 4.35ghz instead o=
f
> 5.14ghz , leading to a large degradation in performance.
>
> Fix the broken assumption and revert back to the old logic for getting
> highest_perf.
>
> TEST:
> Geekbench 6 Before Patch:
> Single Core:    2325 (-22%)!
> Multi Core:     11335 (-10%)
>
> Geekbench 6 AFTER Patch:
> Single Core:    2635
> Multi Core:     12487
>
> Signed-off-by: Lucas Lee Jing Yi <lucasleeeeeeeee@gmail.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 08e112444c27..54df68773620 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -50,7 +50,6 @@
>
>  #define AMD_PSTATE_TRANSITION_LATENCY  20000
>  #define AMD_PSTATE_TRANSITION_DELAY    1000
> -#define AMD_PSTATE_PREFCORE_THRESHOLD  166
>
>  /*
>   * TODO: We need more time to fine tune processors with shared memory
> solution @@ -299,15 +298,12 @@ static int pstate_init_perf(struct
> amd_cpudata *cpudata)
>                                      &cap1);
>         if (ret)
>                 return ret;
> -
> -       /* For platforms that do not support the preferred core feature, =
the
> -        * highest_pef may be configured with 166 or 255, to avoid max
> frequency
> -        * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1)
> value as
> -        * the default max perf.
> +
> +       /* Some CPUs have different highest_perf from others, it is safer
> +        * to read it than to assume some erroneous value, leading to
> performance issues.
>          */
> -       if (cpudata->hw_prefcore)
> -               highest_perf =3D AMD_PSTATE_PREFCORE_THRESHOLD;
> -       else
> +       highest_perf =3D amd_get_highest_perf();
> +       if(highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
>                 highest_perf =3D AMD_CPPC_HIGHEST_PERF(cap1);
>
>         WRITE_ONCE(cpudata->highest_perf, highest_perf); @@ -329,9 +325,1=
1
> @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>         if (ret)
>                 return ret;
>
> -       if (cpudata->hw_prefcore)
> -               highest_perf =3D AMD_PSTATE_PREFCORE_THRESHOLD;
> -       else
> +       /* Some CPUs have different highest_perf from others, it is safer
> +        * to read it than to assume some erroneous value, leading to
> performance issues.
> +        */
> +       highest_perf =3D amd_get_highest_perf();
> +       if(highest_perf > cppc_perf.highest_perf)
>                 highest_perf =3D cppc_perf.highest_perf;
>
>         WRITE_ONCE(cpudata->highest_perf, highest_perf);
> --
> 2.43.2
[Meng, Li (Jassmine)]
Reviewed-by: Li Meng < li.meng@amd.com>

