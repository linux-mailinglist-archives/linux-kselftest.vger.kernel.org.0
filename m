Return-Path: <linux-kselftest+bounces-879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB067FE8D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 06:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192ED1C20CB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 05:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F14D1B294;
	Thu, 30 Nov 2023 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T+cgp2a8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C89D66;
	Wed, 29 Nov 2023 21:52:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWecSWtyKSiPphMhfoBfUnlCLWso9sIj0qiBRUJZGpf6R2dkcWp0pPwoBP2xTYsQMb0G71ldDRltHkCmW3BujHmGuvFVtPCa02C0SzjljTBuuRWBDK9BmpLa0Qkvq915YPS78dvNEw3L5DTccbauB3QceMPk7i6UaL9ou7mltLt+A+idiOuopDY/CaH3IxQQTZA1GKSg9TkPU4hve5VKBfc3x7ZPvCUz754V1pDcU+mjOFs0vqttIYB2sTuyxkAIrT1FFFXhHL3ZFzV7PAKe55PJuP0Ict/qL8dg5G5CF/SwRaLEifnE/rWX4DGOI4IITPx94ofrbRdEbDHroj+BHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DvC1A/YUFL1p71At2tcYGNOl6kUxckDCQl0beoJFTo=;
 b=M2LQt8u1dR0tsWhTmmgEYoYUm1IkLleZHteagJJZWM1WmWN5cbNTPd63ozkPSRCCGV6FXW7fYJTrklnyJ60DnZfRD0h0i8SQZLKlvZoDq63WKjcnNZQmM98Xbr3EeUFz7U+e1J3ZidnWTLbkQ71d0LYeL83hE7ijsiY31nDFLU3/Gu+UZ1nhPv76OQLBOqYaqw8PiHpB4UqcgnzGdpknbohCujDA7RgB4RTUq3ER+hmIn87+SHJ0uqCSbU1RpH/JMRTyJIZrqQKFINbJDX3gwyj7ktk1qV09wJUZpBhY/vdKkgq1qvSgdv+yY7FtntX4IL3KkNK8F4yujF3IOC7BQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DvC1A/YUFL1p71At2tcYGNOl6kUxckDCQl0beoJFTo=;
 b=T+cgp2a8tuCbAjc8/brD0hsKkM7H4OHDWBFuoGhXgV5AtFWRrmAuYlHDXPJm9wDyLIgtDZ+20IKHBRfh9ETu5RvGxbUzA4RofEbi0y/cTe6DEBLR158M2jWPpIj5h7Owun+wxxcFJk4dtJ86GEzk2MmVJQDUy9cowOM3iKk7xfA=
Received: from CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6)
 by SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 05:52:14 +0000
Received: from CH3PR12MB8657.namprd12.prod.outlook.com
 ([fe80::466c:b6a0:f281:1e99]) by CH3PR12MB8657.namprd12.prod.outlook.com
 ([fe80::466c:b6a0:f281:1e99%7]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 05:52:14 +0000
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
Subject: RE: [PATCH V11 7/7] Documentation: introduce amd-pstate preferrd core
 mode kernel command line options
Thread-Topic: [PATCH V11 7/7] Documentation: introduce amd-pstate preferrd
 core mode kernel command line options
Thread-Index: AQHaIpER/Gjpd+u1NkuSXNLB1Ts5kbCSXYPw
Date: Thu, 30 Nov 2023 05:52:14 +0000
Message-ID:
 <CH3PR12MB865736102282E906EC13E4749C82A@CH3PR12MB8657.namprd12.prod.outlook.com>
References: <20231129065437.290183-1-li.meng@amd.com>
 <20231129065437.290183-8-li.meng@amd.com>
In-Reply-To: <20231129065437.290183-8-li.meng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6783e045-c0f0-4b73-8657-e8fe8b49695f;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-30T05:51:55Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8657:EE_|SJ0PR12MB8113:EE_
x-ms-office365-filtering-correlation-id: dba0077d-09dd-4aa7-7168-08dbf16880b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 p5T6r9+u8lPnPMuhU1Nhnae9WEs5DvW5+W8M8Ia9evJu3boxoOr8gOxChCWTHuz56yJ5q5J+ti9wEraW8JzI71ff2jj3tSYskLANTDbmU7wOahJKgYVpFPZMP2c6MAwepOTQS1Vv9zQWJwlrU/WLiqhHiCqB4YyRqgwHThMkA2AkS8RKymUcPjXLKrvJfcrEkTTPhdK0BvdZxYpZjTa4uG7szeUcJVO3P4tNoYH81iQXCWfPEJYNpNPcg6e+UIerd8vhrvgFNGSrSkx1EQF6tHOli9oYRD4FewPcBj2NZrbToNLJ3P5gylSNABRcg5l6BazvRvqbWdatwWKRELgxISnteEr2XpVEFTUudnNc4vcTKJTFuezG3oJxU+WRCDpQQDzsWCzIWAhzUD5ShS3Qe5QtQGp7Js5IIMScQqiwyX1/ut2zKh7JCbJma4vuYrh/4dMGGmm05/3yeWvGlCmvln5bHn6OgiuejhpCewVnXm6KcH1gzooooo+jJLhGbLMC1wlW1dDe8hctfbzGPqlOd+pyQioM3l9mqabqQ6Y0JJD0LgVHa+5lfCe6Ww9u9gNhyjo6/At7D2fDg0WQMDWBjEyv0qLDA29tb6RZl/W6eUn89PXLfjm21Q5MShFCOKnCugw02iUVsqCbcLDf0ttB6soUkm5vxnk2hBqOUFVSD8c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(71200400001)(52536014)(478600001)(86362001)(9686003)(6506007)(7696005)(53546011)(54906003)(64756008)(66446008)(66476007)(316002)(6636002)(66556008)(110136005)(66946007)(76116006)(4326008)(8936002)(8676002)(38070700009)(122000001)(2906002)(55016003)(33656002)(38100700002)(41300700001)(202311291699003)(26005)(83380400001)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d4hTYvanRSWO2+p6fFlXvgNBrlA3AeNbVXxzaHt8R6FE82p/2psdbXjRnAk1?=
 =?us-ascii?Q?5n8RCelqIyQAEkKO5QT9VLr8ioTseB2IGplRZ3SwrJDC1aBKIA8qEidIK+iJ?=
 =?us-ascii?Q?/tuASxcNQRhnW5rWp2v+5h6BjqpCRDiJHjwWB8/0JPHFshFlZIBMPnAJgxTW?=
 =?us-ascii?Q?DP/IqTekectjdUs8wqjpzae1bvNurnrEDeZzqWjKc8nYNi2EdQxugEb8CRw8?=
 =?us-ascii?Q?Yu4r1ctgSlkO9lRpEyg9nxArs426SaEqDNlc0Zh7Q/gRTBkLFUZetPqPk0sF?=
 =?us-ascii?Q?DTVG0S9+LFvwuxO0p+20lWZTmK7VQUKBcohk51IxpcK0bsG5aFepVLQ2IVd8?=
 =?us-ascii?Q?EYYh7SbPsCEY1z2RnAdsg0MMN/VeBiI2gxqb+1N5wD74nRYexD6al68O1njO?=
 =?us-ascii?Q?ssBVMKN6wNJDBdccrYcziD8XjQtfIr3xTqLArbyTooONs80O4ksyRj/pF0iG?=
 =?us-ascii?Q?xFlMv3tjt/3Zefa4SaYI3ht+oxfS/+UYgfBAIBp5Fh50FaVyYcPbHK84vapV?=
 =?us-ascii?Q?U7WBMFLi70PUGszGoprzPhFNsgjtLVP0sb6RbCFvFjH4vTYC76MUHXbMzPdf?=
 =?us-ascii?Q?rFaKs9tXKmRtSmQLR/JpxN3zNfDJeOlkHjBaqQYRuj7oxmbhrDaxwAEotKKw?=
 =?us-ascii?Q?ljBejil4n8Het0nYrO/Bk5661dX9PcEWKW9WeSULUr+FoYCWvjX9rRyzK/Ef?=
 =?us-ascii?Q?+tHMJ5lvHYDIVER/C89kAgQMe4Be6b7GrgZrTjJm4w7ktsbRg+D2qbKy4XHV?=
 =?us-ascii?Q?N2h/+M8jqH3ZFwm2gyrqnxWQUflGGSx4ZIst/e1LyrsmZeF81iDEKqEWqV9j?=
 =?us-ascii?Q?V2SWKHfBFu0UwjF9mfVaeFODweZVT9RNgohadKWNcBoKvYuGjpmVbdLTAfCF?=
 =?us-ascii?Q?UoK1yMqPDnVYJuMmyHP1npfrgu1t8fhkdoud3BIBPuDX4Cm45+MuDqeoeT9t?=
 =?us-ascii?Q?onApTQ1QJ7xY63UoCXDyGzLkHD7QZF0tKSq4JZZW+s0jLS7DBvsAW3yPfG54?=
 =?us-ascii?Q?KaNiulXUMz/ccLbCtMj4/O2d8v0qs+zFPonusxTJrl068PLMA2qCfvHQDu5O?=
 =?us-ascii?Q?z7yJZpVAEx6iyGrQModzi1k2m8s3rlEaFqvFmRYS1VtwvZ1pZC4BCmtppp2I?=
 =?us-ascii?Q?pa2drNocDHtWWiRXS98mswczMjqJhb+r5dHKZYayfbEWw+JGnBFg0BKh4kSP?=
 =?us-ascii?Q?TE9x8Nsswl83A85vgdDWh0cIo0yzwIZTgiUg0Bs8PjkyfES5+zjhNWWgreka?=
 =?us-ascii?Q?j80lBPVOnNN2fI2/O5YSvt/JNjTSJJHknFdXs1eqGMcjbky8LoZvmKEUY23J?=
 =?us-ascii?Q?+xayZew6nEFHFEsaaAAoy0rZTi0xwcjr/NYkhV1CVuGgh33/UQ6y1/L/lg2u?=
 =?us-ascii?Q?dOi8GlPXO9PHsB9VS3qR48j34+VlDn+7x5IfWSGkSX5fL869NeCjeqihuD0d?=
 =?us-ascii?Q?4iZ+GKYrc4QrZX86nwx5fDLjz9CIzrXXvmvYj7yLxIgl2UBIIgNAfw21jAhM?=
 =?us-ascii?Q?gRyYQShILZ3nd/YX4iyOx8Hupc3JBZPs2jTca8MX3wC3vtKtVyNw5ftd/0oT?=
 =?us-ascii?Q?qQHXX8usxsOwea0W9uI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dba0077d-09dd-4aa7-7168-08dbf16880b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 05:52:14.0703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8zfDe2If62mCK8R1nMo1rcmhKCLklgbCo0vTU6Jrs8kDAsaSiCFRug1gqJR7HfXG+ujYhr2172+cfQDnfAi+A==
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
> <Mario.Limonciello@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Du,
> Xiaojian <Xiaojian.Du@amd.com>; Viresh Kumar <viresh.kumar@linaro.org>;
> Borislav Petkov <bp@alien8.de>; Oleksandr Natalenko
> <oleksandr@natalenko.name>; Meng, Li (Jassmine) <Li.Meng@amd.com>;
> Karny, Wyes <Wyes.Karny@amd.com>
> Subject: [PATCH V11 7/7] Documentation: introduce amd-pstate preferrd cor=
e
> mode kernel command line options
>
> amd-pstate driver support enable/disable preferred core.
> Default enabled on platforms supporting amd-pstate preferred core.
> Disable amd-pstate preferred core with
> "amd_prefcore=3Ddisable" added to the kernel command line.
>
> Signed-off-by: Meng Li <li.meng@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index 758bb25ea3e6..008bdfd63c22 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -363,6 +363,11 @@
>                         selects a performance level in this range and
> appropriate
>                         to the current workload.
>
> +     amd_prefcore=3D
> +                     [X86]
> +                     disable
> +                       Disable amd-pstate preferred core.
> +
>       amijoy.map=3D     [HW,JOY] Amiga joystick support
>                       Map of devices attached to JOY0DAT and JOY1DAT
>                       Format: <a>,<b>
> --
> 2.34.1

Reviewed-by: Perry Yuan < perry.yuan@amd.com>

