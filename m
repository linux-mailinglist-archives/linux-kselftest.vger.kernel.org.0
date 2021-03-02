Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE1832A7D8
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Mar 2021 18:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382698AbhCBQmc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Mar 2021 11:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239717AbhCBAGE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Mar 2021 19:06:04 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6596C061224
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Mar 2021 16:01:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 194so20639152ybl.5
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Mar 2021 16:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Ykwv7UPOg2gnv7U6N4+XsXv4MVQdTbl3lFORivTI5qU=;
        b=Ike7yisTth4MPXILsDu/yWLMoEt9B+Ui8PttQAbq3inRV2gVHSVxandNIzZpd5ZqDG
         yTzLI6fh7QLGqwwBZzvml3GG4wf8k4furX6FEBBT5/pscBRVuCf1bHOjj+18ezm3sO+y
         BqRXkF6w+rmlczom6l9qwgJloIYYoBPtB+krv83i3eij0jETbsJDKTVGUQeLmEL5wt41
         BC0zJ/5ipdyI68rlqEtHjblDSX6sLqucKcS4j7LGMiDOnL1HVnDJUqvRC6T/VQT5h+wZ
         A+ezDf0lPKYbc4quZ5oy3GxsVg2cbSZh6nVcGeYr6UNw8HpPCKw+Bx8wrOWJfFoAyFTA
         7Dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ykwv7UPOg2gnv7U6N4+XsXv4MVQdTbl3lFORivTI5qU=;
        b=BmQUIK/vpg4x6Irk/ItLAtG5PKOhPnuad+JayzFBXtujMXi3Lec7C7wQCAuTliQLOq
         dlVpjHTJhU6Wu85lkNAUXjH7Y707P5EZRfdrPHr9uqPdvQIIR130q7HN82Pjg588i2il
         ODob+omv47ysjRmF7hP0BkDt6noyZ05oiDbFGZl3fFy3o7NlWSfVUyvDIiab3GrSUr0H
         GU+fcqEMAUMwYnZ9zbBuRvJP0Gea8oPwumozzPJvkX5AhI/N3Ux4+70p1XmuutzBUmPa
         syEQbNLnyWMUYnBfMpXqylRsnQtKLujjV3ofzXKJY/9LWZtja/NlgkTC2Sx9IM7sVvHM
         FSsA==
X-Gm-Message-State: AOAM5321pnYPemVU51d/xrcN4UoAs+AnEADQqGqS4d7bbTBkF2I/2QB0
        0nvvtU/qckkrdO81OsCxaMD4nggKKXdP8zPCrIym
X-Google-Smtp-Source: ABdhPJw+SgNIXkt4ryxrzUm5ivUNXVG5tdt4ortQaA1qH8YQMU1a/tSZgm1uL1DTR5qkBDiLx57yLwrv3CYpsnXapASo
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:1998:8165:ca50:ab8d])
 (user=axelrasmussen job=sendgmr) by 2002:a25:e08b:: with SMTP id
 x133mr26514883ybg.138.1614643306922; Mon, 01 Mar 2021 16:01:46 -0800 (PST)
Date:   Mon,  1 Mar 2021 16:01:33 -0800
In-Reply-To: <20210302000133.272579-1-axelrasmussen@google.com>
Message-Id: <20210302000133.272579-6-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210302000133.272579-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2 5/5] userfaultfd/selftests: exercise minor fault handling
 shmem support
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>, Wang Qing <wangqing@vivo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
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
 tools/testing/selftests/vm/userfaultfd.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 5183ddb3080d..f31e9a4edc55 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -1410,7 +1410,7 @@ static int userfaultfd_minor_test(void)
 	void *expected_page;
 	char c;
 	struct uffd_stats stats = { 0 };
-	uint64_t features = UFFD_FEATURE_MINOR_HUGETLBFS;
+	uint64_t req_features, features_out;
 
 	if (!test_uffdio_minor)
 		return 0;
@@ -1418,10 +1418,18 @@ static int userfaultfd_minor_test(void)
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
@@ -1431,7 +1439,7 @@ static int userfaultfd_minor_test(void)
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MINOR;
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register)) {
-		fprintf(stderr, "register failure\n");
+		perror("register failure");
 		exit(1);
 	}
 
@@ -1695,6 +1703,7 @@ static void set_test_type(const char *type)
 		map_shared = true;
 		test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
+		test_uffdio_minor = true;
 	} else {
 		fprintf(stderr, "Unknown test type: %s\n", type); exit(1);
 	}
-- 
2.30.1.766.gb4fecdf3b7-goog

