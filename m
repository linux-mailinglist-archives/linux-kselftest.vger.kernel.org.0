Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F6C7DA46D
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Oct 2023 02:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbjJ1Aip (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 20:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346749AbjJ1Aie (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 20:38:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FEE1B9
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Oct 2023 17:38:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5af592fed43so16542727b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Oct 2023 17:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698453509; x=1699058309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BD9lPzNt8hnQJcZ/hWgSWD/y67yszl3sQZlzVb4etk8=;
        b=wRnrNLhowwwCtiquCs34cdBqrU1JXb5Ss+N2lIWxytefgi1RqBRzji+yXiCNmuI6a2
         jC2tjMfyEAVDInZJ0z0offntxZQWshtRnBLUP0WEfWYzyU+Vyu3Qv+ti8qe7KJiHjq2k
         xrWllxJVKdSZFtgbjOZVMnOzaUBGihOSiVSko2XHXipn1Fgqm/7MujSztMZvQW49CloW
         nbWtbW+YF1p97INXPGE3MOTKqmpTUXePC+s1NqWDXwB6HU7DYrZ2n7/qAaLDAsm+FmSv
         sTuKZq+cviYleiA5Gz9RQ7qdALxXER1w2BnldWayez+CiYdXc14Odd0dGwAYxekX4xv7
         c2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698453509; x=1699058309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BD9lPzNt8hnQJcZ/hWgSWD/y67yszl3sQZlzVb4etk8=;
        b=jEwoySy9s1BQFid8O9k2sYTAbc9wPWCRcNYz8/enytcLiqmQMW34AalzKaa9WiRuwl
         FLuwvOjuQi0bmVDq+15KspHQppZIGV9Orh2KxZ4YEW2+5ije4o7SzrGmxIQwHARorlQn
         uK3jOwLWu/kE7rBcclspdD9luygQpveMv+3xsSTwsPl3ejtePhWflpGHsIJF0CKQrTaV
         Ts0HuCcxLVN7K/Kfg/GIqm2ywHfDjpDm3rDmo4OhXcdFAipK4NFUGWVixMsnyPwLwyXl
         YIU3THlCJ9fpDpxUz+SVM7dw5EeSG5+tROEmShmoo9xh7KQf8xRAwaWPlMT1ilSQ9A3p
         anhg==
X-Gm-Message-State: AOJu0YyaVSo37EOLqXrJyV8NTHFe64K8L1Ga8hQxeEPnO+mE9xPmvK/f
        zoFUA86RoLAur37lLImz0cRrxO8HKj4=
X-Google-Smtp-Source: AGHT+IGmeKeXQi4pWbtj4gTgBBjJn+MEaX3ROLUS7uMooi9MoHIQXOo8pDwybtu05kFAWMGKkvzAZguj9E0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:cba3:7e7f:79e4:fa57])
 (user=surenb job=sendgmr) by 2002:a0d:db97:0:b0:5a7:b15a:1a7d with SMTP id
 d145-20020a0ddb97000000b005a7b15a1a7dmr86233ywe.2.1698453509335; Fri, 27 Oct
 2023 17:38:29 -0700 (PDT)
Date:   Fri, 27 Oct 2023 17:38:13 -0700
In-Reply-To: <20231028003819.652322-1-surenb@google.com>
Mime-Version: 1.0
References: <20231028003819.652322-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231028003819.652322-4-surenb@google.com>
Subject: [PATCH v4 3/5] selftests/mm: call uffd_test_ctx_clear at the end of
 the test
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        david@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

uffd_test_ctx_clear() is being called from uffd_test_ctx_init() to unmap
areas used in the previous test run. This approach is problematic because
while unmapping areas uffd_test_ctx_clear() uses page_size and nr_pages
which might differ from one test run to another.
Fix this by calling uffd_test_ctx_clear() after each test is done.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/mm/uffd-common.c     | 4 +---
 tools/testing/selftests/mm/uffd-common.h     | 1 +
 tools/testing/selftests/mm/uffd-stress.c     | 5 ++++-
 tools/testing/selftests/mm/uffd-unit-tests.c | 1 +
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 02b89860e193..583e5a4cc0fd 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -262,7 +262,7 @@ static inline void munmap_area(void **area)
 	*area = NULL;
 }
 
-static void uffd_test_ctx_clear(void)
+void uffd_test_ctx_clear(void)
 {
 	size_t i;
 
@@ -298,8 +298,6 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 	unsigned long nr, cpu;
 	int ret;
 
-	uffd_test_ctx_clear();
-
 	ret = uffd_test_ops->allocate_area((void **)&area_src, true);
 	ret |= uffd_test_ops->allocate_area((void **)&area_dst, false);
 	if (ret) {
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 7c4fa964c3b0..870776b5a323 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -105,6 +105,7 @@ extern uffd_test_ops_t *uffd_test_ops;
 
 void uffd_stats_report(struct uffd_args *args, int n_cpus);
 int uffd_test_ctx_init(uint64_t features, const char **errmsg);
+void uffd_test_ctx_clear(void);
 int userfaultfd_open(uint64_t *features);
 int uffd_read_msg(int ufd, struct uffd_msg *msg);
 void wp_range(int ufd, __u64 start, __u64 len, bool wp);
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 469e0476af26..7e83829bbb33 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -323,8 +323,10 @@ static int userfaultfd_stress(void)
 		uffd_stats_reset(args, nr_cpus);
 
 		/* bounce pass */
-		if (stress(args))
+		if (stress(args)) {
+			uffd_test_ctx_clear();
 			return 1;
+		}
 
 		/* Clear all the write protections if there is any */
 		if (test_uffdio_wp)
@@ -354,6 +356,7 @@ static int userfaultfd_stress(void)
 
 		uffd_stats_report(args, nr_cpus);
 	}
+	uffd_test_ctx_clear();
 
 	return 0;
 }
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 2709a34a39c5..e7d43c198041 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1319,6 +1319,7 @@ int main(int argc, char *argv[])
 				continue;
 			}
 			test->uffd_fn(&args);
+			uffd_test_ctx_clear();
 		}
 	}
 
-- 
2.42.0.820.g83a721a137-goog

