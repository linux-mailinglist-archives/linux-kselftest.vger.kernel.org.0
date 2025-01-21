Return-Path: <linux-kselftest+bounces-24827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F13A17716
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 06:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ADAA7A1614
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 05:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039F91A23A0;
	Tue, 21 Jan 2025 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="x0S9cVH+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8474385931
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737438288; cv=none; b=oZ1o6ikA/BVr31pQntz8K//4/g9+Dy+pX5Y0rQDixzp0qekssftpIGmTudVyUkG6x0MhA64YkJetAstSKZ24g8kQ0bg8M+pba31Bk/D9YbKPTPjCt5/nNmZq/zt3RZmKjTpW2+v6dv9SM8hILrqJ8scaz1LJEWJg1T/g1rkG8xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737438288; c=relaxed/simple;
	bh=KKjKQrSywZ/HAtYTFy2CTQDgCf1VU2GQ+lX5cc5vXaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CdVaLS0TPQ/pNWQ6F9aqEjLkh9p0YwQLLbU670LQwyFrtjB+i27PZ9RTl8CWAW7bvKQ0+UR5kKqLZQ/ukixpXIM6nWCwaEveMwXqQ+aQrs7jShQ27E3gPxTGzzxc2SQXNIkSrniLRCQz85ZNHiGUAzZpO239xgefA7+VmogaYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=x0S9cVH+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21654fdd5daso87410735ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 21:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737438286; x=1738043086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=quek95SDTYVXYnePfXxFQzmJR+Lu7obq+8lhE5GmOzk=;
        b=x0S9cVH+78ZZsjSKnRfDP0qqXDfV4PoPpohm+0pSST8TJ2V/qwePvhtGtyaATADz34
         cMWnJAVX5i/ptl10y23jtB0aCVN2PKm0SguQmUfFcins2jgSY/jPVpqIAjZSS2OBlpsQ
         PV7cAkrn+ALhDyHnNpo9vtqbsAdOgdK0yGIZf5sHOylSy811YQJH8230tz16b9Wb5E25
         ll5/TrZEkikQbRR6+WSkKRHox/ZOZIE3iWVu/M4F/BrJyQyYK4h61ozMmXXehk3msD/H
         17d8wVOEfLVAycsUnjCn74CHH+SALXwAeaHzJPM1UiptfEUTeqnMs1az81MH1G2hGhVg
         Es7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737438286; x=1738043086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quek95SDTYVXYnePfXxFQzmJR+Lu7obq+8lhE5GmOzk=;
        b=nYrp168dMC6RCogWIQKBuSZVn/rHB6Al3hXdkN9FX80fhAAS1eg/bnrRKU/hE/6acy
         XFIjkyKm/CCoDn5xKhuJ6tfcHO7XMwwuxeZ2ZZe0wGiuLCraxJ7wzEpw65o3eOEFpSd6
         fwV/kl58URQDsAexCcQXdIHGtMcMNQu4wFquiVuV6k3nRzV7POb06mMYFs28u4oVFtVF
         jgofWkDEb9N3Vyrd/1W70xnZjtJm9yE3jX7aNQ0nPMtCKIKLbfVLQivQd3r8feM9PBst
         bnOE+PAd+Bj+n9ITrcj2WAuLT4rYFZgg8KX1D3HViaAboPX2dw40llxlXRa3OOUtl7F9
         BRhA==
X-Forwarded-Encrypted: i=1; AJvYcCXdemgrb4X1f/dnjjCMa3KsGx4vFAi+SAoL3m8qGXa1Al/xf4DLDoGb3nc1F3u3XtyS2fC1ZKauAR3udqFSTpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZZoI492E732uls0LXuxGWpLwkzbwWRawWsmBgdM1W+npzgF9
	0zJStaQFiGZzrV4/sUNJ5mXgQb6A23vIh+B9bA5M63EQ5QDKgqYRmxYojPBcjmA=
X-Gm-Gg: ASbGncsJeFmM7/6OAy33uyifkfMHT2C7igGlB5rgERJcov1/72jddHYZ+bYuMT+sbsx
	zYz5E2krGffSf2uV/dFrtwfBpIf8dcH35ignSSGphqFq6g0GSvapR8ux3NEefOfO/UZkz8eFyle
	ukkC6tYRLhATg0guPe1Ic9HLwwWhNBSegiOlpn4u6zdDRDpUPqVzhAJCMbeBCxxb64Hs1akLbiK
	HZjtmphNElczSCvkSda3woPgwgJfWx6uH31NKQOfe7q/M/kVW7PgH1pDgFJCowYVa//RKqXRZ9r
	9lCF
X-Google-Smtp-Source: AGHT+IFTVBGY3mBtHPPZNgGiKdheqCTQ97KHaRubQObIyg1+VGXEf+v/0x6j6pVWQSFPga7FkyMokQ==
X-Received: by 2002:a05:6a20:2524:b0:1d5:10d6:92b9 with SMTP id adf61e73a8af0-1eb215894f4mr22737961637.30.1737438285826;
        Mon, 20 Jan 2025 21:44:45 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dababc174sm8360634b3a.178.2025.01.20.21.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 21:44:45 -0800 (PST)
Message-ID: <806def7d-16f3-4d53-abc8-7d18e8c22dcb@daynix.com>
Date: Tue, 21 Jan 2025 14:44:39 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 8/9] tap: Keep hdr_len in tap_get_user()
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
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
 <20250120-tun-v4-8-ee81dda03d7f@daynix.com>
 <678e327e34602_19c737294b4@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <678e327e34602_19c737294b4@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/20 20:24, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> hdr_len is repeatedly used so keep it in a local variable.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   drivers/net/tap.c | 17 +++++++----------
>>   1 file changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
>> index 061c2f27dfc83f5e6d0bea4da0e845cc429b1fd8..7ee2e9ee2a89fd539b087496b92d2f6198266f44 100644
>> --- a/drivers/net/tap.c
>> +++ b/drivers/net/tap.c
>> @@ -645,6 +645,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   	int err;
>>   	struct virtio_net_hdr vnet_hdr = { 0 };
>>   	int vnet_hdr_len = 0;
>> +	int hdr_len = 0;
>>   	int copylen = 0;
>>   	int depth;
>>   	bool zerocopy = false;
>> @@ -672,6 +673,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   		err = -EINVAL;
>>   		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > iov_iter_count(from))
>>   			goto err;
>> +		hdr_len = tap16_to_cpu(q, vnet_hdr.hdr_len);
>>   	}
>>   
>>   	len = iov_iter_count(from);
>> @@ -683,11 +685,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
>>   		struct iov_iter i;
>>   
>> -		copylen = vnet_hdr.hdr_len ?
>> -			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
>> -		if (copylen > good_linear)
>> -			copylen = good_linear;
>> -		else if (copylen < ETH_HLEN)
>> +		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
>> +		if (copylen < ETH_HLEN)
>>   			copylen = ETH_HLEN;
>>   		linear = copylen;
>>   		i = *from;
>> @@ -698,11 +697,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   
>>   	if (!zerocopy) {
>>   		copylen = len;
>> -		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
>> -		if (linear > good_linear)
>> -			linear = good_linear;
>> -		else if (linear < ETH_HLEN)
>> -			linear = ETH_HLEN;
>> +		linear = min(hdr_len, good_linear);
>> +		if (copylen < ETH_HLEN)
>> +			copylen = ETH_HLEN;
> 
> Similar to previous patch, I don't think this patch is significant
> enough to warrant the code churn.

The following patch will require replacing
tap16_to_cpu(q, vnet_hdr.hdr_len)
with
tap16_to_cpu(q->flags, vnet_hdr.hdr_len)

It will make some lines a bit too long. Calling tap16_to_cpu() at 
multiple places is also not good to keep the vnet implementation unified 
as the function inspects vnet_hdr.

This patch is independently too trivial, but I think it is a worthwhile 
cleanup combined with the following patch.

