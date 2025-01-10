Return-Path: <linux-kselftest+bounces-24197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8593A08CD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 10:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FFE1884EB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE0D20B7F3;
	Fri, 10 Jan 2025 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="KhKUUmvS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CF2209F31
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502485; cv=none; b=gNh89VkJVsg6V/ygIS3uM8CVP882yDuehcWWcTZyCIrgZ5woWcdh4tZ38mZ8P5YIMaqxZlXiZ2MmAxxcu4Hu6gvDGaRxvj+FTn5pJZPRDtLIFJmAaZ0esDfO6Pdm7ZH6uogtsMj8LMf/9Uy2mw0HYO/UkUcJ3YEZgP6mMsyFCcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502485; c=relaxed/simple;
	bh=kVRbfJjqPGz8mIX7HYr5rAjUJTIc7wg/ASHsghAXszw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oeDAJ/ttiqOMm4x/atR907Y8xzcMzFr6x1waOqmqhEIk1r/nCcasZPM8dKnUTy4wC5dkQGIXc9c93cJ88hYStCNhOPrOHBQySwwqv4fimE/SeSLRepzNEnDyHGltkyG311wcNgXzyZObI7NIzaT8SDpxk8P93brQD2f8ttsdLik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=KhKUUmvS; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso4485784a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 01:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736502483; x=1737107283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=32Vr4Gt1G1myfrpAERq6AqxVOpF64+scMP61EbgQiWY=;
        b=KhKUUmvSNnIsRuykpmg5oIG3LsDRZYWxhZlb8W5Y/NscKj6mBRqDvVezPr0kZs2hEk
         SfgNrsDdakX8JelJlPc2k1axQb33aiz2I5rqfH9DwjbeJIsY0Y0KdOKuIdwLv7bFyXDI
         xA2Jier5VQgpTBaIeWTrGjgFTJGqCASVNCmseO9gehJzAa7rA+93QUUbNwSTfSa66KTY
         DwtpqFCBlrO/MBDlZ8TfKY7jYIXUy57fD1WpjPOjRsjT55QZxazx0chlxzTKLVy+Lh1W
         Jt9Or55j4pbduwenjytpVbKZsHApqCH/5GLCeZEjL9KGtZ4vCpps1r0RVkHX+P12sh0N
         DIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736502483; x=1737107283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32Vr4Gt1G1myfrpAERq6AqxVOpF64+scMP61EbgQiWY=;
        b=CEcXBDY21M2iwx3kyYbrOZyTRDQwimL+KwiG8CXccYKRzPmPOAfxXO9anMX0jWDznu
         tdT3mfgGIt67TY5M+/sYPs2ade20QfURxOUvZw7hCixSQ3M/O+un3CmyAF2i8+QR/N0s
         yUnP3iPeQKoUYUwxjjn4m/s1sxUBHDDu/afJfpTTYRo86Eq/zFScyTVDyv/Cj+YQrWOC
         1UzFMti9L5O3dkNneMQ6FXc2uH8rRSWUEm92UR2hhqq6CqXptr5fveHGfWWQyRocI5ic
         eZ/pV5zedy8JwFOLGanZEgOSViKZZSwvxCH8gipUU5jG4aoR1TkDH8PcwyN1QjwzfGI8
         bx7g==
X-Forwarded-Encrypted: i=1; AJvYcCUmddHNu8dAison3RsQ0CnQDDAQgk4CA9/pEhp07iC1wL4w82Gkyq4Duq6lLyT62W3gku4n+q5TWgXvaM7sj58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrxx1A+kHCL1ZPCiV84rS/SdK+En5td+ASkBScKmXJ6OBKauxR
	bi7Dil6+pYPUi4Fondty8o8EI/n69fO1sFnlcDVO1XLtImG5n7KnH/XM8jaYch0=
X-Gm-Gg: ASbGnctueAO4LDpD8pM9ocsvWtkS85Iq2aSbWmmgfFB5cB72ocJH2vwNMJdRfuPuubL
	PJa1YhJksmxVxn9g3kaBCLqw19q0MNBJVqSrSAX3wnBO7spdoz12mE1RHqo4FGjA7vQagu12Up8
	So/upbmNZLzgB0Xxcn0NR66+Yn1mFO2WrhQ574ri+rT8ZLJCKzceklRZcxWow3WpDkRh38lXZ13
	sLG+AE6NBWucpYygMWxcY607i8zUvaK6KQ0Blugjc8rkh5Sh3awP/rqr7edBRefzmw=
X-Google-Smtp-Source: AGHT+IG4bZICCGUJL8IFrqqswdhSk8TqvGQUJNKkxBrtJDASy/wZzUeIl0i4xzyDL1lhN+MfLWTweA==
X-Received: by 2002:a17:90a:d448:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-2f55838d0eamr8537569a91.14.1736502482736;
        Fri, 10 Jan 2025 01:48:02 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f12f94asm10822555ad.72.2025.01.10.01.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 01:48:02 -0800 (PST)
Message-ID: <b645e3e3-b42a-4d7a-b5f1-8f8fd9eff0ee@daynix.com>
Date: Fri, 10 Jan 2025 18:47:56 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] selftest: tun: Add tests for virtio-net hashing
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
References: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
 <20250109-rss-v6-5-b1c90ad708f6@daynix.com>
 <677fdee2b56d_362bc129446@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <677fdee2b56d_362bc129446@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/09 23:36, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> The added tests confirm tun can perform RSS and hash reporting, and
>> reject invalid configurations for them.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   tools/testing/selftests/net/Makefile |   2 +-
>>   tools/testing/selftests/net/tun.c    | 558 ++++++++++++++++++++++++++++++++++-
>>   2 files changed, 551 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
>> index cb2fc601de66..92762ce3ebd4 100644
>> --- a/tools/testing/selftests/net/Makefile
>> +++ b/tools/testing/selftests/net/Makefile
>> @@ -121,6 +121,6 @@ $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
>>   $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread -lcrypto
>>   $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
>>   $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
>> -$(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
>> +$(OUTPUT)/io_uring_zerocopy_tx $(OUTPUT)/tun: CFLAGS += -I../../../include/
>>   
>>   include bpf.mk
>> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
>> index 463dd98f2b80..9424d897e341 100644
>> --- a/tools/testing/selftests/net/tun.c
>> +++ b/tools/testing/selftests/net/tun.c
>> @@ -2,21 +2,37 @@
>>   
>>   #define _GNU_SOURCE
>>   
>> +#include <endian.h>
>>   #include <errno.h>
>>   #include <fcntl.h>
>> +#include <stddef.h>
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   #include <string.h>
>>   #include <unistd.h>
>> -#include <linux/if.h>
>> +#include <net/if.h>
>> +#include <netinet/ip.h>
>> +#include <sys/ioctl.h>
>> +#include <sys/socket.h>
>> +#include <linux/compiler.h>
>> +#include <linux/icmp.h>
>> +#include <linux/if_arp.h>
>>   #include <linux/if_tun.h>
>> +#include <linux/ipv6.h>
>>   #include <linux/netlink.h>
>>   #include <linux/rtnetlink.h>
>> -#include <sys/ioctl.h>
>> -#include <sys/socket.h>
>> +#include <linux/sockios.h>
>> +#include <linux/tcp.h>
>> +#include <linux/udp.h>
>> +#include <linux/virtio_net.h>
> 
> Are all these include changes strictly needed? Iff so, might as well
> fix ordering to be alphabetical (lexicographic).
>    

Yes. I placed header files in linux/ after the other header files 
because include/uapi/linux/libc-compat.h requires libc header files to 
be placed before linux/ ones.

