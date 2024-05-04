Return-Path: <linux-kselftest+bounces-9469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B64268BBD6B
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 19:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE391F21662
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 17:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CDE5C613;
	Sat,  4 May 2024 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neeWk/0Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6B3FE5D;
	Sat,  4 May 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714843234; cv=none; b=A7epUNE6kh30NlAGkahntMpelvgmOff/iJt5qCKcM4YI2KDcpYmJ98q83OCbBlSrdxwrpZlieO3+hnaxj8U5ZMKkb0IVrfSfP0cqUCGgc7EENHWi3Azlpc4+ID+4dMzdJHjs1AcNsWeQRALpdtsj0gxJY4xbnqQWvSnAZQR5w6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714843234; c=relaxed/simple;
	bh=yX3YhEGKIY80QfFguO8Pt5bZTRN+1DjE2KLYJRPTgco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SijrPlq6w8TJUt3HlB2PRWvW1s1vt02QXXPuthqGhtsVEC5z1oB0PLNvaYTmoBfpnaSPlIY12wUZUwwBzDnIAGCC45A4o6qS72Rr3552TRreI2ThRc3g4N794F3TrXbsLwY8xH9OftC1qh0at+gPomOdkhBGep/VcLptnTkToy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neeWk/0Z; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so8971111fa.2;
        Sat, 04 May 2024 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714843231; x=1715448031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fUM1V6Ub284YMqDH0oZoEeFuIvNTBuHj7W1zwy5fjb0=;
        b=neeWk/0ZRV+Iz3yTHxYEZdGLxLciQu9aTiCWzAnuUrw6migmlUv3WfVIB0wdHAJMOx
         FGd8jkzmtLAxgcjBnNiSn1rNxkFWujmZW8fXlSCR1bIhHiMksjIV1LDi5kTPzfd+MnJK
         R8yu3eBH1+PEbC+pBw1VRItLVYX6enLydNv5QyReuHZDHFstTNHK+pLJ7tkeBqFvg0I9
         ty8b5CPhPUdvdMns5Y+NBdzf99Hlt4AWLbvhEnNY0kM+vHg2yHRgb3IdGfQTS/W5ErLe
         20JkWWysCTsd6VnrX6xjMTO1GlTnprPeke7kyC6Ca5jcw4XxRmEIqAqcDkdUGNwU0p4J
         xZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714843231; x=1715448031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUM1V6Ub284YMqDH0oZoEeFuIvNTBuHj7W1zwy5fjb0=;
        b=Vk1t/xF6EVcQaUZMPSCxK/Wn8ui+fJyDxHFScqFJZSSoPZVWw1rgpHnGNoadhMuXUi
         11DxMSotikiUweRilGIo1LSvLSn1qPHXYjLutQTa6WN64HyG9Jyp4KUmNtJBYfu42sZ9
         mB1JJwc4rOT4sJ2mm4XSwwPnnWrmuWEowzEmasjZAnokKF4p1RkJ9yPkbRJe6osoxpIj
         quISOsbOKP4dbF+fq3D9vyVyHrtp0gfJ3I2Kybfd4eH3r/r4V1n23NAiWpxxDIoTMJCs
         N7clgoD8kivtSOQSf7VlhSJB21mR5a6zmfrIGtd5F1ktSIrBr7g2G/Q275KwjHh7wAob
         6ptw==
X-Forwarded-Encrypted: i=1; AJvYcCV1UZ8D6jzZRvWzU4j6FkOFIg2iXNgB1oDcT7hCOPRpXUFkTzeiPfgBSV5Aa0NcljFTTKxG9pgIxrTkvGtaKl9msPu4Ny+PDiLcQ3z+PMhPaWVVocasSeB4KUT4Aa516J7+046odfbC0qNL/vHI
X-Gm-Message-State: AOJu0YxNyjun0j+g2C3M5oXNExMl2dt/gnTEwXUzlznVdW5BKW5OmJ3M
	hFk9OQx2YeDZB60Jmaid/0JhJbDAKIROK41UQ4p45er+92vCXLK3
X-Google-Smtp-Source: AGHT+IFC8URggRH/EqimgZz24CDYpIpC0a5CGmaJCbOTPjAz1+fP7KiYbmc6QPRaskigR0QasCZVCQ==
X-Received: by 2002:a2e:9284:0:b0:2e3:8fa:6438 with SMTP id d4-20020a2e9284000000b002e308fa6438mr102508ljh.33.1714843230746;
        Sat, 04 May 2024 10:20:30 -0700 (PDT)
Received: from [10.67.234.135] ([194.110.115.30])
        by smtp.gmail.com with ESMTPSA id x2-20020a056402414200b00572cf08369asm2326526eda.23.2024.05.04.10.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 10:20:29 -0700 (PDT)
Message-ID: <e4dd9e08-6685-4b67-8410-ccdf91b1597b@gmail.com>
Date: Sat, 4 May 2024 19:20:29 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: filesystems: add missing stddef header
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <df1df586-188e-4290-9986-7b7cd31710e3@collabora.com>
 <20240422131659.30222-1-amer.shanawany@gmail.com>
 <9cba6633-b1dc-4cde-b326-609855c6418a@collabora.com>
Content-Language: en-US
From: Amer Al Shanawany <amer.shanawany@gmail.com>
In-Reply-To: <9cba6633-b1dc-4cde-b326-609855c6418a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/22/24 15:49, Muhammad Usama Anjum wrote:
> On 4/22/24 6:16 PM, Amer Al Shanawany wrote:
>> fix compiler warning and errors when compiling statmount test.
>>
>> gcc 12.3 (Ubuntu 12.3.0-1ubuntu1~22.04)
>>
>> statmount_test.c:572:24: warning: implicit declaration of function
>> ‘offsetof’ [-Wimplicit-function-declaration]
>>   572 | #define str_off(memb) (offsetof(struct statmount, memb) /
>> sizeof(uint32_t))
>>       |                        ^~~~~~~~
>> statmount_test.c:598:51: note: in expansion of macro ‘str_off’
>>   598 |         test_statmount_string(STATMOUNT_MNT_ROOT,
>> str_off(mnt_root), "mount root");
>>       |
>> ^~~~~~~
>> statmount_test.c:18:1: note: ‘offsetof’ is defined in header
>> ‘<stddef.h>’; did you forget to ‘#include <stddef.h>’?
>>    17 | #include "../../kselftest.h"
>>   +++ |+#include <stddef.h>
>>
>> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
> You missed the reviewed-by tag from previous iteration. Putting it here again:
>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>
>> ---
>> V1 -> V2 added compiler warning in the patch message
>>
>>  tools/testing/selftests/filesystems/statmount/statmount_test.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
>> index 3eafd7da58e2..e6d7c4f1c85b 100644
>> --- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
>> +++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
>> @@ -3,6 +3,7 @@
>>  #define _GNU_SOURCE
>>  
>>  #include <assert.h>
>> +#include <stddef.h>
>>  #include <stdint.h>
>>  #include <sched.h>
>>  #include <fcntl.h>
Hi,

Could you please consider this patch?

Thank you

Amer

