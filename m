Return-Path: <linux-kselftest+bounces-35504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CF6AE2627
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9559E7B0C15
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E95924A055;
	Fri, 20 Jun 2025 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tlSDHG08"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C919A243364
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461681; cv=none; b=OdnKCuJhoAAm+7lKSBRsnRllwPSWna5FSFjJx5CaK0SJyfjTcgOu2SSQIW1fU/JLd1gOr6FwvrlylEloE7qQ3HnPDkbINOg1/mWvF8kGp5JK2mQsrLP8gPW1N4uY+iKRQG5tTQ7t5FfgE1IHZNSmiWZEi0VcDRKq9Wk8TNqy61U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461681; c=relaxed/simple;
	bh=rjAOOg5rAqiE8TcyI+gxmP/J4K5fE0ChxFTfHJ5WsPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bz/K0hNx/5j6PvrM0oFwseSXQmwPkg/FrUs5zQQpMMX4KmZNT4IGwbEXH78nzIpZDrYzKwayFIPp9OCrOkjFfnZcQxSfAPMn78ykunyPu/iuk0qbnFZv3in4SZjDTy5f02Em8t18CgmY1tOYG+cHS4QClCb6VqYIxAt0bekYgEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tlSDHG08; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748b4d5c045so1829562b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461679; x=1751066479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=94GJWP70zctYgbzarRKMjhu8IQXsXSiZ1mX5cwoCPok=;
        b=tlSDHG08ICUgIZF586gLlTpnHZiAkHfoEmmgRp9iLSQEu4GYvRJNryk7hUtQVzlVrK
         m9zOOEoJHEPYbIqxg/1MHPf7IqcCTzIIFRCjNaKTD43NbSZIW/69RmA1OrDaCm6pnmI3
         /wmO6T2oyOayP1eOSchrvyRwjYYZeBp8DRMTtkcKrN9Mvj6M3vW8cVGnFWu2rTBOqvtg
         DtCoOw30YNCvhdFlh8A6OgvHgZvxSDu+Jv3lODqnKTg4Je5qKAEU5RheqK22SigvwV9S
         QN3+3IJAKn1k7aeyvcr6CtxoNWsqvWq0k3ZOCyQGumwKAT0J3iJG1H5QFGWp8pfihhqp
         S+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461679; x=1751066479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94GJWP70zctYgbzarRKMjhu8IQXsXSiZ1mX5cwoCPok=;
        b=pyc6fNo1gIsR9Zh3eYCHOhucqa5Uw9iDmIP1hHj5rxbencKPByorzv3OioL+kH6uxU
         K8xfsPeS8KidUNtUBQ4vDKwC1ArZYhuS+xQLPgw3f3oo2QmyBjw4XQ5aRA95rUPrmJkO
         atggKPrap6ePIGAyTxpbWlchRVgHruCVwWlIh3d+BwUdf/4nW+Na5cuuxgIOqdcVVZSu
         B6Aj95O76UP6zrg8ku+b2tu/KiHJHeNR6v6VmlQwmm2Ia2Nfdk+1pBx1kgTKIRj9LxRP
         qqLVqeSRZcn3EjMFWFNXEfdw1nPRr/NDoFC56vTAXxui6B65NgOlX5XxLmJPCf0r3X5u
         jiWw==
X-Forwarded-Encrypted: i=1; AJvYcCUtAXxkK2jfeylMXfP9w2KHdQvqUTKpO2+VasQ4nVWCbhZ8YLoNet8/syByju8jcn+YXo5thVvhqp6iValFjUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYaQn+WEEfc1RW++eCgiqRlj2VTZEkXG+qS7xVbRG2NM3CI+gR
	nmsAwFJdJLf11+Q045JlzfCQG5j0y7/2aYlyvw8I4tKyOPnhjmte8NRtMQ9haAbK97KWCnpzh9U
	+y4cYtybRjjZ2MQ==
X-Google-Smtp-Source: AGHT+IE4VMXsve8M9dbvTR8GNNExOeCyx2MQbPfsc8q8B1evW0kfg7x5+2IlqSW/SM0OnBHCr9pUi8Np41/tTQ==
X-Received: from pfrh7.prod.google.com ([2002:aa7:9f47:0:b0:748:4f7c:c605])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3a0a:b0:73d:fa54:afb9 with SMTP id d2e1a72fcca58-7490d786d97mr6243442b3a.7.1750461679257;
 Fri, 20 Jun 2025 16:21:19 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:09 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-12-dmatlack@google.com>
Subject: [PATCH 11/33] tools headers: Import x86 MMIO helper overrides
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
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
2.50.0.rc2.701.gf1e915cc24-goog


