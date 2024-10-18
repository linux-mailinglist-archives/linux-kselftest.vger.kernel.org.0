Return-Path: <linux-kselftest+bounces-20149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E269A42B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 17:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAD71F21F0C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE3E2022D6;
	Fri, 18 Oct 2024 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FBnZGGCH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93601D5AC7
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266143; cv=none; b=Ty0ZFwrfv9zWGE0atIv1Flm3QwhoX9ZmtJQtXF8gYIwzl+ke7bMUwwXZlFZgKJ7+xlV13LS+IZB3I899u3IJLxetXZGFmfDn4wcfy47iRa7Xj7tfiytPWI28u1cse+iviGeYPws46U7PISFz7Fw0fuVh1lTJKG8jQXf4jpU8NUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266143; c=relaxed/simple;
	bh=0pk2DOGGbs1iYIDo8ie2yXiZL4Hp+H8zOHBUMKYTCM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGnVYcBdXIiqDoc7TV+08B0bg/Vl42129iYExjc44BQHRTsC2IIxOPjLmJXDwLlgxZieIMd++L0Jte9LqWLljuCwzdXG8Ct+raK4Aqry1xRYp9sFWHH4p/LGwM4qGcensjsCZXmzkqgtylwqGArjZgQjvvayKbkyX7pq6e3fGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FBnZGGCH; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-83ab00438acso53954439f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729266141; x=1729870941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8VdO6KdJCH4AdSj2++rrFU9nxwKhshOvegF4lZMcqE=;
        b=FBnZGGCHrja6gfvlKAzFjIibjwZcuvysGUD5DAwKUYFzBwQbLm3C5DcJ/m+zNKseVO
         rERGGzKT3iKw4dGAkOP0sjPDTjrsNXDuMMQVYJFDVpewUe0BKxk5ZpwHiWw5ok6DKyx1
         JY06wMfR6kq/31vxrTxl7Ndjr6HCLB/HG7ZMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729266141; x=1729870941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8VdO6KdJCH4AdSj2++rrFU9nxwKhshOvegF4lZMcqE=;
        b=JNwfVKQfpHoFEyZRa36eibQRkHVSXAoc6fMWma8LcUxNQVT197VC/nThwsdQBfPVQk
         BtxyttABfpjnHi6JP9Mz//5EnrS0SBvmGhQN0YK9E7jch5JTz0QTsrAqYh35jUXWNvbi
         XK+tlN63fLxKNobUvo7jvMDCoOOmCNj9Sg/ko2JcytHqyRfl3bqBCA7nUVSnxQToGRuP
         z7McsZsGt484Qjhr2PTYQu+d68cTz0V2Rz+I/JPgbTjIwrjB3CkaPDRvhlqkk8OKEyu/
         YTbhqhT3fpoEOGBb2mYK3Njglg0jGjhQNGIvQPLjr0tTHeiErx8TkvsgFywgpclRXANM
         VwuA==
X-Forwarded-Encrypted: i=1; AJvYcCWi0KY3eLak4nBgckg1k/RZ498xAj7DQPOPZWsdNQR/2kA8cYXaCmHsz/Os8LCekb9KZzSTmtadgnDwvcUh7ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpAMTWocyR3bq624gpJ3yAk/IKqwEAQP1ya3yMG9Y2A0qENzl+
	XtSDZ2mHfayWSPgXtektgcEHukOL8kzTZzly8g3W2q6siQ6i6iTw8WVxrP9BMoE=
X-Google-Smtp-Source: AGHT+IH4ogcODgSN39TA6PPVl/6vyDZ/seYFLpla/cknawLNdjkkyApJ+afbquxpiqPpJuNhwG9TGw==
X-Received: by 2002:a05:6602:2999:b0:82c:da1e:4ae7 with SMTP id ca18e2360f4ac-83aaddda6f7mr430443939f.2.1729266140750;
        Fri, 18 Oct 2024 08:42:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc10c4d6e8sm468697173.127.2024.10.18.08.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 08:42:20 -0700 (PDT)
Message-ID: <a8e0dc0d-1d49-4287-a5c3-41bd4539a372@linuxfoundation.org>
Date: Fri, 18 Oct 2024 09:42:19 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftest: rtc: Add to check rtc alarm status for
 alarm related test
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Joseph Jang <jjang@nvidia.com>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
 "avagin@google.com" <avagin@google.com>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 "brauner@kernel.org" <brauner@kernel.org>, Matt Ochs <mochs@nvidia.com>,
 Koba Ko <kobak@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240524013807.154338-1-jjang@nvidia.com>
 <20240524013807.154338-2-jjang@nvidia.com>
 <20240620193654d3cd1f05@mail.local>
 <c0db5bd6-8c6a-4017-911e-f3e01cd522ed@nvidia.com>
 <c900db54-d764-4389-ad9a-bc2be61eedd2@nvidia.com>
 <20241018082706d7b167ab@mail.local>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241018082706d7b167ab@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/18/24 02:27, Alexandre Belloni wrote:
> On 18/10/2024 12:26:44+0800, Joseph Jang wrote:
>>
>>
>> On 2024/6/24 9:43 AM, Joseph Jang wrote:
>>>
>>>
>>> On 2024/6/21 3:36 AM, Alexandre Belloni wrote:
>>>> On 23/05/2024 18:38:06-0700, Joseph Jang wrote:
>>>>> In alarm_wkalm_set and alarm_wkalm_set_minute test, they use different
>>>>> ioctl (RTC_ALM_SET/RTC_WKALM_SET) for alarm feature detection. They will
>>>>> skip testing if RTC_ALM_SET/RTC_WKALM_SET ioctl returns an EINVAL error
>>>>> code. This design may miss detecting real problems when the
>>>>> efi.set_wakeup_time() return errors and then RTC_ALM_SET/RTC_WKALM_SET
>>>>> ioctl returns an EINVAL error code with RTC_FEATURE_ALARM enabled.
>>>>>
>>>>> In order to make rtctest more explicit and robust, we propose to use
>>>>> RTC_PARAM_GET ioctl interface to check rtc alarm feature state before
>>>>> running alarm related tests. If the kernel does not support RTC_PARAM_GET
>>>>> ioctl interface, we will fallback to check the error number of
>>>>> (RTC_ALM_SET/RTC_WKALM_SET) ioctl call for alarm feature detection.
>>>>>
>>>>> Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services
>>>>> as optional")
>>>>>
>>>>> Reviewed-by: Koba Ko <kobak@nvidia.com>
>>>>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>>>>> Signed-off-by: Joseph Jang <jjang@nvidia.com>
>>>>> ---
>>>>>     tools/testing/selftests/rtc/Makefile  |  2 +-
>>>>>     tools/testing/selftests/rtc/rtctest.c | 64 +++++++++++++++++++++++++++
>>>>>     2 files changed, 65 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
>>>>> index 55198ecc04db..6e3a98fb24ba 100644
>>>>> --- a/tools/testing/selftests/rtc/Makefile
>>>>> +++ b/tools/testing/selftests/rtc/Makefile
>>>>> @@ -1,5 +1,5 @@
>>>>>     # SPDX-License-Identifier: GPL-2.0
>>>>> -CFLAGS += -O3 -Wl,-no-as-needed -Wall
>>>>> +CFLAGS += -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include/
>>>>
>>>> Is this change actually needed?

I saw this and figured it is is still in review.

>>>
>>> If we didn't include "-I../../../../usr/include/" in rtctest Makefile,
>>> we may encounter build errors like the following because rtctest default
>>> look at the header file from /usr/include/linux/rtc.h which miss the
>>> definition of struct rtc_param, RTC_PARAM_FEATURES and RTC_PARAM_GET.
>>>
>>> rtctest.c: In function ‘get_rtc_alarm_state’:
>>> rtctest.c:94:15: error: variable ‘param’ has initializer but incomplete
>>> type
>>>       94 |        struct rtc_param param = { 0 };
>>>          |               ^~~~~~~~~
>>> rtctest.c:94:35: warning: excess elements in struct initializer
>>>       94 |        struct rtc_param param = { 0 };
>>>          |                                   ^
>>> rtctest.c:94:35: note: (near initialization for ‘param’)
>>> rtctest.c:94:25: error: storage size of ‘param’ isn’t known
>>>       94 |        struct rtc_param param = { 0 };
>>>          |                         ^~~~~
>>> rtctest.c:98:22: error: ‘RTC_PARAM_FEATURES’ undeclared (first use in
>>> this function)
>>>       98 |        param.param = RTC_PARAM_FEATURES;
>>>          |                      ^~~~~~~~~~~~~~~~~~
>>> rtctest.c:98:22: note: each undeclared identifier is reported only once
>>> for each function it appears in
>>> rtctest.c:100:23: error: ‘RTC_PARAM_GET’ undeclared (first use in this
>>> function); did you mean ‘RTC_ALM_SET’?
>>>      100 |        rc = ioctl(fd, RTC_PARAM_GET, &param);
>>>          |                       ^~~~~~~~~~~~~
>>>          |                       RTC_ALM_SET
>>>
>>> After adding "-I../../../../usr/include/", the rtctest will look at
>>> linux kernel source header files from
>>> <Linux root directory>/usr/include/linux/rtc.h to find the definition of
>>> struct rtc_param, RTC_PARAM_FEATURES and RTC_PARAM_GET and fix the
>>> rtctest build errors.
>>>
>>>
>>> Thank you,
>>> Joseph.
>>>
>>>   >
>> Hi Alexandre,
>>
>> Thank you for reviewing the kernel patch [PATCH 1/2].
>> We are still not sure if we could include linux headers files from kernel
>> source directory by the following change ?
>>
>> -CFLAGS += -O3 -Wl,-no-as-needed -Wall
>> +CFLAGS += -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include/

You have to say $(top_srcdir)instead of hardcoding the path
> 
> I guess this is ok, I expected Shuah to take this path too.
> 
>>

Not as is. Need v2 for this with the above change.

thanks,
-- Shuah

