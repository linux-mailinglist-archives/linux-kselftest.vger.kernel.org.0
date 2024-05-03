Return-Path: <linux-kselftest+bounces-9317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6343D8BA5BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 05:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78CD71C223BB
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1956A1C6A4;
	Fri,  3 May 2024 03:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p9/pnUfh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49729F4E2;
	Fri,  3 May 2024 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714707004; cv=fail; b=LOkPfc6qXqv4LTf7A3tHlT5wSpY6qTJ9aRHf6siknjGHdzo2eXmZbPvKu2A4Uz2GwtaihyXlveEfFlqX8q0Wp6OM8gFk1U6SEdOraqsnXeJnelsnlyIz/tJjhqci5sXfsnmkduPN7yfM1JhCqwJHzZdV9ZLDGjKSVZ//gxKrews=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714707004; c=relaxed/simple;
	bh=KRlTvt7iYTIh7WuXr7nTBJ2A2wCJrpAQLn9a0YaqdZA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hM7jmclxl8BOuP4i9Iz2i0oFwgG1eMyPXuGn+3OQyXNg5IDbJpqHDzhw/KsKcay13kZZfqRjalApCTfHks4Y1ctR5dRS0VV17xwprk9RT5xWGdO+yoCm17KXjeuM9aEYjJEl1yeWk+sxru7OzH5+NYlcV4Vwkk1hZm0CFEkrmwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p9/pnUfh; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLpbVuBRKU+/fkQbnil5aa6bmTaLHS37kOxlJaZtlbvotBxpkWXfyvBSd10fy4IpB6CWl9kREvlzNLDrMYkF6G/QxcnW+JMa1T4VhHgnIvs6i1Ggf0a3ZRvLh/NlkDex1USaTRLzU/HII846ju0m3g292kNs/RAfCQve6ZbxWunnY//NlHfglXmh1JPu8mvwwC/h4dPWTK07h5nO4VcsRdQ5gpG3AQPcbp5Bza69lN4MbU/YL4bNFsps8TmsNnTlF+o1be/qCUS0AN0BOH3CU7zsXgMkS3Pt5H9Roga5sORkU98nghH8Isu/KhqERQoDNgw61o+L1jymU4ym80OlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qA7vAc3zkxNzS0PO5aB6CRBYeRlEDeOKe29dfHndRB4=;
 b=B5zRh30P+A5Q5dwFv3zb4WfdEk/O03h2mEOLlzwVY7zo5f1sqc4yak+tNKyT6GN8zn4miF3E6xcxdyfNRHVFGfGJdmvOKa626xCbVkp5R/n4iNcMyoJBLWKcGi4eifdYhYqFcDT6EvGCFQLCQN/95YqbAue/8fYRExhsUM8wZOP64RphG5JXF23OOYZApdXaJPsj6Wj5yx66ikKacrQNuRmth2mjlaLTRTRX//yGmlq4qmQ7b++lqwpEz26853+3QytWQRUu6Axt0vs2iAvVxRPdiWvqYFgtQRPIsjTQwrjOwDgySDuHuxc9BGPMdbTEkrnPZeS9soty43WVw9PRWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA7vAc3zkxNzS0PO5aB6CRBYeRlEDeOKe29dfHndRB4=;
 b=p9/pnUfhglgoDrbLF34G5pC2OnnYWT7/HaYrZi3/KvyLJ1YzQFRort5tQ3IhP7T2ZbyJFZbDBLgxdKCXWwDj41JWgb5SSqcmBe/FBQWoWwCGkrH3dwI67TUL1poQwYXsyuE2yI+n9VQmQxPRoKgkw8K3FvCgXY+YCWqxNqBV6VVfbeOiAHzrNIEB0624R3a7aR80Q1Mn5IrZimnVC62BZSKy/kZtKwL8CNssl2H6zEutvnlzSeh1UGuvbQXRYH+86/07Jv6wuneRyTyWn5d5FT6iVuO5KOPt5+h7feF/28G0GCtyR3YbOZPYJyjzpKcMp9rrdWluM3fkQ8lVVLWLgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 03:29:59 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 03:29:58 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@openvz.org>,
	Andrei Vagin <avagin@gmail.com>,
	Dmitry Safonov <dima@arista.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] selftest/timerns: fix clang build failures for abs() calls
Date: Thu,  2 May 2024 20:29:56 -0700
Message-ID: <20240503032956.89290-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:a03:333::15) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7b7222-98ee-4d61-e377-08dc6b214f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BC7HWymxsAhUh8qQFuNLy36JW6JAbuudLr0NdKOt6TTZfhVVNfj/C/PTLKu6?=
 =?us-ascii?Q?lnSB127LGDoap8mo+itwOY3pmISI/4t+gQu7Ux/s966Bc9F9ro4WK0inXgZ9?=
 =?us-ascii?Q?Qkx0m+N7Y9eYn4ZcAhf81v/5j6xzarLfsiksRAj05btahcgwJSkWM0ZmkoCg?=
 =?us-ascii?Q?lw2d7j9NAXwi3ABIuE4pa6S/GkDeYPIZQb4xH2C+F6qaPsT/fxkZbopLdT7X?=
 =?us-ascii?Q?5ECB1dyO7OuUClTZFCfWLQK4CLwNrhpHRn3l+SPJy03N5Xrbe6FwerYaMlH/?=
 =?us-ascii?Q?7n1/HRCRKBgjgi+A1kPyNSsdQs8hxAPkwVhsPAPaB0Xm5DP2Fuk/IQ5saRjT?=
 =?us-ascii?Q?32L/saX59pcbAJotrMsIswxXO5q60j72mFaltKi4A7NOyw1GbZlWsToZxUmZ?=
 =?us-ascii?Q?PK+yMvFDs+C6Ih6I3q3Do/ebIFE/vWX8qBuKpwAgHV0sLzHTNzqPyaFjXXKi?=
 =?us-ascii?Q?6HBIXZOC/egUbiXjuO8N/qv3jJWawwotkohcwQvKewJf72KKGTPTz+HMl4KX?=
 =?us-ascii?Q?zkwk9eKpNF6BnVtRyyZaN9FmH1S8Qoh4AF4tqoKhfj48o/cKltpeONU1579b?=
 =?us-ascii?Q?IAT1iozrxE+m/0nMZmVDEmr4UvtFHCsA+kxBlyb+d0H3Zf8k7uUSLzsoCcC4?=
 =?us-ascii?Q?MJqFdiqzvE07R5CCd+p7dFTEhqomJsX73ZxS1FU5GTzoXdv/wfNsocPJd2V1?=
 =?us-ascii?Q?LfsV19Fc/8eQHSxYpsf/40tXNglSQvpdesGsaMQuZ8FLuwQVtKbbK3fYvitj?=
 =?us-ascii?Q?rZB+2Uyh2GF0/Y1/IHn2p5hhkRkDL7nXaxI5xnNSQxKXc/bdodHKVcAeBnmG?=
 =?us-ascii?Q?Y4fQ30iipYr1LZlsX93TYlT5hYPCBCQR4zq9Na0rGFl2GOHhS00MiznlFvoh?=
 =?us-ascii?Q?71xZ3+jrSXCFqJw8fr81jsL+5IhInGnWKcr5ux68Yp69eX/1fFUeatmO1JrW?=
 =?us-ascii?Q?Iy5VfN/N6dvgK7zGgBl5manbfQSLVmCQr8hGLCXUVZlWjoJyeoHYjCZM5lf6?=
 =?us-ascii?Q?cBC54K5zT6k2a5JlgawVELsm3jZSoti1AhPSqcZTOsZZEyS7j8pFXoY+pxbj?=
 =?us-ascii?Q?xMbmFhWBk/3Wwqj6apE12ByZk3x8lWfUEhXe/5GlUTeA9B6XyNZrWRojGVu0?=
 =?us-ascii?Q?oF3Nb4EP/hZ3nad8Gjk0l3fWshvTBI687dpmpt+ZO3xw6JzPJYAqjJIDMXSx?=
 =?us-ascii?Q?GYNbjkDj4LxOdY4yDfszHmBv7/4H4sbCH9ENK92qkBA7NgRA9n2jpadk0o6w?=
 =?us-ascii?Q?nWjD3VBxYsAWvF810Q4ekMOI8Tks6PgT9E70z3J1Bg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1//f4hbo7diA3p1QPu5mHgTIpOa/6uqSsuUEsV5uvW7p9IzZzsOAv+i0ePaF?=
 =?us-ascii?Q?ToUnwOOi3MV/3F4dm/gWQwjNq3/u4PtxSjBY8wyNIywk66mfhevRn8+wXtIg?=
 =?us-ascii?Q?ceU5GrN6cn9zqsVrHiO2YnBq0zUgCKiIxx3H8NEfiT0NThf6QdWV3hgKUsAx?=
 =?us-ascii?Q?uyW3WpDko+pO1NSDMnUpshVXUYli1lVAhMgAmRLkF74Aq7czJ/b2ljGO+nwH?=
 =?us-ascii?Q?UMM3DVVtY3myYmwCHWtd8Mj0AcMlXbDQnzrDiYvXS0saWgvvSGylLydusbDf?=
 =?us-ascii?Q?vGYouzHEnSN6+6RHKmooJ/kCzok7eu+l6Gz7bghhfYiAVwhNcJ7qoRpsVXMT?=
 =?us-ascii?Q?x/watQ3RcrLidTHmHUVWHeyzVC/s8Wp5paYHK9CaCgxWf8ZSShpz5IAvMYiW?=
 =?us-ascii?Q?50W8/G8dG5BBJRJ3hYzU1JOV+LQAo+RJHVn2L7v1Rci/0keYyuRM83d3rMhB?=
 =?us-ascii?Q?ckRHfdnPY5dJg1hTBaqHVWULxJ0mVCtVevp6Sl5GhX8IhXQl1aqfv3EI5lBw?=
 =?us-ascii?Q?a9zGwIobXUqTQnTL1U6cZuVgOqX8qvAiqbj2rbBBWlp58K4OoN+7zqWlRw3b?=
 =?us-ascii?Q?QkifhC7f7El6K33989joJdYes7xM5W6O2w8sEIa6ZB4Aktg1DFpPVVCXLdfq?=
 =?us-ascii?Q?aS2MjE5lBUbIKGFljZptKqnm/vQGMTjiiCEhqlWXc7wiQmMk1eiEyeJD82o3?=
 =?us-ascii?Q?Bk4jwtosNBuqxDSzSxVmWuuQKGwL/cpVBJC4T47VA5X8i9mGxqUMpiEed6W/?=
 =?us-ascii?Q?dZ9mJkBB15NK3Rc/eIRIA4tMN1wCnicfeYF6vgpqCKd6vej7FoyL+35ND/9v?=
 =?us-ascii?Q?dHQTCFZI43guGJmmmPygCTUsscPsY9Q1Sk3e1ogbL/s0sJAn9pV5zxe1803E?=
 =?us-ascii?Q?qeyW6CO/b6Vt18YdugEPPUGbnQRb+bGRy4Ebb5MHTFUrHR9MdbFUX+EEI3fj?=
 =?us-ascii?Q?2vFvGYnYtCsDMefR5tpdqoEuodwtMs6R2wj1nCo+LRsxehOF7mmmvKRHiuWx?=
 =?us-ascii?Q?udQTy7pyLMSQdacU6G67KT3Hsi5YqTxXoPKt4aPxEmf9LDmF6OYVYUnEiHvS?=
 =?us-ascii?Q?ylPRL9sT0TTEk3XsumtXhRQBVazr25twhttfLI86sf5gjFNFPsNY9oUs/Q09?=
 =?us-ascii?Q?k2AvW8lxtoDaFX9NNUEFglOQNK2eRxQIFmuFFhtOx0hOe2F81IC0gZZhp4n3?=
 =?us-ascii?Q?1mW68zI3ccIzerq0KHTaeyshoilwU1gTz0dswtvvqQajIwlF4K5b3IQyw9OS?=
 =?us-ascii?Q?2kpOf9/vABJdqQj/Z6anJvangp4YIQaiXY4oNeV6VfnKHG1PRTGkH17F68B4?=
 =?us-ascii?Q?ydYCYALL0V4NbScJZ9r7NcpOiqZmizgN8ssIHQyRVZtMcnHxO7RFMcvqZFze?=
 =?us-ascii?Q?nNAIBuq4LErdOOeFnzvyz0aV4xgunhY/Ooju9kcDbDLJ6xSbglZC347VQieM?=
 =?us-ascii?Q?KJsirsz4kEDl25b+f91HrkP0Wn3I52cdflU6Ljm9As59rLbWWC9nUVbx1b5+?=
 =?us-ascii?Q?6MRMLCsM8aPIrZBRDz35PjranF9efC0Xu21t8H3fwN1L/MrUrnGmtQgK5vZ8?=
 =?us-ascii?Q?/R0+8X9mDg1dHzponvUQntAOC1t/3xJcChP+K5hB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7b7222-98ee-4d61-e377-08dc6b214f42
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 03:29:58.8697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKV0/WPJnhM+/3NUGZes9bwAv0Qfo35Tp9PW30Aica/PoK09KQ9/s3sdYIxqsWLKewUHXtVMvtZ72uV2MWLprQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...then clang warns about mismatches between the expected and required
integer length being supplied to abs(3).

Fix this by using the correct variant of abs(3): labs(3) or llabs(3), in
these cases.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/timens/exec.c       | 6 +++---
 tools/testing/selftests/timens/timer.c      | 2 +-
 tools/testing/selftests/timens/timerfd.c    | 2 +-
 tools/testing/selftests/timens/vfork_exec.c | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
index e40dc5be2f66..d12ff955de0d 100644
--- a/tools/testing/selftests/timens/exec.c
+++ b/tools/testing/selftests/timens/exec.c
@@ -30,7 +30,7 @@ int main(int argc, char *argv[])
 
 		for (i = 0; i < 2; i++) {
 			_gettime(CLOCK_MONOTONIC, &tst, i);
-			if (abs(tst.tv_sec - now.tv_sec) > 5)
+			if (labs(tst.tv_sec - now.tv_sec) > 5)
 				return pr_fail("%ld %ld\n", now.tv_sec, tst.tv_sec);
 		}
 		return 0;
@@ -50,7 +50,7 @@ int main(int argc, char *argv[])
 
 	for (i = 0; i < 2; i++) {
 		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now.tv_sec) > 5)
+		if (labs(tst.tv_sec - now.tv_sec) > 5)
 			return pr_fail("%ld %ld\n",
 					now.tv_sec, tst.tv_sec);
 	}
@@ -70,7 +70,7 @@ int main(int argc, char *argv[])
 		/* Check that a child process is in the new timens. */
 		for (i = 0; i < 2; i++) {
 			_gettime(CLOCK_MONOTONIC, &tst, i);
-			if (abs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
+			if (labs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
 				return pr_fail("%ld %ld\n",
 						now.tv_sec + OFFSET, tst.tv_sec);
 		}
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
index 5e7f0051bd7b..5b939f59dfa4 100644
--- a/tools/testing/selftests/timens/timer.c
+++ b/tools/testing/selftests/timens/timer.c
@@ -56,7 +56,7 @@ int run_test(int clockid, struct timespec now)
 			return pr_perror("timerfd_gettime");
 
 		elapsed = new_value.it_value.tv_sec;
-		if (abs(elapsed - 3600) > 60) {
+		if (llabs(elapsed - 3600) > 60) {
 			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
 					      clockid, elapsed);
 			return 1;
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
index 9edd43d6b2c1..a4196bbd6e33 100644
--- a/tools/testing/selftests/timens/timerfd.c
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -61,7 +61,7 @@ int run_test(int clockid, struct timespec now)
 			return pr_perror("timerfd_gettime(%d)", clockid);
 
 		elapsed = new_value.it_value.tv_sec;
-		if (abs(elapsed - 3600) > 60) {
+		if (llabs(elapsed - 3600) > 60) {
 			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
 					      clockid, elapsed);
 			return 1;
diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/selftests/timens/vfork_exec.c
index beb7614941fb..5b8907bf451d 100644
--- a/tools/testing/selftests/timens/vfork_exec.c
+++ b/tools/testing/selftests/timens/vfork_exec.c
@@ -32,7 +32,7 @@ static void *tcheck(void *_args)
 
 	for (i = 0; i < 2; i++) {
 		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now->tv_sec) > 5) {
+		if (labs(tst.tv_sec - now->tv_sec) > 5) {
 			pr_fail("%s: in-thread: unexpected value: %ld (%ld)\n",
 				args->tst_name, tst.tv_sec, now->tv_sec);
 			return (void *)1UL;
@@ -64,7 +64,7 @@ static int check(char *tst_name, struct timespec *now)
 
 	for (i = 0; i < 2; i++) {
 		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now->tv_sec) > 5)
+		if (labs(tst.tv_sec - now->tv_sec) > 5)
 			return pr_fail("%s: unexpected value: %ld (%ld)\n",
 					tst_name, tst.tv_sec, now->tv_sec);
 	}

base-commit: f03359bca01bf4372cf2c118cd9a987a5951b1c8
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


