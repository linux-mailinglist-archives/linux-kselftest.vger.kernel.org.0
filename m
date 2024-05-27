Return-Path: <linux-kselftest+bounces-10739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8448D0E83
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 22:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02D61C21150
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 20:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB75A15FA6F;
	Mon, 27 May 2024 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pxmi4uzy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D4F15ECFF;
	Mon, 27 May 2024 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716840544; cv=fail; b=JNFFBPzOZIiYm4/CGXw9Y094IOJRqYXp4vXgeNgt52axhvL1JnOjKfpWallld1NMOyS6WJ3vt/EA7tdnQfN5Q3vtOa0DB4qrHZdW7svOJB3DMSXSeR7ouYtZRmZidoz3tRfU+kBIRubBXh9HSoYtGF4bwet8Jq3M6yRxD440S4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716840544; c=relaxed/simple;
	bh=5zpd20uDMc2h43/F49FuetLy3CX5tTTeIifppWp/0UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e6AAeq+5DdsO3b4LzBtp8x6uhiNGk6tNj+4ODkF09y2YaKZWYm0qq0fOvnHbWvwczIhNNFW4T1g5CJEMxtDSn4Hid82cF/1yoLFIJxFMWLFdBov0OOOfP9/Hrv5Ko3mekJrdIXtR/zXeRTLQ6kdxaKqGV7iyz/Wd5WzObcf8wVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pxmi4uzy; arc=fail smtp.client-ip=40.107.95.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awTpnqX5BqZfAgVxNgMjoMNNCaYWAVjfflRRhp+molzLPz56TOIQ49C1k75EjoH7WCQCcf9E1MmTySqDWqXfLn9iezNak00jyXiLazNADzkRX5D43sm6y0KPTcQHiIBZCnKxtaOcfMazEeDmJeNPowMT4Ns3AF3T7KKPsufEtIEksoM5kYlBIAB2LGjKBpVMb30J3fxX6DffDD39dheGFkCLp+lxnq4hmlt7BfPJTvyWILPZJrEzxJ9xwpT8NAk5ZIZPwu6JZVL5xYPStqzNJBCslo/TezKEwQa25mYxQY6Yucg2OXQt9BuA4oZIJ4BS/GGBlJH8VucivYT21Ty0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAvdZShSnMielUmLt9itatcuY+ZvX7NBcMK5HNnpCVU=;
 b=O67Pg4AzVegl7mhpvDWLV+K9Pph/u6PFj5s07eCJqaEdWw19lCNReIbKtIoPKFrS3ImwiQZ3v6NH1eb2sRAclk0LBIR3kw6Dzd7gf73dlO4ZZCr4gKw5iWGkyI8MF3uGe5tdFVq5cgtfsVXmgTddyctoz2Y2EorD6GyYm2Upv3zZfkxi1YHSz1N7Uq+FWLnqEtwXSRSjrtBrYMq+8lBojqQm464+URB2HSBvYBIur3ikAI31r2FIUuj9dHaSdL8zVP8icJ/EewChjKK4W4xjXTaSORYx42dwNzThilmslGAvqYVPgvcBVRx/Ma4LBS6lWovUr1OD4ODvRLH+QeuU6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAvdZShSnMielUmLt9itatcuY+ZvX7NBcMK5HNnpCVU=;
 b=pxmi4uzyy/cH9nKxo/+8Zxf4F30YEeRRVepkysK3t90MTNH6tvM7BlXDV2nHl/J1WjAoXs3nBYy5gVSS2yMOughZpARTBta8wTMa+bxBy6UDfREg8CqA4PTKubVXBJRhDK4PGaQ4imYZiTMMoxuVD1jV5Y7QS3h+XuZwAujEbd0gfUAH9hFnw8x5albVP7TX55udNIXAvTjW9YNMVgU8HbaQo99OBWgNL5dW1txhBCVREB2rPOvNpdTEBvzpjqUPKgiVhNgmQ8UBMXhTVXnc8RXIoZu9IRZng6qS78rZdZ/aO5IyNiWxok27SjPwvSuHwL5O9ZeeB7R6iTKgGJtD/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Mon, 27 May
 2024 20:08:59 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Mon, 27 May 2024
 20:08:58 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	SeongJae Park <sj@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v2] selftests/mqueue: fix 5 warnings about signed/unsigned mismatches
Date: Mon, 27 May 2024 13:08:35 -0700
Message-ID: <20240527200835.143682-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::9) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dce7979-fb08-440e-5ae0-08dc7e88d834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g3nYJ6/0U6mpAEf7/c0+mA/5ubjtvJXdjSrkNtc43SOE9dLNlsLLGJyZ2ecc?=
 =?us-ascii?Q?WEUbtdAXtRxGluQqbml+hRiBYT5miokzxIZ7tNYJiE0uDo8zya+f/gcxMJxN?=
 =?us-ascii?Q?3ESlCF/njXtIMHf8gZq66uqd1YalVs5siHCWsrkupN6Xmu/dUuehilafcHoB?=
 =?us-ascii?Q?PJxwAdlPJIGh+il5C2l7dko4p8E+g4v/GrQWnoDPe0YZaZxzFtruHGOWH3PO?=
 =?us-ascii?Q?uyblG6UvTIfKh6jpNXxAUFydKF4bixQ+8vhk0QFVMGnde0N+2bZROk7CgJmw?=
 =?us-ascii?Q?94RfZai7dYpz8TMr6aUvc1G865hoxdJjcMXNVIEw/HH5GyOl0UpXfFflANnp?=
 =?us-ascii?Q?c5Bu/xOCMAIpd+lAr037pEfBE0RslcHtUdBi8WS5kf85RA2HunWZfkxRH8dA?=
 =?us-ascii?Q?U0AoE8W9pevC6cevS/+2TYhx0HS7YGRdzD2TAzzEE/awE8Gcwf9xL+TLfmVB?=
 =?us-ascii?Q?AfWOq5nmJxD8R7uHqP50VZ9jOwLrIPqbqOrDWgvQoDsvIEcmpgncrhcRIF5s?=
 =?us-ascii?Q?ikJ098ThiTZNv0I1egXHm/x0ucUjaSJGkmYS9gVh8zvM2xOCQT+YIU75QXS8?=
 =?us-ascii?Q?dwbqApDEbW4TYITURLJbjghs7Z7UGbmxjzQFNePnnfYMRp6InTuDTJkIm3aT?=
 =?us-ascii?Q?sa21HWIKpXiW4lLCi4QEUed8Dme9Pma8dVXHKEOetCPZtRmLMwynFRkkF2wO?=
 =?us-ascii?Q?MNSdR5WoVVkZbCT2CWwyzSE/k+swC7GZno9VwHgZhreZXTawcjFNp1YjWDc7?=
 =?us-ascii?Q?+ouVMT37qUrdoydlieqZ+yQtUG7HGMOblyN5j5RX5Tedzq6ka3OFMC0HYITs?=
 =?us-ascii?Q?l44INF5ID+6zpPlminGhM4LubPPynP/Qr5PB4OchjAXqs3FFGzF7jrGaTZ2m?=
 =?us-ascii?Q?FEuqfxTBx+HTJ4CAGMwIFwcR87f3eoJ+v1sWzDR3L2n0EQEUrmmp6epvFrVx?=
 =?us-ascii?Q?vNpqF4VH4yDk8yA/bbJiwWhLU+f7HG6IYtanJOsfxaEyETFgme8HBnQOX7de?=
 =?us-ascii?Q?jfkNwMApbSDjmOZqGqj9z7W/TEDZEj0DtLSAJpM91Et6jflBGi3LdjT1MUnI?=
 =?us-ascii?Q?Cx2JK6BtQo93tiWDdRJKkZ4OhSVfPk8kNZ2OlBYVKt9UGNvKUk809IfivVgz?=
 =?us-ascii?Q?I70xVGciW4HcvvQApSR2/j8VJGybCfDCmEGAjhZJpHrh+pglvURrbHhfPAzB?=
 =?us-ascii?Q?M4hTO5AMLXaHbdHp//cSL6qwZfCM+B7p8iY90LZjC9eA+XFezvQwEQhgnCQO?=
 =?us-ascii?Q?K7U7C6OD+uPIf1yTVZu0j1pYLubEuTe8n3ejfuW6xQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6w5dVHKCu7My8FO7NKVC+CZ7XBnIcabi9MMPf2uvaj+vfbnV+oMUgI5AUJJt?=
 =?us-ascii?Q?MMAOMYUyq2LQKpVPzlIDekWi0PaygqgXaKE6h2I2nHesPCfnE25pTH0w1R8w?=
 =?us-ascii?Q?oDxUc01tk4aCOGhtNcpQILSvGHZI3HCKOrhtjDcq5VjMBQJGA0dYRgtlAKzv?=
 =?us-ascii?Q?pju9MBaICYMmsJTn/pP/exl1rWcN9tADbwRCWnDcxMDOUH6N7xObfDUy1IA0?=
 =?us-ascii?Q?VsgDSlgFFXfYqCh1Y/FDsz5XZWQbofHOG8TcraLTtDO48M+7dyVqB8zAlI9P?=
 =?us-ascii?Q?6+5sXXBFk6n8TLRysqCwHfoNCeLV0nNVINllD9NKxEd/Wl9hdPXU3JeWKm2u?=
 =?us-ascii?Q?GUdQvpuutCjhiC9ByJlvIgCi2ueysxKSvn5NltUpyLrDZDk+1ymbvr0JPhDc?=
 =?us-ascii?Q?2Wr34WUuL4H/KEsl1WIt8e4+2BNetIJxJJrQKqwDBAXlpuzEJWvbKr550Kgr?=
 =?us-ascii?Q?KFFl+Ql8CfjHtwVTUSaQ54xAtkcB5qPKjYM3IelLqqjkZO2WrCJdvt1w5pOh?=
 =?us-ascii?Q?tRU006Xmzx0vSTg40lRDfHGJuzXG8vVe0OzpxAl5GSxnJYVb1vCvqK3MmmJP?=
 =?us-ascii?Q?T8M4quHM+Fhbz/TxVCtDZZtBXyM4zuzUFKFAwBB35JPtl+VQLKxT5icwvfa4?=
 =?us-ascii?Q?EfojjLuT98PD/WSebPauZktsaIs9idWjcxkupl87jGDr8vvaJ1mr70nyku8j?=
 =?us-ascii?Q?s5vEvnLHZR6xdd0s6jg/6vGGQVyDgZ9ictWsaiVbLirr8RNp6/GNYDwF5FF8?=
 =?us-ascii?Q?DeY/GHYfR8T9CIcbIKClLC5bXMSNFF8hjgKdFu6OIZhwg1+9SqrAI/XWd09F?=
 =?us-ascii?Q?h/VfvSUqpeyFWW54vlOIDzpTWysyOeSh556BPs2Xtzxfs7MyQkxB7DChGQTt?=
 =?us-ascii?Q?cknl9Vs5+CKRwnrOkckYcBcVsCBZqj/5ITaSkCC4KXfKKPbD3pgntjM3CMwH?=
 =?us-ascii?Q?BMHK7voXvDsIJ1xIzEIl3vXtzdju6D39mGM7gqpWzpVPruhci69Iiwc9c8uo?=
 =?us-ascii?Q?TNMg4M1moYrOHHeivnLjD+V9KDabzu07f2Xh3NyWiLkIefOWVtdG4b+XRwGy?=
 =?us-ascii?Q?7vlqL3pyKVQodm9r8AxUlcdi7JPs69EuYO/a6wffJ+IHu7D1wVpZmTa20ezl?=
 =?us-ascii?Q?DJmxfZ7rtIFwULdi7DENBC+id7x1q/GuLFZRAkQP2PL9rw+SnCAWlYjn/sEU?=
 =?us-ascii?Q?s55s5GvCOhBHr6epfMFrKYL28yVJA7pz3QB0IM+/tHs17yMhKRB+Das6h56P?=
 =?us-ascii?Q?W34QAuFOgm7qQ4gwE6TAKljIxR1EkY/qL02Od1GTn4C9enW3lS1RtU9AWZYk?=
 =?us-ascii?Q?G7nBD9fFAzJhY7hDfD1jgzr7zi+QCgWE9nqajsbKE4bjZmmCs+f/5iSguswj?=
 =?us-ascii?Q?+2l3EJxz3+Bw2+Zz3RePDwwK6mFrOD3VRsVIMKpkMIzfvjIj1N2UJgkQGCj/?=
 =?us-ascii?Q?BSViBhHIZYE6fQfyBYe7KR2JKaGcHj7tP9E2kcBDdlBg7sRcE4Bbjmz+l7sk?=
 =?us-ascii?Q?joOU9qKzKHNb1bsY/SBG4MiQmAMFKLSBegEpJRSOyECiW1eA1AC4t4Bg9my6?=
 =?us-ascii?Q?IqDHDmPTEmY+QVk15w9wnleGktr+sMioUbBhQflgG39iNPMuJUZBTHHdO+VN?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dce7979-fb08-440e-5ae0-08dc7e88d834
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 20:08:58.8806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrlOopL1phKUNsAMbgfGrlZTx8LpcRtGKkpbXht0+jqqlTz+HYjOnp+7OgSMa/Of5cAZ9uaI25U2t6RE0ry5lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773

When building with clang, via:

    make LLVM=1 -C tools/testing/selftest

...clang warns about several cases of using a signed integer for the
priority argument to mq_receive(3), which expects an unsigned int.

Fix this by declaring the type as unsigned int in all cases.

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Changes since the first version:

1) Rebased onto Linux 6.10-rc1

2) Reviewed-by's added.

thanks,
John Hubbard

 tools/testing/selftests/mqueue/mq_perf_tests.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
index 5c16159d0bcd..fb898850867c 100644
--- a/tools/testing/selftests/mqueue/mq_perf_tests.c
+++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
@@ -323,7 +323,8 @@ void *fake_cont_thread(void *arg)
 void *cont_thread(void *arg)
 {
 	char buff[MSG_SIZE];
-	int i, priority;
+	int i;
+	unsigned int priority;
 
 	for (i = 0; i < num_cpus_to_pin; i++)
 		if (cpu_threads[i] == pthread_self())
@@ -425,7 +426,8 @@ struct test test2[] = {
 void *perf_test_thread(void *arg)
 {
 	char buff[MSG_SIZE];
-	int prio_out, prio_in;
+	int prio_out;
+	unsigned int prio_in;
 	int i;
 	clockid_t clock;
 	pthread_t *t;

base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
-- 
2.45.1


