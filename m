Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FB636CEE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 00:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbhD0Wxy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Apr 2021 18:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239452AbhD0Wxx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Apr 2021 18:53:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0ADC06138C
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Apr 2021 15:53:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 7-20020a5b01070000b02904ed6442e5f6so16211807ybx.23
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Apr 2021 15:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RRWLcA4U8+e/XOHvkZswRCx0YI32rbruxBRpXWbXmCs=;
        b=okG18pV2cHje7Vas2xHrgpMSRzPJeLI9iRNJPNE0FPrPp6Klcqy7/1Swk9FhXFy3Qb
         tJpEyh/CfyzSMCfu+ZiCoWyeiRSKT3APXIJisybUxKCfMpzvt07y/CRA5np6G5JapEpB
         IUI6hMM0aN7/n1yjIYUXs9pj5LHPpMC/9gDy2s4fGjKSH94J6JXZvHYcGTjVJ0ktYWkq
         1gR8Oy0hwQTr9EXyrrp0TO9YsOE8GFBDMrUmb73xr9K7a7VeRuC2Vo+NbSMC+Jz2Elej
         wemHAx8m2OCf16Mzand+AzUNOPgoC4hkLUjk9Kez5uNslnMgycE0zkqOGfIF4GhASWCT
         0Yvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RRWLcA4U8+e/XOHvkZswRCx0YI32rbruxBRpXWbXmCs=;
        b=YFq7IctrN88dkqHYxCBIr3cgi5BWrVu5xql06m6bj/fMpk2rypZqe0ExZXNbUayuPK
         fFLgmvVK3OC4uzRKzfysyCwfXMG0IcTtPaXd2a4uAP+Zs7mrbtsblW/SS1xvl4EIEk5+
         r4ChWThX4bLIL0Rzb6AM+52MXCbGfdTamVevKa4oH60Q9z7DxSS7TNFqawvnJqh5iRLd
         3Vbe/NiMAcrHnaPdnz5ZUq1PLtnKeE4gi3yjshtpP6E4S40h1aK8jFFQi9F+EqK5hr1t
         Bz8n4qxcLCccC8NzFEQ3jx0Td1yXillgZ7SuZ6vF/Admg2PHLbj38mK4fEdsvWzhiSnU
         WCHA==
X-Gm-Message-State: AOAM530ctOuKuDrSp9fa2p4LV3g9BAYtqluSVqmi/vTlqL4sb62hII2M
        /3YYGFtO1dJgmX2bMI9lIsSP7lkgesmI6fTWc2d4
X-Google-Smtp-Source: ABdhPJzDsCZYem6SJI6F68LBLgPVRrD7LYUqb4Kv0yx1mHkS1m/coZ3723JWgl0BgYOQPFBBRglbFBkLq324+VmTx7i4
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c423:570b:b823:c33e])
 (user=axelrasmussen job=sendgmr) by 2002:a25:8682:: with SMTP id
 z2mr12874549ybk.325.1619563986815; Tue, 27 Apr 2021 15:53:06 -0700 (PDT)
Date:   Tue, 27 Apr 2021 15:52:44 -0700
In-Reply-To: <20210427225244.4326-1-axelrasmussen@google.com>
Message-Id: <20210427225244.4326-11-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210427225244.4326-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v5 10/10] userfaultfd/selftests: exercise minor fault handling
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
2.31.1.498.g6c1eba8ee3d-goog

