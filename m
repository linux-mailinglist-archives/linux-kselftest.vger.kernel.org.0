Return-Path: <linux-kselftest+bounces-25747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23913A280AB
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 02:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34E9165A5D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 01:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD802228361;
	Wed,  5 Feb 2025 01:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="obkXaXrL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC1213220
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Feb 2025 01:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718517; cv=none; b=tYtgh8F3FYq+Vtjd8LPd30L1J/+b5kNqXeN1hbjXfKG57Pkq0FNvzn7WdBeIzlslIP/noDVm6nFeOn9LfSTxgc4KGf8LGASpBu3E8jQIVVGhKCYKJ2VLI9Jv5iRGiU/iuzm90FJD4jySy0V1udLApBlEwZfvHrh0xmQ28NwJ4wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718517; c=relaxed/simple;
	bh=4+rkxFDMRzeCaj67Ory62bJbPr1iEDQyQ7MtltlWZ10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PAJI2IZVb2y1AwYc+QPKHPuoqbocI0XrMKS2PJDpi1SRA62mVfY32dZhWWVPoDvyZ7W6AVFBbRTb9PK9PqEz/bNkg+bv8kgm7shr+Hwad2CnpFq4iEO2T2yP2RqIIaTxOqBAknso35INpvJ99BsVeuv2i7VP30/bZEZk6GzsAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=obkXaXrL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166651f752so26833985ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2025 17:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738718515; x=1739323315; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZsmyzkl0ZY8OELLzFzrWZpLBbmgmsnkcCCgL90vWsc=;
        b=obkXaXrL++C5CRCVKFH/z+QEE5m/c6elu2AJLYkjfyG31ufuk/40pv+W2Bpiu/IIqD
         x72oKtFNRt35wxLpU9gX2xOaBbvu4yVJBpGdDczYHXhLs8/AF7rHexxMX6mRsaXKepu/
         TpHdrL+ZxRdU8rveoaAaByFGf3t9LXS6d2U7i2XTNXJTD5sqC7QU4ocQ3uxaUYBdZ+7u
         Gd43OK0kh+1C/fBW1Ud/DrOafyYnwB3KvNQ22qNztlBF3YcVtFmjPkfzDZU3POvHtDMA
         b/iDjMGQL96sG+9ROf/N2Ax05qJLGH+ob1oDB69KrMajECf+ktZpgWeHbeUYcPTq7S72
         AzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738718515; x=1739323315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZsmyzkl0ZY8OELLzFzrWZpLBbmgmsnkcCCgL90vWsc=;
        b=LRm0W6wsmIPo7cBgBS9kdc6ilGyzKS4Kus/n/Fat0l8KLjN7CzaSpSQ1iNUO4Ze8HI
         3wHwMfkeZuH+QtaSyT3lXh/tJLdJ7K6HVeVqLglwnvW8k8jBz+6M+KFthCRGL2q07bRG
         geNPI6IIjb6SRgaorSNvG8J9NpSQgM26CgyHuzPW37w/BmdinYBxQdosdVhGpuQXZYL1
         W+cHkKHFFvhKooIRMxNdG9wXo5EIAteZ9TwHEHQb4s2pnoFc+roZuqkyufr600+JEYdW
         bP2UOGZnanKrycbtmp6VeaRyxG/sidX6c00uOOdyKLJM5a1DO9vJNGIgmBValTbM1SOA
         9Z7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWutP+zA1zxAjjsrwlpuYL34oAL+hb69U/4SB90gfZGWkGW8kaB1dA2W1RNxJOQQlko/Ybgnclo70H5Ght25es=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPhwBPJUynC/bBnTMYgGgp4ELqB8ltmF+77o4zF7v62vpL+cRa
	pMxuK19GCsDTQEWAxiVeuUZpK0HJ5+ZvDByYTIVWVoHd4E050boo9eofd0LVyJI=
X-Gm-Gg: ASbGncsAYkYynRvN6gON/CMaY/66lwnSwzGnNbD2UKsDxxix0wDFoCZHzQEA6Mkr2Jy
	OfueNO5keGduycrceo50n9pfsK22CpqMTPD/DlqaI/sjVy2s/KoIDajOfIdtN3qr6fY1SSnhhjO
	RdmLggNxZkqgI+XpWbt8CjqLikAY7BBSZhF61qVKyYyHF5czaFcAXB6RDS2LxzqrxSWFNL3DnyE
	75DWisqXyWnlQVuGKsx913QBv0I9Q+c6Tk4eAnM7UcZBKyM6CHON6B0NfvR5oRBYvjTyFj44/xa
	8kVnyX6tdDDXmuiLX84L/q/PTA==
X-Google-Smtp-Source: AGHT+IEGfToRmeKwtJLwJvQfR9G8FomtSd4VlGvn3V3djANNYRSyP8PCgL91KTN4ECR+cbbbSTicog==
X-Received: by 2002:a05:6a21:9007:b0:1ed:9e58:5195 with SMTP id adf61e73a8af0-1ede8834f7cmr1948485637.13.1738718515327;
        Tue, 04 Feb 2025 17:21:55 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cec0fsm11457202b3a.137.2025.02.04.17.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:21:55 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 04 Feb 2025 17:21:48 -0800
Subject: [PATCH v9 01/26] mm: helper `is_shadow_stack_vma` to check shadow
 stack vma
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-v5_user_cfi_series-v9-1-b37a49c5205c@rivosinc.com>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
In-Reply-To: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
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
index 3883b307780e..8c64f3ff34ab 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1291,7 +1291,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		    !writable_file_mapping_allowed(vma, gup_flags))
 			return -EFAULT;
 
-		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
+		if (!(vm_flags & VM_WRITE) || is_shadow_stack_vma(vm_flags)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/*
diff --git a/mm/mmap.c b/mm/mmap.c
index cda01071c7b1..7b6be4eec35d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -648,7 +648,7 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
  */
 static inline unsigned long stack_guard_placement(vm_flags_t vm_flags)
 {
-	if (vm_flags & VM_SHADOW_STACK)
+	if (is_shadow_stack_vma(vm_flags))
 		return PAGE_SIZE;
 
 	return 0;
diff --git a/mm/vma.h b/mm/vma.h
index a2e8710b8c47..47482a25f5c3 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -278,7 +278,7 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
 }
 
 /*
- * These three helpers classifies VMAs for virtual memory accounting.
+ * These four helpers classifies VMAs for virtual memory accounting.
  */
 
 /*
@@ -289,6 +289,11 @@ static inline bool is_exec_mapping(vm_flags_t flags)
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
@@ -297,7 +302,7 @@ static inline bool is_exec_mapping(vm_flags_t flags)
  */
 static inline bool is_stack_mapping(vm_flags_t flags)
 {
-	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
+	return ((flags & VM_STACK) == VM_STACK) || is_shadow_stack_vma(flags);
 }
 
 /*
@@ -308,7 +313,6 @@ static inline bool is_data_mapping(vm_flags_t flags)
 	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE;
 }
 
-
 static inline void vma_iter_config(struct vma_iterator *vmi,
 		unsigned long index, unsigned long last)
 {

-- 
2.34.1


