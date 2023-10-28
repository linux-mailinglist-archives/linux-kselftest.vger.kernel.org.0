Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D1E7DA46F
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Oct 2023 02:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbjJ1Aiq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 20:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346757AbjJ1Aie (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 20:38:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7164ED40
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Oct 2023 17:38:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5aecf6e30e9so26458487b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Oct 2023 17:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698453511; x=1699058311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s1R+gkPO6QWaqP2nXLyUZQJ5I/za0dgAKVF5I8CkZ8w=;
        b=MoGenRuyo4nfv3eG/+W2TGVWy3LqwicSEKy2wXR/9lXKmOqWVxFcjjzXvspsM1tASD
         k6RBuyAZ9R99YE/B3j6vrNdwKX2g3WvJhCM/0rORbZt64i3CF+pjbrXNdqjsiKxGyhP4
         4LGCzBrMpVyUAisxqFtwCm7gfWGLTdoMos3BwWnFNlqyC2lPzzz9Gv9HxGtVZh4pUAEg
         z+gprFp78wOpuY9rwMBnhMOxfQSGGSwgr7kZRSh9jUV0BWVKQe8J9y0BElTwvTFOfhas
         WoJbbYmBXt6HAzCEfs6A+jK1hGoOq3cRGUysCFHpwOSP1FxQkkVwcKn5bkHr4H4uXMS0
         YRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698453511; x=1699058311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1R+gkPO6QWaqP2nXLyUZQJ5I/za0dgAKVF5I8CkZ8w=;
        b=VlnaM2yq/4HFMM8U3ni3gD5LbPrHOw4b+GiKrCZSh6qNj5JXRnN44fmHTfgPhQ5iCR
         iJ6tiKXmkzTXecjuhZmvv1H4xXkC/HFlI6nVG+jXpWWu1or1kGgzVG28Iie979q4wcE1
         NOUyHa0whYYNjaR1T2AsHp5FUA3mO3Q2MC8ijt1eGFo+gPjlGbnFBHuBtVY2+pffq7/c
         KBqEhgHP5oFrV10KsKUg+rfiMmcXzvt40JWbtI2NG9bsmt437jxbxWjzY0djGw14fg24
         jtjClZtd9qjBGKPIpSolVyzetHa6etdEzoR0YfIW1lEFWqSM2JxnCtEd1yrMv20c0HJ4
         zoDA==
X-Gm-Message-State: AOJu0YyLaxv8m6v+OaFhY4PYWV1t4UQOqaMMLDuWPTGg7kHeciz0zJ74
        B2oj+sRBwcMwOgtQkfJlhXwQ0xiSgRM=
X-Google-Smtp-Source: AGHT+IH6BjNAe/I3oWPFyDFCzaaFiNnvB+GO/X2zJTyzdisgvbx30Yvihy8swuf1y6CJmKyolAmFsT8binI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:cba3:7e7f:79e4:fa57])
 (user=surenb job=sendgmr) by 2002:a81:4895:0:b0:5af:6717:1c52 with SMTP id
 v143-20020a814895000000b005af67171c52mr94902ywa.0.1698453511616; Fri, 27 Oct
 2023 17:38:31 -0700 (PDT)
Date:   Fri, 27 Oct 2023 17:38:14 -0700
In-Reply-To: <20231028003819.652322-1-surenb@google.com>
Mime-Version: 1.0
References: <20231028003819.652322-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231028003819.652322-5-surenb@google.com>
Subject: [PATCH v4 4/5] selftests/mm: add uffd_test_case_ops to allow test
 case-specific operations
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently each test can specify unique operations using uffd_test_ops,
however these operations are per-memory type and not per-test. Add
uffd_test_case_ops which each test case can customize for its own needs
regardless of the memory type being used. Post- and pre- allocation and
release operations are added, some of which will be used in the next
patch to implement test-specific customizations like area re-alignment,
page size overrides and madvise after memory allocations but before
memory is accessed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/mm/uffd-common.c     | 25 ++++++++++++++++++++
 tools/testing/selftests/mm/uffd-common.h     |  9 +++++++
 tools/testing/selftests/mm/uffd-unit-tests.c |  2 ++
 3 files changed, 36 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 583e5a4cc0fd..69e6653ad255 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -17,6 +17,7 @@ bool map_shared;
 bool test_uffdio_wp = true;
 unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
+uffd_test_case_ops_t *uffd_test_case_ops;
 
 static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
 {
@@ -286,11 +287,17 @@ void uffd_test_ctx_clear(void)
 		uffd = -1;
 	}
 
+	if (uffd_test_case_ops && uffd_test_case_ops->pre_release)
+		uffd_test_case_ops->pre_release();
+
 	munmap_area((void **)&area_src);
 	munmap_area((void **)&area_src_alias);
 	munmap_area((void **)&area_dst);
 	munmap_area((void **)&area_dst_alias);
 	munmap_area((void **)&area_remap);
+
+	if (uffd_test_case_ops && uffd_test_case_ops->post_release)
+		uffd_test_case_ops->post_release();
 }
 
 int uffd_test_ctx_init(uint64_t features, const char **errmsg)
@@ -298,6 +305,15 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 	unsigned long nr, cpu;
 	int ret;
 
+	if (uffd_test_case_ops && uffd_test_case_ops->pre_alloc) {
+		ret = uffd_test_case_ops->pre_alloc();
+		if (ret) {
+			if (errmsg)
+				*errmsg = "pre-allocation operation failed";
+			return ret;
+		}
+	}
+
 	ret = uffd_test_ops->allocate_area((void **)&area_src, true);
 	ret |= uffd_test_ops->allocate_area((void **)&area_dst, false);
 	if (ret) {
@@ -306,6 +322,15 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 		return ret;
 	}
 
+	if (uffd_test_case_ops && uffd_test_case_ops->post_alloc) {
+		ret = uffd_test_case_ops->post_alloc();
+		if (ret) {
+			if (errmsg)
+				*errmsg = "post-allocation operation failed";
+			return ret;
+		}
+	}
+
 	ret = userfaultfd_open(&features);
 	if (ret) {
 		if (errmsg)
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 870776b5a323..19930fd6682b 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -90,6 +90,14 @@ struct uffd_test_ops {
 };
 typedef struct uffd_test_ops uffd_test_ops_t;
 
+struct uffd_test_case_ops {
+	int (*pre_alloc)(void);
+	int (*post_alloc)(void);
+	void (*pre_release)(void);
+	void (*post_release)(void);
+};
+typedef struct uffd_test_case_ops uffd_test_case_ops_t;
+
 extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
 extern char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
 extern int uffd, uffd_flags, finished, *pipefd, test_type;
@@ -102,6 +110,7 @@ extern uffd_test_ops_t anon_uffd_test_ops;
 extern uffd_test_ops_t shmem_uffd_test_ops;
 extern uffd_test_ops_t hugetlb_uffd_test_ops;
 extern uffd_test_ops_t *uffd_test_ops;
+extern uffd_test_case_ops_t *uffd_test_case_ops;
 
 void uffd_stats_report(struct uffd_args *args, int n_cpus);
 int uffd_test_ctx_init(uint64_t features, const char **errmsg);
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index e7d43c198041..debc423bdbf4 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -78,6 +78,7 @@ typedef struct {
 	uffd_test_fn uffd_fn;
 	unsigned int mem_targets;
 	uint64_t uffd_feature_required;
+	uffd_test_case_ops_t *test_case_ops;
 } uffd_test_case_t;
 
 static void uffd_test_report(void)
@@ -185,6 +186,7 @@ uffd_setup_environment(uffd_test_args_t *args, uffd_test_case_t *test,
 {
 	map_shared = mem_type->shared;
 	uffd_test_ops = mem_type->mem_ops;
+	uffd_test_case_ops = test->test_case_ops;
 
 	if (mem_type->mem_flag & (MEM_HUGETLB_PRIVATE | MEM_HUGETLB))
 		page_size = default_huge_page_size();
-- 
2.42.0.820.g83a721a137-goog

