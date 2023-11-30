Return-Path: <linux-kselftest+bounces-878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219357FE8D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 06:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D37AB21004
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 05:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4CF1B277;
	Thu, 30 Nov 2023 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oltltUuT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5D6D66;
	Wed, 29 Nov 2023 21:51:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoxdSj+69R0Tdj04JmH/OURgeLOudJBi41jr6tEXJ4yJZAeoYFzvzeES2xT6+dF0KnmXxDw9GUsqpUNIU+gPYEsEyisASlTH1Z0LKVrJHXpfaRgICfNW1ZwySK1ocT1iEd9l9d6RPxkHk/lxCMpz3gtJvqKJQ+uR8fse4UWdcVWt0SzS17s4lz3OstJvWRbMowRrYGK84qycLfw2o+Yr2gSe+dhBWJnNFD0WNYckVsMuT3A9SJA7zXNOM7X78l/yHXSIqd5cNz5ii9BuhhFab9jiBLdu6ZwwFV8c5v7721/IAmmxJZfzazcrjsc90HLE99hFMnF0B6xJ2mHzsi1viQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQbvgpDyqY46gWEM/kv7DCP0o/Cs+Oa4VzAiDSXCMXs=;
 b=QRm6THFg+31Z10x5QLJbSilf2GleXOriZW5mvmZn69zCs0iRPAqeGUYmpEnOFYsid3GjjF6GZYlzmXyq+aF/nS2AYI6MZuPzmAQMEoyivxuTYQNGDb3kI74gxTk7bFsuuj41koYUVMqLRHNgokv17xsELgiQ0Aao+r0UCl3xzdBaTp4m3d2DTfH5UsHgmbc2K4I4hOuEhQ2nQ5Aent4lloxrZrh22XvDklc65YQCFnFv7PDJUX/o+tCkQBYX9Otl6J37rTtGlRJyUg1sa2z8+f7MW3hMT1ifoXVmbDegvDcygKUljbtmxx9KBtgWiY6f9vSiP41J/gLmlPFaduhKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQbvgpDyqY46gWEM/kv7DCP0o/Cs+Oa4VzAiDSXCMXs=;
 b=oltltUuTn0655iP9f5R3pDY29rLmIIeSKBaeiZFyRlAmjH9C/kfHE5fhScvkGW6bUSnMwTlY4IVWAxWrUchtwq4qyrMC0xnVyLswd7WC/E66ST0GwhnHM2vdzRWWtk5G+eb7p46ifzzxnC3bzAnyhqITM8IoG8cE2m4OWF2mMck=
Received: from CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 05:51:47 +0000
Received: from CH3PR12MB8657.namprd12.prod.outlook.com
 ([fe80::466c:b6a0:f281:1e99]) by CH3PR12MB8657.namprd12.prod.outlook.com
 ([fe80::466c:b6a0:f281:1e99%7]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 05:51:47 +0000
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
Subject: RE: [PATCH V11 6/7] Documentation: amd-pstate: introduce amd-pstate
 preferred core
Thread-Topic: [PATCH V11 6/7] Documentation: amd-pstate: introduce amd-pstate
 preferred core
Thread-Index: AQHaIpEQMSKTBvG39kOHpLqUGtTSFLCSXMmQ
Date: Thu, 30 Nov 2023 05:51:47 +0000
Message-ID:
 <CH3PR12MB8657CE8CA647B9973C0BFF0E9C82A@CH3PR12MB8657.namprd12.prod.outlook.com>
References: <20231129065437.290183-1-li.meng@amd.com>
 <20231129065437.290183-7-li.meng@amd.com>
In-Reply-To: <20231129065437.290183-7-li.meng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b641ddfb-c411-4b4c-a64c-7565c3e48332;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-30T05:49:19Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8657:EE_|SA1PR12MB6799:EE_
x-ms-office365-filtering-correlation-id: e00bf323-ddf2-455f-c614-08dbf16870b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gNdrFPyLMhGqc7R8EPDOu7FoN1+8248Vi+DV6eQRxcKU5rzhLzhy2OxeDep3l68skVLnSpdOUU3ZkisaAd/UyNhGF0nB8gGdrILjmQchN6QXS2vO+QCMKhmE4HJ4EyNvzyGUVpUnBjU5b5jOlcWL5np3Ra+KkWPZKS42jIgRu7OsJpz6yMSfAhStEMWODaKoexw1HNaCifi4s+DAusgHAIfs0LAt1VC/Svt0efv8BumcI4e+MeWKlBSMkncTQ9hoVQaLyOhvDVsJfbKVaWwQTRDcV9raBTTSSFk45/GWV+Ag3sV5Am+0xHqzum0TLRQ0RS6wm0FbOszMeTVZP+mrLs9n2TNfZinGFrXIumicOMNzUVCCDPKd99oPupvhowASxSu3lRu1AEzpDt2lmAeI7nw0yKqkWcb78W4HYiQqzjpb2vMAMMpLi9e7FvKsFzVu4TtPK61bJAamvAj1g4aUiA9G7vy+lF8ULRN+7CncglrcH01sm/L8avQ32MRLAReh3HJvOfUH2We7axV5tdTUCYSe2L0R2Nw4J41gq1Hy5dVPIwTIhDbTbvr8Nx75EXlQb4fWbRr0BTI/jY7EH4v0m8phIbe3CTJeeKWHF594Te2mtvuv8iljsApgRAi3T+0tykc79W7W9+XGI22MYIvUF+ZFSg9WC7JDS5+dNC1Aj6Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(9686003)(122000001)(64756008)(8936002)(38100700002)(478600001)(8676002)(7696005)(4326008)(41300700001)(110136005)(66556008)(66946007)(76116006)(6636002)(54906003)(316002)(66446008)(26005)(66476007)(86362001)(6506007)(53546011)(71200400001)(38070700009)(52536014)(202311291699003)(83380400001)(33656002)(2906002)(55016003)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g6SSDlsuHkBWRAcOcn9w24pHGt6Dky1t+Qvj9n9PZOFfceYhSQUOT9vOxY7G?=
 =?us-ascii?Q?HuSWDLb0Ba4hdQqLsGjDYXjrwyr7nJpkvczFJNINm5SzskK3caWuapR83SHJ?=
 =?us-ascii?Q?btmUEwPzPL6gsWbi7mnc/gNxG9pWDum57fs29BPME2go43eZA0SyCRmnJyha?=
 =?us-ascii?Q?637UoFLdvNi0dKtKR5gczF7jIS673/5Tsgd+K9vraL9eoLzOOxIdKYAiu9jj?=
 =?us-ascii?Q?Glk3FhQQjWXmBgjvIK5bhbb85X0DMzvkFazx0TE05REiCKm/7FMXZH/Up5Cm?=
 =?us-ascii?Q?fhvTK6Vq0J1CBOxZ9ny3ZFK/RDhMqiaRP4DBnSIwUiZfIGfqmZc3OG4o2FLI?=
 =?us-ascii?Q?aU9InvI8le+etfVu83hxlC1XNp6iwEMDpTEH8trofZ4oeVl7lFeYqL6aFI16?=
 =?us-ascii?Q?VDUW4UtVOcQPVzzvE+hsHa82RfaGyqh9pyUKw0B6n5Kr4pDUiTORQ1zUSebt?=
 =?us-ascii?Q?DEF9424YAiHwOOx/PQhWXFOQxMGm2eIB/u/B8BaHtWv0OVqfnZn7VqDoJyLG?=
 =?us-ascii?Q?VWxYwqJZl9+e3SY4IvkYZeLgQBLGQdGJE2YhLz3EiaNGSrP9A9dlnkerhRij?=
 =?us-ascii?Q?zo5CDcRVoPJlmd71hB4n0oN8d95qeC0uJ/yTQ2XBcfHS2StRGB4g4gorjzzd?=
 =?us-ascii?Q?74cig5+FMZxnSiqEpK21JZg5sIbplDyGvR281InNSArT/pgbKirHaNYUBFOU?=
 =?us-ascii?Q?C94YUwFS+zyE4SWHcSkrZ20Ebno0HIVu/iFyjxv8grB1qE40rF1cZh1Wj5Pt?=
 =?us-ascii?Q?pfRb25W4xmfLqQOlyJ3xq/EI806fdlTE6m36R2NA7QhGGPd28XUMED9gVjNf?=
 =?us-ascii?Q?TYESkeDSocEizApGiqK2xuWMKzdlAJe+ytst6VkTk8DJB1b/2wSECTR6ht9x?=
 =?us-ascii?Q?0adv8yTQvaOaGNGovG70ON+21fJu5vxdEQnu7DPb5DP9tYnC921RwpNnDe7J?=
 =?us-ascii?Q?C9dhvtyq/ePBwCv2b6TWkTnPoa6FTo8j9OYAIXFASg6jRlxOzRHA+PaGfMIf?=
 =?us-ascii?Q?iiieHbvVQVZ5lQ/t+e9iuGZKwBvaW57w9BGUb6PBwx/WhkkX1yPsAsGAn4IA?=
 =?us-ascii?Q?gvG/icJDvW5vC0CGzMXGLLId6DAp0kx7ERJ0iOYD7zOB5s7L4+dssORTmLEz?=
 =?us-ascii?Q?UeDjjphvmsg+El+frATj0bX38eG5BUEfjwxxxtDjfUsWe43VITqbxtHX6r4Q?=
 =?us-ascii?Q?WyItLc+XY0L4wcpI2/vdXf3sW5Fd4zz087KV783sIQzBW6ioITMHNP2qiULb?=
 =?us-ascii?Q?BZtGo1vAOFwSsTu5UdKtzCWcCGyNBa3LjYBSCE/0UT+TDq3G7CdjVDUn3/Su?=
 =?us-ascii?Q?w9qZ0mJiTaRHeodRqShJwS70bCL7ObZUeontAvy60D1yx2YnxlDtGZKlbcM8?=
 =?us-ascii?Q?UB+t1LQXiXqeRz2VDRe+uM1v+17E3UO4P70pb8CzoDathLfVqy24WqW/4vtD?=
 =?us-ascii?Q?PVzMzCtS9RbdlE2cteVotziYSK9pqZnnS5kASO0qCQXddHvEjgX2K0r94GMG?=
 =?us-ascii?Q?eqqEcTOJ1NeBIfWcCoW6ZT1CffSoGN/jfY3nbzxywCoD0Ff07C7jf3mzG2qB?=
 =?us-ascii?Q?9Jxgp5VRGynulZaAc/I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e00bf323-ddf2-455f-c614-08dbf16870b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 05:51:47.2699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kAR9z1e+dsOExuvTQ/CuuNtxESFlhkoLjNsiqR+IRSjS3CKQ/tyJzH/liORsJ/Be1p2O1/ukZpvSOCqnjRV5Dw==
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
> Subject: [PATCH V11 6/7] Documentation: amd-pstate: introduce amd-pstate
> preferred core
>
> Introduce amd-pstate preferred core.
>
> check preferred core state set by the kernel parameter:
> $ cat /sys/devices/system/cpu/amd-pstate/prefcore
>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 59
> ++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst
> b/Documentation/admin-guide/pm/amd-pstate.rst
> index 1cf40f69278c..0b832ff529db 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -300,8 +300,8 @@ platforms. The AMD P-States mechanism is the more
> performance and energy  efficiency frequency management method on AMD
> processors.
>
>
> -AMD Pstate Driver Operation Modes
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +``amd-pstate`` Driver Operation Modes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  ``amd_pstate`` CPPC has 3 operation modes: autonomous (active) mode,
> non-autonomous (passive) mode and guided autonomous (guided) mode.
> @@ -353,6 +353,48 @@ is activated.  In this mode, driver requests minimum
> and maximum performance  level and the platform autonomously selects a
> performance level in this range  and appropriate to the current workload.
>
> +``amd-pstate`` Preferred Core
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The core frequency is subjected to the process variation in semiconducto=
rs.
> +Not all cores are able to reach the maximum frequency respecting the
> +infrastructure limits. Consequently, AMD has redefined the concept of
> +maximum frequency of a part. This means that a fraction of cores can
> +reach maximum frequency. To find the best process scheduling policy for
> +a given scenario, OS needs to know the core ordering informed by the
> +platform through highest performance capability register of the CPPC
> interface.
> +
> +``amd-pstate`` preferred core enables the scheduler to prefer
> +scheduling on cores that can achieve a higher frequency with lower
> +voltage. The preferred core rankings can dynamically change based on
> +the workload, platform conditions, thermals and ageing.
> +
> +The priority metric will be initialized by the ``amd-pstate`` driver.
> +The ``amd-pstate`` driver will also determine whether or not
> +``amd-pstate`` preferred core is supported by the platform.
> +
> +``amd-pstate`` driver will provide an initial core ordering when the sys=
tem
> boots.
> +The platform uses the CPPC interfaces to communicate the core ranking
> +to the operating system and scheduler to make sure that OS is choosing
> +the cores with highest performance firstly for scheduling the process.
> +When ``amd-pstate`` driver receives a message with the highest
> +performance change, it will update the core ranking and set the cpu's pr=
iority.
> +
> +``amd-pstate`` Preferred Core Switch
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Kernel Parameters
> +-----------------
> +
> +``amd-pstate`` peferred core`` has two states: enable and disable.
> +Enable/disable states can be chosen by different kernel parameters.
> +Default enable ``amd-pstate`` preferred core.
> +
> +``amd_prefcore=3Ddisable``
> +
> +For systems that support ``amd-pstate`` preferred core, the core
> +rankings will always be advertised by the platform. But OS can choose
> +to ignore that via the kernel parameter ``amd_prefcore=3Ddisable``.
> +
>  User Space Interface in ``sysfs`` - General
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> @@ -385,6 +427,19 @@ control its functionality at the system level.  They=
 are
> located in the
>          to the operation mode represented by that string - or to be
>          unregistered in the "disable" case.
>
> +``prefcore``
> +     Preferred core state of the driver: "enabled" or "disabled".
> +
> +     "enabled"
> +             Enable the ``amd-pstate`` preferred core.
> +
> +     "disabled"
> +             Disable the ``amd-pstate`` preferred core
> +
> +
> +        This attribute is read-only to check the state of preferred core=
 set
> +        by the kernel parameter.
> +
>  ``cpupower`` tool support for ``amd-pstate``
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> --
> 2.34.1

Reviewed-by: Perry Yuan < perry.yuan@amd.com>

