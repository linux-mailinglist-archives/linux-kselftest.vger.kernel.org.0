Return-Path: <linux-kselftest+bounces-35210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 373AFADCDA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 15:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C403A9B8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 13:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A852DE212;
	Tue, 17 Jun 2025 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UxVxbjKr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBC32E2668
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167438; cv=none; b=EKd3AaYc8MwAJ8VjISxgjL3RY6qPqlK8AdQ9s9pxEcWnWBiGNzsWcOpAp//aXEAGtCY9FZnBGC8qX2G45tTxlTKgPKgMxde+w+wfhDJRrCUxKkMA5aS1fdZH6y8uD6v6pBmf7p0d9v2ZUPPtWi5kJenwIlyqINA21jdmav6Xa+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167438; c=relaxed/simple;
	bh=HQNlByHSUvC0ZjiG4WYHMWePhB23AV2AemjXyLk+kJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+jYHEZdWS4kQGAFS4GldKUw2bjUGM8n1qbQ1pcui1JZHCV8GMlrn/5rKXo8vs+SO2jxkHWQ0MIAymWIxqahnjkF3uEUkNee/ouK9n/3PcbZbUttQxI4ozo2z05YESC3oFebbvdPTYC0KdVR8eJVEbBfL5x1lIhQZybhRrTZ3OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UxVxbjKr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so45648435e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 06:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750167434; x=1750772234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgiT6f/x0Fb0H0o2vrOcdtmLUewssNoc2afzunKPIvM=;
        b=UxVxbjKr9xU0Wp9FRJGuk8fo0GWoKenj2xGcxHgudAF64jKrJHpZIEQzaBdHITuHzv
         KqccH3sU+gDL2TGYLhPVuRGCsmEQpsBu0iHM2CDLGjbbsSmPHYuzV9jxBuYlonWsRkSJ
         eqLwTFHNtq4AqXpPxZpDNqj5DyXUVEqhfehvDEd+DcdMmS/ZOo8cGaAQId0TBRRzdrNU
         CyB2cdu3+kT4FFRBmCCW2upcRNiE81bWAMnNLD0i+Kh4lZGmfBASnS1wBXwbDyF/4BLl
         ZSUjJsVMgfMlzLzM9VTCCgPztFLSb5iVNe216ir++vw+IRedn1LdwHhWEV3eF9ZXEg0G
         kTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750167434; x=1750772234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgiT6f/x0Fb0H0o2vrOcdtmLUewssNoc2afzunKPIvM=;
        b=RBnV77lxa0txtZdLkSt64IFDCQyF6RgoPGB6G9kHQ/ZXh9qrvPVgbtsovhxyYTlstd
         DqP5rS5Wnj9wjKl1pxy2VmQep+RNV4OzA9RVqw0YhXNjFcRWimnigI6CJHk7NERYoA1h
         tWnN77O4zr+bwukOO2KE1+tRsovXQ5WqLIXdEcgnOiI/h+KFI3yDJawM+I9kGxxAN7vF
         GR/U6h2WqQsH8p7TeVLocLysxkhryzaJ1C/KpyLU1mMNgV9VsZXvlHW6pCe+jba/cOlb
         8KSZ/k16OyZHLH9lZ7q33o0XBRAz0BtEsq+2uGU97grAXvVMDjVCcn6Kw+wvSf6OFcmr
         +MrA==
X-Forwarded-Encrypted: i=1; AJvYcCUrqYwIhILr+Z+KkAhAKigXHq/lo1kEm5ut1pDG4yrRhFiICxp2TB+i4LrCUHtEXyAgvwFYRDYeRHQqkO+4EgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6bCBO7Ti8KBBQYlRBVXjMNlTyizcp0XHASuFmbJAWCXGObwYW
	qY2RDSr4nSFQ5ewilACyykivOlv782i6Rq5k1+I7HzdTZQ91188qGWJYr1ceqqUsnhY=
X-Gm-Gg: ASbGncsOdUxfqd2do1S2r0I00ai6miMvaqrd+FF/+I/73U//X6zXPmetWWcjDQe8OP7
	eCdSUUQXreZ8Vs+8pIY6PPC50kAQXO4leaxSMsHWTFEg1Fj+NtTKHMeL2oeb7+MT71gN6F8uxKB
	hqkCak1uvNr9sdCQ/vjOApv9MctoOjLRAvkzcwk/givAtp8Sg2MEkWuqHaYY4fH8w7FBUS6GKeP
	T3rI/Zj6iQdcdRCRm9fiQJ5mShX4J6aysZRa/pj2IcocoZnxuTwUsWiOnnfHkPGzjtdFIWKWV8P
	uaNZcwPgxxsZ6KVMlr6krXU7EluFGaIGIlazUcbgK7MzrwpdzSe/CNUGEdyFXuAc
X-Google-Smtp-Source: AGHT+IExevrLdNBxON43pa2jl4pvKa6yc0PjeTqzL/jm9rlEgPnVZnIv7wJ2pCS+hEez9KMDG8M4sg==
X-Received: by 2002:a05:600c:5251:b0:453:92e:a459 with SMTP id 5b1f17b1804b1-4533b28a97emr130794415e9.16.1750167434484;
        Tue, 17 Jun 2025 06:37:14 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224888sm179494365e9.1.2025.06.17.06.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:37:14 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH 1/4] selftests: cgroup_util: Add helpers for testing named v1 hierarchies
Date: Tue, 17 Jun 2025 15:36:53 +0200
Message-ID: <20250617133701.400095-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617133701.400095-1-mkoutny@suse.com>
References: <20250617133701.400095-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Non-functional change, the control variable will be wired in a separate
commit.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/lib/cgroup_util.c         | 4 +++-
 tools/testing/selftests/cgroup/lib/include/cgroup_util.h | 5 +++++
 tools/testing/selftests/cgroup/test_core.c               | 6 +++---
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/testing/selftests/cgroup/lib/cgroup_util.c
index 8832f3d1cb614..0e89fcff4d05d 100644
--- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
@@ -19,6 +19,8 @@
 #include "cgroup_util.h"
 #include "../../clone3/clone3_selftests.h"
 
+bool cg_test_v1_named;
+
 /* Returns read len on success, or -errno on failure. */
 ssize_t read_text(const char *path, char *buf, size_t max_len)
 {
@@ -361,7 +363,7 @@ int cg_enter_current(const char *cgroup)
 
 int cg_enter_current_thread(const char *cgroup)
 {
-	return cg_write(cgroup, "cgroup.threads", "0");
+	return cg_write(cgroup, CG_THREADS_FILE, "0");
 }
 
 int cg_run(const char *cgroup,
diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
index adb2bc1931839..c69cab66254b4 100644
--- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
@@ -13,6 +13,10 @@
 
 #define TEST_UID	65534 /* usually nobody, any !root is fine */
 
+#define CG_THREADS_FILE (!cg_test_v1_named ? "cgroup.threads" : "tasks")
+#define CG_NAMED_NAME "selftest"
+#define CG_PATH_FORMAT (!cg_test_v1_named ? "0::%s" : (":name=" CG_NAMED_NAME ":%s"))
+
 /*
  * Checks if two given values differ by less than err% of their sum.
  */
@@ -65,3 +69,4 @@ extern int dirfd_open_opath(const char *dir);
 extern int cg_prepare_for_wait(const char *cgroup);
 extern int memcg_prepare_for_wait(const char *cgroup);
 extern int cg_wait_for(int fd);
+extern bool cg_test_v1_named;
diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index a5672a91d273c..0c4cc4e5fc8c2 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -573,7 +573,7 @@ static int test_cgcore_proc_migration(const char *root)
 	}
 
 	cg_enter_current(dst);
-	if (cg_read_lc(dst, "cgroup.threads") != n_threads + 1)
+	if (cg_read_lc(dst, CG_THREADS_FILE) != n_threads + 1)
 		goto cleanup;
 
 	ret = KSFT_PASS;
@@ -605,7 +605,7 @@ static void *migrating_thread_fn(void *arg)
 	char lines[3][PATH_MAX];
 
 	for (g = 1; g < 3; ++g)
-		snprintf(lines[g], sizeof(lines[g]), "0::%s", grps[g] + strlen(grps[0]));
+		snprintf(lines[g], sizeof(lines[g]), CG_PATH_FORMAT, grps[g] + strlen(grps[0]));
 
 	for (i = 0; i < n_iterations; ++i) {
 		cg_enter_current_thread(grps[(i % 2) + 1]);
@@ -659,7 +659,7 @@ static int test_cgcore_thread_migration(const char *root)
 	if (retval)
 		goto cleanup;
 
-	snprintf(line, sizeof(line), "0::%s", grps[1] + strlen(grps[0]));
+	snprintf(line, sizeof(line), CG_PATH_FORMAT, grps[1] + strlen(grps[0]));
 	if (proc_read_strstr(0, 1, "cgroup", line))
 		goto cleanup;
 
-- 
2.49.0


