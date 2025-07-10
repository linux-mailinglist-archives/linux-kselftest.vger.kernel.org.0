Return-Path: <linux-kselftest+bounces-36897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91108AFF68B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 03:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7791C467E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 01:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E06B27EC98;
	Thu, 10 Jul 2025 01:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s36gQ67r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C5A846C;
	Thu, 10 Jul 2025 01:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752112622; cv=none; b=TIeD5c50jmuF0uKXJ+D63N4yxfI//3XthxMTfEb+oMEqPR5pdOKTf7EONnMPIXLBh3uywfypaWPiDpDZbW9YO9DnSgU+re4gNwirWirDP5nR3xa2f4vtkxh7rfH3uUoNp2GTJ6pf6F5sDjMtDHADk1DTRe81eiuSZXQhVHemxlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752112622; c=relaxed/simple;
	bh=V5+0JeybGuGj3hNbNrffhOaKN4FNKIUQicNKhhV6M9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omIPSsBs5r7iLg7+sjAVJY9UtCGN9PHUC5gc9uws4aUuGSXXfoAJLKaBa0+DZBMjISWhj0ClhBa3rQ44AlTN0nVkGfO1mDLqwg84gQUwhgcGc70ICfVkH4V0nJYGRKLvvUzm5DX8zGe9+bIYfwvt1qNDMRnY+Hq6beGvjC/DtSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s36gQ67r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5A6C4CEEF;
	Thu, 10 Jul 2025 01:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752112621;
	bh=V5+0JeybGuGj3hNbNrffhOaKN4FNKIUQicNKhhV6M9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s36gQ67r+HzmWOakvqjLN2Bi+cxAqgCf9b1jm8CeVANKXagOyi4qRCxno997vOt7I
	 npTW9Sqm4fAIHoISBPWcX7vjQIgal5suR6GEB+4EiYf2hwAgwibu53TlZdekzLZBEQ
	 9ABBQhGaRUZwnPIix2Qtgh30B7PYqrpPimSO1KfrR0HfIEongwbMYk/1onz4hpDV26
	 GuIsiO8b8UJiiZ9KWrmQ80LhTJRWiOT9thCwXfahXz+KypMzoUnp19aAp8cABbtMDx
	 gSq60cIssEQ+9AYdxjTLFvnKp8xU42OaucaV/Fz2aUcFFHry0HoCkWdrBfNWJs8YVU
	 kLmHPK8kS1RBw==
Date: Wed, 9 Jul 2025 18:57:00 -0700
From: Kees Cook <kees@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 08/14] powerpc: Handle KCOV __init vs inline mismatches
Message-ID: <202507091856.C6510D809A@keescook>
References: <20250523043251.it.550-kees@kernel.org>
 <20250523043935.2009972-8-kees@kernel.org>
 <87jz662ssp.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz662ssp.fsf@gmail.com>

On Sat, May 24, 2025 at 04:13:02PM +0530, Ritesh Harjani wrote:
> Kees Cook <kees@kernel.org> writes:
> 
> > When KCOV is enabled all functions get instrumented, unless
> > the __no_sanitize_coverage attribute is used. To prepare for
> > __no_sanitize_coverage being applied to __init functions, we have to
> > handle differences in how GCC's inline optimizations get resolved. For
> > s390 this requires forcing a couple functions to be inline with
> > __always_inline.
> >
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Cc: Naveen N Rao <naveen@kernel.org>
> > Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: <linuxppc-dev@lists.ozlabs.org>
> > ---
> >  arch/powerpc/mm/book3s64/hash_utils.c    | 2 +-
> >  arch/powerpc/mm/book3s64/radix_pgtable.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
> > index 5158aefe4873..93f1e1eb5ea6 100644
> > --- a/arch/powerpc/mm/book3s64/hash_utils.c
> > +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> > @@ -409,7 +409,7 @@ static DEFINE_RAW_SPINLOCK(linear_map_kf_hash_lock);
> >  
> >  static phys_addr_t kfence_pool;
> >  
> > -static inline void hash_kfence_alloc_pool(void)
> > +static __always_inline void hash_kfence_alloc_pool(void)
> >  {
> >  	if (!kfence_early_init_enabled())
> >  		goto err;
> > diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> > index 9f764bc42b8c..3238e9ed46b5 100644
> > --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> > +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> > @@ -363,7 +363,7 @@ static int __meminit create_physical_mapping(unsigned long start,
> >  }
> >  
> >  #ifdef CONFIG_KFENCE
> > -static inline phys_addr_t alloc_kfence_pool(void)
> > +static __always_inline phys_addr_t alloc_kfence_pool(void)
> >  {
> >  	phys_addr_t kfence_pool;
> >  
> 
> I remember seeing a warning msg around .init.text section. Let me dig
> that...
> 
> ... Here it is: https://lore.kernel.org/oe-kbuild-all/202504190552.mnFGs5sj-lkp@intel.com/
> 
> I am not sure why it only complains for hash_debug_pagealloc_alloc_slots().
> I believe there should me more functions to mark with __init here.
> Anyways, here is the patch of what I had in mind.. I am not a compiler expert,
> so please let me know your thoughts on this.

Yeah, this looks good. I'll snag your patch and drop mine. :)

-Kees

-- 
Kees Cook

