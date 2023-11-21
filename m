Return-Path: <linux-kselftest+bounces-385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D647F34C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 18:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2294EB20F87
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 17:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8405A0FA;
	Tue, 21 Nov 2023 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2EiaItp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222A612C
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Nov 2023 09:16:55 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5c5c0dcb179so73685047b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Nov 2023 09:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700587014; x=1701191814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+oQWC9tOLeE7lomKytBDg6Tp5S7jbgII3AVJArGJfwY=;
        b=s2EiaItpZeT0o0dByrVdBzuwITejUh6B8Dp7V6nbsKSM5w09YfFQCZYcAzCj4yoCv4
         NmrlbTTW0ghvxLEHJOoVHpy3VTwl2Ig2PiktKD3U5M1vTXtXZ2sjYLnCnxWs6uP2mTQ2
         d9Jo9jzwmhNGUkGQBzWTzDoWHHHIHT/NIqC+3hDFYeHC4TlPPnZdvgN+V4RC09oRoRM+
         SLrO7jsUR6B+xG+ej8HdshzVX/Xc6dLfmRqgMOwXwiMVOq1iUnQK7nMZ/CxfYsMi91tB
         4SvUGKcRBClzx/gvGLVe10iF0xNqTgAnyN1ieZfTFdKwk1SN1LQkOdmCOmtq2Ck0FdoJ
         gO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700587014; x=1701191814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+oQWC9tOLeE7lomKytBDg6Tp5S7jbgII3AVJArGJfwY=;
        b=gIV4x+e2BOg8nkdSOueR+/wGaRozm011Gm13yKNyglfQJapFw/507Wtq4hPSk8ub5w
         zcvXJqbdoPVw5AghE04G07A2IfopnwHzg3O1ZHZjwQHHMxm4ETkkh/A8uro0bZBllUQF
         3sMIB0UrPV6tTb/UZn2tJo5cKdLUSx8iGrTQ9gOA7c5/nORO7yEoXaZGszi+PD3V1gRT
         GWDEGg2axKaqRBLIyHrNfeF/95sExdw3RNxA0vhcGw4Cx5s9iNHYRauLsPnOYLKMEnRX
         uqUMHV+XIJ76ItlbYTSFYQcM/fPPjJ3HB4yIM9wx7ejpTFV8W+BtQ81sz2eZpXyqHgwu
         hTCg==
X-Gm-Message-State: AOJu0YydZpp+rDvAML0r+bX9PlEhsOkt263caXotvgUbMAwXabXulD6F
	UP4pYswMfe4DPC5v6Qw6vJKygdBoSUE=
X-Google-Smtp-Source: AGHT+IGt4XeQzmmYh3UGYq1fZSYeCCXt9DvRPaCqVRLnjG7738p7ZSz3vsLWilwzFfU1DtxScxBgR2AWR/c=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:2045:f6d2:f01d:3fff])
 (user=surenb job=sendgmr) by 2002:a05:690c:891:b0:5c9:1c6a:40f with SMTP id
 cd17-20020a05690c089100b005c91c6a040fmr290590ywb.5.1700587014155; Tue, 21 Nov
 2023 09:16:54 -0800 (PST)
Date: Tue, 21 Nov 2023 09:16:36 -0800
In-Reply-To: <20231121171643.3719880-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231121171643.3719880-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231121171643.3719880-4-surenb@google.com>
Subject: [PATCH v5 3/5] selftests/mm: call uffd_test_ctx_clear at the end of
 the test
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
2.43.0.rc1.413.gea7ed67945-goog


