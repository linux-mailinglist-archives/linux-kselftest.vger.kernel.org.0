Return-Path: <linux-kselftest+bounces-18727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8982798B66C
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 10:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B7D1F227B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 08:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD141C2304;
	Tue,  1 Oct 2024 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdA1azYD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646BE1BF300;
	Tue,  1 Oct 2024 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769612; cv=none; b=mFmLu+dwkjp1uR6Hu6OmE+pshid27/YBXlhZDAbNnOE6lROHRst0571Qoz/5u75KEq0bijF3XRdCHvJ0Ro2ylQE5Oc9JsWfejNS3imktwRlBoqQO/r1KIRBxhJgWRBQxXwT780koHSSKzxA4cnnxWVykQg3xuDhEx4+ApIrA7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769612; c=relaxed/simple;
	bh=p4A2brn8pgGiYPzz8SV7EMrpoIMO7Qn7p4+2bG+sRb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AwGup0bcmqCr2vwAlhCUKW7s/+bh2PdUH4KznGIYxE4EOEWbfir//Oi9qPmgcO+K6X6wA6xN+2DuyxRWqseyxtV83QzYN0M3IK/ADcWbTY3oSEGqlBYdNs05KyP5cBucj4IBZAltGlQjSa73Qaf7aeJWmqBfpT7nbPTadVerTfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdA1azYD; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2e0a060f6e8so3511684a91.1;
        Tue, 01 Oct 2024 01:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727769610; x=1728374410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ojxcdjNvn9tfBEJlcLOUTnmOt/qIyQL5omYnTHVVOo=;
        b=UdA1azYDfkwkCpCrsmNjGdi/rzm3DnhYe82+/SCCrZRq+Ej5k79bp2HoXzwu3+RHCy
         ynKU0x9V3HV1kRfzoZ4o/jmxjnLSj/x9szNGoGlRvMX61VYTf+yBPPEJL5ncRZHLN96A
         Z5idIR2AHgcFbZ5I/MQryiOgYFz+78ip4Dpl4+SqBnUh9Ii4ukh/BpdMcV1cp3YdrgD/
         BukTZImpcjLQDqGnlTz+ls9Adr/5WXZaNNZnWuy2h2wY+vS7IERx9B1SktXs3DuRLUKg
         3xY2jez0kBLh/TDFOu9nDRXGvAHRHB457g6UVRkZeq2k21AXX9gEMVYsQnujGQKmnd8n
         MkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727769610; x=1728374410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ojxcdjNvn9tfBEJlcLOUTnmOt/qIyQL5omYnTHVVOo=;
        b=QYoIQdYH6Y4TZ/GFfQS/0Aq0jitoxn7ws1Di3dHDfw7BdEvFLemU4NGmt7xPhkWZRA
         Ir8XqeBkV6mcUm1jxtiDOq0ZP/x9KkbkXOFpqxMI8a1OnzbtDt2E+oAt7nW2/m3L19jP
         hshFtbgIq5KcvcaD9bqcFK7JzszFkvG1KGapLIjVA2usbN8mEVm8hAbAjVBeUuYMCWGL
         gMjFyHmt+pSnmlnfUp4OPJWAcl5Thji0b0ve8afYfmzvdIlhFRL+LWE/xyeIawUkDo3d
         8XSp0NNs3vd+G4+YQ2cZ/0gZH6QqlMCu5l/tS8Epr8mG8edopOZWGzxErDxlDWZaPI1P
         Q3JA==
X-Forwarded-Encrypted: i=1; AJvYcCVjgDMJxBiukkPu8mOgZp4V0w5IWzxkVECOWA3zX8mMKG0t8lM9QCJcVz8sCPc2iGYcohmCUpTUXwwAHnVyDpeH@vger.kernel.org, AJvYcCW+hCh3xDGMbC7GPdrFdJlCFY/SHeV7RsnLS8/D8GBmVMEAx+K/oW1dJ88kbwuqG1WwC91lZERtU5SG6mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVSdO7bP0qgCCxumcoNnDwSSBHpQeZwL2TodJAnSWeY7vOQaWE
	9vIZh5CLRwjlZvPFHjA3QIORp96QTlkOzW1clN5acI4nCLUrdpx9
X-Google-Smtp-Source: AGHT+IF3IG9U7cija4N7THOiO2nq96RB2NLJHQxqNLCpLLW60MhGNrffUUs5bLpndLyek42gdCV41A==
X-Received: by 2002:a17:90a:f2cf:b0:2e0:b26c:9069 with SMTP id 98e67ed59e1d1-2e0b8ea648cmr15853457a91.25.1727769609750;
        Tue, 01 Oct 2024 01:00:09 -0700 (PDT)
Received: from yunshenglin-MS-7549.. ([2409:8a55:301b:e120:88bd:a0fb:c6d6:c4a2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e16d6d2sm13168168a91.2.2024.10.01.01.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 01:00:09 -0700 (PDT)
From: Yunsheng Lin <yunshenglin0825@gmail.com>
X-Google-Original-From: Yunsheng Lin <linyunsheng@huawei.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v19 11/14] mm: page_frag: add testing for the newly added prepare API
Date: Tue,  1 Oct 2024 15:58:54 +0800
Message-Id: <20241001075858.48936-12-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001075858.48936-1-linyunsheng@huawei.com>
References: <20241001075858.48936-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 36543a129e40..567bcc6a181e 100644
--- a/tools/testing/selftests/mm/page_frag/page_frag_test.c
+++ b/tools/testing/selftests/mm/page_frag/page_frag_test.c
@@ -29,6 +29,10 @@ static bool test_align;
 module_param(test_align, bool, 0);
 MODULE_PARM_DESC(test_align, "use align API for testing");
 
+static bool test_prepare;
+module_param(test_prepare, bool, 0);
+MODULE_PARM_DESC(test_prepare, "use prepare API for testing");
+
 static int test_alloc_len = 2048;
 module_param(test_alloc_len, int, 0);
 MODULE_PARM_DESC(test_alloc_len, "alloc len for testing");
@@ -68,6 +72,18 @@ static int page_frag_pop_thread(void *arg)
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
@@ -152,8 +207,9 @@ static int __init page_frag_test_init(void)
 			test_pushed, test_popped);
 
 	duration = (u64)ktime_us_delta(ktime_get(), start);
-	pr_info("%d of iterations for %s testing took: %lluus\n", nr_test,
-		test_align ? "aligned" : "non-aligned", duration);
+	pr_info("%d of iterations for %s %s API testing took: %lluus\n", nr_test,
+		test_align ? "aligned" : "non-aligned",
+		test_prepare ? "prepare" : "alloc", duration);
 
 	ptr_ring_cleanup(&ptr_ring, NULL);
 	page_frag_cache_drain(&test_nc);
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 2c5394584af4..f6ff9080a6f2 100755
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
index d750d910c899..71c3531fa38e 100755
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
2.34.1


