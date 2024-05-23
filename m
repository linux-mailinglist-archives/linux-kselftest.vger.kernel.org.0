Return-Path: <linux-kselftest+bounces-10619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B1F8CD669
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 17:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240B91F22091
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA47B653;
	Thu, 23 May 2024 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xQoQE/L0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF04DB657
	for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476385; cv=none; b=INrdsV4HlHgOvWOoIlY3QNmiOptnZZtaj7ODTD1WAx1J97svHBjblZlXWFpMEfN1rJnoEpl7zGK4xvk1D7+UJyjgX+63lCTBcmbrltlEHcz73x2+GoUg3oJMDunHbwclraFBd2WeByuRQspgZ8oI+JcKQfpQk/cgljLVqN4mlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476385; c=relaxed/simple;
	bh=2Dr0p6+Vq88UVDiwU5c+6Vvwt3ZIg69MAge1qiiRneo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+T0HowcIy4ZG4dvjqus65yGIpvc8C+WVFQkm1Hfx5dkScdKgfnOa0miUquzubTkyJ5keU1J5KekiilijsWoHM/bpA7E4WKz+GiMr6oONnRCX0jofDoahZcK64oScqbK1+fENNZdTYiXr94rUd8ospLRuECaJY+LLHl9qIpWS34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xQoQE/L0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5a2d0d8644so1039133866b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716476381; x=1717081181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJf8nECqEBzmEqcVWslv5AXViIlFFnTcWLmUE5Gi6ig=;
        b=xQoQE/L0Ez07vhPcph3w2XDmhCXg9FR9r/yBEEx01f7bvRE6pNFesxXXnDrdLmFamj
         XesPRyxF3OHasOAK/iaqcdv5zoFZiomaPpVt/7E4fOjuNVbIcP+IVNR1aRNCWOg2s/CV
         wNIPFgPrvBs//5V83fAGcIfl1s9HG428CpnOlP1KUV/EgsHYy7nXz2byAAfjZoVzqIJ/
         4xxfq8TBcEeS5aPfLZHDavEDlvF6DaPfCmBNddYxvyQNtpg9nRenN5LTqVvay59CM9k8
         kqKo9wAvaLz/hqLfSOkB1qrMIrQ9HhsrCVBnZC+NVoiOwUKDm8szA65B8x5NQ7W1NwI6
         PY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476381; x=1717081181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJf8nECqEBzmEqcVWslv5AXViIlFFnTcWLmUE5Gi6ig=;
        b=TKNygHdRIOPuxMgx3hhdZQ0WrYk+eDS6r4yite6iiP6yD/2rL9YYNsqZtNwOADoLYE
         Pf00/t/TYbIuToAaz+85DxR5cNcuM8Y28myZ7M1OvQC0+MRp2C/yFaUydSB8pCBBZXIb
         wougXXgrWyC6eFgfQkZ0SZc6Jb4wJefMpy1pl5jbo+Kh+958+7NwPq+M7WS+J55nfyUn
         Ok2rmYTzoYQgaxmTm2kIvSgBPAnig7BapiJYPn8jrFuc9Y6Df2xJJgImjG31sea+re/z
         +Gl/a7VeuUVLmaFCHvNkNbEQhCLF6HG7S8yt4kBE8j1ZgSFj/WOL1f4zbrgcxHccVlgN
         gG1g==
X-Forwarded-Encrypted: i=1; AJvYcCX7Mp0opSa9qI8hdVrDhbLda7hkBc5puF1qXmW4j88HfIw5vRnLoZRA+dBPr3BrVI3i5fPFwXspSV6LBs890qSQdtNHsHotJupxVAVHmKsg
X-Gm-Message-State: AOJu0Yy+D0EgKn/7UDSU5QCOugpIi67mf06Ib2Wsqi420WwGYzL66TfY
	PSlSmeIhXHJdwr852O5Y6YBWhY1+YP6QbfO6GwpZGDAs3SR8lIYFjHc/cEX8K6yekpp9xAOUhaX
	JZHR5YLvphViZCUBrZliVze/WEK8sVO/9A84F6w==
X-Google-Smtp-Source: AGHT+IH96ZBYqe4cc+1wFeLH7NX/PsHsWO2WigAasUwgg3Elfr20rtzmvQZZHOI45ry8NHHXFtdf/BIf5ZeuawftPVg=
X-Received: by 2002:a17:906:5296:b0:a5a:5c0b:ff77 with SMTP id
 a640c23a62f3a-a622806c0camr321589066b.19.1716476381026; Thu, 23 May 2024
 07:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403234054.2020347-1-debug@rivosinc.com> <20240403234054.2020347-14-debug@rivosinc.com>
 <276fa17b-cd62-433d-b0ec-fa98c65a46ca@ghiti.fr> <ZkJOs6ENmDHFsq/U@debug.ba.rivosinc.com>
In-Reply-To: <ZkJOs6ENmDHFsq/U@debug.ba.rivosinc.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 23 May 2024 16:59:30 +0200
Message-ID: <CAHVXubhS3CJ87DxC+9+8z6CiWDV1bQ8nK+iOZUDvMiT7vszFLA@mail.gmail.com>
Subject: Re: [PATCH v3 13/29] riscv mmu: write protect and shadow stack
To: Deepak Gupta <debug@rivosinc.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, paul.walmsley@sifive.com, rick.p.edgecombe@intel.com, 
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com, 
	keescook@chromium.org, ajones@ventanamicro.com, conor.dooley@microchip.com, 
	cleger@rivosinc.com, atishp@atishpatra.org, bjorn@rivosinc.com, 
	samuel.holland@sifive.com, conor@kernel.org, linux-doc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de, 
	ebiederm@xmission.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lstoakes@gmail.com, shuah@kernel.org, brauner@kernel.org, 
	andy.chiu@sifive.com, jerry.shih@sifive.com, hankuan.chen@sifive.com, 
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com, 
	charlie@rivosinc.com, apatel@ventanamicro.com, mchitale@ventanamicro.com, 
	dbarboza@ventanamicro.com, sameo@rivosinc.com, shikemeng@huaweicloud.com, 
	willy@infradead.org, vincent.chen@sifive.com, guoren@kernel.org, 
	samitolvanen@google.com, songshuaishuai@tinylab.org, gerg@kernel.org, 
	heiko@sntech.de, bhe@redhat.com, jeeheng.sia@starfivetech.com, 
	cyy@cyyself.name, maskray@google.com, ancientmodern4@gmail.com, 
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com, bgray@linux.ibm.com, 
	mpe@ellerman.id.au, baruch@tkos.co.il, alx@kernel.org, david@redhat.com, 
	catalin.marinas@arm.com, revest@chromium.org, josh@joshtriplett.org, 
	shr@devkernel.io, deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org, 
	jhubbard@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Deepak,

On Mon, May 13, 2024 at 7:32=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> On Sun, May 12, 2024 at 06:31:24PM +0200, Alexandre Ghiti wrote:
> >On 04/04/2024 01:35, Deepak Gupta wrote:
> >>`fork` implements copy on write (COW) by making pages readonly in child
> >>and parent both.
> >>
> >>ptep_set_wrprotect and pte_wrprotect clears _PAGE_WRITE in PTE.
> >>Assumption is that page is readable and on fault copy on write happens.
> >>
> >>To implement COW on such pages,
> >
> >
> >I guess you mean "shadow stack pages" here.
>
> Yes I meant shadow stack pages. Will fix the message.
>
> >
> >
> >>  clearing up W bit makes them XWR =3D 000.
> >>This will result in wrong PTE setting which says no perms but V=3D1 and=
 PFN
> >>field pointing to final page. Instead desired behavior is to turn it in=
to
> >>a readable page, take an access (load/store) fault on sspush/sspop
> >>(shadow stack) and then perform COW on such pages.
> >>This way regular reads
> >>would still be allowed and not lead to COW maintaining current behavior
> >>of COW on non-shadow stack but writeable memory.
> >>
> >>On the other hand it doesn't interfere with existing COW for read-write
> >>memory. Assumption is always that _PAGE_READ must have been set and thu=
s
> >>setting _PAGE_READ is harmless.
> >>
> >>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> >>---
> >>  arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
> >>  1 file changed, 10 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> >>index 9b837239d3e8..7a1c2a98d272 100644
> >>--- a/arch/riscv/include/asm/pgtable.h
> >>+++ b/arch/riscv/include/asm/pgtable.h
> >>@@ -398,7 +398,7 @@ static inline int pte_special(pte_t pte)
> >>  static inline pte_t pte_wrprotect(pte_t pte)
> >>  {
> >>-     return __pte(pte_val(pte) & ~(_PAGE_WRITE));
> >>+     return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
> >>  }
> >>  /* static inline pte_t pte_mkread(pte_t pte) */
> >>@@ -581,7 +581,15 @@ static inline pte_t ptep_get_and_clear(struct mm_s=
truct *mm,
> >>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
> >>                                    unsigned long address, pte_t *ptep)
> >>  {
> >>-     atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)pte=
p);
> >>+     volatile pte_t read_pte =3D *ptep;

Sorry I missed this ^. You need to use ptep_get() to get the value of
a pte. And why do you need the volatile here?

> >>+     /*
> >>+      * ptep_set_wrprotect can be called for shadow stack ranges too.
> >>+      * shadow stack memory is XWR =3D 010 and thus clearing _PAGE_WRI=
TE will lead to
> >>+      * encoding 000b which is wrong encoding with V =3D 1. This shoul=
d lead to page fault
> >>+      * but we dont want this wrong configuration to be set in page ta=
bles.
> >>+      */
> >>+     atomic_long_set((atomic_long_t *)ptep,
> >>+                     ((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE=
) | _PAGE_READ));
> >>  }
> >>  #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
> >
> >
> >Doesn't making the shadow stack page readable allow "normal" loads to
> >access the page? If it does, isn't that an issue (security-wise)?
>
> When shadow stack permissions are there (i.e. R=3D0, W=3D1, X=3D0), then =
also shadow stack is
> readable through "normal" loads. So nothing changes when it converts into=
 a readonly page
> from page permissions perspective.
>
> Security-wise it's not a concern because from threat modeling perspective=
, if attacker had
> read-write primitives (via some bug in program) available to read and wri=
te address space
> of process/task; then they would have availiblity of return addresses on =
normal stack. It's
> the write primitive that is concerning and to be protected against. And t=
hat's why shadow stack
> is not writeable using "normal" stores.
>
> >

Thanks for the explanation!

With the use of ptep_get(), you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

