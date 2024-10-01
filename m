Return-Path: <linux-kselftest+bounces-18755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC5698C07E
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 16:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7ABD1C2371C
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79291C9EA7;
	Tue,  1 Oct 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QsI5mclX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088691C9EA3
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793643; cv=none; b=CPNn6gJWc9YO7Hu1yqrXji2njBE6ulO/qWytJPm5cpZ2RzJFV0mie+40Bcty+G/R1b3FUxpug7335G+Cx/karlG73F/wtXUxwbMiyQOVS2oJfhHNk9ne7tiA4Cn/crLqtsl1znjTohfh2LkEa8m5MqNw2JaWULeRlKvFc+jsw8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793643; c=relaxed/simple;
	bh=zxHbuzdK8nWsF4Qd8mbyl+FzEThCtJXb9mYf/9pkr5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8foyr42NZlm2YKfAmpckTjdfEtnSjY9qdS1tzysu9I9N3TMmgxKyFpRmPDAY6Y0ERS9O7WHnDpT0q/mJoLC7MA8woAC6ek83vkL8H14x/UdwiDwTMFSfJXFo3of72A9JnhsVQjPuFuTGVZU8YwE9MkRE44Ien2m76sEUTtVB/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QsI5mclX; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82ce603d8b5so257453939f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Oct 2024 07:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727793641; x=1728398441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aH6Gj5o0Dsut7SHZMO7xTQsbpbbShGmKYJpl5e/my0c=;
        b=QsI5mclXbbkvXpZcY5hQvpYnB19G2hBKY4+uGsJ8BOEEuqlRHcvSEI1fxE45FJ3NJy
         xab9jJbltK0Gk9GDODw2ghaYxPEN2InJFYbMVM3xRlhXsHnVVF6BldzY18oW4cGtcVY/
         JJOQPKJwBOwWKbqcQRSLuefkK6ewPO7fLxUUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727793641; x=1728398441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aH6Gj5o0Dsut7SHZMO7xTQsbpbbShGmKYJpl5e/my0c=;
        b=OKLkFMErt2pq63ysyXHlJAD7TS8Gd1mvPEC1t6V5q+XyZcsBz0RF9btiw1JgQAUqe/
         Xk/o3YVVZxCTehsbmIqw7J/yDG5ty+QpRPQWbNi6e863AO5Mp+6rbfi+hP3/tSfLZ/yu
         U+X9LFxJZzpuVajcTkPYKI3ZCTmcDoNzev7aUEbETN/glK+EZXkVVK1bqNBP/r9jS8IA
         6GiuXC1MjMJjNNd+FVkGblb6+/PhxJl4by5aRBONFjUgS/DayZKUbHqSUFH0JRy/SjTT
         8rsH0LNIFiueMQJitfO9s2zmGQ6kgWbhGTEskTTrZms+pvz1HqkQ6wmHB1zNwpqNNpiN
         T5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHzbCQu4iGTLlp54k6kViesxn6bxB36BAe8rWsEdaJgxeP/zTCmECMzZIVS6s568lLeg5H7lYWcq7o3oBbSJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0J5pa+k4gZClt+wpAnROBbNRZy7wyomQqeDuGYgh1+FV/4A6S
	S2ePJb7u+XMyzAe2djxgEpRxVA3YNMOP0xSJcwH9wyabcSaz7YxrwpaQmvt920M=
X-Google-Smtp-Source: AGHT+IHaEVwDtNrwo0NR3zyG0+hO0l1ljDQU1Gt3urcoO8IOOyU9n3Km7W8VE6gwm2ssz1JIotug6Q==
X-Received: by 2002:a05:6602:148c:b0:82c:d67d:aa91 with SMTP id ca18e2360f4ac-834d83bd384mr3618639f.1.1727793641103;
        Tue, 01 Oct 2024 07:40:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834936e2c94sm280716139f.29.2024.10.01.07.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:40:40 -0700 (PDT)
Message-ID: <04fac319-2cfe-46ff-b932-e3c867d1c9b2@linuxfoundation.org>
Date: Tue, 1 Oct 2024 08:40:39 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: hid: add missing run-hid-tools-tests.sh
To: luyun <luyun@kylinos.cn>, Benjamin Tissoires <bentiss@kernel.org>
Cc: jikos@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240929085549.3528293-1-luyun@kylinos.cn>
 <mimf5cv52q747fwhafr7pv6lgxyyt3rauz373e7hoinpqycmha@2oncke2rw2sc>
 <7910784d-18c2-4e72-9dd8-6b8bd1b9dd0b@linuxfoundation.org>
 <c9763b7c-fc93-44cf-bccb-9709a542e3e6@kylinos.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <c9763b7c-fc93-44cf-bccb-9709a542e3e6@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/30/24 20:43, luyun wrote:
> 
> 在 2024/10/1 04:57, Shuah Khan 写道:
>> On 9/30/24 02:38, Benjamin Tissoires wrote:
>>> On Sep 29 2024, Yun Lu wrote:
>>>> The HID test cases actually run tests using the run-hid-tools-tests.sh
>>>> script. However, if installed with "make install", the run-hid-tools-tests.sh
>>>> script will not be copied over, resulting in the following error message.
>>>>
>>>>    make -C tools/testing/selftests/ TARGETS=hid install \
>>>>          INSTALL_PATH=$KSFT_INSTALL_PATH
>>>>
>>>>    cd $KSFT_INSTALL_PATH
>>>>    ./run_kselftest.sh -c hid
>>>>
>>>> selftests: hid: hid-core.sh
>>>> bash: ./run-hid-tools-tests.sh: No such file or directory
>>>>
>>>> So add the run-hid-tools-tests.sh script to the TEST_FILES in the Makefile.
>>>>
>>>
>>> I assume we probably also want:
>>>
>>> Cc: stable@vger.kernel.org
>>>
>>>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>>>
>>> Not sure about the timing regarding our next PR to Linus, so in any cases:
>>>
>>> Acked-by: Benjamin Tissoires <bentiss@kernel.org>
>>
>> Thank you. This commit appears to be right one for Fixes tag?
>>
>> Is this the right commit for Fixes tag:
>>
>> Fixes: commit ffb85d5c9e80 ("selftests: hid: import hid-tools hid-core tests")
> 
> Yes,  the run-hid-tools-tests.sh script has been introduced since commit ffb85d5c9e80,
> 
> but not added to TEST_FILES.
> 
>>
>> Will apply with this tag added to linux-kselftest fixes for next rc
>> once I get conformation.
> 
> So should I need to send a v2 patch to add the Fixes and Cc tags?
> 
> 

No need to send v2 - I added the Fixes tag and applied to linux-kselftest fixes
branch for next rc.

thanks,
-- Shuah


