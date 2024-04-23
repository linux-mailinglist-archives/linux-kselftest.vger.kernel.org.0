Return-Path: <linux-kselftest+bounces-8673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889578AE05E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC563B21D6C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 08:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE89355E45;
	Tue, 23 Apr 2024 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0m7xbwAu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E23F56472;
	Tue, 23 Apr 2024 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862659; cv=none; b=NP5QlTKfnj5TXWxcDYWCyUFAsE2j+TC7EgpmSgIaU7jOmJDtJpwNfyJNCjEnXzG+MjCr17g2+In1iGnjtt84GxCHfdwthgSL9ts+XFTLevS8MVqUKloQ1gKauf58fKBnknIPXlLj3kvQnA+Ok2XZnYQk2lAUAoiSL5/OHKRjvGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862659; c=relaxed/simple;
	bh=8DzYTWeR1MFLHFT73kWX3M2k0VGpj5e6788N1mCfWks=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cog/QDUAiWlNRcRTlpgIz3wjUuRWUU0K1MqUo1Zv7ZI+kUX5h9RZFvqYXs/gNFxn2IK1WdTsdgQHAe+EUmU9SHTReB/zksCwufuIBDMxMvYl/KKgXTddkUskTIWH4vm6WUnuBJ2ScEC/rncDnW2auau1Nz3e6tnNLVZuB/StNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0m7xbwAu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713862656;
	bh=8DzYTWeR1MFLHFT73kWX3M2k0VGpj5e6788N1mCfWks=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=0m7xbwAuFCRZIYDNvnWtD5eJOkrf68SA+gwQQt04r4jJauSM2UG2ME2BaMD3Gu+Qp
	 PkAcVeGivyAlyl9eaiR0AhKoPy8W4sMjKqy8on3ig6xfTae8tzSZ6NKhEvNNigHfSK
	 KR7inMbFiTGX+PuckTGLTXzSDDNuHzR6TRjPOAcBGuTr5l3FkpYyCUzDetm0FKqpKb
	 a8Z9HRooZNI/7CxxXvjvjnpZPNcON8w2t3rxlWlnvcm2b2d0+Epy9jVmAnGGSMCw7U
	 MotP90H7HqrsgrHem01kTEN7yLhX5QYiDm4p+Of5ED3bSzeEYOpR+XoCYl0XxnDk+f
	 e7TmfzPNyxd8Q==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 39F6F3781183;
	Tue, 23 Apr 2024 08:57:28 +0000 (UTC)
Message-ID: <4f4ca27c-846e-4f8a-928d-fa680c51361c@collabora.com>
Date: Tue, 23 Apr 2024 13:58:02 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Anup Patel <anup@brainfault.org>, Andrew Jones <ajones@ventanamicro.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, samuel.holland@sifive.com,
 Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v8 19/24] KVM: riscv: selftests: Add Sscofpmf to
 get-reg-list test
To: Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org
References: <20240420151741.962500-1-atishp@rivosinc.com>
 <20240420151741.962500-20-atishp@rivosinc.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240420151741.962500-20-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/24 8:17 PM, Atish Patra wrote:
> The KVM RISC-V allows Sscofpmf extension for Guest/VM so let us
> add this extension to get-reg-list test.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
LGTM

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index b882b7b9b785..222198dd6d04 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -43,6 +43,7 @@ bool filter_reg(__u64 reg)
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_V:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SMSTATEEN:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSAIA:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSCOFPMF:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSTC:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVINVAL:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVNAPOT:
> @@ -408,6 +409,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
>  		KVM_ISA_EXT_ARR(V),
>  		KVM_ISA_EXT_ARR(SMSTATEEN),
>  		KVM_ISA_EXT_ARR(SSAIA),
> +		KVM_ISA_EXT_ARR(SSCOFPMF),
>  		KVM_ISA_EXT_ARR(SSTC),
>  		KVM_ISA_EXT_ARR(SVINVAL),
>  		KVM_ISA_EXT_ARR(SVNAPOT),
> @@ -931,6 +933,7 @@ KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
>  KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
>  KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
>  KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
> +KVM_ISA_EXT_SIMPLE_CONFIG(sscofpmf, SSCOFPMF);
>  KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
> @@ -986,6 +989,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
>  	&config_fp_d,
>  	&config_h,
>  	&config_smstateen,
> +	&config_sscofpmf,
>  	&config_sstc,
>  	&config_svinval,
>  	&config_svnapot,

-- 
BR,
Muhammad Usama Anjum

