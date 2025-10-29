Return-Path: <linux-kselftest+bounces-44279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E49FC1B94F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D383C581590
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 13:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DBF289E13;
	Wed, 29 Oct 2025 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QLYfDHhi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0991C84A1
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745471; cv=none; b=aMjsPojWW7D+fWh4kAReiIZqqUtuH83XO47rZlN5BTjL6OLMkfcS+f08kYYHf9p1M6WCkau1PoaGdiSxZgqVwjVeP2QAM+vmXoSqwbJMpWvsat8+XXdDYvajDVzsyhJ7zz8KCj4NcezaRNKwuSqY2HNz4pNZJZxV+gUGJdPlob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745471; c=relaxed/simple;
	bh=akTAlOlvCXgUUeWkN15YYuyCcdmX6JZE7gXZRKSDbwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GT5WTzKS4/DZsApKsfoEbgxt0cohCaSxWbuQiG0EYiwwk5JJY7wh1NeYq2aXy/gbiBimsYDq1UnTo6xlIFyeLllzleOwK2oL9MlZmO8Tdkocj8MhLTtAwRiqA+JPGPpKVjEirpdOyObPM0F2UegwB7hB/VMDmxOkdTrSDxF4lj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QLYfDHhi; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-93e2d42d9b4so306629639f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761745469; x=1762350269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdhm4zDRyUmcL/+bkn0abpwAMWivZMM0K7ilDnHJ6Z8=;
        b=QLYfDHhi5p+4MJ3s42KwufjiLMyEPRiywAqZhkzFNaatH+elh7n4qWz34qwXtkgOk+
         jCeZnBmMM58OfFdksdU3PSK9qlrZhIJkZbgP2/7TBZaWdY2Oyp2c+TqUBax0rmGqoE+v
         SDdHqjv4fcbr9uLHCFzGcG++spQypPQAP1WQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745469; x=1762350269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdhm4zDRyUmcL/+bkn0abpwAMWivZMM0K7ilDnHJ6Z8=;
        b=VxPFMwArmJrud8HQBUck079G1OxekYx4LAboIXtN1UW00Cx9GzXzMr2nPnzic9fS0P
         gq8HtMjNIhqdxqXahp2XL+MTsI64k4GLLCEzVy3usrqz+LZRjnMI60UQeHy3NQHNDsfk
         letXos5hz4Q6mh80joWJOqySNpMInOP0iiqdpwUwx165gewk+nvBYGtgvb3QJfewZ2S6
         yU+TN+Orcx+/wT0sjZknR3NlCqscD5h96tnsu/SoTiqRH3eyiqRV6TTub+KzIxjIzA8b
         l0+HTXCHkbl+lHdupJReJPNeKWoSr5ZgvA7KFMqjtMw/TrxTufz33zZSyAoYG68jkn7z
         qvLg==
X-Forwarded-Encrypted: i=1; AJvYcCVTvCBYVfkOTy92ohk+cRkhMVCbJmr59IefGliGwS4dzMcvM2F2rGgJGn9/XYxOPthcIp5JBD2OkRGjplrnoAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdZsswFe67s9HXsGPNUu+LqYjTtpg3G1jLpnipxY4Y8EV/c51E
	9wA41dgSKI6r9T2AuMs0NuqtLq/l3IKbXO/q6WgXFSrBqRee3luIg8xlfM/RyAlEVUQ=
X-Gm-Gg: ASbGncvgcN14BduAbGmzIGbufDFI1VNmhu//6rG01IUvahjoB0/g88ZUtCN9tMfprlO
	DdUMNHvLJNb+cHxXBos170CI0aHpHItuhLBE+jzNIDEBEjNRqF4FJ5D4mjj7TE/cpCPyohbEZUv
	q7HIHRN1tBvRKfkBoBLl5RPRikSjaMby6sxCbOHNiZC/+Y9iOvOr83dX0jaaxwG9wlQ/aRfrPWi
	4Q4m+5RZ4kvv7fI+veBzKP/LFfUtTYjcVRbZ5+oSwYgOAPkL2po/OQ8iejjBkrF+8W/bcHve8EN
	g2NH2WYl3UUnhq07uEMuZUEJUyhR/xnPQedKINlNbilgSvI2z3+svtdjEyiRcfGhJar+TXznHWY
	X1HGAClRODbYw3eJxWDO43epIkOiP6PegZItT9DCPFdbMJhYVGu74Q5iHWRA2LNZ2hUirfGfUMA
	uhJPZHqXEHA5As
X-Google-Smtp-Source: AGHT+IHLYcDl503ydPp3Vo6nK53Sk01A2+YXNVgZQH4qpA8YmD8SAR5tkVmYDEsWC24bVzDxjEr3wQ==
X-Received: by 2002:a05:6602:148a:b0:945:b86b:d810 with SMTP id ca18e2360f4ac-945c988a604mr450513439f.16.1761745468759;
        Wed, 29 Oct 2025 06:44:28 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94359f316basm466022139f.19.2025.10.29.06.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 06:44:28 -0700 (PDT)
Message-ID: <e7fbebca-ffe6-409c-bd52-848cc2a3ad27@linuxfoundation.org>
Date: Wed, 29 Oct 2025 07:44:27 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update KUnit email address for Rae Moar
To: David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251028194010.519411-1-rmoar@google.com>
 <CABVgOSkxLKkT7+sa53x4dUsCiG3m=uGmrd9ko3GwjnwGPmonfQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSkxLKkT7+sa53x4dUsCiG3m=uGmrd9ko3GwjnwGPmonfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/25 01:18, David Gow wrote:
> On Wed, 29 Oct 2025 at 03:40, Rae Moar <rmoar@google.com> wrote:
>>
>> Update Rae's email address for the KUnit entry. Also add an entry to
>> .mailmap to map former google email to current gmail address.
>>
>> Signed-off-by: Rae Moar <rmoar@google.com>
>> ---
>> I am leaving Google and am going through and cleaning up my @google.com
>> address in the relevant places. Note that Friday, November 7 2025 is my
>> last day at Google after which I will lose access to this email account
>> so any future updates or comments after Friday will come from my
>> @gmail.com account.
>>
> 
> Thanks very much, Rae! Best of luck!
> 
> Reviewed-by: David Gow <davidgow@google.com>

Thank you Rae and best of luck. I will apply and send it up this week
with kunit fixes update

thanks,
-- Shuah

