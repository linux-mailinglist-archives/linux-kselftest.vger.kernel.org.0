Return-Path: <linux-kselftest+bounces-39746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6FCB32453
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28967B679DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DAF34F475;
	Fri, 22 Aug 2025 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JF3i5NN1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5936A34DCFD
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897993; cv=none; b=Rc/iDZZjn70mmIgxxud6FGmC8J1CFJjnxs0TevoT4cgnNfEFkSZNBkF6ImL/S12J8Vzy++lTNTQLHuDrsNuLFXKvRngiKPYPmB272j2LKAVlIS2Bw1n1zxPZ5MECEJZ6dN8KuXHn5qJlnw27eiG23VOg0Pvoi7dnDhG5wegR2PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897993; c=relaxed/simple;
	bh=I359ysknIE62DxKyjSzpHRKc98vK4FsB50qGc1L6+vE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f+M30kTDo0M0YQ5MYu5M8oNpDkeuRZ6qxz08ndYmzizB4ZqquYBOmex0aKmbdi28hYrg8+9ugd7/xcAFt1rPlwq5N7XIxYXqhIYromsorp3v4VdbfkCK70mtt4iv64+M19n0R4m3IF6FJDyiIbXgsXnxd0o2VXB2Teykfao6DmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JF3i5NN1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e21dd6so4374462a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897991; x=1756502791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zu0U30dbChDOvy1DkBrEbu4LTwdhxBRXInij2JFuOQ=;
        b=JF3i5NN1OQ8BM4UpEVeyDFU68jlUGEaP7yiHTr0j7hRcLR68JRNqmhPkrqfj/OZR2b
         HjJO6tVddgcfwD2cTkk9G14kMJjuBG5v822dVIThPvnKJcZ5rUvRHOP0CyuK8IlqZRkL
         /Yg7B7obf2WwmbMJBjZjeWbFMEXLinkCWdPxv6v0Pg2I3FyF0OQ2A1KEU8QRGKQNs5Jp
         h3FSZ3fDrRK7gFXSOL+jrEkUhgoGqeWFKAIU+b9B4BUgbQIsK+vORgbM1Pt+luBnYETa
         UBKjBj+ULJBbrR/nXl5R5Q9IEFlh8b/08iC1Y1/RFaNBKvihI6tOyT98KAF7m5e6zDCX
         BftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897991; x=1756502791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zu0U30dbChDOvy1DkBrEbu4LTwdhxBRXInij2JFuOQ=;
        b=Jogkdlj9Z+EyVTPNtwIDFzC5QRrbkLZbpc9KVnIKrlp0xl5noLV5x8zi9Ksr0ap+Q4
         fbIOY/g31CcBtHPHVv8jS1FeS9AFgKlQvWPMBiPXsaaU9jLodnJkj/hnoF2Vi56RJeY1
         Jq3eDaCX5Apo5tRBk1jIEnUw4x4sV0xGii7LNMBp7dBq+zn37wTp20qciHjanLizuIF2
         FgdqjuYXd5Jb2KmgBulFr7NRrWalIYvxo64BAibxfmQJZzRrbjlXFZ7Qfwv8C1gc/uGL
         u/8KOnZ5ydVySg76eoaKHj/OqBYqob8bKvYTZY6jSjn47Ol43Qe8FPWO0wCBtuprxE9H
         GgOw==
X-Forwarded-Encrypted: i=1; AJvYcCWu63k23SnLy6sbygNFJ74C0sJ9mw6a+U7nd776yQMOK1RP8gycKgQDE/lJ00SKMntlSIpfrKUi8c/i7iDQ+Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye+R3bIbBU1qz9WkxFiv9ELe/kBs15p4+mfvmSTeJiA8A3K2Qd
	M1fEFwS+JTp3vtxgvx7vApihbUCcv+NbbdaL+3wOIZkkM0p3z4tOuEIXTiGdU7uT/WvwuPjdGKr
	XCo18e7PW443z8g==
X-Google-Smtp-Source: AGHT+IGKWXRBWiP3BjTwsu2UAwlNliM2I6gbZNC5y6BuYepeXwYFvKEAdn3upZEZVrLPdGmeKAFoRhl1iTGinA==
X-Received: from pjl11.prod.google.com ([2002:a17:90b:2f8b:b0:325:1d7a:69ff])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d51:b0:311:e605:f60e with SMTP id 98e67ed59e1d1-3251774b34bmr6403091a91.20.1755897990832;
 Fri, 22 Aug 2025 14:26:30 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:02 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-16-dmatlack@google.com>
Subject: [PATCH v2 15/30] tools headers: Import asm-generic MMIO helpers
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

Import the asm-generic MMIO helper functions from the kernel headers
into tools/include/. The top-level include is <linux/io.h> which then
includes the arch-specific <asm/io.h>, which then includes
<asm-generic/io.h>. This layout is chosen to match the kernel header
layout and to appease checkpatch.pl (which warns against including
<asm/io.h> or <asm-generic/io.h> directly).

Changes made when importing:

 - Add missing includes at the top.
 - Stub out mmiowb_set_pending().
 - Stub out _THIS_IP_.
 - Stub out log_*_mmio() calls.
 - Drop the CONFIG_64BIT checks, since tools/include/linux/types.h
   always defines u64.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/include/asm-generic/io.h | 482 +++++++++++++++++++++++++++++++++
 tools/include/asm/io.h         |   7 +
 tools/include/linux/io.h       |   4 +-
 3 files changed, 492 insertions(+), 1 deletion(-)
 create mode 100644 tools/include/asm-generic/io.h
 create mode 100644 tools/include/asm/io.h

diff --git a/tools/include/asm-generic/io.h b/tools/include/asm-generic/io.h
new file mode 100644
index 000000000000..e5a0b07ad452
--- /dev/null
+++ b/tools/include/asm-generic/io.h
@@ -0,0 +1,482 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_ASM_GENERIC_IO_H
+#define _TOOLS_ASM_GENERIC_IO_H
+
+#include <asm/barrier.h>
+#include <asm/byteorder.h>
+
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#ifndef mmiowb_set_pending
+#define mmiowb_set_pending() do { } while (0)
+#endif
+
+#ifndef __io_br
+#define __io_br()      barrier()
+#endif
+
+/* prevent prefetching of coherent DMA data ahead of a dma-complete */
+#ifndef __io_ar
+#ifdef rmb
+#define __io_ar(v)      rmb()
+#else
+#define __io_ar(v)      barrier()
+#endif
+#endif
+
+/* flush writes to coherent DMA data before possibly triggering a DMA read */
+#ifndef __io_bw
+#ifdef wmb
+#define __io_bw()      wmb()
+#else
+#define __io_bw()      barrier()
+#endif
+#endif
+
+/* serialize device access against a spin_unlock, usually handled there. */
+#ifndef __io_aw
+#define __io_aw()      mmiowb_set_pending()
+#endif
+
+#ifndef __io_pbw
+#define __io_pbw()     __io_bw()
+#endif
+
+#ifndef __io_paw
+#define __io_paw()     __io_aw()
+#endif
+
+#ifndef __io_pbr
+#define __io_pbr()     __io_br()
+#endif
+
+#ifndef __io_par
+#define __io_par(v)     __io_ar(v)
+#endif
+
+#ifndef _THIS_IP_
+#define _THIS_IP_ 0
+#endif
+
+static inline void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
+				  unsigned long caller_addr, unsigned long caller_addr0) {}
+static inline void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
+				       unsigned long caller_addr, unsigned long caller_addr0) {}
+static inline void log_read_mmio(u8 width, const volatile void __iomem *addr,
+				 unsigned long caller_addr, unsigned long caller_addr0) {}
+static inline void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
+				      unsigned long caller_addr, unsigned long caller_addr0) {}
+
+/*
+ * __raw_{read,write}{b,w,l,q}() access memory in native endianness.
+ *
+ * On some architectures memory mapped IO needs to be accessed differently.
+ * On the simple architectures, we just read/write the memory location
+ * directly.
+ */
+
+#ifndef __raw_readb
+#define __raw_readb __raw_readb
+static inline u8 __raw_readb(const volatile void __iomem *addr)
+{
+	return *(const volatile u8 __force *)addr;
+}
+#endif
+
+#ifndef __raw_readw
+#define __raw_readw __raw_readw
+static inline u16 __raw_readw(const volatile void __iomem *addr)
+{
+	return *(const volatile u16 __force *)addr;
+}
+#endif
+
+#ifndef __raw_readl
+#define __raw_readl __raw_readl
+static inline u32 __raw_readl(const volatile void __iomem *addr)
+{
+	return *(const volatile u32 __force *)addr;
+}
+#endif
+
+#ifndef __raw_readq
+#define __raw_readq __raw_readq
+static inline u64 __raw_readq(const volatile void __iomem *addr)
+{
+	return *(const volatile u64 __force *)addr;
+}
+#endif
+
+#ifndef __raw_writeb
+#define __raw_writeb __raw_writeb
+static inline void __raw_writeb(u8 value, volatile void __iomem *addr)
+{
+	*(volatile u8 __force *)addr = value;
+}
+#endif
+
+#ifndef __raw_writew
+#define __raw_writew __raw_writew
+static inline void __raw_writew(u16 value, volatile void __iomem *addr)
+{
+	*(volatile u16 __force *)addr = value;
+}
+#endif
+
+#ifndef __raw_writel
+#define __raw_writel __raw_writel
+static inline void __raw_writel(u32 value, volatile void __iomem *addr)
+{
+	*(volatile u32 __force *)addr = value;
+}
+#endif
+
+#ifndef __raw_writeq
+#define __raw_writeq __raw_writeq
+static inline void __raw_writeq(u64 value, volatile void __iomem *addr)
+{
+	*(volatile u64 __force *)addr = value;
+}
+#endif
+
+/*
+ * {read,write}{b,w,l,q}() access little endian memory and return result in
+ * native endianness.
+ */
+
+#ifndef readb
+#define readb readb
+static inline u8 readb(const volatile void __iomem *addr)
+{
+	u8 val;
+
+	log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
+	__io_br();
+	val = __raw_readb(addr);
+	__io_ar(val);
+	log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+
+#ifndef readw
+#define readw readw
+static inline u16 readw(const volatile void __iomem *addr)
+{
+	u16 val;
+
+	log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
+	__io_br();
+	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
+	__io_ar(val);
+	log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+
+#ifndef readl
+#define readl readl
+static inline u32 readl(const volatile void __iomem *addr)
+{
+	u32 val;
+
+	log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
+	__io_br();
+	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
+	__io_ar(val);
+	log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+
+#ifndef readq
+#define readq readq
+static inline u64 readq(const volatile void __iomem *addr)
+{
+	u64 val;
+
+	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
+	__io_br();
+	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
+	__io_ar(val);
+	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+
+#ifndef writeb
+#define writeb writeb
+static inline void writeb(u8 value, volatile void __iomem *addr)
+{
+	log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
+	__io_bw();
+	__raw_writeb(value, addr);
+	__io_aw();
+	log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+
+#ifndef writew
+#define writew writew
+static inline void writew(u16 value, volatile void __iomem *addr)
+{
+	log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+	__io_bw();
+	__raw_writew((u16 __force)cpu_to_le16(value), addr);
+	__io_aw();
+	log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+
+#ifndef writel
+#define writel writel
+static inline void writel(u32 value, volatile void __iomem *addr)
+{
+	log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+	__io_bw();
+	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
+	__io_aw();
+	log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+
+#ifndef writeq
+#define writeq writeq
+static inline void writeq(u64 value, volatile void __iomem *addr)
+{
+	log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+	__io_bw();
+	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
+	__io_aw();
+	log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+
+/*
+ * {read,write}{b,w,l,q}_relaxed() are like the regular version, but
+ * are not guaranteed to provide ordering against spinlocks or memory
+ * accesses.
+ */
+#ifndef readb_relaxed
+#define readb_relaxed readb_relaxed
+static inline u8 readb_relaxed(const volatile void __iomem *addr)
+{
+	u8 val;
+
+	log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
+	val = __raw_readb(addr);
+	log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+
+#ifndef readw_relaxed
+#define readw_relaxed readw_relaxed
+static inline u16 readw_relaxed(const volatile void __iomem *addr)
+{
+	u16 val;
+
+	log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
+	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
+	log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+
+#ifndef readl_relaxed
+#define readl_relaxed readl_relaxed
+static inline u32 readl_relaxed(const volatile void __iomem *addr)
+{
+	u32 val;
+
+	log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
+	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
+	log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+
+#if defined(readq) && !defined(readq_relaxed)
+#define readq_relaxed readq_relaxed
+static inline u64 readq_relaxed(const volatile void __iomem *addr)
+{
+	u64 val;
+
+	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
+	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
+	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+
+#ifndef writeb_relaxed
+#define writeb_relaxed writeb_relaxed
+static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
+{
+	log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
+	__raw_writeb(value, addr);
+	log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+
+#ifndef writew_relaxed
+#define writew_relaxed writew_relaxed
+static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
+{
+	log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+	__raw_writew((u16 __force)cpu_to_le16(value), addr);
+	log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+
+#ifndef writel_relaxed
+#define writel_relaxed writel_relaxed
+static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
+{
+	log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
+	log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+
+#if defined(writeq) && !defined(writeq_relaxed)
+#define writeq_relaxed writeq_relaxed
+static inline void writeq_relaxed(u64 value, volatile void __iomem *addr)
+{
+	log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
+	log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+
+/*
+ * {read,write}s{b,w,l,q}() repeatedly access the same memory address in
+ * native endianness in 8-, 16-, 32- or 64-bit chunks (@count times).
+ */
+#ifndef readsb
+#define readsb readsb
+static inline void readsb(const volatile void __iomem *addr, void *buffer,
+			  unsigned int count)
+{
+	if (count) {
+		u8 *buf = buffer;
+
+		do {
+			u8 x = __raw_readb(addr);
+			*buf++ = x;
+		} while (--count);
+	}
+}
+#endif
+
+#ifndef readsw
+#define readsw readsw
+static inline void readsw(const volatile void __iomem *addr, void *buffer,
+			  unsigned int count)
+{
+	if (count) {
+		u16 *buf = buffer;
+
+		do {
+			u16 x = __raw_readw(addr);
+			*buf++ = x;
+		} while (--count);
+	}
+}
+#endif
+
+#ifndef readsl
+#define readsl readsl
+static inline void readsl(const volatile void __iomem *addr, void *buffer,
+			  unsigned int count)
+{
+	if (count) {
+		u32 *buf = buffer;
+
+		do {
+			u32 x = __raw_readl(addr);
+			*buf++ = x;
+		} while (--count);
+	}
+}
+#endif
+
+#ifndef readsq
+#define readsq readsq
+static inline void readsq(const volatile void __iomem *addr, void *buffer,
+			  unsigned int count)
+{
+	if (count) {
+		u64 *buf = buffer;
+
+		do {
+			u64 x = __raw_readq(addr);
+			*buf++ = x;
+		} while (--count);
+	}
+}
+#endif
+
+#ifndef writesb
+#define writesb writesb
+static inline void writesb(volatile void __iomem *addr, const void *buffer,
+			   unsigned int count)
+{
+	if (count) {
+		const u8 *buf = buffer;
+
+		do {
+			__raw_writeb(*buf++, addr);
+		} while (--count);
+	}
+}
+#endif
+
+#ifndef writesw
+#define writesw writesw
+static inline void writesw(volatile void __iomem *addr, const void *buffer,
+			   unsigned int count)
+{
+	if (count) {
+		const u16 *buf = buffer;
+
+		do {
+			__raw_writew(*buf++, addr);
+		} while (--count);
+	}
+}
+#endif
+
+#ifndef writesl
+#define writesl writesl
+static inline void writesl(volatile void __iomem *addr, const void *buffer,
+			   unsigned int count)
+{
+	if (count) {
+		const u32 *buf = buffer;
+
+		do {
+			__raw_writel(*buf++, addr);
+		} while (--count);
+	}
+}
+#endif
+
+#ifndef writesq
+#define writesq writesq
+static inline void writesq(volatile void __iomem *addr, const void *buffer,
+			   unsigned int count)
+{
+	if (count) {
+		const u64 *buf = buffer;
+
+		do {
+			__raw_writeq(*buf++, addr);
+		} while (--count);
+	}
+}
+#endif
+
+#endif /* _TOOLS_ASM_GENERIC_IO_H */
diff --git a/tools/include/asm/io.h b/tools/include/asm/io.h
new file mode 100644
index 000000000000..9ae219b12604
--- /dev/null
+++ b/tools/include/asm/io.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_ASM_IO_H
+#define _TOOLS_ASM_IO_H
+
+#include <asm-generic/io.h>
+
+#endif /* _TOOLS_ASM_IO_H */
diff --git a/tools/include/linux/io.h b/tools/include/linux/io.h
index e129871fe661..4b94b84160b8 100644
--- a/tools/include/linux/io.h
+++ b/tools/include/linux/io.h
@@ -2,4 +2,6 @@
 #ifndef _TOOLS_IO_H
 #define _TOOLS_IO_H
 
-#endif
+#include <asm/io.h>
+
+#endif /* _TOOLS_IO_H */
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


