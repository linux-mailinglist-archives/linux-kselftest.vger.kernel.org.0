Return-Path: <linux-kselftest+bounces-39121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3ABB286FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 22:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5FD16E517
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 20:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADE32BDC3F;
	Fri, 15 Aug 2025 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DEN4zXX0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE4727F01B
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288879; cv=none; b=qC8jq1KxKhSHWML+LPrYj+72Bw7aNmmE7MS+YEGyuWGuk3ki10UomiJH6Hp54B2u1sHyYtTfDnNiKmH730Yz2xl/vudP6Guoe/5d/crFsDpZYwivZl0uTz0ULaIV880LoRtRUEokxS0nIU1ij9feCPp7iAKondxYrk+sPTZli80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288879; c=relaxed/simple;
	bh=gPLPrgsC04mCj1/YNA/33OZmUtgG2yG+9SpPvMJTiys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN4p5H1r0PS95KGaFhn9ez/Eu+t6GO9xBj239RwnnJGKPck1ylh/Tqx9qXyJojRkLTO8nuCZG8YGSMxAoWTKl4c6zKSl+6+zl2Fsn3kxnPqOQDgbW3cBO/iCs2D0QtSNfh0Zhc/YYML2tO3eP+amLkDLmrIHjgsa21Z2y9+LVQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DEN4zXX0; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3e56fe580b4so10396855ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 13:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755288877; x=1755893677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oiZcsRXblDK+QsurtCHU3wPd/EqkMipNd3cgRBpokNI=;
        b=DEN4zXX0g5wv4pwMd9nNehrcNi9sHM3eNhCz8bMEvAJlq2Cb3FDM0CSIGzM+H4m2eP
         1i2ap60dfF1GRai4YNn6rJr9UFyW2k6uK35mIQL/fuzPdpFycZVktaaS+dH3mK9npEg3
         2t/14qA1RXuKeET4ix1g+g1i5T5PIOZiC4w62QVqC3757THMKGvKsVtOaYHT1uE2Gwu+
         XYjcqyrv6VnJEL5Tw4BTKUkNWXvGz/mcnUhB8yP/Af/e1tlkym0nH2/k5UqT6Oq3VZkx
         jo3WwjLmHAkN+SpbC9GjPRXfA8ZLEZp+OcOjjnJr3+H3tOEyW0xYkVnKoGFdgjCjFkE7
         1ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755288877; x=1755893677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiZcsRXblDK+QsurtCHU3wPd/EqkMipNd3cgRBpokNI=;
        b=LBkNcKD1Vz0uAdhfVWf5vuDy0jR7hgBbmp4VlZhoAzsWBJnRVgwTfP7BnkRNJHX0NK
         yUSVPeSoi3TINYrP55HA0kaWYvu43hYDewS52LtKp7+BhRuE/fkdhlOObVpS4yPm7X60
         3lBgi2yYXx+jgHzvSsvx1l7TCnKKjyne9IyTIdVqsIdfzNOpvf78NE9+Rdfbrr+3WsA+
         Wq//zpQOyi4OEk7EyXvA9zx+PoZhVIXN/2PtjXD4UHAQkepa0X5Ug1WLvJv+5USeoiJj
         UVI6twCxslN2c9eXGW3xaz62YpZisOq7JRu5mJVfnW1waDDdekzboqlfnl/IoCWVFi5m
         fwCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxor9t+bdHz8qKD7r3UCqLl3dAOMqQ3nlJa9IxbIPW8XJGxDSWsaob4CQWdypDliSrgj+KCB6DFEzpjpx+xz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/1IgxfXlAHVsa/GjloFcuSelAhjtre9lmEad5yuUmtrFN9AEy
	RyzZ1FTxeCSY6bgM3a5SDpRoiNaqT4Djt2nEzE6/9NzRo5lDNbTebLFwHNABe3lpkEo=
X-Gm-Gg: ASbGnctliiSmRo4oprvoFaj17ZM+lMqvq+PbFmOQ982ddbJjJafLIGXEEbHpswnqC8b
	zAqc+RLThwLs9bQiHOB7Z//5zciqocTytuckSdj1i7+dtKHrgOkmuTY8umSwYq2ja/i0/qxBHJX
	ntbSrnn6vcaC3L4rrY4HAHIRoF1TUNarffiwjWvf9HKWcVxKGWS6gH8fmnM7uSdAvuEYaxNre44
	I+fyMXx/7UTteTimatpjPgihMKj9wr0hL1RcJSpXaPdxc1OHfKdyneQ18USCkL/MF4SjqDzksDG
	AkPkWAQZsREcKpPOSAJGN/CoGhiGqLILhWXxY3eD+91GXnl2eia4Oep4TcMjkTWQHT7RmL5hsw0
	gvVtMV9fnHU5L1axFU5aNxXZp
X-Google-Smtp-Source: AGHT+IExUiAjUdPYMjUNNYaE14vRBPYsuuXTciG9RIicgQedUovVnhzk5z3ol3/Zbxwlnlhc2kiZ3w==
X-Received: by 2002:a05:6e02:1a4f:b0:3e5:469e:b105 with SMTP id e9e14a558f8ab-3e57e9d1a1fmr71697515ab.18.1755288877401;
        Fri, 15 Aug 2025 13:14:37 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c947f547bsm634066173.43.2025.08.15.13.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 13:14:36 -0700 (PDT)
Date: Fri, 15 Aug 2025 15:14:36 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/6] RISC-V: KVM: Introduce feature specific reset for
 SBI FWFT
Message-ID: <20250815-30ccdcf30a9746a3b2443b4b@orel>
References: <20250814155548.457172-1-apatel@ventanamicro.com>
 <20250814155548.457172-3-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814155548.457172-3-apatel@ventanamicro.com>

On Thu, Aug 14, 2025 at 09:25:44PM +0530, Anup Patel wrote:
> The SBI FWFT feature values must be reset upon VCPU reset so
> introduce feature specific reset callback for this purpose.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/vcpu_sbi_fwft.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
> index 164a01288b0a..5a3bad0f9330 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -30,6 +30,13 @@ struct kvm_sbi_fwft_feature {
>  	 */
>  	bool (*supported)(struct kvm_vcpu *vcpu);
>  
> +	/**
> +	 * @reset: Reset the feature value irrespective whether feature is supported or not
> +	 *
> +	 * This callback is mandatory
> +	 */
> +	void (*reset)(struct kvm_vcpu *vcpu);
> +
>  	/**
>  	 * @set: Set the feature value
>  	 *
> @@ -75,6 +82,13 @@ static bool kvm_sbi_fwft_misaligned_delegation_supported(struct kvm_vcpu *vcpu)
>  	return misaligned_traps_can_delegate();
>  }
>  
> +static void kvm_sbi_fwft_reset_misaligned_delegation(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
> +
> +	cfg->hedeleg &= ~MIS_DELEG;
> +}
> +
>  static long kvm_sbi_fwft_set_misaligned_delegation(struct kvm_vcpu *vcpu,
>  					struct kvm_sbi_fwft_config *conf,
>  					unsigned long value)
> @@ -124,6 +138,11 @@ static bool kvm_sbi_fwft_pointer_masking_pmlen_supported(struct kvm_vcpu *vcpu)
>  	return fwft->have_vs_pmlen_7 || fwft->have_vs_pmlen_16;
>  }
>  
> +static void kvm_sbi_fwft_reset_pointer_masking_pmlen(struct kvm_vcpu *vcpu)
> +{
> +	vcpu->arch.cfg.henvcfg &= ~ENVCFG_PMM;
> +}
> +
>  static long kvm_sbi_fwft_set_pointer_masking_pmlen(struct kvm_vcpu *vcpu,
>  						   struct kvm_sbi_fwft_config *conf,
>  						   unsigned long value)
> @@ -180,6 +199,7 @@ static const struct kvm_sbi_fwft_feature features[] = {
>  	{
>  		.id = SBI_FWFT_MISALIGNED_EXC_DELEG,
>  		.supported = kvm_sbi_fwft_misaligned_delegation_supported,
> +		.reset = kvm_sbi_fwft_reset_misaligned_delegation,
>  		.set = kvm_sbi_fwft_set_misaligned_delegation,
>  		.get = kvm_sbi_fwft_get_misaligned_delegation,
>  	},
> @@ -187,6 +207,7 @@ static const struct kvm_sbi_fwft_feature features[] = {
>  	{
>  		.id = SBI_FWFT_POINTER_MASKING_PMLEN,
>  		.supported = kvm_sbi_fwft_pointer_masking_pmlen_supported,
> +		.reset = kvm_sbi_fwft_reset_pointer_masking_pmlen,
>  		.set = kvm_sbi_fwft_set_pointer_masking_pmlen,
>  		.get = kvm_sbi_fwft_get_pointer_masking_pmlen,
>  	},
> @@ -321,11 +342,16 @@ static void kvm_sbi_ext_fwft_deinit(struct kvm_vcpu *vcpu)
>  
>  static void kvm_sbi_ext_fwft_reset(struct kvm_vcpu *vcpu)
>  {
> -	int i;
>  	struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
> +	const struct kvm_sbi_fwft_feature *feature;
> +	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(features); i++)
> +	for (i = 0; i < ARRAY_SIZE(features); i++) {
>  		fwft->configs[i].flags = 0;
> +		feature = &features[i];
> +		if (feature->reset)
> +			feature->reset(vcpu);
> +	}
>  }
>  
>  const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft = {
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

