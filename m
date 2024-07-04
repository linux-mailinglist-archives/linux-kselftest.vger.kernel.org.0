Return-Path: <linux-kselftest+bounces-13150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B60C926D78
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 04:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EEFC1C2121D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 02:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F6B101EE;
	Thu,  4 Jul 2024 02:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q0utNq4F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A597B17BA0;
	Thu,  4 Jul 2024 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060413; cv=fail; b=mY5G669sofTlp6H4qdMQR5zR3tYeLTopKm0eKhuTxi8QNcYK9PT5J5NRGJTHpPNZefNlJkGQGF+Fvw1w8qm08ig1Pya4zMzmdbKZ2RS0FPl9yOkRlkxUR05zncLB+WwKjG2q44zMtn2Wl0lB6eVEVYNv+aKixR4O3rQA6VdYGo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060413; c=relaxed/simple;
	bh=fS0h2uo0gjsvRvhFJVYjz4AkAkxlJjbzDCaNBlB9SjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oT94l/4uJjjx0DBKhmy9h0ZBnWQBSEEEl5g/SDjMnuptnOpJ7bL4KhtF5LeWJuN2Oz91+O+HhghCWgbvQshe+tuXLZyX6YJ5OhP1KDocr/dgrwui0uiW+rmF62ZwDjZ2keGoYrbNEH4nlr7tMiDlEKf4OpPe1tKVePio4cbya0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q0utNq4F; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDKziM2hRVpQ6y2UelJfC1inikpBlz9U2Nv6Q6AMDi3xEOKrD+ARnzTmMGj2zoef9WErY7cSnJII7TZW3KGR/398wfHYQYQ/aAst8aHYdjOEp2XRaRU7NSSRcyFUzWfeI6SM/K5BA4VLTyy18GW8X5pjexEVfzEIWuObt/MorxFjid5BLOVFzpsqJV4W7nRWhRbODnIz7DKKFbMtVqt6ytiTzWYWHDlhwO0QlyH0ZC9RELUhRsw/K2PNw6LNm6KwUDIs+E4HioAVqQE/CEgMGgJRcNxpBsYLJDVYWbFI6uHf1rNazgJKQ2941myJJFIFVaOcKi49teq15foulw41fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcsnsD1pNMQuFrOynC4BFElE2hN2iFDFASMwNJ9NSK4=;
 b=d/fcMnbOUupiYarFbiM74zwSTfxHeWVGxRpYM4Q5fOQLHeWrvx14V+SWe+0sffWcM98/FMafO79UxGfB0ZMJJRnL3K2ftVaIYrebs4Dkpfdf/f6vECiR1dUqI3n8oCmln75P+KHjmnl+JiKec1lLXmm2+SL1zDq7T9wLPEqVxwg1GOl+sLcHUE1bdHc1u7PNODmZbKmqIc4ui9zOn0N6hrrIPh93bECHPiWYDfLK2KFYnkhe0Tvpl91r7RhR4xMXWU/j4I/xNz2A62LSFc3/gSyTNWgiwc137XQo2a7Z+ol7TaGPrrjHb/euScbEv8JloU/gr/f924y+wd5nkBBQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcsnsD1pNMQuFrOynC4BFElE2hN2iFDFASMwNJ9NSK4=;
 b=Q0utNq4FpmxhXQHYzRnM3E1xt5mwJziMaCbkAoNRelgSFC3/pNZzo/WXvKcQdwn6BqPbFcZrRw8jnVervJIXxMj36w7TMbrhtF1kucixQl98kQxb6953XEpoZQd0HSpl48xNwuIQvGkthZB18TUqETm7xLfExTmeMRSQ72a/uK6QzAfs6nDaXZB4t2f592p/RSKHwJk/BCCfb738Z04PqRdqrTx6xFYU2B2j27OolR1JoycXuBjNOwBLktPwpU0Bf4zfgVrRwW2mUKcuXLF2uAeZrljkAzq4Y60mOayKrRutoBL9FKkCIJam2KyTAYBgbtGIax+U3Qr2i2g+1wCIrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Thu, 4 Jul
 2024 02:33:26 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 02:33:26 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>,
	Carlos Llamas <cmllamas@google.com>,
	Edward Liaw <edliaw@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v4 1/3] selftests/vDSO: fix clang build errors and warnings
Date: Wed,  3 Jul 2024 19:33:22 -0700
Message-ID: <20240704023324.83564-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704023324.83564-1-jhubbard@nvidia.com>
References: <20240704023324.83564-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::43) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb0a3bf-5152-4e02-a00b-08dc9bd1aee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PHG1pf1LCPQH3PT11kAMebEgOQcZc5rVm+sVAVrHNzFOc3un7kPARAwv38aT?=
 =?us-ascii?Q?pJ82ZOmHHpyVLQS4MZ2Rztr3ujiLwZilNsS3m9F/7wJFCfaoWuGRDF9IcR5T?=
 =?us-ascii?Q?l9bjmNxYtpc94TkmiCiLd6b+86PB+e/C6b6q8TpahAxQNNCwtMRR0ewHo9Y6?=
 =?us-ascii?Q?otmx5/HXmWeAoiZIoq+rHzM36GjXs0w3m54+xK/BZ40k5CtyStTjRGqS1z5I?=
 =?us-ascii?Q?yYcpNUE5cBWaOreN08cp8iIheGP6kfUwjDBMUg6ji/4aZy8B77FKJDiXLELZ?=
 =?us-ascii?Q?+SNh055KW5LP8H03bhopv8bIDM2QISiSELMc8kYYmOoG/fOd0uOJmZwBUMVn?=
 =?us-ascii?Q?VhvSfradQ/v9RPKGhq3NBYk4Imca19qFpLQppfH6IWXt/MCNH7Nsl8Q0EgrK?=
 =?us-ascii?Q?oGHwYPCPyUBkoZbBeBm9uecFfFXzKUU01aEmroGgJ0WMybxbKQN5He+ehBB6?=
 =?us-ascii?Q?mRKsXSy9IVQcpUhb7OxULJ5g6sKrIAvBfxNKimN4vId1eaFzzWfgKI0Zv2jj?=
 =?us-ascii?Q?uN3imma+t9XJGe9cd9wx9ufiNOE0kFJJW+BZVJozELy72xkceYSrdQBVZRQQ?=
 =?us-ascii?Q?fCEvcw7ktkJWwnkvNSrC7fI45boBn7cLX61FiWkBaCrmW9TK0ldznCiV6msV?=
 =?us-ascii?Q?DsGV7rfXL8GHeb69872oVLwAbKPyhHiEagIgsF4+BUmqyyHwMIhsn4bxCgns?=
 =?us-ascii?Q?6A/aflLs5Dyo4UoZiTzK6Sp9acmNRNc6FhgvG5CNGclfyMr/kLmb2/yKJNeD?=
 =?us-ascii?Q?T2L47VUDO3RD3VtWxvuHrpGCunMoL8b05vZ+xpwVZ1LFUPs6ntpINv+wqmWt?=
 =?us-ascii?Q?qjotpnUaNYcXtxaLxsaBJWPthPqOnrtdswL3zh+3j63iD5mPFOuuP5Br6ZF+?=
 =?us-ascii?Q?jmvgH9V9e6LslS+O0IfuOODAn45AILoxn95o3UuDKbusOzaJhsxPJVmeMYSb?=
 =?us-ascii?Q?Lu+M83bDbPhZDns2vPWUJJb3XtZnLuC60Ns4T3Vz4B+YNbgKNdge6M4QhrK1?=
 =?us-ascii?Q?zAmdUbxFSq6+RaDfmUfc4i2ITHhG8SIWf47KeuO8y5iMpesWkVsRK0KYbo/P?=
 =?us-ascii?Q?leHj9n662Z6gXwfH6RzxwQ7v7wXboZ5ytz5UVeMgNnJqIH6BQzS5KXzYJlSd?=
 =?us-ascii?Q?R6MHnaPAoNPACRxZiPNjG0MnF178PRVnJ5dyLP7YOa9CIQgo+/f36DJ1N+Sa?=
 =?us-ascii?Q?eGDWN0H3a7JWIPpKYL8W5VwRL7dEK+CYORLsWetDG06tX/Jc52nlhR3WEmtX?=
 =?us-ascii?Q?WM7G+4oeITEXR2qlZyXySz3WxVrTL0F667pAFHWeWk2iMzcHodHk6b5GYL8A?=
 =?us-ascii?Q?Tk3cLRMpKAFkYUuHud8aemB/sR1svFnDke71O5ayM6OWug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gba02cOb1X+XCYn5zE8eZ+HinO0G3y2ZV/NQhmutrJ6ni2kDuAYJU3E8EvI3?=
 =?us-ascii?Q?7xTWIuPTBmzzIyltZ9KpKXy4WTGPFHXZqBhvcj4nwucdI8SKt64mtNfLV2g/?=
 =?us-ascii?Q?3Pa3jkWCaohuHybvixqIoADx+2126bFX92bE1hBv0tMS4ZdKG6UDAp6ZPxJj?=
 =?us-ascii?Q?uDSK2H3fFDxzi1t5tBDTlocalHG4MfSq3s3+8/bkw805uYGVyIIwlrfPVk0R?=
 =?us-ascii?Q?GltOaeoD7MRRl7iTgn+EBvlGxWqrXni29+cmD57E2/F0wYaoYj7t/DfIwzgv?=
 =?us-ascii?Q?wd3xQNr2ctdmWckBuX939OYQ26vz/+5sX1zeGhmyEaiPv6bYDUbXZCg2bYWH?=
 =?us-ascii?Q?gXzB1UYC5FU3f6CcAgeaWSSfyYchjIxA8TO3uVNNi6B/pP6H+uu/ht9c+Lbx?=
 =?us-ascii?Q?h2MbG22d6G+TI+/LsKaW+L/+Mrhm/BjxQuDdc5Xqu+UtyaKtUf1hJyhrMATz?=
 =?us-ascii?Q?+DRdS3kJxM2Kzh/urNlsbKG5YYLFqkr0vHfkBvRMPzbvJGIxN+CINjHOmTgJ?=
 =?us-ascii?Q?AqEY+L3UAxQPFN4ItJMW4zotQj1qQANj9DYDjcH/MObzI1j2pKoc8wqmc/tm?=
 =?us-ascii?Q?RTe7d9ohzC6vNwfhdoVa5qvkB98pwDUtS1SX8VM8U7ylM0LX5kuSGeM2wZ9e?=
 =?us-ascii?Q?mXqo23uAIn72o7J4FjzGeDdo/2JgtEosu0l/sa+vLbwbehPF+oOl84Uglbo1?=
 =?us-ascii?Q?LAiM+hDJnV9bOuwVeX1iBHmk3z+GQH9j8f3ow9C9etypx327LhD8S4qZWbe2?=
 =?us-ascii?Q?JOBVRAiG0TGFoOz/aEs5Xst+0A1MBAA9Nl1OsYfcO+BANkNPCFVKUMTGPBRd?=
 =?us-ascii?Q?j6KfO1/1DM1/q1//MMHflzd9r79FbmhGGU2YOtwaLCBVVb7OITcoe4wBrecU?=
 =?us-ascii?Q?or49rh+iWbcp66T9SWvvGDlvrRI8gDGVOrjtU/rTHkQ4jZWSUS0+HMIGk9u3?=
 =?us-ascii?Q?7I2JHccE5wPY1t6ysJTSY2NMSfA3gZFYkum8c8rK/6f1TCCjluUlOh5PEJRJ?=
 =?us-ascii?Q?mI+0TXvIOOIaVd27mqQIupfdcvXGOUpf2BAYUPHz1sIB0begI2JP3tg6rkHB?=
 =?us-ascii?Q?JJV4lAvDwm+1R+q6XgwfBizKH9BMzHJijvhkAglv4ozyAs1zvohCmyUYFwgZ?=
 =?us-ascii?Q?3NP16czxc/bZCYtg7YmoAeH9zT6VCOtVp+EJxR5BqA14fjbsqycFfJhPG13p?=
 =?us-ascii?Q?xb5ICGMr3UOooAssKO9qMGbLEkp9fs+3/jI+WP5m6Hjaq0OPWElQSLTX6iqp?=
 =?us-ascii?Q?C7dJoNjwv44HRpZSmtPkOPMt4oYV/KFbiiadDQnFgPNiI3GLNFXolgL0gSgc?=
 =?us-ascii?Q?a1Q4N1HEbOvCb7lTzNCxCbhJsHzm5vS2txoNYZGk/Xv1Ow6HVVmF/z8Sw/nH?=
 =?us-ascii?Q?oUH/K+cXLX86W3rkUOt7lbhiC9Ca/tgQTAGs6IVK69DyQMKxY8PTxYP3xJm8?=
 =?us-ascii?Q?nzu/Yzr4WPnIUaaXduFjkCwokrj6y/+Vq6UEK3aIk3mMNAmSpYY48SKr3TQk?=
 =?us-ascii?Q?/qhEFbiOelbwbTn0KfaOpNiIiInD6S0D22qYDtfMechYaVeLXc/jiJuU/IQB?=
 =?us-ascii?Q?QdYYTazIqbhsvuQq4or9BLzAtwc47Kz2+/ILTqW+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb0a3bf-5152-4e02-a00b-08dc9bd1aee0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 02:33:26.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgzsqicaIXAdgIsx/q2TrsitpdyIUtBICJPJkdMMjGWOa0yqBOLakTKkyBLaAszWr1OLKOKCSflqHie8fyO31w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...there are several warnings, and an error. This fixes all of those and
allows these tests to run and pass.

1. Fix linker error (undefined reference to memcpy) by providing a local
   version of memcpy.

2. clang complains about using this form:

    if (g = h & 0xf0000000)

...so factor out the assignment into a separate step.

3. The code is passing a signed const char* to elf_hash(), which expects
   a const unsigned char *. There are several callers, so fix this at
   the source by allowing the function to accept a signed argument, and
   then converting to unsigned operations, once inside the function.

4. clang doesn't have __attribute__((externally_visible)) and generates
   a warning to that effect. Fortunately, gcc 12 and gcc 13 do not seem
   to require that attribute in order to build, run and pass tests here,
   so remove it.

Reviewed-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Edward Liaw <edliaw@google.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vDSO/parse_vdso.c      | 16 +++++++++++-----
 .../selftests/vDSO/vdso_standalone_test_x86.c  | 18 ++++++++++++++++--
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 413f75620a35..4ae417372e9e 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -55,14 +55,20 @@ static struct vdso_info
 	ELF(Verdef) *verdef;
 } vdso_info;
 
-/* Straight from the ELF specification. */
-static unsigned long elf_hash(const unsigned char *name)
+/*
+ * Straight from the ELF specification...and then tweaked slightly, in order to
+ * avoid a few clang warnings.
+ */
+static unsigned long elf_hash(const char *name)
 {
 	unsigned long h = 0, g;
-	while (*name)
+	const unsigned char *uch_name = (const unsigned char *)name;
+
+	while (*uch_name)
 	{
-		h = (h << 4) + *name++;
-		if (g = h & 0xf0000000)
+		h = (h << 4) + *uch_name++;
+		g = h & 0xf0000000;
+		if (g)
 			h ^= g >> 24;
 		h &= ~g;
 	}
diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
index 8a44ff973ee1..27f6fdf11969 100644
--- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
+++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
@@ -18,7 +18,7 @@
 
 #include "parse_vdso.h"
 
-/* We need a libc functions... */
+/* We need some libc functions... */
 int strcmp(const char *a, const char *b)
 {
 	/* This implementation is buggy: it never returns -1. */
@@ -34,6 +34,20 @@ int strcmp(const char *a, const char *b)
 	return 0;
 }
 
+/*
+ * The clang build needs this, although gcc does not.
+ * Stolen from lib/string.c.
+ */
+void *memcpy(void *dest, const void *src, size_t count)
+{
+	char *tmp = dest;
+	const char *s = src;
+
+	while (count--)
+		*tmp++ = *s++;
+	return dest;
+}
+
 /* ...and two syscalls.  This is x86-specific. */
 static inline long x86_syscall3(long nr, long a0, long a1, long a2)
 {
@@ -70,7 +84,7 @@ void to_base10(char *lastdig, time_t n)
 	}
 }
 
-__attribute__((externally_visible)) void c_main(void **stack)
+void c_main(void **stack)
 {
 	/* Parse the stack */
 	long argc = (long)*stack;
-- 
2.45.2


