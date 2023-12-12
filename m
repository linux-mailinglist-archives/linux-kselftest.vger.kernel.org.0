Return-Path: <linux-kselftest+bounces-1761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBFD80FB28
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 00:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6D6B21011
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 23:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E407964718;
	Tue, 12 Dec 2023 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UVi8MmUb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43991CE
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 15:17:17 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d0bcc0c313so35636675ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 15:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702423037; x=1703027837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0KleV6o3T8VwIpW2LkN+EL0QO50pQ5bkLoTJyBRonk=;
        b=UVi8MmUbHi0kNmSZ3GTDUM9D8DkaJTGkCEL2dbPQ0c2m9U/F/dZ2Sd89oztK1KW+OS
         SmE11kWukVcJXlgVH1mBBwmpD/8kX8qTm4YzCAl427EblT8kfxN4p3Uv3JVke1Ygzvr0
         y9MnTZdXv61odrB09tA71ICC7wjyNSI2bDRq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423037; x=1703027837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0KleV6o3T8VwIpW2LkN+EL0QO50pQ5bkLoTJyBRonk=;
        b=Ts/yAN4YxA9JdnCUskgJVgvevlUJoFlcpfw6DmZXnWRUGHnqHSkfoGOngMK0pXhn85
         IExcFPwKitkn2kzkQusH2/YXEo/WD30UY/peA+OslEGAHbdBEV5FJnUoyTlm1kKs6XwM
         kpOsu5qB4cP9t49Y/GmybFfA8f7XZAoIIPlduegclhrFQxIwlYB6O1AGr5BScmsWtHsJ
         Nk/Bb5dxT3hV8PIUxWqRRP2gW+AVWYXs0csdMWbXCg0vSKXGBSDioxwoyvY/P9MJvWKf
         zp25jw3Bd7L/81bdT52FJX7cZUuoUi3sP9WnkFG0OlFRo3IrO0TgPhbdr39lcylsc/0O
         0jjA==
X-Gm-Message-State: AOJu0Yw6oSYtL3+3CUPfR6pIlfw/7gCGFKPbj3a2Z5ShlUZiZKhP8+5U
	uygzdgBZPzrK22uMX8GD3tqdEOJ74lw3WSo9nRk=
X-Google-Smtp-Source: AGHT+IGxR0oJJr0EjsRByUJbUwGXJ3kDSLTggQ7aP2NMz7xXn0QhhIQ1l2eHY3b5MujUVGQNKRdT6g==
X-Received: by 2002:a17:902:d4d2:b0:1d3:4aab:194d with SMTP id o18-20020a170902d4d200b001d34aab194dmr281091plg.72.1702423036672;
        Tue, 12 Dec 2023 15:17:16 -0800 (PST)
Received: from localhost (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.gmail.com with UTF8SMTPSA id e1-20020a17090301c100b001d33e65b3cdsm1661489plh.112.2023.12.12.15.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 15:17:16 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pedro.falcato@gmail.com,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	deraadt@openbsd.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v3 06/11] mseal: add sealing support for mmap
Date: Tue, 12 Dec 2023 23:17:00 +0000
Message-ID: <20231212231706.2680890-7-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231212231706.2680890-1-jeffxu@chromium.org>
References: <20231212231706.2680890-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Allow mmap() to set the sealing type when creating a mapping. This is
useful for optimization because it avoids having to make two system
calls: one for mmap() and one for mseal(). With this change, mmap()
can take an input that specifies the sealing type, so only one system
call is needed.

This patch uses the "prot" field of mmap() to set the sealing.
Three sealing types are added to match with MM_SEAL_xyz in mseal().
PROT_SEAL_SEAL
PROT_SEAL_BASE
PROT_SEAL_PROT_PKEY

We also thought about using MAP_SEAL_xyz, which is a field in the
mmap() function called "flags". However, this field is more about the
type of mapping, such as MAP_FIXED_NOREPLACE. The "prot" field seems
more appropriate for our case.

It's worth noting that even though the sealing type is set via the
"prot" field in mmap(), we don't require it to be set in the "prot"
field in later mprotect() call. This is unlike the PROT_READ,
PROT_WRITE, PROT_EXEC bits, e.g. if PROT_WRITE is not set in
mprotect(), it means that the region is not writable. In other words,
if you set PROT_SEAL_PROT_PKEY in mmap(), you don't need to set it in
mprotect(). In fact, with the current approach, mseal() is used to set
sealing on existing VMA.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Suggested-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 arch/mips/kernel/vdso.c                | 10 +++-
 include/linux/mm.h                     | 63 +++++++++++++++++++++++++-
 include/uapi/asm-generic/mman-common.h | 13 ++++++
 mm/mmap.c                              | 25 ++++++++--
 4 files changed, 105 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index f6d40e43f108..6d1103d36af1 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -98,11 +98,17 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		return -EINTR;
 
 	if (IS_ENABLED(CONFIG_MIPS_FP_SUPPORT)) {
-		/* Map delay slot emulation page */
+		/*
+		 * Map delay slot emulation page.
+		 *
+		 * Note: passing vm_seals = 0
+		 * Don't support sealing for vdso for now.
+		 * This might change when we add sealing support for vdso.
+		 */
 		base = mmap_region(NULL, STACK_TOP, PAGE_SIZE,
 				VM_READ | VM_EXEC |
 				VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
-				0, NULL);
+				0, NULL, 0);
 		if (IS_ERR_VALUE(base)) {
 			ret = base;
 			goto out;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2435acc1f44f..5d3ee79f1438 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -266,6 +266,15 @@ extern unsigned int kobjsize(const void *objp);
 	MM_SEAL_BASE | \
 	MM_SEAL_PROT_PKEY)
 
+/*
+ * PROT_SEAL_ALL is all supported flags in mmap().
+ * See include/uapi/asm-generic/mman-common.h.
+ */
+#define PROT_SEAL_ALL ( \
+	PROT_SEAL_SEAL | \
+	PROT_SEAL_BASE | \
+	PROT_SEAL_PROT_PKEY)
+
 /*
  * vm_flags in vm_area_struct, see mm_types.h.
  * When changing, update also include/trace/events/mmflags.h.
@@ -3290,7 +3299,7 @@ extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned lo
 
 extern unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-	struct list_head *uf);
+	struct list_head *uf, unsigned long vm_seals);
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
@@ -3339,12 +3348,47 @@ static inline unsigned long vma_seals(struct vm_area_struct *vma)
 	return (vma->vm_seals & MM_SEAL_ALL);
 }
 
+static inline void update_vma_seals(struct vm_area_struct *vma, unsigned long vm_seals)
+{
+	vma->vm_seals |= vm_seals;
+}
+
 extern bool can_modify_mm(struct mm_struct *mm, unsigned long start,
 		unsigned long end, unsigned long checkSeals);
 
 extern bool can_modify_vma(struct vm_area_struct *vma,
 		unsigned long checkSeals);
 
+/*
+ * Convert prot field of mmap to vm_seals type.
+ */
+static inline unsigned long convert_mmap_seals(unsigned long prot)
+{
+	unsigned long seals = 0;
+
+	/*
+	 * set SEAL_PROT_PKEY implies SEAL_BASE.
+	 */
+	if (prot & PROT_SEAL_PROT_PKEY)
+		prot |= PROT_SEAL_BASE;
+
+	/*
+	 * The seal bits start from bit 26 of the "prot" field of mmap.
+	 * see comments in include/uapi/asm-generic/mman-common.h.
+	 */
+	seals = (prot & PROT_SEAL_ALL) >> PROT_SEAL_BIT_BEGIN;
+	return seals;
+}
+
+/*
+ * check input sealing type from the "prot" field of mmap().
+ * for CONFIG_MSEAL case, this always return 0 (successful).
+ */
+static inline int check_mmap_seals(unsigned long prot, unsigned long *vm_seals)
+{
+	*vm_seals = convert_mmap_seals(prot);
+	return 0;
+}
 #else
 static inline bool check_vma_seals_mergeable(unsigned long vm_seals1)
 {
@@ -3367,6 +3411,23 @@ static inline bool can_modify_vma(struct vm_area_struct *vma,
 {
 	return true;
 }
+
+static inline void update_vma_seals(struct vm_area_struct *vma, unsigned long vm_seals)
+{
+}
+
+/*
+ * check input sealing type from the "prot" field of mmap().
+ * For not CONFIG_MSEAL, if SEAL flag is set, it will return failure.
+ */
+static inline int check_mmap_seals(unsigned long prot, unsigned long *vm_seals)
+{
+	if (prot & PROT_SEAL_ALL)
+		return -EINVAL;
+
+	return 0;
+}
+
 #endif
 
 /* These take the mm semaphore themselves */
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..f07ad9e70b3a 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -17,6 +17,19 @@
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
 
+/*
+ * The PROT_SEAL_XX defines memory sealings flags in the prot argument
+ * of mmap(). The bits currently take consecutive bits and match
+ * the same sequence as MM_SEAL_XX type, this allows convert_mmap_seals()
+ * to convert prot to MM_SEAL_XX type using bit operations.
+ * The include/uapi/linux/mman.h header file defines the MM_SEAL_XX type,
+ * which is used by the mseal() system call.
+ */
+#define PROT_SEAL_BIT_BEGIN	26
+#define PROT_SEAL_SEAL	_BITUL(PROT_SEAL_BIT_BEGIN)	/* 0x04000000 seal seal */
+#define PROT_SEAL_BASE	_BITUL(PROT_SEAL_BIT_BEGIN + 1)	/* 0x08000000 base for all sealing types */
+#define PROT_SEAL_PROT_PKEY	_BITUL(PROT_SEAL_BIT_BEGIN + 2)	/* 0x10000000 seal prot and pkey */
+
 /* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x0f		/* Mask for type of mapping */
 #define MAP_FIXED	0x10		/* Interpret addr exactly */
diff --git a/mm/mmap.c b/mm/mmap.c
index dbc557bd460c..3e1bf5a131b0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1211,6 +1211,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	int pkey = 0;
+	unsigned long vm_seals = 0;
 
 	*populate = 0;
 
@@ -1231,6 +1232,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (flags & MAP_FIXED_NOREPLACE)
 		flags |= MAP_FIXED;
 
+	if (check_mmap_seals(prot, &vm_seals) < 0)
+		return -EINVAL;
+
 	if (!(flags & MAP_FIXED))
 		addr = round_hint_to_min(addr);
 
@@ -1381,7 +1385,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_NORESERVE;
 	}
 
-	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf);
+	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf, vm_seals);
 	if (!IS_ERR_VALUE(addr) &&
 	    ((vm_flags & VM_LOCKED) ||
 	     (flags & (MAP_POPULATE | MAP_NONBLOCK)) == MAP_POPULATE))
@@ -2679,7 +2683,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 
 unsigned long mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
+		struct list_head *uf, unsigned long vm_seals)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
@@ -2723,7 +2727,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	next = vma_next(&vmi);
 	prev = vma_prev(&vmi);
-	if (vm_flags & VM_SPECIAL) {
+	/*
+	 * For now, sealed VMA doesn't merge with other VMA,
+	 * Will change this in later commit when we make sealed VMA
+	 * also mergeable.
+	 */
+	if ((vm_flags & VM_SPECIAL) ||
+		(vm_seals & MM_SEAL_ALL)) {
 		if (prev)
 			vma_iter_next_range(&vmi);
 		goto cannot_expand;
@@ -2781,6 +2791,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_page_prot = vm_get_page_prot(vm_flags);
 	vma->vm_pgoff = pgoff;
 
+	update_vma_seals(vma, vm_seals);
+
 	if (file) {
 		if (vm_flags & VM_SHARED) {
 			error = mapping_map_writable(file->f_mapping);
@@ -2992,6 +3004,13 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
 		return ret;
 
+	/*
+	 * Do not support sealing in remap_file_page.
+	 * sealing is set via mmap() and mseal().
+	 */
+	if (prot & PROT_SEAL_ALL)
+		return ret;
+
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-- 
2.43.0.472.g3155946c3a-goog


