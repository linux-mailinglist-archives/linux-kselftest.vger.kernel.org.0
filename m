Return-Path: <linux-kselftest+bounces-45078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8F6C3F7DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 11:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B14C3A38D1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BCA322774;
	Fri,  7 Nov 2025 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kED9AsCl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9DD320CBF;
	Fri,  7 Nov 2025 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511435; cv=fail; b=pn0TApNpne41FMeTJo6nB6NQAY45+ymw2uNsjIx4mBuM+/YhztWPT1yNuBFKCE7hUfG8nWmTFSSMnEwCeuhPGMFAnTNcogVUFLETSUD/87jmvkQu96MlQOAgcvu+i3mWOTdxvNNM7lK7QjVTVN9lA+L9vxgGcFNkeOT7B2zr/MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511435; c=relaxed/simple;
	bh=YDig1/ulXJiK4BMA2ClROq9MzOUYtvUgzz/80LfgDpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjdlgR4aiCGN6SQY4pObTNclDfIwHfzt9jux+7Fr91zsIUYcd+OSam43ykQS925AraaQTWbivE9jF8v6kc7ad892Qv4WAr3B+NxUkjgly0RYDLYQlHNzwi6vmHQ4lEFHRzM2jbOJiYm3mEtg6qae55yLqfPgk+7pij1WcP3ztE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kED9AsCl; arc=fail smtp.client-ip=52.101.48.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvm/sDcc+eREu7WVp/KevN5Hs2rB0T7FnbIZMAz67PJfHkhoSzK2eUi9g5CqjCfhgU+faQ76/GRo5CBacLjlfL7xEP/cLN2qx3Toe07Sx1B/PsRO9bUDVriCy5lQdM76C3oNsKkUbZeUw9DDERrjNOgehOk7its8y5/+9NhBLCo6Z7FY6AqCddIxp6OIKev1r+wPhjpntanBbOGhDQpb/N12wX7owXb0Nz7AT8pCNn+rj9SzwGdl5BXMSChFXkDVzdrnMLmnslNRVw5ENwBTrESjJdW+FOKzdFU3n1hZBU3Qm5OkThJQeGWYXvnLsmxi7YKOBAAkRcq+ka/Kp1fpQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaeLEZ5sF2mVL2TahAify3GyrPWSZ8VkbOUQmg/QtN0=;
 b=lNm3M59WjgZ62H4tlWPgfeV5pvNH9ocFuAezDDbKIrrxVq3ZyuNrBl1lFLSbaUBd52DIktyY2uRDsgMayOuK4Ui3R5wdoVP2Ibs3yCUbmdbVy0ENJOY9ku/ao7wpreXUax6rvzI5EXDsg6K5hnms8DDfTaLZY5M2vV7ZrxPHNJt/8cD7xfVEXySDGkpY1irQR85L9Yq9Euw68gnFCxsSRedJ77cv76J0y/goOLjBBZ5XlZ0v1JKYkLRUbNgI1StSaD5hdualDHKnVyF/MzbB1Ri7C6hC+c3jX54vvWUc+4HPVZWTUZTY0xuo4m5EwR5Y/8meuyc6LAJoziGOqJNAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaeLEZ5sF2mVL2TahAify3GyrPWSZ8VkbOUQmg/QtN0=;
 b=kED9AsClBdbllrFZR42pBGMRxaKYYUkkM1vlPs8L2EnGonhG05+RdImfQCyghw9QWzfrg0jaftXJf7S2M/o9V0MRyp4sj8arzSfxIVGOOcawl9Hn9htC3d/xU/hHRBHU4Bdua/8E8LCq6AyvwSDDM+Mp3Dvx0i0hYmwEY2kG7RTzREDSbxy2tkj5pHNWVRm3mH+D2MF4Ez/lEDhzbA1eS1LCPdrCwCbC60a+CkjWKxPGpMm/Ouzj42RKppjCjYtpCaNUKCe9kvZ/DxsnKwmdpo/BQkGMKNO7d7ophjvpERh7gsBF3YaOzn9H7pRjF5z3eFQT11nZl3ZYetM/2utSbQ==
Received: from BL0PR0102CA0065.prod.exchangelabs.com (2603:10b6:208:25::42) by
 PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Fri, 7 Nov 2025 10:30:23 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:25:cafe::cb) by BL0PR0102CA0065.outlook.office365.com
 (2603:10b6:208:25::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 10:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Fri, 7 Nov 2025 10:30:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 02:30:09 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 7 Nov 2025 02:30:08 -0800
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 7 Nov
 2025 02:30:05 -0800
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer
	<hawk@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Shuah Khan <shuah@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC 1/2] page_pool: add benchmarking for napi-based recycling
Date: Fri, 7 Nov 2025 12:28:45 +0200
Message-ID: <20251107102853.1082118-4-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251107102853.1082118-2-dtatulea@nvidia.com>
References: <20251107102853.1082118-2-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|PH7PR12MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c546f4-3fcf-434b-2488-08de1de8a87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QRSb8Vh1eTOQ8NHVBy73zTrwoGIyfgxBd3kjD49SyHL6v8NlSW2LJNxp2pFa?=
 =?us-ascii?Q?n8P7/9N86UMel2v9QI8A6fru9BbRYHMPwr3U3zTTM2xlo5wEFY6Hg0c9/qvS?=
 =?us-ascii?Q?4612UwW2ESKQjG/5IgwNUEUEoGNIttt7iXf/TfwAG1+ScCCFIjgg/ToMPZT2?=
 =?us-ascii?Q?/CS2Lg66DN+yjJKWNbeIeKbnlEJ6bsoNWNIYnofGYZbeY+8f6zRlIaxSfJ81?=
 =?us-ascii?Q?cN2goKZAyhCWd81oytw21b7cxQwt0uezePc757ao6Xn7+s82+sr6vGhuMCHK?=
 =?us-ascii?Q?RzcZwMW8aYrrjGpTzd/jCTzZ+vr7g748g847qpyIH0Wgiqrx9IYXoTjgcjkK?=
 =?us-ascii?Q?5QJzXL8O9BRS6K822pvtlo5Sq2GVcovcd0b5vRXIBRdUxID6he3rDM/uA3if?=
 =?us-ascii?Q?mWx4023QOBOh4jv/+u909XqOZy/i/9XjDZp5RjfBpS4iA84gFoZayBSwPXD4?=
 =?us-ascii?Q?QBsaLo2ljPZU2sA7xIE9NV2dXdbb8ZSW+QPnUm7dJbj1r5PjJ9bhBt3IX5rv?=
 =?us-ascii?Q?XTZyA409yEkdGnlFzs5d4k4w3mQP7k257uYwr23V3Faoeek7RQ7IZr/RDTAI?=
 =?us-ascii?Q?mWpqlg5A0j3T3L9hStUpItokyl8rcF260z3Y49yVLRy+I3vszDTxcsN/k3g6?=
 =?us-ascii?Q?1/ri0FzI9l5LqZ4WFjqcIjd+bs1EDpPyOcrpTlkyNJG52hdTzvm+31DwhAdo?=
 =?us-ascii?Q?LPEUnHVT2IUamWKgiSn+30XbKZTz2M3Xp+d/m+wBlvlVIirqAyQs5j97Ws5/?=
 =?us-ascii?Q?cXGTo+Go1xmcM3jXIaFMhn0Xk74LY6voZGKhghakY86Kp5glZoAQx+fif5WN?=
 =?us-ascii?Q?PhYVEBKhA6/0qp+/pK93jb2biWyWzPPig45ZTGtoVHb/Dj1sKzRhKCKYApLi?=
 =?us-ascii?Q?h7AWp08R08QHgDnunBf1e7y2z5OKBwyEM8HJnbp/QMAIS1o55aq7CNQwdRdr?=
 =?us-ascii?Q?xmxAbNe1Yc39AjDusxkgMRANYBpk9/Xb62RgzN6Wx4iv366HInkUTqYp6nQJ?=
 =?us-ascii?Q?T0Jm27kAxmE3HxTeWrjUZAzr3qRIuL5ZVUXSsVmDSZmvwq/tl0PP986M2pq0?=
 =?us-ascii?Q?/didiT0daBjnNAtKwV6XnlMadGNvXRxzK5tDyYZeWRvcpmhZYvpkUJT40Dmd?=
 =?us-ascii?Q?IJcDdC9ZXYJ6tyzYBdXoaIxAXeBZuXvaPgLMXs7UWwMJ3HTlZL7zIh2/f+kF?=
 =?us-ascii?Q?gShzqRVrMmWTYCMZhXzTHM2k+0r+dEYNQCKX1ZYGWTceL3dEPahqCMSGWn3j?=
 =?us-ascii?Q?9vEL2joUngPyrzaWCnT6V/CezTktBdtWsIhF51N1dJwHze09RFpulijm8i+q?=
 =?us-ascii?Q?Jw/WHz4stxnY7MkZYBb9YLKnpTFQT5nMiUBh/JMNYBqOlTvcXXhT/SfPK5Cw?=
 =?us-ascii?Q?fS51ubkLA3jkhlELOBq3ic6DkqDs2ochotnnnymALwJtjoXBXHRHXExC16tA?=
 =?us-ascii?Q?QAQtt5z6VXs/Ao0R8LU2eihrcDkqjpETEyUUcCduEtcN2Q6qYVeFnjBi5whP?=
 =?us-ascii?Q?Nu8fDxeTW+rpfInRR3kTAfMi4Ppo0irv9e/GqS+kgKWoG0Hi/duBsAWP5EZu?=
 =?us-ascii?Q?cENpzlSFEtAsNb/A4UA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:30:22.7823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c546f4-3fcf-434b-2488-08de1de8a87d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595

The code brings back the tasklet based code in order
to be able to run in softirq context.

One additional test is added which benchmarks the
impact of page_pool_napi_local().

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 .../bench/page_pool/bench_page_pool_simple.c  | 92 ++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c b/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
index cb6468adbda4..84683c547814 100644
--- a/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
+++ b/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
@@ -9,6 +9,7 @@
 #include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/netdevice.h>
 #include <net/page_pool/helpers.h>
 
 #include "time_bench.h"
@@ -16,6 +17,8 @@
 static int verbose = 1;
 #define MY_POOL_SIZE 1024
 
+DEFINE_MUTEX(wait_for_tasklet);
+
 /* Makes tests selectable. Useful for perf-record to analyze a single test.
  * Hint: Bash shells support writing binary number like: $((2#101010)
  *
@@ -31,6 +34,10 @@ enum benchmark_bit {
 	bit_run_bench_no_softirq01,
 	bit_run_bench_no_softirq02,
 	bit_run_bench_no_softirq03,
+	bit_run_bench_tasklet01,
+	bit_run_bench_tasklet02,
+	bit_run_bench_tasklet03,
+	bit_run_bench_tasklet04,
 };
 
 #define bit(b)		(1 << (b))
@@ -120,7 +127,12 @@ static void pp_fill_ptr_ring(struct page_pool *pp, int elems)
 	kfree(array);
 }
 
-enum test_type { type_fast_path, type_ptr_ring, type_page_allocator };
+enum test_type {
+	type_fast_path,
+	type_napi_aware,
+	type_ptr_ring,
+	type_page_allocator,
+};
 
 /* Depends on compile optimizing this function */
 static int time_bench_page_pool(struct time_bench_record *rec, void *data,
@@ -132,6 +144,7 @@ static int time_bench_page_pool(struct time_bench_record *rec, void *data,
 
 	struct page_pool *pp;
 	struct page *page;
+	struct napi_struct napi = {0};
 
 	struct page_pool_params pp_params = {
 		.order = 0,
@@ -141,6 +154,7 @@ static int time_bench_page_pool(struct time_bench_record *rec, void *data,
 		.dev = NULL, /* Only use for DMA mapping */
 		.dma_dir = DMA_BIDIRECTIONAL,
 	};
+	struct page_pool_stats stats = {0};
 
 	pp = page_pool_create(&pp_params);
 	if (IS_ERR(pp)) {
@@ -155,6 +169,11 @@ static int time_bench_page_pool(struct time_bench_record *rec, void *data,
 	else
 		pr_warn("%s(): Cannot use page_pool fast-path\n", func);
 
+	if (type == type_napi_aware) {
+		napi.list_owner = smp_processor_id();
+		page_pool_enable_direct_recycling(pp, &napi);
+	}
+
 	time_bench_start(rec);
 	/** Loop to measure **/
 	for (i = 0; i < rec->loops; i++) {
@@ -173,7 +192,13 @@ static int time_bench_page_pool(struct time_bench_record *rec, void *data,
 			page_pool_recycle_direct(pp, page);
 
 		} else if (type == type_ptr_ring) {
-			/* Normal return path */
+			/* Normal return path, either direct or via ptr_ring */
+			page_pool_put_page(pp, page, -1, false);
+
+		} else if (type == type_napi_aware) {
+			/* NAPI-aware recycling: uses fast-path recycling if
+			 * possible.
+			 */
 			page_pool_put_page(pp, page, -1, false);
 
 		} else if (type == type_page_allocator) {
@@ -188,6 +213,14 @@ static int time_bench_page_pool(struct time_bench_record *rec, void *data,
 		}
 	}
 	time_bench_stop(rec, loops_cnt);
+
+	if (type == type_napi_aware) {
+		page_pool_get_stats(pp, &stats);
+		if (stats.recycle_stats.cached < rec->loops)
+			pr_warn("%s(): NAPI-aware recycling wasn't used\n",
+				func);
+	}
+
 out:
 	page_pool_destroy(pp);
 	return loops_cnt;
@@ -211,6 +244,54 @@ static int time_bench_page_pool03_slow(struct time_bench_record *rec,
 	return time_bench_page_pool(rec, data, type_page_allocator, __func__);
 }
 
+static int time_bench_page_pool04_napi_aware(struct time_bench_record *rec,
+					     void *data)
+{
+	return time_bench_page_pool(rec, data, type_napi_aware, __func__);
+}
+
+/* Testing page_pool requires running under softirq.
+ *
+ * Running under a tasklet satisfy this, as tasklets are built on top of
+ * softirq.
+ */
+static void pp_tasklet_handler(struct tasklet_struct *t)
+{
+	uint32_t nr_loops = loops;
+
+	if (in_serving_softirq())
+		pr_warn("%s(): in_serving_softirq fast-path\n",
+			__func__); // True
+	else
+		pr_warn("%s(): Cannot use page_pool fast-path\n", __func__);
+
+	if (enabled(bit_run_bench_tasklet01))
+		time_bench_loop(nr_loops, 0, "tasklet_page_pool01_fast_path",
+				NULL, time_bench_page_pool01_fast_path);
+
+	if (enabled(bit_run_bench_tasklet02))
+		time_bench_loop(nr_loops, 0, "tasklet_page_pool02_ptr_ring",
+				NULL, time_bench_page_pool02_ptr_ring);
+
+	if (enabled(bit_run_bench_tasklet03))
+		time_bench_loop(nr_loops, 0, "tasklet_page_pool03_slow", NULL,
+				time_bench_page_pool03_slow);
+
+	if (enabled(bit_run_bench_tasklet04))
+		time_bench_loop(nr_loops, 0, "tasklet_page_pool04_napi_aware",
+				NULL, time_bench_page_pool04_napi_aware);
+
+	mutex_unlock(&wait_for_tasklet); /* Module __init waiting on unlock */
+}
+DECLARE_TASKLET_DISABLED(pp_tasklet, pp_tasklet_handler);
+
+static void run_tasklet_tests(void)
+{
+	tasklet_enable(&pp_tasklet);
+	/* "Async" schedule tasklet, which runs on the CPU that schedule it */
+	tasklet_schedule(&pp_tasklet);
+}
+
 static int run_benchmark_tests(void)
 {
 	uint32_t nr_loops = loops;
@@ -251,12 +332,19 @@ static int __init bench_page_pool_simple_module_init(void)
 
 	run_benchmark_tests();
 
+	mutex_lock(&wait_for_tasklet);
+	run_tasklet_tests();
+	/* Sleep on mutex, waiting for tasklet to release */
+	mutex_lock(&wait_for_tasklet);
+
 	return 0;
 }
 module_init(bench_page_pool_simple_module_init);
 
 static void __exit bench_page_pool_simple_module_exit(void)
 {
+	tasklet_kill(&pp_tasklet);
+
 	if (verbose)
 		pr_info("Unloaded\n");
 }
-- 
2.50.1


