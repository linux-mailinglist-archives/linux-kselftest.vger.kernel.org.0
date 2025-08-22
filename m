Return-Path: <linux-kselftest+bounces-39747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95228B3247B
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AECAE1153
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3C234F483;
	Fri, 22 Aug 2025 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/PJMAHd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F44034F467
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897994; cv=none; b=tE448CNIc/n5YOJtQHtMMaotlxBKux3RPVsfC7T1zTW66v9SKyRRUIssi8DEIFVMuVfLRRFlyLxNNoLOZk8mYLzRsnHrZjJ4DrDu7HkcvD2RtWg46Z+RfMP3UifAHPBfRm50MIPwB8zPn3Rq4sbRpN1cTbNENWpFC0vxyFiJ8r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897994; c=relaxed/simple;
	bh=st2bAkDcHArqlZH/Ep7aZTmX2/+vCG37gQKkypE/wcU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OwuisY81IpoKPZyAnwI5FYqskZTu863jVKEgsFSC+Io/dCXLNKr8EPzjc7z7DGCZfbRWuitSexozeLQgZpBoJmJmfAV7jmA/IZnVgYbL03wq2BH7uw0B9FkiE5oC+KTJ+SB2zvTFLRQsu5xAu01Uzs3HS+vp1kv5+pmsJnakVIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R/PJMAHd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b49ca6ba890so780399a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897992; x=1756502792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NewM7guCQbZ54DkrDr3Nbxt1PFBAZlwvsa0ASdQoorY=;
        b=R/PJMAHdKVQJkrjSs9IrpdXTb1LKRmoe/JxXHzJb8Z57Y9cYck9QgmNIFQKoJ/YIkI
         O1hAqPGBu9kRjpXvE+Dwo2RI7Z0fuOvZwAJpzJ/kNNkARUoVN3zGJ4VtFHFsAGO+ymTO
         +Q/b8+DhMv5sEQplZkXNwHDanXWTKXEGUkgS2u2NfNHzZtXj7YBarCwCSMtgsDQ0Y/jy
         AES63OUqDYwTAkJxWulKyN1SLK5ilXgrAwAX6IzCdBQ3XVbJG0URJbQEN+FbLv0Keojv
         X/lxCmYhhLxvx043iH/mQMSZgzp1S7y0qRDNML+k9OOIOn/i6MIflBfZ6lyt+LXu6mAC
         xTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897992; x=1756502792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NewM7guCQbZ54DkrDr3Nbxt1PFBAZlwvsa0ASdQoorY=;
        b=TmHrBgAF5gXUoK+BrjaWsrk9CU5iDBgzuuMRLnYzc81Fb3iHWUZeY6gFP/DbuefzU2
         /dLtH2Memzqfku78Q/6WpeJL0LDjZTElPOP3yeKL3YxJBE8/HuR2WO31JGC09T9ArCPF
         fMGzZVtHQXFD1a3LLaN1+VsYbhpc6DjROO9FRlhwVN3XRzL4cAEUCQ9zldGRaA8Qhpyd
         vZYneRhX1f2s2D+GSMuj6NARWoAoDWjipmbINh2cYSCP1ae55EQU/5/6G2VBIT5Lt4/s
         AX0o/zcsBYjOeF3wxXeDdaoeCU+o8sNxPhr/IUgRbbU9BO3KT0bpV53jz8Y6I7ixwuH7
         WrQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrQteqYw4or9jvf+3AP15A6mPS6hioRhyRROIMRlmx+XBogevFpp+v/72lSdpZCgnHqqd8Ronw2HRYZrxdFvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmh7V9gCgLiMa6CMINl0uKYpJHU3PwDhwO9RhFEe+wAFrp1O0Y
	U/PDIg0DPElX4qn27JVkowFVYy5SNQ1WJAdt351mQv90n4v5buVFLQwYDfxUUgUyp3sa9dtsTqg
	aAnDYKzAQQFDQdw==
X-Google-Smtp-Source: AGHT+IH0eU89n3fh/RFsflbfoqEeSyt3RNSN7kC81WRTN2L5uMvUPH4QIwTpFFDFaU6Xc6tjT4Fnadhoix3CHQ==
X-Received: from pgjh17.prod.google.com ([2002:a63:df51:0:b0:b42:c17:47ac])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7fa7:b0:243:15b9:7791 with SMTP id adf61e73a8af0-24340eb3d15mr6068245637.53.1755897992392;
 Fri, 22 Aug 2025 14:26:32 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:03 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-17-dmatlack@google.com>
Subject: [PATCH v2 16/30] tools headers: Import x86 MMIO helper overrides
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Import the x86-specific overrides for <asm-generic/io.h> from the kernel
headers into tools/include/.

Changes made when importing:
 - Replace CONFIG_X86_64 with __x86_64__.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
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
2.51.0.rc2.233.g662b1ed5c5-goog


