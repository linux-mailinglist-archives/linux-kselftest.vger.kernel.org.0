Return-Path: <linux-kselftest+bounces-32838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E8CAB319C
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 10:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CAF179276
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 08:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70819259C9E;
	Mon, 12 May 2025 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="upmkSWB5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B19259C8E
	for <linux-kselftest@vger.kernel.org>; Mon, 12 May 2025 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747038486; cv=none; b=QCDOwsPNJ95vQKxNdhdp6CzasK2RUQ1S62XO6fkHCu1kJ27k1hBJ0SX4QzE3ItbdBVsIXuvM3djxVki8ffiXv6aswd0ydmtIbdJDhRkuNX1NRchxZo3IsZe/qw8aeR1HiNTNVq831ylPkFVXDvOPc0iG0bibMLUjO3HVoIAVgso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747038486; c=relaxed/simple;
	bh=FnqapDHA2Oh8Kjn2D4GnRbRG39bzWiagKhETfDHDPuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtSYwdbbVFXX7VKc6OZiSnkqxyS6EOOrv8IrWvN5iD4+k0gjrTDv1Tm2uOlTtJvJunTzgsITEF8oOI1le5/FEp9xL5tZXsrseoca2ouKuB6kRqsLzCRwB1yoE/U+0uHCAtx+BUtlCNiybejcmnScgjdWapzEsA/jSu4Okwu1rXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=upmkSWB5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a0bdcd7357so2821209f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 May 2025 01:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747038482; x=1747643282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/GHu16VagS4Zo0QZx5ctfJMlX1e+tH9PDkYdamiUkNk=;
        b=upmkSWB5gkuTSDiWyiVat3gk1NnkqSA8LAKDyLbn9txIzzVs1IWi6P49GiWFrv7n8n
         DGlXR7PHJMxyZV1TKu46Dy6YTyFnKwo7R/Ij0Hhfm/U7xkoOYD7O9WzcKG+TkOgEeXG+
         bP6AY2Jp15xy0K0/iWZlXLjOOC0EYo1yMwexZ/HVedN5CG23CJA47FerszbrhHqCObXW
         Z1oUzJgmzcZatXdZUmDUDV77p8mJPpqV4wOUmhIUPjT49RUrrvmL/YIQ46IE2sPHKiwX
         MLqRg2x3bAUhm70Pn/A0tDaZN50caTrz/xHC4ofGCsg8FTW8I7CQ/AFPV2WH7dzFWPKl
         /DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747038482; x=1747643282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GHu16VagS4Zo0QZx5ctfJMlX1e+tH9PDkYdamiUkNk=;
        b=CEfouifuqIsTdYzVdYeaUi5XEMVMTyptb6LjatirNRppaamPVpsPpd8Vq4aOHAt6PJ
         54XiEeljcWQ7iCAYuIEkitg4+lQHn3VtO/eUOvwE4281FUFCrdrOgWL5EatoEmV8ja8+
         QVvsv7XeBAjhRZPtxR3C6de+npecwGEj2NDasQyXrcwSiaUYVx80tHWBjYzKC4Ze/+6t
         ++MH1m+fPO3tyg4Gw8XAyqqKP3UbWmpgehdzGj4O1uX8mAQdmfHXOWcOH5H2phhZlOT9
         afyghMM2mvLmVrF++7KgrhpW+CYFfKP59bkN9LLU0y0mbnstG7H4vXrBqgPVCmPfekQl
         8BKg==
X-Forwarded-Encrypted: i=1; AJvYcCX/l9HHjWWFwDiC7LcoLz4ntGipFWPuKxuqBPPxVrSGhky3jjZtNfJZDScFj30Uo7zkZnYfcgR7gzoJoyoOCWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI6NtlOo+TuUFG0e32qbQtvlneymOHtK2qduVpWzXNT+4yEIYq
	VSu/qVVugquWIyMoMixDweejKtO5bCYvzAc6Gjr+Z8oEgE0KMd/FuLpsjuD0r2w=
X-Gm-Gg: ASbGncvg4k3Td/qPEUgCNPNfycrMHk7uwkZiK8TIQklVENRISyaesCDFmIUGc3sEGvH
	pFmtTjUqaOgJaEk8AyKC8nM8+376BSqMKsdNzBmKf39TBRndTw3iQLlOlLQga6oMvo76f7w5Xv1
	FeQqfOeIKwJK7PJhieEyrlVCVPuk+7FrYSWdEWxwHW4T17bq0VApUW27Fw3HE6R9M/JuEqTU3NK
	U/7qgCcsT+f/NFnCrm0VdU+5d3Jl3f+BCEG9xclShchBJeEFJo5kK+lO3/glGZ4Gbu+5vhTsZzk
	KOEVmU0lGDPg0Hw2QGP3Yz3NQWEYObcDCsTUdv8DrAYRrry95uWyI1cJuphJ+eWQgHNDgPzggzf
	/67GLxqKgmMJsX4lZxcPv
X-Google-Smtp-Source: AGHT+IF3cuftk1+itln34hyUlsyO+lAZrtrkx94Wsxfu0ogw4IibSZyT4oEk1i1ctGEF1Ke0Xxw6Ig==
X-Received: by 2002:a05:6000:2410:b0:3a0:7a5d:96f6 with SMTP id ffacd0b85a97d-3a1f64b5850mr10211716f8f.38.1747038482577;
        Mon, 12 May 2025 01:28:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2ab2sm11460379f8f.46.2025.05.12.01.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 01:28:02 -0700 (PDT)
Message-ID: <67896719-5cbc-4bf6-8b00-3b785940952f@rivosinc.com>
Date: Mon, 12 May 2025 10:28:01 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/14] RISC-V: KVM: add support for
 SBI_FWFT_MISALIGNED_DELEG
To: Atish Patra <atish.patra@linux.dev>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>, Deepak Gupta <debug@rivosinc.com>
References: <20250424173204.1948385-1-cleger@rivosinc.com>
 <20250424173204.1948385-15-cleger@rivosinc.com>
 <87b2eade-acda-428e-81af-d4927e517ebe@linux.dev>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <87b2eade-acda-428e-81af-d4927e517ebe@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09/05/2025 20:09, Atish Patra wrote:
> On 4/24/25 10:32 AM, ClÃ©ment LÃ©ger wrote:
>> SBI_FWFT_MISALIGNED_DELEG needs hedeleg to be modified to delegate
>> misaligned load/store exceptions. Save and restore it during CPU
>> load/put.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> ---
>>   arch/riscv/kvm/vcpu.c          |  3 +++
>>   arch/riscv/kvm/vcpu_sbi_fwft.c | 36 ++++++++++++++++++++++++++++++++++
>>   2 files changed, 39 insertions(+)
>>
>> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
>> index 542747e2c7f5..d98e379945c3 100644
>> --- a/arch/riscv/kvm/vcpu.c
>> +++ b/arch/riscv/kvm/vcpu.c
>> @@ -646,6 +646,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>>   {
>>       void *nsh;
>>       struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
>> +    struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
>>         vcpu->cpu = -1;
>>   @@ -671,6 +672,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>>           csr->vstval = nacl_csr_read(nsh, CSR_VSTVAL);
>>           csr->hvip = nacl_csr_read(nsh, CSR_HVIP);
>>           csr->vsatp = nacl_csr_read(nsh, CSR_VSATP);
>> +        cfg->hedeleg = nacl_csr_read(nsh, CSR_HEDELEG);
>>       } else {
>>           csr->vsstatus = csr_read(CSR_VSSTATUS);
>>           csr->vsie = csr_read(CSR_VSIE);
>> @@ -681,6 +683,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>>           csr->vstval = csr_read(CSR_VSTVAL);
>>           csr->hvip = csr_read(CSR_HVIP);
>>           csr->vsatp = csr_read(CSR_VSATP);
>> +        cfg->hedeleg = csr_read(CSR_HEDELEG);
> 
> Can we avoid saving hedeleg in vcpu_put path by updating the cfg-
>>hedeleg in kvm_sbi_fwft_set_misaligned_delegation.
> 
> We already update the hedeleg in vcpu_load path from cfg->hedeleg.
> If the next vcpu did not enable delegation it will get the correct
> config written to hedeleg.

Yeah that make sense, I'll modify that.

Thanks,

Clément

> 
> This will save us a csr read cost in each VM exit path for something
> that is probably configured once in guest life time.>
>>       }
>>   }
>>   diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/
>> vcpu_sbi_fwft.c
>> index b0f66c7bf010..d16ee477042f 100644
>> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
>> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
>> @@ -14,6 +14,8 @@
>>   #include <asm/kvm_vcpu_sbi.h>
>>   #include <asm/kvm_vcpu_sbi_fwft.h>
>>   +#define MIS_DELEG (BIT_ULL(EXC_LOAD_MISALIGNED) |
>> BIT_ULL(EXC_STORE_MISALIGNED))
>> +
>>   struct kvm_sbi_fwft_feature {
>>       /**
>>        * @id: Feature ID
>> @@ -68,7 +70,41 @@ static bool kvm_fwft_is_defined_feature(enum
>> sbi_fwft_feature_t feature)
>>       return false;
>>   }
>>   +static bool kvm_sbi_fwft_misaligned_delegation_supported(struct
>> kvm_vcpu *vcpu)
>> +{
>> +    return misaligned_traps_can_delegate();
>> +}
>> +
>> +static long kvm_sbi_fwft_set_misaligned_delegation(struct kvm_vcpu
>> *vcpu,
>> +                    struct kvm_sbi_fwft_config *conf,
>> +                    unsigned long value)
>> +{
>> +    if (value == 1)
>> +        csr_set(CSR_HEDELEG, MIS_DELEG);
>> +    else if (value == 0)
>> +        csr_clear(CSR_HEDELEG, MIS_DELEG);
>> +    else
>> +        return SBI_ERR_INVALID_PARAM;
>> +
>> +    return SBI_SUCCESS;
>> +}
>> +
>> +static long kvm_sbi_fwft_get_misaligned_delegation(struct kvm_vcpu
>> *vcpu,
>> +                    struct kvm_sbi_fwft_config *conf,
>> +                    unsigned long *value)
>> +{
>> +    *value = (csr_read(CSR_HEDELEG) & MIS_DELEG) == MIS_DELEG;
>> +
>> +    return SBI_SUCCESS;
>> +}
>> +
>>   static const struct kvm_sbi_fwft_feature features[] = {
>> +    {
>> +        .id = SBI_FWFT_MISALIGNED_EXC_DELEG,
>> +        .supported = kvm_sbi_fwft_misaligned_delegation_supported,
>> +        .set = kvm_sbi_fwft_set_misaligned_delegation,
>> +        .get = kvm_sbi_fwft_get_misaligned_delegation,
>> +    },
>>   };
>>     static struct kvm_sbi_fwft_config *
> 


