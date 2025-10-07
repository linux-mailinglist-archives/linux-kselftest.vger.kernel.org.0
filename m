Return-Path: <linux-kselftest+bounces-42809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBD7BC0192
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 05:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0ED3C3608
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 03:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30DB221D96;
	Tue,  7 Oct 2025 03:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="POuQW/Gp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD2D1D6DB6
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 03:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759807876; cv=none; b=lty5uOjXKrz9EgEOY2XNxnHo3oZ35MGxmQZBJyKDUV4pIEagu7Qad5lpidA8gObta1kLKY7aTprkVUgDFD3Ev3aE44Zwge7es9bXGLVPcLs2CyOMyCSH07cv1thtEIBuovU+yWTNytnRkmjdOZj8iaHvMZkl61h+VNoTXw8rWPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759807876; c=relaxed/simple;
	bh=Tfwqw8OEZOL2ezVx8JcOcQZ0zoAFvd3pQ2ktx/jzJV4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ze/4H2Uo9wwX8KAnRAvqW2wygNgLNP2tOpxPutCxSAUOTozh6y6aKzuA9YS6oC3trwgafqyUh7G/fUQcrIMSZ/iYctkS6YjF3BFkGarJakxIPldRWLDnFHr7iIGaH9UPUW/8/0TaAC2GOZKS6B9kO+qG3f0KF/+dYJQot1GiqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=POuQW/Gp; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54a80b26f88so2227843e0c.0
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Oct 2025 20:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759807874; x=1760412674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5YiQ5dlO7dBlobQ5XJDQPeGxLG7MsQM1BhS0aByLIw=;
        b=POuQW/GphTtx/g0bYDP7JsT5yiw4/p6PmhL9ELi6ZtJEm/EEIflHspws3y3Ig/j4LU
         tByGbVV9vhizVhGhrDzXbuofmZvH7qgyBZdvgxRtRiM8iBNj/HfoX7gOazkvHEa6bQ6d
         FLcWZk3jwpLA7mUM7o/1gjcQDcePHC0Ohp+15cdi0zYP49uF0BlI2veVFpBhZ2Pi6xhL
         zZ3Xb1Rx04/Fvx3nFqePZQt+1We8eVblgWQyNW67SqJRJD/vgnbFIE3CuleY9WYkLfkj
         6QJm+Uk9HBv/ZwzkV9vmColBSgyWASE2UCX+AxVn2OfVEB5ozwKXdiujI2tmtaQnY4Ov
         mKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759807874; x=1760412674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5YiQ5dlO7dBlobQ5XJDQPeGxLG7MsQM1BhS0aByLIw=;
        b=u33Ub5eh1R53HlLBBGerp0f3KkNMXOQ2BEXMsweWuE6Cjo0NHgxOcmnQvuOw91vmIu
         oEYwxHV+55qiPlsjw4dkS9Bd5O0/BENO6Qo1xJaLzHe4q9oypgzPAEqzNlGrvxF/qa4w
         MBUm/WIve9Se7w7CQSgz6EAaUrhCRV+RoKODEGER3RyT4TGbELfnXmYI2De29T4PGW7C
         lc24v2PeHE5quXuZKTsxRc9mPswXZPvSrKS6gp+cMJq+aZrqph6fNpyFMI9Aspzaom4J
         tq7ap0agbiXKglijQ7GBmRkWg0TUbFMXSWj603gBLRBcfllJvOOEt80RKZg+xZHGRdug
         YNqA==
X-Forwarded-Encrypted: i=1; AJvYcCWGNU6pZpR8APgZC7JdPehpvHlSJuyfUGlCrM8tSYGSPUzedIm51AW5T7zBj5VM1Zk0myNZJppmBgOM2JorPw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyJ3GQXuHO9AweJTT2h8bHgUnwXAF/QjWYIHyD/f/BAvWOI/G
	mULzwMQV7YnqC8p3TWBXe3dRmHJWtWJfbXkDsaQX2QOM8CbOJlFnJTFAPvOpEGXecnE=
X-Gm-Gg: ASbGncuBGc5bgdAQPvAwz6kU37M071CpGTO1Vr9JEIbINi+prVcCNT3SIySAoXzCDV2
	gGmRpm//5CezyiHXBp2WnYCaPHR9YDt6bbUZG94znwQqxoYFsoh9yDKbdxNVk4POYo9i7QLHhC6
	egOe/I4ac/k7SQx9KWPrZc26iFCoGqlbkb7eUrT1v1V/XUR5Tbwg5F31fHivQObW2MBvY0zx1iV
	fn/KgJpXO0anbyunxbUGB66vBl2O1d3+5U+r06Qo5iUVbgAgdJUNe6zzYYfEVdge2rwYbDmJN/K
	5rwUPwhw4+nUXG1mrPIaYvyBipSh94KrLEtM5UeQ6zw1blDgTmvjgvf5iC2ILwgq9bFRdlvRoSl
	/73henGLklw4q7zVrhCZuLeCuCR3KtynkLL0Bsi8R4Qo72m0dZreLj+mz0+wx8SIYut64qx9PM1
	w6UfY50MauMer+PbB+fmQwarOOLPp5wdA=
X-Google-Smtp-Source: AGHT+IHeIDZnOswf52ELEZYN9Eapu+gsyWvQ4kUElr+dQYU/Cq4+N/m+PwBTQ8uS2hlStxD8ANRbMQ==
X-Received: by 2002:a05:6122:8d3:b0:54b:c215:8c0 with SMTP id 71dfb90a1353d-5524e417161mr4784194e0c.0.1759807873730;
        Mon, 06 Oct 2025 20:31:13 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-552ea335f07sm2446030e0c.15.2025.10.06.20.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 20:31:13 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org
Subject: [PATCH v5 6/7] liveupdate: kho: move to kernel/liveupdate
Date: Tue,  7 Oct 2025 03:30:59 +0000
Message-ID: <20251007033100.836886-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
In-Reply-To: <20251007033100.836886-1-pasha.tatashin@soleen.com>
References: <20251007033100.836886-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move KHO to kernel/liveupdate/ in preparation of placing all Live Update
core kernel related files to the same place.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/core-api/kho/concepts.rst       |  2 +-
 MAINTAINERS                                   |  2 +-
 init/Kconfig                                  |  2 ++
 kernel/Kconfig.kexec                          | 25 ----------------
 kernel/Makefile                               |  3 +-
 kernel/liveupdate/Kconfig                     | 30 +++++++++++++++++++
 kernel/liveupdate/Makefile                    |  4 +++
 kernel/{ => liveupdate}/kexec_handover.c      |  6 ++--
 .../{ => liveupdate}/kexec_handover_debug.c   |  0
 .../kexec_handover_internal.h                 |  0
 10 files changed, 42 insertions(+), 32 deletions(-)
 create mode 100644 kernel/liveupdate/Kconfig
 create mode 100644 kernel/liveupdate/Makefile
 rename kernel/{ => liveupdate}/kexec_handover.c (99%)
 rename kernel/{ => liveupdate}/kexec_handover_debug.c (100%)
 rename kernel/{ => liveupdate}/kexec_handover_internal.h (100%)

diff --git a/Documentation/core-api/kho/concepts.rst b/Documentation/core-api/kho/concepts.rst
index 36d5c05cfb30..d626d1dbd678 100644
--- a/Documentation/core-api/kho/concepts.rst
+++ b/Documentation/core-api/kho/concepts.rst
@@ -70,5 +70,5 @@ in the FDT. That state is called the KHO finalization phase.
 
 Public API
 ==========
-.. kernel-doc:: kernel/kexec_handover.c
+.. kernel-doc:: kernel/liveupdate/kexec_handover.c
    :export:
diff --git a/MAINTAINERS b/MAINTAINERS
index 49e8fc4a393e..c1c4291556aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13777,7 +13777,7 @@ S:	Maintained
 F:	Documentation/admin-guide/mm/kho.rst
 F:	Documentation/core-api/kho/*
 F:	include/linux/kexec_handover.h
-F:	kernel/kexec_handover*
+F:	kernel/liveupdate/kexec_handover*
 F:	tools/testing/selftests/kho/
 
 KEYS-ENCRYPTED
diff --git a/init/Kconfig b/init/Kconfig
index cab3ad28ca49..0605de5d96c0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2138,6 +2138,8 @@ config TRACEPOINTS
 
 source "kernel/Kconfig.kexec"
 
+source "kernel/liveupdate/Kconfig"
+
 endmenu		# General setup
 
 source "arch/Kconfig"
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 03c3aa6263d3..15632358bcf7 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -94,31 +94,6 @@ config KEXEC_JUMP
 	  Jump between original kernel and kexeced kernel and invoke
 	  code in physical address mode via KEXEC
 
-config KEXEC_HANDOVER
-	bool "kexec handover"
-	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
-	depends on !DEFERRED_STRUCT_PAGE_INIT
-	select MEMBLOCK_KHO_SCRATCH
-	select KEXEC_FILE
-	select DEBUG_FS
-	select LIBFDT
-	select CMA
-	help
-	  Allow kexec to hand over state across kernels by generating and
-	  passing additional metadata to the target kernel. This is useful
-	  to keep data or state alive across the kexec. For this to work,
-	  both source and target kernels need to have this option enabled.
-
-config KEXEC_HANDOVER_DEBUGFS
-	bool "kexec handover debugfs interface"
-	depends on KEXEC_HANDOVER
-	depends on DEBUG_FS
-	help
-	  Allow to control kexec handover device tree via debugfs
-	  interface, i.e. finalize the state or aborting the finalization.
-	  Also, enables inspecting the KHO fdt trees with the debugfs binary
-	  blobs.
-
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	default ARCH_DEFAULT_CRASH_DUMP
diff --git a/kernel/Makefile b/kernel/Makefile
index f21d8c98d857..e83669841b8c 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -52,6 +52,7 @@ obj-y += printk/
 obj-y += irq/
 obj-y += rcu/
 obj-y += livepatch/
+obj-y += liveupdate/
 obj-y += dma/
 obj-y += entry/
 obj-y += unwind/
@@ -82,8 +83,6 @@ obj-$(CONFIG_CRASH_DUMP_KUNIT_TEST) += crash_core_test.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
-obj-$(CONFIG_KEXEC_HANDOVER) += kexec_handover.o
-obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS) += kexec_handover_debug.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
new file mode 100644
index 000000000000..522b9f74d605
--- /dev/null
+++ b/kernel/liveupdate/Kconfig
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "Live Update"
+
+config KEXEC_HANDOVER
+	bool "kexec handover"
+	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
+	depends on !DEFERRED_STRUCT_PAGE_INIT
+	select MEMBLOCK_KHO_SCRATCH
+	select KEXEC_FILE
+	select DEBUG_FS
+	select LIBFDT
+	select CMA
+	help
+	  Allow kexec to hand over state across kernels by generating and
+	  passing additional metadata to the target kernel. This is useful
+	  to keep data or state alive across the kexec. For this to work,
+	  both source and target kernels need to have this option enabled.
+
+config KEXEC_HANDOVER_DEBUGFS
+	bool "kexec handover debugfs interface"
+	depends on KEXEC_HANDOVER
+	depends on DEBUG_FS
+	help
+	  Allow to control kexec handover device tree via debugfs
+	  interface, i.e. finalize the state or aborting the finalization.
+	  Also, enables inspecting the KHO fdt trees with the debugfs binary
+	  blobs.
+
+endmenu
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
new file mode 100644
index 000000000000..9a702edc1dec
--- /dev/null
+++ b/kernel/liveupdate/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
+obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debug.o
diff --git a/kernel/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
similarity index 99%
rename from kernel/kexec_handover.c
rename to kernel/liveupdate/kexec_handover.c
index 902c30feae09..5da21f1510cc 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -24,8 +24,8 @@
  * KHO is tightly coupled with mm init and needs access to some of mm
  * internal APIs.
  */
-#include "../mm/internal.h"
-#include "kexec_internal.h"
+#include "../../mm/internal.h"
+#include "../kexec_internal.h"
 #include "kexec_handover_internal.h"
 
 #define KHO_FDT_COMPATIBLE "kho-v1"
@@ -1124,7 +1124,7 @@ static int __kho_finalize(void)
 	err |= fdt_finish_reservemap(root);
 	err |= fdt_begin_node(root, "");
 	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
-	/**
+	/*
 	 * Reserve the preserved-memory-map property in the root FDT, so
 	 * that all property definitions will precede subnodes created by
 	 * KHO callers.
diff --git a/kernel/kexec_handover_debug.c b/kernel/liveupdate/kexec_handover_debug.c
similarity index 100%
rename from kernel/kexec_handover_debug.c
rename to kernel/liveupdate/kexec_handover_debug.c
diff --git a/kernel/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
similarity index 100%
rename from kernel/kexec_handover_internal.h
rename to kernel/liveupdate/kexec_handover_internal.h
-- 
2.51.0.618.g983fd99d29-goog


