Return-Path: <linux-kselftest+bounces-35321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FE8ADF7A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 22:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECF71892DE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 20:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9083421B184;
	Wed, 18 Jun 2025 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iOOjnzdJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48870217654
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750278266; cv=none; b=mR3tbXJKQnueMM9gkYdU3rHxSBmoZ4ApCmt91+kscW9cmpxn3IXpyCuOA1ti1xw8gjVvXCv8Vm2EG8BolBwuzTempaRa0u8kYCr4oB8oNABbn7VLIaE53BUS5U/4yFjpuOxov4aFMDoF4A3SMUHTQQkTrYxDYPPxw2INkIbxp1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750278266; c=relaxed/simple;
	bh=ylZ70ncHbeW/ivx3qza5+aWLiJZv9MG+zSnbg5933kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oJ67n3Ar6reRYJBSLjZHCxbhS5FoIoD1tzkhTDrqMCWDme8qr5y9ZBAyW3xjYmKHdt3vwRiMsQn6MvVNPeN6EaZTK+SycRd4NZRBSGjtwAtzb/qZY3YH+BzdF3uK2hwfbmvp+PPnErMThszfgpVrrL0Jafg34Scx+xsrSkd7JmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iOOjnzdJ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-87404493fd2so350139f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 13:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750278263; x=1750883063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HCu35ww/oMEyXBf94BroyAlUN2PE2A2StVRIVaVmA9U=;
        b=iOOjnzdJHW32DM8APCZhwjUnRbKB7h6lXJol6FKciWWy9MZ2DV8T/ULJwPVi2GxoQH
         7UvX3+MeNkYICHbpo1emG7rUKkAZn2mQzS9qM0LfVWDUS0nSlYP2saJFrG/QtMYlYNLt
         EHj/l40v7L4bIfUA0EhfX2ZNEEXbkrU96oYQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750278263; x=1750883063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCu35ww/oMEyXBf94BroyAlUN2PE2A2StVRIVaVmA9U=;
        b=KEW+8w20fz2c3afya6PLtO1327RGTSUEJSmd4/301qvnByuuBWrtvYgSzLYz+0P4L6
         2H4Ic+qDUgJIWXD6hNWer5iodJFoOwubDS0ZsPlwwnmxeFRF6kYwds5hE3uVED26qtN6
         NuHpE9v3mCQeSzN4d2FWXdPM75Yx4G/yoJcaoLEzzre6Ny4fv7J1dRHjFNOZuD6iLYiF
         +2uKyU2/dueYGIRD4eL0EG9tcCC8sO4d+CezzYkT3xBx7DbYHNyqdkMCTHaNyvPORHwW
         fTKg0MaDH3N/EGjCku4YoYkAhI+T1ihotQmOFWomvc7f85obD9AjyqAapW+JIvID4jzu
         rEkw==
X-Forwarded-Encrypted: i=1; AJvYcCWBalg8Czt70L+EmGWOadAy62ovWSGt1NMJItZ4GFNTGnHjkUoUenUD4673syqCeOdj16lYKNSefiTVwGYhlsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfMl6LOdx7zKJfSf04LQnk6p+sJaA1H15ziq8iyBGJa0ZghMrC
	VRoKqkHV6oXn5FZRakjasA5N9yCqjesCwxxZnAnVEko/R3xS366QudDVMNmSc8YHWh7odHppIHC
	R8DbK
X-Gm-Gg: ASbGncuT/+jpQfxfrjnMSI3cztkuclUIKPfTiqBb9uvMcC5955B0zXS6gusaO4miTuP
	0PKS0fD9oGBFgiu9UXmWH4SpBYERT7sfwMVUUYDgVJuJbqT149zkHiIVcJp8UAtsArNZvwqvk8J
	s0bhrPqlj2yiDL2p/M8KT5T5e7v9Lhy1kZyjW1h/NsulMXHCBLfzsnXwDenJnn5c2LfMg3s/MAu
	t1FlrIpAFThuAxuFB+jd8ho9lLD9b0DGsZFufPjHfVsnlxSy/pNrGn3twFUnXCR2QHGcJfXbZz2
	yqyj4tAcoZ+rYB2l+nXyI00fNRqawqkrphdUPVHP5rkLgxWbmwOgth4t1cnthqoTZnTTxBkiiNA
	9bNmq/tKr
X-Google-Smtp-Source: AGHT+IGTr4xk86dP9TBj1SzxxbPwDomUhdedUjIGYija/fR1bC30muYfH3ph6QLHGAUs2xkjCGl4Mg==
X-Received: by 2002:a05:6e02:1529:b0:3dd:b706:b7d3 with SMTP id e9e14a558f8ab-3de07c55935mr222589545ab.7.1750278263146;
        Wed, 18 Jun 2025 13:24:23 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3de01a4ae11sm31814405ab.52.2025.06.18.13.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 13:24:22 -0700 (PDT)
Message-ID: <452559d3-cdb5-4e57-be83-c8f75bd1e142@linuxfoundation.org>
Date: Wed, 18 Jun 2025 14:24:21 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [next] selftests/ptrace: Fix spelling mistake "multible"
 -> "multiple"
To: Ankit Chauhan <ankitchauhan2065@gmail.com>, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250501060329.126117-1-ankitchauhan2065@gmail.com>
 <20250611022156.ov4gifa52fagjd3g@ankitchauhan-Legion-5-15ITH6>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250611022156.ov4gifa52fagjd3g@ankitchauhan-Legion-5-15ITH6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/25 20:21, Ankit Chauhan wrote:
> On Thu, May 01, 2025 at 11:33:29AM +0530, Ankit Chauhan wrote:
>> Fix the spelling error from "multible" to "multiple".
>>
>> Signed-off-by: Ankit Chauhan <ankitchauhan2065@gmail.com>
>> ---
>>   tools/testing/selftests/ptrace/peeksiginfo.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/ptrace/peeksiginfo.c b/tools/testing/selftests/ptrace/peeksiginfo.c
>> index a6884f66dc01..2f345d11e4b8 100644
>> --- a/tools/testing/selftests/ptrace/peeksiginfo.c
>> +++ b/tools/testing/selftests/ptrace/peeksiginfo.c
>> @@ -199,7 +199,7 @@ int main(int argc, char *argv[])
>>   
>>   	/*
>>   	 * Dump signal from the process-wide queue.
>> -	 * The number of signals is not multible to the buffer size
>> +	 * The number of signals is not multiple to the buffer size
>>   	 */
>>   	if (check_direct_path(child, 1, 3))
>>   		goto out;
>> -- 
> I am new to the Linux kernel development and still learning the
> development process.
> This is the patch I submitted sometime ago. Not sure what to do next.
> 

Applied to linux-kselftest next for 6.17-rc1.

https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=next

thanks,
-- Shuah

