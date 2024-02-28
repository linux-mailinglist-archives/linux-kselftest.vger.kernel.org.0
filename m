Return-Path: <linux-kselftest+bounces-5537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FA386B001
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 14:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA3D1F24B08
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B81B14D426;
	Wed, 28 Feb 2024 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SfoL4P+F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F314CAD1
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125832; cv=none; b=cGSRK8b8M2jekulVradf6XsFoWo47RmKGaD0wjLnkQFL2GmJpr5YwS2VTCahDFZsjzP5Y0A0bpS5yWEBnB5lhJRWXFh0Vm0VUh4fxPb/vHLP4c1xjNnjOGHMpdE7b1KLG3yZmiRSOclrRoZcrFMO5AsTgnFde/mQGvVi3I+ZwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125832; c=relaxed/simple;
	bh=y+XQ8TER6IUelZZXjUiPLMXBHKScWmB2tiHBXkIHb4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2tu+DqRuhuhYIvVoBnbDXj7sfTQeyRvblG/p4EcKOzO8D3mQIuz02hM2babvzXQfsWtFh2u47VbxRT8wCf2AII5XayLG7s0SCHQmSBGrl8sLunvo7i6x7dFxmjnAXMdSiB+BGb/91UfgR0Th6XSKpcHn7dbJVYs+9H79Qirn9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SfoL4P+F; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a26fa294e56so915672566b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 05:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709125829; x=1709730629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q2NAebkb74PRN2BzyJL1cyLz7aGeJCOrEFsttYow7lE=;
        b=SfoL4P+FPplg00DH4rhlv5mX5o+wIbNBKxndiTNqLidRcd2Qlfu+5dJntU5/XK94vT
         YUqsMv57EpW5+Wbt0A+jbFJHWgf/pzxKQ2IV2PZKtD4VCPGBeeatQpNmicVapDUKGwTO
         P56rfwNo0tuB5bYhiCtLy4xB7Hm0z85DLLXvQyIsuubAh5S82i/PE7obdGmLLuyEhQmO
         286Ehtno8UPieS6dpKQXsvVBd4W5lJKQ/L5W6T0prMUrW70LoINRdfgOn5XQZC+1iIGh
         J7y73HRAfdW96p6XtWnG6yUr0HScGKnJQapPqQRU9IHNRgh5msnfNvSAY4gMJpBVeghn
         mOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125829; x=1709730629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2NAebkb74PRN2BzyJL1cyLz7aGeJCOrEFsttYow7lE=;
        b=hh3ydqlirT4E93qO+NeJEP9yJZO0PJgfmtNLttp2saCkwIrV3ewN/wZHNpk4hH+wm8
         B7mx1Za92UUXVmatZdAD5h/fZLLDrsjYGYemY0qq2yxi7EufcNl9ytq3ME0yIDx+5HrD
         KK+66T++JAJTytjPJRtHHRCjCzXTV4IJ7h3cwpfwv1H8tc6mjt70V53lDQnmrCzhZS6q
         0no8WRtWmFdA4WdxEKZjzXI4IwIPFojmlECvTwK6UVX85i8nthlXhvUgcRgmVwI0TGBQ
         69Y4wH8ufPL4SbScXXdBoOKWxy8v7CyjCr1rle97IeFaqMjq72gCyoIVHAIyQDioG6le
         q1hw==
X-Forwarded-Encrypted: i=1; AJvYcCXke/Pj4E+MavlR0+X0AkbOiFyRGdkEpOakft/n/3pFUDgjdEsInb189DkyVDShtvlKV/Lhpo333KZXlSWRk1/sKLfmH61LIHiR2UUy/Mrl
X-Gm-Message-State: AOJu0YxDu2PdZyWCUxSjXTDkBEqv/CYA6Ikejw4tr+E9K6gn3yUMmstT
	wXEp0hQGbLtdsJZv/HQdMkJI66VNlY+oh5WZznqBzyobu13Pr/Fl9kzfW69tw90=
X-Google-Smtp-Source: AGHT+IF5HIjUzKDomFUnEg6DOvdb72PcuesnipX63O5viuhCdygq+/+gijCmgtIJP5epcZJ7ZF3eDQ==
X-Received: by 2002:a17:906:c305:b0:a44:21c4:91b3 with SMTP id s5-20020a170906c30500b00a4421c491b3mr105263ejz.44.1709125828798;
        Wed, 28 Feb 2024 05:10:28 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id i25-20020a1709063c5900b00a3f596aaf9dsm1851570ejg.26.2024.02.28.05.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:10:28 -0800 (PST)
Date: Wed, 28 Feb 2024 14:10:27 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 5/5] KVM: riscv: selftests: Add Zacas extension to
 get-reg-list test
Message-ID: <20240228-8f3f6703b3c14ceaf169da3b@orel>
References: <20240214123757.305347-1-apatel@ventanamicro.com>
 <20240214123757.305347-6-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214123757.305347-6-apatel@ventanamicro.com>

On Wed, Feb 14, 2024 at 06:07:57PM +0530, Anup Patel wrote:
> The KVM RISC-V allows Zacas extension for Guest/VM so let us
> add this extension to get-reg-list test.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index 5429453561d7..d334c4c9765f 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -47,6 +47,7 @@ bool filter_reg(__u64 reg)
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVINVAL:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVNAPOT:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVPBMT:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZACAS:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBA:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBB:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBC:
> @@ -411,6 +412,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
>  		KVM_ISA_EXT_ARR(SVINVAL),
>  		KVM_ISA_EXT_ARR(SVNAPOT),
>  		KVM_ISA_EXT_ARR(SVPBMT),
> +		KVM_ISA_EXT_ARR(ZACAS),
>  		KVM_ISA_EXT_ARR(ZBA),
>  		KVM_ISA_EXT_ARR(ZBB),
>  		KVM_ISA_EXT_ARR(ZBC),
> @@ -933,6 +935,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svpbmt, SVPBMT);
> +KVM_ISA_EXT_SIMPLE_CONFIG(zacas, ZACAS);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zba, ZBA);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zbb, ZBB);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zbc, ZBC);
> @@ -987,6 +990,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
>  	&config_svinval,
>  	&config_svnapot,
>  	&config_svpbmt,
> +	&config_zacas,
>  	&config_zba,
>  	&config_zbb,
>  	&config_zbc,
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

