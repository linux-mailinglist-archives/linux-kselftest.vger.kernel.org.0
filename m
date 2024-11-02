Return-Path: <linux-kselftest+bounces-21344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D939BA218
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 19:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A833E1F217C6
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 18:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036201AA7B6;
	Sat,  2 Nov 2024 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDbAlzr/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2592B15E5B5;
	Sat,  2 Nov 2024 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730573790; cv=none; b=Jj2OZTpPpgWZ/9/7O3DMkPGGQLB12Z27CeF9wRfnSDySkunGi8eIIgR8JLN9BFDwELWL0xFt+vCWnjcNRYYynIE6zMnFe2Hlxnls5lrWF9igKOyM1a7YOQFNwQG+Ip2X+CR9vKbZSc8EIMMONsp2zUqP0Bu2Jsyn3nU1epvMQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730573790; c=relaxed/simple;
	bh=7QeM04EM0YFR3Z3/S/OYVO+OfYGTXCTZU0XRDgRkxL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MM41eUjp/Bi//CmwJt0oYUkDCRZlJhSBnX4w2tfjwB46oJ1Ae+uZeQo2YCpgnKPfhp0lbaT/DllrnmR6Rq5ffwDzuMJR9zxYQ3J+aAKQ8vABjW1X3FM5i5z64+ydb/J09MXSg2JJlPP6tpf6azlNEJwL6fIqtpdppCJ3kRuSYzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDbAlzr/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ceb75f9631so2638441a12.0;
        Sat, 02 Nov 2024 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730573787; x=1731178587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NWC+gjEyCqr5E3blGfY3A7hEvdkevCUpxwSqcipkieA=;
        b=bDbAlzr/hEt1Qs6qIrV0d2/7DoLvVIYwCiXNQsMFgnzCWwDwZjVgzyc8qvKQJS8CrB
         CI9CP21mLBesIEJ264cidR9GNT/uElqC6gFKAUSLfoApOXAOcO5ssXNdSNNLblAedSu+
         VcnZZmUIwKWN5hU+wotdNDR1eURk3Q/uCnoAYthxhB2cxo4h0E1Vdo0mZq/f/xKmWDI0
         q2Bx9Lf1ejSYk96+yYykHfwhcZiLV533N27lZpcnqtF82fYesnMtt9y9qwXNkOikGwBP
         qW1I5jLzpRnI97w9tKP9OuKn3SXr9GguRrI7QH6BOSimGTnsm1YSDnCrO/wmBtVbCKmC
         F9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730573787; x=1731178587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWC+gjEyCqr5E3blGfY3A7hEvdkevCUpxwSqcipkieA=;
        b=QkDUHsXAVYSofwDo/esIhb7AI/UADl+a4n3Phwe1ocy2PlaI6mZivNouNFZYRRDrIi
         4kp012wpCZDdeYQ0ha64ZQ455r7zWN76+Ss1dsVZbnQFJ3DggeX30gDOaFOvClHPikp6
         ChWa06Oc0rc46siuCXn5fP8I7dsdR5qXV4LGy38haeEROP0Y30HKacAK9+3KMQystfqU
         mnl+AAL33Q/J5L5DQy5DiyoXjfhEb69mg9SDaC7uQEWvJjq9Ps7ob0VvsOccpR1jscDo
         i2Z3rmSD5kZ+V1KUVDqXv96Nx19p1pbKGuMX99ZGvsxWLVlhh67Wx0VzrnIywiuxdB+a
         CDdw==
X-Forwarded-Encrypted: i=1; AJvYcCVbwUZefo0fLiO7SVloK18F7r376cuGKbkYsL+mIpuCQ7KnyP7JNz41axLLj+Can0Q9xqcC2IEDbtRqHg8=@vger.kernel.org, AJvYcCWH+4znQ1hS+kiFeiTgbi7P2nMRwVmcSoqAECqs5cDAnStZBKxkR4ogKlE29Zgf68IXHeQkOqsCDOkc0JXu2Jlr@vger.kernel.org
X-Gm-Message-State: AOJu0YzbGiZee+Jd9xFB4COkoHR9X38zy5OthsjaUa58Qwh2Fv651WBr
	z0DwlyzzMtHrQskotpfdiLrgHRGgWGRnCFkrapupv8yvWh7PfBCg
X-Google-Smtp-Source: AGHT+IGEQWz6ooYjGaCSgLNXrz5MuxJzqSOc83IxilSTdsdldQljy0mpnCM/Mqu8m3Q48kAxrDNPOA==
X-Received: by 2002:a17:907:31cb:b0:a9a:296:b501 with SMTP id a640c23a62f3a-a9de5f660a2mr2709296166b.26.1730573787115;
        Sat, 02 Nov 2024 11:56:27 -0700 (PDT)
Received: from [192.168.178.20] (dh207-40-94.xnet.hr. [88.207.40.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e566812eesm334973566b.194.2024.11.02.11.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 11:56:26 -0700 (PDT)
Message-ID: <04b9c37a-d39f-49eb-b7d9-fced64eb12e8@gmail.com>
Date: Sat, 2 Nov 2024 19:55:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] selftests/x86/syscall: fix coccinelle WARNING
 recommending the use of ARRAY_SIZE()
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20241101111523.1293193-2-mtodorovac69@gmail.com>
 <a2a9995c-deed-4545-bf65-9ce7a811609a@collabora.com>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <a2a9995c-deed-4545-bf65-9ce7a811609a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/1/24 13:04, Muhammad Usama Anjum wrote:
> On 11/1/24 4:15 PM, Mirsad Todorovac wrote:
>> Coccinelle gives WARNING recommending the use of ARRAY_SIZE() macro definition
>> to improve the code readability:
>>
>> ./tools/testing/selftests/x86/syscall_numbering.c:316:35-36: WARNING: Use ARRAY_SIZE
>>
>> Fixes: 15c82d98a0f78 ("selftests/x86/syscall: Update and extend syscall_numbering_64")
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: x86@kernel.org
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>

> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Dear Sir,

Thank you for your positive review of the patch.

There are much more suggestions by the coccinelle check, but that's a substantial work to do.

It would help to set some priorities in this by some more experienced developer.

Thank you.

Best regards,
Mirsad Todorovac
 
>> ---
>>  v1: initial version.
>>
>>  tools/testing/selftests/x86/syscall_numbering.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/testing/selftests/x86/syscall_numbering.c
>> index 991591718bb0..41c42b7b54a6 100644
>> --- a/tools/testing/selftests/x86/syscall_numbering.c
>> +++ b/tools/testing/selftests/x86/syscall_numbering.c
>> @@ -25,6 +25,7 @@
>>  #include <sys/mman.h>
>>  
>>  #include <linux/ptrace.h>
>> +#include "../kselftest.h"
>>  
>>  /* Common system call numbers */
>>  #define SYS_READ	  0
>> @@ -313,7 +314,7 @@ static void test_syscall_numbering(void)
>>  	 * The MSB is supposed to be ignored, so we loop over a few
>>  	 * to test that out.
>>  	 */
>> -	for (size_t i = 0; i < sizeof(msbs)/sizeof(msbs[0]); i++) {
>> +	for (size_t i = 0; i < ARRAY_SIZE(msbs); i++) {
>>  		int msb = msbs[i];
>>  		run("Checking system calls with msb = %d (0x%x)\n",
>>  		    msb, msb);
> 

