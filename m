Return-Path: <linux-kselftest+bounces-28696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA84A5B920
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 07:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9BE16FEA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 06:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D682F1EDA3D;
	Tue, 11 Mar 2025 06:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="r0pVdBqS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2531DEFE1
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 06:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741673994; cv=none; b=Av0iIaYHk+JXcbwNV5JfO7iUPcYYiQAg/2gBJSffkNrL1lA+YVSPhijTxqY9J+PTAv/vtbXArzok65+m9cQfShwqYU/I4dxaq8yTQeoPahxwYdHiT/9ye6FxTz3NYvFoPnqRYkrDmsR9GFYw4gBd851wg6DsxfkV62VZRXGsTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741673994; c=relaxed/simple;
	bh=ZP4EaVCBU43ETX1tsWfetopJ677SR8acZVhOJLrcrw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qr3MIEURdwiZ2AQ9oOTvJimJr9DymOu3Zs1cc6Ks04wgr8uf41RuiRWxesVVC21dH5Ft/zeEnxi9p+P01w+G3V8mH346ewCisfxy+kcXyT6sI/WMUwFTpzQAEA9YnF0zbhtfKOj/SpM12NGpeawXIZ3AJnIKGgYxyfZp+pk1UwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=r0pVdBqS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2232aead377so1670575ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 23:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741673992; x=1742278792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbcW5/eDAGhdpWi7HyX3jjOdHbLTgrUim/DP0OQGuWo=;
        b=r0pVdBqSlYlaLTahjdTPd8TF3QsBOiOSOqTWeNjGAMKFcI3nXQfondYE+kch38jYSL
         5YwEt4prOcOBGftjrZ1F72y8/J6hrFawCMkGNOP7+u7cJYnWCiXuiIRC2SESSFSS8CHA
         FpBomgMo+qnJRoTHuw9co+mDt0+ce85cp3ZT6HRywW3SPQ4o/xiUA36SkNWtxvrAuT1w
         WQGmmF9NVuhUaZJNg8ARmVSDem38gWxRzgcUhPrBP2GNGfHzkT7cU3GnW9wdecY583rN
         TaB0euWxhno9HQIRt0XJG3o75zVFGnVvvndOBG4FGmbz/S++SRb1q0Bsu7843OPZgFzX
         zPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741673992; x=1742278792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbcW5/eDAGhdpWi7HyX3jjOdHbLTgrUim/DP0OQGuWo=;
        b=BdvKQJ1bRTzmjwYcJFZM158l3u4gcRRuAE34zIe13aDfzvwsu3ARlMIFuT7s+iQfHq
         dq9yFSLPyfjy7NePQSglfbxUKxvYp40TjXkFmLCLqJHR1APd1J4gNIbx4TQEOk7SwNXP
         7QKl87vFWtvYKdjIcOf5MTrUS31+R6YEMqgroQruz0rBGPAj/7MAHTmNkPs5KspPs1oq
         jFZ0uFnJHYNTKek4sQHm8hYpg76lWiHwP75fTyWr28m2OprkvQ+ofM/JtVj+lnUsH8vP
         Zgyl/1Dwz049FNgElSGVJdXwn8WqYYNwtAX/QjmW7lgTBzh7RLXPHl3VOKE3tu+NJNKN
         sUJg==
X-Forwarded-Encrypted: i=1; AJvYcCWd08pEgI1MITuQcdDRIjf6xXxHM7oqTjm3Zwhx8l96IBjNibqD7oNjyxNwjv4JeNUIrt0K3uZPQMydzyVLA5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcQ1d3EuJniVy/RMd2FMACr8LmtQvdpgCkGrECPI2fE4sXeTbg
	czFJtxEttNPKMAIk74GzVk2N65G6EKOp2LTW+SC8rcnY5GXWmLPFIbLVIYsCCGw=
X-Gm-Gg: ASbGncuoJQypORc4FuwqRR3VCtZhcMbD+d7lpgexiXlJ9S8JeHB1MW6pIyuBAC44eYV
	WFGmV5Zj50BSuFnWHke+DoGh7f7fKvAk7BoWrCt+yXW8GZVBeGe88P3RqmOxocSL0sk15xIKycx
	a+CE511zcx9i+D21uxJIguiKYau2PE0g8JDMIGu2ZXSWRgPIcP8tjWTLM2dpKMVtpBvbMXji3UZ
	Eumupl9v1YAZ8uVPMYBOHEe38+gXduwWk7MH3e9Uql2yg2HuWQ1MK40CGNFP3FpcqzM7k9X3gOz
	3N1ZmS94C08SR3m07iZxCYPMqvB2IYs/5lR8GWLnW7ENVcPSRDP53xeLEg==
X-Google-Smtp-Source: AGHT+IEO1Addst46ofGtxfDAcyJAfRa7cWyZNqzRhdZXtyiIrODFKfx6qBjS5jqvhrfaOM+pKspNkg==
X-Received: by 2002:a17:902:e802:b0:223:26da:4b6f with SMTP id d9443c01a7336-22428895abfmr268969215ad.14.1741673992501;
        Mon, 10 Mar 2025 23:19:52 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f5dasm89029115ad.137.2025.03.10.23.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 23:19:52 -0700 (PDT)
Message-ID: <217fb3ef-336d-4141-b47e-3236f2c22ec3@daynix.com>
Date: Tue, 11 Mar 2025 15:19:47 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 5/6] selftest: tun: Add tests for virtio-net
 hashing
To: Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250307-rss-v9-0-df76624025eb@daynix.com>
 <20250307-rss-v9-5-df76624025eb@daynix.com>
 <CACGkMEuTwd4+DP1Cb+ZgJtxTiJj4N_NMPHiKusd8a4Tn3+B_3A@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEuTwd4+DP1Cb+ZgJtxTiJj4N_NMPHiKusd8a4Tn3+B_3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/10 13:03, Jason Wang wrote:
> On Fri, Mar 7, 2025 at 7:02 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> The added tests confirm tun can perform RSS and hash reporting, and
>> reject invalid configurations for them.
> 
> Let's be more verbose here. E.g what's the network topology used here.

The network topology doesn't matter because this only tests the rx of 
one device.

I can still add more details; it tests all supported hash types, and 
tests both the queue selection and reported hash values.

And this message is wrong in terms that it does not test validation of 
configuration so it also needs correction.

> 
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Tested-by: Lei Yang <leiyang@redhat.com>
>> ---
>>   tools/testing/selftests/net/Makefile |   2 +-
>>   tools/testing/selftests/net/tun.c    | 584 ++++++++++++++++++++++++++++++++++-
>>   2 files changed, 576 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
>> index 73ee88d6b043004be23b444de667a1d99a6045de..9772f691a9a011d99212df32463cdb930cf0a1a0 100644
>> --- a/tools/testing/selftests/net/Makefile
>> +++ b/tools/testing/selftests/net/Makefile
>> @@ -123,6 +123,6 @@ $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
>>   $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread -lcrypto
>>   $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
>>   $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
>> -$(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
>> +$(OUTPUT)/io_uring_zerocopy_tx $(OUTPUT)/tun: CFLAGS += -I../../../include/
>>
>>   include bpf.mk
>> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
>> index 463dd98f2b80b1bdcb398cee43c834e7dc5cf784..acadeea7194eaea9416a605b47f99f7a5f1f80cd 100644
>> --- a/tools/testing/selftests/net/tun.c
>> +++ b/tools/testing/selftests/net/tun.c
>> @@ -2,21 +2,38 @@
>>
>>   #define _GNU_SOURCE
>>
>> +#include <endian.h>
>>   #include <errno.h>
>>   #include <fcntl.h>
>> +#include <sched.h>
> 
> Is this needed?

Yes, it is for unshare().

> 
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
>>
>>   #include "../kselftest_harness.h"
>>
>> +#define TUN_HWADDR_SOURCE { 0x02, 0x00, 0x00, 0x00, 0x00, 0x00 }
>> +#define TUN_HWADDR_DEST { 0x02, 0x00, 0x00, 0x00, 0x00, 0x01 }
>> +#define TUN_IPADDR_SOURCE htonl((172 << 24) | (17 << 16) | 0)
>> +#define TUN_IPADDR_DEST htonl((172 << 24) | (17 << 16) | 1)
>> +
>>   static int tun_attach(int fd, char *dev)
>>   {
>>          struct ifreq ifr;
>> @@ -39,7 +56,7 @@ static int tun_detach(int fd, char *dev)
>>          return ioctl(fd, TUNSETQUEUE, (void *) &ifr);
>>   }
>>
>> -static int tun_alloc(char *dev)
>> +static int tun_alloc(char *dev, short flags)
>>   {
>>          struct ifreq ifr;
>>          int fd, err;
>> @@ -52,7 +69,8 @@ static int tun_alloc(char *dev)
>>
>>          memset(&ifr, 0, sizeof(ifr));
>>          strcpy(ifr.ifr_name, dev);
>> -       ifr.ifr_flags = IFF_TAP | IFF_NAPI | IFF_MULTI_QUEUE;
>> +       ifr.ifr_flags = flags | IFF_TAP | IFF_NAPI | IFF_NO_PI |
>> +                       IFF_MULTI_QUEUE;
>>
>>          err = ioctl(fd, TUNSETIFF, (void *) &ifr);
>>          if (err < 0) {
>> @@ -64,6 +82,40 @@ static int tun_alloc(char *dev)
>>          return fd;
>>   }
>>
>> +static bool tun_add_to_bridge(int local_fd, const char *name)
>> +{
> 
> I wonder if a packet socket is more convenient here.

I'll try it. Thanks for suggestion.

Regards,
Akihiko Odaki

> 
> Thanks
> 


