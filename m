Return-Path: <linux-kselftest+bounces-34647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CF6AD4D28
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C99188552A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD23236429;
	Wed, 11 Jun 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TOtBh2KU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dcdGNp35"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DF223183C;
	Wed, 11 Jun 2025 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627516; cv=none; b=c3Zb8VhYWwf9d+Tkq08jGu4aU0yAa6kTuPZ6v5wNlmH1sN4RcKoBKnMtPWcIjo7AwkL5cKCt/JjOjD2IQNwWle41qOQvr1VoBPpB0LPDqhNHRNegWmXiFG/wH3eNguYmjb3CM8z1uY4TQpN572XKWOTakAMvbkvAtB2Xywrpef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627516; c=relaxed/simple;
	bh=JA+lgR6jDYP95l8ivl1hKVe2RNOg9XU9LTMBTUtdWi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=utVfPCwIoMxsPt66AUBFGpYZQC1CXxEwHjsWt9njX/GE/dupm6c4fqzSazDi36230bO6XIcTy6Tv3yQzMvKsaAVO5/qDsS8oeuRE633E/WL+hJZNakrMkql8JITvSPPfBWWwXknqjfoU025yhHGHxHKs/Ux/D00Hvm1ZMrd+4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TOtBh2KU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dcdGNp35; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749627512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1E+pxdC7XCvBOJZ8pPzaFk5ypsAf/K5wNQ3KeFLn+F8=;
	b=TOtBh2KUnuVUS85lSgOHCG1Fg+t5UqkQ41US1tcjvzvyS8oPdeMPXvCrknrP7INKLsI28G
	6SFNHskWUP+eJ0riYZXKK1OoxxOpdvghQ6uyWNteogP/1acmivFX6mmYejNvlr3ZFwahxp
	EeZMlXXc6pJ/HY1ypPO/UAWII9PEoz1ULxHccGKw4W6CVAoObU6vDDLvvxLwThuc2pQpjs
	/JJ5pmAPBMrA/5E+F2gZtsDaosx4JfSPa63nd9W/VpPluNsAqRAO63m26iaZ+wC2dC7kJ1
	iFlAf+LkhTcbxMa2M2gPR+7kewxvUUF081sAB0Dd+hrJbUDoB0TLsl7Oa3KAFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749627512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1E+pxdC7XCvBOJZ8pPzaFk5ypsAf/K5wNQ3KeFLn+F8=;
	b=dcdGNp35cwbN5l5enyvrw6QqtNl8z0RMXdG6AeX+mek+y58WZuuaxlr1/igfQ65QB18v2D
	fiADWYTRb3Csz1BQ==
Date: Wed, 11 Jun 2025 09:38:10 +0200
Subject: [PATCH v3 04/16] kbuild: userprogs: add nolibc support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-kselftests-v3-4-55e3d148cbc6@linutronix.de>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749627510; l=3395;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=JA+lgR6jDYP95l8ivl1hKVe2RNOg9XU9LTMBTUtdWi0=;
 b=sshp51ZicOppr5xNE4J5XSfIA6Ho2MK+qJPaO4m7xgV0guqxem23z+NRO9Fn1L/NBaCPXM/F4
 irTj9CDLvh+AcNB81yPzcohfGaEWOImNfEmzL/uyKt+d0bHjfhF15sx
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Userprogs are built with the regular kernel compiler $CC.
A kernel compiler does not necessarily contain a libc which is required
for a normal userspace application.
However the kernel tree does contain a minimal libc implementation
"nolibc" which can be used to build userspace applications.

Introduce support to build userprogs against nolibc instead of the
default libc of the compiler, which may not exist.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
This could probably be moved out of the generic kbuild makefiles.
I think the ergonimics would suffer and this functionality could be
used by other users of userprogs.

Also this does currently not support out-of-tree builds.
For that tools/include/nolibc/*.h and usr/include/*.h would need to be
installed into the build directory.
---
 Documentation/kbuild/makefiles.rst | 13 +++++++++++++
 scripts/Makefile.userprogs         | 13 ++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 8aef3650c1f32b6b197e0dc777e26775d371a081..4cc7a1b89f1803857a4723284613111e9ad71d92 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -974,6 +974,19 @@ When linking bpfilter_umh, it will be passed the extra option -static.
 
 From command line, :ref:`USERCFLAGS and USERLDFLAGS <userkbuildflags>` will also be used.
 
+Building userprogs against nolibc
+---------------------------------
+
+Not all kernel toolchains provide a libc.
+Simple userprogs can be built against a very simple libc call "nolibc" provided
+by the kernel source tree.
+This requires ``CONFIG_HEADERS_INSTALL=y``.
+
+Example::
+
+  # lib/kunit/Makefile
+  uapi-preinit-nolibc := $(CONFIG_ARCH_HAS_NOLIBC)
+
 When userspace programs are actually built
 ------------------------------------------
 
diff --git a/scripts/Makefile.userprogs b/scripts/Makefile.userprogs
index f3a7e1ef3753b54303718fae97f4b3c9d4eac07c..b1633a9de6c86a023c70a717bac0b80b89d01431 100644
--- a/scripts/Makefile.userprogs
+++ b/scripts/Makefile.userprogs
@@ -16,10 +16,17 @@ user-csingle	:= $(addprefix $(obj)/, $(user-csingle))
 user-cmulti	:= $(addprefix $(obj)/, $(user-cmulti))
 user-cobjs	:= $(addprefix $(obj)/, $(user-cobjs))
 
+user_nolibc_ccflags := -nostdlib -nostdinc -static -fno-ident -fno-asynchronous-unwind-tables \
+		      -ffreestanding -fno-stack-protector \
+		      -isystem $(objtree)/usr/include -include $(srctree)/tools/include/nolibc/nolibc.h -isystem $(srctree)/tools/include/nolibc/
+user_nolibc_ldflags := -nostdlib -nostdinc -static
+
 user_ccflags	= -Wp,-MMD,$(depfile) $(KBUILD_USERCFLAGS) $(userccflags) \
-			$($(target-stem)-userccflags)
-user_ldflags	= $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-stem)-userldflags)
-user_ldlibs	= $(userldlibs) $($(target-stem)-userldlibs)
+			$($(target-stem)-userccflags) $(if $($(target-stem)-nolibc),$(user_nolibc_ccflags))
+user_ldflags	= $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-stem)-userldflags) \
+			$(if $($(target-stem)-nolibc),$(user_nolibc_ldflags))
+user_ldlibs	= $(userldlibs) $($(target-stem)-userldlibs) \
+			$(if $($(target-stem)-nolibc),$(user_nolibc_ldlibs))
 
 # Create an executable from a single .c file
 quiet_cmd_user_cc_c = CC [U]  $@

-- 
2.49.0


