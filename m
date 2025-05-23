Return-Path: <linux-kselftest+bounces-33676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D87CCAC2A68
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 21:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEDB1B64DE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 19:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A6629672F;
	Fri, 23 May 2025 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hG14mgnU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764FD1D798E
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028236; cv=none; b=WFq0haAvNgVczjImJ2b15iMo5kA12CagHfEfLz3OBqqW+XKaCjL2NlWqJg1jPoOQjaGzkh7Uf5k+/r8selLYofDsnD077fHqkChhuFCctBBHazOi1Uxo/ABljmTveKBcAzn5diE2/4Y8S1bef4TNByWt5vuRm+MEYschnbM5u1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028236; c=relaxed/simple;
	bh=NECU1W/GfeOBqRjNfEa0fXcRwvYNTzTuGDKdrAlKpxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5o1HxCy1hJQIn63Bf14xn1lWoyYwrRmW7JTDNPbHuNz3ieiRL0PzIrvdb1CqeHPAmO41sxvlWoJ3v8L78cEVfQgh+IVYcPlp7lvHWsnx0dFS9Y4YoQezhPGyYAWN9oRd5XoNDz6Qwto18xuk11VuiHUy/7A4prLuW9tM6bUP9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hG14mgnU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af548cb1f83so133539a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 12:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1748028234; x=1748633034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ymdNLyOhnChndrLOo/uMB8HrcV+eYphQgSa+w1rmBgc=;
        b=hG14mgnU8afCrC1AcBz5inUvSd1hIq5OLXqGLtnXyyGHcDTE9Gs8ZZjjKpQVmMV+Bx
         ZuSvS2JDya0t8D3m/ljaYj95SIF4goBnPgllk4nnmUDFrvyCOa0R4jD/v8nNNmFNu4Cf
         rwqhO4n4k7hKdzKR/dfre9/VEJ6SRTz43LxxVzj5eqF4t9/9SINWuBVOrEOhGJNJRfNa
         2+Xrm1+N1etW1MbNwImqSVS71Ivd1EJ2hBVWrX2IOyLP9wzCpaAiLBuptVyJMKOO/Ldy
         I0yya5u0EIH+g21vYC2LEnud1odXLGbmz4qtBIBtCVrG8T/aZ9KoFHoXO3z55UnojL/X
         tQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748028234; x=1748633034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymdNLyOhnChndrLOo/uMB8HrcV+eYphQgSa+w1rmBgc=;
        b=iczRNbz9gFcaZNcLJn9lq+AcUkX04eeNJadnJNFVKM2Tg+y0G2cytUL00v1NyXBsof
         NeN2A+jAwGpqBlx1ll4jAnazjiIHZQlH7fFpWjE7HwrGZftLXuKbIsLNA+GwjHMnPj2A
         95K/iqUdGzps8rZh0y8MZbQsns2+vrJi6oUWUzshgwgq35uQJitbgqFUATl+qPxI8vNS
         /5yznRU6hXNcSVS/wOAtLyoWdCjrt5Vml+K8L1uEYYlI29zSxrJZeitKNP2j5HymYoeN
         j76Mz7TY7FmLfimGVc0ligFEcKm8FZ+7h1CEZvgRn6Ce0mziOvYzW+zLE4N/o4nb/enP
         vo4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBP46j60KshrwvVU8S9vNJWv3hYbJPM08akCEhUKoYycy/YHTQlz6vINVYEpCoSie3yxqLXoG0iPQuRKItFQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIVejA8QDpb321/PoF9eB8TYbGfOL/b1Vbb4pJSnwav8rlV3hg
	5MHhaFJn6dVORe/qFeLLjSX4TUR92MndxkIrlAcb10bezVoahxc4iQw58+MXY8PJkmw=
X-Gm-Gg: ASbGncs+Pl1mgeCFgy2Xfc0PvbAYqHr/6syX/dtBOYiqXVT1QDSzg4/GOvzVN7MHmCc
	0I5HeX6cEe2ooywIKdCUvVNA1saYv6zxWOYLTyYjB7ThQW7LDcc3PP+IRONUJh5056ySq3gh1OQ
	kkRCaIXzp3NoIhOJTIW/peUh9i0mV4jriScLmQxKXUQHu8EWHLv7+xfoTTZMsjPxo9vnx7YP+Td
	o+Wp+p+72FSPwYJIgLJcEOQNmwd7YrR96hJcC/cZxAUfgrZcpTg6q8EjmfXliJdwmw55QkkSJDS
	m8dUja8PGvCbpWQvecQ1IH9ZiQl8Z/AllNlwtRY1/5MwxLy3nyEtzea8M3VJmnOGhHKTMzW4+jh
	KV2FyhXBJHjum+pmUlzNq
X-Google-Smtp-Source: AGHT+IGHsnt5I+k7LE92/G9eFGeVn+BHXduOeLqVjzYHaGY4iH/sZrh2puQGctc+9XB7qZF1QzFT9w==
X-Received: by 2002:a17:903:244a:b0:223:5c33:56a8 with SMTP id d9443c01a7336-23414fb18ffmr9697045ad.35.1748028233664;
        Fri, 23 May 2025 12:23:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4af1b75sm127752175ad.85.2025.05.23.12.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 12:23:53 -0700 (PDT)
Message-ID: <01696003-e2b4-4450-85cf-715e31b136d5@rivosinc.com>
Date: Fri, 23 May 2025 21:23:41 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/14] RISC-V: KVM: add support for FWFT SBI extension
To: Atish Patra <atish.patra@linux.dev>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>, Deepak Gupta <debug@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 linux-riscv <linux-riscv-bounces@lists.infradead.org>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
 <20250523101932.1594077-14-cleger@rivosinc.com>
 <DA3K95ZYJ52S.1K6O3LN6WEI0N@ventanamicro.com>
 <9f9e2869-725d-4590-887a-9b0ef091472e@rivosinc.com>
 <DA3OJ7WWUGLT.35AVP0QQDJRZV@ventanamicro.com>
 <5dd587b3-8c04-41d1-b677-5b07266cfec5@linux.dev>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <5dd587b3-8c04-41d1-b677-5b07266cfec5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23/05/2025 20:02, Atish Patra wrote:
> On 5/23/25 9:27 AM, Radim KrÄmÃ¡Å wrote:
>> 2025-05-23T17:29:49+02:00, Clément Léger <cleger@rivosinc.com>:
>>> On 23/05/2025 15:05, Radim Krčmář wrote:
>>>> 2025-05-23T12:19:30+02:00, Clément Léger <cleger@rivosinc.com>:
>>>>> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
>>>>> +static const enum sbi_fwft_feature_t kvm_fwft_defined_features[] = {
>>>>> +    SBI_FWFT_MISALIGNED_EXC_DELEG,
>>>>> +    SBI_FWFT_LANDING_PAD,
>>>>> +    SBI_FWFT_SHADOW_STACK,
>>>>> +    SBI_FWFT_DOUBLE_TRAP,
>>>>> +    SBI_FWFT_PTE_AD_HW_UPDATING,
>>>>> +    SBI_FWFT_POINTER_MASKING_PMLEN,
>>>>> +};
>>>>
>>>> How will userspace control which subset of these features is allowed in
>>>> the guest?
>>>>
>>>> (We can reuse the KVM SBI extension interface if we don't want to add a
>>>>   FWFT specific ONE_REG.)
>>>
>>> Hi Radim,
>>>
>>> I didn't looked at that part. But most likely using the kvm one reg
>>> interface seems ok like what is done for STA ? We could have per feature
>>> override with one reg per feature.
>>
>> Sounds fine.
>>
> 
> Yeah. We can have a follow up series for SBI FWFT state that allows user
> space to toggle each state individually.
> 
>>> Is this something blocking though ? We'd like to merge FWFT once SBI 3.0
>>> is ratified so that would be nice not delaying it too much. I'll take a
>>> look at it to see if it isn't too long to implement.
>>
>> Not blocking, but I would at least default FWFT to disabled, because
>> current userspace cannot handle [14/14].  (Well... save/restore was
>> probably broken even before, but let's try to not make it worse. :])
>>
> 
> User space can not enable or disable misaligned access delegation as
> there is no interface for now rightly pointed by you. I guess supporting
> that would be quicker than fixing the broader guest save/restore
> anyways. Isn't it ?
> 
> We can have the patches ready for the next MW for FWFT one reg interface.

Yeah sure I'll work on that in the meantime.

> 
>> Thanks.
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 


