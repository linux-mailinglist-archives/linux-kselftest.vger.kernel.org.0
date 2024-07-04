Return-Path: <linux-kselftest+bounces-13153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF84C926D7E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 04:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705701F22D18
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 02:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F151BC57;
	Thu,  4 Jul 2024 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P5MDim03"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB6617C98;
	Thu,  4 Jul 2024 02:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060418; cv=fail; b=WGJQMmGuBzCn45uq6ZRYNctA6UV99HtZN3b7vKwB7ApfhbJSUaRskZuN//JFTLhH1O82DcX3puNuf3ZtsSYoygdWV5FllYFc4c1SnI2Qkvmih0gzxkrFboqgpKeMiPNLaFXhJUtzypTSBLJnQ4SklU7rUOmp3NFxbVR6a7iqkSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060418; c=relaxed/simple;
	bh=lK58vpBfcZSQv3JcPh24mTbHXlmDL5Zm8gqKEelHQvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJiKAigj1ci2PJbZsOSYF6rjjBfnSm9CXeWTTzotiPK35Ixk5BARlJJIIefUUP3eCOlULH92tUEaF6kqTD7weWS144t4ZoUgYxj5Ya9MSzaEehX8/U+Dp/TbKS+MOUNxv87prHHk84DyxLe+cUnzJSkEV5GX2l7CNv1+R4G4bzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P5MDim03; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEjG8ccsL1qJbGpxlLJzWdsl6HQ1WD+6jjtxWwx4tDYrHGhnMqDEiRdQESIBeVc6T7dVfsThZBEZdUUtQGKklCPT6CafhjNfPZMTF5DGdPV9cFySyv26Ty4r2Tgal7lgw1lJDTD6/SkdDkv3+5PL+DylyCTT07yyYMDOFz/QHYlcTDuKLfKzWiSj/qmf/c5rtz2xNuZVVFtSypMC9w0Dk2Ms2suqnge5ugYHfcdvs8fu1kMmc0YCVt5y5g2uA+YosEuvTE5JlXuGDFJFiqpqegbBwdk0Gom1E3J3x/Ud8jUFh0VDE/S+YlBiz7BYNIgQHqHZKfjXqvJAafNyuvHE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xmOt1V+qeM2fjYdwMfL4nhE84hrotY5xIDTqf3ElEA=;
 b=KelJMuI5w+UCvwdGME56eyI59tyNV2Wtp820fqfpFbnuKsUkTSHikeRDs6nYIWqaNGfqd5q6FESwPogqcwz9mankbwbZQ9+Z5LosZAuRVYCOzhk9we+1hkunRHTjhuv3HPiT2eCAL6X51hvrt6YgGyRUH9kuhg8X/+fOhM/9FXMGNMEwAN8W2EXAtBm4/oV3Wm/Jobs1WeyquqbE2QvqYComFLg/Of1Edwk9ur2sMu/ZFUIT1xGNvnh4xocg/QdWecrxwSICYycM1bfDgNfqSFr8hvJFxZcb9+SFT5wcf013Bmu9gwXfT/q3GmImCzQPK84GpO/ekfCjRZ2c1K1dRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xmOt1V+qeM2fjYdwMfL4nhE84hrotY5xIDTqf3ElEA=;
 b=P5MDim03+42EMFOPDqBV0j/DPZpDVmM+7Ek0Crj401cyLOXnN/krQcfMZLdzrggvtk7QaxQJ3dpZ5kjM+imRAHVPluG6PlQr8GvWipFcw/D8vGJCWzR8bD1WsDkXoXElYZbXAuFpuww0kRwwgCth80ieOkyY0DutGtsERrp2cznFXQ7wlS+sL4yw+FRCdm8ExX1rRU5Tb6UDekgZupt4WMmSkFeKvpn1flj7K1nIbVYJ8gaH17941zwD3e/Pec2hvLUyN08emNFQRSJrPpXRj3D3evNgtVahUCbIfEjbgP9yeq2GU4d41PnbDf5R0BwCiRoPD5LypeeA7jOxOBXDfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Thu, 4 Jul
 2024 02:33:28 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 02:33:28 +0000
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
Subject: [PATCH v4 3/3] selftests/vDSO: remove duplicate compiler invocations from Makefile
Date: Wed,  3 Jul 2024 19:33:24 -0700
Message-ID: <20240704023324.83564-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704023324.83564-1-jhubbard@nvidia.com>
References: <20240704023324.83564-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0045.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::22) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c36748-ff20-400f-2b88-08dc9bd1afde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sDiLnWcthpPKjgWVuFWeB9KbQuMHL1W63kq5C7yC2RnCRcHVgSnZGkjZQqRq?=
 =?us-ascii?Q?KLj2C7k9RpCl6PHj0MiuJhDNG232rqAY1o+A7stGp05tDfeh07dXNHTE22xa?=
 =?us-ascii?Q?vXC9JqsrsbqQVu0/UPDxcZWqJlsHafNeas6eHp2Ms5YrJA/T8xzeSKq8f2X2?=
 =?us-ascii?Q?sn67eTnLO7LJC+kpJp3wKwCqMI0qY8CWbXKJJrKWbNiu38BuYe970BCOAZqW?=
 =?us-ascii?Q?O7BtUFnRVWtl+00enSLGD/SVURUiLWEoL+VAyHIuP58p9k2TDe0eKlg2IfEd?=
 =?us-ascii?Q?bdaNYKdNHu4ePfPIkTjVs3JOym5c8+dfsc8MViWVQ5nJGaueAx3VfAiLCVfC?=
 =?us-ascii?Q?JfW/gqR2zMS/H+ZhxMV6wS5/JoGQMI58HoaqaqIt5PGHfLIztBmCOzVS83FK?=
 =?us-ascii?Q?+RodiXayIG9XwmLe/8KSC/HH9KXHjCKR/HX6034vwHP2MnldWiyaN+0jjay9?=
 =?us-ascii?Q?bBjRUlpFjRuqdc4PhysZw6iF5C4B5PvkFSouWx+HpKZcnP99Ji9RkIJuYncv?=
 =?us-ascii?Q?U2qhSCmL/ZbYBTAJJC2ZMjIhHWGVwI/Bzgj2ULmJi8M9/KjUbahLkuC9g9xM?=
 =?us-ascii?Q?NvXlrDMiIwBKatzwo/3qozTcALOGuHB+cEDcaEBl19B/i2Uya7pWabZ8QUXG?=
 =?us-ascii?Q?BSG77gGVw59vDYcBQwHalIsehStTqiENFIA56VJAtmgCr1getvQ2+fQMAakl?=
 =?us-ascii?Q?vku1y+TF1MuRFPiFfZIodZKd4PNnwfGL8XJjXBjCvFEwL2G8qYat8RwxFDJs?=
 =?us-ascii?Q?UBV2O70O+u9ZJWqqN/FMgnjzt6al15Xv5dz+6C1XsJt5nXb2N8loDKFDtWaV?=
 =?us-ascii?Q?r2nNCrB+HwWFnqVi3wF51DxF/y6fbx3/Qu2gn1QE3JsM8DxBrD+DvHnIGVmg?=
 =?us-ascii?Q?K7NzZbWlTQsytsDBHfk8ITCOz7LfPIoXCyLHHtEIc0QWCcaxAaLWHEWcCQN0?=
 =?us-ascii?Q?zvgiccKC1cS+8XHz/JH/YUHSkFCSS8qELmFhKG309eNpzltRIQVz1CZgPIH5?=
 =?us-ascii?Q?T2EPh9PskFfbW0rEqbzoz+9XLKjhIp2nG9eovCe5vtMLmD+KC3LU1hPNSycf?=
 =?us-ascii?Q?gwdOFRl1SEvVzURTxRN6aoCB7Yv5ZWSObE0TokbdFzPpdnyHlAiwur5SmIUW?=
 =?us-ascii?Q?ru9y20os4bE/0hP7eyGynW7oU0SExHSUM56K8rE/+MESlUrzZkXFAdHBPyOq?=
 =?us-ascii?Q?15Sz0xEJkgMlFQF8bG7dYuTyuowdKDvtthNM5sIMVy0SKgrCXsrfqlMOxs0L?=
 =?us-ascii?Q?bKdyAQrObgfnzGA5j3eankJrXIJYEWdscbS7y2vOl/vZJKnFezgFudh2MtHz?=
 =?us-ascii?Q?5skUxFVTDH4RG7gP34hVrkIMx/cwCypqve6GSJylUrehxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z9ntv8XM/f0OIkG9tCYaC4EeT86ch6GJqF9sigynXFBaWmGu+hv+RbWqblkN?=
 =?us-ascii?Q?+KfeGsyrs7niNwiu9W9eYD40oR1BzuXuABaCe8DkikD1s2I2kw2lP2hK12Al?=
 =?us-ascii?Q?s1I7O+I2HzftJn2eHb9+YFdkHDqLmbkZi7zOQLBijLGyH+ef0m5IsKTiKVma?=
 =?us-ascii?Q?rISmWmOUaS4OwktoAl1Glg6prpLVeHM7LIQENjSBMYtpwkMkDg7h8AGQCSPn?=
 =?us-ascii?Q?PRBC2larn3JD5JbEzPwDDaXymiuuTCpwJmIu5LFcHkN7cw8G4lqa3e60UsRc?=
 =?us-ascii?Q?vBbvDwyC772kduqje1IccG81504p9SyBaANmjVmmA4R3n0xTcEd6klQY/63D?=
 =?us-ascii?Q?dCIST5KB5q5/1667Hu+Ho4PgbgwrLcJzCcRpD1kHlnN102ImT3wnF+HiNKxl?=
 =?us-ascii?Q?7Ee4QOTEe6RrpHsbF3SIL/fj76X2Nw+6q31N0lWBC0VucKwNpr+7NB6b4WMF?=
 =?us-ascii?Q?mtu0r4YuEQuC5KyQxexhA7+tr4ix+kGRwRRjjwyz/wzvXkUvxSDRpn2a3JWR?=
 =?us-ascii?Q?KzZYIAKBIeucLGgo1ljc0d2VhRm+sNryXLLhaiEYZJATKFHBxCw9QN6VpNAd?=
 =?us-ascii?Q?VBtp7Ilmg3R2jOZzUyTZDjVyJl5McNITOWfl9I+hLvHaNANeQbQcxyE+SSsq?=
 =?us-ascii?Q?FnTtZ/omRpvu0YDfMmGNw9DTRPbxYw61EkJPTx2x0F45St7p6mUU/51IFm0g?=
 =?us-ascii?Q?+zGpG1o8Ya6qFmeEfdgIWwf8muE1vd6rOHEPm0pqV3TRpGphNkwPGeRJZAld?=
 =?us-ascii?Q?LoAoU7k8EtcgkA/HuQb2EqZDvDm+AbmUP5MQvhsQM+sJaLksWItM4pnmDcNg?=
 =?us-ascii?Q?OfWzcPPT9i95uvcBip7BoN08332E86GC/pVGZFPZG/S/eUo+VYKDy3sEYYv1?=
 =?us-ascii?Q?UUGmeYn8wxMYRSPvcZZtvO8Mqpd8aBeR2SW8pz/wLZWYTPN0K3RWrFjeVQOw?=
 =?us-ascii?Q?Z+/pXmTmtsb39ce+QvhpxGPBlP6pU8XHFqSz9HoVlMXUJ8V3JYr7QKh2lGl1?=
 =?us-ascii?Q?XYVH+ZdU438bEjpkKSpLmhBKC+2IzxMi/XjwCfZIxb2nAD6PsuCfW+pzhTAH?=
 =?us-ascii?Q?+9Ge2VttOyoRTsKDKmDEUEjI67dxfj/g+ZWmaBGaeMBTDtaTrWHUaH26sgVD?=
 =?us-ascii?Q?S7TWQwZqROC43FE1t2q8ue56rTiwaqHq7W28Nbxn1tJimdSG33qAaab3hkwl?=
 =?us-ascii?Q?rZYwHCeCL/hCdZcwD+Qbh1NC01W8Ikxe3UWOh7m7Wro0hhlYMAA7Ijx5iAoW?=
 =?us-ascii?Q?XMC7B5MPKI2HxVMyIg0SG/0hziAHJMVAaedeP3uPqYf7PEpbnLsD+VjJuXi0?=
 =?us-ascii?Q?n+ae9hQR2zQPkW9QNhTuuzsvgWhHmhSAzt3DVY8cfnsOzb3fFUV1tL2sIHZV?=
 =?us-ascii?Q?lZoA5hVHCpxAv7DKhqujsLLBczjOftyNGvmxmgq1Iw5azelVhXNz4DsqR84L?=
 =?us-ascii?Q?trk6KyMbJPUh096S3SnziMOw9fQTCxfYx/MWGPmte3atp/r2UIm365PnqIp7?=
 =?us-ascii?Q?4YxyQ98jkY0ZYEkqfuIkzxz2kzvgI8T061bmHKSZGiR+EtrRd8MT5RqXYoW7?=
 =?us-ascii?Q?r9nZ99LtsFqZnvGzJjljarD2R7ab6KL7CeFsRX7z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c36748-ff20-400f-2b88-08dc9bd1afde
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 02:33:28.1689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPBrvKBlVupim7kqjA7YtSo7V8DA/aTlXbgfoCb4v1c7TfEjsqYp4QSlN+C5E1qIOnhdVVmqX/J6uEkKukqgMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775

The Makefile open-codes compiler invocations that ../lib.mk already
provides.

Avoid this by using a Make feature that allows setting per-target
variables, which in this case are: CFLAGS and LDFLAGS. This approach
generates the exact same compiler invocations as before, but removes all
of the code duplication, along with the quirky mangled variable names.
So now the Makefile is smaller, less unusual, and easier to read.

The new dependencies are listed after including lib.mk, in order to
let lib.mk provide the first target ("all:"), and are grouped together
with their respective source file dependencies, for visual clarity.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vDSO/Makefile | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 209ede5de208..98d8ba2afa00 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -12,8 +12,7 @@ endif
 TEST_GEN_PROGS += vdso_test_correctness
 
 CFLAGS := -std=gnu99
-CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
-LDFLAGS_vdso_test_correctness := -ldl
+
 ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
 endif
@@ -23,12 +22,9 @@ $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
 $(OUTPUT)/vdso_test_clock_getres: vdso_test_clock_getres.c
+
 $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
-	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
-		vdso_standalone_test_x86.c parse_vdso.c \
-		-o $@
+$(OUTPUT)/vdso_standalone_test_x86: CFLAGS +=-nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
+
 $(OUTPUT)/vdso_test_correctness: vdso_test_correctness.c
-	$(CC) $(CFLAGS) \
-		vdso_test_correctness.c \
-		-o $@ \
-		$(LDFLAGS_vdso_test_correctness)
+$(OUTPUT)/vdso_test_correctness: LDFLAGS += -ldl
-- 
2.45.2


