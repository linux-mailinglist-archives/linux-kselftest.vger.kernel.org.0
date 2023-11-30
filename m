Return-Path: <linux-kselftest+bounces-880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8E47FE8E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 07:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1CE1C20BB9
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 06:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7906A1CA95;
	Thu, 30 Nov 2023 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GhXEf2/5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8DDD5C;
	Wed, 29 Nov 2023 22:00:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDDYCCzgt2rAFBBCNOisiaibDfLorBEw1RPNeiMCPXUkItNIHmQDbPdl93gnf7UtsFNOUKTqnDB2WcueIam1EcfdTuwwyGrGSkv9nlxJV8HHxFBWw2pBHdN7TkukkVYnK9qoAn+BpJ1kRRT51jg23G6KB2cGWyzbhVFzW8kCrZWOtOJJMvxBq5wwCqOZHFO+Z7h/v0clwcjhbp7m/xmPHh7bVmL9qQRsuBPMaZFJgZ/8JmzpvzsMBNKH51NZ0rBVnHPsARZ4aKUmRRw45WbwW/ZjZAlMbM3ZlKgbdsXDCc0wN537t8xOi9xjYu90uvZKV45fM3CKpgdHgtxOY/Nizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoMSL8pYLOpkKdoN5w1xEIDhmsqsa4Xo43KpNte7MmU=;
 b=lJFAu0mLiZgLlDfuJiT/1ouJfraEjtCuI0Hrz/qB9BzKZ4y2QoWuKTQAgjUiy4o9lqYXRrSYIHF9RvhEQKr2wmevi3TCTKbw836iK7CGKQCUUanE/eUJY1t9AqElVik/AQNjVDo533sNbExYJSHYncX3ldneqk5/4wjFAWYK2cH+qWKKNPFT/Zkf8cASEeH2iVex1Wmd/rGSBOthUYK+qMJCDHs1DSPIjWpEKicAgUg+YT0bY7EX8G0eMpjNlRJ+Z9pbPNTpRcA1lTJHBiPBL8SEEf2bwc5DdUqCEZlAo9gc37SYqGiigmdODUw6hD0oHRBDHDaEYw2sjb6F/kGs8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoMSL8pYLOpkKdoN5w1xEIDhmsqsa4Xo43KpNte7MmU=;
 b=GhXEf2/5ZGsgJdvOFWYO/Hjs2+lJRN2EkSHzrr6cOqM8JxFF3lBhyr6VeD0hjaGfdJBfkWX+MKAOVMx3tCdEQazG7HLBjfhmd2L+oYbsM9XypZgsOLd9ZbsknThayWFKUsIIBYZ55JzxNZXMVEBUsmcgoxTwtb/BWbxkOBu+4ws=
Received: from CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6)
 by SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 06:00:22 +0000
Received: from CH3PR12MB8657.namprd12.prod.outlook.com
 ([fe80::466c:b6a0:f281:1e99]) by CH3PR12MB8657.namprd12.prod.outlook.com
 ([fe80::466c:b6a0:f281:1e99%7]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 06:00:22 +0000
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
 Natalenko <oleksandr@natalenko.name>
Subject: RE: [PATCH V11 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for
 the expansion.
Thread-Topic: [PATCH V11 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for
 the expansion.
Thread-Index: AQHaIpEAIxc9UVc6VkOx9GblNLjMzbCSX5VA
Date: Thu, 30 Nov 2023 06:00:22 +0000
Message-ID:
 <CH3PR12MB86576227E4BC52CB184E2BEB9C82A@CH3PR12MB8657.namprd12.prod.outlook.com>
References: <20231129065437.290183-1-li.meng@amd.com>
 <20231129065437.290183-2-li.meng@amd.com>
In-Reply-To: <20231129065437.290183-2-li.meng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bdfb7f22-ffc4-4baa-bab9-1c972e618000;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-30T05:59:19Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8657:EE_|SJ0PR12MB8113:EE_
x-ms-office365-filtering-correlation-id: 17aea68d-0790-44ff-7a94-08dbf169a386
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AkubrUjhat9UOEUg3il/gqaXCqPmbJCgL4OxL/6pnnWNil9tSr7jnqGb2qPj5uaHdz9okOIpbIw/9dCHZgqIIAX0a8LZ3AyWUON6Dwe2z8L86DJuafLuwN6RiqOtWD3drxt0Dr2ZBHuOVJKS1A3KEprzj4Zb2z+ftLwSvJlNhyEG/JVUUBNili6N3FFPtLd+XL2S6cYGVzDXisk7KDAWxBPTtXMKrLf5dJa6bG9mEjWIQPFXWetwL8qQLVx3gNr6S45F68UaMYNUEc2BpCH/XZbgUOa8h+DvVzz51MZuawr81cPLsOvqv5TuFbjnKax9UZ13S5OVQ6IGXvPim3QmWI51VJu6HEs2sFMP6p9sLbnLp0Inq/KK6oIP+RXJWB7Eo53i+xvlE1ADAqAZP9rIRA0kuAok1ofgxEVzYtrMFR7VT736y62V5n/FKsjAGT7giOn6vfaN2pAbxuyOyw+hVHNZVZVtG4ERLnzQ8hAkFf5Ht3edOs57ot6boF2YYaPlprPR37WzF8aRV+RSGlewT70useCe2GoEmXWSQ3VrQiMRDZqSsfpHYnA1Cl999hE5JPKr8Nr4ZgUg2++tAfDvgL5pOZI6YFMdF+5g88ymyWP87asbKbuDivLaevsMK9m1fojAcWfT4kUAKGGknKCWUJLr69WGv1XpICdnH1gK1hk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(71200400001)(52536014)(478600001)(86362001)(9686003)(6506007)(7696005)(53546011)(54906003)(64756008)(66446008)(66476007)(316002)(6636002)(66556008)(110136005)(66946007)(76116006)(4326008)(8936002)(8676002)(38070700009)(122000001)(2906002)(55016003)(33656002)(38100700002)(41300700001)(202311291699003)(26005)(83380400001)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Mb20QuyGGKhfJ8R2wqDIykiFNx49e8/nYPWYgGFjWdxPoyB0mXR9FCL3FQVi?=
 =?us-ascii?Q?4hps9QqRgRlGBqTZ082QYlzG87ji5qU4OA3+6nwpFzZ6AAFHThMTxE/SmUkH?=
 =?us-ascii?Q?tKg2BuUHVhej6u0sDPI+++dHRB13M0qp+M1McftKGRe0UWgr7VRQaXAHIhX/?=
 =?us-ascii?Q?ihAuqy337Nx+TxloHgwmOpPCSOJs94WMzkEczRfX//WiUFAd9cuzOCw28vpi?=
 =?us-ascii?Q?O/RlZErlMdjUkxXfnMlL81v3eQawnwj4RF1fi3xMUzMyAItXTnTaz0P7/f9J?=
 =?us-ascii?Q?k4gsF1fesic+eHSJXYEFYYx6yvoaMJbVs0mVUkKQhyzfeeAFbI+sloo0VOYt?=
 =?us-ascii?Q?rlHx0OmW8uQFZcJOQHmHd1I65eYqBNVskqNDcWWKVTDD0h1XoZiyUZ8os8IG?=
 =?us-ascii?Q?KMofGmsKnz3jZ1dab2sbWht/r+zcHVnrG94PyA49XHgFbQgtxBUeN8W5r16n?=
 =?us-ascii?Q?BCcZ+hNgCoV5+XpOQmpvI4ixvvKvu/QuR0kdBt9zoRfFwd8xw6+nrbzssjKU?=
 =?us-ascii?Q?N9mNa2bIFW27MlDrUPCw5/mhWJgQyUb7ssycumFhAzQdYLIf9RPw8XcZHzyr?=
 =?us-ascii?Q?xqJrknFyuGNOeilZ2QCr996Qy3onULIGAhd/w6Yyx5RXwH3grVHU4oFVA3Z1?=
 =?us-ascii?Q?jWT7cFw7kpT2GcrUWFmktjZ3LSWty7dbCip1lvFnK0D2PUbBzcDibfnatcGM?=
 =?us-ascii?Q?RTXmcHziE5/GJIzU0ZutAVySRVFGxaeMrFeq4Y04/oGWTc2qt6t+Peq9nppi?=
 =?us-ascii?Q?MGE1n2YHCy2bI6BAFPAYZSoZaZ5zAUIhlzciaoCPeLDN5oOOEQTIVj3OjfJO?=
 =?us-ascii?Q?U8jRWuOcYe++CvJuyOYt9XHK4+/uUMb1v1ow5DElo/AqK3sIA2VeL2FwWgg4?=
 =?us-ascii?Q?Wf0XZ+2xYu+AxmiGbvZGPL33aa4a5ePZNGacjCF/dm0YJYueaYs8t/Xm2c7A?=
 =?us-ascii?Q?RYppa+Dd5NVbiDUXw6SLcs/F6T7D/ifIPqqRY/ne0QgckfeegzpfYwKoW22+?=
 =?us-ascii?Q?mrZ9DkwZNMPy+gTM+eOiEWxhDgihCUgI1pFmRQAlzKrM6YlIrXC6/5FQlFt+?=
 =?us-ascii?Q?1utP91YrY2fydbWWMGLOsKuxffp2s86QBoFoSKWwqD1WQ5ONkzuFcV0X4IT+?=
 =?us-ascii?Q?Y+dQub+D03/SQ7UwuxdGTB38EeKwdEx8qa4crSPE6/DKkgTE98NlZlW7DtBI?=
 =?us-ascii?Q?SM+CT/pnP84+VNszTU3v2Jzektbf1JNlwjk8SosIyB3OzdiQF8mc+Q+OaCm1?=
 =?us-ascii?Q?0AAmp69Qoq4qo1IjUBCdMnMchHxKI7z88x9XigOYijbLhKW1yFRf9jLF8iq/?=
 =?us-ascii?Q?j6dtt4z/sary0+SJVp60WNB+ct9kfvD4XE96/T4feMPooPST0rN9bM/fo6XK?=
 =?us-ascii?Q?Z+dm6wEmQVXc9/NqvM2RHR0f4pvSILUmiYo8OlOqeZyxin9s1mR4IPvPr+Qp?=
 =?us-ascii?Q?QqoxUoibJBoHjjHePS3eAkdjPhEmX/lSzX7qscpziTsqFpzABm99dkqna19R?=
 =?us-ascii?Q?Q2sQq0HcztN9Rfr427BOiK3TpRMDtIdUPKvI+V5OifCcDiHelBLFXBy8gP1o?=
 =?us-ascii?Q?SXr5u4dhfb73gpDEDOc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 17aea68d-0790-44ff-7a94-08dbf169a386
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 06:00:22.0153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DKcBWqZHS1iPfTNuqHmix917SIWtDR3s5fuclR+3y8ORi5nm/FtifFjSLiecVgWVu7rOQE5ohcI6wcD/ykjskg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8113

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
> <Li.Meng@amd.com>
> Subject: [PATCH V11 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for
> the expansion.
>
> amd-pstate driver also uses SCHED_MC_PRIO, so decouple the requirement of
> CPU_SUP_INTEL from the dependencies to allow compilation in kernels witho=
ut
> Intel CPU support.
>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  arch/x86/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig index
> ad478a2b49e2..77b1af90f7a2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1054,8 +1054,9 @@ config SCHED_MC
>
>  config SCHED_MC_PRIO
>       bool "CPU core priorities scheduler support"
> -     depends on SCHED_MC && CPU_SUP_INTEL
> -     select X86_INTEL_PSTATE
> +     depends on SCHED_MC
> +     select X86_INTEL_PSTATE if CPU_SUP_INTEL
> +     select X86_AMD_PSTATE if CPU_SUP_AMD && ACPI
>       select CPU_FREQ
>       default y
>       help
> --
> 2.34.1

Reviewed-by: Perry Yuan <perry.yuan@amd.com >

