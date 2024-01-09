Return-Path: <linux-kselftest+bounces-2767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64248828E8B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 21:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EEE286AAE
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 20:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF143D96B;
	Tue,  9 Jan 2024 20:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ceez6eWN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90CA3A8E3;
	Tue,  9 Jan 2024 20:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b2HomVXY7FzMXkiwOxrMKlwOQEHDYNZAL5sKCtuBtfk=; b=Ceez6eWNOAP75GYM7O6sxoxLMK
	sEyjYspnASHzv4goTZkwM3Azj9T0S7OArOGxOU0BOxqwe41T54sximqesBg7tYZ2EljvmUQbzuqfs
	HtwprQ1pepzRo3YWq4OU0ZII2MeOfSxGvO9mWRXg+B1f4bGSCsXK93nokeodRy1CNMbURutmgvIXr
	0KZ+RyDs4RA8S5DouFLHfXW22t6qXMqJWoS2/KlDbl+InFqT8xmW7WSXCHnEoq+Zz7ODVYHdpWcbX
	4+8Ux7WmXEdCstEG7wBE3mnDIhmtbpiK7ct9wzwe/d/z5PliZNsv5D0yOj0TOzGJyppNW3vNYrnVF
	herDEtbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNIq7-00AIGa-4i; Tue, 09 Jan 2024 20:36:47 +0000
Date: Tue, 9 Jan 2024 20:36:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
	sroettger@google.com, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org, usama.anjum@collabora.com,
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [RFC PATCH v5 2/4] mseal: add mseal syscall
Message-ID: <ZZ2uXyPCE+l2Uccr@casper.infradead.org>
References: <20240109154547.1839886-1-jeffxu@chromium.org>
 <20240109154547.1839886-3-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109154547.1839886-3-jeffxu@chromium.org>

On Tue, Jan 09, 2024 at 03:45:40PM +0000, jeffxu@chromium.org wrote:
> +extern bool can_modify_mm(struct mm_struct *mm, unsigned long start,
> +		unsigned long end);
> +extern bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
> +		unsigned long end, int behavior);

unnecessary use of extern.

> +static inline unsigned long get_mmap_seals(unsigned long prot,
> +	unsigned long flags)

needs more than one tab indent so it doesn't look like part of the body.

> +{
> +	unsigned long vm_seals;
> +
> +	if (prot & PROT_SEAL)
> +		vm_seals = VM_SEALED | VM_SEALABLE;
> +	else
> +		vm_seals = (flags & MAP_SEALABLE) ? VM_SEALABLE:0;

need spaces around the :

> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -17,6 +17,11 @@
>  #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
>  #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
>  
> +/*
> + * The PROT_SEAL defines memory sealing in the prot argument of mmap().
> + */
> +#define PROT_SEAL	_BITUL(26)	/* 0x04000000 */

why not follow the existing style?

> +static inline void set_vma_sealed(struct vm_area_struct *vma)
> +{
> +	vma->__vm_flags |= VM_SEALED;
> +}

uhh ... vm_flags_set() ?


