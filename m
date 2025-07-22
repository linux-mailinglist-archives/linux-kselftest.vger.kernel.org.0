Return-Path: <linux-kselftest+bounces-37833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED28B0DAD4
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 15:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA10C5644A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 13:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42CB2EA15F;
	Tue, 22 Jul 2025 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icCzbYE3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC5C2D3EFB;
	Tue, 22 Jul 2025 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190973; cv=none; b=jUbfq6LzYuDe8e2xZhmDFylAk82T8N+MMEYIKpBxojGEidYm6Vylg0yaPAmkkshn63vdVSCUD90HSWt9MO0R3nd1J32RRgIX4mb0D6rlNoWgRNSg1PxGtO5l89YlRRw1xld2RfKsd6w/+ImvwDJYoACPN0XaAhdiTKSZlVwGOhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190973; c=relaxed/simple;
	bh=v5BLSIwd7srHi/OWA5ndIBkdalmEzmLEQmrp+RewTTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGItBp7f0LJtFN0uHXVdSHBZ7Iu7ohLohoEN0sVtiLa0UUj8G20bvsqoZjSP4BErfMdtD4RlWkyaRGSWt6bsjq7zMwMV4jXbODJdDpGEMpH1y8lqKrHlolk0AgMXEnqGIcwunW3BYJWaZpefdQsci7y5deQ/aHn4RQNvfZPCnrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icCzbYE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B00BC4CEEB;
	Tue, 22 Jul 2025 13:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753190972;
	bh=v5BLSIwd7srHi/OWA5ndIBkdalmEzmLEQmrp+RewTTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=icCzbYE3Gw4FMkjzZQGdd5PRl3DLgwJi4XEJMOcR2bhXW2g1yFhd+T0X/aqMi3/BP
	 CibFuID4nbj6OAYkc1NMOYpqf8N3QkVei13FupO8PIGWwd7LMLFew2Gjxu4KdVUg1O
	 DkTKaYgXxxbbsiX0+w7BLz0w/qJZtmL94y+JVE7CzC9ZZx6kQNyfp3ET4nPZ9scvga
	 Dn2CpPG5UqY1IGli6LRySAYz4YmMRdxPp1TJllyeOcCWdL2WRYt94l/h9D04DE4+Uc
	 MGgZG1jWvtMVVXZVVriPuhmhhcn2IesGNkPl/Ho6XBcy/wvha6uvWcQ0AKEDdQ4Ukm
	 HjjZtlQLlu8FQ==
Date: Tue, 22 Jul 2025 14:29:19 +0100
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Juergen Gross <jgross@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Roger Pau Monne <roger.pau@citrix.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Usama Arif <usama.arif@bytedance.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Huth <thuth@redhat.com>, Brian Gerst <brgerst@gmail.com>,
	kvm@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-mm@kvack.org, Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v3 04/13] x86: Handle KCOV __init vs inline mismatches
Message-ID: <aH-SL2V2bSPkJ18o@willie-the-truck>
References: <20250717231756.make.423-kees@kernel.org>
 <20250717232519.2984886-4-kees@kernel.org>
 <aHoHkDvvp4AHIzU1@kernel.org>
 <202507181541.B8CFAC7E@keescook>
 <CAMj1kXGAwjChyFvjQcTbL8dFXkFWnn9n47bkN7FP=+EsLNsJdg@mail.gmail.com>
 <aH42--h-ARsvX5Wk@willie-the-truck>
 <202507211311.8DAC4C7@keescook>
 <202507211349.D93679FB25@keescook>
 <CAMj1kXGoy7D+_hKyQrT_uXdjuFMYGUEMDYdRf6mx69PLeuBQQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGoy7D+_hKyQrT_uXdjuFMYGUEMDYdRf6mx69PLeuBQQg@mail.gmail.com>

On Tue, Jul 22, 2025 at 04:55:47PM +1000, Ard Biesheuvel wrote:
> On Tue, 22 Jul 2025 at 06:49, Kees Cook <kees@kernel.org> wrote:
> >
> > On Mon, Jul 21, 2025 at 01:14:36PM -0700, Kees Cook wrote:
> > > On Mon, Jul 21, 2025 at 01:47:55PM +0100, Will Deacon wrote:
> > > > On Sun, Jul 20, 2025 at 04:10:01PM +1000, Ard Biesheuvel wrote:
> > > > > On Sat, 19 Jul 2025 at 08:51, Kees Cook <kees@kernel.org> wrote:
> > > > > > On Fri, Jul 18, 2025 at 11:36:32AM +0300, Mike Rapoport wrote:
> > > > > > > On Thu, Jul 17, 2025 at 04:25:09PM -0700, Kees Cook wrote:
> > > > > > > > When KCOV is enabled all functions get instrumented, unless the
> > > > > > > > __no_sanitize_coverage attribute is used. To prepare for
> > > > > > > > __no_sanitize_coverage being applied to __init functions, we have to
> > > > > > > > handle differences in how GCC's inline optimizations get resolved. For
> > > > > > > > x86 this means forcing several functions to be inline with
> > > > > > > > __always_inline.
> > > > > > > >
> > > > > > > > Signed-off-by: Kees Cook <kees@kernel.org>
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > > > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > > > > > > > index bb19a2534224..b96746376e17 100644
> > > > > > > > --- a/include/linux/memblock.h
> > > > > > > > +++ b/include/linux/memblock.h
> > > > > > > > @@ -463,7 +463,7 @@ static inline void *memblock_alloc_raw(phys_addr_t size,
> > > > > > > >                                       NUMA_NO_NODE);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -static inline void *memblock_alloc_from(phys_addr_t size,
> > > > > > > > +static __always_inline void *memblock_alloc_from(phys_addr_t size,
> > > > > > > >                                             phys_addr_t align,
> > > > > > > >                                             phys_addr_t min_addr)
> > > > > > >
> > > > > > > I'm curious why from all memblock_alloc* wrappers this is the only one that
> > > > > > > needs to be __always_inline?
> > > > > >
> > > > > > Thread-merge[1], adding Will Deacon, who was kind of asking the same
> > > > > > question.
> > > > > >
> > > > > > Based on what I can tell, GCC has kind of fragile inlining logic, in the
> > > > > > sense that it can change whether or not it inlines something based on
> > > > > > optimizations. It looks like the kcov instrumentation being added (or in
> > > > > > this case, removed) from a function changes the optimization results,
> > > > > > and some functions marked "inline" are _not_ inlined. In that case, we end up
> > > > > > with __init code calling a function not marked __init, and we get the
> > > > > > build warnings I'm trying to eliminate.
> > > >
> > > > Got it, thanks for the explanation!
> > > >
> > > > > > So, to Will's comment, yes, the problem is somewhat fragile (though
> > > > > > using either __always_inline or __init will deterministically solve it).
> > > > > > We've tripped over this before with GCC and the solution has usually
> > > > > > been to just use __always_inline and move on.
> > > > > >
> > > > >
> > > > > Given that 'inline' is already a macro in the kernel, could we just
> > > > > add __attribute__((__always_inline__)) to it when KCOV is enabled?
> > > >
> > > > That sounds like a more robust approach and, by the sounds of it, we
> > > > could predicate it on GCC too. That would also provide a neat place for
> > > > a comment describing the problem.
> > > >
> > > > Kees, would that work for you?
> > >
> > > That seems like an extremely large hammer for this problem, IMO. It
> > > feels like it could cause new strange corner cases. I'd much prefer the
> > > small fixes I've currently got since it keeps it focused. KCOV is
> > > already enabled for "allmodconfig", so any new instances would be found
> > > very quickly, etc. (And GCC's fragility in this regard has already been
> > > exposed to these cases -- it's just that I changed one of the
> > > combinations of __init vs inline vs instrumentation.
> > >
> > > I could give it a try, if you really prefer the big hammer approach...
> >
> > I gave it a try -- it fails spectacularly. ;) Let's stick to my small
> > fixes instead?
> >
> 
> Fair enough :-)

(but please add the helpful explanation you provided to the commit message!)

Will

