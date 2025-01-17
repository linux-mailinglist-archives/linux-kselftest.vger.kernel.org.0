Return-Path: <linux-kselftest+bounces-24710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557E7A14DA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 11:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D959188AC9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 10:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F23E1FBCBC;
	Fri, 17 Jan 2025 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="P6RxKjc+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8361F9F58
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110128; cv=none; b=ofailJ1J0CK1KAh2CAilLfEnSpISlpJ7an/90BQ6lGWI8IHvbmn/+RaujWZBz2HvAvsXhNVu+yw3aJM2PtQuRtfnf+tTVqfeW/aY6HHukSkfZFwwVmie76aB3B+SwPSpA9VCdcvDAG060Y2aSXMD5gehpzxTOBUDQ2BXWBEPGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110128; c=relaxed/simple;
	bh=70bfaT34dxfacCnCOxEBqaLDOi2/f294fVDQPUnDUSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=OAdqSydmJ5cWfEmdThwIeZxwvNnxpPmkeyLeu82f8B/Sih3/NajVrb3qAB5WysTyQj+oUAb2v1CBF5Quy8qYq0xQRwLyL8zqDKv2s9hzkBwjoUAr1c34+45sAdVLNwn5Ue3Mho4d2GQ4KYB6ddHzAuVHBf3Bn7cjiznIWjf8ysY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=P6RxKjc+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-218c8aca5f1so46956375ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 02:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737110126; x=1737714926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1s3j+Lo8FohUApnn9jxJmXSbe+FtIPWK2NNPguyY5ds=;
        b=P6RxKjc+Fvu+48J+Mgoj+P8aOkuqRlMij+k5AS9ELVIjMH2zLxK3uhS13pQt4yC0+0
         SomVAFK9Y8lOX+rGAfJ+8QWuuaqdOiMCj58MXIAMLQkMhlTJqEnVSQm54EYFUyf3JXFO
         iFpdKCmikfvAxOlwTASDIo3/nLsTSERDHlJTrf/qyFfOlZg+1D9C8cN/cZJVQRoeO/HN
         8svSpUy0Sv7EkTGsfCES7GE+q0zLb6hvRw7J9GuoDEwhWFqK18Oo75KTb/B2Dj2lhvLl
         uLAsgFpsmqrYJTAZLa4r0xKU7tcKBO7o3jBCYpu69EoOjnRCmiJqR8o/fFBHtxL73jH8
         bRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737110126; x=1737714926;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1s3j+Lo8FohUApnn9jxJmXSbe+FtIPWK2NNPguyY5ds=;
        b=EnLcRWgaOqYAcQ0UMcAZFkw8/lq/Z017DIe2KwPjC/R00QkoDsGtPTsQNGL9KOU7l5
         bPMX2LvcL4l0H0zkZSZHh4bY+/ovTrm0+/GCuZDWnf0o5nBAwpF9CvOwNL/K/Ewwh6a/
         fagN4eEIbPZYDFWadLa+ekPdJ3g+lJC1jxgxNiVHVadYjAkRgyyjGxjJX6Qjay9Eh75B
         srP4okaXxt5O8h8HtFahzIHhXyqvfx581HqWXx8V1GIwucazWuZICpm8mb8YwR25Aj3V
         /CWLkx2Skem46zY+ZhQFb0g39FW7V5VdF76kOOlt/WLsG37MTo06ZNi27z+qfjtGnmHN
         UinQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvOKRsel1FS7jTGSffHRwxor1OewPHRDu68LIueAZ40gWoOV3AQrp9jdc6XBeNISKufuMr9kWrshQ+GViot+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0QtrBgoTJezVPciBm8tjFJD8mkMrpFUYTZN88BRT2Zv+Ra/wU
	+vGgoUPofwRAKBE/1Y5cxfdAJhFG25NAasMXkiVyryuENnd/ctN0Ab56TGwjC6w=
X-Gm-Gg: ASbGncv+PK5nim/FeAhQIJp6nm1YJsgpi81nBA03NbBajXOxTcr7s5Nm1HS28flr5ld
	ieDKCcKgGXAWQnLS4N9Fhf9qTwdaDwqYInLnxW7v0L2I7OWjHXK8NpihcCyKRE5crAbhZjq8Gri
	WEbmOF6fIar483lXmHtTvDyO4Y5FTUlOO6bp+ajEgsA7aAApiWzsn//3gZcXANjj0USudei+r2Q
	X8mSNb+jHwZLNhqKhBN+E7kK4wMah+hL+u8rhuAnrEoKgmzjMsrnKOsiVXiB8Vr6WE=
X-Google-Smtp-Source: AGHT+IGPzLz6S37k0uPz0pnAPaNjl5ykAtTRRDNMCEBSSX1EJykbz5I62peVJ/pXXng63XBSAbFQiQ==
X-Received: by 2002:a05:6a21:788b:b0:1e1:9bea:659e with SMTP id adf61e73a8af0-1eb215d4c46mr3415218637.35.1737110125973;
        Fri, 17 Jan 2025 02:35:25 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab81754csm1564334b3a.63.2025.01.17.02.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 02:35:25 -0800 (PST)
Message-ID: <51f0c6ba-21bc-4fef-a906-5d83ab29b7ff@daynix.com>
Date: Fri, 17 Jan 2025 19:35:19 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 9/9] tap: Use tun's vnet-related code
To: Jason Wang <jasowang@redhat.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-9-c6b2871e97f7@daynix.com>
 <678a21a9388ae_3e503c294f4@willemb.c.googlers.com.notmuch>
Content-Language: en-US
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
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <678a21a9388ae_3e503c294f4@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/17 18:23, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> tun and tap implements the same vnet-related features so reuse the code.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   drivers/net/Kconfig    |   1 +
>>   drivers/net/Makefile   |   6 +-
>>   drivers/net/tap.c      | 152 +++++--------------------------------------------
>>   drivers/net/tun_vnet.c |   5 ++
>>   4 files changed, 24 insertions(+), 140 deletions(-)
>>
>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>> index 1fd5acdc73c6..c420418473fc 100644
>> --- a/drivers/net/Kconfig
>> +++ b/drivers/net/Kconfig
>> @@ -395,6 +395,7 @@ config TUN
>>   	tristate "Universal TUN/TAP device driver support"
>>   	depends on INET
>>   	select CRC32
>> +	select TAP
>>   	help
>>   	  TUN/TAP provides packet reception and transmission for user space
>>   	  programs.  It can be viewed as a simple Point-to-Point or Ethernet
>> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
>> index bb8eb3053772..2275309a97ee 100644
>> --- a/drivers/net/Makefile
>> +++ b/drivers/net/Makefile
>> @@ -29,9 +29,9 @@ obj-y += mdio/
>>   obj-y += pcs/
>>   obj-$(CONFIG_RIONET) += rionet.o
>>   obj-$(CONFIG_NET_TEAM) += team/
>> -obj-$(CONFIG_TUN) += tun-drv.o
>> -tun-drv-y := tun.o tun_vnet.o
>> -obj-$(CONFIG_TAP) += tap.o
>> +obj-$(CONFIG_TUN) += tun.o
> 
> Is reversing the previous changes to tun.ko intentional?
> 
> Perhaps the previous approach with a new CONFIG_TUN_VNET is preferable
> over this. In particular over making TUN select TAP, a new dependency.

Jason, you also commented about CONFIG_TUN_VNET for the previous 
version. Do you prefer the old approach, or the new one? (Or if you have 
another idea, please tell me.)

> 
>> +obj-$(CONFIG_TAP) += tap-drv.o
>> +tap-drv-y := tap.o tun_vnet.o
>>   obj-$(CONFIG_VETH) += veth.o
>>   obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
>>   obj-$(CONFIG_VXLAN) += vxlan/


