Return-Path: <linux-kselftest+bounces-33759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA35AC3722
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 23:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A0C7A1BC4
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 21:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13301B4153;
	Sun, 25 May 2025 21:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceT//yHx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4C19CC3D;
	Sun, 25 May 2025 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748210015; cv=none; b=mSEPmm4Jjlnlo1Tqrphlq8aCTHWadcFVyjaKeQu+hV7EtLJS4KkUMQi/+DGphSacqnVcOPEuYWuMGnTXsuOs2qreM/JRz8eFq0GIisjqLq/Sw9OkJJ/ybdUzs5SQjEXC/LbkDo32/KBji46736+ERETKDqby/qE4F73LwsmWsSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748210015; c=relaxed/simple;
	bh=y5rT2ewj429hL1YZNClBKAuoapp2CjjiHYqsoHYBDa8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ivfXgqeQQawE+Act3qu6cJPHXlg2C9Rr1WGWgN2cmDTcH+gUfTWq62Qp8eMh/+ZnjW7AXEjyT46xzM9pNAuFWqcxakVkLnSozkfH4KzYT5OBLjeHBpSkk+9kYid/0nB+RzdPGzEQq3Gr4+SkcwfTCUC29R/FajMtoLLjIhKMqyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceT//yHx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748210014; x=1779746014;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=y5rT2ewj429hL1YZNClBKAuoapp2CjjiHYqsoHYBDa8=;
  b=ceT//yHx7F0JqM4+bzORHTA3Hi0DK9vzfTD1ChrJRaNLXIhJqaQrPXuV
   jeTpNhnEGDPaw8H78PwGHktNfpPl6dAdZnMrVh6xm1h0OeNOrtjXYgAQP
   HYJvVZ8LewX/ce74CBC3V2xjHqrvNUpVDNL6sJy8F3rmaul/SA3qqMHai
   2894vABY/4tUZ5uOvuNyUXGwk9+lY+VakC1LK4rQ/xwTjuuYThHsIEazu
   MYeuZPolTV3eA+ejC3fihWhKEDYqtSrkTEPhz6SgE0HplDA2/xcMU0C6H
   ve00bhfgJ3wnSFXHsbgX+rFdoGEUqCKzyEaz8CigT+qrPQKOHfw4ry55i
   A==;
X-CSE-ConnectionGUID: HQGD0TEPSUq8fOLusNMwCQ==
X-CSE-MsgGUID: NdAAS2XBR6u4/DLqkNH5Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="60435792"
X-IronPort-AV: E=Sophos;i="6.15,314,1739865600"; 
   d="scan'208";a="60435792"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 14:53:32 -0700
X-CSE-ConnectionGUID: srkUUk2LSiS9AVRoLfAP+A==
X-CSE-MsgGUID: abYToWTKQVe6L6ZrKUUaNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,314,1739865600"; 
   d="scan'208";a="141991367"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 14:53:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 May 2025 00:53:13 +0300 (EEST)
To: Kees Cook <kees@kernel.org>
cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, 
    Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
    "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, 
    Vitaly Kuznetsov <vkuznets@redhat.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Hans de Goede <hdegoede@redhat.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
    Mike Rapoport <rppt@kernel.org>, 
    Michal Wilczynski <michal.wilczynski@intel.com>, 
    Juergen Gross <jgross@suse.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Roger Pau Monne <roger.pau@citrix.com>, 
    David Woodhouse <dwmw@amazon.co.uk>, Usama Arif <usama.arif@bytedance.com>, 
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
    Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
    LKML <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com, 
    linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    kvmarm@lists.linux.dev, linux-riscv@lists.infradead.org, 
    linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org, 
    linux-kbuild@vger.kernel.org, linux-security-module@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org, 
    llvm@lists.linux.dev
Subject: Re: [PATCH v2 04/14] x86: Handle KCOV __init vs inline mismatches
In-Reply-To: <20250523043935.2009972-4-kees@kernel.org>
Message-ID: <ba4f4fd0-1bcf-3d84-c08e-ba0dd040af16@linux.intel.com>
References: <20250523043251.it.550-kees@kernel.org> <20250523043935.2009972-4-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-965883235-1748206555=:933"
Content-ID: <8656ab6c-8f8d-81d1-5dfa-740e7f21544c@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-965883235-1748206555=:933
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <fa62886f-fdfb-f2a5-84db-475ce3a46169@linux.intel.com>

On Thu, 22 May 2025, Kees Cook wrote:

> When KCOV is enabled all functions get instrumented, unless the
> __no_sanitize_coverage attribute is used. To prepare for
> __no_sanitize_coverage being applied to __init functions, we have to
> handle differences in how GCC's inline optimizations get resolved. For
> x86 this means forcing several functions to be inline with
> __always_inline.
>=20
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: <x86@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: "Ilpo J=E4rvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Michal Wilczynski <michal.wilczynski@intel.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Roger Pau Monne <roger.pau@citrix.com>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Usama Arif <usama.arif@bytedance.com>
> Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: <kvm@vger.kernel.org>
> Cc: <ibm-acpi-devel@lists.sourceforge.net>
> Cc: <platform-driver-x86@vger.kernel.org>
> Cc: <linux-acpi@vger.kernel.org>
> Cc: <linux-trace-kernel@vger.kernel.org>
> Cc: <linux-efi@vger.kernel.org>
> Cc: <linux-mm@kvack.org>
> ---

> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/=
thinkpad_acpi.c
> index e7350c9fa3aa..0518d5b1f4ec 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -559,12 +559,12 @@ static unsigned long __init tpacpi_check_quirks(
>  =09return 0;
>  }
> =20
> -static inline bool __pure __init tpacpi_is_lenovo(void)
> +static __always_inline bool __pure tpacpi_is_lenovo(void)
>  {
>  =09return thinkpad_id.vendor =3D=3D PCI_VENDOR_ID_LENOVO;
>  }
> =20
> -static inline bool __pure __init tpacpi_is_ibm(void)
> +static __always_inline bool __pure tpacpi_is_ibm(void)
>  {
>  =09return thinkpad_id.vendor =3D=3D PCI_VENDOR_ID_IBM;
>  }

Hi Kees,

What's your plan on upstreaming route/timeline for this? I'd prefer to=20
retain full control over this file as we were planning on some=20
reorganization of files into lenovo/ subdir.


--=20
 i.
--8323328-965883235-1748206555=:933--

