Return-Path: <linux-kselftest+bounces-31770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15722A9F0F9
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 14:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC4D17441F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B12226AAB8;
	Mon, 28 Apr 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gIwg4Tsu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lcFmL2Cm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707B726980C;
	Mon, 28 Apr 2025 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844014; cv=none; b=KFmamXfQy3qvkesi1gQ3I+GWjsceI/WrQaMCAL2KOktVxwuPevr3suNdYgjYmE1PKqrHMODY+do0ERPOrK6KN3KCVO1jx/Zfno1EpZxfrIhbaOyZFXf1rKCv3dQlirMzim148iIoU7ThvG1E7qhp4Pu4Wb0bmYZkoN3Xlr9lO6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844014; c=relaxed/simple;
	bh=x7vlVk9lwh5FEmDyAto9R37oXEH+y51IIvotdJ4TcKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BW304drDgR2Q/Vza0g6Mjlf427h0fkONj1pfGlsBJYCDyTyMJEThFU67sCR+mIbjGvVAxrH0BiI1wUzezJlkxTyz5T+TeEwwNzKxS2WDFokKy/Ky62o6kpWr9d3kbTIZUoKsvUipZl9vlT1Psx6VXXSt5wsDVlg5JRWGUNvtBIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gIwg4Tsu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lcFmL2Cm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745844010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbPWjHhlJoETnAz824XzmvX5jyZFPtPy6g/2Y6azr8U=;
	b=gIwg4TsuLI74B/q4WScfk1HlnLV7sSeJzpII3Vrv8ZY3wNX1HePkzU9VQZw+YCdix1hXNK
	rEFsSgH6WV5xzACdB1XhvOoLz3EOjII1hkwtrRn0+grFetrFxgUDomjY12kUXzHewIQdfl
	S14nrMhlgW+BBYUcsJ/rTOAR8mCIwSwsciEt0aGJb9wzfjcoOIoAZ745Wu+rv6dbpWPUC6
	u9jnCYrCROz4oC2cAJp5MEDASKb2sJw7ujOhSfUyvY0m+yPSZPZeUO3G6FtfLua05ZhUBD
	KRDHjmsqGf57G/PiQqoXWfP6bmKWN22oWExKaEkMwWg5k+azXaJ+9yzAUjT+EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745844010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbPWjHhlJoETnAz824XzmvX5jyZFPtPy6g/2Y6azr8U=;
	b=lcFmL2Cmeme180KmjzZH8dso5SwlCBOV0SRr6gwoudEdeU0wjSGgWlgRNt2ttKzNEtaCkA
	nfBoleFlK2FQoiAg==
Date: Mon, 28 Apr 2025 14:40:05 +0200
Subject: [PATCH v2 04/15] tools/nolibc: add mremap()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-nolibc-misc-v2-4-3c043eeab06c@linutronix.de>
References: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
In-Reply-To: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745844007; l=2698;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=x7vlVk9lwh5FEmDyAto9R37oXEH+y51IIvotdJ4TcKw=;
 b=2+mGdTIJWB7jJfMqgtCXuSBYTlP2bzo4FbtOCG6JqBZehw+Fsa0ydAIjWxTsgXafLmHUA1E1X
 Ida/KUW9TD7Cc9H38GhkfFa9JM9cKFUKWe3dQxv8i39yXdaJw6Gu8Gi
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys/mman.h              | 19 +++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 14 +++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/include/nolibc/sys/mman.h b/tools/include/nolibc/sys/mman.h
index 41c7bf45e427b96efec949364890e9c2b9c226a5..5228751b458c8d8a1bdfb5006623d016a48155fb 100644
--- a/tools/include/nolibc/sys/mman.h
+++ b/tools/include/nolibc/sys/mman.h
@@ -48,6 +48,25 @@ void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
 	return ret;
 }
 
+static __attribute__((unused))
+void *sys_mremap(void *old_address, size_t old_size, size_t new_size, int flags, void *new_address)
+{
+	return (void *)my_syscall5(__NR_mremap, old_address, old_size,
+				   new_size, flags, new_address);
+}
+
+static __attribute__((unused))
+void *mremap(void *old_address, size_t old_size, size_t new_size, int flags, void *new_address)
+{
+	void *ret = sys_mremap(old_address, old_size, new_size, flags, new_address);
+
+	if ((unsigned long)ret >= -4095UL) {
+		SET_ERRNO(-(long)ret);
+		ret = MAP_FAILED;
+	}
+	return ret;
+}
+
 static __attribute__((unused))
 int sys_munmap(void *addr, size_t length)
 {
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index b7440a667db6b541a2548bdf5182bee0277100ed..abe0ae794208762f6d91ad81e902fbf77253a1c1 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -926,7 +926,7 @@ int test_mmap_munmap(void)
 {
 	int ret, fd, i, page_size;
 	void *mem;
-	size_t file_size, length;
+	size_t file_size, length, mem_length;
 	off_t offset, pa_offset;
 	struct stat stat_buf;
 	const char * const files[] = {
@@ -966,14 +966,22 @@ int test_mmap_munmap(void)
 		offset = 0;
 	length = file_size - offset;
 	pa_offset = offset & ~(page_size - 1);
+	mem_length = length + offset - pa_offset;
 
-	mem = mmap(NULL, length + offset - pa_offset, PROT_READ, MAP_SHARED, fd, pa_offset);
+	mem = mmap(NULL, mem_length, PROT_READ, MAP_SHARED, fd, pa_offset);
 	if (mem == MAP_FAILED) {
 		ret = 1;
 		goto end;
 	}
 
-	ret = munmap(mem, length + offset - pa_offset);
+	mem = mremap(mem, mem_length, mem_length * 2, MREMAP_MAYMOVE, 0);
+	if (mem == MAP_FAILED) {
+		munmap(mem, mem_length);
+		ret = 1;
+		goto end;
+	}
+
+	ret = munmap(mem, mem_length * 2);
 
 end:
 	close(fd);

-- 
2.49.0


