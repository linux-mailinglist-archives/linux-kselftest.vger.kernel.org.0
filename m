Return-Path: <linux-kselftest+bounces-8174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60CC8A6FB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3D11F222C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E58130A65;
	Tue, 16 Apr 2024 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BTfJMlxr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E91130498;
	Tue, 16 Apr 2024 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280999; cv=none; b=nKkSIlvQ92+sx/KHM2az7E9YmRDamf+SdRsYlhN5BCsfiiA3YpKSQnFuHMiAv25KAmnly2X4FJEDAJEEtvOhxXqBAlg90fA0SwFuaST0RnonoQLTTrDOOKD5uNh4vSw+ZrjVKKy2vrJxKeELPLzyTU0LocKyLBv6O920X92qdPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280999; c=relaxed/simple;
	bh=bLU73jHksihFb5Kkaq6O4l8bW9c2Gyah+VFZw8edoJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eDa2Imw90zqM0xP8+Q6h6Ev26Z3W7+FNj6qstV163L21lbmNsTeeM8I+llyAui1k1KxqIMsRsSD4XYHOMxFRnYGLeuIVFO0f/hd/U1e9uy6qd9dnCoYgamaZhV2mFxCYHAgtdkkylSsoWjMHi8YvD/BNpq//y3Foq+KCM7R2twg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BTfJMlxr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713280996;
	bh=bLU73jHksihFb5Kkaq6O4l8bW9c2Gyah+VFZw8edoJs=;
	h=From:To:Cc:Subject:Date:From;
	b=BTfJMlxrRUDfa89Wuw0pdzkeWXI73KDxPeb0+H0wN5gDq9ooJz7F6f3QNHmFQuZai
	 2n1++yqBqRg95Xpi2EZcdFrPnWpKNLmSYBQ/62l3V7fgXZ6uILFDXJt8pG9A3vO7yX
	 NXd3iasStbJAfwIn0vlx3uNQQ7u8EGDEEbdmN9rOPuYVVs22KSVUEkw9K2gUAhaumr
	 SGULr/XhBI2hFFaedtgljvNBEKBQ3kc5dbMLfgCkb3MSxE04EoykkQKsOQzNGaUnPh
	 DqQNnRVau+C72nJcOViHK4pXv+LgdJa+Qk+ifgG5wN2D7t+OqTwlMnhsfqZYeEAupK
	 0+hs2EjeWWGlg==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6248F37804B2;
	Tue, 16 Apr 2024 15:23:12 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] selftests: exec: make binaries position independent
Date: Tue, 16 Apr 2024 20:23:39 +0500
Message-Id: <20240416152341.3186853-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The -static overrides the -pie and binaries aren't position independent
anymore. Use -static-pie instead which would produce a static and
position independent binary. This has been caught by clang's warnings:

  clang: warning: argument unused during compilation: '-pie'
  [-Wunused-command-line-argument]

Tested with both gcc and clang after this change.

Fixes: 4d1cd3b2c5c1 ("tools/testing/selftests/exec: fix link error")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/exec/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index fb4472ddffd81..01940d9165d67 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS = -Wall
+CFLAGS = -Wall #-Wunused-command-line-argument
 CFLAGS += -Wno-nonnull
 CFLAGS += -D_GNU_SOURCE
 
@@ -29,8 +29,8 @@ $(OUTPUT)/execveat.denatured: $(OUTPUT)/execveat
 	cp $< $@
 	chmod -x $@
 $(OUTPUT)/load_address_4096: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000 -pie -static $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000 -static-pie $< -o $@
 $(OUTPUT)/load_address_2097152: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x200000 -pie -static $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x200000 -static-pie $< -o $@
 $(OUTPUT)/load_address_16777216: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000000 -pie -static $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000000 -static-pie $< -o $@
-- 
2.39.2


