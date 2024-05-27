Return-Path: <linux-kselftest+bounces-10751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 332B68D0FA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 23:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C3A1C215D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 21:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BD34642D;
	Mon, 27 May 2024 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FsO42aFt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47E179A8;
	Mon, 27 May 2024 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716846453; cv=fail; b=tVcghrR6ESOl2DCz6zu6dxx/F9hbzNiZ/sGk93ZxmJginrjtWbECGyRyPWeuGmm3Kfbm8ZriqKaJGsusaBlANmsg94S98ccB2MqOgn2+hZ5P9jzOgM4L4uXBpB4BZdKtdpHOyUC/gkbdrWumnuv93LBvqI3okJGtMxgbV+OLAF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716846453; c=relaxed/simple;
	bh=qBaC1q3YXJUrQKcuFKKRQEwUwWPbYAl2olYHZnHzR+c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SrcyzMOyBqdBkdq+c9umhL4awl1h8Jnz2hl27e3L6QkDn6zp3cfpJ4cR35vkioYPwgF28HWB+zBbWT3KhhEIgXqSoebzswqCKs/1dT8Oli/kY6i7RfrRe893V7e+2ygR5B2k7DR1g33bKQHL+0r6bX+YXJskVICSs0YJOHbYU0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FsO42aFt; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kf8ddbXFqWB8UKQ0lvcXjib2bwpWGT8qfviWONXSPXV3N8X4Fzc4pMSSDFrLmx3TPvsL7RMQ9f5fMgNAziRV4l5Pj64p/EuHnAIMPw12hDd5QCHNiVClc1WW8yQ6mNzYh/23pcIIeC2Cee3PE24AUrpMc7iGnsk7Jwk7aU3vtUujv6QoBU/3FfkJBSeYLkpNYztln+8De1YWdb2NRXFn7XiuVZtI/hgCNONV7nRNbfbGQ/x7O3ypcIA4R6hoo5k1+wHKu3DkBRVrZHI+hNwtQYhqadG+cZmIdJCcOFx/Va9WryeOfftx2ck0m9x/O1/K8MT0Ls/FcQq10jZiU63o/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4qVoQr0un2mWR9QkXloxNDP3qrlyqvuGO2Y3z72NmU=;
 b=kWViYjYJzmSbdWBCO1WbWjf88X/afgI2RmnD3ajVXXyi17ucFBrTSn3NcXNNIxcfmch7hM50eL4LnLy5CEoxFrdtkfvqm2uMpK8KVrYOb9DPtJHXyAv+N7JcqxnDTh65FBPEnLymdfV/BRMogwlcpeLcmxHCbEV7oh6oBnwxPPfnT7LkwafkZzTrnBKbfxk+wpFXDmr866iiqt+IFEKKBqoUgGNG2FaxXkou4S3CxWerRJlECRGW0ahaQdqTCzru7OwiN74vB0JkqAllE5bU6LAnq6SD84NdkrxHgTkoZnTQQ08/v6WBNdZ6sNj4A3+TsWSe9/gNRdrUGeX6/3KRgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4qVoQr0un2mWR9QkXloxNDP3qrlyqvuGO2Y3z72NmU=;
 b=FsO42aFtzotVE73hBPAEk0uiLdwH+n4Wy0poYFoAt9c87rE5VRfhpQR7NMulgnCpzZYddBTbT/pc9M7Y+8RSEoQEzYfgDII1TcZhlSPNptpkLVC8sf4WMa+8rRhcSW2LG8X1fxItkUBtSjXL04JW5m8GITvdwRetV2JaawF6kpM14MSTgqkm/w3s5DJGUQ8NQAkir2A6pe6gUyISVk6aBMrt1XE3Bl3Tn6ruLveO3AgxeXyhhK0XZwv67mCNFhDz/DXWM1s62MnFuHzzd+ED0zx7/YSUfLVU8k/AIfCBhk9CSlhDIICGIYF0min0LgvHhB1FXLU3Scl/Jp1ASbH/FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 21:47:27 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Mon, 27 May 2024
 21:47:27 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	sunliming <sunliming@kylinos.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2] selftests/user_events: silence a clang warning: address of packed member
Date: Mon, 27 May 2024 14:47:04 -0700
Message-ID: <20240527214704.300444-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::12) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 17694fca-8c59-4582-a179-08dc7e9699d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x+JGId/vBcpAA/ccmffbNzCGTcN50WHT+XmzFWopgnw12JUd/68rKt2iLxUg?=
 =?us-ascii?Q?xIt5g1zj6g9/RjqdILTQKCeprePcDfs6lRWrjG8BoPzYYTP2WACCVagEFUVM?=
 =?us-ascii?Q?UrF+DXQD3cgvJmR1EGIqC36bWjmUVHvUaw/fimU3MmSAQsvMwiRJpnkCV/y0?=
 =?us-ascii?Q?jNLVsLh/v44uOhZFYG4ZEZCTUaZhBzvrQVJvtLb5EksMvV5Fc7C0s25PNFxN?=
 =?us-ascii?Q?xo/B4pz7zxFk4ZuN8WLEVNo04KCB1MfrwiNcScy3EHMqLvP2ainA7UORB66S?=
 =?us-ascii?Q?LxvEiQMc7ql/dPHe9DMdGUEHNfvlRQde+kwKOuA7lLHewoEa/vy8zDq9LRPb?=
 =?us-ascii?Q?4ROli8IQjN1p9otwEHXhz7PEc89GAn5OeJC3qwcuMylILEoyXZXs+EpGMIV4?=
 =?us-ascii?Q?mgfYX8U86HI5Ke1yqjQ247L5i5+NWji+g2XH3SpF6pFXXCqyJJE4UXP5bIUS?=
 =?us-ascii?Q?hv2EwkCr0YtokANJxW2TqO2MuuBn0kaiXvkMRQ+dRn/2PT1chk+lIB9aa/xO?=
 =?us-ascii?Q?J5tLHsPzu/SQA882VB47J8l5lkWBNiZF/ZJZ9vSS94mc9jhhgY+7Bb2NimE2?=
 =?us-ascii?Q?79k3OZJubs/dZkW6c0meN5CC1RFoSxZX0LFWAC2UaW8f4MbHKEXRivF13wvX?=
 =?us-ascii?Q?dijPRuqjhBZs//OOAHSXSkn0eqnUZYv2ut86Ob9DZJkaIXRdbnFGLcB1N3Wj?=
 =?us-ascii?Q?+mobHolhdTjT5QNOCnJKW+pbLizqzi3MTE0rjwFYusmrB7zeLPbPUTbIz9Cs?=
 =?us-ascii?Q?YzG9vDFyJgEXNrGF57szdU687HRYhMAGHplD2fEgReXSMMGPq/hJOYKr6qgO?=
 =?us-ascii?Q?sS9E95yHBCIULuxB3l8GprNL8ziqxNS6zpsN8Xb3SJg1Rs9oHPoVvr/RtwbQ?=
 =?us-ascii?Q?JrWdV8FCtUgVd2I7hpgMKsAU51rYb60AhJj1p/+7CR44ZSOrxhAggKNYumOW?=
 =?us-ascii?Q?ouuQSUG/aE+Ep4VAqLOArPHKWL+PDrmF3RNeSp0n2e2o+tabX7s1VS+bYm+8?=
 =?us-ascii?Q?NWhPBBplLRhA9+ndNuIsi/WYYPHl5NbBPaYrfPskSBCyHdAfINTTn3kwfiel?=
 =?us-ascii?Q?4hdHFBsX/HayuEFNQNTFSYqQPWOVxgB/2iPxmeTZp8WdsDygFXGQs8LEImf1?=
 =?us-ascii?Q?Srq215hIZ3uat4Ow+pTBWHMgzZuhlUZh/q+iu2Hed3l8Ld6IuhtyFilHnsq6?=
 =?us-ascii?Q?uIBVdhrlUelL1khQXOv/InSoY4QGP7o1xu4IHtS4OilEzFbahXnCsHeXDcCr?=
 =?us-ascii?Q?D/ha8R7WL6DGFBZXbU78Di1Ze3Alp7EYUxtFRQDVRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h9NahQyMyUXePzOavFYj28xz/kpwmV4MQWyJmXiQMC7uN/Llu3dzj5AtihCv?=
 =?us-ascii?Q?LW0THgMvNQEez4P+gAbd2PdLyFzUW/jEgMsyu13xiJwvl0LAcBmMP59S+tVi?=
 =?us-ascii?Q?YOpZGyivZgPHiLvhY/vDsWO6mvnoHFWrPWWvcPa9ros9Tl/yALwRjtUoNHgi?=
 =?us-ascii?Q?z6m/6EStN/JTaxPuZGDtUw1E5SVKpW0LvV4JrrpeB7HHwL9NcX2rljr7tWzW?=
 =?us-ascii?Q?cjAwJZJpk6xRMVfAuWLeCoeUZYKX/hvJLHHN415KEhxYzZg/APY0NQixExWF?=
 =?us-ascii?Q?Mg9OheM9Oi/jjqr1jcDr4v1rtj4qQ9+0A0la1HTh4+NmZ4eMmJPEfWGiSt8z?=
 =?us-ascii?Q?5/Z3p8EZNnamoe9f1G/sk3Kbs5nF6yb7DXxRUTiWQw0JZKTlsxUebiltz6gF?=
 =?us-ascii?Q?XSIKP9AVD4nkBiFY9+krAxAV83f7Ts7fdPnDr7I16RWcHkzx8MUlm7zW/c31?=
 =?us-ascii?Q?XvktXoJJL+OejKm0b0IVFN4dcZntK02tuXrP8PYFA+OBdR3UzsC8RCoYzvZB?=
 =?us-ascii?Q?7b0hx9OVqqLD2rQYcMSVh7nH1S5T2fPwMOOSjX5744fD2Bo+kjf1YrFs0M0k?=
 =?us-ascii?Q?77nJxy0FF7dtiYHgUSZ0gvvENo3fkeq4CUop7DFXA8/K70vsPleCG27xJFzh?=
 =?us-ascii?Q?byklG5fHf64vVLy2qBwy+FvtuBBtDi2OyDLngzQb9WCjsvqQ4JIp1xfIPjhX?=
 =?us-ascii?Q?G1g5tXVX2O+XuAkO2y1V8yImfcbinqtrGMvH+THaH+xDWI+LqXLrAws7ywgh?=
 =?us-ascii?Q?0p6sBX+ZAPPnnu3MmEIkDwTlrFG360ZBn/LBPwFjsSnzccR7vosK60qGRMRM?=
 =?us-ascii?Q?O9kkNNE0y1Zta6MOa1HRfC4cJ+FrBRpiDR0DcKmTZPgSsMk/zVIgmfHEaaFX?=
 =?us-ascii?Q?2inWt1wDzse7xPsfUgQldLB/ABbfPWSusLq9dqo2yqgEjoFCXQdPNryoL+14?=
 =?us-ascii?Q?/JPoNYxI8y1XSzi5+5Ne3fQNQxuHJgKTMrMqPYV2eRAxx51pIc2xgFr+DeDb?=
 =?us-ascii?Q?rV9z0IiTk85WoXuZijFEbaGz/YuALSiAtyiSK/pD+t/DGS5UnkwU85nwIQPW?=
 =?us-ascii?Q?tKMv2aM8mYHVUv0/+uXGJhag7Uv8zVBNp1vjeIcseIX2wRlWwSGQpWHqmTdw?=
 =?us-ascii?Q?6E1kpgkS+0495ZL4+b6x5Xzq1dwR9/bdetkNeR+R4YthRmR/jNYlGIKCc/BP?=
 =?us-ascii?Q?OERLZ4jUiBhHzE9lP72KZD8RPb1mUt2ktaWk8sxlD69AoBQveq5PTs56fINi?=
 =?us-ascii?Q?gfjYtIkkgG7K+75UXxi3IUqavcT48JlaNeUHfy/Th7IIx59uPG0FXmQoc9l1?=
 =?us-ascii?Q?bI2kmKfawhXb+nWdDb1JwVPk1TMBkw/Nl2jpUmDCqaNuuIiUSR+IJs+7jBCC?=
 =?us-ascii?Q?zujUe6lZIW1joq1JRsjFSCplY/7nd1GkjqB3w4lJk7yQCfi99IMOZlLYL6ue?=
 =?us-ascii?Q?bFihOX3F7O2BtRwf2PdAh5BVgwDgfhuiVd7GjQb24eVUF/1ngkCoD5DUXcQj?=
 =?us-ascii?Q?oHf/cWFgrYcBqAwU88dyeObJaom7r+2wdQG/I9wQ58+QfFy8uk5RvIMogU+W?=
 =?us-ascii?Q?1svJnNsKKfVpDOCEezDDdIpx/1jkpCSCNgtRbRWJ+Y9dHJSWn2XSVJk+aZSH?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17694fca-8c59-4582-a179-08dc7e9699d2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 21:47:27.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dye9BvUTuksbe157hgzLcNX6x4RUZ3POCKv1PdIsAS9WssV/BlCpTNyTwDMtkLoRipKSiBpcs80dmjjtHwximA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955

When building with clang, via:

    make LLVM=1 -C tools/testing/selftest

...clang warns about "taking address of packed member 'write_index' ".
This is not particularly helpful, because the test code really wants to
write to exactly this location, and if it ends up being unaligned, then
the test won't work (and may segfault, depending on the CPU type).

If that ever comes up, it will be obvious and can be fixed. But all it's
doing now is prevent a clean clang build, so disable the warning.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Changes since the first version:

1) Rebased onto Linux 6.10-rc1


thanks,
John Hubbard


 tools/testing/selftests/user_events/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/user_events/Makefile b/tools/testing/selftests/user_events/Makefile
index 10fcd0066203..617e94344711 100644
--- a/tools/testing/selftests/user_events/Makefile
+++ b/tools/testing/selftests/user_events/Makefile
@@ -1,5 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
+
+ifneq ($(LLVM),)
+    CFLAGS += -Wno-address-of-packed-member
+endif
+
 LDLIBS += -lrt -lpthread -lm
 
 TEST_GEN_PROGS = ftrace_test dyn_test perf_test abi_test

base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
-- 
2.45.1


