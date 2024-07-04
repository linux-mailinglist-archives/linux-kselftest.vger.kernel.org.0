Return-Path: <linux-kselftest+bounces-13152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180B4926D7C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 04:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBF71C213E1
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 02:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A31617C6C;
	Thu,  4 Jul 2024 02:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OSJijCtK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96846171AA;
	Thu,  4 Jul 2024 02:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060417; cv=fail; b=H2qMNB9JrckPR0kYpR7Pwrcz3YZ4kFOEQ9JCt9jiybaa57Uo99zYD2jVVEkzNHttl8Iquqg/CHjsL3uSqfhKX9XJaj4V9N7vQmxNXLOYtc7eguNP3wYMiQ999xq1C24SvEACRFKoKYGBSu1JLpoPhJ71EqLbS6YdgFfSztwDHvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060417; c=relaxed/simple;
	bh=xz+IbFEVQi1i2+B3MIak2OoiRYbFH6kWotXqPDhvOEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mTwTmv5p+K0GeAWoXTGInzFMFtFHJzY0Zgu65hSMPm3UWNGzGFplsvmvwVlzJBVKyr1vIEuPuEu+wNLyl5xCEKqhwAaIkHFYhsHeGcWmEUadThNhbJxXnIg0MgiSdtuC0o5iOcImBiG0BzAWwVR08lOUq80vghIjbtfRpGU1A50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OSJijCtK; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAGWy4SS9/EfRrtZctzlbpD8jwsG0KDJ8tXrh3+BKycLgNuN4w3nURym2zlgKVEwgcd11JIForzGVBM9O/PdnuXpaxuv8xsMt6E6hVUqoatUp6HuRzFBSQ5anSLyZi3zMGMO+17NbVARLGXI+t2i68PDuuVz/DD0hrmKrt7bG91xNQbzqXUGjFrFGT8mWQJs/C3xL+UvS8qM5DYgdEhRNibj44mQKLBkFQ95WcaVNR4kPAhMSrGEn3GR4IIk153PkJrU4G7Pf43flP4sYTAVCxt6krzvCrq5oLW2BgsqT/seFRFOv+E1HeqErpcbHlauFntYXaBqYQgJxVD1YnXT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4L7Mdw7LkQKm8VHtcpcip7zoUkVQc9BeISjiGBJ6DUM=;
 b=OxRvmN7/6KBnS5Iifm4/PaDd/SLBrobEGKFYrzvKMKT2oYZVQ7Bj4Tdx5BvxlruP/hN237sFD8nC6iUlT25kZxaUWsQj20p7JOmz6AFlTWroXTM+G6BTnx0/QRvhCOqGP3H4u93TZzx9A0LY/y+mBAQXr4oIROuy0cxiImbYJBPSrxU3CSuCziksVfXUl5iR5OB7WZyc0RXvqL6Cs9iNhEcDRYgscxvYytDEMp9w831NQGFm72MChtbKvNDT3LslNugNTTsSla9AlOLeGmjLRSeVYEw1IzpwprFEFsYOnTEI7rYPJSXe7g3zIBalQrRjDDHpLgUjBMelGiHj3O285w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4L7Mdw7LkQKm8VHtcpcip7zoUkVQc9BeISjiGBJ6DUM=;
 b=OSJijCtKvWsF2mI7b87LE09bEFmSuySx2RSErzWzFacn9kfGBGdm573KTUl0Uiil2wPs5QTBD4MSVZE2BIFo9BJlKvBS15Pro6oKjPrzEFVFiLbJ5ZzKbIaX5mxahNu/uV4JCJ/R2DEgocYrxkRZpNhUViPiL+Vuu8Skp4kA8fAH+hCsuSwdEt7y/3IivluajSMntrqSbuFCrdis5AYwmg0Kje5xVD6EsR7Taq9+ROx4HVjT+xOkO7sMbnVWxZMkGry1SYxgv7jgaarIDEtHvujdiluueGK31gL/TgoSoR5c6h1H3AFQf2+sccRttbAldEao6ROMUpWgyOjm8FRAsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Thu, 4 Jul
 2024 02:33:27 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 02:33:27 +0000
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
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 2/3] selftests/mm: remove partially duplicated "all:" target in Makefile
Date: Wed,  3 Jul 2024 19:33:23 -0700
Message-ID: <20240704023324.83564-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704023324.83564-1-jhubbard@nvidia.com>
References: <20240704023324.83564-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:a03:114::18) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be302a2-f947-430e-ebae-08dc9bd1af4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LVhFB6kvDBQ51brxZezidwsYWviLmz2SWjG1XE+f+vzo0qRbfPhrJ/FnKi/H?=
 =?us-ascii?Q?fN0a4qDM4DfNMZUPgokEUTSIRjEwggCbQ2t59oktQ1YrS4KgZbWKJBF9LF7f?=
 =?us-ascii?Q?alPlli5qFYXW1b2phfWX0MaYt9L4Y8nlHQz5vDuPZMLhdi6X27BzQUJHQMTh?=
 =?us-ascii?Q?2H9cIaJQxur/c4/iAVnBGILjlnLtFV4K0nE0DybI06G4rqNL3Kjo6aCJnQHH?=
 =?us-ascii?Q?pxTyCvU1hrQHIPXydEMEpr7kHr9CJglGLZJ2mHiguDAwl01PwpF6qCWfFM8M?=
 =?us-ascii?Q?wiN+1NspQ6YqWrwoAanF/qlwtsMsx6GDWdYxaZxRNAeXD1bbbaigCnFS4DYB?=
 =?us-ascii?Q?/Untb4FK11IwA+DGxXO3gVd5MDTWYFd3eLmo3uvQQfLYSF+GRgtAcGJN0UJr?=
 =?us-ascii?Q?KVeO0pFDqHcx+iwDV8hvO/C3mudlNC6pjhlqfWK64iHbDDzkGNuo/jVERVFb?=
 =?us-ascii?Q?9ZziWLWk9BlvH8lZ2j91QSdqA6a4BdUXpvHvsQqiFuciL/XIssE5Wv1/U9MT?=
 =?us-ascii?Q?4hvLI0eMFD7Z80D4QB84Uv9Ie50q+upyTmvYCJi1dDcKAxPXKde+2ERoDILZ?=
 =?us-ascii?Q?qrIZQ6S5gDVvtSapc6X4fIbc8m14OIlH7f5WnRQm7aFd1kEyset+1FbRcV2/?=
 =?us-ascii?Q?4v5t9I2aCL0VPDWO5hLOSRXnWWJQ3qhcWXVXKbjFtXuDhSr4p0SZ9d1Tm/wH?=
 =?us-ascii?Q?6M7QU4H/0Fbs+hn0N4Yn59c6VJPTJ12H97VhzWUCkmkA9v7+qzFW56gCvatX?=
 =?us-ascii?Q?ZqMpPkDZCwckkJ4mkrYQizWnjIKR92mo3epWn9yfdboQq1OeWpGiGVw/jnXh?=
 =?us-ascii?Q?34fe8FaiWcStLdLVtRSzVU853oVFrmlklrVMDIogEEDYEUJElrrcTjQyQjz6?=
 =?us-ascii?Q?Z9hUX2isrj7ojS5FnNh2vmjUTuKFPgwxH1KHy1F2ld38LuY+ahHZmiFmya0L?=
 =?us-ascii?Q?7f/4kng4oAONYTYEky9UrdsmYEkQu1WkdWq+uGs6/1rHWSj73oPEd/puAwnR?=
 =?us-ascii?Q?o+smfe05Q9SyGP9SO7oyQ9JQij4+Mw4oEWVksv8qp5eLm+qOIYP7dVsezsZh?=
 =?us-ascii?Q?ncMyeYKdM7wHMUb/7t8ayxbHyQzvqK540WocsRJUb8auGL6stqrAuM+w+gCc?=
 =?us-ascii?Q?2VyLdAZj7WdajsXWXitsNQa88yUA2lBKVM4gK8tK7g17ZzZ3UmmlhO8iqzMc?=
 =?us-ascii?Q?w3+SetWyIytwwdR9GOpkirytzTJFrzVyG57J1TdbkEFK84gs8p/2kAiqbh+q?=
 =?us-ascii?Q?Tyo4AH8SRvc/PjYQP5A9mATkS12OPt0WmmRdjKj6GITW0BPe5CL47ERv12qO?=
 =?us-ascii?Q?8h2k+ZLkMfBF8y3SaZ6gxyz8FpDh+WMW/Mc/egWsfTQeww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O28h3ASWVR7X8YVCOu8kmYNC/F0NBgmnrP/atHP+l4JTa1i634ggCKjewXoH?=
 =?us-ascii?Q?tfWo+A0TCk37t5Atog72/USt4oe/CO0yFvVuEPNToN9w8cNqvPscgnMZzRM0?=
 =?us-ascii?Q?7Fz/uIj66j93I0NvDYNz9y0If+Nf9y4eNXmONgEW8HLv/e2K0e9u8VqEkK+7?=
 =?us-ascii?Q?nxGQIH2re9sIVsr8a/lqAtQXbA3EhXjrgpHthvVcKtEA+whEV2D069HmYidl?=
 =?us-ascii?Q?ymKKD6nxmkSvAod3BCC4C2os3q5tDVlESMeDKgkRV2QFFV0PuvUYon96k8Rh?=
 =?us-ascii?Q?Gwv9ru68CjXCrlwR2CJpe/GQTo4/8xSeEUW+y6C7B960yngQ5TkzI1wNAOoR?=
 =?us-ascii?Q?NNgRj51tjnQecgkNG9xN6GOp+ZHVKl5Cf9IPw4OqBXO8vRMd6VBxjC1KsvV/?=
 =?us-ascii?Q?YXDrH4bx0X3Q61gtZz0aWH9jikufPWr4L+VTZPvtKy49GyGK3hsS1cNQI0eV?=
 =?us-ascii?Q?AjMVRSh4QOd+GKJ9oEYz+zxOm3KhM4qWpXJpWx4AWxImTIi2IZH67bT5Oald?=
 =?us-ascii?Q?ter2Jw4hT14rnrZlrM0j3OV1o4vchGi4qmuDHls6YT7eVauSeuF7j7JnWhvf?=
 =?us-ascii?Q?C2oWVB6cE2gIvMLbmOaPeo1KN/1hP5N8M4/F2O0aP451CfaNAUhm/jhmWb69?=
 =?us-ascii?Q?YBYCNhHzhqOXfNATxQXQoO0VgsOCIcLzclwypZobAFb27PWwCxl+3ygp/7Y3?=
 =?us-ascii?Q?wcqOgLpJVs12K6AowhI5LrS5wPLA08XQpyFrfMPqZPAIfVxu4by1S8+4rK//?=
 =?us-ascii?Q?ks4/NNJJvllj6zloBLmQaEUE93SIwJke9Bg299M7F5+Wh1fJrZwIG6L2WMt/?=
 =?us-ascii?Q?rynKqxUyCA1YbMYyCXMwSQNZ4PrjT8Dveam+zqRUEr8n/+AIHV7VMtZHLQ14?=
 =?us-ascii?Q?iKFU8DStK2aWLLGLMgWCnKCZPQFrSO9WtX/p+dJY9WOHYMKXNt8x2s6T+o86?=
 =?us-ascii?Q?te9oX6zG0Qz8cKXVG1GugZuC8Qq7GSgut4bI9GQy8Mm912g6bkrfuruzL8cb?=
 =?us-ascii?Q?TEjUccvwdeq6IKg2hV/LHOtg7GFgdkgbzCNgOCUkczSJmrnRTMpehSrw8TV6?=
 =?us-ascii?Q?Nm9q1ufE1MpJ7KbEKCfaiayHDZestsaWecYfbHyPp4Knj6g9uUCN/cqDCNfO?=
 =?us-ascii?Q?ZiIE4AmUaYJhmRk3suk47xRVHPwFxqckpmcElJar3fbra9CEahaztccU15V3?=
 =?us-ascii?Q?Q4KyLdke2Rm1xgKWUulhd8fKGAwSL4IYYz0d1HKaJB6unw4h828LmZQA1EE6?=
 =?us-ascii?Q?w25amFXryaP8MRUD7aomE/+FyfvocevtSpZXTkUZYpniHo6PNBg6pz9SAvC9?=
 =?us-ascii?Q?VAzrFSTmAXSaU1ZGaJbVyyi7S7U6olm538RtKGBDr2AfNTC+GKmwu4tJ4mxu?=
 =?us-ascii?Q?1eJU2bWmXf+veG23lhpNh9JCF6MeSWP6vdoduY8+1AB54xSu1pbx5cgGTLNb?=
 =?us-ascii?Q?O7FoG4SwjctbdXSGmyJ0jXRFIy8QubarHMbCuhnMKPdMnb4R2wi73QKiNm4+?=
 =?us-ascii?Q?V8sjAD2gwdubIOjXtk5Ns4W7TzmoAeWZrk3xPDmoL2nKu9mKUxkWXybJ3lrH?=
 =?us-ascii?Q?K+Vu6sp0YF/P37IXqSxeyxOHm4SJ1ukKbXCGA7I1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be302a2-f947-430e-ebae-08dc9bd1af4e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 02:33:27.2304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //NpkWfgrE2g+p5TuKFh1Hr1AHwQeG3PsTUHy38nMcVwhueB8Y+6NxNOnTWiFUGMP3CsvFfddzsHWWcKiL0TrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775

There were a couple of errors here:

1. TEST_GEN_PROGS was incorrectly prepending $(OUTPUT) to each program
to be built. However, lib.mk already does that because it assumes "bare"
program names are passed in, so this ended up creating
$(OUTPUT)/$(OUTPUT)/file.c, which of course won't work as intended.

2. lib.mk was included before TEST_GEN_PROGS was set, which led to
lib.mk's "all:" target not seeing anything to rebuild.

So nothing worked, which caused the author to force things by creating
an "all:" target locally--while still including ../lib.mk.

Fix all of this by including ../lib.mk at the right place, and removing
the $(OUTPUT) prefix to the programs to be built, and removing the
duplicate "all:" target.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vDSO/Makefile | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index d53a4d8008f9..209ede5de208 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -1,16 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
-include ../lib.mk
-
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
-TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday $(OUTPUT)/vdso_test_getcpu
-TEST_GEN_PROGS += $(OUTPUT)/vdso_test_abi
-TEST_GEN_PROGS += $(OUTPUT)/vdso_test_clock_getres
+TEST_GEN_PROGS := vdso_test_gettimeofday
+TEST_GEN_PROGS += vdso_test_getcpu
+TEST_GEN_PROGS += vdso_test_abi
+TEST_GEN_PROGS += vdso_test_clock_getres
 ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
-TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
+TEST_GEN_PROGS += vdso_standalone_test_x86
 endif
-TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
+TEST_GEN_PROGS += vdso_test_correctness
 
 CFLAGS := -std=gnu99
 CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
@@ -19,7 +18,7 @@ ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
 endif
 
-all: $(TEST_GEN_PROGS)
+include ../lib.mk
 $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
-- 
2.45.2


