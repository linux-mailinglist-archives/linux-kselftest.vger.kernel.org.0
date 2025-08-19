Return-Path: <linux-kselftest+bounces-39306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F49CB2C3E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 14:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F62A00B88
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 12:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C069338F23;
	Tue, 19 Aug 2025 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEKzZxdQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B432275C
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606820; cv=none; b=Ex0ZCsPzH1067RUvhTa7okpgbryFgWFLNcOL+YYmLwd0rdF6Y1YYD1oEIy8ZUYkFvnS9FXbxLrUtZmF+0+IH/9Z0kB3JXekIOQRcMhWiIxnsAOSY9G4aV2PaLcbf2HSdw5xS+VFxur86iLnX2jfB4qIgEwxZDc64HKe+Sakllag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606820; c=relaxed/simple;
	bh=RNlgMc8ApZnqgsjPYglVWYGwKiK6+wsvkBg07eJDOBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1s84QTt2O9/bWCRYDe/AXjWzR+DisRlQ7h0tcVro/AgulcL0FkzU3J1khyIwsT5ek/YcOHXaxWZ5cPj9g8f5g8rR4sSLmWZovWDcTxUpA5ppcc1txD9X2MmFUQ0SovooDUJhoUOOflrAetBXwo2+xFj/bwOSVGE5vLxiTyTBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEKzZxdQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4717543ed9so3539665a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755606817; x=1756211617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1NTraUDhkyJj/nkQEAY36vAk9FsJbBrZQ6MRp6OEOMw=;
        b=XEKzZxdQjFDVp0W9U+aay6KWbxlZzwtEtgcT9HZIYA4vCCi6+49LtgQ0sjk+dfFREQ
         DeufPOc3RK0iZb8PrxAamQcyfTUA9bzDMtQm0APO5Fvgg9dkm8rKrMBT6N7HLYjg57wi
         4k5iWWr2cq8fIk9o/CbVKmLHdb6NB3bI9LN2nJxUFwgLYyXelrFcbWQU3h4gMxexJ46x
         knDwUiNd11r2PYI1g9F0lngQcT4BQy7DN+DnxHDwqe8ZRmhg1A2NOG84xe45t11vm+e4
         McvXVTJ//NLbK2cWQmtGKY+S3ebb/ilvSfSwRifsIMXNY+GcvkmOOgxTGwbCShHnS9TB
         us8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606817; x=1756211617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NTraUDhkyJj/nkQEAY36vAk9FsJbBrZQ6MRp6OEOMw=;
        b=t3LJkLUxxAVpvtnokSn0I9lYhHAoWuvgkc4dlonlPUeSCBANbRu5GxmPrt89Z/ICEa
         aOi3u/ZN9oHwUAE+z6bHvDnq/RsWDImI1UVVDv6x7W8W3HqRMEPUMnz1vqjO3E7IZ2vL
         ckzwnblN8RThnKjGRIKXPE05sUeRNYroJcCSxV04BfjzeMxtVM1kEJtU2AVCmdbGdxte
         OJv8cTMMgDBS9yQXNl8rWdmJbCc7iuW785JFZHPKsC2bU8UHaEm6Vrjwf/uMIDqN4Vhq
         Gq9NoMy5yvXrcTscwuatBFdZ1IgbHZ8jkOp4VCdwgmMP+pQmXLlOZLjjKvvNE0apUEXU
         62Tw==
X-Gm-Message-State: AOJu0YxsSElU98egMi8C/GHkADwd4kDRDDCdKhemx6h4fNGduu2UPXtm
	S+As7XKFGUZIFwG6OWy8HbKMjK2KGn3+cbwaLbrWCxJl0cjjy7c4+ZE0AvnTM1LlkDg=
X-Gm-Gg: ASbGncsnCdH+i/lCeuDaA/02RYpNS8/0UQB5xmFc1s9Wv1OkpR+DtfOQdvlOZK2h2KY
	WwUqqwBEOhfOsVmyItbWMIGC1FrpRfyiNOpcCpaGlKO77bGI7ym2MU1AV9fScviTp0CcoCdgcua
	PVvgvMrq5Tp8VRQjIOURL+MI3JYDLKCDIZ1+9idU0haVx9KHMeKN1STEzIh42vV+aMFLzR49ayz
	eKUFOX7qxQEY83M+Hu4eIDmKXU8eDJqsDVkWNYFW+q4I39DcqVHPI6a+CuB0FBi+SQxJDcxj4J5
	1xBAYd5NUq5yZjGL/0SvSADEd/2zmeiPQ2Tyxcfd7U7WlDE7jso2oS6ce0fR46+jqJmmoqavhVM
	iW1XRmz9R4c2MQ07mDt2i/p3m+nkQqeY=
X-Google-Smtp-Source: AGHT+IEXaqcZCFwVyWzf3fBFdyAYI0sebebias2NvND61h1LRj8yB2jNSmL/MraH8e8UtRwT+WiV6A==
X-Received: by 2002:a17:902:ce81:b0:234:d431:ec6e with SMTP id d9443c01a7336-245e04346e4mr25629865ad.3.1755606816970;
        Tue, 19 Aug 2025 05:33:36 -0700 (PDT)
Received: from lkmp.. ([157.51.92.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9ef6dsm108012945ad.10.2025.08.19.05.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:33:36 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au,
	skhan@linuxfoundation.org,
	maddy@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	npiggin@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	rakuram.e96@gmail.com
Subject: [PATCH] selftests/powerpc: fix typos in tm
Date: Tue, 19 Aug 2025 18:03:24 +0530
Message-ID: <20250819123326.7025-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed multiple typos in powerpc/tm reported by Codespell

Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
---
 tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c | 2 +-
 tools/testing/selftests/powerpc/tm/tm-signal-stack.c    | 4 ++--
 tools/testing/selftests/powerpc/tm/tm-sigreturn.c       | 2 +-
 tools/testing/selftests/powerpc/tm/tm-tar.c             | 2 +-
 tools/testing/selftests/powerpc/tm/tm-tmspr.c           | 2 +-
 tools/testing/selftests/powerpc/tm/tm-trap.c            | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c b/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
index 4a61e9bd12b4..8aee18819603 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
@@ -42,7 +42,7 @@ void signal_usr1(int signum, siginfo_t *info, void *uc)
 #else
 	ucp->uc_mcontext.uc_regs->gregs[PT_MSR] |= (7ULL);
 #endif
-	/* Should segv on return becuase of invalid context */
+	/* Should segv on return because of invalid context */
 	segv_expected = 1;
 }
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-stack.c b/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
index 68807aac8dd3..e793b5d97c48 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
@@ -2,7 +2,7 @@
 /*
  * Copyright 2015, Michael Neuling, IBM Corp.
  *
- * Test the kernel's signal delievery code to ensure that we don't
+ * Test the kernel's signal delivery code to ensure that we don't
  * trelaim twice in the kernel signal delivery code.  This can happen
  * if we trigger a signal when in a transaction and the stack pointer
  * is bogus.
@@ -52,7 +52,7 @@ int tm_signal_stack()
 
 	/*
 	 * The flow here is:
-	 * 1) register a signal handler (so signal delievery occurs)
+	 * 1) register a signal handler (so signal delivery occurs)
 	 * 2) make stack pointer (r1) = NULL
 	 * 3) start transaction
 	 * 4) cause segv
diff --git a/tools/testing/selftests/powerpc/tm/tm-sigreturn.c b/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
index ffe4e5515f33..4dfb25409393 100644
--- a/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
+++ b/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
@@ -5,7 +5,7 @@
  *
  * Test the kernel's signal returning code to check reclaim is done if the
  * sigreturn() is called while in a transaction (suspended since active is
- * already dropped trough the system call path).
+ * already dropped through the system call path).
  *
  * The kernel must discard the transaction when entering sigreturn, since
  * restoring the potential TM SPRS from the signal frame is requiring to not be
diff --git a/tools/testing/selftests/powerpc/tm/tm-tar.c b/tools/testing/selftests/powerpc/tm/tm-tar.c
index f2a9137f3c1e..ea420caa3961 100644
--- a/tools/testing/selftests/powerpc/tm/tm-tar.c
+++ b/tools/testing/selftests/powerpc/tm/tm-tar.c
@@ -50,7 +50,7 @@ int test_tar(void)
 			"bne	2b;"
 			"tend.;"
 
-			/* Transaction sucess! TAR should be 3 */
+			/* Transaction success! TAR should be 3 */
 			"mfspr  7, %[tar];"
 			"ori	%[res], 7, 4;"  // res = 3|4 = 7
 			"b	4f;"
diff --git a/tools/testing/selftests/powerpc/tm/tm-tmspr.c b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
index dd5ddffa28b7..e2c3ae7c9035 100644
--- a/tools/testing/selftests/powerpc/tm/tm-tmspr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
@@ -9,7 +9,7 @@
  * - TFIAR  - stores address of location of transaction failure
  * - TFHAR  - stores address of software failure handler (if transaction
  *   fails)
- * - TEXASR - lots of info about the transacion(s)
+ * - TEXASR - lots of info about the transaction(s)
  *
  * (1) create more threads than cpus
  * (2) in each thread:
diff --git a/tools/testing/selftests/powerpc/tm/tm-trap.c b/tools/testing/selftests/powerpc/tm/tm-trap.c
index 97cb74768e30..99acb7c78403 100644
--- a/tools/testing/selftests/powerpc/tm/tm-trap.c
+++ b/tools/testing/selftests/powerpc/tm/tm-trap.c
@@ -91,9 +91,9 @@ void trap_signal_handler(int signo, siginfo_t *si, void *uc)
 			 * LE endianness does in effect nothing, instruction (2)
 			 * is then executed again as 'trap', generating a second
 			 * trap event (note that in that case 'trap' is caught
-			 * not in transacional mode). On te other hand, if after
+			 * not in transactional mode). On the other hand, if after
 			 * the return from the signal handler the endianness in-
-			 * advertently flipped, instruction (1) is tread as a
+			 * advertently flipped, instruction (1) is thread as a
 			 * branch instruction, i.e. b .+8, hence instruction (3)
 			 * and (4) are executed (tbegin.; trap;) and we get sim-
 			 * ilaly on the trap signal handler, but now in TM mode.
-- 
2.43.0


