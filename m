Return-Path: <linux-kselftest+bounces-26328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B1FA30289
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 05:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD909168682
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 04:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23E11D63FB;
	Tue, 11 Feb 2025 04:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LT5hQ26v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5CF1A23BE
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 04:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739248300; cv=none; b=Sc3jhUNi5+RmrrfDmUzQ9OBbVcgBb+gcdk2jQN/GAj1fUmHvTfUr5qeLqTKlF7bdah8xxpQ6esNOrHUvMpt6ssB861IA2+Ms5bs0DAtN6RHmvb+Gnao7r3jO5WCnIN7d+Z2Yyg+KoVPbDeB58I/NRGMb/zBF0kA02dWXg/s5wto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739248300; c=relaxed/simple;
	bh=KBi+G9UGgPx2k8umZQyZtGo0Tkv4fp4ucz0iGRT1/ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+ZazW5pYxExfWF/5ViSKMKYDvZUILvVLDhhE6pKCTqwZLP69wVksY9R8EH9253+kYb4bARrOFY8vxxPj1FzeGoiI8b9YM6ooUAdB8bHWrtTj4P51BbSDvd7Oc+k9uHg4imiG2DpDthSWiLoVf23pIYfGZ8kVTbg7i9eqKGdoqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=LT5hQ26v; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8553e7d9459so28766739f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 20:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1739248298; x=1739853098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uk7QCT1ibthTmG31kgz2RQ3fd9RFf43i5AcvZcwTxN4=;
        b=LT5hQ26vzNTfE/pnK0iQOZRlVJ9iOVJQ30cBQmxNxGOYs0Vtyj0Q9LZ/WXHnaWr8WU
         8FodzwkLHV86p1IUbMUClZ9I4/aeZYYEGROWTkIEkLhO3n4w3dqfKFA7tM4PlmtHKxrM
         NxDtHeltMZL1QL6dPtT64MMeL1LqLFoBAePnhx1+7+Qr/JLh3uCcFaYzggmbRAIWwpZB
         C9c5pou1ojdbaiGDB1o+FBiigUli+g4i25OaoeEoloPr5csOaMngMzQ4h0MXF67Pz7XY
         4FQWQchXuJhtDRzcL2EB+VDzyNVYrgA7enODAz6mFQfVVAoqeY3zftSgOYIkKPut6lW9
         0KCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739248298; x=1739853098;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uk7QCT1ibthTmG31kgz2RQ3fd9RFf43i5AcvZcwTxN4=;
        b=qSPyK8x4UF0wrou62zOisArlDGRBSTZwvcJ0cAegB3AHwi4wgu0yFqqnWkm5wa0YuA
         GErdKrfg00ipgom5lIQei6/m8PTCzzvWTrQp9rR63BGfGJ/eyoHRtu7rkHOHXm5kjxyk
         xe6ZzMaCFigfZhlMFdib8miCvN2DJKsaXQe2LNnFBCTS3MgGW0LCnTA8jryASLfwGep6
         03Hl4JdbOLSAAAREOmb3664o3S+9XnNkkKcfIem1kLBrQI4pNEcUNB/HJZcV+fiWIVDp
         SpUEkQw0HFk4mh3vrhnvHnRhqtI31HMxeoSOkQKqIk3OM1TNqlXogi/0FOFZWz7jG7qO
         9Mrw==
X-Forwarded-Encrypted: i=1; AJvYcCWCaZSLzuIkmmiLYH8xv65QezQ3WObXBMSo33Q3qKrRboScRa3YUd0KOzeWEVfrKw1AEoexMAhbcExCI0QqSrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX7OuZkWlxnWjcwzID90V+IGVtsRqMrmQoFDCvkTOY/nBXuTCA
	Ek4hCqYnSXuk05CTgLniH08lGvCZjI4IujkFMJSTscp5HVtnH78FXfDugP5+fMQ=
X-Gm-Gg: ASbGncsRWC3zrdKgDqs4sO+MvIXYOxUkSeDA6yWzrEsMuiGqcl+s0G8y+9sMB56zD24
	EUZ4WpdoVEO3rj10w8hIwSYY35w2ooA5nTOHigp2Dvm2Eskbfgbbt4A7QY4PZRQW26QhgYvnkXv
	/1lDJgYmrITVPf3+TUM6ofq3kPBDNr+42Qu+6RvDWhU3tV786TNucYQ9WXxYiVqYuInmUfb+Thl
	EpEaN9ozmCcXlpS+ZVCYjfdjVzxBL7w/UqQDwgs4ZXfE/xIuF2WRQZ3W5PpfxM+QCPRZbo45Wwm
	5XH77YNWhCZO6Lz2bSDB7lQxefyBXsMw2+gdRHA=
X-Google-Smtp-Source: AGHT+IHEmCDuHZ+8uB9f8GDunxYoBJjA1XFOTU/tpz/O0tguykq12oFATdzw1dCWB2rK39lLH2IaZg==
X-Received: by 2002:a05:6602:3946:b0:84a:5201:41ff with SMTP id ca18e2360f4ac-854fd886d54mr1422323839f.3.1739248297943;
        Mon, 10 Feb 2025 20:31:37 -0800 (PST)
Received: from [100.64.0.1] ([165.188.116.9])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ecdb903a89sm2110916173.70.2025.02.10.20.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 20:31:37 -0800 (PST)
Message-ID: <6223225b-a7cf-452d-ae69-d895b5f23d62@sifive.com>
Date: Mon, 10 Feb 2025 22:31:35 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] riscv: add Firmware Feature (FWFT) SBI
 extensions definitions
To: Deepak Gupta <debug@rivosinc.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org
References: <20250210213549.1867704-1-cleger@rivosinc.com>
 <20250210213549.1867704-2-cleger@rivosinc.com>
 <Z6rMtBud/hsKYYIw@debug.ba.rivosinc.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <Z6rMtBud/hsKYYIw@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Deepak,

On 2025-02-10 10:06 PM, Deepak Gupta wrote:
> On Mon, Feb 10, 2025 at 10:35:34PM +0100, Clément Léger wrote:
>> The Firmware Features extension (FWFT) was added as part of the SBI 3.0
>> specification. Add SBI definitions to use this extension.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
>> Tested-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>> arch/riscv/include/asm/sbi.h | 33 +++++++++++++++++++++++++++++++++
>> 1 file changed, 33 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>> index 3d250824178b..d373b5c08039 100644
>> --- a/arch/riscv/include/asm/sbi.h
>> +++ b/arch/riscv/include/asm/sbi.h
>> @@ -35,6 +35,7 @@ enum sbi_ext_id {
>>     SBI_EXT_DBCN = 0x4442434E,
>>     SBI_EXT_STA = 0x535441,
>>     SBI_EXT_NACL = 0x4E41434C,
>> +    SBI_EXT_FWFT = 0x46574654,
>>
>>     /* Experimentals extensions must lie within this range */
>>     SBI_EXT_EXPERIMENTAL_START = 0x08000000,
>> @@ -402,6 +403,33 @@ enum sbi_ext_nacl_feature {
>> #define SBI_NACL_SHMEM_SRET_X(__i)        ((__riscv_xlen / 8) * (__i))
>> #define SBI_NACL_SHMEM_SRET_X_LAST        31
>>
>> +/* SBI function IDs for FW feature extension */
>> +#define SBI_EXT_FWFT_SET        0x0
>> +#define SBI_EXT_FWFT_GET        0x1
>> +
>> +enum sbi_fwft_feature_t {
>> +    SBI_FWFT_MISALIGNED_EXC_DELEG        = 0x0,
>> +    SBI_FWFT_LANDING_PAD            = 0x1,
>> +    SBI_FWFT_SHADOW_STACK            = 0x2,
>> +    SBI_FWFT_DOUBLE_TRAP            = 0x3,
>> +    SBI_FWFT_PTE_AD_HW_UPDATING        = 0x4,
>> +    SBI_FWFT_POINTER_MASKING_PMLEN        = 0x5,
>> +    SBI_FWFT_LOCAL_RESERVED_START        = 0x6,
>> +    SBI_FWFT_LOCAL_RESERVED_END        = 0x3fffffff,
>> +    SBI_FWFT_LOCAL_PLATFORM_START        = 0x40000000,
>> +    SBI_FWFT_LOCAL_PLATFORM_END        = 0x7fffffff,
>> +
>> +    SBI_FWFT_GLOBAL_RESERVED_START        = 0x80000000,
>> +    SBI_FWFT_GLOBAL_RESERVED_END        = 0xbfffffff,
>> +    SBI_FWFT_GLOBAL_PLATFORM_START        = 0xc0000000,
>> +    SBI_FWFT_GLOBAL_PLATFORM_END        = 0xffffffff,
>> +};
>> +
>> +#define SBI_FWFT_PLATFORM_FEATURE_BIT        (1 << 30)
>> +#define SBI_FWFT_GLOBAL_FEATURE_BIT        (1 << 31)
>> +
>> +#define SBI_FWFT_SET_FLAG_LOCK            (1 << 0)
>> +
>> /* SBI spec version fields */
>> #define SBI_SPEC_VERSION_DEFAULT    0x1
>> #define SBI_SPEC_VERSION_MAJOR_SHIFT    24
>> @@ -419,6 +447,11 @@ enum sbi_ext_nacl_feature {
>> #define SBI_ERR_ALREADY_STARTED -7
>> #define SBI_ERR_ALREADY_STOPPED -8
>> #define SBI_ERR_NO_SHMEM    -9
>> +#define SBI_ERR_INVALID_STATE    -10
>> +#define SBI_ERR_BAD_RANGE    -11
>> +#define SBI_ERR_TIMEOUT        -12
> 
> nit: Space mis-aligned(^)    ^

The alignment is correct when the patch is applied. It only looks wrong in the
patch because the "+" from the unified diff format causes an overflow to the
next tab stop.

Regards,
Samuel

> otherwise
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> 
>> +#define SBI_ERR_IO        -13
>> +#define SBI_ERR_DENIED_LOCKED    -14
>>
>> extern unsigned long sbi_spec_version;
>> struct sbiret {
>> -- 
>> 2.47.2
>>
>>


