Return-Path: <linux-kselftest+bounces-31555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5864A9AE6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 15:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA401B81C33
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 13:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B86A27FD41;
	Thu, 24 Apr 2025 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VYXbB5tz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB3B27F74E
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499850; cv=none; b=fMubKpul5FLIYcGdkJPXm0KBNe6Tc40O03u83HbmG/iXWSwJvWHI4wR/HF8U/EpXoOezDXlmoi/HksD7T5l3qUZF14pMWeFPAYuwkiZlyvuR+q9HYQWpmxLbBoazQcskhQIYV/KrfAfJHnKs8M6gA9enVEZCsjEv1lScTstnnhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499850; c=relaxed/simple;
	bh=pgbvCwp/paE3IyGYTw9Wb1/PXLYgEcy616PkjyGJOSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpawwo9IrnbuAlT+xilQwVDgPNU9SKIhYNd4Suv7efGD+rGukhvAMa37y8AYCqtbq09Ow1sDK8SkZQmGP2w5T2BtxMPxsia9lI73519hGwqv5yY64PDkrAwbF2BblIC581TydmNgPDxeJFbQiakXxq5z/aLGvtCnPeux1FQq3AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VYXbB5tz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so9762865e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745499845; x=1746104645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlenUvh61lykgI0moQ4b5m5MpD7H2yqiNR9KiWkzX9o=;
        b=VYXbB5tzb8XIudiEVaWQPT0utH1Kbc7Qh7zQqzmmafEhB0TN+/xnDJexH5WGp+bZhv
         +RhOH4Hc6SkwqB17dLvBAsfueWIK61ukMaVRtecbbPbbqj+mWbp8Ag+lqZYDvy74z4uR
         xkzZat/8z+83jkZLpcX6mJ7eArAXYQxYlY8XhxErxf/bNCDTx4Z6aF7g5eiWv//ynzwF
         qxWRgvFXu0wps+/UBC7DDbXKoJ23qDqHHRQPG1x7hen31q0NoR2fhA3G+plnTmSWVTbA
         idPJOzPq8lgdbfKCG1pufzge194CNUcc254VBhwWSljNtLcREgGr/wfQ77vzapK3G+YK
         araw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745499845; x=1746104645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlenUvh61lykgI0moQ4b5m5MpD7H2yqiNR9KiWkzX9o=;
        b=n7Yk7zjrszCqa4zIaDATuvhjfDjMsmKW5XMZiMEFwnT2vp/i9M2fyu2pL2Nm6cNQRl
         o7NVRWHd8yeLPakcCC/qU3LbJdO//fmLYPGxUNX8P1IT4CXV+N5USE31JhrHoILLnMuH
         IPZT2nmSaq6ubvc4QOYEg+7wSMzKhCFtZxBJ1p154wSEj+iKABijt8OEWF9a40AIHXSM
         5280Co0WUEz/VAhGyGxNWREq2MowM0A69sD1VcBzF7JJ+d+kRSyxqp4wNCGiPmdA9GTV
         REQc0NI1TZM3woFFRs5o6AIBwOZA2BO5tvhg+fpkSRQT4tJxnJ1qpaM7SrhePSV6wIIL
         Y6yA==
X-Forwarded-Encrypted: i=1; AJvYcCWVkj8UFkzU/gFYrmrfolyi4gAptGU1/OLgHWpfjlqWFBHyPdeUzfr9myBe2noO/10QHs/iEc7EEbjLPTtUhEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVG0lBMqi2avXq/mYb5ju6fREICkwSJ1XiR6hjyhY4KUMVNt8T
	EaytUNewM1+7h7H40ZvvOpuSkqbPgEIzDB/lc47trrzzI9xhgHMOy/sJpdc/SyI=
X-Gm-Gg: ASbGncvZUQX9gLqnFxC3fprnzwt/vMjPXkcOqyXF8nuSN75ybdkBDDrLuZKi6RNkvqf
	P9Z3bZe8hpXqSIZQmLlnXd/+/A5Hvh+OrRnS4mXaKCXTS7GFkSg2NHoNv+aJ99k31NNZV3gTBjG
	TEOgSExZrOAb1Dq/JZpqLEhCq1+w2ILz/QwriArzuLuctXMHySjLgVLmaxo6BILZ9t1IvaXoD9r
	7GzmvF8rgEKPUDQejGv5jveBWsImpOC2IHqvF22Li3kp5Y1exGOkcZeJTT6CFGoLbsQx0lt+Dl/
	P6fk/jW7myPacOPlkXDzX+5E9jTsBOcJou8B9DgXJnmd1l0flAFXzg05M3jwP5o2pYu0gEZWpES
	I6VhTp8chHw==
X-Google-Smtp-Source: AGHT+IFY/zQrAFYpl1F/wfq7qZKx4PChEo3rOT9RvUxXUgDej0UjL+OvlI8WpktqulU98FccnhbKpQ==
X-Received: by 2002:a05:600c:5110:b0:43c:ef55:f1e8 with SMTP id 5b1f17b1804b1-4409bd20ab9mr23814095e9.13.1745499844890;
        Thu, 24 Apr 2025 06:04:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2acf8dsm20366545e9.23.2025.04.24.06.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 06:04:04 -0700 (PDT)
Message-ID: <8c7c1632-ced2-491a-92a3-8b98de655b4a@rivosinc.com>
Date: Thu, 24 Apr 2025 15:04:03 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/13] riscv: sbi: add SBI FWFT extension calls
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>
References: <20250417122337.547969-1-cleger@rivosinc.com>
 <20250417122337.547969-5-cleger@rivosinc.com>
 <20250424-c0700f89bcd29438d6d8d65c@orel>
 <f6c5c92d-73aa-41a7-99bb-f95e388ea294@rivosinc.com>
 <20250424-27a672c1da15353051b52c59@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250424-27a672c1da15353051b52c59@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 24/04/2025 14:59, Andrew Jones wrote:
> On Thu, Apr 24, 2025 at 02:35:02PM +0200, Clément Léger wrote:
>>
>>
>> On 24/04/2025 13:06, Andrew Jones wrote:
>>> On Thu, Apr 17, 2025 at 02:19:51PM +0200, Clément Léger wrote:
>>>> Add FWFT extension calls. This will be ratified in SBI V3.0 hence, it is
>>>> provided as a separate commit that can be left out if needed.
>>>>
>>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>> ---
>>>>  arch/riscv/kernel/sbi.c | 20 +++++++++++++++++++-
>>>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
>>>> index 379981c2bb21..7b062189b184 100644
>>>> --- a/arch/riscv/kernel/sbi.c
>>>> +++ b/arch/riscv/kernel/sbi.c
>>>> @@ -299,6 +299,8 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +static bool sbi_fwft_supported;
>>>
>>> At some point we may want an SBI extension bitmap, but this is only the
>>> second SBI extension supported boolean that I'm aware of, so I guess we're
>>> still OK for now.
>>
>> That seems reasonable to have a bitmap rather than duplicating
>> *ext*_supported. If that's something that bothers you, I can take care
>> of it and use a bitmap. SSE will also have a sse_supported boolean but
>> in it's own driver file though.
> 
> Up to you. We can always do it later.

I will let that for the next extension being added then ;)

Clément

> 
> Thanks,
> drew


