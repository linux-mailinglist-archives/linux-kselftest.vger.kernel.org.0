Return-Path: <linux-kselftest+bounces-6831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA34B89129A
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 05:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8D11F226A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 04:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0423B185;
	Fri, 29 Mar 2024 04:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="EY/x67VL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4B63FB3C
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 04:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687576; cv=none; b=kB62AEZK4KVK8TFMAGEkgQP7etywBSTlarMvMVds5/GVQFqo80hrrl06942wX3xgdEFcVbEsvVoUa5PxcDFJ6ZObrqYcG1hh+7wbxz8Cnkq6HaGsMV8iFKPrXxiZOR3TuAXhqlDu56/WF9K+ElXb9yDzUL4fhNcdOTz7Phlpias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687576; c=relaxed/simple;
	bh=WfBodVkF4fVB/Ej67rhL87Mq/iBcG77x0Ahg7PAgCNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=reSAshQs1Syqe+oKK2DWskTnoHwowOC2+lYznBp0ZROsNIbnYv7BbE3ZqFPT0nLUDINGHTpuqjiYc6w49I4xWLLnNsKFy1a1ISagTyhSVYdvCY5Pyinqj2oLcuYJlgqxclDQog5ExoRGQXtooLredxRfXxNdtnUlvjpaDkNg2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=EY/x67VL; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c36f882372so1017671b6e.2
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Mar 2024 21:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711687573; x=1712292373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qNedlIktUfQrTR049/Z3OzWmqNS/siPqaKIdhPjXgQ=;
        b=EY/x67VLsrZlVz2a1fk+4i6Su2v4rikoMZ3h4iSFE5I1bpuNbfORMAmBSTaTT3hxxv
         uBgzUYbGZvUv+BECsMq1Yzl2+z2QesZs+cKlxO377r7UFjpKS7cv+EcN0hu8rvznqBhg
         v17gYt2S/KRhXsd3K007hmIbinTLfv258JP//BVUyy1m/6EtdYAoAP7P/iDNBoJZu4Q6
         oFyzmq3pBuYxbE+R0WP4LPWWCsokoSJ5OKqXUGeAkWYOwxA/3Wb8ABdGp9iD4g+p2FFb
         CJeK2Twg06o5RVr9/xv+VbrJZt3rnvV815BYuVO1jfBCVUQkJ/fpc0bBHw26Fn0jfjII
         p52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711687573; x=1712292373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qNedlIktUfQrTR049/Z3OzWmqNS/siPqaKIdhPjXgQ=;
        b=PXQNc0A99FtYqZBo+5nxJhdkFA5vagc6fN7s1o80a4Jq4lq10UeJhWZCvEwN+DdwNC
         9mbHFK1NYIF6FBJLoNTkAaKAQKS9spYXLHCKhcbwzm5Xk6+ZfhhrE4WjkSemYAM99spO
         g1c3VRuSGQ4fTvyQcneSlA9rl5lEUlcTfVzS7obPuGqMu7n9NyB7/mGC2k61iTFgw4W1
         7OY+CT0T3NE410FcY7m2E1q2XfnlN0TvhN+RZzpXWcOfwMkqetQi1oKj3ZKqQsq+lOqf
         Q8fl35h0GpGC+FKckj+pUFWEVUFxiQl3rfG0g7kI+SNhzsSIiCJZoNSD1kQU0A6DqgkH
         Ma9A==
X-Forwarded-Encrypted: i=1; AJvYcCVlDxU7/24oWPhtXr9aaupxrMHVKfymjcUj77iShXz/DcfcogO5HjCc52CZX7BbB+jkpk2xNL7LMNGzu+8R3dgKOky9yMjum/r5/jzR1XPR
X-Gm-Message-State: AOJu0Yyn0V0DsPSbuc2pfr3frLY22u9aT4zWYQoMo5ew2sqBUkAvR6yg
	FkNDyDG4jFjdMubL1o/uDTSOQRV3v7XlHanXV9dlY/SLRg1mpaVLUtCvcQF2Urs=
X-Google-Smtp-Source: AGHT+IHTQWx1tR1j7s3+pvyrI5hMSSRXmYpDonpnfYPB/9nbQQQRNm8eLeO96l4IIa6gD4IvOzseMg==
X-Received: by 2002:a05:6808:398c:b0:3c3:d2ca:a4fe with SMTP id gq12-20020a056808398c00b003c3d2caa4femr1622664oib.7.1711687573325;
        Thu, 28 Mar 2024 21:46:13 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id i18-20020aa78b52000000b006ea7e972947sm2217120pfd.130.2024.03.28.21.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:46:13 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	samuel.holland@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	tech-j-ext@lists.risc-v.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	hankuan.chen@sifive.com,
	greentime.hu@sifive.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	charlie@rivosinc.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	sameo@rivosinc.com,
	shikemeng@huaweicloud.com,
	willy@infradead.org,
	vincent.chen@sifive.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	gerg@kernel.org,
	heiko@sntech.de,
	bhe@redhat.com,
	jeeheng.sia@starfivetech.com,
	cyy@cyyself.name,
	maskray@google.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bgray@linux.ibm.com,
	mpe@ellerman.id.au,
	baruch@tkos.co.il,
	alx@kernel.org,
	david@redhat.com,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	shr@devkernel.io,
	deller@gmx.de,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: [PATCH v2 08/27] mm: abstract shadow stack vma behind `arch_is_shadow_stack`
Date: Thu, 28 Mar 2024 21:44:40 -0700
Message-Id: <20240329044459.3990638-9-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329044459.3990638-1-debug@rivosinc.com>
References: <20240329044459.3990638-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86 has used VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) to encode shadow
stack VMA. VM_SHADOW_STACK is thus not possible on 32bit. Some arches may
need a way to encode shadow stack on 32bit and 64bit both and they may
encode this information differently in VMAs.

This patch changes checks of VM_SHADOW_STACK flag in generic code to call
to a function `arch_is_shadow_stack` which will return true if arch
supports shadow stack and vma is shadow stack else stub returns false.

There was a suggestion to name it as `vma_is_shadow_stack`. I preferred to
keep `arch` prefix in there because it's each arch specific.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 12 +++++++++++-
 mm/gup.c           |  5 +++--
 mm/internal.h      |  2 +-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 225af437ecba..9e6a4fbfccac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -352,6 +352,10 @@ extern unsigned int kobjsize(const void *objp);
  * for more details on the guard size.
  */
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+static inline bool arch_is_shadow_stack(vm_flags_t vm_flags)
+{
+	return (vm_flags & VM_SHADOW_STACK);
+}
 #endif
 
 #ifdef CONFIG_RISCV_USER_CFI
@@ -372,6 +376,12 @@ static inline bool arch_is_shadow_stack(vm_flags_t vm_flags)
 
 #ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
+
+static inline bool arch_is_shadow_stack(vm_flags_t vm_flags)
+{
+	return false;
+}
+
 #endif
 
 #if defined(CONFIG_X86)
@@ -3482,7 +3492,7 @@ static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
 		return stack_guard_gap;
 
 	/* See reasoning around the VM_SHADOW_STACK definition */
-	if (vma->vm_flags & VM_SHADOW_STACK)
+	if (vma->vm_flags && arch_is_shadow_stack(vma->vm_flags))
 		return PAGE_SIZE;
 
 	return 0;
diff --git a/mm/gup.c b/mm/gup.c
index df83182ec72d..a96043429b31 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1053,7 +1053,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		    !writable_file_mapping_allowed(vma, gup_flags))
 			return -EFAULT;
 
-		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
+		if (!(vm_flags & VM_WRITE) || arch_is_shadow_stack(vm_flags)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
@@ -1071,7 +1071,8 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 			if (!is_cow_mapping(vm_flags))
 				return -EFAULT;
 		}
-	} else if (!(vm_flags & VM_READ)) {
+	} else if (!(vm_flags & VM_READ) && !arch_is_shadow_stack(vm_flags)) {
+	/* reads allowed if its shadow stack vma */
 		if (!(gup_flags & FOLL_FORCE))
 			return -EFAULT;
 		/*
diff --git a/mm/internal.h b/mm/internal.h
index f309a010d50f..005761d754f6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -572,7 +572,7 @@ static inline bool is_exec_mapping(vm_flags_t flags)
  */
 static inline bool is_stack_mapping(vm_flags_t flags)
 {
-	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
+	return ((flags & VM_STACK) == VM_STACK) || arch_is_shadow_stack(flags);
 }
 
 /*
-- 
2.43.2


