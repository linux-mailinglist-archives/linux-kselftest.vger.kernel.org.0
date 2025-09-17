Return-Path: <linux-kselftest+bounces-41656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E485B8018E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BFD1C0014B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 05:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33C127E077;
	Wed, 17 Sep 2025 05:59:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F1627E076
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 05:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088765; cv=none; b=R1QK4FajvgYewpu6zw3Pxj3AKFaLD7XL3gK8yP1xbXB18hkt/hfRaJHUpOQu897Yfw04ms0oxclAEaVS9GUGVsBhnWJNLQrEvd2gZrzgFqDBl6qfhrv2K/Th23sjCke0KRYvGK95oHdphFbwgnOcOXC8VhrbkRR33ovpv1Kf1U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088765; c=relaxed/simple;
	bh=8R658MgjSKQ6OjkgZybldgeN9jzE69wFj18W4yvtA1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NjmH5V/h3BtivTaBDM51XUsPQwnFr6Rty2tu1jaCj8x95vHxsVhHA/hoTryZ519VTmKx3zn/6k+HdO+Yjbi5ynTUr8KH8Ka5xtFjhzwtGLKpRAF6auk1gxhJvAYnv4ekSTfAvzC0DqDXMzTKKeouVn/8HV26NwA23axK4Y+c2fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f2c9799a3so21410735e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 22:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758088762; x=1758693562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlrrbpNOChtNjzl9J83pPts581jGsxoyMpwY2SqwJY4=;
        b=FFzmvn2hjhVwhk9hJhDhrk2B1bFtpYmrOf1CE/5N4oDlKwKxNiOB0f2fSxl0vXzEw6
         gaiSwsa+2uHw1Rr4SIF5Ch8cqwOpS586OUQJon9Bpd4Vx8mNU9i2EDq/JQDTgfP+FDOh
         pyy/XjhAy8PXJMlwU2B0tUfnBOiyhO6PRCdANi3NdBEGqmcvzn3u3yHfCvRjpsGh+bcn
         g3GEfhklv8XwOxjFcRWzIA8ow0OjX7XPqcN90kbVZyEzrdaTfiZHDzfp2X4B/+qIdhg8
         RPz6PT7gGTLcciu2Fil2HQkxhaJXc+mOF9wfz7wmiJUEE3vx7NAO9lRRTUewXQK3hVon
         X2Yw==
X-Forwarded-Encrypted: i=1; AJvYcCW2LWjgT8mV5zk1komPU8sdaeD1ExcfuOjle1TWFF/LlkmAxFzgAXcK0Mk4+XtIRPZWSsqygEaDN08yfkDQ3QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBWRqH3udz711zba0Zrk8itRm5I9mk0GTt1HX3r35ezrqEoB5
	DHi7w2VzE9ekFN9Vnar/bjg5PnVXu/5VqoLTHEql6E5GvZUaX1LMQ3HM
X-Gm-Gg: ASbGncvFixqpl+TCYqkBbUc5tauMvXEG3PnOkiajuxhJes4gRJcdYTe/0qout1jtRa7
	k9tVNJmypHhx9kcIrYqrWORIaMiwufxDXuGEMSkKtRbAc6yMCII+OjjQ32iZeRKzqHTmJF6DlAq
	jxOUnF4MePxzUVpatZkh+ADJllupW8HMraYx+NT3mTK00YR4L0kK/8TdzRVHogQBQvI4mAQ8lyg
	odJMGgZOPIdhDneQj1jHkQjDowKLKJo/4tcfQbIMztGfKkuWI3RBATOVvYEbGE795kcY++GglqG
	oU1S9sVfo/SG4Zj/WpE/U70QLleL6aQOaTSczw6Pp4Q+eP/6TPkEl+OmnzMPdNDPh1iYovy7ANM
	dkXx1LicmNwEDpLA93gk=
X-Google-Smtp-Source: AGHT+IH9W7esOzFT5IkroJVMwtaxdDK6d7E9R4NeEsWdBedzAfyvLtUnHVT1+OGn9VtvheonzXFrmg==
X-Received: by 2002:a05:6000:1863:b0:3e7:6474:1b63 with SMTP id ffacd0b85a97d-3ecdfa3d20fmr589203f8f.63.1758088761975;
        Tue, 16 Sep 2025 22:59:21 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::3086])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7c778f764sm19485191f8f.57.2025.09.16.22.59.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Sep 2025 22:59:21 -0700 (PDT)
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
Subject: [PATCH RESEND 1/1] selftests/mm: skip soft-dirty tests when CONFIG_MEM_SOFT_DIRTY is disabled
Date: Wed, 17 Sep 2025 13:59:13 +0800
Message-ID: <20250917055913.49759-1-lance.yang@linux.dev>
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

Introduce a new helper softdirty_is_supported() into vm_util.c/h to ensure
tests are properly skipped when the feature is not enabled.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 tools/testing/selftests/mm/madv_populate.c | 21 ++--------------
 tools/testing/selftests/mm/soft-dirty.c    |  5 +++-
 tools/testing/selftests/mm/vm_util.c       | 28 ++++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h       |  1 +
 4 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index b6fabd5c27ed..43dac7783004 100644
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
+	if (softdirty_is_supported())
 		nr_tests += 5;
 
 	ksft_print_header();
@@ -300,7 +283,7 @@ int main(int argc, char **argv)
 	test_holes();
 	test_populate_read();
 	test_populate_write();
-	if (system_has_softdirty())
+	if (softdirty_is_supported())
 		test_softdirty();
 
 	err = ksft_get_fail_cnt();
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 8a3f2b4b2186..98e42d2ac32a 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -200,8 +200,11 @@ int main(int argc, char **argv)
 	int pagesize;
 
 	ksft_print_header();
-	ksft_set_plan(15);
 
+	if (!softdirty_is_supported())
+		ksft_exit_skip("soft-dirty is not support\n");
+
+	ksft_set_plan(15);
 	pagemap_fd = open(PAGEMAP_FILE_PATH, O_RDONLY);
 	if (pagemap_fd < 0)
 		ksft_exit_fail_msg("Failed to open %s\n", PAGEMAP_FILE_PATH);
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 56e9bd541edd..3173335df775 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -449,6 +449,34 @@ bool check_vmflag_pfnmap(void *addr)
 	return check_vmflag(addr, "pf");
 }
 
+bool softdirty_is_supported(void)
+{
+	char *addr;
+	int ret = 0;
+	size_t pagesize;
+
+	/* We know for sure that arm64 does not support soft-dirty. */
+#if defined(__aarch64__)
+	return ret;
+#endif
+	pagesize = getpagesize();
+	/*
+	 * __mmap_complete() always sets VM_SOFTDIRTY for new VMAs, so we
+	 * just mmap a small region and check its VmFlags in /proc/self/smaps
+	 * for the "sd" flag.
+	 */
+	addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
+		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+	if (!addr)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	if (check_vmflag(addr, "sd"))
+		ret = 1;
+
+	munmap(addr, pagesize);
+	return ret;
+}
+
 /*
  * Open an fd at /proc/$pid/maps and configure procmap_out ready for
  * PROCMAP_QUERY query. Returns 0 on success, or an error code otherwise.
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 07c4acfd84b6..87ad8e0d92c0 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -104,6 +104,7 @@ bool find_vma_procmap(struct procmap_fd *procmap, void *address);
 int close_procmap(struct procmap_fd *procmap);
 int write_sysfs(const char *file_path, unsigned long val);
 int read_sysfs(const char *file_path, unsigned long *val);
+bool softdirty_is_supported(void);
 
 static inline int open_self_procmap(struct procmap_fd *procmap_out)
 {
-- 
2.49.0


