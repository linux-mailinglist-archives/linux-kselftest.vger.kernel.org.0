Return-Path: <linux-kselftest+bounces-17874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B6E9774CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 01:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D638B1F24E93
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 23:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DF31C460B;
	Thu, 12 Sep 2024 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="j4YCQcKi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D841C3F36
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183036; cv=none; b=B+Fall2dvAR+2yAiWMN/9h7wsT7fw7JS8cyyWr+bSGpSHeSt5eDzTVGVfs8JIX9oPCb9VURYP5cvCZgRGzh7fYRR4zCYLuRi/mJaNss3TrKv8uCwdQQEs+S+CnymsACGZB6SWi0yXeVnVcuhasqOkm+eRH/+oNXT5GvDA0viv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183036; c=relaxed/simple;
	bh=hpow8mQ74i+wSk+QIPGbfZWyaC+Jvq6LJd4lssAAiHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/8/+4xqexm9f041okJT1/BROn8ksByVKzCsK9ogFKo0+wxuEdDvrxNRE8py+bvkWouG14tCF2q81lyEY5Qe6P4lz+LTWh8m0y2+fqj/tzrbLttbb7S5Tm1qKTcwmKvodDtFO3/AEiF0qq5DY7swepLEUfFxshJZN53UnyfGO9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=j4YCQcKi; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7163489149eso205939a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 16:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183034; x=1726787834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=067qKPjJ+n9l6Epc1eYM3Yt2z4Jj28HWHwDjljiSStY=;
        b=j4YCQcKiD8Xq9Cl/WGJ0cV5+E965SrheZaOa0wOFmv89PUU/AcQY6qAw7xSl0A5UEV
         AoyyIcm5OCo7BAmSGjQjysXp80v7YQVfkeiFcIWBZWwkV5nvlN2/14T6aDiFSbfjcKyq
         jqpLtciZC6kMxcwasEGiXB6g6/ruP2Y1cMDQG5sBq8aPZgJWBIBKASSH3ClE/rXAjQrf
         F5QWeHsdnNnSJJBWnwjye9O6Gegw7Ex1Ee+VAPg65s3NTToDLdqrLF7I37WFRtTr/zrA
         YawSDFHl9DVGN/Sq//EWsauHOg5DvB7QmPWG2WIxWVWrUJxvpFwSwV8XimfOSHY+yL7s
         0TDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183034; x=1726787834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=067qKPjJ+n9l6Epc1eYM3Yt2z4Jj28HWHwDjljiSStY=;
        b=jtVYQlmWf/SlQh5b0GrLb47A8XIsaVoxk1stvc2pEMoEXTcD2GA8l6cWriISWRVOuA
         sYtAUhGyKxEZnd7rtqT6zypsQiUUza6qIwNC3ACxgnFgavonCMDjiToLRbafn+3gKxyZ
         w1Dxs6I/gQsW1T+gOpSaNjI8bJvd3XirhGmmoib0wUA1Gl5rsNTMfoQyGdZrkaB9BKDr
         /8lzLDEdgEX3SU+77E89SruQAn6kHKqjl9h6gaWavNx8bCFH9OaVE1KwyW0gAlw//xay
         mdRSoKzCRXlZft6ei99ebKnBjNsfGmA9J3DRfA4QWpUKWyZDJZZILal/bzMRAy9pYoBl
         vIhg==
X-Forwarded-Encrypted: i=1; AJvYcCWIXS0E1GNIeLn65/DH3CgS0k9a5g/zwxSck/14mDPQm+bZKnaZJFsDweOlbfOFdjGmFsqOzKcsqCeKh6LHU2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTL4CI3bXn7VDQhtSElNhkbuzHEe6GUGgbHh07MNX+GTdOpuc0
	GeB7tSQNU8694v2NqVkjRrcQ+HYHB2iKY1nRC06J+erNgh4KyitQTS8nsFOjASU=
X-Google-Smtp-Source: AGHT+IGUPoWnvS5/UyAev2mMCxr4fAbJAZEQ5NXGYl3k4LYiYl5m+yOy9I9Oauh7+qEP1ZcWno2Wvg==
X-Received: by 2002:a17:90a:d489:b0:2d3:cd57:bd3 with SMTP id 98e67ed59e1d1-2dbb9f3a7cemr1099703a91.29.1726183034358;
        Thu, 12 Sep 2024 16:17:14 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:17:13 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	krzk+dt@kernel.org,
	oleg@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	shuah@kernel.org,
	brauner@kernel.org,
	samuel.holland@sifive.com,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	greentime.hu@sifive.com,
	charlie@rivosinc.com,
	evan@rivosinc.com,
	cleger@rivosinc.com,
	xiao.w.wang@intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	mchitale@ventanamicro.com,
	atishp@rivosinc.com,
	sameo@rivosinc.com,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	david@redhat.com,
	libang.li@antgroup.com,
	jszhang@kernel.org,
	leobras@redhat.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	costa.shul@redhat.com,
	bhe@redhat.com,
	zong.li@sifive.com,
	puranjay@kernel.org,
	namcaov@gmail.com,
	antonb@tenstorrent.com,
	sorear@fastmail.com,
	quic_bjorande@quicinc.com,
	ancientmodern4@gmail.com,
	ben.dooks@codethink.co.uk,
	quic_zhonhan@quicinc.com,
	cuiyunhui@bytedance.com,
	yang.lee@linux.alibaba.com,
	ke.zhao@shingroup.cn,
	sunilvl@ventanamicro.com,
	tanzhasanwork@gmail.com,
	schwab@suse.de,
	dawei.li@shingroup.cn,
	rppt@kernel.org,
	willy@infradead.org,
	usama.anjum@collabora.com,
	osalvador@suse.de,
	ryan.roberts@arm.com,
	andrii@kernel.org,
	alx@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	revest@chromium.org,
	bgray@linux.ibm.com,
	deller@gmx.de,
	zev@bewilderbeest.net
Subject: [PATCH v4 02/30] mm: helper `is_shadow_stack_vma` to check shadow stack vma
Date: Thu, 12 Sep 2024 16:16:21 -0700
Message-ID: <20240912231650.3740732-3-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912231650.3740732-1-debug@rivosinc.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack
VMA on three architectures (x86 shadow stack, arm GCS and RISC-V shadow
stack). In case architecture doesn't implement shadow stack, it's VM_NONE
Introducing a helper `is_shadow_stack_vma` to determine shadow stack vma
or not.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 7 ++++++-
 mm/gup.c           | 2 +-
 mm/internal.h      | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e39796ea17db..f0dc94fb782a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -361,6 +361,11 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_SHADOW_STACK	VM_NONE
 #endif
 
+static inline bool is_shadow_stack_vma(vm_flags_t vm_flags)
+{
+	return !!(vm_flags & VM_SHADOW_STACK);
+}
+
 #if defined(CONFIG_X86)
 # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
 #elif defined(CONFIG_PPC)
@@ -3504,7 +3509,7 @@ static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
 		return stack_guard_gap;
 
 	/* See reasoning around the VM_SHADOW_STACK definition */
-	if (vma->vm_flags & VM_SHADOW_STACK)
+	if (is_shadow_stack_vma(vma->vm_flags))
 		return PAGE_SIZE;
 
 	return 0;
diff --git a/mm/gup.c b/mm/gup.c
index 54d0dc3831fb..2f84a0a80cfe 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1289,7 +1289,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		    !writable_file_mapping_allowed(vma, gup_flags))
 			return -EFAULT;
 
-		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
+		if (!(vm_flags & VM_WRITE) || is_shadow_stack_vma(vm_flags)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
diff --git a/mm/internal.h b/mm/internal.h
index b4d86436565b..f7732c793f3f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -798,7 +798,7 @@ static inline bool is_exec_mapping(vm_flags_t flags)
  */
 static inline bool is_stack_mapping(vm_flags_t flags)
 {
-	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
+	return ((flags & VM_STACK) == VM_STACK) || is_shadow_stack_vma(flags);
 }
 
 /*
-- 
2.45.0


