Return-Path: <linux-kselftest+bounces-33652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1A3AC251F
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 16:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E851C540879
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 14:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238AD296158;
	Fri, 23 May 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b84De/zP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA0295D8F
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748010912; cv=none; b=klSOKjBdpSbXEvtaRtPi9NKzBj+20aWLmXxWbrZbePzVIvl+9A1DoBDLAp3Stkmr1B25+gRrmihROUqZp5f2kOMaEMch9xDxXoDyaZTejqItf3V9Tjnfs19X68z3vyuKvuDuDZ+LXb65HjzyKA3EiO4tKqUVYzD+GKBjVBmto0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748010912; c=relaxed/simple;
	bh=rpziN1/05Zj11wUE9u4BbCxVKKTZOSPJiBdxOoe4oCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eT4cLg0jjNypPDnHx64McQ2zgU2bn43Eyc3ooEw1459fVtoKCrji4a6VEkhgP1iYQxu55rkWA6S+jg4yA/e3nnRbh4gjDtfl1RnG+Mo2vIunarwTqxd4xZ/zZ1xVa165HcZAlFchmmaEstU4b2I9DwSZg0dAdgbq9Bjh6EGk0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b84De/zP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-231e76f6eafso66656425ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 07:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748010909; x=1748615709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OHIXFovAEYPRF7pj3DkvXM+Wh6ry7OAZQdb2dc5cgKo=;
        b=b84De/zPy6OG7FPMct1S/l0RArSEw077OwRFF8QI1wCXcsIr22NtiTb84AWT63UXbP
         RfM3rq17cVcnzqgWKhmBoF+fXJTWsZbY4F/p8C/xjl0ettvBg6kn/kgB9W5QVh2Yvi2Y
         4Mf+ZzIJd2th0q3njefRUC3Dj3tZTzrFD0do/0h28Lgx9fGfwnW5b8SZ6IMBZurC3HOM
         p9dzZj/9SpMFYBFzYmh/PlOz/oMQz0ZLLY3NlRWunqFyPr8lpy6o1b4lIbxcOhb2xIKd
         BdsWUWUpRel+re7QfPTc+rW7RtdZgHK2xYATjZ0VzkEICtxIe8tLX8GxMjEOKKkXoQ6O
         +4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748010909; x=1748615709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHIXFovAEYPRF7pj3DkvXM+Wh6ry7OAZQdb2dc5cgKo=;
        b=PxVc8yI//TH2AyoHKsz24eOQoh7FNUhzJSIG84DwzFwtGKBHRpfrel8NqNty6RhXwH
         njrkAK+YrxPNQ3k2r85njwDrvLACrILgLSl2LMCtDdRi/jqWAXHPyU2helwFezalm2as
         UTidv3+sd7J+Gdm2uRxuHAGKi6myFfhIE5iQwodZDV4Cip9j9NYmW4xhkgBA3hk+F0Gx
         e0n+L0x5h4p+w8e/MYFEIXJ+5d3kwgFS20vLTO1d/apS0PnfMzNN2D0r1QFOMvyCJepK
         shXH1809tMJw9eHUfxu3PZDEeSYDHcfLOd5ifx/AKnpCFSLgcMlwFkMBQE4377BI0p7u
         IrXg==
X-Forwarded-Encrypted: i=1; AJvYcCUPhEt7lMKiBaJmokGYVNXftNxFMlFKmru1mbpUdWZwMao3mXTJa0PgOMgjg0qTIHM2YKpOWdvannepijPL5do=@vger.kernel.org
X-Gm-Message-State: AOJu0YyutWc66rOegUnNQG4wYGVnc1pzIQmdAFX8SuilOHBxU+jpiC9G
	tltmcIjN8oP3vn2iDO0ARTTAeG/LA7DSyxQanP9w2IUoQk/xKw2lsG4xSYXztNVAbgLl50cO7R1
	fwA6H4w==
X-Google-Smtp-Source: AGHT+IFz7sb0nLy8RLNRfKCeKqRGA0z4OYWQ9Q5+lv5cIKJ3DXiQQbAp7L//6YajGR6GltgQpVeH/+sDQGY=
X-Received: from plka13.prod.google.com ([2002:a17:903:f8d:b0:231:def0:d268])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41c7:b0:224:1221:1ab4
 with SMTP id d9443c01a7336-231de317b43mr439457305ad.22.1748010908457; Fri, 23
 May 2025 07:35:08 -0700 (PDT)
Date: Fri, 23 May 2025 07:35:03 -0700
In-Reply-To: <20250523043935.2009972-4-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523043251.it.550-kees@kernel.org> <20250523043935.2009972-4-kees@kernel.org>
Message-ID: <aDCHl0RBMgNzGu6j@google.com>
Subject: Re: [PATCH v2 04/14] x86: Handle KCOV __init vs inline mismatches
From: Sean Christopherson <seanjc@google.com>
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
	Hans de Goede <hdegoede@redhat.com>, 
	"Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Wilczynski <michal.wilczynski@intel.com>, 
	Juergen Gross <jgross@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Roger Pau Monne <roger.pau@citrix.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Usama Arif <usama.arif@bytedance.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Thomas Huth <thuth@redhat.com>, Brian Gerst <brgerst@gmail.com>, 
	kvm@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, 
	platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-mm@kvack.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	sparclinux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, May 22, 2025, Kees Cook wrote:
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 921c1c783bc1..72f13d643fca 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -420,7 +420,7 @@ static u64 kvm_steal_clock(int cpu)
>  	return steal;
>  }
>  
> -static inline void __set_percpu_decrypted(void *ptr, unsigned long size)
> +static __always_inline void __set_percpu_decrypted(void *ptr, unsigned long size)

I'd rather drop the "inline" and explicitly mark this "__init".  There's value
in documenting and enforcing that memory is marked decrypted/shared only during
boot.

>  {
>  	early_set_memory_decrypted((unsigned long) ptr, size);
>  }

