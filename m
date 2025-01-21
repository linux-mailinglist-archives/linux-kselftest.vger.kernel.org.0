Return-Path: <linux-kselftest+bounces-24826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C49FA176FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 06:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ADC7188AB8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 05:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3811A8F8E;
	Tue, 21 Jan 2025 05:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="CjFGBInK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C0919E819
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 05:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737437242; cv=none; b=GD28hXhOAeI0SM6+cZ9haNK7DFb6g8bBlE19pAhts3oVxIwGTZZQDKgdElwogUgqVUm401DFE5Qf/VUHc4BoiVUqm5Ra1BrqeOFr+eZi5lf86ydS+hwxvybGzFm55FqKJ8NyQYPaM2l7JPg1b5jZzpx3uzCe1DH6FWT1klvQwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737437242; c=relaxed/simple;
	bh=17jdquf1O8HrGT7YX1JbIULVdHRHHmmF5bL1fyAoM9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsILnkahU/7BDDVDf8e3GFobFzaA3HXc4CwDFzBlH5UlRkHvQySgkO9Fs4Ow2sEF9YYU0mZ7wqOgUeY1CJ18LtcoJhi6Uq4cQK+gUPVm5w8vMY//TDZPgUbtYg5+h95SNUzxYfQeWK96lt10+zExEprOQeklgVSt/mIyIHfcGCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=CjFGBInK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21670dce0a7so108254485ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 21:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737437239; x=1738042039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KuNe0V4SlZE9V8OcN/E4qhh/fBRX/xaiMcicz54Ypbc=;
        b=CjFGBInKFSGtYLOCcEjqY8Bn27ymGEWz+08u6G22zDw2Yn46EzpuW8ioqpYyPZvdeS
         PL+f0F6rwFmgOXeE9ks7WFaFgX4+4jqLcP+1tXkSMwOk6FpTjJAKFo92DNqefY3itE9+
         qbnj3cTHBa9mkhch49YxEGenvFajWjpC9wKhOMRN3mg/GEgEzHW1NMt6WQtygK1yl0jT
         KjHFTzfudxO69pYWMqpeW11YwD/40z4r8JDENBd7cuW9R3f36CPPLMIkEr4ygsBwUqlR
         phRItPEggnf264dj8xCT/GRiNq1mVtuFb0Mb53x9B/h1AiTanITyn+rEfGqJ8n2DFfkY
         P4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737437239; x=1738042039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuNe0V4SlZE9V8OcN/E4qhh/fBRX/xaiMcicz54Ypbc=;
        b=SOK+mMiQYCNI5MI8ukqzq4BDgzqQJ+q+HOHV/OVlm+IbiThdvZCGkWEWVxpO3UT2eX
         BEQ4HzpuLAdMWNVyzr//DRjRnZhulS2YmdRSHKC9LUPPoXRLMmPwmvDkPz6yr+HnLb9C
         SoAHDVZpzl5uUAfmF6ok8yr32yJIBXPfNyJcAlxIMG1i4CiXXA5RXSj0AogpTaLXpyFY
         mMAEEG49UsG9trnFo1O2PEOt3QiuQPbH+Hs3OfEjI4HEuz/6HIrs4CAaxKS6SBQpwUHM
         xQTV5IaMUgkEPcC9qfEU9/Chm62lQEThBAf2N5cZU25A+ogZ7sr+5Fn3DbsG7wGneQeO
         DoyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtYdJUOxwvEN+heigrAJ9CT7SrZSw4045PC8nDdNGXLQAtOKUBs8iaXGRdYB4+4Sr6cVSbrnpzSPv3PzqinaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFaRXymAew0n6/l1x9n/f00ImFi1a+n36Qp2caO8ATF55IG/5W
	OyKU/L39ZGEAvqM1D6lXdcoUzDDFA6/ZP7DIr2k4xgFiS75bStLGSfBkcswu7ck=
X-Gm-Gg: ASbGnctsah8lYSaE4QZ5RxyaglwtKAcPFDNfPyp8hIjVGTZ6xsixENOYZjrlAZI1E4A
	2wsYf3OD/5hmQ4FWNdsYozRNuXW4tSMoedxke/yUNbPchVZcbEP8lBXbrq7eiMUyH0MqPNsgKDt
	QtS1KCpyrykVSXGCPPDyMV9mc9KMYxhukjBevZAxvX9CeAPoA6By/IrvprnHRqAX2QSRh6tT00t
	73zT5KB+GBfC5P/tIy80uPecq17clyFJWFL2Q7IRYrWqI+FoEZQ6ZdmUTfAUfi+HDapwqHRd6Xb
	FrHh
X-Google-Smtp-Source: AGHT+IF8AscE6lKE6K9gAMAkVavPAuy5ImBZTIR2UjEzttP05cs28ECPVkex5+WoyQz221rWXZqSKQ==
X-Received: by 2002:a17:902:f7ce:b0:215:773a:c168 with SMTP id d9443c01a7336-21c352de425mr241247485ad.1.1737437239066;
        Mon, 20 Jan 2025 21:27:19 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdf0b4503sm6710167a12.67.2025.01.20.21.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 21:27:18 -0800 (PST)
Message-ID: <92675e51-cbaf-4905-8cf8-dff741a26db9@daynix.com>
Date: Tue, 21 Jan 2025 14:27:12 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 9/9] tap: Use tun's vnet-related code
To: Willem de Bruijn <willemb@google.com>, Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-9-c6b2871e97f7@daynix.com>
 <678a21a9388ae_3e503c294f4@willemb.c.googlers.com.notmuch>
 <51f0c6ba-21bc-4fef-a906-5d83ab29b7ff@daynix.com>
 <CACGkMEuPXDWHErCCdEUB7+Q0NxsAjpSH9uTvOxzuBvNeyw7_Hg@mail.gmail.com>
 <CA+FuTSec1z7-8nNNc1ZXkzekDrFHPnvYKFf8PNZg89VuwhoWSw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CA+FuTSec1z7-8nNNc1ZXkzekDrFHPnvYKFf8PNZg89VuwhoWSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/01/20 20:19, Willem de Bruijn wrote:
> On Mon, Jan 20, 2025 at 1:37 AM Jason Wang <jasowang@redhat.com> wrote:
>>
>> On Fri, Jan 17, 2025 at 6:35 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>
>>> On 2025/01/17 18:23, Willem de Bruijn wrote:
>>>> Akihiko Odaki wrote:
>>>>> tun and tap implements the same vnet-related features so reuse the code.
>>>>>
>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>> ---
>>>>>    drivers/net/Kconfig    |   1 +
>>>>>    drivers/net/Makefile   |   6 +-
>>>>>    drivers/net/tap.c      | 152 +++++--------------------------------------------
>>>>>    drivers/net/tun_vnet.c |   5 ++
>>>>>    4 files changed, 24 insertions(+), 140 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>>>>> index 1fd5acdc73c6..c420418473fc 100644
>>>>> --- a/drivers/net/Kconfig
>>>>> +++ b/drivers/net/Kconfig
>>>>> @@ -395,6 +395,7 @@ config TUN
>>>>>       tristate "Universal TUN/TAP device driver support"
>>>>>       depends on INET
>>>>>       select CRC32
>>>>> +    select TAP
>>>>>       help
>>>>>         TUN/TAP provides packet reception and transmission for user space
>>>>>         programs.  It can be viewed as a simple Point-to-Point or Ethernet
>>>>> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
>>>>> index bb8eb3053772..2275309a97ee 100644
>>>>> --- a/drivers/net/Makefile
>>>>> +++ b/drivers/net/Makefile
>>>>> @@ -29,9 +29,9 @@ obj-y += mdio/
>>>>>    obj-y += pcs/
>>>>>    obj-$(CONFIG_RIONET) += rionet.o
>>>>>    obj-$(CONFIG_NET_TEAM) += team/
>>>>> -obj-$(CONFIG_TUN) += tun-drv.o
>>>>> -tun-drv-y := tun.o tun_vnet.o
>>>>> -obj-$(CONFIG_TAP) += tap.o
>>>>> +obj-$(CONFIG_TUN) += tun.o
>>>>
>>>> Is reversing the previous changes to tun.ko intentional?
>>>>
>>>> Perhaps the previous approach with a new CONFIG_TUN_VNET is preferable
>>>> over this. In particular over making TUN select TAP, a new dependency.
>>>
>>> Jason, you also commented about CONFIG_TUN_VNET for the previous
>>> version. Do you prefer the old approach, or the new one? (Or if you have
>>> another idea, please tell me.)
>>
>> Ideally, if we can make TUN select TAP that would be better. But there
>> are some subtle differences in the multi queue implementation. We will
>> end up with some useless code for TUN unless we can unify the multi
>> queue logic. It might not be worth it to change the TUN's multi queue
>> logic so having a new file seems to be better.
> 
> +1 on deduplicating further. But this series is complex enough. Let's not
> expand that.
> 
> The latest approach with a separate .o file may have some performance
> cost by converting likely inlined code into real function calls.
> Another option is to move it all into tun_vnet.h. That also resolves
> the Makefile issues.

I measured the size difference between the latest inlining approaches. 
The numbers may vary depending on the system configuration of course, 
but they should be useful for reference.

The below shows sizes when having a separate module: 106496 bytes in total

# lsmod
Module                  Size  Used by
tap                    28672  0
tun                    61440  0
tun_vnet               16384  2 tun,tap

The below shows sizes when inlining: 102400 bytes in total

# lsmod
Module                  Size  Used by
tap                    32768  0
tun                    69632  0

So having a separate module costs 4096 bytes more.

These two approaches should have similar tendency for run-time and 
compile-time performance; the code is so trivial that the overhead of 
having one additional module is dominant.

The only downside of having all in tun_vnet.h is that it will expose its 
internal macros and functions, which I think tolerable.

