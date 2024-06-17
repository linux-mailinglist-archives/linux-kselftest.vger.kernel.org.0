Return-Path: <linux-kselftest+bounces-12026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E3490A356
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 07:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83071F21F59
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 05:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9617181326;
	Mon, 17 Jun 2024 05:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnOwnzWU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB8181330;
	Mon, 17 Jun 2024 05:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718602186; cv=none; b=U4wNQKrzPEGXY8RRy5qqvGAVNcMFDxdpy03z3VTOZ1MIkwetAuydxVFdNFidljbfbBRJDe3xulknFiZ4wGR4jbjVZ15dHgG3uMmr1iI60jVGor0zOItpYlvAHj5vfKAWIBys6K1FvBxdPG2j34vxenp2css2xe/HIigT8Eeut7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718602186; c=relaxed/simple;
	bh=VZl9Dt00+pQFuwUZq2ZbWrXnzRU7zRHOGJ+iYooxmx0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BIasybgKa8LYCjbjWPpkgBSlUAxA69fIxRU/5bd3p/snz4pEle4+2irU87pj63h7bBmUsZPisRXApePnG78XL5bklNO02UaH4bcFlThCa2k6PMlHd7oos1n9HJuRwPOKy1jIiyEQAuK0+I5EBpvhjIiZUG5WXtu5c5PZHJPAGM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnOwnzWU; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2c4e2cd931aso521199a91.0;
        Sun, 16 Jun 2024 22:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718602184; x=1719206984; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUsI5R+Z0iy5fF8mDhU7qwVZOawS/mIqRte7Pe8J3zI=;
        b=YnOwnzWUaZmO/D+ow7ns103fHsew4JkE0bhjlHn2ZOS6wVzASxBOqXnfbRT49c3adA
         2+B4R6MfoL+o0+q4AcPoNes9DAlJMXJW9ri6tvm1fTYCi6Dbsg0nMG1iJX7R6kbZXP3L
         pY3pBVkxgBvb0O+otaSy/kyEjOACnEHN9Sq4qL/49ipjbNR6ZtHBfMj2OJ8Ri2AE7eIm
         BLXdlGZ2xB5H+6m3eq4eVO2HnuukuNP8445tPCnUmfzW+mK1uGNxwOAZOLUCklsAl3+2
         dbIZUYCF+uVMhI8j2MW8X7FfEI77cMfKo8YEH1BH1HWTfchYTOIulZz97s/1A8tj4qEA
         aa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718602184; x=1719206984;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUsI5R+Z0iy5fF8mDhU7qwVZOawS/mIqRte7Pe8J3zI=;
        b=OnOUjEjHzsl3pvpHV5m2XNG9LYXP5qRv0pqoxYwYaqThLn+Yc0g/HKij9CR6x9D3Nf
         SMsaXrcoX9NwXDT131K0Q9Apr7C/SZ8utvqZNpwgqbGQZMSIYRuKrNsXESHQwVNG7y2S
         ts7nyqtuN9sBhMLUuRa5O8yOAEAOu23vO88IhCtPzGRfRzja9GHDejdVwYv88RWAJ97J
         cYjRZicRBmUqM0PbrhE2GNPpuh0wCo1Hu8IRHecvsNrblVz3m8Vi0VsY7zDv/ZmK52GZ
         jeeEPO5YGTg3cohzjshhMc3TWZ/UBknGpNLlxasQkR+cd3kR+ftkMQsvo7yeCJ6HThGc
         br1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXk/StLLP9BKjv5xy2hRKJqisoQ+8rvvSGoP8JuPgTKJel7+oQch4RQiED3lUe/Q4TOvlXmEhpKUnCdNGgixJTJHhV6SBrbRm+SXeblTuWSTJet+rs6umgvbHwvN/c+wT8hwpNTKP2ZnLqkgcTS
X-Gm-Message-State: AOJu0YwSXZG8fKXMzb7CNu9Y/6+Jfoopwt67jPW+rq9vqtq5BHjoVTKz
	/jZngjuqt3IIDd4FVjMvo7e2WKeqas/m38sXihXPLj6qgWbz7cGw
X-Google-Smtp-Source: AGHT+IH3QQcBtYgpWXy8Eibq53Mk2mB6I+M4MbSta2aASqh/Q1m8xZoJHiVBxZsXJ0RpaXUKk29i0w==
X-Received: by 2002:a17:902:d4c7:b0:1f2:f9b9:8796 with SMTP id d9443c01a7336-1f8627eb9fcmr102562255ad.2.1718602184316;
        Sun, 16 Jun 2024 22:29:44 -0700 (PDT)
Received: from localhost.localdomain ([117.147.90.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f88daf2b8dsm11699355ad.193.2024.06.16.22.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 22:29:43 -0700 (PDT)
From: aigourensheng <shechenglong001@gmail.com>
To: akpm@linux-foundation.org
Cc: shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aigourensheng <shechenglong001@gmail.com>
Subject: [PATCH] selftests/mm:fix test_prctl_fork_exec return failure
Date: Mon, 17 Jun 2024 01:29:34 -0400
Message-Id: <20240617052934.5834-1-shechenglong001@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

after calling fork() in the test_prctl_fork_exec() function,
the global variable ksm_full_scans_fd is initialized to 0
in the child process upon entering the main function
of ./ksm_functional_tests.
In the function call chain test_child_ksm() ->
__mmap_and_merge_range -> ksm_merge-> ksm_get_full_scans,
start_scans = ksm_get_full_scans() will return an error.
Therefore, the value of ksm_full_scans_fd needs to be
initialized before calling test_child_ksm in the child process.

Signed-off-by: aigourensheng <shechenglong001@gmail.com>
---
 .../selftests/mm/ksm_functional_tests.c       | 38 +++++++++++--------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 37de82da9be7..b61803e36d1c 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -656,12 +656,33 @@ static void test_prot_none(void)
 	munmap(map, size);
 }
 
+static void init_global_file_handles(void)
+{
+	mem_fd = open("/proc/self/mem", O_RDWR);
+	if (mem_fd < 0)
+		ksft_exit_fail_msg("opening /proc/self/mem failed\n");
+	ksm_fd = open("/sys/kernel/mm/ksm/run", O_RDWR);
+	if (ksm_fd < 0)
+		ksft_exit_skip("open(\"/sys/kernel/mm/ksm/run\") failed\n");
+	ksm_full_scans_fd = open("/sys/kernel/mm/ksm/full_scans", O_RDONLY);
+	if (ksm_full_scans_fd < 0)
+		ksft_exit_skip("open(\"/sys/kernel/mm/ksm/full_scans\") failed\n");
+	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+	if (pagemap_fd < 0)
+		ksft_exit_skip("open(\"/proc/self/pagemap\") failed\n");
+	proc_self_ksm_stat_fd = open("/proc/self/ksm_stat", O_RDONLY);
+	proc_self_ksm_merging_pages_fd = open("/proc/self/ksm_merging_pages",
+						O_RDONLY);
+	ksm_use_zero_pages_fd = open("/sys/kernel/mm/ksm/use_zero_pages", O_RDWR);
+}
+
 int main(int argc, char **argv)
 {
 	unsigned int tests = 8;
 	int err;
 
 	if (argc > 1 && !strcmp(argv[1], FORK_EXEC_CHILD_PRG_NAME)) {
+		init_global_file_handles();
 		exit(test_child_ksm());
 	}
 
@@ -674,22 +695,7 @@ int main(int argc, char **argv)
 
 	pagesize = getpagesize();
 
-	mem_fd = open("/proc/self/mem", O_RDWR);
-	if (mem_fd < 0)
-		ksft_exit_fail_msg("opening /proc/self/mem failed\n");
-	ksm_fd = open("/sys/kernel/mm/ksm/run", O_RDWR);
-	if (ksm_fd < 0)
-		ksft_exit_skip("open(\"/sys/kernel/mm/ksm/run\") failed\n");
-	ksm_full_scans_fd = open("/sys/kernel/mm/ksm/full_scans", O_RDONLY);
-	if (ksm_full_scans_fd < 0)
-		ksft_exit_skip("open(\"/sys/kernel/mm/ksm/full_scans\") failed\n");
-	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
-	if (pagemap_fd < 0)
-		ksft_exit_skip("open(\"/proc/self/pagemap\") failed\n");
-	proc_self_ksm_stat_fd = open("/proc/self/ksm_stat", O_RDONLY);
-	proc_self_ksm_merging_pages_fd = open("/proc/self/ksm_merging_pages",
-					      O_RDONLY);
-	ksm_use_zero_pages_fd = open("/sys/kernel/mm/ksm/use_zero_pages", O_RDWR);
+	init_global_file_handles();
 
 	test_unmerge();
 	test_unmerge_zero_pages();
-- 
2.17.1


