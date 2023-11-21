Return-Path: <linux-kselftest+bounces-387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4F97F34C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 18:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2AD1C20921
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 17:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E3D5A11B;
	Tue, 21 Nov 2023 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Fx8E6sV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A468D62
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Nov 2023 09:16:57 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5c9eef53013so55090227b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Nov 2023 09:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700587016; x=1701191816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=16WWsVx2wninDVgD360hRJytZJiRJbLfp5hnTHjwaT4=;
        b=0Fx8E6sVu7JKZB6nar4jwc35y60/AQmZIiM28NSJQWDtcxnvaBQu+6fu05lrovfn6u
         vO4hQVUDfSHZBoRQ2alD9+sFn4R+fXWhDbpUhhwUL/HQ5D102kj8CNOivK4Ra/HYs9r/
         cmLyYnjQNcmtxXVLz66IRix5Em7QWFPZi4P1PJOb9sA9qxY36Wo5GwuSjhmGCmA70v2F
         Oz6O7mILmDnzY4YiOSi+dbJLESh2LgCl6aULTVj7n4M1y5QKAO6ZQEirW9n9uIta7Psh
         rhcMDou0wiAhh4+isC1Pi6jLiXRoK3lUqX64IaMKjp55a59plAs6GvgZU/ODji41Gpht
         Lcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700587016; x=1701191816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16WWsVx2wninDVgD360hRJytZJiRJbLfp5hnTHjwaT4=;
        b=Yk6Nyc0vRnpaBMLdYbkCOUHtkh6ZsDPZ/KCsZOmfQknVhbJb7p/8AFnQEPl6eU2GMO
         tm9YrhUEHaKS+ssJQO59dTcT+qA/h2LvSr3Mkaln2pjO5JfXXQbgc4//cy1+62KGi95W
         gB1jp3Qjai0GaguzlKToBTvrcoq/X4Ucl/OLhRSuRBDHMwfTASE0SJmb6I5+6FoqfTc+
         E60h8aaPzWxFIw6CoJeANGsawSYJs5zCas+HZIO9/aWrlqtBf22pQEAxnhfR17YJCqkh
         XybUsOrhBHQXnzfflgflBAbI+VrPNzFcqx/Gz4sTfltV7EDbcMys9vJFtKraK19muAf8
         l1ng==
X-Gm-Message-State: AOJu0YwtCqWgcrSnXbd/2hx34haSqDDyGmUEeIoAmsyoU5EhuMG4kkXZ
	63W86DBUTDoeRr3kp7q4yLNC0gxEiNg=
X-Google-Smtp-Source: AGHT+IEDzZp+znMIvLmLUboaHGb6wcOjpm4sLpEi36+gWsJpIjPPrJpEev3RGtNgfOw04VbiAOuwWaVIAJQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:2045:f6d2:f01d:3fff])
 (user=surenb job=sendgmr) by 2002:a05:6902:110:b0:d9a:cbf9:1c8d with SMTP id
 o16-20020a056902011000b00d9acbf91c8dmr324632ybh.12.1700587016415; Tue, 21 Nov
 2023 09:16:56 -0800 (PST)
Date: Tue, 21 Nov 2023 09:16:37 -0800
In-Reply-To: <20231121171643.3719880-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231121171643.3719880-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231121171643.3719880-5-surenb@google.com>
Subject: [PATCH v5 4/5] selftests/mm: add uffd_test_case_ops to allow test
 case-specific operations
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, hughd@google.com, mhocko@suse.com, axelrasmussen@google.com, 
	rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com, 
	jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com, 
	kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com, 
	surenb@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Currently each test can specify unique operations using uffd_test_ops,
however these operations are per-memory type and not per-test. Add
uffd_test_case_ops which each test case can customize for its own needs
regardless of the memory type being used. Pre- and post-allocation
operations are added, some of which will be used in the next patch to
implement test-specific operations like madvise after memory is allocated
but before it is accessed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/mm/uffd-common.c     | 13 +++++++++++++
 tools/testing/selftests/mm/uffd-common.h     |  7 +++++++
 tools/testing/selftests/mm/uffd-unit-tests.c |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 583e5a4cc0fd..fb3bbc77fd00 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -17,6 +17,7 @@ bool map_shared;
 bool test_uffdio_wp = true;
 unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
+uffd_test_case_ops_t *uffd_test_case_ops;
 
 static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
 {
@@ -298,6 +299,12 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 	unsigned long nr, cpu;
 	int ret;
 
+	if (uffd_test_case_ops && uffd_test_case_ops->pre_alloc) {
+		ret = uffd_test_case_ops->pre_alloc(errmsg);
+		if (ret)
+			return ret;
+	}
+
 	ret = uffd_test_ops->allocate_area((void **)&area_src, true);
 	ret |= uffd_test_ops->allocate_area((void **)&area_dst, false);
 	if (ret) {
@@ -306,6 +313,12 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 		return ret;
 	}
 
+	if (uffd_test_case_ops && uffd_test_case_ops->post_alloc) {
+		ret = uffd_test_case_ops->post_alloc(errmsg);
+		if (ret)
+			return ret;
+	}
+
 	ret = userfaultfd_open(&features);
 	if (ret) {
 		if (errmsg)
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 870776b5a323..774595ee629e 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -90,6 +90,12 @@ struct uffd_test_ops {
 };
 typedef struct uffd_test_ops uffd_test_ops_t;
 
+struct uffd_test_case_ops {
+	int (*pre_alloc)(const char **errmsg);
+	int (*post_alloc)(const char **errmsg);
+};
+typedef struct uffd_test_case_ops uffd_test_case_ops_t;
+
 extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
 extern char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
 extern int uffd, uffd_flags, finished, *pipefd, test_type;
@@ -102,6 +108,7 @@ extern uffd_test_ops_t anon_uffd_test_ops;
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
2.43.0.rc1.413.gea7ed67945-goog


