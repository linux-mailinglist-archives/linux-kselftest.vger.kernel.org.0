Return-Path: <linux-kselftest+bounces-37550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262E6B09E24
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 10:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6872616BB1B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A268F29290A;
	Fri, 18 Jul 2025 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmH8kuFD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D450EEDE;
	Fri, 18 Jul 2025 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827814; cv=none; b=eyntYJaOy4gIbuISg5O630Y3+5gvaeJoIPU5cSsM1zFktkufsRKTpjqpx2pgpt+IPwN7XBU8WWtLt0tmjLElX0aObU4eKT+vhvg5ZmeV+wp+xWFYOduL2bGAPGrdT5VPR/k8Tp5GEKT31wuC57UESjfPK1YoN/M9qoGuEDP9WlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827814; c=relaxed/simple;
	bh=HL/2nr+vhFKcEcF58riyFRNQttwiCB/9fGbm+q71Dgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+ghDL96vtdztCGorIA7DWIOOdf3DXo+Wqg5kLolqXr6ayiQzjOmRia/r8q4X1I14CjPThK4ekcYbFzW8537oqCW9rsqJ8wtvZcqT91ucl1IZaajfkMJtQqhTCr7hJw42ia2cDlSM1WIbLcEyX3ka6/I+xVulGxVk8ujaDDQRhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmH8kuFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E585C4CEEB;
	Fri, 18 Jul 2025 08:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752827813;
	bh=HL/2nr+vhFKcEcF58riyFRNQttwiCB/9fGbm+q71Dgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmH8kuFDP69wLkOjDvdpYL8g4oErm+tCxzSYFjNficaE3yVU2VDi2CVybyh3k2vzL
	 ktrs4o3SmHh9+Ti01m0+zENfWaUVs3rPEOFccIDJ8JzUuMBm7vzDhfYqgJjGzyUfX2
	 tzprzSBZDHn6R6ZCy1S+ooHnVTZn0aRQWwJVACdL/lb02WuONW5CmJoAQ+l6IEgvXV
	 YUoaFOXIVofvTGsxJhTxgxblsj38dHI42GL2cErPbWSgZ0WyDVaDQIEbTqk0zRmB/4
	 6UGfFtVoeLA7gIVsJdymOjI/f87nJMUh+D/2j397DUryS3KRRsJ57CDJHeSOO9dNdu
	 VnRo0rjVmoxGg==
Date: Fri, 18 Jul 2025 11:36:32 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Kees Cook <kees@kernel.org>
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
Message-ID: <aHoHkDvvp4AHIzU1@kernel.org>
References: <20250717231756.make.423-kees@kernel.org>
 <20250717232519.2984886-4-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717232519.2984886-4-kees@kernel.org>

Hi Kees,

On Thu, Jul 17, 2025 at 04:25:09PM -0700, Kees Cook wrote:
> When KCOV is enabled all functions get instrumented, unless the
> __no_sanitize_coverage attribute is used. To prepare for
> __no_sanitize_coverage being applied to __init functions, we have to
> handle differences in how GCC's inline optimizations get resolved. For
> x86 this means forcing several functions to be inline with
> __always_inline.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

...

> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index bb19a2534224..b96746376e17 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -463,7 +463,7 @@ static inline void *memblock_alloc_raw(phys_addr_t size,
>  					  NUMA_NO_NODE);
>  }
>  
> -static inline void *memblock_alloc_from(phys_addr_t size,
> +static __always_inline void *memblock_alloc_from(phys_addr_t size,
>  						phys_addr_t align,
>  						phys_addr_t min_addr)

I'm curious why from all memblock_alloc* wrappers this is the only one that
needs to be __always_inline?

-- 
Sincerely yours,
Mike.

