Return-Path: <linux-kselftest+bounces-23999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BADA043F2
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 16:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3292A3A3F43
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 15:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913971F3D32;
	Tue,  7 Jan 2025 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UiQRK0pO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kfi/QA9H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03FD1F2395;
	Tue,  7 Jan 2025 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262900; cv=none; b=RrWTe6puIlW59Gs82spdC8XVKy6krtstsrs9bQJsVYmgMNrbvQTyVjJLAGbWTyRg3w8/u4e8VwzlCQzdsUos+gGZsf5j13uG9xtb80tFVQcvQndtLV6wPNSQtvM4xwgvf6MBLpfLw8ICNRx3o+uJsxgAx2bJVgBEhbrprboCCUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262900; c=relaxed/simple;
	bh=MeslUuRpp6snP8kaY60rYzKdJKBjCd/nlz8O3AupkXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gnt7lJsTa40FdtS/XwyROxgICBT9KJBWTwPkvYHNatpN1VQicvSb/19BOkvbIM5qGBTwFvFeAqwxv/57TwBn6v2ktVobQbgnxZguwdfpfLfeLD2HVUV9/H8c0uXZJHIhxWppXA39vTpU6kWlMUqLw+Qd/8RcukbYlPQodSaKZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UiQRK0pO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kfi/QA9H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736262896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tydfE0F+64UOWjWNZaYZ/G6V8qY6qkkoQjYUo5kzM8U=;
	b=UiQRK0pOMnBJssXVy82Zjf1x4fX0s6WRl+VbZBBCpTDHc/y/KzVxCjU8wCZTMEqfWR3CTC
	GkwWkidrZdh7otQx6AY4tbdd6bGm1RZhEbTUM455gxI/uYzwItJNYnFGMpl+iAyeNm4x0N
	Wf+kMoOtKaMN9PFgMyPViFjRTqO3unAmJZx0hlO5vAJX2AAdzO1Egbwa2I1uVQpWuHt+VE
	Oc23zoruxrccDh8+ZMtLsUonylVw+yjkbOejLe3JSC+J9ZdlMXcpEDIWPcSGsbovpafcU/
	xE1656kYniX8lstBNsSSBpui7QJdkqSgGHt5rDDBa8w9mVSaES7WlLw/n8FHeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736262896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tydfE0F+64UOWjWNZaYZ/G6V8qY6qkkoQjYUo5kzM8U=;
	b=Kfi/QA9HsvdZ4syxi4iEtnoRj7YoGxTHEfXpJeTF/g6P+zPt8wSKZ8n1LlDIE+CmZardgk
	JjIVXg8097Oa12Ag==
Date: Tue, 07 Jan 2025 16:14:47 +0100
Subject: [PATCH 3/3] selftests/mm: virtual_address_range: Dump to /dev/null
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250107-virtual_address_range-tests-v1-3-3834a2fb47fe@linutronix.de>
References: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
In-Reply-To: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736262892; l=2277;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=MeslUuRpp6snP8kaY60rYzKdJKBjCd/nlz8O3AupkXI=;
 b=NgTUKSqcuckegdTFYfiFIOnS20yzvT8cJRDvGk4KpA/YgWzMR5+yLFIoBtpKsziXFS/XXkBns
 TiPuiJvnbd+C2YlaXpIPif/pnn6JvFsSRrw925v6Gp3yFUsERRJgQl7
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

During the execution of validate_complete_va_space() a lot of memory is
on the VM subsystem. When running on a low memory subsystem an OOM may
be triggered, when writing to the dump file as the filesystem may also
require memory.

On my test system with 1100MiB physical memory:

	Tasks state (memory values in pages):
	[  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
	[     57]     0    57 34359215953      695      256        0       439 1064390656        0             0 virtual_address

	Out of memory: Killed process 57 (virtual_address) total-vm:137436863812kB, anon-rss:1024kB, file-rss:0kB, shmem-rss:1756kB, UID:0 pgtables:1039444kB oom_score_adj:0
	<snip>
	fault_in_iov_iter_readable+0x4a/0xd0
	generic_perform_write+0x9c/0x280
	shmem_file_write_iter+0x86/0x90
	vfs_write+0x29c/0x480
	ksys_write+0x6c/0xe0
	do_syscall_64+0x9e/0x1a0
	entry_SYSCALL_64_after_hwframe+0x77/0x7f

Write the dumped data into /dev/null instead which does not require
additional memory during write(), making the code simpler as a
side-effect.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/mm/virtual_address_range.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index 484f82c7b7c871f82a7d9ec6d6c649f2ab1eb0cd..4042fd878acd702d23da2c3293292de33bd48143 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -103,10 +103,9 @@ static int validate_complete_va_space(void)
 	FILE *file;
 	int fd;
 
-	fd = open("va_dump", O_CREAT | O_WRONLY, 0600);
-	unlink("va_dump");
+	fd = open("/dev/null", O_WRONLY);
 	if (fd < 0) {
-		ksft_test_result_skip("cannot create or open dump file\n");
+		ksft_test_result_skip("cannot create or open /dev/null\n");
 		ksft_finished();
 	}
 
@@ -152,7 +151,6 @@ static int validate_complete_va_space(void)
 		while (start_addr + hop < end_addr) {
 			if (write(fd, (void *)(start_addr + hop), 1) != 1)
 				return 1;
-			lseek(fd, 0, SEEK_SET);
 
 			hop += MAP_CHUNK_SIZE;
 		}

-- 
2.47.1


