Return-Path: <linux-kselftest+bounces-11040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EBA8D690F
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B131C25414
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 18:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566C117D376;
	Fri, 31 May 2024 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ze6fU8bx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11EB17C23B;
	Fri, 31 May 2024 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717180686; cv=fail; b=TOG7uFOQBuaFbcHhQkBpwj07LJIg2/EYoue+iajiC3FtenxngSzEwebqaVqe/E4R/g0xzLwYfPIPvSe8ndJQbY0VAu11Kvwc1MOKaasGhmYn3JREQvhoYw2f8yqJmfHvqrRjLmaCBZnUUWUVH8o99bEKLOBbXphlL3I/uqt+kDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717180686; c=relaxed/simple;
	bh=DIhwsKVgYBpxueJvHkM+NRBBDTBGnoZiOvZeZ54nxaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=djqmRyKP7dsp4eeYoHRs29SKXiCgXfi2/HzYiQYJfLh0VIY4PtephuQFDpeq37cIpKm4EsH7lyqo1yIk10a0WEtg9MaXULKN0f91z0uo+G2NVqZBE0mg615lYs4Oa8ec566ABJdEddzH0xOaSWONbp3uYNDcSqA62TcTTdOQ5Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ze6fU8bx; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQp6FIT8wRwv7WOWkRuX/3UdCsQQ1+L678mPkPa+6e59m5jD8PW7rsN66TC9or6ZoKZutrxY7oTeX40cDQS99j1Mo5GDfZXz+KmeoHS3xsgEeGHLlNr727g6n0D2N1Tpm1tIrt/HQOhQsZHr3QysrAc/vp+nDq8MPTeqRSciA3aVTDvVkYJeGWXLCyGLye2PGm9uaRP5OCRfPF0bR/6J8CMA1vGa0r0WBrmLE4i6uEC9IN18d48ZspPX6+qGqdbWrIQxiF/1JWp4mmEFVbw4pCkTbTCKkfhOeLDPbCzGhGLTXXCIkyj1JRnUAajX9+d1MFIsVXz8YKWOpJWV0He5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zq87mtnFUsXcFEG/fBM5MQrx+9iKtQ9bsuRba9PzrI=;
 b=KypHE6CJrC8MfIdjQTQFsNS0keYqQUg9TQWf/bEwPaa6v+J/DcCB+9f6m2cEYLkMucW5wa/Q3rseHeZB+KQIOcTH5UIgZsfsBDBswHN3ATAsDTkuPf3WHrjqaVNU2L+WGFCQyhOW+QRJ1BrSrC2RcgU3yMTTd6PsNuh4CeDsMOsk2qAZh9p8MtvfIIkDIBtEPw46B2/jB618dnypbEgCOh6y/Ehh4a2kvokd/Qpw8BZb8k9cGJR7978Ki8ejQXS7lX4s/0mGkA/EnLm8m8TFab+yOp7vaPEDTi3JQFOiC4kZpJqB35T/pLAP0ha3FU4CIre+DpuZJmvzg4cTk/Id0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zq87mtnFUsXcFEG/fBM5MQrx+9iKtQ9bsuRba9PzrI=;
 b=Ze6fU8bxQhhQyd43zsmFVjp/kErPxNWg1TaacNFGtp25MBCVS8GnsyZi8A9WOjQgOIrdxLKigEWyXWAiGKmwzXArVs6FWBrUF84cbwAD/qH7dSk9Cf9f2/0t2Gn9UuF0y4XXgQ1UK9VXoctPapmYoip1tLwjnSZ4z+7dLIbHEF39UsknE7vJWKXoH6Schy8N3nzJzhZJ9T3YJMmLjED1xx6ocmS0NlXS2uCDvunVEIk0KeszoziOJvG+rccYSgS7NPJgpd/C3sVHsV93mEt7i4ZZdlhScInYs9MiZHsqHOSFBnUKi2puiRxoD76puuIP10p48NS2jkhVOkxV/3zBpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 18:37:57 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 18:37:57 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Bill Wendling <morbo@google.com>,
	sunliming <sunliming@kylinos.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 2/2] selftests/lib.mk: silence some clang warnings that gcc already ignores
Date: Fri, 31 May 2024 11:37:51 -0700
Message-ID: <20240531183751.100541-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531183751.100541-1-jhubbard@nvidia.com>
References: <20240531183751.100541-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::21) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd71373-ff43-4076-b722-08dc81a0ca87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3pRhIEG1CYfUUSAe8lHwAymgdIzUZYIpL0X91tFZ02USPoF7qKtf1WcXf4T2?=
 =?us-ascii?Q?/x+y4juqMV6rdP7vgcXYP2BJFkyjZZq/23NvMViB14KhNPnmqbsasL/yBwTJ?=
 =?us-ascii?Q?FI19fb0O9EzNvTtBt8sZ558qlZ0cA20Uj4YP4hdVeNuxQQ5ZGko89/oM40/J?=
 =?us-ascii?Q?hJNpZCcQuaVanysJ7LvjDXoiAChbASrJUUhXTMOpdWGWwuqyhXpT0LDTYl2o?=
 =?us-ascii?Q?dj05bqa087oI+JHzjqsca4XsGZm2K6rxKYwhjepWtO3p69RbWGmQWgjzuUA6?=
 =?us-ascii?Q?Xrqf3nuWvH2vFKQPLpVhzinV/qctgEcbbFJ639EuaB+hSdZqyQvm0YLJO/Wa?=
 =?us-ascii?Q?eFoB5oPvBhCS3SUNEwPkx0IHncswaj+v+hLjQrE/ai+AFtgNIoV5tLNF2ODJ?=
 =?us-ascii?Q?M/7dBiDpUEMsdjAsVce6NcuEMwljbRN9By/ia0fbCFfqLwapb0APQThzLQDG?=
 =?us-ascii?Q?smCFgXjRM/yhrIl6itSn8W6odoKX9GQ34uavhLueg/sLT59BDHrYg/e6D+C7?=
 =?us-ascii?Q?w3Gl8MVOXsEQmIDAxISI8VkMSwWzQ8J52qwksYmawrMuM/+IYIn1p/1F7Wxx?=
 =?us-ascii?Q?j5+EDo6O2mcdtOn/3mDVZi7RajrOd3m8loJoPkG0Nbmzpcj16w0LvQoEStzu?=
 =?us-ascii?Q?2elDwLj7CHJsrlbxRbKbCLe3DcslBpxO8LoB81IcuJ/qFTZBXeNOtRHybg8c?=
 =?us-ascii?Q?Gt4SIMSBccPsueIuJ0XiTuPKvOCndZeqwxTYCqh5haRIsti/GiEL3X0Vz26b?=
 =?us-ascii?Q?NSNb9OV0cRw06C+Jz3v0v7qpi4BBw1gmbIOe/iSjj6ggGdbR8oBBRGIgA8QW?=
 =?us-ascii?Q?BVrCHLeRRo17IhjMOw5NPuHepBiTXwigm+D+/p6AnGnmh2tvyHXG8r2cziXG?=
 =?us-ascii?Q?cIWmdrhjHGi/+otTSFaq2+SnoVlU5hGHTcCcxoIQ7EBYB24/kLkGy0l2IPXJ?=
 =?us-ascii?Q?dVDT7JbTY1lIwB+Ae2aYXeFJzNFuieLSmzJreAYcbQrnEzVAfD4Ks9lUJMAF?=
 =?us-ascii?Q?7mw/5iVFapJ7NQ3hh0MJvykQpSZYFiVQif6GEA05lohC9+wy9VSmhPBMThpk?=
 =?us-ascii?Q?2jTk8xuVR9ODTabSwZUj+wp1vMw8lDfOPFcLGdJn5v3nb6Oilpzla/7uZxNX?=
 =?us-ascii?Q?DHJH0RdLfUVSLZOjCW8fMQ7nX+XwifVR5z9u870JwRGcRhiJzQNM4PNqA+/N?=
 =?us-ascii?Q?JCHfhVYH2Y6fLYneZYlAFHKpmyMeBXhSywYysrys4EwrPALSotXbWXbDfTqN?=
 =?us-ascii?Q?hysUb2lppJCmGypsgGyN2ukVLo1VOtb9dJuJxxlqVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ojMyj70feVHdbB1/O4J/zwJyQStcR4otvioygq+UvgbYrxWz1RN69kz1pHvi?=
 =?us-ascii?Q?6QSodPLBH3kvGlE2IDA5sOWoULImEPsFzqJ0ZxF9crffvQ7gjwffgweVHvcE?=
 =?us-ascii?Q?1A09TmWGdWH/W+m+Hc6h5pzbX3FW41ZO0yQ3ugcRfrEPewod86a45aEIq5mt?=
 =?us-ascii?Q?EPDbtDjbndoH7LkplrVWw2GvymM+SnkpSeFF0vRB5cJEeNvuul2PpAdwBQyH?=
 =?us-ascii?Q?VRY3DBQQObMSwMfvfkVFp4x+X8yO5o4VW4S0WAkGoIySijJsyNlOlJnWrlCs?=
 =?us-ascii?Q?lJ/zG2iz1+jTAKFSBucu8AeqItpqVN77crNsPGSLuKu5xmlImicchDMVCgpX?=
 =?us-ascii?Q?0lFb6cLhp6A0QPIDsmfPM+eSIrdMa4qerEjVSF8Z5ehgQLOnaxrkRMmq3Mtj?=
 =?us-ascii?Q?3Mx71EjOb91zBmNjqNOxw/46ah4vZcgwMoyhH45aTfXS8yszwNDyLpv9yscW?=
 =?us-ascii?Q?1n4ZrdDwwVFW5ZqPBaN7NCpPG88cfGGhHU8tOEJSZg71mRsvMUDDlsf1St6d?=
 =?us-ascii?Q?W4z4MIlEup9StADhmoy3l9YRCE3/zsOG56GkavOW17goR2Mi9R7ugnh8ATiu?=
 =?us-ascii?Q?54eNe8D8+gshZXLVa6JfWvUbqG2vcyanKyptjqO97qmu4bYNRaxpo+IweNj7?=
 =?us-ascii?Q?kMUyAJeopdlz3NuASFYVJxdTvUip3Zi66V1yxNDHRadSpzuyvLAFHj4GQzgv?=
 =?us-ascii?Q?eOkUiovHGYV8ulQ5T/oVWk9indj+U8spdpr8bEKQKPnRS+ewZ3dNW2m8G5HL?=
 =?us-ascii?Q?01gVhxEvPFxEpuOBqenljemlLuA+h3N0GBfQhcTKdNX69laZdp6nKWFjocZj?=
 =?us-ascii?Q?PpRJM0u9J5Dx8jSfhcxdKnJzpUFMTfHqi8LrIiC2V6Uob/2nlvTWlvy8ng3v?=
 =?us-ascii?Q?CJFw72A7VEbzOP7VVeUNd2786BnHltVDTxnOgjhIiBx2eKGaljbG34nbegMP?=
 =?us-ascii?Q?jWGzs8BEerUk9Gfk1XcXEBAmfXLXEldrzqmDV9Gl0J3EOYe+8pC/qC48ppzq?=
 =?us-ascii?Q?OMA+8PJ2S6O/hkP6YTbSA3RsMjsYx4YyUAr2BwJ4IYfEh3sBBLKe2+7J4d/Q?=
 =?us-ascii?Q?b63FrYMI9W/BZyPvpK1Agah7hoG+faeHwjAOBw5/BSr2jj+GwZ7zz3iX8zet?=
 =?us-ascii?Q?Nt8lWvTwyJOtmv6OkesBLdwlQsWDFmKExxYwmLTpHVzwjM6v/Lw/xeU1Mzu2?=
 =?us-ascii?Q?sfFqtAZcEXSDwW1ZWa/72lh7YAZm1Lt/HeTyuf4ZnlOomcmhzvqdf4wQlAD1?=
 =?us-ascii?Q?lEwv0k8FVLkEYGmMf3pC3yVH5Mjkv9MxBmWxX8XHeOfTiLwZiUhhdhNvs+1n?=
 =?us-ascii?Q?Fg+TXHhiUdrWKBGCrPxwg3OIjI9Ekz03Wv9K1IvXNx3O2u2UOb0YMNR0wz8f?=
 =?us-ascii?Q?2gZ/WgwFFUoEylC+2BMIS6gtdm67mQK3XRY4m2W/dw1sPpVucZLYztvJczSP?=
 =?us-ascii?Q?LrzBMc5Ob2hv8+AFb5C8YY/MidrVPNQx06QYpl40T49ydELoFdZ4EM+Di9yr?=
 =?us-ascii?Q?hf1/4uw9e1uQ/u3St2dHmQ3EcRZ5Mxh1POgdwF7Utk27KJi7pKToH4QH6+aA?=
 =?us-ascii?Q?tRY/CtCiG3s27Pq3Y/vqCUp+jSt/TAKGyrMCtv2D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd71373-ff43-4076-b722-08dc81a0ca87
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 18:37:57.3203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7t0BUYoRnOnJOz86VuT07Zc6YwRWpgUNzEoW3ta9h3xJmdcGIAOPXECGkeH42sD7YJSCNBcL1TN+jQQY+PTEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207

gcc defaults to silence (off) for the following warnings, but clang
defaults to the opposite. The warnings are not useful for the kernel
itself, which is why they have remained disabled in gcc for the main
kernel build. And it is only due to including kernel data structures in
the selftests, that we get the warnings from clang.

    -Waddress-of-packed-member
    -Wgnu-variable-sized-type-not-at-end

In other words, the warnings are not unique to the selftests: there is
nothing that the selftests' code does that triggers these warnings,
other than the act of including the kernel's data structures. Therefore,
silence them for the clang builds as well.

This eliminates warnings for the net/ and user_events/ kselftest
subsystems, in these files:

    ./net/af_unix/scm_rights.c
    ./net/timestamping.c
    ./net/ipsec.c
    ./user_events/perf_test.c

Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/lib.mk | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 2902787b89b2..c179c02281e9 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -50,6 +50,14 @@ else
 CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif # CROSS_COMPILE
 
+# gcc defaults to silence (off) for the following warnings, but clang defaults
+# to the opposite. The warnings are not useful for the kernel itself, which is
+# why they have remained disabled in gcc for the main kernel build. And it is
+# only due to including kernel data structures in the selftests, that we get the
+# warnings from clang. Therefore, disable the warnings for clang builds.
+CFLAGS += -Wno-address-of-packed-member
+CFLAGS += -Wno-gnu-variable-sized-type-not-at-end
+
 CC := $(CLANG) $(CLANG_FLAGS) -fintegrated-as
 else
 CC := $(CROSS_COMPILE)gcc
-- 
2.45.1


