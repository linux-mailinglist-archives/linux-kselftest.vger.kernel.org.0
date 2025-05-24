Return-Path: <linux-kselftest+bounces-33736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6DFAC2FFA
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 16:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CAF1897D8D
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2907F1E0E0B;
	Sat, 24 May 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="Df2BckU2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EB41C5D53
	for <linux-kselftest@vger.kernel.org>; Sat, 24 May 2025 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748096521; cv=none; b=bDYmRowvJSuarZzL9+RkrwxjW/SHRzUjwea7pKhfyXMyU69vXvoCsxfvOh6Epv5exVcks6p9LkJq7Hfn+CXkJZ2SP1susXA0GQwyEkHacCdhnGarc6fVweRFYBenWw0TU8HfvKbDzBnyMoYbTyaPPBkP1q+oP4Whkg/Ij3a+rHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748096521; c=relaxed/simple;
	bh=sBfHEicx9n5nJB33h/MlpbBvlmIc4NurM37vg1qxBkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HAu6a56RHPsSJXINTNYTTlkBbFNAS88c2UJ/ddnI7jDMNUiYer/7d51aUTgazzuqzrmEqpTDQJjjtYE3ryG2gJFvyQEdqLJXjR5cgayMJbR6t1udqGHjiOFQq7667LK5pbBW8u0JVMJDbHDt2dbZbh8kPVlMeqezzzUqlasG1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=Df2BckU2; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4b4PNg3f14z9spb;
	Sat, 24 May 2025 16:21:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1748096515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hvg3N2ieMC5PgAeoIMzegr5VQt81jWXcWZQ+/jHGu9E=;
	b=Df2BckU23auawHHISBuwPbH4HphFdIGw+4g3UL9jnVczwOcQW9IXgcUKvMUkiHSLMAtoi6
	qUBbYwhdWYsG+KRNksSaBD7xszvHj1Lc5nvUZaS8hDu11kpmZwRNqnrPoAtMdJ1P3aLy0Y
	ht7NU5DPe66NMe4SBNl8mnJfG1M4ZyhTJaApF1LhnnhfLloBXyNUKJA8EQSmSHoWc6fVvQ
	Q/1YINJjj5T/4xPqjlQ1Xm+I4kYcY19SpWsY9CMzd1mWXuGxqzQgmOWNKFqXotK6xcAd/S
	OHWhhWkrPQRylz0e5MyjivL9utGJmX6Xe4r30HDnaOyHaR0xI7cR9iVldOjvMw==
From: Brahmajit Das <listout@listout.xyz>
To: linux-kernel-mentees@lists.linux.dev
Cc: linux-kselftest@vger.kernel.org,
	brauner@kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH 1/1] testing/mount_setattr: fix redefinition of sys_open_tree
Date: Sat, 24 May 2025 19:51:45 +0530
Message-ID: <20250524142145.18558-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4b4PNg3f14z9spb

sys_open_tree is once defined in filesystems/overlayfs/wrappers.h so
before we define it in mount_setattr_test.c we should check if has been
previously defined or not. Otherwise it results in the following build
error:

make[1]: Nothing to be done for 'all'.
  CC       mount_setattr_test
mount_setattr_test.c:176:19: error: redefinition of ‘sys_open_tree’
  176 | static inline int sys_open_tree(int dfd, const char *filename, unsigned int flags)
      |                   ^~~~~~~~~~~~~
In file included from mount_setattr_test.c:23:
../filesystems/overlayfs/wrappers.h:59:19: note: previous definition of
		‘sys_open_tree’ with type ‘int(int,  const char *, unsigned int)’
   59 | static inline int sys_open_tree(int dfd, const char *filename, unsigned int flags)
      |                   ^~~~~~~~~~~~~
make[1]: *** [../lib.mk:222: /home/listout/linux/tools/testing/selftests/mount_setattr/mount_setattr_test]
		Error 1

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 48a000cabc97..b0798777b822 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -173,10 +173,13 @@ static inline int sys_mount_setattr(int dfd, const char *path, unsigned int flag
 #define AT_RECURSIVE 0x8000 /* Apply to the entire subtree */
 #endif
 
+/* Do not define sys_open_tree if it's already defined in overlayfs/wrappers.h */
+#if !defined(__SELFTEST_OVERLAYFS_WRAPPERS_H__)
 static inline int sys_open_tree(int dfd, const char *filename, unsigned int flags)
 {
 	return syscall(__NR_open_tree, dfd, filename, flags);
 }
+#endif
 
 static ssize_t write_nointr(int fd, const void *buf, size_t count)
 {
-- 
2.49.0


