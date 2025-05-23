Return-Path: <linux-kselftest+bounces-33707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF55CAC2C3C
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF5F541E09
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F30C220699;
	Fri, 23 May 2025 23:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3tlNTM4+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730BF217701
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043048; cv=none; b=JW8kWbzxZ0DlLs7NMFvEo/++Xn5fSNyMWpH8GkiF5ZgTuIFJZdYAiqP7pLAMARg9rojSFLMG78YPTd0KfOPKsyeoLyXbrL6l/XpPnhgb3jGBLn/ShEPIGXs7yR+MEKHFGa/CljUHpE5b4dQIpNPyXWQpzckauWcR9ZbV7OYcfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043048; c=relaxed/simple;
	bh=pSt6hqFp0TXiq3XNe4gBZ0pAPQcGa/uFxgZiBbkD8mE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K3v5yPubcvSDQ+14gFyUQJluX3fMTmrcOi3CPeCqn+YaDR5oKDZ6EoBI8fWV6L4DKPsx7rt+HrAWVCuEmTQexRnDfstOtKcQkp37tDlFdxpTF5XU/Gz3TiIwsGMt2HC1Mw0XougZgVMGSRt2ZXjrlYckj7RX1tHH8AwJ4XhYNYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3tlNTM4+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31107cc21feso404149a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043046; x=1748647846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2956OZuGZreL0emM+nR7xbZnosCgEt+uYi1FTVeUB/g=;
        b=3tlNTM4+ebgdIoC9AQgUMwON6bHbAtufciRy486x4IkxSaqGyP44C7XJJSzzY92cTw
         e4u+wEuPr3Txs3WudXBxjFdL5QhIFhDh2QrUbFoam2egvsuuPV+gKtjGq6LsIwWi9seT
         LVJgGMWSvfBy11BdHYdgwiiGTzSt2CIURxlJhcLb4MoIeNjAl5w03/+PfNmV45GBUexp
         4zJybFzi6yTh2vXDP/35pKX+kVHd1vIeu1Z2o8IfbC9VrNUuFZ4CN9VLnXLU33/uIFBC
         LNVXu5eP2dHB6cq/KQuKrCcqCxTypbOyNclaqsTNMlQ6A2hO+wcMQdxiqsSv53J7LF5j
         6hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043046; x=1748647846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2956OZuGZreL0emM+nR7xbZnosCgEt+uYi1FTVeUB/g=;
        b=l8GLM6dKFvzFCIN2tkFHDeM39ELO9uJGphCvn/E9KPeFyRrt56fM7ynk0UKjOtKSZD
         WAA1pJzQ7pdCBtWad4+zRvTzZB0jvKrvhcXHWDLXDag6kgAreyNYb4tXppaalrTaG+L9
         FpL/JVr9AxZI7G3PakN5MdtoRHXl8qcvksxl5pYr92Gf4RlLjONtfwQX+oFD55iTJTZJ
         kZNFB1lf7nJZSlyIJwW8Pi61GrsoqO5hVfGGFyb/Z/4JB4PxQj3SyoFqNjeM7Ud7N9cu
         aajI5x4upDLeGmL14SWiJ0U0csuxZjum0i2k9mll+o7+KH4NLKg1MQtrp9dsnutjjdPF
         9Xnw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Z9aXsEE6Y0yhbrBXKAIK4/+tuVJYvr5JHelj9/MHSVXcJwbAvXo+PNUwZXc6mT6ybrJD1zM1O81amstrfCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzapK5WRhGISSwtyVtI0iRayf3NPX3LmQKhS1rcLZQkQ4Ho5Mix
	Ns/UMsSfsuXorQu1VOMlg3KCkEbaY4e2h+zCftlYKs57/BGgZjXum4XZslEzzM6x16Djk/0Rqiy
	tYWZIJJlcgI0KVw==
X-Google-Smtp-Source: AGHT+IEk+iX5N8w1Ax+WlWPsiyQA+3IBKByqgkAQCQVeSWGtQJFMLj/JAnWxv4OGtypjn7p8YoLzMSe4KwbHGA==
X-Received: from pjm6.prod.google.com ([2002:a17:90b:2fc6:b0:2fa:a101:755])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:55cb:b0:30a:883a:ea5b with SMTP id 98e67ed59e1d1-3110f30e9dbmr1644757a91.17.1748043045842;
 Fri, 23 May 2025 16:30:45 -0700 (PDT)
Date: Fri, 23 May 2025 23:29:56 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-12-dmatlack@google.com>
Subject: [RFC PATCH 11/33] tools headers: Import x86 MMIO helper overrides
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

Import the x86-specific overrides for <asm-generic/io.h> from the kernel
headers into tools/include/.

Changes made when importing:
 - Replace CONFIG_X86_64 with __x86_64__.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/arch/x86/include/asm/io.h | 75 +++++++++++++++++++++++++++++++++
 tools/include/asm/io.h          |  4 ++
 2 files changed, 79 insertions(+)
 create mode 100644 tools/arch/x86/include/asm/io.h

diff --git a/tools/arch/x86/include/asm/io.h b/tools/arch/x86/include/asm/io.h
new file mode 100644
index 000000000000..4c787a2363de
--- /dev/null
+++ b/tools/arch/x86/include/asm/io.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_ASM_X86_IO_H
+#define _TOOLS_ASM_X86_IO_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+#define build_mmio_read(name, size, type, reg, barrier) \
+static inline type name(const volatile void __iomem *addr) \
+{ type ret; asm volatile("mov" size " %1,%0":reg (ret) \
+:"m" (*(volatile type __force *)addr) barrier); return ret; }
+
+#define build_mmio_write(name, size, type, reg, barrier) \
+static inline void name(type val, volatile void __iomem *addr) \
+{ asm volatile("mov" size " %0,%1": :reg (val), \
+"m" (*(volatile type __force *)addr) barrier); }
+
+build_mmio_read(readb, "b", unsigned char, "=q", :"memory")
+build_mmio_read(readw, "w", unsigned short, "=r", :"memory")
+build_mmio_read(readl, "l", unsigned int, "=r", :"memory")
+
+build_mmio_read(__readb, "b", unsigned char, "=q", )
+build_mmio_read(__readw, "w", unsigned short, "=r", )
+build_mmio_read(__readl, "l", unsigned int, "=r", )
+
+build_mmio_write(writeb, "b", unsigned char, "q", :"memory")
+build_mmio_write(writew, "w", unsigned short, "r", :"memory")
+build_mmio_write(writel, "l", unsigned int, "r", :"memory")
+
+build_mmio_write(__writeb, "b", unsigned char, "q", )
+build_mmio_write(__writew, "w", unsigned short, "r", )
+build_mmio_write(__writel, "l", unsigned int, "r", )
+
+#define readb readb
+#define readw readw
+#define readl readl
+#define readb_relaxed(a) __readb(a)
+#define readw_relaxed(a) __readw(a)
+#define readl_relaxed(a) __readl(a)
+#define __raw_readb __readb
+#define __raw_readw __readw
+#define __raw_readl __readl
+
+#define writeb writeb
+#define writew writew
+#define writel writel
+#define writeb_relaxed(v, a) __writeb(v, a)
+#define writew_relaxed(v, a) __writew(v, a)
+#define writel_relaxed(v, a) __writel(v, a)
+#define __raw_writeb __writeb
+#define __raw_writew __writew
+#define __raw_writel __writel
+
+#ifdef __x86_64__
+
+build_mmio_read(readq, "q", u64, "=r", :"memory")
+build_mmio_read(__readq, "q", u64, "=r", )
+build_mmio_write(writeq, "q", u64, "r", :"memory")
+build_mmio_write(__writeq, "q", u64, "r", )
+
+#define readq_relaxed(a)	__readq(a)
+#define writeq_relaxed(v, a)	__writeq(v, a)
+
+#define __raw_readq		__readq
+#define __raw_writeq		__writeq
+
+/* Let people know that we have them */
+#define readq			readq
+#define writeq			writeq
+
+#endif /* __x86_64__ */
+
+#include <asm-generic/io.h>
+
+#endif /* _TOOLS_ASM_X86_IO_H */
diff --git a/tools/include/asm/io.h b/tools/include/asm/io.h
index 9ae219b12604..eed5066f25c4 100644
--- a/tools/include/asm/io.h
+++ b/tools/include/asm/io.h
@@ -2,6 +2,10 @@
 #ifndef _TOOLS_ASM_IO_H
 #define _TOOLS_ASM_IO_H
 
+#if defined(__i386__) || defined(__x86_64__)
+#include "../../arch/x86/include/asm/io.h"
+#else
 #include <asm-generic/io.h>
+#endif
 
 #endif /* _TOOLS_ASM_IO_H */
-- 
2.49.0.1151.ga128411c76-goog


