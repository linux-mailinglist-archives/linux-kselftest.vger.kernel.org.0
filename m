Return-Path: <linux-kselftest+bounces-37607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C12B0AC53
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 00:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24BC67BA431
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 22:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85534225A35;
	Fri, 18 Jul 2025 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmiVcikE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D2D224AFB;
	Fri, 18 Jul 2025 22:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752879089; cv=none; b=S3MILflS8Cf19q+M1ugUM9nr3hCErwhnmRs4Qeh2HM2Uy7IPGii8uqPCudEWjUEtX34LZYs8qH0Je5AYBSPGWhdV7Dv74trvZCru2ggaDKIwSKz1pXODf+sM16Hfs8Im8guWp4c7ereH5PUKWbcy3d1LTGyZZCKapX9NeBORdq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752879089; c=relaxed/simple;
	bh=9wq1gPYvCplHPaY4Wm5XgoLMe+aODde2O7VcmHcmk98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPLgdyUatVim0CECah6F4FPsKF/Ls5gb4V26IYBlQ1t173MdwVyCoWuoCPsOvoYdTionaiaKpw/1zEypEwH8hQ3ac8ZeL+s+ZrJ3IowNbuL9fEz1xfQN0oSbLJgtdU8JIsb0nKL4BcNLpdplupJAQ+SQ37o8H60Ag8plhzcuNkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmiVcikE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0591C4CEF1;
	Fri, 18 Jul 2025 22:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752879088;
	bh=9wq1gPYvCplHPaY4Wm5XgoLMe+aODde2O7VcmHcmk98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VmiVcikElcqZk72BFs7/zWioNVg/RlBsEZTqUIs6HsScTtVwOS6j7B3ua7R/5a+8f
	 B/Xx/QRZM/EQh/lO2RicrfWNUj4TspYI7v5C1esxaGnMy5qNgSFrlaLuHCW1KuRQE/
	 vwjy0/1yadEDESYc6Jup2r2d1g6hRKk98N3uI9FiR3pIjtw/6N8d9/1A9DF/kI7Ptp
	 /KtF2y8xo3+DKYzmZGh9ileKlyQIK4tsMmB+vc1VQguKTRnI0Md6sJRL9kCLGWssqH
	 x60/sDs7wvwXbxMyYV4GlknlF8akcqkSZPz9pRU1nNtV+O7XtlJK1/hNvPy3K6SwqK
	 vqLjSPHvQBQpQ==
Date: Fri, 18 Jul 2025 15:51:28 -0700
From: Kees Cook <kees@kernel.org>
To: Mike Rapoport <rppt@kernel.org>, Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
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
	Ard Biesheuvel <ardb@kernel.org>,
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
Message-ID: <202507181541.B8CFAC7E@keescook>
References: <20250717231756.make.423-kees@kernel.org>
 <20250717232519.2984886-4-kees@kernel.org>
 <aHoHkDvvp4AHIzU1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHoHkDvvp4AHIzU1@kernel.org>

On Fri, Jul 18, 2025 at 11:36:32AM +0300, Mike Rapoport wrote:
> Hi Kees,
> 
> On Thu, Jul 17, 2025 at 04:25:09PM -0700, Kees Cook wrote:
> > When KCOV is enabled all functions get instrumented, unless the
> > __no_sanitize_coverage attribute is used. To prepare for
> > __no_sanitize_coverage being applied to __init functions, we have to
> > handle differences in how GCC's inline optimizations get resolved. For
> > x86 this means forcing several functions to be inline with
> > __always_inline.
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> ...
> 
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index bb19a2534224..b96746376e17 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -463,7 +463,7 @@ static inline void *memblock_alloc_raw(phys_addr_t size,
> >  					  NUMA_NO_NODE);
> >  }
> >  
> > -static inline void *memblock_alloc_from(phys_addr_t size,
> > +static __always_inline void *memblock_alloc_from(phys_addr_t size,
> >  						phys_addr_t align,
> >  						phys_addr_t min_addr)
> 
> I'm curious why from all memblock_alloc* wrappers this is the only one that
> needs to be __always_inline?

Thread-merge[1], adding Will Deacon, who was kind of asking the same
question.

Based on what I can tell, GCC has kind of fragile inlining logic, in the
sense that it can change whether or not it inlines something based on
optimizations. It looks like the kcov instrumentation being added (or in
this case, removed) from a function changes the optimization results,
and some functions marked "inline" are _not_ inlined. In that case, we end up
with __init code calling a function not marked __init, and we get the
build warnings I'm trying to eliminate.

So, to Will's comment, yes, the problem is somewhat fragile (though
using either __always_inline or __init will deterministically solve it).
We've tripped over this before with GCC and the solution has usually
been to just use __always_inline and move on.

For memblock_alloc*, it appears to be that the heuristic GCC uses
resulted in only memblock_alloc_from() being a problem in this case. I
can certainly mark them all as __always_inline if that is preferred.

Some maintainers have wanted things marked __init, some have wanted
__always_inline. I opted for __always_inline since that was basically
the intent of marking a function "inline" in the first place. I am happy
to do whatever. :)

-Kees

[1] https://lore.kernel.org/lkml/aHouXI5-tyQw78Ht@willie-the-truck/

-- 
Kees Cook

