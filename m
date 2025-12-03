Return-Path: <linux-kselftest+bounces-46945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F85C9FF64
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 17:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6262A3024E73
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A0E3277B1;
	Wed,  3 Dec 2025 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KjmL/NCZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D805326D77
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Dec 2025 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777562; cv=none; b=AyV5x+BmlSCxaI/biO3UuSkJDeq7u8zGzYxl6vvClGIuixxFKi3v6NgP9+qytEtwYtoQ1wZfMblxoOhy3qcoSAl9wUCAY9fRvcq4Rioptn8w/UeMSQfKZtdkrywohMvuV43sQyWKPgtbEWOIrQCp59K/DvzxQ47IwmwoR+uXqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777562; c=relaxed/simple;
	bh=iakk/Jr76m1kJL5Np9IbPtoAP3+T1JvteiA3kLHZ94M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYKDMguguSCL1qqLxY46s4HQcQiYYnsI4tPq2DxpvKg2mS1cOunLdxmUAxkH+NBR7asksAI+n6Z3ymlheYdiYpj3a6BzrG7GFJ1Dk5JSrZWAOkLjhOVKCpC+3vlb1TGxufChPPPHO6PCZNUfdtbVWil9qdvGdSz0T5l+IxNWZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=fail smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KjmL/NCZ; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c75fd8067fso4135640a34.2
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 07:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764777560; x=1765382360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V34xiYHMBhlRprMCQ3/uOloSz9kB9mYUn7HTGoE0360=;
        b=KjmL/NCZGhpvD+wNtHg6HyH1dhoO5OjQului2xmbn701FQHz574G2PSvbHravx8WsS
         tBT8pqcGZj9+2yIRo7qIG84OD6bRvmEFA57ellbKmSPKhM+NJi8/bMjnFpxWJBKqbAAN
         C6MumKEWg8+DzZ6g2gpIU0O/S2C4UzHOVPdEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764777560; x=1765382360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V34xiYHMBhlRprMCQ3/uOloSz9kB9mYUn7HTGoE0360=;
        b=evCl7UXQvlPsPUEogL5Y6lSH4yLwsfqbg/YtdZhKvuLXofrWLi0l1581/j2HwBAmow
         iGHBa+eaXWRFkqs41bggT3zO7m0DyLTy7nh6mVsSUPmku9GjjbMQSFCrTKsAYXQeKxZ7
         8ghT9//t1fKMB+MBUWoZ5u7d8pXpXUU5Ozkj+Xdevp0FLGN/BhM2nY2GaJUoXsslRzXE
         xUO0SsF/538pQj+XXktRR8SjxVPE4zyWfIteYwcKJV7lQt/19rJLX+FbqYm2/Bm05DfL
         S94PEjB45eMjeqKjWICD1+5Aue3hiHGX3hKjbe3ETweHYnSkzM7cl+xiDezo1Cebcqpo
         mW1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtvn3S2/KA1/ZGt9rf/p/yAjiydHF77E4uLWX24k9wCdYL3Sq6UpenNKO/YJV3QPq45kjzkpWbZ7QtfrQVNVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRZK2lE+HV6XnCdDzbjwoRqpD9V3OiRH3Zw7WRg5FmmjZTvxtC
	uOj+7d45+Sv3BfuorXCN87SwzBts6KCoszTmaWNWCwLGDYpRjmAckVrZFYWiOwJHwgQ=
X-Gm-Gg: ASbGncsgiTSFyhpHZs+LNtpl8L+2UZ4p1mrCU5YNZamipOGfAfbdy3lOCMSTiY52DeH
	EPxLUD75O0VfKg+UoryyoNtyaebjBHZUdrpnOU3IsWrIRdnclZZjF5+YHULiVyfO8ld2HjbkZ+M
	mH9EhFc1bBm/PFdLXv/OUx7j6HW/NISY7C/TYqE3pPAILB91e8dMVyFAh9HiZ4e3OlV2m1RFZCU
	QAZggTd30fZYeOXZpGwhLl6fauxMC+ceS4SWTKJH2Nnf+p//llRgJjeOs1RyfATD3TXVwR3ZSsi
	UshNmif373c9IJf/CM+YaJ1pIY5UCwEhY/kwPmAh2Nci3YzQ21Ou3t41yU6yT0OsvhHeYAXuZmB
	PpZEs2mWQ1lXi520snpY/Fb+OVghDK7uJlltlHBpxMieO0UhJUSHM9OS9aZHfQ0buxa06cLU8/M
	hjyqtRF065tRGGuaXqFU3wn6k=
X-Google-Smtp-Source: AGHT+IHZKqU6OwoL05VlFhrm59ANsB5LDQOaT2yu73WegIU0kb05V6z7peIr7y7gMgvG/jBK7FYjzQ==
X-Received: by 2002:a05:6830:4389:b0:7bc:6cc3:a624 with SMTP id 46e09a7af769-7c94dd09ab0mr1682360a34.32.1764777560172;
        Wed, 03 Dec 2025 07:59:20 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90f5fedbbsm8945257a34.10.2025.12.03.07.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 07:59:19 -0800 (PST)
Message-ID: <a5a1d7bf-04b0-43fb-8f93-781c3534d8fd@linuxfoundation.org>
Date: Wed, 3 Dec 2025 08:59:18 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/seccomp: fix pointer type mismatch in UPROBE
 test
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, llvm@lists.linux.dev, khalid@kernel.org,
 david.hunter.linux@gmail.com, Jiri Olsa <olsajiri@gmail.com>,
 sam@gentoo.org, shuah <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <aP0-k3vlEEWNUtF8@krava>
 <20251026091232.166638-2-nirbhay.lkd@gmail.com>
 <8e1ff2f1-b45e-4b1f-b545-d433e277607f@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <8e1ff2f1-b45e-4b1f-b545-d433e277607f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/25/25 04:20, Nirbhay Sharma wrote:
> 
> 
> On 10/26/25 2:42 PM, Nirbhay Sharma wrote:
>> Fix compilation error in UPROBE_setup caused by pointer type mismatch
>> in the ternary expression when compiled with -fcf-protection. The
>> probed_uprobe function pointer has the __attribute__((nocf_check))
>> attribute, which causes the conditional operator to fail when combined
>> with the regular probed_uretprobe function pointer:
>>
>>    seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional
>>    expression [-Wincompatible-pointer-types]
>>
>> Cast both function pointers to 'const void *' to match the expected
>> parameter type of get_uprobe_offset(), resolving the type mismatch
>> while preserving the function selection logic.
>>
>> This error appears with compilers that enable Control Flow Integrity
>> (CFI) protection via -fcf-protection, such as Clang 19.1.2 (default
>> on Fedora).
>>
>> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
>> ---
>>   tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
>> index 874f17763536..e13ffe18ef95 100644
>> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
>> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
>> @@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
>>           ASSERT_GE(bit, 0);
>>       }
>> -    offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
>> +    offset = get_uprobe_offset(variant->uretprobe ?
>> +        (const void *)probed_uretprobe : (const void *)probed_uprobe);
>>       ASSERT_GE(offset, 0);
>>       if (variant->uretprobe)
> 
> Hi all,
> 
> I'm following up on this patch that fixes the pointer type mismatch in
> UPROBE_setup when building with -fcf-protection. It resolves the
> incompatible-pointer-types error seen with Clang 19.
> 
> Please let me know if there are any comments or some changes needed.
> 

Hi Kees,

Is it okay to take this patch through my tree?

thanks,
-- Shuah


