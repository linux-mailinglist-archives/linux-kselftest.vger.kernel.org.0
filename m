Return-Path: <linux-kselftest+bounces-7957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA038A510A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 15:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECDD1C21E0C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 13:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8D812B159;
	Mon, 15 Apr 2024 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pqBdIetp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E59C763F7
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186402; cv=none; b=ksNEVm8ZWWOLyv4Aipb4JSoOY+7ul7XaEowLAhIDAanLuulGIsXvwsqKm3ojImelPAyVYHWORW6TBAmpfRF9ktsjIL1WHEGZ4m235vrIlXTz3+LAUsKzIlH4ZKo1hOFRf6arYCtu3W8JGAaq91BfZBF5FOLAA+HuoEK7csMDF80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186402; c=relaxed/simple;
	bh=ROXk9XS99J8mzxWv8tUd/6Kf37JaYFVRZLkuT1TMEa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAxftLlBqVnVcTfpRvQCefKwfmhf6Q5JAXtWWlG2GDgkeVziRkZpFplGTTNoINab66VshyVm1KPsMuR1yI+LEf6NjHNmsXRJOIHKoYNo1v0JB3/WLiCoSFbIoo/n3c6gsGtvceOiWZT6RaRD39rvwderTYRVLriq/J8xSW3Bf2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pqBdIetp; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2da888330b1so11388501fa.1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713186397; x=1713791197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+QRCDHPbz+mQnU+rPEOfZ5PlBfWp32GZiq6bjgpQeA=;
        b=pqBdIetp1ApKhfa07J5SnT+A8wbQo73Ivvy4FEhtJJpDDvhhoWZO/QEVa3Q8z6M5ul
         qJxt7c8v8F8W4qaeKXAsOI48zUJ145oZcnAzXAqsw+8Xk/R9pZQVwgfISetCpNszOEiD
         SZF7/GctaDrg3IZHXSae34s6pZLBiQEaP2I75G4luxMUhlqca216vlZ7bY4TVJW8aX+e
         EkwduIBbbqeN5KW0ukJN0Y7/zA3dYWp8EgRy4l9MsUJV6A35J106u7OfczffMys31OkQ
         4F2a639vPxfuPo8N1lGnvV4olcrCtbK0zn3/3vV2KTHToJ3E7wTq01WmIuDeFuDjfQju
         qlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713186397; x=1713791197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+QRCDHPbz+mQnU+rPEOfZ5PlBfWp32GZiq6bjgpQeA=;
        b=Z8ibkiS+Q+Jqq79xX88pOF/0XEcAwvZgi/pCtO7w2Z1yzKwJuunurQwxyl70VHkDl4
         U5RNLCsAZytGdJVR8d7hBpv5w/zdRo5hroJR574gWvoZFs8adny3x0fGzLCN+r/ic/9E
         jhh4kKX0ejMsVbR8S1qQKHQfrahpVVdGkWFh2e0Yz1nN5lgZZ2uI4PQ72iCkUfG7tkkn
         E9/ZXHx4gzNNTygnSFP0wlOgJG0plwBGwz2iorT62PAB431Eet4dawE67N5+B/hcz9+N
         j89O2oKX8F3h1CkwllyRYdAWYpYLun3z+ljKEqdHzIaOQPf7w4Wqxq2QYsLC7f+0fUqi
         c0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXM8AKJKxroKfC7pW0kzZPfU3dTwNiRibzBLVNk+aM0TP8CBBiXz0PHVwTv2fUQxGmd72y9Lx6d/c0uzXTf325GFRcg/a3sivwfdTvxkqIR
X-Gm-Message-State: AOJu0Yy+Fl6EuP/Z1zb2K2AW5qfmcAGTw/xh0xNgPDCaUbeqSDOpQTrx
	7eY/rzz2/u8p5HhbV/b7Ma7xCGEYLZE/G+wO7efNgFHrDh+QpULPY7a899lORXM=
X-Google-Smtp-Source: AGHT+IGFmVnC0mQLQib6YvAkM+B394OqmZQ8G1VQ5hm0jgJqcVKUD4C5OhCM3fHue9y8M9iXA9JCIw==
X-Received: by 2002:a2e:be8b:0:b0:2d8:dd28:878e with SMTP id a11-20020a2ebe8b000000b002d8dd28878emr7797631ljr.2.1713186397221;
        Mon, 15 Apr 2024 06:06:37 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c510400b0041624ddff48sm19436126wms.28.2024.04.15.06.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:06:36 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:06:35 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, 
	x86@kernel.org
Subject: Re: [PATCH v6 07/24] RISC-V: Use the minor version mask while
 computing sbi version
Message-ID: <20240415-e229bb33ad53ce43e3534f5a@orel>
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-8-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411000752.955910-8-atishp@rivosinc.com>

On Wed, Apr 10, 2024 at 05:07:35PM -0700, Atish Patra wrote:
> As per the SBI specification, minor version is encoded in the
> lower 24 bits only. Make sure that the SBI version is computed
> with the appropriate mask.
> 
> Currently, there is no minor version in use. Thus, it doesn't
> change anything functionality but it is good to be compliant with
> the specification.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index f31650b10899..935b082d6a6c 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -367,8 +367,8 @@ static inline unsigned long sbi_minor_version(void)
>  static inline unsigned long sbi_mk_version(unsigned long major,
>  					    unsigned long minor)
>  {
> -	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
> -		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
> +	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT
> +		| (minor & SBI_SPEC_VERSION_MINOR_MASK));

The previous version had ((major & major_mask) << major_shift) | minor
(parentheses around all the major bits before the OR). Now we have
parentheses around everything, which aren't necessary, and no longer
have them around all the major bits before the OR. We don't need the
parentheses around the major bits, since shift has higher precedence
than OR, but I'd probably keep them.

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

>  }
>  
>  int sbi_err_map_linux_errno(int err);
> -- 
> 2.34.1
> 

