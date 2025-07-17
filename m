Return-Path: <linux-kselftest+bounces-37531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF80B097AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30953189C92D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F946265637;
	Thu, 17 Jul 2025 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRbkjAx4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E7D2550D2;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794721; cv=none; b=Vegn0qUVsv6r/am/XJzSKogi3X2pTFsfBT/ahM4YsJF0oEGmlMQ6ruqQaWc4HsdvdprdpHpsu7WYPOM17xzqL8hyIIemddx2eoTalRc6FMSGCB6Fpgshg9UPDEuVo+hmYHZUeySztTgfL38n+gNI370sHCL7clKIe1JWu0W5VrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794721; c=relaxed/simple;
	bh=h6Zg7bnGhZLJl7gzBxEvRrK024ha+iznbtZZpACm6QM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgPnnKkvS0ON3RBMEX7B3dmwRbvf1y2NF7x2lsoKw3BxDkx+4aJzGiADZxbWXUvZHFq/D6OM9Jl8NhRpBCPKKDst5+xdgxZC6HsY0oBTWUFJGFINxIQLXJ2I8hT4iCP6l3Bd0J2Vun4vq9tSBGrrzROG2IprCXEhmpMavsdYYBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRbkjAx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B01FC116D0;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794720;
	bh=h6Zg7bnGhZLJl7gzBxEvRrK024ha+iznbtZZpACm6QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRbkjAx4agQoaNgy3gLSJriPgyOo5ZCrhh3RqY0GC546jkLVEZccPCSzF8ie7fy6u
	 kWfBerRtRzKtuY8tBoSJzz6wpe622Laedp++mPG1+CmC7M1OekiauZqbXDoIfrxwaa
	 qPbCsHOLWtVOn1W7v9sgTGhxFMBGtrfzn5esRTca8flZAjwNRqLlO5gTyJQnSWnfg+
	 WJcneUc8gjGzKRoq1g/v/b3UtHPiOO7ErykuiiNNVtdCQC5nlDPHQyvn5pzubaO4HM
	 NPazOkyKiCZdmzeC3mefEGu+PJePhSvFG4uHATZJqL96ZZJo3iwGb5u8caANyBnlSk
	 FEC4bFEVGFelQ==
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
	Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
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
Subject: [PATCH v3 04/13] x86: Handle KCOV __init vs inline mismatches
Date: Thu, 17 Jul 2025 16:25:09 -0700
Message-Id: <20250717232519.2984886-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717231756.make.423-kees@kernel.org>
References: <20250717231756.make.423-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7379; i=kees@kernel.org; h=from:subject; bh=h6Zg7bnGhZLJl7gzBxEvRrK024ha+iznbtZZpACm6QM=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmVbVEsBUWRs14v3rd2ZcSn8mMh7T+55X5XTfK6NfVtU nnon9hnHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPx6WT4n2zhIJZwQbqtV2mf gj9/g5L3r9WHjHc+Olf9QXTtxJXKZYwMuypdt881O3ZGS1GRa0Flo/olSxb117FqYnc5ylXOiL1 mAwA=
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
 arch/x86/include/asm/acpi.h     | 4 ++--
 arch/x86/include/asm/realmode.h | 2 +-
 include/linux/acpi.h            | 4 ++--
 include/linux/bootconfig.h      | 2 +-
 include/linux/efi.h             | 2 +-
 include/linux/memblock.h        | 2 +-
 include/linux/smp.h             | 2 +-
 arch/x86/kernel/kvm.c           | 2 +-
 arch/x86/mm/init_64.c           | 2 +-
 kernel/kexec_handover.c         | 4 ++--
 10 files changed, 13 insertions(+), 13 deletions(-)

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
index 71e692f95290..1c5bb1e887cd 100644
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
diff --git a/include/linux/smp.h b/include/linux/smp.h
index bea8d2826e09..18e9c918325e 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -221,7 +221,7 @@ static inline void wake_up_all_idle_cpus(void) {  }
 
 #ifdef CONFIG_UP_LATE_INIT
 extern void __init up_late_init(void);
-static inline void smp_init(void) { up_late_init(); }
+static __always_inline void smp_init(void) { up_late_init(); }
 #else
 static inline void smp_init(void) { }
 #endif
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 921c1c783bc1..8ae750cde0c6 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -420,7 +420,7 @@ static u64 kvm_steal_clock(int cpu)
 	return steal;
 }
 
-static inline void __set_percpu_decrypted(void *ptr, unsigned long size)
+static inline __init void __set_percpu_decrypted(void *ptr, unsigned long size)
 {
 	early_set_memory_decrypted((unsigned long) ptr, size);
 }
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index fdb6cab524f0..76e33bd7c556 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -805,7 +805,7 @@ kernel_physical_mapping_change(unsigned long paddr_start,
 }
 
 #ifndef CONFIG_NUMA
-static inline void x86_numa_init(void)
+static __always_inline void x86_numa_init(void)
 {
 	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
 }
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 49634cc3fb43..e49743ae52c5 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -310,8 +310,8 @@ static int kho_mem_serialize(struct kho_serialization *ser)
 	return -ENOMEM;
 }
 
-static void deserialize_bitmap(unsigned int order,
-			       struct khoser_mem_bitmap_ptr *elm)
+static void __init deserialize_bitmap(unsigned int order,
+				      struct khoser_mem_bitmap_ptr *elm)
 {
 	struct kho_mem_phys_bits *bitmap = KHOSER_LOAD_PTR(elm->bitmap);
 	unsigned long bit;
-- 
2.34.1


