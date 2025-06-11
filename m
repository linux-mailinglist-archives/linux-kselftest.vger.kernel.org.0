Return-Path: <linux-kselftest+bounces-34651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F42EAD4D3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3306C1BC1E6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE37E23BD1B;
	Wed, 11 Jun 2025 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oTMf50hh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eyt1KjCL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DEF23645F;
	Wed, 11 Jun 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627518; cv=none; b=ZGckYIdoITOTe5GXpoIhyRf0lcGf4cZo2/Chgm4PGCBeikhOa/5Vsl2q8TITPxOXFs0G9Wc3o8tC4bQQSzJMvCpAnnkwulCBog99k8DJ9bJON/CxOxbJWGy2hmu3tXQJt4HHLwqnt8S4X5EBCqPhwEgaZbVGGxoWPwAwofUDSUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627518; c=relaxed/simple;
	bh=pD/oIF6vl9bmzEkj5ZAggKlVnatrMGsxFjGxCBob1vE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pYEcaYdUNTPZ3UnC9Tmsn6NPW4NS3cnRl7DfhWuNlCCVW157C2xSOkCnC+rOGuAVjUhGaXlu0unXRe7cWrsu6oruACyShqixeFIkJxupEOP3Y2OCPuVr8y9HzWC/645dipeEIa55qneGxe6vHvQnYhha2uzVpP9MuYR0Epr6BiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oTMf50hh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eyt1KjCL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749627514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hLESzJCjyRk9NgOKWsvqneN/Z/AUG3s6f3HWO22jmYQ=;
	b=oTMf50hhVcZvAq7cTFl2mfQ/H4rC+iKT77rmSwh9XM4lzT+iEYd+Iwslf1uxQ+S0+g8xW2
	2iweO6okLzO+oGrR8jwnfbkW3N5rEOKiuC4IWVtJEZL34pfSOTmfQNSBZ3sRxium/aN6ky
	G2W0oigiG4c2afXkqglMZ09onZcvyDT6vqUsAubrdys8DNRFbZ1GL4NOXg5Aed6hff/6+5
	pBcWCVqCsS9vd9n6SGQtlCseLG95HY/CegtQ6Em5vLCjEaElicn2rPAWqMYyS/iVbq5W6Z
	Iic/sKQWofH6ropkyg3u56CVQXVGdqonVn0u932jzrUwLdAAoarX9tMPjux4dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749627514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hLESzJCjyRk9NgOKWsvqneN/Z/AUG3s6f3HWO22jmYQ=;
	b=Eyt1KjCLG4nBEZrCwUCujpVH1Np3Ey9ikW6SJ/XQstAYueHJ9vwJj8AF04q6pcLn6gsdkE
	a/wdLSa1qB7TwWBg==
Date: Wed, 11 Jun 2025 09:38:13 +0200
Subject: [PATCH v3 07/16] kbuild: introduce blob framework
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-kselftests-v3-7-55e3d148cbc6@linutronix.de>
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
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Nicolas Schier <nicolas.schier@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749627510; l=7359;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=pD/oIF6vl9bmzEkj5ZAggKlVnatrMGsxFjGxCBob1vE=;
 b=okb47YtxatsIw23cWcUwSqe3GEUIdBFjMySlBe+F8PzQLJv/i65uwNeakG3GPik12BxsbwBTY
 l0bAQhPUq7yAGA3PuaiJ5HPWP9bGdsm/3aHZ0V6wue2TOqRI4F79SWJ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Various subsystems embed non-code build artifacts into the kernel,
for example the initramfs, /proc/config.gz, vDSO image, etc.
Currently each user has their own implementation for that.

Add a common "blob" framework to provide this functionality.
It provides standard kbuild and C APIs to embed and later access non-code
build artifacts into the kernel image or modules.

Reviewed-by: Nicolas Schier <n.schier@avm.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Due to its closeness to kbuild this is currently added to its MAINTAINER entry.
But I can also maintain it on its own.
---
 Documentation/kbuild/makefiles.rst | 23 +++++++++++++++++++++--
 MAINTAINERS                        |  2 ++
 include/linux/blob.h               | 31 +++++++++++++++++++++++++++++++
 scripts/Makefile.blobs             | 19 +++++++++++++++++++
 scripts/Makefile.build             |  6 ++++++
 scripts/Makefile.clean             |  2 +-
 scripts/blob-wrap.c                | 27 +++++++++++++++++++++++++++
 7 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 2adea36ac6ebf6c292e01a3e04c0b633e3c1b8ad..5d158780948ab6d7d21287231e310dc87d5e1dc7 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -525,8 +525,8 @@ otherwise the command line check will fail, and the target will
 always be built.
 
 If the target is already listed in the recognized syntax such as
-obj-y/m, lib-y/m, extra-y/m, always-y/m, hostprogs, userprogs, Kbuild
-automatically adds it to $(targets). Otherwise, the target must be
+obj-y/m, lib-y/m, extra-y/m, always-y/m, hostprogs, userprogs, blobs,
+Kbuild automatically adds it to $(targets). Otherwise, the target must be
 explicitly added to $(targets).
 
 Assignments to $(targets) are without $(obj)/ prefix. if_changed may be
@@ -1019,6 +1019,25 @@ There are two ways to do this.
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
index a92290fffa163f9fe8fe3f04bf66426f9a894409..435f8af750d40d859b48dd4f93f7991768f218e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13063,11 +13063,13 @@ Q:	https://patchwork.kernel.org/project/linux-kbuild/list/
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
index 0000000000000000000000000000000000000000..4104d04e036fadce220e05fd2d9b996323dd06e8
--- /dev/null
+++ b/include/linux/blob.h
@@ -0,0 +1,31 @@
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
+#include <linux/types.h>
+
+struct blob {
+	const char *const path;
+	const u8 *data;
+	const u8 *end;
+};
+
+#define BLOB(_symbol)	({					\
+	extern const struct blob CONCATENATE(__blob_, _symbol);	\
+	&CONCATENATE(__blob_, _symbol);				\
+})
+
+static inline size_t blob_size(const struct blob *blob)
+{
+	return blob->end - blob->data;
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
index a6461ea411f7a95a9dd156897bec43cb22ef1092..de000268a538875596aae597efaf06058474b17d 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -529,6 +529,12 @@ ifneq ($(need-dtbslist)$(dtb-y)$(dtb-)$(filter %.dtb %.dtb.o %.dtbo.o,$(targets)
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


