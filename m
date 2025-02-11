Return-Path: <linux-kselftest+bounces-26392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55775A310C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 17:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A47B7A1467
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117EA256C74;
	Tue, 11 Feb 2025 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WbvhyPoO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39781256C62
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290139; cv=none; b=oLn26HBIoUJnNPnFb1/cHC/amCOGpPbhq8XPLw9MGVdyVzkjAxnJpzvEt+p0vspzFhSdgeYlGBO8u08hCjimpYT6pOreyVlLTGzzoANqUWn1qIEHzZ8O5ht9TiKQFJ4n2Rjcjg14c5WmaIxqD3UXqNqG9poXR7m+kn9y9PECgXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290139; c=relaxed/simple;
	bh=fM6tMWdfzkcGZeMu8sbljrtpDaDJ3qlk57x3dLx9yP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW/1bgskuuLgbYl244r0/zqCAuQhkqpDe9QldKiF6LMFUfBfXi5nyaKV+wmz8MUZDDkmL3ejoSa/SzLDLFZGlY4jZYEUGuQCTaPPxcV1+Lf1oolGWHLLHfC2LNeh6Irkch382GF3QJTTpx2+rf3D9uMYRjDnp4gG658vWqn4W+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WbvhyPoO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f48ebaadfso97202025ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 08:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739290137; x=1739894937; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fM6tMWdfzkcGZeMu8sbljrtpDaDJ3qlk57x3dLx9yP0=;
        b=WbvhyPoOd8+NMwZF8CceWzOycvAh3Q+L392GU10F3kxDn02jm8VShALm4dUgGNeGEc
         grEuKSSQc9kNH7zmS1+WJDJ313tT3mblokyumTKJPVHHEk0pnpXKPTvzmTjzZlJxl2zS
         9RzP2KrlmBso2ayhPvfBnN+slR2SCTIYsHAXqMZyDzmVruWpVSyLnmgZVPVrJWackW7r
         80PQdoDnjwROc6ha38BISS6tEmY1EzbI1t8kg2zr5viHLswgVX/YjKeMR3Du6HZ2GxAz
         tJ41Y9hZTjJ6oFol1IVoZomrwy1cnL1HEHg0A4sZeU50ebvdus6QSclkpBKaSF4DyGWv
         pNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290137; x=1739894937;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fM6tMWdfzkcGZeMu8sbljrtpDaDJ3qlk57x3dLx9yP0=;
        b=EZYREtnJesXAicoZ+udSyIKKcBhw7b/9PQqv+g+f166wbKZr53tYXFla0NNscqNMeT
         s6BKke4QKj0iq4mhUtQ86MF6uCfFZGJejfzcIyZsXmPd5MfyjXIgTcHZlchEhKKSmwxD
         l6z4ygLNI4Uov7Z45T4KuPVzE8Nyqo5drz67K8b85uiR49gSAvnAwSxbm2tofCcWHSC1
         QySlAfVnVkgUrqc2IFqPmxP+grgbQaCgXk/7JCgEk8Bbq9Z1MK0CJPLz3Olkl/JN7w90
         HCP01MYGYEOqHp54/5G0MiBgyK80L6l8jb1pXm+vWUMm8GOjO3tj0vC+RwJAc/eOjQIK
         nM6g==
X-Forwarded-Encrypted: i=1; AJvYcCUHpFgSVKWucHIew92nAxTOZjh1x/+M4Tab5O42HRQfHVxTUs1Qy4J1rKq+H9H2EZwHwNHkfBXD/P/bWZtnXJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkUqMzyuee5sk4741nLutZbn+LjYeH3fzK3d2YJORREFa+wxdM
	rPNXPFP2LvCTfcjF+09dhCmYSTsaechQ+W5iOfzVbXiKYXCF8J6aJJj21/yS1n8=
X-Gm-Gg: ASbGncv33K6iE+q2jvZoWn+5iwZPhltUZp9cR7uFvqWnCoSEuAOzIcfwuADJa1Xfgnw
	yA9yRJAvLPQI5Q0BMZVj6mrRCt9/flrlAtop2ezEjGawG00UlLAbzSKbFZAo/R5Jo7ppwwAo75L
	5NQ0F3NNevECF48K7NK79UfQcGC/rVPlZlG+OWlfo47DLBwPOi28nYNfh1XvRxoIKCR+EB/6ky7
	Ay8FPiYY0P1+9xoLMlgFf3kFqlDnGyxlS6LznnJ0nm+kLPelnMsUWjA/7oD/I62njTD3f4AoD+0
	LMAd/jBmzLWdUT/cTdAL4PHAZw==
X-Google-Smtp-Source: AGHT+IFZ7zG8kNq32XbGzHizA+/obYPBTcZQNtVCcsm+yZBTBiOP0hgDR8QeXXdRboljfbChEW5/qA==
X-Received: by 2002:a05:6a20:6f9c:b0:1e1:c054:4c58 with SMTP id adf61e73a8af0-1ee03a22be8mr33720540637.2.1739290137163;
        Tue, 11 Feb 2025 08:08:57 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730887b0fa8sm4433085b3a.8.2025.02.11.08.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:08:56 -0800 (PST)
Date: Tue, 11 Feb 2025 08:08:54 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2 14/15] RISC-V: KVM: add support for FWFT SBI extension
Message-ID: <Z6t2FsP91rUNv64D@debug.ba.rivosinc.com>
References: <20250210213549.1867704-1-cleger@rivosinc.com>
 <20250210213549.1867704-15-cleger@rivosinc.com>
 <Z6rjkk5JlMlqbl2j@debug.ba.rivosinc.com>
 <a8af5d3a-e739-4f65-9e2d-d92978be9a3d@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8af5d3a-e739-4f65-9e2d-d92978be9a3d@rivosinc.com>

On Tue, Feb 11, 2025 at 11:31:28AM +0100, Clément Léger wrote:
>
>
>On 11/02/2025 06:43, Deepak Gupta wrote:
>>> +static int kvm_sbi_fwft_get(struct kvm_vcpu *vcpu, unsigned long
>>> feature,
>>> +                unsigned long *value)
>>> +{
>>> +    int ret;
>>> +    struct kvm_sbi_fwft_config *conf;
>>> +
>>> +    ret = kvm_fwft_get_feature(vcpu, feature, &conf);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    return conf->feature->get(vcpu, conf, value);
>>> +}
>>> +
>>> +static int kvm_sbi_ext_fwft_handler(struct kvm_vcpu *vcpu, struct
>>> kvm_run *run,
>>> +                    struct kvm_vcpu_sbi_return *retdata)
>>> +{
>>> +    int ret = 0;
>>> +    struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
>>> +    unsigned long funcid = cp->a6;
>>> +
>>> +    switch (funcid) {
>>> +    case SBI_EXT_FWFT_SET:
>>> +        ret = kvm_sbi_fwft_set(vcpu, cp->a0, cp->a1, cp->a2);
>>> +        break;
>>> +    case SBI_EXT_FWFT_GET:
>>> +        ret = kvm_sbi_fwft_get(vcpu, cp->a0, &retdata->out_val);
>>> +        break;
>>> +    default:
>>> +        ret = SBI_ERR_NOT_SUPPORTED;
>>> +        break;
>>> +    }
>>> +
>>> +    retdata->err_val = ret;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int kvm_sbi_ext_fwft_init(struct kvm_vcpu *vcpu)
>>> +{
>>> +    struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
>>> +    const struct kvm_sbi_fwft_feature *feature;
>>> +    struct kvm_sbi_fwft_config *conf;
>>> +    int i;
>>> +
>>> +    fwft->configs = kcalloc(ARRAY_SIZE(features), sizeof(struct
>>> kvm_sbi_fwft_config),
>>> +                GFP_KERNEL);
>> nit:
>>
>> I understand that in next patch you grow the static array`features`. But
>> in this patch
>> `ARRAY_SIZE(features)` evaluates to 0, thus kcalloc will be returning a
>> pointer
>> to some slab block (IIRC, kcalloc will not return NULL if size
>> eventually evals to 0)
>>
>> This probably won't result in some bad stuff. But still there is a
>> pointer in
>> fwft->configs which is pointing to some random stuff if `features` turns
>> out to be
>> empty.
>>
>> Let me know if I got that right or missing something.
>
>So I actually searched into the kmalloc code to see what hapopens with a
>zero size allocation and it actually return ZERO_SIZE_PTR:
>
>/*
> * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
> *
> * Dereferencing ZERO_SIZE_PTR will lead to a distinct access fault.
> *
> * ZERO_SIZE_PTR can be passed to kfree though in the same way that NULL
>can.
> * Both make kfree a no-op.
> */
>
>Which seems like it's not really random and will fault if accessed. I
>think that's enough for that commit (which will be bisectable if needed
>then).
>

Awesome. Thanks for looking into it.

>Clément

