Return-Path: <linux-kselftest+bounces-16966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513D2968741
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 14:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BFCB22B8B
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BDB3DAC0A;
	Mon,  2 Sep 2024 12:09:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E699201246;
	Mon,  2 Sep 2024 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278970; cv=none; b=NTF7wP5HJ2TMokMVQ8+dZUlQ1PbDSK4l9kG5F1ThDV3aDasc24n/UDtzFAnlzzcYEJc1mYDLiGZBD0YZMaOr6+fvRWx5/pgAFl+J3+vJAkIARG+45T0+359Le+ND4mhC/L/2D0CMYnaBYUcwhqAgtHb2IWPDVXiHRIywixUwZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278970; c=relaxed/simple;
	bh=d1qWoWcVW4USTfMVy2yf0oJ879YUKelwXNFLCaVNbqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4nacl9huL2NEq9H/bUqqQPiep9fqz8QNAXvJ1Fr0imGqzKRiYPvVcBG0zHIVW7BBO5RD+SbSd6F5CtabqhLTX6HUK5FqaDiPxvDpV6qlbh/nAng165jPdp4UiTahUTBpsgO3YxBMu2gN8cVSibLPPHqQzWYTSvtZiynGmBRTJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wy6qy54QNz20nLc;
	Mon,  2 Sep 2024 20:04:30 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A3AAD18001B;
	Mon,  2 Sep 2024 20:09:25 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 20:09:25 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
	<linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v17 11/14] mm: page_frag: add testing for the newly added prepare API
Date: Mon, 2 Sep 2024 20:03:10 +0800
Message-ID: <20240902120314.508180-12-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240902120314.508180-1-linyunsheng@huawei.com>
References: <20240902120314.508180-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Add testing for the newly added prepare API, for both aligned
and non-aligned API, also probe API is also tested along with
prepare API.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 .../selftests/mm/page_frag/page_frag_test.c   | 66 +++++++++++++++++--
 tools/testing/selftests/mm/run_vmtests.sh     |  4 ++
 tools/testing/selftests/mm/test_page_frag.sh  | 31 +++++++++
 3 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/page_frag/page_frag_test.c b/tools/testing/selftests/mm/page_frag/page_frag_test.c
index a4bd543d6950..7cfa896f69cb 100644
--- a/tools/testing/selftests/mm/page_frag/page_frag_test.c
+++ b/tools/testing/selftests/mm/page_frag/page_frag_test.c
@@ -27,6 +27,10 @@ static bool test_align;
 module_param(test_align, bool, 0);
 MODULE_PARM_DESC(test_align, "use align API for testing");
 
+static bool test_prepare;
+module_param(test_prepare, bool, 0);
+MODULE_PARM_DESC(test_prepare, "use prepare API for testing");
+
 static int test_alloc_len = 2048;
 module_param(test_alloc_len, int, 0);
 MODULE_PARM_DESC(test_alloc_len, "alloc len for testing");
@@ -67,6 +71,18 @@ static int page_frag_pop_thread(void *arg)
 	return 0;
 }
 
+static void frag_frag_test_commit(struct page_frag_cache *nc,
+				  struct page_frag *prepare_pfrag,
+				  struct page_frag *probe_pfrag,
+				  unsigned int used_sz)
+{
+	WARN_ON_ONCE(prepare_pfrag->page != probe_pfrag->page ||
+		     prepare_pfrag->offset != probe_pfrag->offset ||
+		     prepare_pfrag->size != probe_pfrag->size);
+
+	page_frag_commit(nc, prepare_pfrag, used_sz);
+}
+
 static int page_frag_push_thread(void *arg)
 {
 	struct ptr_ring *ring = arg;
@@ -80,13 +96,52 @@ static int page_frag_push_thread(void *arg)
 		int ret;
 
 		if (test_align) {
-			va = page_frag_alloc_align(&test_nc, test_alloc_len,
-						   GFP_KERNEL, SMP_CACHE_BYTES);
+			if (test_prepare) {
+				struct page_frag prepare_frag, probe_frag;
+				void *probe_va;
+
+				va = page_frag_alloc_refill_prepare_align(&test_nc,
+									  test_alloc_len,
+									  &prepare_frag,
+									  GFP_KERNEL,
+									  SMP_CACHE_BYTES);
+
+				probe_va = __page_frag_alloc_refill_probe_align(&test_nc,
+										test_alloc_len,
+										&probe_frag,
+										-SMP_CACHE_BYTES);
+				WARN_ON_ONCE(va != probe_va);
+
+				if (likely(va))
+					frag_frag_test_commit(&test_nc, &prepare_frag,
+							      &probe_frag, test_alloc_len);
+			} else {
+				va = page_frag_alloc_align(&test_nc,
+							   test_alloc_len,
+							   GFP_KERNEL,
+							   SMP_CACHE_BYTES);
+			}
 
 			WARN_ONCE((unsigned long)va & (SMP_CACHE_BYTES - 1),
 				  "unaligned va returned\n");
 		} else {
-			va = page_frag_alloc(&test_nc, test_alloc_len, GFP_KERNEL);
+			if (test_prepare) {
+				struct page_frag prepare_frag, probe_frag;
+				void *probe_va;
+
+				va = page_frag_alloc_refill_prepare(&test_nc, test_alloc_len,
+								    &prepare_frag, GFP_KERNEL);
+
+				probe_va = page_frag_alloc_refill_probe(&test_nc, test_alloc_len,
+									&probe_frag);
+
+				WARN_ON_ONCE(va != probe_va);
+				if (likely(va))
+					frag_frag_test_commit(&test_nc, &prepare_frag,
+							      &probe_frag, test_alloc_len);
+			} else {
+				va = page_frag_alloc(&test_nc, test_alloc_len, GFP_KERNEL);
+			}
 		}
 
 		if (!va)
@@ -149,8 +204,9 @@ static int __init page_frag_test_init(void)
 	wait_for_completion(&wait);
 
 	duration = (u64)ktime_us_delta(ktime_get(), start);
-	pr_info("%d of iterations for %s testing took: %lluus\n", nr_test,
-		test_align ? "aligned" : "non-aligned", duration);
+	pr_info("%d of iterations for %s %s API testing took: %lluus\n", nr_test,
+		test_align ? "aligned" : "non-aligned",
+		test_prepare ? "prepare" : "alloc", duration);
 
 	ptr_ring_cleanup(&ptr_ring, NULL);
 	page_frag_cache_drain(&test_nc);
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 96fd470b9f51..e4a36231bbea 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -464,6 +464,10 @@ CATEGORY="page_frag" run_test ./test_page_frag.sh aligned
 
 CATEGORY="page_frag" run_test ./test_page_frag.sh nonaligned
 
+CATEGORY="page_frag" run_test ./test_page_frag.sh aligned_prepare
+
+CATEGORY="page_frag" run_test ./test_page_frag.sh nonaligned_prepare
+
 echo "SUMMARY: PASS=${count_pass} SKIP=${count_skip} FAIL=${count_fail}" | tap_prefix
 echo "1..${count_total}" | tap_output
 
diff --git a/tools/testing/selftests/mm/test_page_frag.sh b/tools/testing/selftests/mm/test_page_frag.sh
index d2b0734a90b5..3bc40a895d0d 100755
--- a/tools/testing/selftests/mm/test_page_frag.sh
+++ b/tools/testing/selftests/mm/test_page_frag.sh
@@ -36,6 +36,8 @@ ksft_skip=4
 SMOKE_PARAM="test_push_cpu=$TEST_CPU_0 test_pop_cpu=$TEST_CPU_1"
 NONALIGNED_PARAM="$SMOKE_PARAM test_alloc_len=75 nr_test=$NR_TEST"
 ALIGNED_PARAM="$NONALIGNED_PARAM test_align=1"
+NONALIGNED_PREPARE_PARAM="$NONALIGNED_PARAM test_prepare=1"
+ALIGNED_PREPARE_PARAM="$ALIGNED_PARAM test_prepare=1"
 
 check_test_requirements()
 {
@@ -74,6 +76,24 @@ run_aligned_check()
 	echo "Check the kernel ring buffer to see the summary."
 }
 
+run_nonaligned_prepare_check()
+{
+	echo "Run performance tests to evaluate how fast nonaligned prepare API is."
+
+	insmod $DRIVER $NONALIGNED_PREPARE_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Ccheck the kernel ring buffer to see the summary."
+}
+
+run_aligned_prepare_check()
+{
+	echo "Run performance tests to evaluate how fast aligned prepare API is."
+
+	insmod $DRIVER $ALIGNED_PREPARE_PARAM > /dev/null 2>&1
+	echo "Done."
+	echo "Check the kernel ring buffer to see the summary."
+}
+
 run_smoke_check()
 {
 	echo "Run smoke test."
@@ -86,6 +106,7 @@ run_smoke_check()
 usage()
 {
 	echo -n "Usage: $0 [ aligned ] | [ nonaligned ] | | [ smoke ] | "
+	echo "[ aligned_prepare ] | [ nonaligned_prepare ] | "
 	echo "manual parameters"
 	echo
 	echo "Valid tests and parameters:"
@@ -106,6 +127,12 @@ usage()
 	echo "# Performance testing for aligned alloc API"
 	echo "$0 aligned"
 	echo
+	echo "# Performance testing for nonaligned prepare API"
+	echo "$0 nonaligned_prepare"
+	echo
+	echo "# Performance testing for aligned prepare API"
+	echo "$0 aligned_prepare"
+	echo
 	exit 0
 }
 
@@ -159,6 +186,10 @@ function run_test()
 			run_nonaligned_check
 		elif [[ "$1" = "aligned" ]]; then
 			run_aligned_check
+		elif [[ "$1" = "nonaligned_prepare" ]]; then
+			run_nonaligned_prepare_check
+		elif [[ "$1" = "aligned_prepare" ]]; then
+			run_aligned_prepare_check
 		else
 			run_manual_check $@
 		fi
-- 
2.33.0


