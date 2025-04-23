Return-Path: <linux-kselftest+bounces-31409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0637A98F06
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F287A521E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4A62857C5;
	Wed, 23 Apr 2025 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rIDQAI1U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H9Ed+i7p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9854328469F;
	Wed, 23 Apr 2025 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420504; cv=none; b=VcHsAwBulpky7KDrE0GBMErTHsr7ZAtfurO+5mVjI3tgihwcIxJ+ym7HMl/4qcrdpJU99+g3aqjvmHtI8kFEEIEild+a1RzYlTxXde48QDvErYBqgUo5JEv/Y8CUkmQpVyjhy8h/Q8I29V4tHlayR08gwlaBaUkmZSP4mRqQp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420504; c=relaxed/simple;
	bh=jBXf5Mtp9KvxjCbpxdmGGb3Wzx4EvSPLG4sESOoybeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d2a4aB0KW9buE+4pTz0yMnmD8w28kC0dBKZzm+YggMjoxpMlGUMb/Q1mOedaA4sNgAnhtpdIlLt2Rr16FjnbLdTGzBQ3YYh/HLeB7Q6VGBoq6Z+6NESJxCtMsVmkmUBcapfIjLniLPvCUIANZzYxS4TUor8OyziShiioneUYvMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rIDQAI1U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H9Ed+i7p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745420501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWLbPEK5LvxBlDZi/5mdWIWYYff5AO7fk+5OpUiSiZU=;
	b=rIDQAI1UceFgts2Y98B5e3CKEXXFh4jm4guFodHltQEbrKdig3eVnbky1zBfKSDSWlh3XV
	pT5gslxCSJEAUAEenP4DOJOMvGZXmG/x4yKBdoFOb7a0jMxU5fAZBn6aqt/SU49/osgr2f
	JKCvs9YP3ypifU127eRRgLyWyFDkabnYfV+nZajDaBA9VwOYX3LLNNEvEafp5YCjX2VyIL
	iteZrtU1Sv9KiajVeX26oXNEaL7QZNWD7a53+wm4Gj4MUXoinHwz0fv7/U2BAZUdTIuOW3
	pDvv6Viy2/1Ye7K6rnzwe6PHZdRFmYdhvhYh37niOeVL2LxalJgM6sV71CWFhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745420501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWLbPEK5LvxBlDZi/5mdWIWYYff5AO7fk+5OpUiSiZU=;
	b=H9Ed+i7pqlTJ2LhJMINn2JxdAy0H16Gvi0ejMS23Fs4XzX4BKR4oOTwrfutTExRyS2OppQ
	yCj99Su1RhUFECBQ==
Date: Wed, 23 Apr 2025 17:01:34 +0200
Subject: [PATCH 04/15] tools/nolibc: add mremap()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-nolibc-misc-v1-4-a925bf40297b@linutronix.de>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
In-Reply-To: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745420497; l=2662;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=jBXf5Mtp9KvxjCbpxdmGGb3Wzx4EvSPLG4sESOoybeQ=;
 b=GXyXOFUZo3z60zm1V1Zq5wlUG8H2zppRlAY55njuNEIeJpeEVus5VyN8+cNfz99tr9bLO1mHJ
 ojmTCKeAYjgBXMEgRYVQYk9SLnp0w2vgFjNTT+ymDXkh9+y5Q/zIOO6
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/sys/mman.h              | 19 +++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 14 +++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/include/nolibc/sys/mman.h b/tools/include/nolibc/sys/mman.h
index ad9d06b6b7919ec76a0652266158366cf639a77a..d1c213c19d7fa55c9db3a9527dd35b6072ca9485 100644
--- a/tools/include/nolibc/sys/mman.h
+++ b/tools/include/nolibc/sys/mman.h
@@ -45,6 +45,25 @@ void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
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


