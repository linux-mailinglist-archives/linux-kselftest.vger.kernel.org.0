Return-Path: <linux-kselftest+bounces-30225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC17A7D675
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 09:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CB9166E6D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D6D227E9E;
	Mon,  7 Apr 2025 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lwR6wPAy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LsFfLANA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E2D225A22;
	Mon,  7 Apr 2025 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011783; cv=none; b=i6bwKKwEg9yBg9JnJUy8Hk+LGEUSXvRudR8CrFafpMiLKG1BT6MX5aEVuA9yYsz8xYzT+OIq1lIVX/W3mk2HCv2kVaGuflPPLjKX3q2tjyEWIO71wZRN4McY5oVg4/W8J+MQYga1tS0gfqoU/AZyzyyVeXX3QpwwG4GFGgAaBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011783; c=relaxed/simple;
	bh=wigAJUFJ+V9EVhNSp3BPVdxWuuiUQqmtFd9VHobAqVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XHWHJtyOk3B7yiI2ownPyyrA7HH+B2wzVOP35rqEp5EGYSulHUB154o1V3xLmT1fnLsDWr4xqxL80sLdeexdRbgvuo9f3FwQxgxMAYJGPU/2rJG5nBH9IH6EzpOPYfU1PT8tZfN6bNNLWAl706fyFQs4VLQQeDzVFnIsnC9qQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lwR6wPAy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LsFfLANA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744011779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61AaDAxKbOLaApOgc6P6k2wgx7ZZhb7JXrh4epva6Ak=;
	b=lwR6wPAyMCnoqtHBjbQX509ibXuppvAPHqwU3w3/XR9MoYll9WTLRMizfjkKewVvYbBLfV
	4w9HT11cMOn9Q/Y1tjmkZMWEGddaWeCFxF34PxnI1bFj/7nAtYu9OjWFVnLQBNzpinWwWW
	/FNISO6VZ0loic3wpQfH2IYVv81xAz7E4sMOGpDKAtLAoIm/LlnUeCfWQ1WPX5LDA3+zQl
	WUfuiLCLBi/NUMU9j1Dv8Mpg4enZLstU7tVvWCdbSp0mH2AgzEbw7pNN0OHcIeadql+1vW
	YTP1zRP3ioOm4zQVGTzd8pW09Fk1GH6JVfWLMc85UPpizFe47ZS2QVOXt3F9hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744011779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61AaDAxKbOLaApOgc6P6k2wgx7ZZhb7JXrh4epva6Ak=;
	b=LsFfLANAiIa1ulCK7XvzhNo/OdTnoA9OhV288y1h/5g3b4SMu0mRTYZ1NGptK77eazmFdc
	dXPWMqElO1QzWXBQ==
Date: Mon, 07 Apr 2025 09:42:41 +0200
Subject: [PATCH v2 04/11] kbuild: introduce blob framework
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-kunit-kselftests-v2-4-454114e287fd@linutronix.de>
References: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
In-Reply-To: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744011776; l=7377;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=wigAJUFJ+V9EVhNSp3BPVdxWuuiUQqmtFd9VHobAqVk=;
 b=W53cr/hBF4jP2PzCvJZgWJY4oQ5TqlaFkaGw7u+jGR9Cu1DPovyqhYzOJHDMXsTKszIKeqJdw
 lddPRiKmgI7DjR/GRuD7iv70BRo3E27/64A0GXV+m/B2dQF1WktVfb/
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Various subsystems embed non-code build artifacts into the kernel,
for example the initramfs, /proc/config.gz, vDSO image, etc.
Currently each user has their own implementation for that.

Add a common "blob" framework to provide this functionality.
It provides standard kbuild and C APIs to embed and later access non-code
build artifacts into the kernel image or modules.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
Due to its closeness to kbuild this is currently added to its MAINTAINER entry.
But I can also maintain it on its own.
---
 Documentation/kbuild/makefiles.rst | 23 +++++++++++++++++++++--
 MAINTAINERS                        |  2 ++
 include/linux/blob.h               | 32 ++++++++++++++++++++++++++++++++
 scripts/Makefile.blobs             | 19 +++++++++++++++++++
 scripts/Makefile.build             |  6 ++++++
 scripts/Makefile.clean             |  2 +-
 scripts/blob-wrap.c                | 27 +++++++++++++++++++++++++++
 7 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index d5cd73820e406276ee2e3721e265e3ed3cc299c9..c3a165fcb1ab0bbc090fd61c38ebd78317c7aa85 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -521,8 +521,8 @@ otherwise the command line check will fail, and the target will
 always be built.
 
 If the target is already listed in the recognized syntax such as
-obj-y/m, lib-y/m, extra-y/m, always-y/m, hostprogs, userprogs, Kbuild
-automatically adds it to $(targets). Otherwise, the target must be
+obj-y/m, lib-y/m, extra-y/m, always-y/m, hostprogs, userprogs, blobs,
+Kbuild automatically adds it to $(targets). Otherwise, the target must be
 explicitly added to $(targets).
 
 Assignments to $(targets) are without $(obj)/ prefix. if_changed may be
@@ -1014,6 +1014,25 @@ There are two ways to do this.
     This will tell Kbuild to build binderfs_example when it visits this
     Makefile.
 
+.. _kbuild_blobs:
+
+Blob framework
+==============
+
+Kbuild supports wrapping source or generated files into object files which are linked
+into the kernel and then accessed at runtime through ``include/linux/blob.h``.
+
+Example::
+
+  obj-m := some-module.o
+  userprogs := some-userprog
+  blobs := some-userprog.blob.o
+  some-userprog.blob-symbol := some_userprog
+  some-module-y += some-userprog.blob.o
+
+Kbuild will build the :ref:`userprog <kbuild_userprogs>` ``some-userprog`` and
+link it into ``some-module`` from where it can be accessed as ``BLOB(some_userprog)``.
+
 Kbuild clean infrastructure
 ===========================
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 96b82704950184bd71623ff41fc4df31e4c7fe87..d61e28e289c7027c026a872cd166342a4761b2a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12847,11 +12847,13 @@ Q:	https://patchwork.kernel.org/project/linux-kbuild/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 F:	Documentation/kbuild/
 F:	Makefile
+F:	include/linux/blob.h
 F:	scripts/*vmlinux*
 F:	scripts/Kbuild*
 F:	scripts/Makefile*
 F:	scripts/bash-completion/
 F:	scripts/basic/
+F:	scripts/blob-wrap.c
 F:	scripts/clang-tools/
 F:	scripts/dummy-tools/
 F:	scripts/include/
diff --git a/include/linux/blob.h b/include/linux/blob.h
new file mode 100644
index 0000000000000000000000000000000000000000..de76cdb76cbab388b62f574b80fb13a4c84d1d2d
--- /dev/null
+++ b/include/linux/blob.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linkable blob API.
+ *
+ * Copyright (C) 2025, Linutronix GmbH.
+ * Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ */
+
+#ifndef _LINUX_BLOB_H
+#define _LINUX_BLOB_H
+
+#include <linux/args.h>
+#include <linux/compiler_types.h>
+#include <linux/types.h>
+
+struct blob {
+	const char *const path;
+	const u8 *data;
+	const u8 __private *end;
+};
+
+#define BLOB(_symbol)	({					\
+	extern const struct blob CONCATENATE(__blob_, _symbol);	\
+	&CONCATENATE(__blob_, _symbol);				\
+})
+
+static inline size_t blob_size(const struct blob *blob)
+{
+	return ACCESS_PRIVATE(blob, end) - blob->data;
+}
+
+#endif /* _LINUX_BLOB_H */
diff --git a/scripts/Makefile.blobs b/scripts/Makefile.blobs
new file mode 100644
index 0000000000000000000000000000000000000000..fd20ebb41c1d6509750debf7896a08a143d28759
--- /dev/null
+++ b/scripts/Makefile.blobs
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Build linkable blobs
+#
+
+blobs	:= $(addprefix $(obj)/, $(blobs))
+
+blob-stem = $(subst -,_,$(subst .blob,,$(basename $(patsubst $(obj)/%,%,$@))))
+blob-symbol = $(or $($(target-stem)-symbol),$(blob-stem))
+
+blob-flags = -DBLOB_SYMBOL="$(blob-symbol)" -DBLOB_INPUT=$<
+
+quiet_cmd_blob = BLOB    $@
+      cmd_blob = $(CC) $(c_flags) $(blob-flags) -c -o $@ $(srctree)/scripts/blob-wrap.c
+
+$(blobs): $(obj)/%.blob.o: $(obj)/% $(srctree)/scripts/blob-wrap.c FORCE
+	$(call if_changed_dep,blob)
+
+targets += $(blobs)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 13dcd86e74ca830ce3fb2587df7f200105490881..c2965ee4002d239bf4e18115e026e7bcd5abb197 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -436,6 +436,12 @@ ifneq ($(need-dtbslist)$(dtb-y)$(dtb-)$(filter %.dtb %.dtb.o %.dtbo.o,$(targets)
 include $(srctree)/scripts/Makefile.dtbs
 endif
 
+# $(sort ...) is used here to remove duplicated words and excessive spaces.
+blobs := $(sort $(blobs))
+ifneq ($(blobs),)
+include $(srctree)/scripts/Makefile.blobs
+endif
+
 # Build
 # ---------------------------------------------------------------------------
 
diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
index 6ead00ec7313b3e4330a8de5f1342f2da1d6eb84..536972b0a528d117e17296da9936825c3903af6e 100644
--- a/scripts/Makefile.clean
+++ b/scripts/Makefile.clean
@@ -25,7 +25,7 @@ subdir-ymn	:= $(addprefix $(obj)/,$(subdir-ymn))
 # directory
 
 __clean-files	:= \
-	$(clean-files) $(targets) $(hostprogs) $(userprogs) \
+	$(clean-files) $(targets) $(hostprogs) $(userprogs) $(blobs) \
 	$(extra-y) $(extra-m) $(extra-) \
 	$(always-y) $(always-m) $(always-) \
 	$(hostprogs-always-y) $(hostprogs-always-m) $(hostprogs-always-) \
diff --git a/scripts/blob-wrap.c b/scripts/blob-wrap.c
new file mode 100644
index 0000000000000000000000000000000000000000..82ab3bc641bd69ec35029c2f4a9dd6d6c6720a02
--- /dev/null
+++ b/scripts/blob-wrap.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/args.h>
+#include <linux/blob.h>
+#include <linux/stringify.h>
+
+#define BLOB_SYMBOL_DATA	CONCATENATE(__blob_data_, BLOB_SYMBOL)
+#define BLOB_SYMBOL_END		CONCATENATE(__blob_end_, BLOB_SYMBOL)
+
+asm (
+"	.pushsection .rodata, \"a\"\n"
+"	.global " __stringify(BLOB_SYMBOL_DATA) "\n"
+__stringify(BLOB_SYMBOL_DATA) ":\n"
+"	.incbin \"" __stringify(BLOB_INPUT) "\"\n"
+"	.global " __stringify(BLOB_SYMBOL_END) "\n"
+__stringify(BLOB_SYMBOL_END) ":\n"
+"	.popsection\n"
+);
+
+extern const u8 BLOB_SYMBOL_DATA;
+extern const u8 BLOB_SYMBOL_END;
+
+const struct blob CONCATENATE(__blob_, BLOB_SYMBOL) = {
+	.path	= __stringify(BLOB_INPUT),
+	.data	= &BLOB_SYMBOL_DATA,
+	.end	= &BLOB_SYMBOL_END,
+};

-- 
2.49.0


