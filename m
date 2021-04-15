Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E17361273
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Apr 2021 20:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhDOSst (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Apr 2021 14:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbhDOSs1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Apr 2021 14:48:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB0C061350
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Apr 2021 11:47:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c4so3467757ybp.6
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Apr 2021 11:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NPeuLMJJBun5hHaf/B7onZQg8F0X8wxMw6hgTnGDv34=;
        b=vw7MzmYeICCDTRNei7JjvxvzICXL2ZYuT4Nz6yv4/CUGud49o5WkaiMtGUEKjESiNe
         eqeLwt7B9gk5riuJjePaDEIXzryk7b0Mbr38Nkkl820E/HvvH22SX0pF+lA4xhjX6ow5
         dUJYx0Oe3tM0v7Bmsk7r6IDlffnGRxKlJ3WgwXPU6L2juztGfnlihgY7sNzUe1s96oO9
         qOaQs+JmiNApmOMt/72KEifjhtqmiTyp1mTvmMhfqYyC/qbuvzaYjU9gPDKDBcXGswrT
         y/LDRGxE6+iRNjY/2a/jM03q6ztRO1tvKZoMDEzSvPoYumCoj9FTQglvUy8NQBlEogtN
         jxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NPeuLMJJBun5hHaf/B7onZQg8F0X8wxMw6hgTnGDv34=;
        b=YyT1B4ixJ2TZdpzZRJQTH4u/O4aSyUPFtyAyXyI0/SUZemPs0xc2Q05zH0enM6VZ9A
         i6HppJQ2/LSlmzYdSuygTW7rzokUGPjvbYagrW0xrYq993rEXNyOm5YO3ZwtvIlcTZv8
         hHEgDJ3yQtzvfb1vZ4iCOgCa0dhMw7OB0xhJ+Pwi98cUkSj/VngR5dYx0g62DGC+tneN
         wyzTcrSQ/U9GdfILtaNL60lzJYUlOrZWDwwb1hZNcPO7heLP/ecEnQJXSakBgNnyPyRH
         3m578fBAZ0oFfND0nQjCRC620DpmiJzHZyqYosjz7hJv3R3+2vZJ2FgY2nw8F/a+tSAg
         15Zg==
X-Gm-Message-State: AOAM530nnmjy+m9x6eg7EKLKAvYIxNxCArCVSCiqAr9jvE1hri2DG65L
        bGIkldWmjzWqFSHYr1f+mYuGWjYPOkXx27fjPkN7
X-Google-Smtp-Source: ABdhPJxlGnER12EmP/f0nSlgabsWu4do5d+gV2zBolHTH9XXwXG+B3xbsjG4QJWdVxfVM57Q/xab/269EvD9Wg67ANQ7
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:21b1:6e5c:b371:7e3])
 (user=axelrasmussen job=sendgmr) by 2002:a25:3056:: with SMTP id
 w83mr6539422ybw.381.1618512470669; Thu, 15 Apr 2021 11:47:50 -0700 (PDT)
Date:   Thu, 15 Apr 2021 11:47:30 -0700
In-Reply-To: <20210415184732.3410521-1-axelrasmussen@google.com>
Message-Id: <20210415184732.3410521-9-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210415184732.3410521-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v3 08/10] userfaultfd/selftests: exercise minor fault handling
 shmem support
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Enable test_uffdio_minor for test_type == TEST_SHMEM, and modify the
test slightly to pass in / check for the right feature flags.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 29 ++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 3fbc69f513dc..a7ecc9993439 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -474,6 +474,7 @@ static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
 static void continue_range(int ufd, __u64 start, __u64 len)
 {
 	struct uffdio_continue req;
+	int ret;
 
 	req.range.start = start;
 	req.range.len = len;
@@ -482,6 +483,17 @@ static void continue_range(int ufd, __u64 start, __u64 len)
 	if (ioctl(ufd, UFFDIO_CONTINUE, &req))
 		err("UFFDIO_CONTINUE failed for address 0x%" PRIx64,
 		    (uint64_t)start);
+
+	/*
+	 * Error handling within the kernel for continue is subtly different
+	 * from copy or zeropage, so it may be a source of bugs. Trigger an
+	 * error (-EEXIST) on purpose, to verify doing so doesn't cause a BUG.
+	 */
+	req.mapped = 0;
+	ret = ioctl(ufd, UFFDIO_CONTINUE, &req);
+	if (ret >= 0 || req.mapped != -EEXIST)
+		err("failed to exercise UFFDIO_CONTINUE error handling, ret=%d, mapped=%" PRId64,
+		    ret, (int64_t) req.mapped);
 }
 
 static void *locking_thread(void *arg)
@@ -1182,7 +1194,7 @@ static int userfaultfd_minor_test(void)
 	void *expected_page;
 	char c;
 	struct uffd_stats stats = { 0 };
-	uint64_t features = UFFD_FEATURE_MINOR_HUGETLBFS;
+	uint64_t req_features, features_out;
 
 	if (!test_uffdio_minor)
 		return 0;
@@ -1190,9 +1202,17 @@ static int userfaultfd_minor_test(void)
 	printf("testing minor faults: ");
 	fflush(stdout);
 
-	uffd_test_ctx_init_ext(&features);
-	/* If kernel reports the feature isn't supported, skip the test. */
-	if (!(features & UFFD_FEATURE_MINOR_HUGETLBFS)) {
+	if (test_type == TEST_HUGETLB)
+		req_features = UFFD_FEATURE_MINOR_HUGETLBFS;
+	else if (test_type == TEST_SHMEM)
+		req_features = UFFD_FEATURE_MINOR_SHMEM;
+	else
+		return 1;
+
+	features_out = req_features;
+	uffd_test_ctx_init_ext(&features_out);
+	/* If kernel reports required features aren't supported, skip test. */
+	if ((features_out & req_features) != req_features) {
 		printf("skipping test due to lack of feature support\n");
 		fflush(stdout);
 		return 0;
@@ -1426,6 +1446,7 @@ static void set_test_type(const char *type)
 		map_shared = true;
 		test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
+		test_uffdio_minor = true;
 	} else {
 		err("Unknown test type: %s", type);
 	}
-- 
2.31.1.368.gbe11c130af-goog

