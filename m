Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214BB3661FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Apr 2021 00:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbhDTWJO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Apr 2021 18:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbhDTWJA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Apr 2021 18:09:00 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF6AC06138F
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Apr 2021 15:08:24 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id p133-20020a37428b0000b02902de31dd8da3so8210964qka.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Apr 2021 15:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NPeuLMJJBun5hHaf/B7onZQg8F0X8wxMw6hgTnGDv34=;
        b=ZreUEMGX5w46ttG+DVBFu8u1yQcYHgC00EnXT+xD6FaeUxYRrZP/60cA7/0Noho0dU
         i0SVSFKQZsfa+6G9feTiogYQyxP1TNNWCtDd3TDjF1lH5UYppSg6lLHqvf1y2xMzLiqw
         dFrUFCqFTn/HL60soYFWayK9JwpCCIi3TZoX6vBPCn8k8GHmtK7uTavC2gGYfc/H6woj
         uzNvo8KGW5r6v6n8duFxibIs33FwMdL7rGkKyjethciITgma7juCPWhsOErHcZ7XilTz
         /uf20aIdqN0FlsbiuXvqy/29Vzbwb4Q31UjqyR1RHaAhC39f6UktbqNrEwKhihjEWMg6
         /YAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NPeuLMJJBun5hHaf/B7onZQg8F0X8wxMw6hgTnGDv34=;
        b=RR3S+p4NegHVn37DWNMIu4MOtopRtUa/ACEWWddlT8qWwA7vZ9dQPDWF/JrZ7+M2vP
         mEZfINqRbKSEhYNin4GBBsL32mXVCLF5pXmiK4giMfgbU3orlUIJRPoHGkCRSaSS/vpk
         O2Uc1CFweaE1ZvG2tYt6uPWQ4GMu1KfEdJXvV5tHTjnO8x3/S2goPZv6KodBEOqxYH8t
         wjUIha0evqYe0IfknEHhJzCmQT9KMmxU5wP0YPW481YMpZxZ1Ago9Ia9bug8PuLpcz4O
         4i8oqAYFP1IwRD0Fms3QbQIQ9hQ9vktYa3oU5fiOJS2rZZoD/AznDvLKPnAKF7xLMjWP
         xTjg==
X-Gm-Message-State: AOAM533vo7BuGBLrVpZ3lyAeviJtovVKzcLZw0li4ro9Y3UskkKOf8BO
        QiZYhfFDRcBcgzX//S2E/rzMzsZV1sltYVLkprTA
X-Google-Smtp-Source: ABdhPJzmLXY1CzgdycVXq5x5HQh17y9fyx4hPJa6xeszPxn2QpA4blLC5JBOHQejRGCpxAcCwNDVIcT2LW63TClsNauJ
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c40e:ee2c:2ab8:257a])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:4944:: with SMTP id
 o4mr29064674qvy.18.1618956503394; Tue, 20 Apr 2021 15:08:23 -0700 (PDT)
Date:   Tue, 20 Apr 2021 15:08:02 -0700
In-Reply-To: <20210420220804.486803-1-axelrasmussen@google.com>
Message-Id: <20210420220804.486803-9-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210420220804.486803-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v4 08/10] userfaultfd/selftests: exercise minor fault handling
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

