Return-Path: <linux-kselftest+bounces-26346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAE1A3088A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 11:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FF81887B4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 10:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57CB1F1533;
	Tue, 11 Feb 2025 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pkaMqdaX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1044C1E5726
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739269892; cv=none; b=oZvUcYfzBsa4RbuELcLIbvmc5dI43itiPsWaEN+LWPN7N+88csdxhb7qGlfcDfawlDNPiwPbKWEE/LrDwuPQdRmuR1p9KBqigpBQo4eQwHTprVNUT6loO3aOV1TLMB7eHbLEPP19K+cmK0qPINaSmqxlI5C1qwoczwdPiJZV4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739269892; c=relaxed/simple;
	bh=3UHxA/qdoAY3MebmP1PqzZZYiy2zYfWAOCI1X57hn6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEMi6OwW35SBOTdocYcErdyPPoHguFH3XikUhKjCq7f7VegHkHm1FNGxVMjBl9NqdhADaCXlzzMuhNqv0qbrpV/zBOI6FGoFunnVNZQEZ0mKCgO6wVIM8OD10g26xdfoGM4Y+qGZX0oSuMjUE+QP2nFytMqWlPo6lkHY3NWBi3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pkaMqdaX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso16103535e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 02:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739269889; x=1739874689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/a6P8MPGQ0avVAV5Cfpz5Ib9WVUVZW41mP8caOrUgAQ=;
        b=pkaMqdaXgaH8QmNXCo5B47pnLdVS4Skgx+AokX/Evv4YmPRQCOTYWmIVQxQpf8Ex5d
         OsVKM262Hg94W0XE3ZlIQUS7Ze5609rOSMjvyKh6d0BhEJzyQjzozs2XfBRqNQzayBRq
         CCJPjUn/In+zVVEQoRoZEAtTJf4G3oykcdD+e/aYSf9e/0oNnCHpJO2tOfJrQu/fvhxN
         9WnRwzQI4Mx7U5sKEWEugBgSVYMOHK0iw6TzBYNM5x7l0W4M6E6vCBOMxR/jBhlhqhHb
         A9xjyEnaFuiFYD9tGaIIexPq/7xzK13iCyNBVSRSey66RQmDXiJXzoydgqgJzu4/p+sG
         rhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739269889; x=1739874689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/a6P8MPGQ0avVAV5Cfpz5Ib9WVUVZW41mP8caOrUgAQ=;
        b=I5nmJOu+Z0jrILRYQks63N6kRIRyl3cHepd58w+RiZ9LvjAxgOoNLp+ZIKhohGWoA6
         PZXIFSxzH7r6BJI2JCPXpTBFoRGEpp2FaD+33jlcPuE+ryaFtWnz2YF+74GgVA3D5BGi
         2IsNpRA3HAh0yLDZgDbhrZQG+jn7MzM9Y98K8bf3h7kRiXbOSYiiunPXGofg3L+WsP5W
         UM0rE1MdsW0yfYNR97zbYyONGBobx0qCVu+ROzkvomOIYpXBUpeh+nPsriKT0L2IGvOS
         2AA1GzlwNKRQ2gck3SJLw68Ue0Qazuj5fd1xPfpe7d/VbiQfvoYSgi4Bfte8CcVKlRVu
         jWnw==
X-Forwarded-Encrypted: i=1; AJvYcCUpCniYZWg8PJ+UOD8tkThy2d5QIkQCo9i1nwjIRXmwztTnQ0eXgcGCJzNbPZqN7VQ7vp84N23CPgY+Qut/nxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBDCSrxQh3IkUsxXG8PDhd3d25ZGp0uCmbGibxJa5xOz4aTets
	8QK6BVaS5N+nB8T7BLaDGZAuZN3BSi/GxS6qDkVjasFSGvOSgYyxCOb9tTz0qJs=
X-Gm-Gg: ASbGncv99lkB3+zxYuN34P0y4ivoz9JYLyfaH+/AADA+HfstFz3GdNxNrmpQ5/usmTS
	xgRjWwnRrrvDV0GvMvZ09U64YaeCOAxwZ95mSDSEYz5VuT1hbRg7UmQ3USt6XxDqjzNnXYcS817
	vDOYcac8MGGCXGM7Z/ZRbFiShSvSZodRw5a81D2ph7GroGecxA/5UXHuxx7VnpAa4fZsrpyzIlL
	04ZDTCY1TdybxRSpLOSPgngBPyealAjdr7n+lAhQVlCamT1mv96oFMKHcb+2PNcxZ8J+gMv2C3/
	lyWX6u9uSB6zgdDsFcoiMO2EC8kIYVOF9LgFQPFr7Ue3p13ObGIsP3Y6bNiE
X-Google-Smtp-Source: AGHT+IGrgjPSoOFkF4U85XDHHGJCIZJGQtRmyI8bFutmDHy81O7VBQ3XMYuog+hqAiQegwH4kGE9Dg==
X-Received: by 2002:a5d:588f:0:b0:38d:d613:9bb1 with SMTP id ffacd0b85a97d-38dd6139eacmr6656232f8f.12.1739269889329;
        Tue, 11 Feb 2025 02:31:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc3a10fffsm13606012f8f.12.2025.02.11.02.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 02:31:28 -0800 (PST)
Message-ID: <a8af5d3a-e739-4f65-9e2d-d92978be9a3d@rivosinc.com>
Date: Tue, 11 Feb 2025 11:31:28 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] RISC-V: KVM: add support for FWFT SBI extension
To: Deepak Gupta <debug@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>
References: <20250210213549.1867704-1-cleger@rivosinc.com>
 <20250210213549.1867704-15-cleger@rivosinc.com>
 <Z6rjkk5JlMlqbl2j@debug.ba.rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <Z6rjkk5JlMlqbl2j@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/02/2025 06:43, Deepak Gupta wrote:
>> +static int kvm_sbi_fwft_get(struct kvm_vcpu *vcpu, unsigned long
>> feature,
>> +                unsigned long *value)
>> +{
>> +    int ret;
>> +    struct kvm_sbi_fwft_config *conf;
>> +
>> +    ret = kvm_fwft_get_feature(vcpu, feature, &conf);
>> +    if (ret)
>> +        return ret;
>> +
>> +    return conf->feature->get(vcpu, conf, value);
>> +}
>> +
>> +static int kvm_sbi_ext_fwft_handler(struct kvm_vcpu *vcpu, struct
>> kvm_run *run,
>> +                    struct kvm_vcpu_sbi_return *retdata)
>> +{
>> +    int ret = 0;
>> +    struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
>> +    unsigned long funcid = cp->a6;
>> +
>> +    switch (funcid) {
>> +    case SBI_EXT_FWFT_SET:
>> +        ret = kvm_sbi_fwft_set(vcpu, cp->a0, cp->a1, cp->a2);
>> +        break;
>> +    case SBI_EXT_FWFT_GET:
>> +        ret = kvm_sbi_fwft_get(vcpu, cp->a0, &retdata->out_val);
>> +        break;
>> +    default:
>> +        ret = SBI_ERR_NOT_SUPPORTED;
>> +        break;
>> +    }
>> +
>> +    retdata->err_val = ret;
>> +
>> +    return 0;
>> +}
>> +
>> +static int kvm_sbi_ext_fwft_init(struct kvm_vcpu *vcpu)
>> +{
>> +    struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
>> +    const struct kvm_sbi_fwft_feature *feature;
>> +    struct kvm_sbi_fwft_config *conf;
>> +    int i;
>> +
>> +    fwft->configs = kcalloc(ARRAY_SIZE(features), sizeof(struct
>> kvm_sbi_fwft_config),
>> +                GFP_KERNEL);
> nit:
> 
> I understand that in next patch you grow the static array`features`. But
> in this patch
> `ARRAY_SIZE(features)` evaluates to 0, thus kcalloc will be returning a
> pointer
> to some slab block (IIRC, kcalloc will not return NULL if size
> eventually evals to 0)
> 
> This probably won't result in some bad stuff. But still there is a
> pointer in
> fwft->configs which is pointing to some random stuff if `features` turns
> out to be
> empty.
> 
> Let me know if I got that right or missing something.

So I actually searched into the kmalloc code to see what hapopens with a
zero size allocation and it actually return ZERO_SIZE_PTR:

/*
 * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
 *
 * Dereferencing ZERO_SIZE_PTR will lead to a distinct access fault.
 *
 * ZERO_SIZE_PTR can be passed to kfree though in the same way that NULL
can.
 * Both make kfree a no-op.
 */

Which seems like it's not really random and will fault if accessed. I
think that's enough for that commit (which will be bisectable if needed
then).

Clément

