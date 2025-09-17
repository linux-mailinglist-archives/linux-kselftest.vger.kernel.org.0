Return-Path: <linux-kselftest+bounces-41673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA76BB7D9D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254BA16B893
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 12:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61133337EB6;
	Wed, 17 Sep 2025 12:28:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E683337EA6
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112095; cv=none; b=UWrHbl0v0cloI76GALJPDn4e8qQ90PRoj2wwyTURmW7kf8M6sfEZXVvuV20LwtuvEdcI0aPi2/QXZYuAiiUvyhLIwt+wxF1Mxbr7Dt8N0Q6B32O+RU7w+HSWiSzIiAXvmtPtnAbTW3ipKj2tyClM67Yhp0jSkMEkbMBcJYSsyuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112095; c=relaxed/simple;
	bh=p0eLd5FnxaTnLyJGUpKveSeYoTasHRMKbTQN6xHgLyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWS7JeB3BxIOJUtLpsS2Jfae6hVHT6HXZ+4vJNlUNrcUvXm0gsKWM0wNK6N+r8ngG/HqiRBV8tlgkZRvniYjRBKL+STkj5yFnw5XUGiW9GIF8hFO6Inyk3SSgfMVKd44RiTadcdqFohdzhBDIuveKFss8LpgPjOAh0vBB76DNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3dae49b117bso5181963f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 05:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758112092; x=1758716892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qD2fpIrArmTyZxxLn48nFl6F/9cW6IoNw/VXQ+AiGyg=;
        b=R1fN9wkeAz3qxSJMQnPzX4fQCc8Tol60paCmmmCYl5dezDNt9/sP7k6jRHZZOc4zET
         JS1dXWt94AjeE3Cev1yRGRHJVUGlPEjg4pcS7oYRxoO/QKXn/wNtvJXDOBen++uk5McI
         wNYfZQ7dr5c4RERjGaU/QDEXJqCDcpJEY69IYVssHg6ROMOBzLVhzAVtWx4wSeKBewtn
         Yluvx6Rg+Dw9Tig/rghKS/bJdDrzmaT+9azGrNH0E/AsZ999Urjbi/fkEaQPT/iDedah
         1KTE+SGgr8pxlxQczQVJ3aGy9FC7YfM6cTO3y/Ps1jcyq8da+FfOXrIkCuVKg4wls5e4
         qIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD3w/VNezm9LFho37wwW/TW4vo18lXRii+O6QujVgc1gsU4CPgZcNmhqUcRYiQEWfQN8iXRnilAYbsHN+7cig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW5bi1CqlJCf9vk9oOKjCcX7Zt6BkVP/RQ6Q/Swwi4fAgs5gsJ
	qBGKG7EFxFlDCYhKaAm0bRMhq5tfxWRvIDvdvPIV/IlUK0qJ09oysD0Y
X-Gm-Gg: ASbGncvB66XbR4pawWKAvI36j87zBRHKevmyw7mFI/b+LcPwmI2yGgkrFilPSk6YMdp
	pVmelcOLWBxQOIGSDJ89r+nnK13vEJwNp45cv5+9brcWdwd4ksnWoix2NC1ndP5lM105RC6ewCL
	S6Z+dhpYyu8xWkFJuv/0Y2+ecM8uWanbM1vxhBxBcivcq7GgLENVbqQXy9gIr9lOlmefmWfaTyr
	32ZIN9b2ajBXe5FXH3FXJ6L6uKqgXThlWchwEJD62nDux22y8XD1PoNp5w/bwIooUJXIgEBo0wb
	QizEQCvM1SS1SYXRsP9aipDsE8D4EXqETokeYvVl6qczXYWi5ca0h1BP0dhrpv2GkDSj/wvYORO
	xDdLOkldF
X-Google-Smtp-Source: AGHT+IEhRdB7nBids5w22yMAJVOTFKi7URkF3KNMkIzMofyDJUedOPZhjL9ZUsgPqYsxBt2TT+mIxw==
X-Received: by 2002:a05:6000:2313:b0:3ea:6680:8fa3 with SMTP id ffacd0b85a97d-3ecdfa35214mr1949003f8f.42.1758112091433;
        Wed, 17 Sep 2025 05:28:11 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::3086])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e911188fb9sm16275658f8f.28.2025.09.17.05.28.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Sep 2025 05:28:10 -0700 (PDT)
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
Subject: [PATCH v2 1/1] selftests/mm: skip soft-dirty tests when CONFIG_MEM_SOFT_DIRTY is disabled
Date: Wed, 17 Sep 2025 20:27:50 +0800
Message-ID: <20250917122750.36608-1-lance.yang@linux.dev>
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

Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
v1 -> v2:
 - Rename softdirty_is_supported() to softdirty_supported() (per David)
 - Drop aarch64 specific handling (per David)
 - https://lore.kernel.org/lkml/20250917055913.49759-1-lance.yang@linux.dev

 tools/testing/selftests/mm/madv_populate.c | 21 ++-------------------
 tools/testing/selftests/mm/soft-dirty.c    |  5 ++++-
 tools/testing/selftests/mm/vm_util.c       | 19 +++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h       |  1 +
 4 files changed, 26 insertions(+), 20 deletions(-)

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
index 56e9bd541edd..ac41d10454a5 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -449,6 +449,25 @@ bool check_vmflag_pfnmap(void *addr)
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
+	if (check_vmflag(addr, "sd"))
+		supported = true;
+
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


