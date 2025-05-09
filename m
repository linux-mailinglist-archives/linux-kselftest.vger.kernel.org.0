Return-Path: <linux-kselftest+bounces-32761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE66AB1B2E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 19:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8BE508030
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEBA23026D;
	Fri,  9 May 2025 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JA7GZt+R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C58E22539F
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810224; cv=none; b=hb7pw5a96kj1sPQExqlYp9cug1jwGAcj38x02mhtz0AyGQrSFNIZxL2EqBW+RJL0oAyUxywVQb+SPRtxQJJtEgv/nj7GCgqhb1AV8yQN40b9yh7/8vL+c3PDSLz98/NXVjQxLcpXLvx3gzmWQKVu1GapK5YmoOD9VaAbo6zE/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810224; c=relaxed/simple;
	bh=xBy9z9qoIyBCdJ0TEb3T7p6Ufk8Td87Yc2gExoFB528=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/TLUAQXVHE24SoL99Xfto8VU7IratpnIJ4gLgZIqNMTKh04xAVZerMizQAgww78gww0VY2HHbcf4SAzFDNvgPIKjJwuJEYzEx10x4Syvh6QaNjRbCUNjEHXc8vYjoECexTVusfPZ5t5fHnJP2EEIJntgXiCOzdrZYMxtz4WzK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JA7GZt+R; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-86192b64d0bso177464639f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 09 May 2025 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746810221; x=1747415021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=86jg2jZVkyd1MUCPfhL5AkHN1Ejwp/KScOnUCxw+kzU=;
        b=JA7GZt+Rkb8DyjxxBIsb4OH8qzYwbcYTTIYbHULjJVw+uVFjJ3u1CTd4dcWw69PnxY
         Wpp5k4S5kLJOtF0kMIS9dLgNkOL3jDoJfYr2odIz1u2Gh8v+OFV9ijF/NSZy49YYxc98
         RUVfxqvGsoznppMttHqU9j3cmZq7N/Xxog5Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746810221; x=1747415021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86jg2jZVkyd1MUCPfhL5AkHN1Ejwp/KScOnUCxw+kzU=;
        b=RhyUjN1Zly3PBbXXzB90MT72ia7SLt2CjWwvIX6ZwlZhJwVzVjtNMIzQxu3iNeqeK7
         0PdwTJfuDBP8vX9rQlzUoyEECZUFU2CBbXORh2qk/mIHo1o1dMM8cjG41l1UJ4s6kW1W
         c4iqJbM8H9Z1sEOCrgHstIPICrzIb6jGu5advX1Eauj8oZP4y2QNA9Plg3uQGaIs8QjT
         mT363qw2YQr2DtUGcgoRuj4Hbr+KZB1eEzdj+1mhshIzryp+ol0pefs+cZtdhTECT9/r
         uWR8WAt5ZiXTTZ8TvVE6byoWNwyySLEc61wsWzMjC1vOTmajx+1gElNDYupVG5kTfkeI
         i6fg==
X-Forwarded-Encrypted: i=1; AJvYcCVYTeg9SpT2Rv2ze/hub37Eh6f2CmjmmB5/fpRkZ6f0QKY4pLnFglZxJYLit+A9gK7xPdCr+4yko9DfTcQKjDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wjFShQ4Q1Pp7o9Kj/5ZxzfLO6TJRQb32/hmjrMDCUspo+Voo
	QFGqqW6RXLtRysHN54R+y7QDDpkIk+RUGr8NAClUXii+KiMRvf8529N074IArXM=
X-Gm-Gg: ASbGncvRavfmeRnSovW/JsoCxqN94cD9RoxU5T9P/k+nVMgU8QIBrzfzpobKiSAT9U/
	/pRF8nRIVE4t2eub0dOfIpBvF6YPbB4CC2xPz5rtv+6t0OPamjFsSSyWNx7L8q8Jqu6FjlvrXCn
	hXy9+0mWWAiBF2Ttlwo9Tf/LhJXkhVtVgYTvgFK8i92a1k2M2P6BvPzfNOOYPz0aPZZsH3RN/n2
	m72lBBnxooBB1fCfiOw3yfRB2qe/yJZ/CliUwDhceDLD4+hQPOi+jdHp06AyBSr3/8/R7fCzrtg
	Sl1uTpqmNotnXurLaK11HoNHQjqld8nqr1hs0aA72JMpe2df/QYQJvOrPXsh9Q==
X-Google-Smtp-Source: AGHT+IGTWqfwSqopxk2jtrqUjuYm1w/WdHF2kTGMBDH5rszV8vB2geURSZzxlD0eJ+oY4RWQCxLEWg==
X-Received: by 2002:a05:6602:1402:b0:85b:43a3:66b2 with SMTP id ca18e2360f4ac-867635c3eccmr482377439f.7.1746810221015;
        Fri, 09 May 2025 10:03:41 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa226535f6sm473050173.105.2025.05.09.10.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 10:03:40 -0700 (PDT)
Message-ID: <4f3eeda9-b9d0-41f6-8a05-b845cf020b76@linuxfoundation.org>
Date: Fri, 9 May 2025 11:03:39 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/ftrace: Convert poll to a gen_file
To: Steven Rostedt <rostedt@goodmis.org>, Ayush Jain <Ayush.jain3@amd.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Naveen.Rao@amd.com, Kalpana.Shetty@amd.com,
 Narasimhan.V@amd.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20250409044632.363285-1-Ayush.jain3@amd.com>
 <20250409124855.4dc8fd58@gandalf.local.home>
 <20250507152653.4af2549a@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250507152653.4af2549a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/25 13:26, Steven Rostedt wrote:
> 
> Shuah,
> 
> Can you take this through your tree?
> 
> -- Steve
> 
> 
> On Wed, 9 Apr 2025 12:48:55 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Wed, 9 Apr 2025 04:46:32 +0000
>> Ayush Jain <Ayush.jain3@amd.com> wrote:
>>
>>> Poll program is a helper to ftracetest, thus make it a
>>> generic file and remove it from being run as a test.
>>>
>>> Currently when executing tests using
>>>      $ make run_tests
>>>        CC       poll
>>>      TAP version 13
>>>      1..2
>>>      # timeout set to 0
>>>      # selftests: ftrace: poll
>>>      # Error: Polling file is not specified
>>>      not ok 1 selftests: ftrace: poll # exit=255
>>>
>>> Fix this by using TEST_GEN_FILES to build the 'poll' binary as a helper
>>> rather than as a test.
>>>
>>> Fixes: 80c3e28528ff ("selftests/tracing: Add hist poll() support test")
>>>
>>> Signed-off-by: Ayush Jain <Ayush.jain3@amd.com>
>>
>> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
>> -- Steve

Yes - I will take this through my tree.

thanks,
-- Shuah

