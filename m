Return-Path: <linux-kselftest+bounces-26766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D009DA3812A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 12:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AAE1647FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 11:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8C2219EB8;
	Mon, 17 Feb 2025 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gLDHBea2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sq0417x/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC672218EA8;
	Mon, 17 Feb 2025 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790043; cv=none; b=h9cOrm7GmtNJ33pY3JF+scJX7U2ja074WXGLu7+7FqYg2hEGgXmmCVDQv2AV6jfOgOCPR1i62Jl3jm/hsXKIVurPHPpxxUn5q5vBUV9HNi3E9Qr0puymmkVPb5yrO960aEqu2DydlZTMs1dKfZ4SCHtpStBIZ3l80LS3vTStUY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790043; c=relaxed/simple;
	bh=CpCkmbMgLBYAXvposf48tXlYf7KsrlXSlYBVTNHhQME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T8xU5ylDVbwQ0oiyzxW6Rdxs1EMeKF7HB6RLH7ZskD52tJG8U6RxEuQmk0XEiXwH1QItheVutNvtWVoDLWxCgNdEU8G9qMWomddw+Q4WbxVKWaRCa+kMBmCYLDBmku6wbeCfen7mX/TBu06jxjKGCahtfMhV0B86BuO40bIJjO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gLDHBea2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sq0417x/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739790038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYMG4AG4faj0loSjPiu926YoV/r7OSKMUw1XHgOOtZk=;
	b=gLDHBea2ysl3TC+ewqGA5xFrhH9SipjP6LFwmwpbhRVKWHztb+eC91f7Ixn7S862nN3waP
	M8laN1Ofvc/VbK3MMeBphg2KmC4QrSmqnieQ2cnmDGWr5jLY38IANQGuUJux9op7ew0UUR
	XmFIk+tAkOC9EsUVe5bO0SJ3SDWOCvICe7PMNBcauz1TVRdcVYZpnUlv3AUPgPuvgVUOfe
	ptH1cvSoz3L54YnDRd0jQLdqlNeVIBWmzlBwY9p9vJr4H/IV7SfhRoi1lKjPtgPz0SIOdh
	v3/O4pcFD2Uge5DjfVVLZv4paOC1YlAF/s2/DjFZOxBj2sVS+Uny4UsEevyrig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739790038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYMG4AG4faj0loSjPiu926YoV/r7OSKMUw1XHgOOtZk=;
	b=sq0417x/xJvOEkI0o+EEixKYBcDtm6SUNU3ttvCc1Y3iwBhgTLnax9u7OmZEK39vqGH6nI
	UyPUGXaV0d24s0Bg==
Date: Mon, 17 Feb 2025 11:59:25 +0100
Subject: [PATCH 05/12] kbuild: introduce blob framework
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-kunit-kselftests-v1-5-42b4524c3b0a@linutronix.de>
References: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
In-Reply-To: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739790034; l=4689;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=CpCkmbMgLBYAXvposf48tXlYf7KsrlXSlYBVTNHhQME=;
 b=tlNTx5n5HmBXjGzUDgzCIRB0T2czuInanv8C4uglwv6pqewahSisRFz5CjKNPGiwZn4vsO6nr
 mx8gaXotG+5ASt4wWwvy32sQBcHwRifuEbvL9i9UJTmqvOsNDFZ/KK8
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Various subsystems embed non-code build artifacts into the kernel,
for example the initramfs, /proc/config.gz, vDSO image, etc.
Currently each user has their own implementation for that.

Add a common "blob" framework to provide this functionality.
It provides standard kbuild and C APIs to embed and later access non-code build
artifacts into the kernel image or modules.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
This is currently lacking a MAINTAINERS entry.
Due to its closeness to kbuild I would tend to add it there.
But I can also maintain it on its own.
---
 include/linux/blob.h   | 21 +++++++++++++++++++++
 scripts/Makefile.blobs | 19 +++++++++++++++++++
 scripts/Makefile.build |  6 ++++++
 scripts/Makefile.clean |  2 +-
 scripts/blob-wrap.c    | 27 +++++++++++++++++++++++++++
 5 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/include/linux/blob.h b/include/linux/blob.h
new file mode 100644
index 0000000000000000000000000000000000000000..5749c364f7e9c93eb32a6d8870621e3d6df0683c
--- /dev/null
+++ b/include/linux/blob.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_BLOB_H
+#define _LINUX_BLOB_H
+
+#include <linux/compiler_types.h>
+#include <linux/types.h>
+
+struct blob {
+	const char *const path;
+	const u8 *data;
+	const u8 __private *end;
+};
+
+#define DECLARE_BLOB(_symbol)	extern const struct blob _symbol
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
index 993708d1187459f3678d68ec81ef005e6f51d470..def9791523d718552617ef6ef752c1852d40d996 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -440,6 +440,12 @@ ifneq ($(need-dtbslist)$(dtb-y)$(dtb-)$(filter %.dtb %.dtb.o %.dtbo.o,$(targets)
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
index 0000000000000000000000000000000000000000..715d6981fa94bee309c693c2b937899c982e27b4
--- /dev/null
+++ b/scripts/blob-wrap.c
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/args.h>
+#include <linux/blob.h>
+#include <linux/stringify.h>
+
+#define BLOB_SYMBOL_DATA	CONCATENATE(_blob_data_, BLOB_SYMBOL)
+#define BLOB_SYMBOL_END		CONCATENATE(_blob_end_, BLOB_SYMBOL)
+
+asm (
+"	.pushsection .rodata, \"a\"			\n"
+"	.global " __stringify(BLOB_SYMBOL_DATA) "	\n"
+ __stringify(BLOB_SYMBOL_DATA) ":			\n"
+"	.incbin \"" __stringify(BLOB_INPUT) "\"		\n"
+"	.global " __stringify(BLOB_SYMBOL_END) "	\n"
+ __stringify(BLOB_SYMBOL_END) ":			\n"
+"	.popsection					\n"
+);
+
+extern const u8 BLOB_SYMBOL_DATA;
+extern const u8 BLOB_SYMBOL_END;
+
+const struct blob BLOB_SYMBOL = {
+	.path	= __stringify(BLOB_INPUT),
+	.data	= &BLOB_SYMBOL_DATA,
+	.end	= &BLOB_SYMBOL_END,
+};

-- 
2.48.1


