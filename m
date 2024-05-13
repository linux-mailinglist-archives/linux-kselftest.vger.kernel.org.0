Return-Path: <linux-kselftest+bounces-10147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4D88C4617
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 19:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2321C2318F
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 17:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AA422339;
	Mon, 13 May 2024 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Qd/svlTr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37DA25776
	for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2024 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621562; cv=none; b=tgqpSpLeNY9ciqtzb/MyCINmdlqZX1YSjgQ/ZR/e22LWsGhcxWJl7UUs3bh/RJPf2sk6MMeBbv9lvpS3Kae+PIU4ZlcYh/LTr4ka3DYWbnCMqCNO/c6tl8fv2J4mopQh84bpxr6spDoimwQDzwOEzHvsGFjA0bdDw72tNw3c3Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621562; c=relaxed/simple;
	bh=mPHMcasvWFpk25M8Za6Mkdnzu/OeKqq71I0HciR5Psw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zcme91xFrTyx4rbjk+R1PKmLEX4fr98suSKG9aT3IpMJyUT65/hwXZILOanDHU+JVyiTNGD7zYMJ4ZzgwKNCWmtH9yPVBlLY9Bgt73gsMWe8qsVQ3g6TjUfq0F6DIyA1D+WG3mmyEi2aB8VoC1qm5fdmC0OxnV90aM1kyLWwiCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Qd/svlTr; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2b3646494a8so3652939a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2024 10:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715621560; x=1716226360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kFXpqZ06tDuL/9cR0jtY4Xzt7LWkOIEFJ/Br1ZOH9fM=;
        b=Qd/svlTrA/3dgomdRrlpEFa34QqHQN2SvMs4524NF463CjFqrd4SKKA9AS2OpYQy4A
         MXzdHMycRNTaKQU1oRkDWuvJy5pHkp3EZXfHx4Rux7yu3ID2i9nVS6qhFMdf5M3PaXab
         lazwG47fJitIwnxmv94mFUgYmz+sgAbUNXoa9bvapYdYuzDddFNNCodptb0moKO5npqB
         hfMH69RzcA/h2OzjpHQFEaEJ2kTPzqYxu9HWi+Lzc0yCpQ9BiqleXzEMOaFabZxdS5lV
         vBbaZsbr+tl1KFxbyV3l4ROaHE6Cxzp/Eku2TGdDY6aEssMxikHXcPkZA54uLx7OasgX
         WTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621560; x=1716226360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFXpqZ06tDuL/9cR0jtY4Xzt7LWkOIEFJ/Br1ZOH9fM=;
        b=FPiGQJk2xYHDU+OmBenodrCRjYhOUdT89lmBFfI5ai9/DpEVoc3vqBK3CagbbvAilW
         8xNeiSMLBcm+4Mz5mz+CQOxoYfHd4LMB/FfeugQqCZdvavm6pw0p0ZDdnFgnfrLkSMpA
         BFBZhF56E74/lCLRciWK3DXYuJxO5MwpVekA7s03SHhO70LB/X3g+ky178anDhI1bYk2
         6zEiaGerAl68KxV6tK1546p5vFxlYgshjCWZYbTv/j/A9Cf6/KBte0ikUcUqiolN5Evc
         JzyNtuI9MvT5tYBlf3X3H66xJcOgq0F35Hq37haH0WDxQvD1fjgw80TllNHv/5CrO9KT
         5/gg==
X-Forwarded-Encrypted: i=1; AJvYcCXn7UaBUSyy6oGQ1D9KTjT2tx6GYwlqEr2Jid7W56hPAzb43FNv7jYyj4rfWZtBUvBoL0ghkLinViPzBvkL5/4TH0Fr7Zm4pi28iPSBTodB
X-Gm-Message-State: AOJu0YyJJgjZ3cMY9Qc3n/pe8KtlvPBS7KFAgjhS8zHRfMYg+YGj68Db
	lUa9Ixz/ElRMDNmgJHsosbvH2AginpB09v1FfFXqZiQ1KjOYd6YIDRhOxjTq06M=
X-Google-Smtp-Source: AGHT+IHKmfimNpAoB9AkagGSZYSsR4bthh7r8LX1Nfh54P1zDj04Ez6BdQHy8JDipeCpvu8vEpu4Yw==
X-Received: by 2002:a17:90b:46c3:b0:2a4:b831:5017 with SMTP id 98e67ed59e1d1-2b6ccef66cemr8063931a91.48.1715621560155;
        Mon, 13 May 2024 10:32:40 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca51e0sm10048832a91.35.2024.05.13.10.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:32:39 -0700 (PDT)
Date: Mon, 13 May 2024 10:32:35 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com,
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com,
	keescook@chromium.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, bjorn@rivosinc.com, alexghiti@rivosinc.com,
	samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
	shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
	jerry.shih@sifive.com, hankuan.chen@sifive.com,
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com,
	charlie@rivosinc.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, dbarboza@ventanamicro.com,
	sameo@rivosinc.com, shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, david@redhat.com, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, shr@devkernel.io,
	deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH v3 13/29] riscv mmu: write protect and shadow stack
Message-ID: <ZkJOs6ENmDHFsq/U@debug.ba.rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-14-debug@rivosinc.com>
 <276fa17b-cd62-433d-b0ec-fa98c65a46ca@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <276fa17b-cd62-433d-b0ec-fa98c65a46ca@ghiti.fr>

On Sun, May 12, 2024 at 06:31:24PM +0200, Alexandre Ghiti wrote:
>On 04/04/2024 01:35, Deepak Gupta wrote:
>>`fork` implements copy on write (COW) by making pages readonly in child
>>and parent both.
>>
>>ptep_set_wrprotect and pte_wrprotect clears _PAGE_WRITE in PTE.
>>Assumption is that page is readable and on fault copy on write happens.
>>
>>To implement COW on such pages,
>
>
>I guess you mean "shadow stack pages" here.

Yes I meant shadow stack pages. Will fix the message.

>
>
>>  clearing up W bit makes them XWR = 000.
>>This will result in wrong PTE setting which says no perms but V=1 and PFN
>>field pointing to final page. Instead desired behavior is to turn it into
>>a readable page, take an access (load/store) fault on sspush/sspop
>>(shadow stack) and then perform COW on such pages.
>>This way regular reads
>>would still be allowed and not lead to COW maintaining current behavior
>>of COW on non-shadow stack but writeable memory.
>>
>>On the other hand it doesn't interfere with existing COW for read-write
>>memory. Assumption is always that _PAGE_READ must have been set and thus
>>setting _PAGE_READ is harmless.
>>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>>diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>>index 9b837239d3e8..7a1c2a98d272 100644
>>--- a/arch/riscv/include/asm/pgtable.h
>>+++ b/arch/riscv/include/asm/pgtable.h
>>@@ -398,7 +398,7 @@ static inline int pte_special(pte_t pte)
>>  static inline pte_t pte_wrprotect(pte_t pte)
>>  {
>>-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
>>+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
>>  }
>>  /* static inline pte_t pte_mkread(pte_t pte) */
>>@@ -581,7 +581,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>>  				      unsigned long address, pte_t *ptep)
>>  {
>>-	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
>>+	volatile pte_t read_pte = *ptep;
>>+	/*
>>+	 * ptep_set_wrprotect can be called for shadow stack ranges too.
>>+	 * shadow stack memory is XWR = 010 and thus clearing _PAGE_WRITE will lead to
>>+	 * encoding 000b which is wrong encoding with V = 1. This should lead to page fault
>>+	 * but we dont want this wrong configuration to be set in page tables.
>>+	 */
>>+	atomic_long_set((atomic_long_t *)ptep,
>>+			((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE) | _PAGE_READ));
>>  }
>>  #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
>
>
>Doesn't making the shadow stack page readable allow "normal" loads to 
>access the page? If it does, isn't that an issue (security-wise)?

When shadow stack permissions are there (i.e. R=0, W=1, X=0), then also shadow stack is
readable through "normal" loads. So nothing changes when it converts into a readonly page
from page permissions perspective.

Security-wise it's not a concern because from threat modeling perspective, if attacker had
read-write primitives (via some bug in program) available to read and write address space
of process/task; then they would have availiblity of return addresses on normal stack. It's
the write primitive that is concerning and to be protected against. And that's why shadow stack
is not writeable using "normal" stores.

>

