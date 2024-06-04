Return-Path: <linux-kselftest+bounces-11169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC558FABB6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 09:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4F72822CB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 07:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28972140E50;
	Tue,  4 Jun 2024 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Dyl2wM9v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1BF137C47
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Jun 2024 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717485525; cv=none; b=oaFTOB8LGt/+t5e9I8pm19HQTKNvbyGBijuu47Rw80FLI04eJ27ToojxLMOIkhIm8IwQDlLaH0t3ceHUyR2g65Iz+Bok8eFTY9tBRXjYmfsmWYcA4/gg8TQ7PI09TQAV9PTYc0pmZfjgmGa5en2axF0vM+iTc0MIrBgeNlrTisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717485525; c=relaxed/simple;
	bh=F95EGVVxTZzrtH/iZbq5IMEiCEI5HtwHeAy8QgjRypA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0Xc+U35llLzB6HkHAT1q2pZ7PIXzTvFCkmHDwkWXxWxT3yMlIPytm1sw6nYXeTxltYCTMfnQFh2GIQ1iZGbo+KMTzPrGZhj/noJG8kHDV6eGql9gOKu6jsCn6+K+v3XvhkZulIHgeNiumxoQ4sXuH65b1cxQoA9Hb4s/eBPCvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Dyl2wM9v; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6c87835b8c5so176762a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jun 2024 00:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717485522; x=1718090322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IN4YotoHrJqUzJm3B5rfjHxZ9heuhTQwYjd8l3vWTCM=;
        b=Dyl2wM9vO02Yk0ZK8NErPylRnM3dv/dvxs7yZTQ0j4jvUmSeFnr4AO6+Dkg9rl7xes
         7UcmW/O7gvsOo8ZrGH3CiavUTxmxq6QoIzTBlBT/S1KIfyqS+WpbtgLOIjiHq75/Al7J
         46QKWNDkn/+5ma+2BpeeoVtjW9IHl05JlGVhmU5gjhcZRqniJsXotcw8BKEwlumApz9g
         uX95udukO788Hw39wQGuvPapteMQjs+EGw0ItrvjxPe70qxh76PXSsV+U8tafEW7zsq5
         19LXNgtYitHN4qqk0NST5ppsBN8v/m3mBB5I2/H2Hsc/r086a28YEuR2QgaenU9koxf5
         nr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717485522; x=1718090322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IN4YotoHrJqUzJm3B5rfjHxZ9heuhTQwYjd8l3vWTCM=;
        b=v4Nj5XjVeqG6EEwg811RWIIlrcMit2FNXM7VjNDL9C9E02YDnz/eSFvZllacl2HpTj
         njPSh2g4qfQ33sHL7e6/6ebrj3CnmS1iHrJPsB3XMegzv85VJhAtiZNaCDSmAYlHnt7V
         k/90Ip9EyIL57wyg2F+d1N+LlxbEbhnfFnczLv38qp+Vc0cC470IXq5XalgamDZeyjv6
         BgZgBK8QcDujiiyean4xDT19a3IbQZaYsDPdb01a2gczLYwiVRfwfyVlg0Ny8JPTIvJR
         C74Mmnfe2+CqqZ8MXk1TliBb6yMyl9mjLRkfceFB+hnGsHT0F6TWj1sfK2fHREWU2dVD
         j53g==
X-Forwarded-Encrypted: i=1; AJvYcCVDRgerjuUvq4Rq0F0z8iWxGbyW69UbTfsgp+IoZBkWBFDZ0oqtES81/gwe4+l7wui/DHCCZDxBfxe1/8vjWz/DVhamAXOb5ZtwXos/gx8q
X-Gm-Message-State: AOJu0Yyxvtd1oISd/hh5CWP5w+K8wrYQYL0CDenx8IfbY1QWQEVJ92Oh
	l8vdKJD80YObtN1ZYnSJmN4G42KmsnV9OhseJCJPEKN5bHx15xNKeETUJOusx/0=
X-Google-Smtp-Source: AGHT+IFWL8L1FbR0wZ7pGG9sTqaIq8MsqqTQdkXuTxrZK9vhL+JYsZ64DIfumPIQtJaghfe3mvA/Mg==
X-Received: by 2002:a05:6a21:33a1:b0:1b2:63c3:274c with SMTP id adf61e73a8af0-1b26f35e160mr12461974637.6.1717485521635;
        Tue, 04 Jun 2024 00:18:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:d768:c577:5bf0:47ab? ([2a01:e0a:999:a3a0:d768:c577:5bf0:47ab])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1aa9dce87sm8984869a91.21.2024.06.04.00.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 00:18:40 -0700 (PDT)
Message-ID: <06d8ae43-4aad-4637-a33b-9bae91b23872@rivosinc.com>
Date: Tue, 4 Jun 2024 09:18:25 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/16] riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Conor Dooley <conor@kernel.org>, corbet@lwn.net,
 Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, anup@brainfault.org,
 shuah@kernel.org, atishp@atishpatra.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <mhng-d5016935-99b6-4dc6-bbd2-ed84eb834f98@palmer-ri-x1c9a>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <mhng-d5016935-99b6-4dc6-bbd2-ed84eb834f98@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/05/2024 23:13, Palmer Dabbelt wrote:
> On Wed, 22 May 2024 00:20:09 PDT (-0700), cleger@rivosinc.com wrote:
>>
>>
>> On 21/05/2024 21:49, Conor Dooley wrote:
>>> On Fri, May 17, 2024 at 04:52:48PM +0200, Clément Léger wrote:
>>>
>>>> +static int riscv_ext_zca_depends(const struct riscv_isa_ext_data
>>>> *data,
>>>> +                 const unsigned long *isa_bitmap)
>>>> +{
>>>> +    return __riscv_isa_extension_available(isa_bitmap,
>>>> RISCV_ISA_EXT_ZCA) ? 0 : -EPROBE_DEFER;
>>>> +}
>>>> +static int riscv_ext_zcd_validate(const struct riscv_isa_ext_data
>>>> *data,
>>>> +                  const unsigned long *isa_bitmap)
>>>> +{
>>>> +    return __riscv_isa_extension_available(isa_bitmap,
>>>> RISCV_ISA_EXT_ZCA) &&
>>>> +           __riscv_isa_extension_available(isa_bitmap,
>>>> RISCV_ISA_EXT_d) ? 0 : -EPROBE_DEFER;
>>>> +}
>>>
>>> Could you write the logic in these out normally please? I think they'd
>>> be more understandable (particular this second one) broken down and with
>>> early return.
>>
>> Yes sure. I'll probably make the same thing for zcf_validate as well as
>> removing the #ifdef and using IS_ENABLED():
>>
>> static int riscv_ext_zcf_validate(const struct riscv_isa_ext_data *data,
>>                   const unsigned long *isa_bitmap)
>> {
>>     if (IS_ENABLED(CONFIG_64BIT))
>>         return -EINVAL;
>>
>>     if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA) &&
>>         __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_f))
>>            return 0;
>>
>>     return -EPROBE_DEFER;
>> }
> 
> Are you going to send a v6 (sorry if I missed it, I'm trying to untangle
> all these ISA parsing patch sets).

Yes, I was waiting for more feedback/Rb by it seems like I now have
everything I need. I'll send that.

Thanks,

Clément

> 
>>
>>>
>>> Otherwise,
>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> Cheers,
>>> Conor.

