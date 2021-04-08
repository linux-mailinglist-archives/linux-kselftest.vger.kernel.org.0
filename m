Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EFF359086
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Apr 2021 01:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhDHXoM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Apr 2021 19:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhDHXn7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Apr 2021 19:43:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F7CC0613D8
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Apr 2021 16:43:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d1so3545680ybj.15
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Apr 2021 16:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WSNoP8c3GVSSHFh1g2WvnJRaFbPgXevhOBLl09IZVIU=;
        b=GTSRqeAtpIM5Fb79iJUqC7M8Tk0OMkIKgRA91v9QUk8XPSho24dNwSGb+x2suMVH7g
         ZUyFpBL/CCGtfiYGoUiEVuGEjdCqDoTMRa8rLnvH5LCdhI4fyiCDRIAZdiVwEGmaLs4l
         oHnXarP2qV+AwK4CixPK5vJXrCZVDWiog4QDfK8PDfikecEOaLU9aAaKeYilLpftkQm0
         HMWI958gN/YKEwmMHf6YOAZVpR4R9u1icRa5OMpLrjjI+4/9uuof+lT+Q5hVJAiV2Eks
         US5fO+lAPes914Qy6GCFTlcPyAKC035xNlr9iS7vnabPVnkD9ejloGRXEb3zHFILuVFu
         S8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WSNoP8c3GVSSHFh1g2WvnJRaFbPgXevhOBLl09IZVIU=;
        b=eQOMgknz+LEwTPJDwMwPOKbXNx63dRj+tjFmt4k98/da8WOz/7lnCtZqHaGyraLJb9
         /uSFYDfdKvbugM+eLcKZ2Y3LfqC3Q6Ln1adoQ53ahhdc8bs+zMUwGiq85kjNUSobD1yB
         HPEwPOTYC390IcgjGKPyy2/WwEEES7e8/yVnVsYMO0Lp/HQK3EOSfjjgZO3xKQsel4Xa
         FLv/KcaIDW+WuqkrLR50VWeLLuKIkl5gsOZsVDh7Nds9baiHy6aydAZiib9deLcQtFGG
         0FHeKDOBWcsdSmd2Pnm1iaBtYXTIQ+qE/83HhZ4NHllPBigvTRnMC97PZNLWKft28FLq
         yWZA==
X-Gm-Message-State: AOAM530Xxy6pn9ZAjJR2qJgDV3zsX1IjgI9m+7o8ophBXH2PiwiF99TS
        y8zz3C4qJWd58+RE/TOiDx9zTLF5DtKrj9zNe2j4
X-Google-Smtp-Source: ABdhPJwvO+MZlsHbO+qMgNHWdl/g5ZOBZCUrI2P4iJAvMCv9bDmGUW1aJu5V83dw1rhmvOWNIncWTDrBaDb2rLqiRPTk
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d06:d00f:a626:675a])
 (user=axelrasmussen job=sendgmr) by 2002:a25:3304:: with SMTP id
 z4mr16256601ybz.330.1617925425618; Thu, 08 Apr 2021 16:43:45 -0700 (PDT)
Date:   Thu,  8 Apr 2021 16:43:26 -0700
In-Reply-To: <20210408234327.624367-1-axelrasmussen@google.com>
Message-Id: <20210408234327.624367-9-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210408234327.624367-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 8/9] userfaultfd/selftests: exercise minor fault handling
 shmem support
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
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
index 9b032cfdc262..640d0a2d107d 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -488,6 +488,7 @@ static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
 static void continue_range(int ufd, __u64 start, __u64 len)
 {
 	struct uffdio_continue req;
+	int ret;
 
 	req.range.start = start;
 	req.range.len = len;
@@ -496,6 +497,17 @@ static void continue_range(int ufd, __u64 start, __u64 len)
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
+		    ret, req.mapped);
 }
 
 static void *locking_thread(void *arg)
@@ -1198,7 +1210,7 @@ static int userfaultfd_minor_test(void)
 	void *expected_page;
 	char c;
 	struct uffd_stats stats = { 0 };
-	uint64_t features = UFFD_FEATURE_MINOR_HUGETLBFS;
+	uint64_t req_features, features_out;
 
 	if (!test_uffdio_minor)
 		return 0;
@@ -1206,10 +1218,18 @@ static int userfaultfd_minor_test(void)
 	printf("testing minor faults: ");
 	fflush(stdout);
 
-	if (uffd_test_ctx_clear() || uffd_test_ctx_init_ext(&features))
+	if (test_type == TEST_HUGETLB)
+		req_features = UFFD_FEATURE_MINOR_HUGETLBFS;
+	else if (test_type == TEST_SHMEM)
+		req_features = UFFD_FEATURE_MINOR_SHMEM;
+	else
+		return 1;
+
+	features_out = req_features;
+	if (uffd_test_ctx_clear() || uffd_test_ctx_init_ext(&features_out))
 		return 1;
-	/* If kernel reports the feature isn't supported, skip the test. */
-	if (!(features & UFFD_FEATURE_MINOR_HUGETLBFS)) {
+	/* If kernel reports required features aren't supported, skip test. */
+	if ((features_out & req_features) != req_features) {
 		printf("skipping test due to lack of feature support\n");
 		fflush(stdout);
 		return 0;
@@ -1444,6 +1464,7 @@ static void set_test_type(const char *type)
 		map_shared = true;
 		test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
+		test_uffdio_minor = true;
 	} else {
 		err("Unknown test type: %s", type);
 	}
-- 
2.31.1.295.g9ea45b61b8-goog

