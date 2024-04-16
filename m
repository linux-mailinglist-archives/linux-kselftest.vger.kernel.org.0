Return-Path: <linux-kselftest+bounces-8099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C708A6621
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A4D1C20C5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 08:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A227882860;
	Tue, 16 Apr 2024 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oRSHb/GE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D0B11C92
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713256294; cv=none; b=j3c+5Sd/OBU/I2lQ8HcFJuUxFGM9KizGBKdlfEJ0mzTVv/iKEz/nRFO+scANisAx/M95j7UwHdYrWtfMeWUulsCup5+gSVSZXtVkfxedvuCiqTC6JZxm3w1REGPuGs+0Im0nYCEbynMq18mBntxWVRZLf7yjx10kO7FloVNIVIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713256294; c=relaxed/simple;
	bh=QJUQ/zdpL5MKogbwTVUpahdJojofb6ggmogXZkHP62Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpDpCd4KQ27+pSTG4uSgMuXPdZ97uzQpAV6P6kyXwHws+O7l6GS9HHH+bnwaqY5w02mvpq91lu4RfjHiRvs8b8nbSKhpC9HqxBUy9cJ/k5/uwSZfTOXdCz58DSxlpPxeOPDpzcZW0ePAHqdac/Lj2YxyXgHMhRYCdRST1i5jdsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oRSHb/GE; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a4bdef3d8eso3035679a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 01:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713256291; x=1713861091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akzntEN6IcfsPIIN3EJ0b1QR4PPdVf92yYRa0+VTDrk=;
        b=oRSHb/GE4NTlJUP44a/g5ZX2WwTpYnOxJCRdWcqjvaeKU6h9W3cuQHo6VxdCkLHEw6
         c6/qZqC3K8ZHpFcKWH13prM75+sAEWMcoEX9hE8dC0Ynj9UqkMh8qlTaHhI3213ZnZEn
         xIh4LqVfQiMxBnuGlKEcgUUp6wRiTDIdat6bSNzCOM8NOYXg6JcrNPLBQL5am3Kg189P
         FENpHXd2RpodMT/R8VXUsYtRNBCK+OjZIMyhP8j2gVAVJtbcbthQgv9Jln5Uvtx/q8OK
         jb52H5FkbY7vTkn4ui+xwjrPpt4Hl8SU9NQCkfNV3JD6gsaniklTRKQEi7izBVvIbwGN
         LUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713256291; x=1713861091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akzntEN6IcfsPIIN3EJ0b1QR4PPdVf92yYRa0+VTDrk=;
        b=BqcL13rcEV6rZAI7fgAuKXEktYwoXKfpKsfaByRSDMFwqrKNEDR+ChzE2qphfE3Qzm
         5gnIa5gM+jRKgBfwn5b0pCxHzQU+ak+F5zUNtpQc8HzRT4wENMDSWK+ZyZhgSBosaYPh
         oCkxevWF76ObS1dM5LVEH4aZvjlGQhROBf5tvqVysGenwnOpkcd/tIQijvD4lCyPXMWQ
         e5wMjgz985PIPtCCB2M500NwL4mqHGM7j3fBGsCd15lB1OZDsqf1c28JyLt1ZA8Xtwun
         F5JS7fyzUEfl2oJn7aoD0nlrSh4Q7girlbaI6ckdesgXPThfAygeeFLMr8wsNztBgHPR
         ohmg==
X-Forwarded-Encrypted: i=1; AJvYcCUKOyK5+KewtOscu7m6ZVF9uTbaCmep7UM1lVBwyqiwGeYqej0zYbe9f4Vswt0Iu766FggMedJviv4egdKoHIE4UZGh2Kaw9AaeFDM2Be0d
X-Gm-Message-State: AOJu0Yww0PV4lxab0npL1b7fjt0NFdnwuU99Zj7xva/mMEXL3DWZcD3a
	ztzw5KEmEfJN3nLxGuyei2/vjzUVJyq6sWcduIXVZm6WetS7auXCJXvsb9RNLdc=
X-Google-Smtp-Source: AGHT+IEjp4eHKvU41MXzaTBSiCq/DCxOMtVytJg0BK7QzgSTloHHj2HR6MrE7Rn4vkRt6wQgP/UbDw==
X-Received: by 2002:a17:90a:640a:b0:2a4:752f:b7b7 with SMTP id g10-20020a17090a640a00b002a4752fb7b7mr11498554pjj.26.1713256291117;
        Tue, 16 Apr 2024 01:31:31 -0700 (PDT)
Received: from [172.16.0.33] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
        by smtp.gmail.com with ESMTPSA id d24-20020a17090ab31800b002a513cc466esm10012347pjr.45.2024.04.16.01.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 01:31:30 -0700 (PDT)
Message-ID: <2a63d7da-91b6-496d-9966-e6c0a0aa6c6c@rivosinc.com>
Date: Tue, 16 Apr 2024 01:31:27 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/24] RISC-V: Use the minor version mask while
 computing sbi version
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Alexey Makhalov <alexey.amakhalov@broadcom.com>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, x86@kernel.org
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-8-atishp@rivosinc.com>
 <20240415-e229bb33ad53ce43e3534f5a@orel>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240415-e229bb33ad53ce43e3534f5a@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/24 06:06, Andrew Jones wrote:
> On Wed, Apr 10, 2024 at 05:07:35PM -0700, Atish Patra wrote:
>> As per the SBI specification, minor version is encoded in the
>> lower 24 bits only. Make sure that the SBI version is computed
>> with the appropriate mask.
>>
>> Currently, there is no minor version in use. Thus, it doesn't
>> change anything functionality but it is good to be compliant with
>> the specification.
>>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   arch/riscv/include/asm/sbi.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>> index f31650b10899..935b082d6a6c 100644
>> --- a/arch/riscv/include/asm/sbi.h
>> +++ b/arch/riscv/include/asm/sbi.h
>> @@ -367,8 +367,8 @@ static inline unsigned long sbi_minor_version(void)
>>   static inline unsigned long sbi_mk_version(unsigned long major,
>>   					    unsigned long minor)
>>   {
>> -	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
>> -		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
>> +	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT
>> +		| (minor & SBI_SPEC_VERSION_MINOR_MASK));
> 
> The previous version had ((major & major_mask) << major_shift) | minor
> (parentheses around all the major bits before the OR). Now we have
> parentheses around everything, which aren't necessary, and no longer

We have to use parentheses around | to avoid compiler warnings 
(-Wparentheses)

Are you only concerned about the outer parentheses ? I have removed it.

> have them around all the major bits before the OR. We don't need the
> parentheses around the major bits, since shift has higher precedence
> than OR, but I'd probably keep them.
> 

Is this what you prefer?

return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << 
SBI_SPEC_VERSION_MAJOR_SHIFT) | (minor & SBI_SPEC_VERSION_MINOR_MASK); 
 



> Otherwise,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
>>   }
>>   
>>   int sbi_err_map_linux_errno(int err);
>> -- 
>> 2.34.1
>>
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


