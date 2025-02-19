Return-Path: <linux-kselftest+bounces-26920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E29A3AD0D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 01:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F08173B43
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 00:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57476168DA;
	Wed, 19 Feb 2025 00:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aG7B9L+F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525D4EAC7
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 00:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739924785; cv=none; b=XGctqd2Uqcir/KT/7yjoB0xT6BAu7+spYJDU57+CcL6kKqwwiHw7PC0dJG70LFhjxHhgQs4KfpokvKGhXQ3JNq3FXW4goFchXgUo2xtl/wTmjCi3qMB38HQf7lrOKJSjwraTBRPF+bl22wAD+TJodghITrLgcWB4LiZTYck2jd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739924785; c=relaxed/simple;
	bh=ZZo//4hODelh2c6BfzMbQ4+GU8HzqqhnXsMuuww/k94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKR6W0yWBx5o/yTsA+/jFtS6Q0qou9KuqXybwWTaAlGCQ5MiD0zLILcs+cM8VkWkHlpP7UOI2kzSm9bs1vSUi4BJZTlbD5YJ2aHn+kTtzJ3kDr5vIaFWzzHBKg/umsr7/yhKdVYpLYYTs57bq6zzIKTRSLIKvdf5TKQ9EK5oxZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aG7B9L+F; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso20241035ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 16:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739924781; x=1740529581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjj+IpI8XLPpxvRHICEn5KoIEt2tfZVRuk+n8D88sxs=;
        b=aG7B9L+Fvm+Umbxq8JRgiVWh2yWxh4ngIjz7szLfPrGmW1cTjqkML/Im9XTVzBDhR0
         dwJVLeAkBd3/pz/ygWxhsr4l4CUhWa2Vyj2fyUyaQO198ROUm0p+dxLn1b2tgSlMEltO
         s5SOZUAZCdsRZ/SwHjVnlC5JOtxNnd2nMACnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739924781; x=1740529581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjj+IpI8XLPpxvRHICEn5KoIEt2tfZVRuk+n8D88sxs=;
        b=r2cQoXBdoJueySVCdONR2p1q+Z7BT54Oj04Q0EQsbvnHihApPnXpfo0j/J8ApVTiey
         w5eXeR7U098KibU2YPeE171pNT5qCQUJkt930qJsRZBNyr6JeFFr/8a8Ylv7aHlYUmiP
         VPrGIrSyBpuJNDA4qKdq5grQZqv8B6AeEyID2pLmKX59TwxNdoL+nC/peOHSKWbcczl8
         Ru+hUO0aXmBMClcajCCwtf4NC6/+leDcsJWaXBWR+Iv2t4Gn0Ip2+rVh806bcM9VDrbM
         PcOT5hxpOgdAkXjnp89P5oNKqnDAotYwODk9dkUmcVYmUBt4gOdgHo7VgofSJA5IOnKu
         JkzA==
X-Forwarded-Encrypted: i=1; AJvYcCX+r54L5gZnjuR2mAReMg/I3//vuq/xn/5tqnpI9O5vcEXqlQ+dGQAXLROqr11PBnDsaPHArfGvkXvDzXoyvf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+nO6NwvKiyackopcaF9pnxkSx5iXdqv3eOlVc5u1fs6g6n9Vq
	o6KqsC6mDzFLugGFL5Jxy1hv+EiBkssT6MsFviAQIQlvOl7Vgwlw7eZ37aCYSGs=
X-Gm-Gg: ASbGncuNRHHJjyJP5umXgknt6N8ay4Xnivy+/RBWvhJEHkMTiEubfSdtGF0ahC654gs
	uqXiiIMUd3matx987I487ohp8zO1yzx9gcvEnUx+bwatAVXsGuC1GsNwuJ/DKwY1GhZaeusWd0i
	K6y9AlpJfnGEi+TwG9Nyi2k42ACsky7C4N1yFbbjb/o9rGXloyj/g7ADLlHks1UrWPWk2BYmW5x
	VK7mIYmig+0CQFrpBFdtEbCTZoNcSnGBS1yJDMGQXHOn31eIoF80rif1Jh43uJzBxiZvcWqC3fM
	6gikXs0USvDV4rwjES5vnBOQAg==
X-Google-Smtp-Source: AGHT+IGBtjCwi/pMAyxQDfD2N7tzHmX/V8YYMgyBPiwCm/1lyGQajHdbwZUK6F3MOWSk64oBzhQRLQ==
X-Received: by 2002:a05:6e02:1d04:b0:3cf:b87b:8fd4 with SMTP id e9e14a558f8ab-3d2808d7ac6mr109126855ab.15.1739924781205;
        Tue, 18 Feb 2025 16:26:21 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d18fb56f99sm26039815ab.50.2025.02.18.16.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 16:26:20 -0800 (PST)
Message-ID: <f189e844-7d3c-4bca-9006-c949963e74b3@linuxfoundation.org>
Date: Tue, 18 Feb 2025 17:26:19 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: pid_namespace and pidfd missing include
To: Alessandro Zanni <alessandro.zanni87@gmail.com>, brauner@kernel.org,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250128170447.12918-1-alessandro.zanni87@gmail.com>
 <CABq9Dx53aaX1t2Jidi_zDtR6VDB4UvWo1LkO5GYhCnwfs3ycsQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABq9Dx53aaX1t2Jidi_zDtR6VDB4UvWo1LkO5GYhCnwfs3ycsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/12/25 17:24, Alessandro Zanni wrote:
>> Running "make kselftest" results in several errors like these:
>>
>> pidfd_fdinfo_test.c:231:36: error: ‘MS_REC’ undeclared (first use in
>> this function)
>>    231 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
>>
>> pidfd_fdinfo_test.c:231:45: error: ‘MS_PRIVATE’ undeclared (first use
>> in this function); did you mean ‘MAP_PRIVATE’?
>>    231 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
>>
>> pid_max.c:48:9: warning: implicit declaration of function ‘umount2’;
>> did you mean ‘SYS_umount2’? [-Wimplicit-function-declaration]
>>     48 |         umount2("/proc", MNT_DETACH);
>>
>> This patch adds the <sys/mount.h> include in pidfd_fdinfo_test.c and
>> pid_max.c files to find the variables MS_REC, MS_PRIVATE, MNT_DETACH.
>>
>> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
>> ---
>>   tools/testing/selftests/pid_namespace/pid_max.c   | 1 +
>>   tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testing/selftests/pid_namespace/pid_max.c
>> index 51c414faabb0..972bedc475f1 100644
>> --- a/tools/testing/selftests/pid_namespace/pid_max.c
>> +++ b/tools/testing/selftests/pid_namespace/pid_max.c
>> @@ -11,6 +11,7 @@
>>   #include <string.h>
>>   #include <syscall.h>
>>   #include <sys/wait.h>
>> +#include <sys/mount.h>
>>
>>   #include "../kselftest_harness.h"
>>   #include "../pidfd/pidfd.h"
>> diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
>> index f062a986e382..f718aac75068 100644
>> --- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
>> +++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
>> @@ -13,6 +13,7 @@
>>   #include <syscall.h>
>>   #include <sys/wait.h>
>>   #include <sys/mman.h>
>> +#include <sys/mount.h>
>>
>>   #include "pidfd.h"
>>   #include "../kselftest.h"
>> --
>> 2.43.0
> 
> Hello,
> 
> I'm reaching out to know if you have any comments or
> feedbacks about this patch.
> 

Christian, would you like me to pick this patch up?

thanks,
-- Shuah

