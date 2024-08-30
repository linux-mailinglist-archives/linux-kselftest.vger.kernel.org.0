Return-Path: <linux-kselftest+bounces-16782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8FF9660A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 13:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7D61F29798
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 11:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7051B29C5;
	Fri, 30 Aug 2024 11:25:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E1C15C153;
	Fri, 30 Aug 2024 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017106; cv=none; b=MoPo6FRgbfAZXToVEOHTJ3+uSnJi0oMptv5XbVl4rw0fePWBIu6TI4tprsE/EG0hp76ii0jrtvg348+igbjCH6yRjBakejeKCPhJZP9aw1bpJ3MqGXUwx5suL0kSpdKUW5N0lOuREk8907O4wGAdLRN2LZfHwwdKlfseXwcaRx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017106; c=relaxed/simple;
	bh=IUfW2H/bvcutI+nJJf8bITzIrTXLcvdN6Hmuctos/5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wve+yfSFnqbvDhiOXQSMcLHgUYD1dyzsDZqOOXBIS3Lsh8bDelbo7I87AWs/oMug9KFWWQuCUdBuAezlwF0dpdCc1Dgb38j7VM9l6ItjqRjvDWaGx2hveQR2qiSq3GIqFuW6Opi+SZmFrym7aQgRpYI2lWJZHXnpsQ7I4shp5x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WwG052v3VzQr55;
	Fri, 30 Aug 2024 19:20:05 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D6CC180100;
	Fri, 30 Aug 2024 19:24:57 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Aug 2024 19:24:57 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
	<linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v16 11/14] mm: page_frag: add testing for the newly added prepare API
Date: Fri, 30 Aug 2024 19:18:41 +0800
Message-ID: <20240830111845.1593542-12-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240830111845.1593542-1-linyunsheng@huawei.com>
References: <20240830111845.1593542-1-linyunsheng@huawei.com>
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
index e21a22b1d70b..856eacdd1c90 100644
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
index aad55e0ca2cd..753ec4b6fdc3 100755
--- a/tools/testing/selftests/mm/test_page_frag.sh
+++ b/tools/testing/selftests/mm/test_page_frag.sh
@@ -32,6 +32,8 @@ ksft_skip=4
 #
 NONALIGNED_PARAM="test_push_cpu=$TEST_CPU_0 test_pop_cpu=$TEST_CPU_1 test_alloc_len=12 nr_test=512000000"
 ALIGNED_PARAM="$NONALIGNED_PARAM test_align=1"
+NONALIGNED_PREPARE_PARAM="$NONALIGNED_PARAM test_prepare=1"
+ALIGNED_PREPARE_PARAM="$ALIGNED_PARAM test_prepare=1"
 
 check_test_requirements()
 {
@@ -70,6 +72,24 @@ run_aligned_check()
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
@@ -82,6 +102,7 @@ run_smoke_check()
 usage()
 {
 	echo -n "Usage: $0 [ aligned ] | [ nonaligned ] | | [ smoke ] | "
+	echo "[ aligned_prepare ] | [ nonaligned_prepare ] | "
 	echo "manual parameters"
 	echo
 	echo "Valid tests and parameters:"
@@ -102,6 +123,12 @@ usage()
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
 
@@ -155,6 +182,10 @@ function run_test()
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


