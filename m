Return-Path: <linux-kselftest+bounces-17851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9AB976EFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 18:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E528B1F250EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 16:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E7D1B373C;
	Thu, 12 Sep 2024 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WcELXjxV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8F1448ED
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159494; cv=none; b=srAdaVgkDRZdQk4PfsP3vISxSQRPmECSDAY3r0uVzr0XKfu1l8Alc1qKtHWpq0zPpSkW42T9EynZxUNMkzb9kv4XGW5w2wJVFLKaj8REEc9m82WLA1Momn/x8AIe8pFLsmlbC9ZATcciBRLOND9zYF+jSIGtrAqyW1ZrXN/rojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159494; c=relaxed/simple;
	bh=OywBXN/615TU+QFB6O6G9HCLhy16wQtwKSU6yMEnB18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTpz7D6+qnkqnaBNDgHh2kMd7xovWRRa8rt2URsUoM9Z6SIacN+rfTnM521d6OYgqJ3xhmDZ3BFTia+LCPLsV2TbYYu9Y4H+QUTaV9KitlxHjf+AhCPgW20Wqo+VQBTaT8tLgdQznEH37SCeS16fS+0dJMyWdgy/GvK+veIl+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WcELXjxV; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82a151a65b8so57632839f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 09:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726159491; x=1726764291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wo3x8YHvYS65DE5Sfp4lGYzOUb4Y2BKazjbznKZokSo=;
        b=WcELXjxVrwb8T2Iw9jTeHUCBLYw6qGpdri6se9qShhXzlnULgU33+r1iWPAL8Ybj7M
         u8I+Y5Yz2Je//745ByUSDddFvDHqaKF7zuxBzd0wPPQ3t7A9v7vExGKMgtEcrPkrakHn
         3rbFKKpOvFoA0PM7DHZbGp5bDjUglhHr+hKZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726159491; x=1726764291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wo3x8YHvYS65DE5Sfp4lGYzOUb4Y2BKazjbznKZokSo=;
        b=C3k+tTv4Qv9Jm6z9lDYqKO+NNywOCsvCBCu2l4rAgQmGAH9X3G1oFnRR1xE+VAmFja
         dbf+PS+4ABr4LApBeCLbZUrnDsPgVsEXPKTpnLwANAXv1Ap5fUCPNtg2J9wrPH6GAqTP
         8YtnXBu/CmnVsW+6BWdZBc3YMdsr3SbNgO/yUSFcQaWQIuf8rAMQY/tLYLe6wMSRqAk7
         7Dqk7p41x+MdZUyeF5KIqcy5qgHvBycY3O0V79aRhdmJZJxlQdSIEXLaQZNBGcYcxso+
         5ucMiETbbP4a42PwUveIt0fvIizNVFgpaWQ6X8lNepKQASIgFbo29SRP+YED17WwQYcq
         cn7A==
X-Forwarded-Encrypted: i=1; AJvYcCXFL8294s3R2WS/xHAtW3Cg34VN/pq3bt6QGVKX6mzhRIm1opxlHlGAPPDGSZqU9UTS60Fd2Q/UR+u0VZZZP/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeSi+Cj7YCVdUs5xxGGTjwgXdkKndMthdDs7af0+BF3xLwj5rm
	ssDLZMppW1FcMAThpRpMGmOKN61WsvK9zm/6+/Aj0ooQAZp7vwa9pu4Ds9yi7DNd6H6093sMnTk
	X
X-Google-Smtp-Source: AGHT+IG8WxtLjeMTnLkX9JNP/f0ES/0H83E8EkQxcj3L6ZPvuQbDvcor09kJInQjlGBaiqWRZJJqkg==
X-Received: by 2002:a05:6602:15d2:b0:82d:1ba1:da5b with SMTP id ca18e2360f4ac-82d1f971466mr317736539f.13.1726159491009;
        Thu, 12 Sep 2024 09:44:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f56ddedsm689762173.62.2024.09.12.09.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 09:44:50 -0700 (PDT)
Message-ID: <3a55faea-5570-4a27-8625-c3f0a276907c@linuxfoundation.org>
Date: Thu, 12 Sep 2024 10:44:49 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Makefile: add missing 'net/lib' to targets
To: Jakub Kicinski <kuba@kernel.org>, Anders Roxell <anders.roxell@linaro.org>
Cc: shuah@kernel.org, willemb@google.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240912063119.1277322-1-anders.roxell@linaro.org>
 <20240912082307.556db015@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240912082307.556db015@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 09:23, Jakub Kicinski wrote:
> On Thu, 12 Sep 2024 08:31:18 +0200 Anders Roxell wrote:
>> Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>> ---
>>   tools/testing/selftests/Makefile | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index 3b7df5477317..fc3681270afe 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -64,6 +64,7 @@ TARGETS += net
>>   TARGETS += net/af_unix
>>   TARGETS += net/forwarding
>>   TARGETS += net/hsr
>> +TARGETS += net/lib
>>   TARGETS += net/mptcp
>>   TARGETS += net/netfilter
>>   TARGETS += net/openvswitch
> 
> Please make sure you always include a commit message. Among other
> things writing one would force you to understand the code, and
> in this case understand that this target is intentionally left out.
> Look around the Makefile for references to net/lib, you'll figure
> it out.
> 

+1 - thank you for outlining the benefits of writing a change log
which includes the details.

This patch is missing the changelog completely - change log is
an important part of sending a patch.

> The patch is incorrect.

thanks,
-- Shuah


