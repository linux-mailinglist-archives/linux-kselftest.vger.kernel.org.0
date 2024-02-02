Return-Path: <linux-kselftest+bounces-3968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272B58465E6
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 03:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E4A28A94D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 02:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0B612FB1A;
	Fri,  2 Feb 2024 02:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NsFwKzt3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720E9CA71
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841058; cv=none; b=HtF2EVLMFU5kjQsmyUV2ieandbCHN55moKXGA3s/tCNu56nQFdfHCCEG2YB6n8wjKZeznyK+9aTsce/Kyae0yThLrLRGIxXRa0bnLm0dgDY9Oy4NgSnrXVq/OBR1Xw2JGeOryKqfngOCgN8iIXfG2h5H2pkdIRxhVaDeHnKc0O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841058; c=relaxed/simple;
	bh=KpL5m4Y25ECKAWZYe1aKcE9e3nSH9gZtcs480pi8j/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsrjfFhTwb9d3OJS+DHg+kVWwL2XHPQGNz+h4rDfMBsq96MXvFKacNq1Cgg+zy2DK7j1l2cTdmgR1fxavKIIO0Gm5pxoByWpsFg1hCUl7705ewWdqw1f9qLb5zf3oXY4vThEtSM0CBaX5Qv1ii2j2ytrYt+k35nBKfkQWvSZICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=NsFwKzt3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fb63c40c0so13998405e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 18:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1706841055; x=1707445855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQCgprpOyHEK0e/SRQUIuIzVOt3Yj59dY0F+3ICLlFA=;
        b=NsFwKzt3xv/NuA3z+nr/1kapbnl3rjpf3Bum1Bdl2IROeokoly/89mxyzDlhcsavdQ
         oODberjOQW6fmyKDt2c/SROUXMf2FfkDadsg795JOQJkbOAzCek36U2WLbbSl2OidOk7
         wo5sRmWPtmrJlyFhucC/6yspSVtD4/nCzJVz5doe+68j8yZfGJBk3cDqWEYSfkT+32mK
         BBQKO8rm/ECgMoN788xzHJxcJtR9Y7TNVl8H5whmyBStBxYvYWL3LDGWXcELR/ohqArc
         G/yURMaN27uKDQkBdSJh3KaOjmtE4Vo26oitrfV7XHl68A13sD/a90y2cdQlSy1o6J7F
         bk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706841055; x=1707445855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQCgprpOyHEK0e/SRQUIuIzVOt3Yj59dY0F+3ICLlFA=;
        b=Etq6R+IIaSh5heJF2/sRjFcU05PaScMXTm0PQywab/MrBhOOkOjzUWVcK5AYhn2DZn
         jvBpmKgusjMIu7akuuVx5QxcMuk1b7vIOQFleOjt20a/oc522FjJIEDO3T9Xo7Kj1oIy
         XU+GI8xm8OJMxGX3geh7+MXj5v7hf4w6lvYM6a5F8xqfVqI+2P2OOPKN7bqrywoy4Vyu
         iJ8oeKleWvEhRpZgJlSyHx4Z4FLjw32QA3ZBxfyl4UxsYRWOVdUVU6N/FFie3pJ6N01o
         qjHcl4+EfZcVI8d+c1TYBu9UgydfDL8KJeBf/Dw/ZQcSUHqgoUxUUqSQFURqnl1SECGJ
         Ns3A==
X-Gm-Message-State: AOJu0Yw1X2OrmYHx75UeufDQDvARQu3EvfvtdQ1DyIQosPhpjyRnyfly
	YphB6LXsGsvCfqIP3BiszxKW9Liy2DVP6z7PcRiSSYeRPYZ2Mt3/Xc4dTSQokw==
X-Google-Smtp-Source: AGHT+IGU+GNRD1OLnjZW2xraXAipdX2qEh4m6QD8hspwdTG5tlbNntKBNpIfpaOO7GxNnbApF+8FZw==
X-Received: by 2002:a5d:66cd:0:b0:33b:10ca:d190 with SMTP id k13-20020a5d66cd000000b0033b10cad190mr3331333wrw.24.1706841054408;
        Thu, 01 Feb 2024 18:30:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWfUw5cmK7XCnawjH0IsiCOqFeJ/0vUC36eFm/aog4HwweheKPvb2eUx9wEsDMnVdBu3HcMnFprFTvj5Ao/kd/QLz/Z/gQk/mNCCMO1FwvRfb+tV+XMJV8RW/hseoTjrWN3PNp2avJGBhDN/ZmeXkcWU2YgQZ8v2OVYQxVVjAH4ts9cjmAtXr5iAiDyLv8CtxgiIYrc1pom5hpuXCm5XuBI8Rxi7Nbw2+7tk94o5jZnI++/Ww67wZQiletmfXpCFbU8zjCu3doswKNVZ/yCTqfu28GNeRC2HR+vnNqwRoyb+PuoGaTXGf3q+CRtAQFppt2FkICJuILPQj2DEQpkEi9ga4+PFdXO8xCvj93M
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id h10-20020adff18a000000b0033ae4df3cf4sm775276wro.40.2024.02.01.18.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 18:30:53 -0800 (PST)
Message-ID: <6104436c-4c71-4427-a569-cf98174d0c20@arista.com>
Date: Fri, 2 Feb 2024 02:30:52 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] selftests/net: A couple of typos fixes in
 key-management/rst tests
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>,
 Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
 <20240131163630.31309ee0@kernel.org>
 <e88d5133-94a9-42e7-af7f-3086a6a3da7c@arista.com>
 <20240201132153.4d68f45e@kernel.org>
 <44d893b4-10b0-4876-bbf7-f6a81940b300@arista.com>
 <a1ac7a6e-4447-4476-8fb7-fb5f0d7ec979@arista.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <a1ac7a6e-4447-4476-8fb7-fb5f0d7ec979@arista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/24 23:37, Dmitry Safonov wrote:
> On 2/1/24 22:25, Dmitry Safonov wrote:
>> Hi Jakub,
>>
>> On 2/1/24 21:21, Jakub Kicinski wrote:
>>> On Thu, 1 Feb 2024 00:50:46 +0000 Dmitry Safonov wrote:
>>>> Please, let me know if there will be other issues with tcp-ao tests :)
>>>>
>>>> Going to work on tracepoints and some other TCP-AO stuff for net-next.
>>>
>>> Since you're being nice and helpful I figured I'll try testing TCP-AO
>>> with debug options enabled :) (kernel/configs/debug.config and
>>> kernel/configs/x86_debug.config included),
>>
>> Haha :)
>>
>>> that slows things down 
>>> and causes a bit of flakiness in unsigned-md5-* tests:
>>>
>>> https://netdev.bots.linux.dev/flakes.html?br-cnt=75&tn-needle=tcp-ao
>>>
>>> This has links to outputs:
>>> https://netdev.bots.linux.dev/contest.html?executor=vmksft-tcp-ao-dbg&pass=0
>>>
>>> If it's a timing thing - FWIW we started exporting
>>> KSFT_MACHINE_SLOW=yes on the slow runners.
>>
>> I think, I know what happens here:
>>
>> # ok 8 AO server (AO_REQUIRED): AO client: counter TCPAOGood increased 4
>> => 6
>> # ok 9 AO server (AO_REQUIRED): unsigned client
>> # ok 10 AO server (AO_REQUIRED): unsigned client: counter TCPAORequired
>> increased 1 => 2
>> # not ok 11 AO server (AO_REQUIRED): unsigned client: Counter
>> netns_ao_good was not expected to increase 7 => 8
>>
>> for each of tests the server listens at a new port, but re-uses the same
>> namespaces+veth. If the node/machine is quite slow, I guess a segment
>> might have been retransmitted and the test that initiated it had already
>> finished.
>> And as result, the per-namespace counters are incremented, which makes
>> the test fail (IOW, the test expects all segments in ns being dropped).
>>
>> So, I should do one of the options:
>>
>> 1. relax per-namespace checks (the per-socket and per-key counters are
>>    checked)
>> 2. unshare(net) + veth setup for each test
>> 3. split the selftest on smaller ones (as they create new net-ns in
>>    initialization)
> 
> Actually, I think there may be an easier fix:
> 
> 4. Make sure that client close()s TCP-AO first, making it twsk.
>    And also make sure that net-ns counters read post server's close().
> 
> Will do this, let's see if this fixes the flakiness on the netdev bot :)

FWIW, I ended up with this:
https://lore.kernel.org/all/20240202-unsigned-md5-netns-counters-v1-1-8b90c37c0566@arista.com/

I reproduced the issue once, running unsigned-md5* in a loop, while in
another terminal building linux-next with all cores.
With the patch above, it survived 77 iterations of both ipv4/ipv6 tests
so far. So, there is a chance it fixes the issue :)

Thanks,
           Dmitry


