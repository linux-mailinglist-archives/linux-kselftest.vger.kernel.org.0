Return-Path: <linux-kselftest+bounces-37798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 916ACB0D23A
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 08:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2601AA36C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 06:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6863E2C15A5;
	Tue, 22 Jul 2025 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpfcgUnu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B986288531;
	Tue, 22 Jul 2025 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167361; cv=none; b=eiblMF0NaWZeKcDKG3HuFak0dGEIvvCBC+0Bt8yAM4gxP7GBhsxU8UJliQnKT0CqE+1yl2XZOTfwsqe+gVU8o81Y9pojwDCMkGpX3WlaM7nDhVToa7uyQHBh+mTrINmoprr7O5aavvbnJCd46PpYC/6n2R5i72IW+RLL2xXLRhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167361; c=relaxed/simple;
	bh=DqE2r+jnLUTL7QjlcN7tboq45VqA22jH4eIVD8o4Gmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAJgP20a1duVeppOqeal2e+DlUQ49vNLLuIzhW2wJ9VfGd9Q9ReBA3bS2yIttHRwmIO+oXx5OM3w8k/iMi3VkJ/trhvV8btukQ4rk1T3l5v8yBDll3Vqy3dEgR00YTrNKG/tdXfZhM0zyOjt8wiHo6H9Od/YA+MuTwcte1dhiFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpfcgUnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB071C19421;
	Tue, 22 Jul 2025 06:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753167360;
	bh=DqE2r+jnLUTL7QjlcN7tboq45VqA22jH4eIVD8o4Gmo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CpfcgUnuDL0Vl921O+6i/yShR++00pNLOKABN64TGoQv08s4JWDaq5R787TzRwPYd
	 SOxP3mvcTg3o5UodLqlybzcfO2KW0UIPKod6tyjXn4Q6f0Jg20Bo4EcbVyst6PFIeD
	 9wwLag5HZhkuEkGdG4rGL0/xDa1dd1XF4wE0tl/b+CrzT64kGYr4RZg1sRlNLV6OW9
	 D1EcUuEM2t8ys5AutC5biwDJeSbkbVn8adA+/943wMPAxGJivryo7aGbp+SI8Q2V02
	 kg6rNPNzOZNNl41J5VZzJI8EAO2Ut8rnz8gAHCFuXdd0jodm+XgB+V+DD74LOgNTj5
	 FmJF7Vu5xhdxg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b7f41d3e6so48641711fa.1;
        Mon, 21 Jul 2025 23:56:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUX5wKbZm2IOtUum/OGqvpO4z6HuCoB1LDU2yLwkY/f5Plsi8y4zE7js47QLNR0MkFLXMM=@vger.kernel.org, AJvYcCVDFvz1UDnN4bfMZaZgoSiBU61uNCyrxz+1ErMzitvXnzAlZWI9i5+nvxqxh5s7fy2Laa8PrZJbca+7@vger.kernel.org, AJvYcCVXWLC8kFscT4NpsDZZFxDbZ1pu5IWgbTG27fSBGPQgOFAhz6tYiTgQZGgiFozgYMae+vl17pTXVFmX2O5WaB9jXRhz/g==@vger.kernel.org, AJvYcCVfWZPG7npEyTbMf5CuHA0vK3Bh81fIGfE5oziQZ9WMjmNkuKAYdW+D81lLZlHoZy6rErgEY+L/QCHc@vger.kernel.org, AJvYcCVj6WVTPqRmsxR9US0Joe4xnrPVkYsbsYT++zuIpmTRkEHX9xvIqIZ7MyFjVPnW3CqfuvbKMr5vEoLa6A==@vger.kernel.org, AJvYcCWIhHeca4enoslA8mdW5sv2IpglC0O/kcNO1B+dftXygCOgwvIKyfDo3YJI5TkOiCO80vNC+35WXCRown6gjbS4SyGc@vger.kernel.org, AJvYcCWKpdWnXbrCDuydrQBZwMHAUbEn6sGmeLTp+AYxZyVQ+HylMHErW7RpIkJHS8eog07E4je8+5aK+LCcalpzfDgM@vger.kernel.org, AJvYcCWWRMDezKzELWTei7j8lwehVzYU2wXXzGpbEo9LsULQJqvW/sAJPS8rUcyMNoX/SLuhruyJ0kaXOfp1Q1wH@vger.kernel.org, AJvYcCWaFIstkBLEsbsyiPCjVFAr09vbqxYy8dhM+o9xHEbwxdiirKcP4bmleBRy7fZerOWHI+VknG0EVklZ07EU@vger.kernel.org, AJvYcCWwTRRT
 6vJOEDwauzGDPFuIsF6zvAqUmVu976G21HrW9NMF8co5qYnVLJeRX66VOCgFq0Bw717UdQRQGTUdWBC64c/Try4J@vger.kernel.org, AJvYcCWyes6iceGphS7jGv/ls1AtiWGzyXRtfigL4fqxx/xrf/Sw+WaanLwDyp+k2kIwaF7mtt845IqkLVHm8g==@vger.kernel.org, AJvYcCX8rIOD/qSM4PM4IVveozDj2YjXy0m4kU8jyFdGCHpBY4yFfq0NewdYaQIULZezfmeXafsp/IRUX1DL1wmGhiVp@vger.kernel.org, AJvYcCXcRc3v6VqLNOTSPnRuq5qB7YOR3ONHs/zUFF1SQ6LHMLYPwCyGFQ+xAzBHWMT73HhYpC4LGQp8KHP/Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Cy5HykqPvtQ5L4xKmkwIDzkKvL6nHs1mHEJ4eifUwYsfa/DJ
	C+/llk2ypanRlVGw/69/D1y6SVgb4NgL6jYrUBzsTgVraZGV964/HhlSXLoWc2zuCuVkXbH2viD
	CPk7MY3bCa8axRF4IL3qKDHpWaHWCJ3s=
X-Google-Smtp-Source: AGHT+IHafl72rt/goLHslFsPSeMLrUwjaR0SoHeFAxURGVfbf4gcV3AlCo9M3FCJzrvPSuMBFqrA7K/+xkn2H/6KxwI=
X-Received: by 2002:a05:651c:b11:b0:32b:952f:3e0 with SMTP id
 38308e7fff4ca-330d25506d3mr8241951fa.7.1753167358762; Mon, 21 Jul 2025
 23:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717231756.make.423-kees@kernel.org> <20250717232519.2984886-4-kees@kernel.org>
 <aHoHkDvvp4AHIzU1@kernel.org> <202507181541.B8CFAC7E@keescook>
 <CAMj1kXGAwjChyFvjQcTbL8dFXkFWnn9n47bkN7FP=+EsLNsJdg@mail.gmail.com>
 <aH42--h-ARsvX5Wk@willie-the-truck> <202507211311.8DAC4C7@keescook> <202507211349.D93679FB25@keescook>
In-Reply-To: <202507211349.D93679FB25@keescook>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 22 Jul 2025 16:55:47 +1000
X-Gmail-Original-Message-ID: <CAMj1kXGoy7D+_hKyQrT_uXdjuFMYGUEMDYdRf6mx69PLeuBQQg@mail.gmail.com>
X-Gm-Features: Ac12FXxN7NYW1J5gsbL-uJ8eWKShqoH6QBvGfux9lCX9EcW_ZhNmDxq92IzpXG0
Message-ID: <CAMj1kXGoy7D+_hKyQrT_uXdjuFMYGUEMDYdRf6mx69PLeuBQQg@mail.gmail.com>
Subject: Re: [PATCH v3 04/13] x86: Handle KCOV __init vs inline mismatches
To: Kees Cook <kees@kernel.org>
Cc: Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Michal Wilczynski <michal.wilczynski@intel.com>, 
	Juergen Gross <jgross@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Roger Pau Monne <roger.pau@citrix.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Usama Arif <usama.arif@bytedance.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Thomas Huth <thuth@redhat.com>, Brian Gerst <brgerst@gmail.com>, 
	kvm@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, 
	platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-mm@kvack.org, Ingo Molnar <mingo@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	sparclinux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Jul 2025 at 06:49, Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Jul 21, 2025 at 01:14:36PM -0700, Kees Cook wrote:
> > On Mon, Jul 21, 2025 at 01:47:55PM +0100, Will Deacon wrote:
> > > On Sun, Jul 20, 2025 at 04:10:01PM +1000, Ard Biesheuvel wrote:
> > > > On Sat, 19 Jul 2025 at 08:51, Kees Cook <kees@kernel.org> wrote:
> > > > > On Fri, Jul 18, 2025 at 11:36:32AM +0300, Mike Rapoport wrote:
> > > > > > On Thu, Jul 17, 2025 at 04:25:09PM -0700, Kees Cook wrote:
> > > > > > > When KCOV is enabled all functions get instrumented, unless the
> > > > > > > __no_sanitize_coverage attribute is used. To prepare for
> > > > > > > __no_sanitize_coverage being applied to __init functions, we have to
> > > > > > > handle differences in how GCC's inline optimizations get resolved. For
> > > > > > > x86 this means forcing several functions to be inline with
> > > > > > > __always_inline.
> > > > > > >
> > > > > > > Signed-off-by: Kees Cook <kees@kernel.org>
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > > > > > > index bb19a2534224..b96746376e17 100644
> > > > > > > --- a/include/linux/memblock.h
> > > > > > > +++ b/include/linux/memblock.h
> > > > > > > @@ -463,7 +463,7 @@ static inline void *memblock_alloc_raw(phys_addr_t size,
> > > > > > >                                       NUMA_NO_NODE);
> > > > > > >  }
> > > > > > >
> > > > > > > -static inline void *memblock_alloc_from(phys_addr_t size,
> > > > > > > +static __always_inline void *memblock_alloc_from(phys_addr_t size,
> > > > > > >                                             phys_addr_t align,
> > > > > > >                                             phys_addr_t min_addr)
> > > > > >
> > > > > > I'm curious why from all memblock_alloc* wrappers this is the only one that
> > > > > > needs to be __always_inline?
> > > > >
> > > > > Thread-merge[1], adding Will Deacon, who was kind of asking the same
> > > > > question.
> > > > >
> > > > > Based on what I can tell, GCC has kind of fragile inlining logic, in the
> > > > > sense that it can change whether or not it inlines something based on
> > > > > optimizations. It looks like the kcov instrumentation being added (or in
> > > > > this case, removed) from a function changes the optimization results,
> > > > > and some functions marked "inline" are _not_ inlined. In that case, we end up
> > > > > with __init code calling a function not marked __init, and we get the
> > > > > build warnings I'm trying to eliminate.
> > >
> > > Got it, thanks for the explanation!
> > >
> > > > > So, to Will's comment, yes, the problem is somewhat fragile (though
> > > > > using either __always_inline or __init will deterministically solve it).
> > > > > We've tripped over this before with GCC and the solution has usually
> > > > > been to just use __always_inline and move on.
> > > > >
> > > >
> > > > Given that 'inline' is already a macro in the kernel, could we just
> > > > add __attribute__((__always_inline__)) to it when KCOV is enabled?
> > >
> > > That sounds like a more robust approach and, by the sounds of it, we
> > > could predicate it on GCC too. That would also provide a neat place for
> > > a comment describing the problem.
> > >
> > > Kees, would that work for you?
> >
> > That seems like an extremely large hammer for this problem, IMO. It
> > feels like it could cause new strange corner cases. I'd much prefer the
> > small fixes I've currently got since it keeps it focused. KCOV is
> > already enabled for "allmodconfig", so any new instances would be found
> > very quickly, etc. (And GCC's fragility in this regard has already been
> > exposed to these cases -- it's just that I changed one of the
> > combinations of __init vs inline vs instrumentation.
> >
> > I could give it a try, if you really prefer the big hammer approach...
>
> I gave it a try -- it fails spectacularly. ;) Let's stick to my small
> fixes instead?
>

Fair enough :-)

