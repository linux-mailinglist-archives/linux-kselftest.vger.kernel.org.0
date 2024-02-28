Return-Path: <linux-kselftest+bounces-5533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F39B86AFE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 14:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00CC1C209B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DA814A081;
	Wed, 28 Feb 2024 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OUXK/3LT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BADB149DE2
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125669; cv=none; b=u+R2RiTzZBLuoKE169vULSqXe2ZNtHtHiBKWehpkYDod0GBIhmclPsC0F4WTCO2aODeqFUu4xV0803ytDOCjj/SvsgIZbK420Llj+gnUqBaeLtY1fyCCPgoPfN0guckqHy9PY4yj4MJV/nXa7jj+345sdaN25ikoPPFKi6GTcs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125669; c=relaxed/simple;
	bh=lnm+0EEdegAjRqKT4byJnEVNNkPFSOBtM19dPMn2Bzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRLLfoInQDkG9XwhSNLiMlkEEu6KBQhWLD1FN42k8NyMnqquWDXuY+3mk6E2jtVaa+qvQU276GFUstazHH5Ky80P6izWmtKKRZ8/8sLS+m6mQyjJPHBrDxZBd3IA6CPWAAkDplEdKtKWAt8faMTCv1ukqHxN0c3pv/1moG8wY1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OUXK/3LT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56657bcd555so1329551a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 05:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709125665; x=1709730465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uyEO6boa+xJ/OQch4N2V/Css5OUzCe/Ii8yKVOFLc2o=;
        b=OUXK/3LTKhbdyQbLtfnVmMJZLzIY+m3Awboab9MSNs5NwpVENWUCqKXR+YpAfeDIgk
         znNiBjpkcKsSK5LWX+bvgJ1sd8RocSIlluyWk8gSfiZ16zAQ89bG91MAYC58owfoFUQI
         ECwYS0HSgqStYFKkAUPUmpiqAdwvspBQIoJiOoxVZmVSYUKdzT4lDoGPOuvLaPQW6cdE
         yHR8zt03CS5+3Bdxbm9DP0LDz834recZ5LsuYd3ij1vZQHMpImPcOeUL1/AFkxvJNhw3
         uNs1OGcuhIAhXsfNtuTTqWr328g2mtut8gOXQaqRpjGr6CY3q1Wv9Jz6UAUWZMVBz3Hs
         hGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125665; x=1709730465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyEO6boa+xJ/OQch4N2V/Css5OUzCe/Ii8yKVOFLc2o=;
        b=utT6gTcv4cluR+YvJl+THt17y2baZez9kM9B791PMPqxORbKZ9HzglNSoV7NWKYOe8
         /bZByWvgIZ2g9A5uOxU5nt5fl7TKDbd4TnEdFOtbvOHGr1ntCG0ze/teo67btlFVt7XV
         FyTNYWbOGc7lKvwm+67nLURfRjo1mIQOmajgnHYvu3xU9r/07ZTK78kpqrE+tkO8sua4
         e74AzPCAwHlGLXzuqynZUgmHsyLKdBXSQhM6uxzfLUEZxiklo8SAlhf7wJnLvqnwZWCl
         WozRv/3WIRkPpDdNr1KSA6331EpvTB+SksPc/wbS/ma7gd0c2ScR6Nk+PdSOyDQm5fZT
         PIrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDSgSksfctkymExNJtok5KZ1W0ZSO/ayDhR81P+ra1yKo+1XO2nAICmgS13wWmN6zE/5Tdt1yNjsd51ozYWGdW0xRu/xA0c7JrRvdls14m
X-Gm-Message-State: AOJu0YweZyLj+7z2tibyuw0toPzXHWqcC2Nl0yWHnh5bRFkVqJl8HaZd
	3G+EPcslMDEAf/S/F2c/WT2QAU/sW64VcZpny9DQezRZnuG/OawtVd7PjYJEk8Q=
X-Google-Smtp-Source: AGHT+IHz6Q/4cwrnVSPpcLF88omhchUxt+jZb2vdilR4dpr1cIS/m3RQ1nQ+HOnDHiBkqjyTNNA/5Q==
X-Received: by 2002:a17:906:5651:b0:a43:164c:cb3a with SMTP id v17-20020a170906565100b00a43164ccb3amr6249584ejr.53.1709125665459;
        Wed, 28 Feb 2024 05:07:45 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ts7-20020a170907c5c700b00a43f4722eaesm705990ejc.103.2024.02.28.05.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:07:45 -0800 (PST)
Date: Wed, 28 Feb 2024 14:07:44 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/5] KVM: riscv: selftests: Add Ztso extension to
 get-reg-list test
Message-ID: <20240228-8e0f8611d2f45f71c04ead57@orel>
References: <20240214123757.305347-1-apatel@ventanamicro.com>
 <20240214123757.305347-4-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214123757.305347-4-apatel@ventanamicro.com>

On Wed, Feb 14, 2024 at 06:07:55PM +0530, Anup Patel wrote:
> The KVM RISC-V allows Ztso extension for Guest/VM so let us
> add this extension to get-reg-list test.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index 9d9c50b68207..5429453561d7 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -73,6 +73,7 @@ bool filter_reg(__u64 reg)
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZKSED:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZKSH:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZKT:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZTSO:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZVBB:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZVBC:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZVFH:
> @@ -436,6 +437,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
>  		KVM_ISA_EXT_ARR(ZKSED),
>  		KVM_ISA_EXT_ARR(ZKSH),
>  		KVM_ISA_EXT_ARR(ZKT),
> +		KVM_ISA_EXT_ARR(ZTSO),
>  		KVM_ISA_EXT_ARR(ZVBB),
>  		KVM_ISA_EXT_ARR(ZVBC),
>  		KVM_ISA_EXT_ARR(ZVFH),
> @@ -957,6 +959,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zkr, ZKR);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zksed, ZKSED);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zksh, ZKSH);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zkt, ZKT);
> +KVM_ISA_EXT_SIMPLE_CONFIG(ztso, ZTSO);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zvbb, ZVBB);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zvbc, ZVBC);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zvfh, ZVFH);
> @@ -1010,6 +1013,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
>  	&config_zksed,
>  	&config_zksh,
>  	&config_zkt,
> +	&config_ztso,
>  	&config_zvbb,
>  	&config_zvbc,
>  	&config_zvfh,
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

