Return-Path: <linux-kselftest+bounces-33835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 203C9AC46CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 05:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631D13AD869
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 03:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FC51A256B;
	Tue, 27 May 2025 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDpCasoc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3D13D8A3;
	Tue, 27 May 2025 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748316656; cv=none; b=BkAoTSY7oPxTj22whIgesem09KbHz0sz4yKkAmbhHl+vaI4OG/EzqLtVUSyb+y4NO+ec6SpV0z82XFzUaGvOd/wlxrZMgXaZmkqfuFeYG6VZQRTY5I9DzIG39w07WI4x++9qivMurScmmviEzOydti47tAg6LnxynDc0J1+JW+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748316656; c=relaxed/simple;
	bh=4+1dYOsA3kHiY8rIfLnjAgd8wOHuIeN0O4AklhVQ26M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNgPsuz+bFx9p4F0t8inlF8y/5XUgtuJWyWiqw1UWQ9oGu6l6IO65YMF0CREu1OjL3Ep3yJ46a6AMQJRjElZoTmOoio1FfNbYDqdGQeYu3oRKjtivEtMl4AgB1ll4ehm2YLqpTirZM2ZqP1bkAXKVCAmB1Afo+54aksJr/hfP5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDpCasoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81B4C4CEED;
	Tue, 27 May 2025 03:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748316655;
	bh=4+1dYOsA3kHiY8rIfLnjAgd8wOHuIeN0O4AklhVQ26M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDpCasocKfbRpFVO+Gva5E2erDIv83oOIdsyR75Vq2GGa56oNa5MOdQa5qay1G54y
	 S3D805nuKzNhvN1MGkOcNzDYg75XhUCqp/yL2uAtapUbK1S3n1G1UqKFxjn4ntxa2t
	 CxK7rnXc/L95iZlTUmMOfPm+tWQHp0eHX8ylQn1MLkMLwWEVbEIqOGdVT8vlbCWjXx
	 1q7/F23sOsIArXHlRGvPt/BGFksZoRCqKz9JnzG/1PYvusJQ1vfQN1bIMcZcy537wE
	 EtK8ERnZ0Vf1prle9VJ/upLUeNrvka0s29uYXbrEKAL1WDGe39ZbtoexMTV0Oi8rty
	 ACZ9lz8fPa0vg==
Date: Mon, 26 May 2025 20:30:52 -0700
From: Kees Cook <kees@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>,
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
	linux-mm@kvack.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	LKML <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 04/14] x86: Handle KCOV __init vs inline mismatches
Message-ID: <202505262028.E5B7A7E8@keescook>
References: <20250523043251.it.550-kees@kernel.org>
 <20250523043935.2009972-4-kees@kernel.org>
 <ba4f4fd0-1bcf-3d84-c08e-ba0dd040af16@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba4f4fd0-1bcf-3d84-c08e-ba0dd040af16@linux.intel.com>

On Mon, May 26, 2025 at 12:53:13AM +0300, Ilpo Järvinen wrote:
> On Thu, 22 May 2025, Kees Cook wrote:
> 
> > When KCOV is enabled all functions get instrumented, unless the
> > __no_sanitize_coverage attribute is used. To prepare for
> > __no_sanitize_coverage being applied to __init functions, we have to
> > handle differences in how GCC's inline optimizations get resolved. For
> > x86 this means forcing several functions to be inline with
> > __always_inline.
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: <x86@kernel.org>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Michal Wilczynski <michal.wilczynski@intel.com>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Cc: Roger Pau Monne <roger.pau@citrix.com>
> > Cc: David Woodhouse <dwmw@amazon.co.uk>
> > Cc: Usama Arif <usama.arif@bytedance.com>
> > Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> > Cc: Thomas Huth <thuth@redhat.com>
> > Cc: Brian Gerst <brgerst@gmail.com>
> > Cc: <kvm@vger.kernel.org>
> > Cc: <ibm-acpi-devel@lists.sourceforge.net>
> > Cc: <platform-driver-x86@vger.kernel.org>
> > Cc: <linux-acpi@vger.kernel.org>
> > Cc: <linux-trace-kernel@vger.kernel.org>
> > Cc: <linux-efi@vger.kernel.org>
> > Cc: <linux-mm@kvack.org>
> > ---
> 
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> > index e7350c9fa3aa..0518d5b1f4ec 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > @@ -559,12 +559,12 @@ static unsigned long __init tpacpi_check_quirks(
> >  	return 0;
> >  }
> >  
> > -static inline bool __pure __init tpacpi_is_lenovo(void)
> > +static __always_inline bool __pure tpacpi_is_lenovo(void)
> >  {
> >  	return thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO;
> >  }
> >  
> > -static inline bool __pure __init tpacpi_is_ibm(void)
> > +static __always_inline bool __pure tpacpi_is_ibm(void)
> >  {
> >  	return thinkpad_id.vendor == PCI_VENDOR_ID_IBM;
> >  }
> 
> Hi Kees,
> 
> What's your plan on upstreaming route/timeline for this? I'd prefer to 
> retain full control over this file as we were planning on some 
> reorganization of files into lenovo/ subdir.

I'm not in a big rush. I'm hoping to have this all in place for v6.17,
but the Clang feature won't be in a released compiler version until
September. :) I can send this bit separately for your tree.

Thanks for taking a look!

-- 
Kees Cook

