Return-Path: <linux-kselftest+bounces-1259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA93C806C27
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 11:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7F61F21390
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 10:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCC923761;
	Wed,  6 Dec 2023 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xy4NiCIV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E0AD69
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 02:37:13 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db7dd9a8bd6so4395946276.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 02:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701859032; x=1702463832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Puo0/IOkGZzeDNo6LANVKcztB/uZ2FwQ4rTVo9jmukU=;
        b=Xy4NiCIVkWQjHZI12g0N2bHajZMA/cr07PnsRO0B/yUClSeECRq/6mEO9aISfKRpqz
         sMKqEPuTZIptWUi28yRh/GagOLyowh0pz3NvHKcfNsvrXsaeStysyDZQfb6lkVio6ZdR
         HNLw0RlnJDcBEN3xhiqqQDC6A48MflcgkeItoZh+gSlYV30kiju/qGNN666xj7o5uSC4
         rEyFUokNkkhA93hCNcy0lphHRtof4yU6KUufzM8dQYKxyswLEUBkK1VHHq+2ACJBaeDk
         hDphhG6Nqdrcm2JkHhSOwqZ71BqYyLA+yMYTMKbylxEullHjVCQw0qgaiitVLqp1bE4q
         VPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701859032; x=1702463832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Puo0/IOkGZzeDNo6LANVKcztB/uZ2FwQ4rTVo9jmukU=;
        b=BhAb87qZ5MovrJX5g6qWz4L+sk5v9IAyKVs2nHtOQMqzU5d4s+r9i1DsFUkbanLKwl
         YvjwFocLzoOfAKnP/s6RKsvG5HFenlQq0Kxb3glkwVFC+1IIgWv3LrbyKf+HZGemE7xh
         qQH/00cgFsRYZFNZ1CZFxn/hDNJa09PZHRD8wtdl3OUkUkNywINaUcgde2bv0Ewe7p8q
         0npJLJ4fmlPMLcTwPta9hL+HVLwbrAQsYsIJibD3p7Uvzl5AosIPgr/CqlOyOUjsUJEp
         RyATrhQbL0CtZ5gfhshn9vDGyr+Hw3jz0iSA+aZpUc6eNwLsLej+pK683FOnIzB+EJca
         rsuw==
X-Gm-Message-State: AOJu0Yz7nUSKCqRWNhN14jr+6In1ZwrKj5Zz2jcNWOAmlaCVL6oGoMRM
	8u81OErxBKoNgIRkzzrA5HYpAX2T3vs=
X-Google-Smtp-Source: AGHT+IHA1Y29L+NkSe0tx6k2aoEfMY/lNB6ALySjHtUB1ExXnuX9TN8ZY2Jn+/kFOMbKEKZSCPu3KGAmWc0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:73f6:b5e2:415:6ba5])
 (user=surenb job=sendgmr) by 2002:a25:3144:0:b0:da0:5452:29e4 with SMTP id
 x65-20020a253144000000b00da0545229e4mr5930ybx.0.1701859032195; Wed, 06 Dec
 2023 02:37:12 -0800 (PST)
Date: Wed,  6 Dec 2023 02:36:57 -0800
In-Reply-To: <20231206103702.3873743-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231206103702.3873743-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231206103702.3873743-4-surenb@google.com>
Subject: [PATCH v6 3/5] selftests/mm: call uffd_test_ctx_clear at the end of
 the test
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, surenb@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

uffd_test_ctx_clear() is being called from uffd_test_ctx_init() to unmap
areas used in the previous test run. This approach is problematic because
while unmapping areas uffd_test_ctx_clear() uses page_size and nr_pages
which might differ from one test run to another.
Fix this by calling uffd_test_ctx_clear() after each test is done.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
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
2.43.0.rc2.451.g8631bc7472-goog


