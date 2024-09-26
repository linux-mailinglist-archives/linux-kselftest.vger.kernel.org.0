Return-Path: <linux-kselftest+bounces-18401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F129987664
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 17:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81ABF1C242B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6DF1547FD;
	Thu, 26 Sep 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTcd6+ND"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723564D8C8
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364062; cv=none; b=Mm131VpPZqRAnPznvwTBkMUJOnbN2wvzhNYKOIzLZXBJDbiVx1cKudDwyxJ+FnzmBAUqjVFG/nk7OP39wuq9Q7tPhcSfPwo+5vtAk3vsHQZC+Xz5fZ9l/b6YIeJFF5mxV4HD0IdfU64hLz1hgQjQSVMukbe/GSAA+u9nfXftYeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364062; c=relaxed/simple;
	bh=XBqWDfNJG/2q9rjmUvR7KopetYbDazuFgLdnXBBgHJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pq7b75WevfQwt7CJwt4VYT7HuC/nM3cIaWa5X60krPOxXp4PkKIJOGZ8PLsbPSm+S54OWER6WMx2jaG7QMzIMJRB5zvil8Q1Eu+QLVKURLkhMj6vm0y+UOs+YiTjvbAUVvIcnTRx64AmEMXGhm8DiYo6yZrYFRecx8vBSVFpBRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTcd6+ND; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727364060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnbjnYmt3l0aTxSupRXPM1juyT6aAAemxQXR6PSRwdY=;
	b=GTcd6+NDNpTk93ZC6y8gj8odeAv/IjDmKayVQAVlzwE0A+2ACBEMiihhmtr4YZELcbPR5i
	tvATEwm/QtMjgKHPUNw1kFq+IMi1I9o1aYayjDkJdmtpFRyFpfDDJoEMVh5/ihXjuefJc6
	ux+CATSteh3zBd7Ht68IloyolyqIXv4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-ZKadytkVMWCA608fWmDaRg-1; Thu,
 26 Sep 2024 11:20:57 -0400
X-MC-Unique: ZKadytkVMWCA608fWmDaRg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 229791936CF3;
	Thu, 26 Sep 2024 15:20:56 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.16.71])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A157C1944D16;
	Thu, 26 Sep 2024 15:20:53 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Mario Casquero <mcasquer@redhat.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH v1 2/2] selftests/mm: hugetlb_fault_after_madv: improve test output
Date: Thu, 26 Sep 2024 17:20:44 +0200
Message-ID: <20240926152044.2205129-3-david@redhat.com>
In-Reply-To: <20240926152044.2205129-1-david@redhat.com>
References: <20240926152044.2205129-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Let's improve the test output. For example, print the proper test
result. Install a SIGBUS handler to catch any SIGBUS instead of
crashing the test on failure.

With unsuitable hugetlb page count:
  $ ./hugetlb_fault_after_madv
  TAP version 13
  1..1
  # [INFO] detected default hugetlb page size: 2048 KiB
  ok 2 # SKIP This test needs one and only one page to execute. Got 0
  # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

On a failure:
  $ ./hugetlb_fault_after_madv
  TAP version 13
  1..1
  not ok 1 SIGBUS behavior
  Bail out! 1 out of 1 tests failed

On success:
  $ ./hugetlb_fault_after_madv
  TAP version 13
  1..1
  # [INFO] detected default hugetlb page size: 2048 KiB
  ok 1 SIGBUS behavior
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../selftests/mm/hugetlb_fault_after_madv.c   | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/hugetlb_fault_after_madv.c b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
index ff3ba675278d..e2640529dbb2 100644
--- a/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
+++ b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
@@ -5,6 +5,8 @@
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <unistd.h>
+#include <setjmp.h>
+#include <signal.h>
 
 #include "vm_util.h"
 #include "../kselftest.h"
@@ -14,11 +16,25 @@
 static char *huge_ptr;
 static size_t huge_page_size;
 
+static sigjmp_buf sigbuf;
+static bool sigbus_triggered;
+
+static void signal_handler(int signal)
+{
+	if (signal == SIGBUS) {
+		sigbus_triggered = true;
+		siglongjmp(sigbuf, 1);
+	}
+}
+
 /* Touch the memory while it is being madvised() */
 void *touch(void *unused)
 {
 	char *ptr = (char *)huge_ptr;
 
+	if (sigsetjmp(sigbuf, 1))
+		return NULL;
+
 	for (int i = 0; i < INLOOP_ITER; i++)
 		ptr[0] = '.';
 
@@ -44,13 +60,23 @@ int main(void)
 	 * interactions
 	 */
 	int max = 10000;
+	int err;
+
+	ksft_print_header();
+	ksft_set_plan(1);
 
 	srand(getpid());
 
+	if (signal(SIGBUS, signal_handler) == SIG_ERR)
+		ksft_exit_skip("Could not register signal handler.");
+
 	huge_page_size = default_huge_page_size();
 	if (!huge_page_size)
 		ksft_exit_skip("Could not detect default hugetlb page size.");
 
+	ksft_print_msg("[INFO] detected default hugetlb page size: %zu KiB\n",
+		       huge_page_size / 1024);
+
 	free_hugepages = get_free_hugepages();
 	if (free_hugepages != 1) {
 		ksft_exit_skip("This test needs one and only one page to execute. Got %lu\n",
@@ -73,5 +99,11 @@ int main(void)
 		munmap(huge_ptr, huge_page_size);
 	}
 
-	return KSFT_PASS;
+	ksft_test_result(!sigbus_triggered, "SIGBUS behavior\n");
+
+	err = ksft_get_fail_cnt();
+	if (err)
+		ksft_exit_fail_msg("%d out of %d tests failed\n",
+				   err, ksft_test_num());
+	ksft_exit_pass();
 }
-- 
2.46.1


