Return-Path: <linux-kselftest+bounces-7186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B83B3898690
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 13:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1581F22B6C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25CA84FCC;
	Thu,  4 Apr 2024 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GHw7yOx5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6DD84D3B
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231861; cv=none; b=K5IGwHPQ+DWGHMRlkmjNYDxneZssVAc+twgfeLBkHrggYkhrlHG1ZP/HYlpSFXEZ3HzLLCHRPhW1emzl+uznT8UawGiFXGnzLrBVHpTLKbMIMmStD9wE9Pikyo9jgzM6vvJPMsLDL40/0aHR8TXID8xg9jRR9gNDpj0+PHun7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231861; c=relaxed/simple;
	bh=r2y5XgIeaVFD9YYVCCQXxvPJe8jenW3QZdB/CzLVRdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC7iBRGOk+eLRPPxVKx3fC0iorsNrjF8iifNXC1SMqJbfOpExO0geV2siP4xflsi7cPzCTAePNTm+eFVciiBxzUy6kncFx6A2tZ9CxoKV20hZntbQ/9QZfqFdekSGeISuhs6OAUp55eQe5Ndf1RbHBKSai36UScPQbjMz/5i0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GHw7yOx5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so859674a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 04:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712231857; x=1712836657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wWw71C7jU1cEwI+5ODGcknLMAR0yYHVr8hihh6Lqglg=;
        b=GHw7yOx5X/R0s614/5Rftzsrr1O3kiprSpaywNMKFkoxb2PHZ5gMMWYTnBDonwIj5u
         W90RiXYhSFTzTc438kzJKNdb/BvBFWI11G/3uXbuC5BoNNl6HieILMP8xPUeJsI8UlaK
         +mbFivmR/knt0tOhbaYVybM8RaXMDjRzBnmOvY4NgbVr3duzsdmHGa044Qtcaly83HYO
         t/4ADBu49c9g/JplcxZDIzQrAXw7dkytaQ3S/V9pvxJ5MCYOQ8waR21dA/74GK1EzAnU
         wxNrZ3aIIwJ6LqfFgNl1LfylufRqSPE4hdF8DEqE5vnhA2t+bwtuRkAd37BKPkM9yNUD
         E/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712231857; x=1712836657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWw71C7jU1cEwI+5ODGcknLMAR0yYHVr8hihh6Lqglg=;
        b=YI+KX+qUqyabjfW/CSFzsHZNz0th8DjOow0iOXyu3k78WrhR0nnsZoE+UwsgQDpfwf
         ZxDFeMlRu3wd0+WrJ1cNZ5U9rXSTGhb4hW6bYo/IrrMyH/IdKcof1SBbuzvZ1cmvmunJ
         hhslDQQZ2UPjXBVhywBwqjNOz+N7r0Sa0O+h61856xPUu43Hl24gQdXSdYxa33jH7lmZ
         hcZN6dmArOjY1mlxwkCgOHSJ1JSfoM1tlS0S3kxXVxkYZ7cJXCZF+F4q42GhTiT70Qia
         CTbiwdukIV3Nrct3q+mTxnefL3ceim+xmxARrKjOcevII/rKaKUxwHL+2swNXlhgj2kp
         y6OA==
X-Forwarded-Encrypted: i=1; AJvYcCUbh3ulbfFQFvQZVHawiFryBn/5gFNpl2MYnoRs8JGjkO4WeJ/AAkWZ9FM2Ui33lvi8XGIQfcDFEBbanCKRtzi4QQotxXRDhpHBbAAhqbYd
X-Gm-Message-State: AOJu0Yyyi4Q+xDxHcqIBLasHgtbXKBTosUBLoe9Utor4J3oQDWSdyRSL
	53C3vSEBoyEtUoxFfhZPIVi+OD90ytlHZabaisY1EQLF4g/6pEdG5pWOz3b8JORatErKV6h/La5
	9
X-Google-Smtp-Source: AGHT+IF8SdqZ3HyZZ91FGKimTKayOc7UTusAbOGT6GeUZ2TkAX0/2dzA77WUR8ICDxbEhjc/oE44yQ==
X-Received: by 2002:a17:907:c0d:b0:a50:f172:6994 with SMTP id ga13-20020a1709070c0d00b00a50f1726994mr1816047ejc.73.1712231857594;
        Thu, 04 Apr 2024 04:57:37 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id g15-20020a170906538f00b00a4e98679e7dsm2355698ejo.87.2024.04.04.04.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:57:37 -0700 (PDT)
Date: Thu, 4 Apr 2024 13:57:36 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <akaher@vmware.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <amakhalov@vmware.com>, 
	Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 08/22] RISC-V: KVM: Fix the initial sample period value
Message-ID: <20240404-1c3dc9b63f80fc451d3a732a@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-9-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-9-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:37AM -0700, Atish Patra wrote:
> The initial sample period value when counter value is not assigned
> should be set to maximum value supported by the counter width.
> Otherwise, it may result in spurious interrupts.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/kvm/vcpu_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 86391a5061dd..cee1b9ca4ec4 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -39,7 +39,7 @@ static u64 kvm_pmu_get_sample_period(struct kvm_pmc *pmc)
>  	u64 sample_period;
>  
>  	if (!pmc->counter_val)
> -		sample_period = counter_val_mask + 1;
> +		sample_period = counter_val_mask;
>  	else
>  		sample_period = (-pmc->counter_val) & counter_val_mask;
>  
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

