Return-Path: <linux-kselftest+bounces-41682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A29F0B7F742
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 15:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325C61C27E8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 13:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D1431A802;
	Wed, 17 Sep 2025 13:33:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43CB31960F
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116039; cv=none; b=FgyriWmCYbUfzWOvwgpNbB+bezMWESpvBfsls0ErBNwPq+YU/P4Jjkz27Kp+MUxWaeUwuRKyAWA/XZWqc+AzL6lzwdBnu2YlL3lRSIqp99doQjmzdDJgrQj9ZHeu1hFJye+VIAhpynVky2b5RGgcOdS9guZtR6PxP0+pzIHhmLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116039; c=relaxed/simple;
	bh=GuO132UD6kDNK7GM80KvsDR2s46lSBmWg2yAjSMD2iA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K7qAZ96U3MVBnGJUJdEznXxaC9W61hbJSaX+x+e5yiOPunk0dwlj9+k/oO5e7QUJVfl5hDixX+ENde53/OraplP/p1CqaitxdTcCK+bPBfzdfQXBpBvbFxT2MsSsceTPszy/d52B9yB7HZBg7pp8jLtKSYQfZXCxesDdqTnLyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4619eb182c8so8725625e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 06:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116035; x=1758720835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PB/dLP6okMS4UB2K8/m8T0leXGzvWyq468DHfShm8FI=;
        b=Qh4oslrdQYHiMgCm2lx0PkOSkrlycOddXobKKI98vAS/UVi2EMkIIbeyknbw3zLqNP
         REECZvtHYXbMCiugcHHNmto+hBL2zLVPkKdxn0M65EhxvPkt2DKk7gV8HpsGXz3k12NX
         +XiquFH+wwMhkD8FtHaIMmifWwyUHjEvYHF/mef6mmXCR7muFtFYGyU7T70fUjpwOq75
         RfD1a8DQlvsJzjO+l+Gk686bqjYXKc5IGIUPzzJBDZRSbLgPbnxyNNrICdRmKlQhcO+R
         5uPqAWN042oFY3+kLR9CszfqVSMAjVcSVRHoJImV+6Tz3PED3NfHTQrEC0y0XHXpg8nN
         hZQw==
X-Forwarded-Encrypted: i=1; AJvYcCWMpsLSVD8pUWIZTkjz4+cB5rMruHZwL3i7fHrDbfuw5KzbL85tTX/Qa6o2XcLMT+WbRraV4bwPjpxOuBc/FUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/99UpPDvNofdxuYdk8qn1dP/D/k0QqtXS2d2BokLFqvJKcft2
	4+xWv0sfApxc2sReteLE9zXRZloQ4Z0BnNB+GQPTq1wodSQDThxUKB+lzRVNKg==
X-Gm-Gg: ASbGnctTsMgILGWIWxw///5R8IpsOXvTut8gwHIZZUQuvwjlxvcQggwVSNEM/WxnKvy
	NMx4gbRKs7GD8A4XJgmsekNiTFF8sOVLPIjGEt6bufhUifFjRbXkumGp/uiqb3jTFh0XGtj3BnM
	PHKkGpx6CUBzgdXGBI0HFRA2DvmjpysGzbDyWNAJUfKKo4AzJZbXLgY12zBheukeBUJm/TIimJg
	qX1Aamqmh+vZKOicZ4Jqyatru9jQ8Z8J/QZgZp/gYJcy22HeYPYkONkQ6kIGB8qwL92hHpmcFfk
	psmgr0cLE6N0INxER9UbCvxz9V88X5rM3KzDLHAFjSWp/D/MVKXcEpJ5/QGtP9O9Jm69Ffl05xX
	KadUOgg6q+0w=
X-Google-Smtp-Source: AGHT+IHct0Y/HPdTudotgDrMkhOC/Gqh0P/h5DFuXgasUmqgBiIUkvyCvRBlCVJGcbLI22/xe1VfaA==
X-Received: by 2002:a05:600c:3547:b0:45b:8039:6196 with SMTP id 5b1f17b1804b1-46201e96069mr23430525e9.4.1758116034842;
        Wed, 17 Sep 2025 06:33:54 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::30b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdd4d15ecsm3871446f8f.11.2025.09.17.06.33.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Sep 2025 06:33:54 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: shuah@kernel.org,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v3 1/1] selftests/mm: skip soft-dirty tests when CONFIG_MEM_SOFT_DIRTY is disabled
Date: Wed, 17 Sep 2025 21:31:37 +0800
Message-ID: <20250917133137.62802-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

The madv_populate and soft-dirty kselftests currently fail on systems where
CONFIG_MEM_SOFT_DIRTY is disabled.

Introduce a new helper softdirty_supported() into vm_util.c/h to ensure
tests are properly skipped when the feature is not enabled.

Acked-by: David Hildenbrand <david@redhat.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
v2 -> v3:
 - Optimize softdirty_supported() by directly assigning check_vmflag()
   result (per David)
 - Pick AB from David - thanks!
 - https://lore.kernel.org/lkml/20250917122750.36608-1-lance.yang@linux.dev

v1 -> v2:
 - Rename softdirty_is_supported() to softdirty_supported() (per David)
 - Drop aarch64 specific handling (per David)
 - https://lore.kernel.org/lkml/20250917055913.49759-1-lance.yang@linux.dev

 tools/testing/selftests/mm/madv_populate.c | 21 ++-------------------
 tools/testing/selftests/mm/soft-dirty.c    |  5 ++++-
 tools/testing/selftests/mm/vm_util.c       | 17 +++++++++++++++++
 tools/testing/selftests/mm/vm_util.h       |  1 +
 4 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index b6fabd5c27ed..d8d11bc67ddc 100644
--- a/tools/testing/selftests/mm/madv_populate.c
+++ b/tools/testing/selftests/mm/madv_populate.c
@@ -264,23 +264,6 @@ static void test_softdirty(void)
 	munmap(addr, SIZE);
 }
 
-static int system_has_softdirty(void)
-{
-	/*
-	 * There is no way to check if the kernel supports soft-dirty, other
-	 * than by writing to a page and seeing if the bit was set. But the
-	 * tests are intended to check that the bit gets set when it should, so
-	 * doing that check would turn a potentially legitimate fail into a
-	 * skip. Fortunately, we know for sure that arm64 does not support
-	 * soft-dirty. So for now, let's just use the arch as a corse guide.
-	 */
-#if defined(__aarch64__)
-	return 0;
-#else
-	return 1;
-#endif
-}
-
 int main(int argc, char **argv)
 {
 	int nr_tests = 16;
@@ -288,7 +271,7 @@ int main(int argc, char **argv)
 
 	pagesize = getpagesize();
 
-	if (system_has_softdirty())
+	if (softdirty_supported())
 		nr_tests += 5;
 
 	ksft_print_header();
@@ -300,7 +283,7 @@ int main(int argc, char **argv)
 	test_holes();
 	test_populate_read();
 	test_populate_write();
-	if (system_has_softdirty())
+	if (softdirty_supported())
 		test_softdirty();
 
 	err = ksft_get_fail_cnt();
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 8a3f2b4b2186..4ee4db3750c1 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -200,8 +200,11 @@ int main(int argc, char **argv)
 	int pagesize;
 
 	ksft_print_header();
-	ksft_set_plan(15);
 
+	if (!softdirty_supported())
+		ksft_exit_skip("soft-dirty is not support\n");
+
+	ksft_set_plan(15);
 	pagemap_fd = open(PAGEMAP_FILE_PATH, O_RDONLY);
 	if (pagemap_fd < 0)
 		ksft_exit_fail_msg("Failed to open %s\n", PAGEMAP_FILE_PATH);
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 56e9bd541edd..e33cda301dad 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -449,6 +449,23 @@ bool check_vmflag_pfnmap(void *addr)
 	return check_vmflag(addr, "pf");
 }
 
+bool softdirty_supported(void)
+{
+	char *addr;
+	bool supported = false;
+	const size_t pagesize = getpagesize();
+
+	/* New mappings are expected to be marked with VM_SOFTDIRTY (sd). */
+	addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
+		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+	if (!addr)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	supported = check_vmflag(addr, "sd");
+	munmap(addr, pagesize);
+	return supported;
+}
+
 /*
  * Open an fd at /proc/$pid/maps and configure procmap_out ready for
  * PROCMAP_QUERY query. Returns 0 on success, or an error code otherwise.
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 07c4acfd84b6..26c30fdc0241 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -104,6 +104,7 @@ bool find_vma_procmap(struct procmap_fd *procmap, void *address);
 int close_procmap(struct procmap_fd *procmap);
 int write_sysfs(const char *file_path, unsigned long val);
 int read_sysfs(const char *file_path, unsigned long *val);
+bool softdirty_supported(void);
 
 static inline int open_self_procmap(struct procmap_fd *procmap_out)
 {
-- 
2.49.0


