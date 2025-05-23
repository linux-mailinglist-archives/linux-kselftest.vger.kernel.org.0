Return-Path: <linux-kselftest+bounces-33566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4D5AC1B36
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 06:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5381BA7F9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 04:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EC4254B1F;
	Fri, 23 May 2025 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rj3s+e3m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF76324E4C6;
	Fri, 23 May 2025 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747975181; cv=none; b=OfOfZmfJXazlLwWWO05oWMJCS3jRW1QyVGAF/P/Oco9HcD8GXZumlYGzTGx4thv8BE8OtzjPlshYLZ+oC1XzvGkJ5AR5Q6pJwLWLw32Ovij9cetRkWNdepitLQBWjQ9CgQHFgO4WNe48Xj5rQKK9kGSvEFBg6y6QABSJbZL5LOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747975181; c=relaxed/simple;
	bh=NLp+yNLHFbt0GV+WqSgZP5Jpw7SgnlmemsBZjPqNKQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqJJ+zrUyRiEmYRLkkQBqTTSwHJ+1+p6epCc0In4xElz/ElQNFFhkZXw3zB9AeLPxLC1GipZLbcf8Mz/U7pTpOA1uc2Q0pZjS16YLScM8pHLtHI9Y5mGoCeQ6Elu2L8G9CUiaz3XM4PKBBrMEkCwgMGj5Z2TOvcQHfEuci9/+AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rj3s+e3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3635CC4CEE9;
	Fri, 23 May 2025 04:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747975181;
	bh=NLp+yNLHFbt0GV+WqSgZP5Jpw7SgnlmemsBZjPqNKQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rj3s+e3mE3W4aIysRoKZFNxm9vD2ek1huWH4Vn0crUEGAbKJwFulKN6m0+LDN4Aln
	 XTkNK1mH9zOlLXf7FFTGL9Hc+gsp/JQpJfgx+hC9w/yyjXWfEJNgzqLEzNQyzv+LTn
	 oxehudMtjyuOgnOccQomiSSYSAM9uLxKgYHBMJU1Q7fkn2wwOX0bCFGYNM0HOdfsYr
	 cl0BaSwZwFwDWjrVNBwZrOcsmN8ydAPwT5gU9Sl36aB8F4iIIh+L32zFmkZiZNG8WE
	 /xdL3qIg2hbWBC7ZuHTze9Sty41eTTtKnbIn8L1FWsb+X57lFIMyIVNqg/L9Oi12EV
	 CBe9AnINRA1vA==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Juergen Gross <jgross@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Roger Pau Monne <roger.pau@citrix.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Usama Arif <usama.arif@bytedance.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Huth <thuth@redhat.com>,
	Brian Gerst <brgerst@gmail.com>,
	kvm@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-mm@kvack.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 04/14] x86: Handle KCOV __init vs inline mismatches
Date: Thu, 22 May 2025 21:39:14 -0700
Message-Id: <20250523043935.2009972-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523043251.it.550-kees@kernel.org>
References: <20250523043251.it.550-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6526; i=kees@kernel.org; h=from:subject; bh=NLp+yNLHFbt0GV+WqSgZP5Jpw7SgnlmemsBZjPqNKQ0=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn6v3/M6Lj0TL3UZvEPryO2U1XiwmeUWRnm7Ltu8Tv7T fejWHWxjhIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIncPMDIMF2RL/S7vLKpfM2M t8x3m+UdDqwvS9xyTbb4p4asf8qChQw/nnGmzL67VZLb8E8Q7+r/36asCDud1Su0ufrUxFOvRAJ YAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When KCOV is enabled all functions get instrumented, unless the
__no_sanitize_coverage attribute is used. To prepare for
__no_sanitize_coverage being applied to __init functions, we have to
handle differences in how GCC's inline optimizations get resolved. For
x86 this means forcing several functions to be inline with
__always_inline.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <x86@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Michal Wilczynski <michal.wilczynski@intel.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Roger Pau Monne <roger.pau@citrix.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Usama Arif <usama.arif@bytedance.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: <kvm@vger.kernel.org>
Cc: <ibm-acpi-devel@lists.sourceforge.net>
Cc: <platform-driver-x86@vger.kernel.org>
Cc: <linux-acpi@vger.kernel.org>
Cc: <linux-trace-kernel@vger.kernel.org>
Cc: <linux-efi@vger.kernel.org>
Cc: <linux-mm@kvack.org>
---
 arch/x86/include/asm/acpi.h          | 4 ++--
 arch/x86/include/asm/realmode.h      | 2 +-
 include/linux/acpi.h                 | 4 ++--
 include/linux/bootconfig.h           | 2 +-
 include/linux/efi.h                  | 2 +-
 include/linux/memblock.h             | 2 +-
 arch/x86/kernel/kvm.c                | 2 +-
 drivers/platform/x86/thinkpad_acpi.c | 4 ++--
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 5ab1a4598d00..a03aa6f999d1 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -158,13 +158,13 @@ static inline bool acpi_has_cpu_in_madt(void)
 }
 
 #define ACPI_HAVE_ARCH_SET_ROOT_POINTER
-static inline void acpi_arch_set_root_pointer(u64 addr)
+static __always_inline void acpi_arch_set_root_pointer(u64 addr)
 {
 	x86_init.acpi.set_root_pointer(addr);
 }
 
 #define ACPI_HAVE_ARCH_GET_ROOT_POINTER
-static inline u64 acpi_arch_get_root_pointer(void)
+static __always_inline u64 acpi_arch_get_root_pointer(void)
 {
 	return x86_init.acpi.get_root_pointer();
 }
diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index f607081a022a..e406a1e92c63 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -78,7 +78,7 @@ extern unsigned char secondary_startup_64[];
 extern unsigned char secondary_startup_64_no_verify[];
 #endif
 
-static inline size_t real_mode_size_needed(void)
+static __always_inline size_t real_mode_size_needed(void)
 {
 	if (real_mode_header)
 		return 0;	/* already allocated. */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e72100c0684f..ae76c8915000 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -759,13 +759,13 @@ int acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem, int *timer_count)
 #endif
 
 #ifndef ACPI_HAVE_ARCH_SET_ROOT_POINTER
-static inline void acpi_arch_set_root_pointer(u64 addr)
+static __always_inline void acpi_arch_set_root_pointer(u64 addr)
 {
 }
 #endif
 
 #ifndef ACPI_HAVE_ARCH_GET_ROOT_POINTER
-static inline u64 acpi_arch_get_root_pointer(void)
+static __always_inline u64 acpi_arch_get_root_pointer(void)
 {
 	return 0;
 }
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 3f4b4ac527ca..25df9260d206 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -290,7 +290,7 @@ int __init xbc_get_info(int *node_size, size_t *data_size);
 /* XBC cleanup data structures */
 void __init _xbc_exit(bool early);
 
-static inline void xbc_exit(void)
+static __always_inline void xbc_exit(void)
 {
 	_xbc_exit(false);
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7d63d1d75f22..e3776d9cad07 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1334,7 +1334,7 @@ struct linux_efi_initrd {
 
 bool xen_efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table);
 
-static inline
+static __always_inline
 bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 {
 	if (!IS_ENABLED(CONFIG_XEN_EFI))
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index bb19a2534224..b96746376e17 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -463,7 +463,7 @@ static inline void *memblock_alloc_raw(phys_addr_t size,
 					  NUMA_NO_NODE);
 }
 
-static inline void *memblock_alloc_from(phys_addr_t size,
+static __always_inline void *memblock_alloc_from(phys_addr_t size,
 						phys_addr_t align,
 						phys_addr_t min_addr)
 {
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 921c1c783bc1..72f13d643fca 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -420,7 +420,7 @@ static u64 kvm_steal_clock(int cpu)
 	return steal;
 }
 
-static inline void __set_percpu_decrypted(void *ptr, unsigned long size)
+static __always_inline void __set_percpu_decrypted(void *ptr, unsigned long size)
 {
 	early_set_memory_decrypted((unsigned long) ptr, size);
 }
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index e7350c9fa3aa..0518d5b1f4ec 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -559,12 +559,12 @@ static unsigned long __init tpacpi_check_quirks(
 	return 0;
 }
 
-static inline bool __pure __init tpacpi_is_lenovo(void)
+static __always_inline bool __pure tpacpi_is_lenovo(void)
 {
 	return thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO;
 }
 
-static inline bool __pure __init tpacpi_is_ibm(void)
+static __always_inline bool __pure tpacpi_is_ibm(void)
 {
 	return thinkpad_id.vendor == PCI_VENDOR_ID_IBM;
 }
-- 
2.34.1


