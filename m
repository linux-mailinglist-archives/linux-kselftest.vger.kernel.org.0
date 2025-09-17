Return-Path: <linux-kselftest+bounces-41655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EA6B80185
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF271899EFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 05:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EF326A0C6;
	Wed, 17 Sep 2025 05:56:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7891C5F23
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088599; cv=none; b=kLIXYRxLVnn0ikGmi8C/w5fOu7IZAYyr9iur0vXilsk41F0ncMhwh6z3W7q54INNUKnZJNtrID39dDxO4MIwun0VAXDkSqAMHvDwSMz0gsJJ1mIVVkdssQpMprs4N602qTOBl6h4zfWttzK3dgYcZJE9/MhV+IYfStF9F4b/Xnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088599; c=relaxed/simple;
	bh=HEAtg16SjSSpTPSJTLyQUgy2jQeNKW9e6mUD3MY3hAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qTPabAki3VvrGnvDnl+v2vUemWxocXXA0rYC1pr3FeoopnaM3Bkzro+7ZAToywZ/hegJYq+FukfUaXza/CoTAK0xuaHhTGH6qCEZ86u58EUfLoOFAILXHoHMqMa+rDA/akHxgBuZRxF5S22vep7FftN8azGnqbnIoD4gKfaDl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e9042021faso2534903f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 22:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758088596; x=1758693396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rL2rlM29fREnsY3UP4GCd3w0RbbtqI2tzuuAuaZNNM=;
        b=fwJvhdm421lkUZ+m7QrSDk2cMA6zPSsOY+1nS3gFhz7fCeaqqWvKZdn9xm9R7cVwJw
         erDRsLmw3MbL4Y+QdjIdfYmuIgV1fttml+wG2sUREU4c2k//4l5x5MqZ29bSPpycYkPT
         u45ufrrUyz4bWKCBn9f1fMZ6JcjM1TYcThuBpdcX4bVEEUKIS5C59s9Q9m8TxvDYRCby
         N2DR+6MpGu1l35hgs1ET7mdEjEyZPK6hXpwQxyfBgJKSN7QVB8bUuClX3DHinTYinBdK
         cvtcedzuY5NT1HUtX6H83IITrVf/9guyTWoLcLI3OEeDUAGS6DkYHK+nVHaNKICis2g+
         n+jg==
X-Forwarded-Encrypted: i=1; AJvYcCUXrJUoW14jIkfMosHHpqT3m5NbB/VVRkR2KoCinorDhJKxoc857/T4bKpH+2ooJ382VsGDDjb2Luj/KGwr6xY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFXBa80wUBgEbR3wyeqQSCwI1CUzttK8jgL2HNvSSM3/iMRV3F
	/IB4US0qBUk9K26IwbzyF9s/lmjFtVXnVLw5W8L1Nbx/xY9scDNLRulpYuekUw==
X-Gm-Gg: ASbGncsDqhJNVfQiCxw0Lya/SH/fkCcDoL3dkPtN8jX74E9B0hNZWV3ReOaaERgb5wK
	7PCnm2kUc26Elpmw95rSq5+ZARdNR7+qJmr9Ix7LLDcoxjbpDKb7VKMEgx/XNyqE0afyEyWGcil
	xEMng/ImquXdT03aGk3kfdFmJpgCtXY0uu35dfoNez/iSO4C34R2U67UIi6Ym8qG/a5GTUJ+2HD
	qJU+BEVkw+jmxnursyCTxPOT1YvMyJ+uhcWMGgaiWvaEID/9nJf2Gmgik8Y/Sk5rVDHY1tmRIbT
	fZjPI1yOCilqexCG19tVkAZFC/yqrJqkuNi4aVbQ5zFkouXtfhyY+JlH9uTg/preJoQXK3ANdxq
	hdg+zCOQd
X-Google-Smtp-Source: AGHT+IGjxHPHG8T6fPu431Ka9rSzcuna7td6QNzojHq1qsMru8NT7pUxzrEnuuQd7KWe/4SL2weFmQ==
X-Received: by 2002:a5d:64c8:0:b0:3ea:e0fd:28ea with SMTP id ffacd0b85a97d-3ecdfa0d2e6mr682457f8f.39.1758088595501;
        Tue, 16 Sep 2025 22:56:35 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::3086])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdf0bbf24sm1433237f8f.63.2025.09.16.22.56.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Sep 2025 22:56:34 -0700 (PDT)
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
Subject: [PATCH 1/1] selftests/mm: skip soft-dirty tests when CONFIG_MEM_SOFT_DIRTY is disabled
Date: Wed, 17 Sep 2025 13:56:22 +0800
Message-ID: <20250917055622.46564-1-lance.yang@linux.dev>
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


