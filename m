Return-Path: <linux-kselftest+bounces-44573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A84C280E1
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 15:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D72E4EB5ED
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 14:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6839F2FC003;
	Sat,  1 Nov 2025 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Q8hF631B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB42FB99B
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Nov 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007028; cv=none; b=GG8QvqtXeFrg+qsYvRfA22KJ+wAYciDNA/GY+kEUBjditRQlwNxti2MQr8egl8SDapK/KKQLqIAjtqTLVEHJkCWI/EIg4vV2nfNtEghY3cBOppeizueXPOB0wpv4GCzDzdFSColF9N6zSHUjXKKeoJX3SiYE3j1dKFZW7UvJD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007028; c=relaxed/simple;
	bh=Sz6qvH3kZZly7FxwahblwfCH26skEMNmJunfLKVFLiY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ro84iR8N5eexfoxApvzknInMxLNtd5nx6Wrig9gKAVBB6nsi+NeJr215mCIGHiYnac3PpiQpTWZ2OzsD9kWnBEE5IpPlfvm+ybRUFovAMQIysaWLWva0RYTq4hqXr99tAuG/n0mKvQuIm13er+lfuZEuW24msuxUyp6ELLN9ouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Q8hF631B; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5563c36f6d4so3234330e0c.1
        for <linux-kselftest@vger.kernel.org>; Sat, 01 Nov 2025 07:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762007025; x=1762611825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqNjQc+nWE3xdzzLNsyLKvDeccdmT+igcGJuf8ZrBtc=;
        b=Q8hF631BsLLm76sDVONF8JXZiWa0IrI2d3Ie4tbwxb56JjjGTH2W+inbYiPElSXGae
         wLTKKTrB/ZSaqiAXr9XQN2VZzJvOOPJvcAQdfXcEDyHDNHGitReCRLMn0y2ejXKfLVDq
         LxOughvsVo2Y4awPiRZ8oFFYX/ej/rKsiRbmatK4NbBWpRVlC5AHxEw/lhartnPEIwr8
         7dUrUwzdnsEgbw4NVT0Xzqv2xGpzgcp3cteGclv17nG+dvIFSJHBguIDE1nAWdNr9P9Y
         hHlyzxGIrqyNJSG/s6ejET1LM8MumQ0cHoK0ipsgO3UOpNWwr5cUyFiTSdkc4oJ/X5pV
         fTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762007025; x=1762611825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqNjQc+nWE3xdzzLNsyLKvDeccdmT+igcGJuf8ZrBtc=;
        b=vTbnjt8yqYSpDZAwJakn/OkVATGoOUWzRrwSoMOJFzjTAUBV7wZEs2e6vJonCaNClc
         15hgO7tz3bg6KaCfi1v2+jM20HvbjKFGnsWK1UFoBNeI+vxUUip/te0yqG65qAXLMpE2
         elHt+0WFsKaYBK1CIvmQYzUO03img6g9XP+62Qxu/5vhu64myE0vUX116cWYaObAXKNR
         q8PBixcKnM1kOFTxDFqSUbSPXrJrXyC5bnF4pNL3BbzXP6Gt/CQrYD9lNkMni6ScwKYU
         vRAitkiyOzqjT6qzs004sDgS6YZfcG9U5HsY4o4B5dMk3M1YU9QrwU67HOQd/t3kS+NW
         RRLg==
X-Forwarded-Encrypted: i=1; AJvYcCXWoQOaFJpPCfTJWOPq6AjpNarElCzSXWxMlZoDqNwtaZ3gwXeO3pLmIt/TRgPomO6SPR3LioXdwiaAFN23/gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGK0MqRKJwwKusdudX0u7OAG4wVzE/HHVahJ6NArhn+EWAhn/D
	FH3bR91vAXqOFYcMCwFHRL41kxpIK4y0lxMnrr4JDc333BNcJiSqT+VySsu/MN7JvEA=
X-Gm-Gg: ASbGncuFIdH49N223DUV45/tLC6xX7CxPbLm29FG8OI0YO3Z+CAX+OQoP+fkc59POsH
	xRv2rdM26yCEYAPHQ0ZR64j1/dBzD1gZy55khbzrann4+pc10uXO5J1lluBnk2RaB9dujJtWBVq
	Xu0rlFueYcIjdeOpbD2oguz6A3oLmJTaBisjJpar1FUyehOgBYhrRahgfqYMNRSRxStwqfgc22k
	l6pALDNvCAVwsD1pgT++nSshDB43JWCI9zw4/dSp6LyWKVPFnInngA3yDoDWByEPY6xTlR5htNK
	pILm/8GFbetdxXySDkpMaVnSJrn65KOtgWWCoCoqPkzuZvk2dYS9ZhjOeC8KPTVMYYzxqWkvT3t
	Hpp5TF858NkUmR8UFpK9z9qSoANTQcPXzRntstGEFTtl2SHNXbyBa4gF2peoQO+r6bjiScGvI9i
	t+7YPeOZm/DvnONniFdU85WBLfUyz8+DVoNyqnLy9tt/AVw2ECQrlMQBvA2g4/
X-Google-Smtp-Source: AGHT+IHYfN0T4cVNH96uqE/VxqJsEPgIJwOQllfGh/DOiPLvpYAfaaq3PsJ2yY0Nnq8P1OfSoH8nvw==
X-Received: by 2002:a05:6122:3289:b0:552:3366:e822 with SMTP id 71dfb90a1353d-5593e260540mr2675875e0c.1.1762007025167;
        Sat, 01 Nov 2025 07:23:45 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559449647e0sm1776242e0c.3.2025.11.01.07.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 07:23:44 -0700 (PDT)
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
	tj@kernel.org,
	yanjun.zhu@linux.dev
Subject: [PATCH v9 7/9] liveupdate: kho: move to kernel/liveupdate
Date: Sat,  1 Nov 2025 10:23:23 -0400
Message-ID: <20251101142325.1326536-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
In-Reply-To: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
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
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 Documentation/core-api/kho/concepts.rst       |  2 +-
 MAINTAINERS                                   |  2 +-
 init/Kconfig                                  |  2 +
 kernel/Kconfig.kexec                          | 34 ----------------
 kernel/Makefile                               |  4 +-
 kernel/liveupdate/Kconfig                     | 39 +++++++++++++++++++
 kernel/liveupdate/Makefile                    |  5 +++
 kernel/{ => liveupdate}/kexec_handover.c      |  4 +-
 .../{ => liveupdate}/kexec_handover_debug.c   |  0
 .../{ => liveupdate}/kexec_handover_debugfs.c |  0
 .../kexec_handover_internal.h                 |  0
 11 files changed, 51 insertions(+), 41 deletions(-)
 create mode 100644 kernel/liveupdate/Kconfig
 create mode 100644 kernel/liveupdate/Makefile
 rename kernel/{ => liveupdate}/kexec_handover.c (99%)
 rename kernel/{ => liveupdate}/kexec_handover_debug.c (100%)
 rename kernel/{ => liveupdate}/kexec_handover_debugfs.c (100%)
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
index bdd0a1260421..764df916fae7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13795,7 +13795,7 @@ S:	Maintained
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
index cc6743137946..15632358bcf7 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -94,40 +94,6 @@ config KEXEC_JUMP
 	  Jump between original kernel and kexeced kernel and invoke
 	  code in physical address mode via KEXEC
 
-config KEXEC_HANDOVER
-	bool "kexec handover"
-	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
-	depends on !DEFERRED_STRUCT_PAGE_INIT
-	select MEMBLOCK_KHO_SCRATCH
-	select KEXEC_FILE
-	select LIBFDT
-	select CMA
-	help
-	  Allow kexec to hand over state across kernels by generating and
-	  passing additional metadata to the target kernel. This is useful
-	  to keep data or state alive across the kexec. For this to work,
-	  both source and target kernels need to have this option enabled.
-
-config KEXEC_HANDOVER_DEBUG
-	bool "Enable Kexec Handover debug checks"
-	depends on KEXEC_HANDOVER
-	help
-	  This option enables extra sanity checks for the Kexec Handover
-	  subsystem. Since, KHO performance is crucial in live update
-	  scenarios and the extra code might be adding overhead it is
-	  only optionally enabled.
-
-config KEXEC_HANDOVER_DEBUGFS
-	bool "kexec handover debugfs interface"
-	default KEXEC_HANDOVER
-	depends on KEXEC_HANDOVER
-	select DEBUG_FS
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
index 2cf7909a74e5..e83669841b8c 100644
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
@@ -82,9 +83,6 @@ obj-$(CONFIG_CRASH_DUMP_KUNIT_TEST) += crash_core_test.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
-obj-$(CONFIG_KEXEC_HANDOVER) += kexec_handover.o
-obj-$(CONFIG_KEXEC_HANDOVER_DEBUG) += kexec_handover_debug.o
-obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS) += kexec_handover_debugfs.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
new file mode 100644
index 000000000000..1379a4c40b09
--- /dev/null
+++ b/kernel/liveupdate/Kconfig
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "Live Update and Kexec HandOver"
+
+config KEXEC_HANDOVER
+	bool "kexec handover"
+	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
+	depends on !DEFERRED_STRUCT_PAGE_INIT
+	select MEMBLOCK_KHO_SCRATCH
+	select KEXEC_FILE
+	select LIBFDT
+	select CMA
+	help
+	  Allow kexec to hand over state across kernels by generating and
+	  passing additional metadata to the target kernel. This is useful
+	  to keep data or state alive across the kexec. For this to work,
+	  both source and target kernels need to have this option enabled.
+
+config KEXEC_HANDOVER_DEBUG
+	bool "Enable Kexec Handover debug checks"
+	depends on KEXEC_HANDOVER
+	help
+	  This option enables extra sanity checks for the Kexec Handover
+	  subsystem. Since, KHO performance is crucial in live update
+	  scenarios and the extra code might be adding overhead it is
+	  only optionally enabled.
+
+config KEXEC_HANDOVER_DEBUGFS
+	bool "kexec handover debugfs interface"
+	default KEXEC_HANDOVER
+	depends on KEXEC_HANDOVER
+	select DEBUG_FS
+	help
+	  Allow to control kexec handover device tree via debugfs
+	  interface, i.e. finalize the state or aborting the finalization.
+	  Also, enables inspecting the KHO fdt trees with the debugfs binary
+	  blobs.
+
+endmenu
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
new file mode 100644
index 000000000000..f52ce1ebcf86
--- /dev/null
+++ b/kernel/liveupdate/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
+obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
+obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
diff --git a/kernel/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
similarity index 99%
rename from kernel/kexec_handover.c
rename to kernel/liveupdate/kexec_handover.c
index 3adf86c7c2db..be945c133a2f 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -26,8 +26,8 @@
  * KHO is tightly coupled with mm init and needs access to some of mm
  * internal APIs.
  */
-#include "../mm/internal.h"
-#include "kexec_internal.h"
+#include "../../mm/internal.h"
+#include "../kexec_internal.h"
 #include "kexec_handover_internal.h"
 
 #define KHO_FDT_COMPATIBLE "kho-v1"
diff --git a/kernel/kexec_handover_debug.c b/kernel/liveupdate/kexec_handover_debug.c
similarity index 100%
rename from kernel/kexec_handover_debug.c
rename to kernel/liveupdate/kexec_handover_debug.c
diff --git a/kernel/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
similarity index 100%
rename from kernel/kexec_handover_debugfs.c
rename to kernel/liveupdate/kexec_handover_debugfs.c
diff --git a/kernel/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
similarity index 100%
rename from kernel/kexec_handover_internal.h
rename to kernel/liveupdate/kexec_handover_internal.h
-- 
2.51.1.930.gacf6e81ea2-goog


