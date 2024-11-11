Return-Path: <linux-kselftest+bounces-21800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAD39C4736
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 21:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412A81F22F1C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 20:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9021BCA05;
	Mon, 11 Nov 2024 20:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yUwopGo7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247C01BBBF8
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358441; cv=none; b=QOX7G4l8VLOUfkl1JD2IKPuy3l4j+DaIU9KSEBZ7+BC/Yy0IkroZv9FRBDT9pEnSWvgvdFeXe5PUfr1Eop3ry920o+vv56l3Y5Rh8BOFEKc4YQ5oL3BZBlwxA5S5bb0pKy36Waqvm0J280JTQww39s3NLYmOmJywjgi09JH4d5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358441; c=relaxed/simple;
	bh=TpLvserod6k2ZU4j2c+tB5t0JSCdEx8bDMlrfpUJajM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bDOAevw4wwMotIJHQku4/KPR2a4yjmlj5YZWzkPTQu3d/Bi3Wj+e/odgFdhUs9dXRDtfsfiLSJDxuFhqznCWpRSeN4W23zZImGnoocjhririfMn8wpEc1UqgXc+jg29ScshUZ7+NP3d/flAa2aC+xSvyAHjhs4IucrSRDOia7V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yUwopGo7; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7f43259d220so2411527a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 12:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731358439; x=1731963239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/atH3Dmc2hDWuHIRnNBwkfWUhbP1w3P23HyX8egA5iY=;
        b=yUwopGo76VEpd7GwdNAc16uBff/FyW7WHAm6VtZMK9+QFOoGdSmTcIhne9H9tS/s7i
         fUyH9lMuivkmBi1R6vKlGcTZ8wXni04o95szmNNjmrVxPWj9LoqfzdT2lSToN8Epi30x
         Y+4hwnvVbAXkC9ILTg1R2h281QsvtNoY44W7K0ZId7h+D3eLPHf6tluw7vfgg/gykSbr
         iWSL9eet94LLcfmTBGFXg4tFlKjGLvBkbwjtZv8CKlzKqoDtG4fBwf9aPNsLbREJIFkg
         aG9HV/ZRPs9HrD5Q5ZitEHjIOszE0E3nGwNbFVA8iWnNLDHdTcsek/0GwUYNKOeqHIBM
         Cf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358439; x=1731963239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/atH3Dmc2hDWuHIRnNBwkfWUhbP1w3P23HyX8egA5iY=;
        b=GmlcXSc0fbmEmfe14E3P5oTdUFTlX+ONF0lHsWc5ij5p/9NdgLIm58jolfEjNKeQP+
         c+Agh1VUoEloVNfzlJ4A+8q8UrhxbBd9mjco0WXbzIPm590P1CLaxBcn9033zfIU/W5U
         CCSXfcTPyfoWcUAniN/r/OUoSLrg/ayaVM7nbWwRJkB+M2EuoRSXXLPOzcocOf+k9v0+
         uFHO3kNR5FwDy2UfBgr+zEEtm3ArzscdglihtBI3odDUapkyDDoMlQ3XoiqjJa+ig1ee
         /WTZ3kFZ72egGlfZ/8UlgV2ycfxYFEm/LMcP7AVDzGKzEv5zblDeWD7/i4BhKfVZfXzj
         ZoqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkwkCH3/eHGrDTHGCocO4ywdPOLGNtIgwql/Vt+Uszl+eaGEqBa+r1PrU6779RM6TQAcf2ZPnmp+d36iKg27c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGP+wWAa7KieVCofiuMTvF0CvOga70j2/hL2RAnA5gw7AY+hZW
	jZ6RpULLkBT5O36KIZoRjt28kUYnNsH0WD29zExzWXA58BVP/hOOC7EZGzB1nFQ=
X-Google-Smtp-Source: AGHT+IEvbaDX9G6RBqut4iScbl/I53KZSOyAqnYCopkb1nPpVHZJcEx6PnWjjFsFphBR/XrDfiSPvQ==
X-Received: by 2002:a17:90b:2e07:b0:2e2:bd32:f60 with SMTP id 98e67ed59e1d1-2e9b1780a4bmr18569491a91.32.1731358439483;
        Mon, 11 Nov 2024 12:53:59 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1534sm9059974a91.42.2024.11.11.12.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:53:59 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 11 Nov 2024 12:53:47 -0800
Subject: [PATCH v8 02/29] mm: helper `is_shadow_stack_vma` to check shadow
 stack vma
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-v5_user_cfi_series-v8-2-dce14aa30207@rivosinc.com>
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
In-Reply-To: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack
VMA on three architectures (x86 shadow stack, arm GCS and RISC-V shadow
stack). In case architecture doesn't implement shadow stack, it's VM_NONE
Introducing a helper `is_shadow_stack_vma` to determine shadow stack vma
or not.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 mm/gup.c  |  2 +-
 mm/mmap.c |  2 +-
 mm/vma.h  | 10 +++++++---
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a82890b46a36..8e6e14179f6c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1282,7 +1282,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		    !writable_file_mapping_allowed(vma, gup_flags))
 			return -EFAULT;
 
-		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
+		if (!(vm_flags & VM_WRITE) || is_shadow_stack_vma(vm_flags)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
diff --git a/mm/mmap.c b/mm/mmap.c
index 9c0fb43064b5..f17573469c42 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -708,7 +708,7 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
  */
 static inline unsigned long stack_guard_placement(vm_flags_t vm_flags)
 {
-	if (vm_flags & VM_SHADOW_STACK)
+	if (is_shadow_stack_vma(vm_flags))
 		return PAGE_SIZE;
 
 	return 0;
diff --git a/mm/vma.h b/mm/vma.h
index 819f994cf727..0f238dc37231 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -357,7 +357,7 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
 }
 
 /*
- * These three helpers classifies VMAs for virtual memory accounting.
+ * These four helpers classifies VMAs for virtual memory accounting.
  */
 
 /*
@@ -368,6 +368,11 @@ static inline bool is_exec_mapping(vm_flags_t flags)
 	return (flags & (VM_EXEC | VM_WRITE | VM_STACK)) == VM_EXEC;
 }
 
+static inline bool is_shadow_stack_vma(vm_flags_t vm_flags)
+{
+	return !!(vm_flags & VM_SHADOW_STACK);
+}
+
 /*
  * Stack area (including shadow stacks)
  *
@@ -376,7 +381,7 @@ static inline bool is_exec_mapping(vm_flags_t flags)
  */
 static inline bool is_stack_mapping(vm_flags_t flags)
 {
-	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
+	return ((flags & VM_STACK) == VM_STACK) || is_shadow_stack_vma(flags);
 }
 
 /*
@@ -387,7 +392,6 @@ static inline bool is_data_mapping(vm_flags_t flags)
 	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE;
 }
 
-
 static inline void vma_iter_config(struct vma_iterator *vmi,
 		unsigned long index, unsigned long last)
 {

-- 
2.45.0


