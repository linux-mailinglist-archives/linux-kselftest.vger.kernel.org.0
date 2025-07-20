Return-Path: <linux-kselftest+bounces-37674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD676B0B3B2
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 08:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4053C17F1
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 06:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778771B4242;
	Sun, 20 Jul 2025 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcocEkaA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AC9182B4;
	Sun, 20 Jul 2025 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752991820; cv=none; b=hBg14WIWsHUwYzEBvDy6ZfacHxXSkegdexfZYQLuL/U8dHbCaqSj+1JMtHhTs4iTMAU3fRhjvZcOtl9jYhRPRRHWVcutH/t6JlXtPagErXpq4heNZKF5XsbbQ4Lv0rCBcOxrFXBG4gCMF0FLUyWKQ4+iGrVNrDn5bH7Y1IfnCSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752991820; c=relaxed/simple;
	bh=ombXy5J9mN5+Ko6iFhW8NndKJFf3Fpi4o6CQRaezi3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9eCXqwwDh9roo9isXlqCDWW9w1gibgSa9w8uQrPosnaH/t2ssC/UAwLyPBFIiokTXLlgVfK9eBwl2GxuQi5MJOlL8pqrITNFuImlqFWNOKoed6ves6KfG0Gf4UksAUZzJ5VGtD93NBZ6wf/vbC5psPpmSAp7Yuka/nNbEdWAhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcocEkaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D626EC19421;
	Sun, 20 Jul 2025 06:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752991819;
	bh=ombXy5J9mN5+Ko6iFhW8NndKJFf3Fpi4o6CQRaezi3g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HcocEkaAHqoiHoBCIs5ZO1zgy5A6mlv32UCcJW8LJrNOH9xTJsjCjR+0l+k+rDugt
	 FfJRK0wuMhP1+l40qQ4Zsqb2kNgofBEYfXVrDcz5S49YWRrNZuwLyidR4kwpzmO+j+
	 2Ti22ok5s651Cl0DKENNJulslvkPPeDYInLV6/E1rLq+3JS2kHByx10FDPlWtaaYoO
	 zbBEeae5MrdFJ4uyBR+eocuvKJFVtcaQkoastPWeZ1nTyt+lAAqN/K7z9f9MgU77QF
	 ns3N6LeIPgbEVfylgBuIAeVsTpY9WQPioWqB+bD85jLB/SdJceatFgmEgi7I3n/vBJ
	 jDFV6fT3ykiRg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55622414cf4so2928807e87.3;
        Sat, 19 Jul 2025 23:10:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKELGM/ashHPFgoKCL9nctb4y0d4y+qbD4P53Q+1tSd7LRfn9MV78LpsXGidu3HrJeLdmsoOJOhWGw@vger.kernel.org, AJvYcCUMiohBnJmrFxFxFe9PYL17Q7ShcYP2VeZeeYLZsnH9E+hr5lOvu21HFVubc80PBWY2fWPy3R4NjfkOvjzpLBVI@vger.kernel.org, AJvYcCUlNBIJSfM8sgAbeaxc85+pdeBUcZyk8iMSNYW6U1rSffrvBjVByJXOft6TzypgTUWIgQZ3Cfjf7CjVvA==@vger.kernel.org, AJvYcCV2NXQwjeR4DYr6Ind0bCxoOzQTh9XOa9N++vn6rP6EcHI2j4nUprBFHpNnU3enXwfg/maKhfx/X/9cx0gy6UOO@vger.kernel.org, AJvYcCVGne03iuMAcCztfyBqjN3EINlYyOHUIRcdhlM5muxd3DJQJkdAkyWmqKKoNh0NPZs0Hc/M7VIksDVqVXjjHnW+8sZz@vger.kernel.org, AJvYcCVnw3A0foCIkyfH2UIPAS6ZgSqrtA5SkB/FKqtvWeKjyObQOxciuHpphgUoKjxe52YuHCiF5up8AFaq1Q==@vger.kernel.org, AJvYcCVr/3B8F1Vjvnjzldjpwg/hnAzOlh/NVZdAxDi4X7FELWh82PyulBQrI8ssQHDSUKmhNrTqVDnzCxQANaTQ@vger.kernel.org, AJvYcCW4D6JFTgCvOiopuKLxIpG0vcqq0RHn4BRSLOdmBA3EOU//G9v6cVg9ZitGdwohFExrCnI=@vger.kernel.org, AJvYcCWqraamdjbvXObGalFIXiBcb62yFGO4wxDPUyxoaIJvOyVBm1Kr/4M/APrySHKNOj9yU6SeWFzSxXD+@vger.kernel.org, AJvYcCWsMvJ6sfvfskTZ
 rJxe33y1RORyQLmqEZfnkbylM9FU7OrC1Nu8TWxq6GnYCwY1AKgc3g/WBjdEFtuZBtZVtQH26ZLN1ZyG@vger.kernel.org, AJvYcCX8hi+duU26oTYVSKJIRMloRGdwGZrS3Hpd74gmpVo3BEqB/YlzqOu9Fu6OCRv+WBmdP9nbdAt6QHvFwpvSVDvVnZkUYQ==@vger.kernel.org, AJvYcCXXnwZn7kkbncLKby6XxH86oz9GvSxSTLUmMVXlaRlzm1jVRyZD+fpg46VZW2rRjKCuCvvHIeWpug1rRA==@vger.kernel.org, AJvYcCXjk8tNlYGrU1DrrV3YTxAh2tHKeSaod8NnL9nuf+efZM0hB/Xr3BUcCBF4BFmfzc3CKesjqurhYNcY+iOm@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSOgQY3WWLFbolB0FzpUU+BEwg/oGmgLXO6Jkb5qFFhTxfUMF
	7SAW79ISsthUVrkoDDIH1v94w97nlSEVld5QUKbTlUHj7p2s6FkuWr6VfsisnuyIrtGmAouy6gR
	UpAbV+UN5yvInMfSnHYh1eS0M9F1vjTY=
X-Google-Smtp-Source: AGHT+IGzW7z8MZyh/6NVryj0xIRWvZtmGLwUiyHXGC4Qk/FYdRSLZqwcI4BFS0lrRzeksvOsF0eTUUFywEq3kCkPty0=
X-Received: by 2002:a05:6512:2301:b0:553:5176:48a with SMTP id
 2adb3069b0e04-55a31843110mr2007807e87.21.1752991817889; Sat, 19 Jul 2025
 23:10:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717231756.make.423-kees@kernel.org> <20250717232519.2984886-4-kees@kernel.org>
 <aHoHkDvvp4AHIzU1@kernel.org> <202507181541.B8CFAC7E@keescook>
In-Reply-To: <202507181541.B8CFAC7E@keescook>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 20 Jul 2025 16:10:01 +1000
X-Gmail-Original-Message-ID: <CAMj1kXGAwjChyFvjQcTbL8dFXkFWnn9n47bkN7FP=+EsLNsJdg@mail.gmail.com>
X-Gm-Features: Ac12FXxx6bD_QGQsGFgOANxpcIEdVmgITnXc8yZmdE0EdDE9cBbQCb787bRnEwA
Message-ID: <CAMj1kXGAwjChyFvjQcTbL8dFXkFWnn9n47bkN7FP=+EsLNsJdg@mail.gmail.com>
Subject: Re: [PATCH v3 04/13] x86: Handle KCOV __init vs inline mismatches
To: Kees Cook <kees@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
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

On Sat, 19 Jul 2025 at 08:51, Kees Cook <kees@kernel.org> wrote:
>
> On Fri, Jul 18, 2025 at 11:36:32AM +0300, Mike Rapoport wrote:
> > Hi Kees,
> >
> > On Thu, Jul 17, 2025 at 04:25:09PM -0700, Kees Cook wrote:
> > > When KCOV is enabled all functions get instrumented, unless the
> > > __no_sanitize_coverage attribute is used. To prepare for
> > > __no_sanitize_coverage being applied to __init functions, we have to
> > > handle differences in how GCC's inline optimizations get resolved. For
> > > x86 this means forcing several functions to be inline with
> > > __always_inline.
> > >
> > > Signed-off-by: Kees Cook <kees@kernel.org>
> >
> > ...
> >
> > > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > > index bb19a2534224..b96746376e17 100644
> > > --- a/include/linux/memblock.h
> > > +++ b/include/linux/memblock.h
> > > @@ -463,7 +463,7 @@ static inline void *memblock_alloc_raw(phys_addr_t size,
> > >                                       NUMA_NO_NODE);
> > >  }
> > >
> > > -static inline void *memblock_alloc_from(phys_addr_t size,
> > > +static __always_inline void *memblock_alloc_from(phys_addr_t size,
> > >                                             phys_addr_t align,
> > >                                             phys_addr_t min_addr)
> >
> > I'm curious why from all memblock_alloc* wrappers this is the only one that
> > needs to be __always_inline?
>
> Thread-merge[1], adding Will Deacon, who was kind of asking the same
> question.
>
> Based on what I can tell, GCC has kind of fragile inlining logic, in the
> sense that it can change whether or not it inlines something based on
> optimizations. It looks like the kcov instrumentation being added (or in
> this case, removed) from a function changes the optimization results,
> and some functions marked "inline" are _not_ inlined. In that case, we end up
> with __init code calling a function not marked __init, and we get the
> build warnings I'm trying to eliminate.
>
> So, to Will's comment, yes, the problem is somewhat fragile (though
> using either __always_inline or __init will deterministically solve it).
> We've tripped over this before with GCC and the solution has usually
> been to just use __always_inline and move on.
>

Given that 'inline' is already a macro in the kernel, could we just
add __attribute__((__always_inline__)) to it when KCOV is enabled?

