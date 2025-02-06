Return-Path: <linux-kselftest+bounces-25891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E97A2A1BE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 08:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B0116856D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 07:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F5B224B1B;
	Thu,  6 Feb 2025 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Z94t4Vw+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0981FE461
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Feb 2025 07:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738825461; cv=none; b=l32dAwgv9PshAtkbJmggi1LKKrlyFce/kPE5wuuzfOKBJttulMKaJzrEociX7xeuQb3zqyp2PWW7+XgrkF/RnZXfOu1ppm5PG4AS5/w+bwFC8KE+iLHHIgj6QWrmz0N8Zb8iZP64UXIwLBEKycm8taFOiBkrx0VRlHL+KiFc8p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738825461; c=relaxed/simple;
	bh=6Z7n8UWnuTd40YxRqOUHsnsjz1hSaR5JYJ7mFXzEuEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nyC/MlvgAVrc5quGLTi2dAqV4jY9hUwPpHqqc1FL88DXgXH7TC0RFfwESS9oR9Q9Q3k9x8n06w0V+FhCSfLmq0Jx411i4UObOasZ977Er2IL01n52Gn91VrS3kMZD3UF81HyZzdXbWjcHp4Vy5w3h7BwcjR0e51INuWw3e4rosU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Z94t4Vw+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f3e2b4eceso1986105ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Feb 2025 23:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738825458; x=1739430258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xSMzQMG1ZHF7w5vbC9dgevornaZeizWpfwbsJmx7bQk=;
        b=Z94t4Vw+PQhHm/5AADHOjjd8ZhDcd+V5D6AQ7o7Jp1LWmWsHVcxJlyOvqcNqHIjGl6
         XiWk+CRqG67jELyb0owDOcKj7ld3q3qh3iSiHe7SK2vDLjqXrbSoiW+bXM5ehTPL1JaY
         9AVEKGIlfvuEAYlhz+WYcGKZ17KEAiLVjKav4mPAILViMwGvEJYx+fg0pSbSNrM292sn
         SiXt8MHxPvVYgCGKljfqrjhrFd5FVJ/f5dlWXUCu+aB1wOhvMOn3lCdkZr3lur42Upvy
         3WvUzsWgHU3ts0u5ySa25e6zDILJHcwrk7jsdWWT3jGijvNNSkwM0YHShK4PrGu8SixI
         3jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738825458; x=1739430258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSMzQMG1ZHF7w5vbC9dgevornaZeizWpfwbsJmx7bQk=;
        b=bf4O90SDCpzgQLcVzj7o38nX4TvNvpNw1yqhHg0aDXiqaPRVC0+H8bfda30Hhgb3tF
         V5Q1hN1lRSq96o/blzqDNDtiCMApvZsisj2NjqlispuNBfhaRZSiQ98YfJyugyu0GdOj
         VwmE/wR3W8QLllZ4PFypWIkQq2zDxGz1EddaqvU29qP6sL1aGyDHrvcbexKHX3OtuUAo
         lanVLkK4J1+7pqSvWrN+RgZ5dTb2OyDhbi6j9a66a/t9uZ7E8wf8LPw4nRKHKVnQN4Mo
         p+DTV+Huc5qCV40fVvso7Y94X2rWSCu/od9v+qRgEIJVEIw9CriP7WL+YjBKza3e9C5U
         ZGTg==
X-Forwarded-Encrypted: i=1; AJvYcCUylN4hG7TG2ZPzYyl7WoziS8Pxu2YJfNVfDJga4nTI5DabEINmNYpbcShi+7OleTWxN5518IK9Wpa/CukNdqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybRgzLSLNK7c0cbYii4g3Latw/4myc72mfAkFMNWC0YPZLkL2K
	uvgpv+gLeE0+ZU2BG7u3Q7FmYeyKz0K26JdS4w5jXeAlzQLlK1pWHkWIaGXS9yw=
X-Gm-Gg: ASbGncuTucD8304UyJcUcv4lD1yPnuVd9A62mtWDSmlAJJDXFxqqfj+oa0H4ux872IN
	M55QSlPzgBogUxfZJ899VSZjZCzkICoklzvfhuLx/Xz5w9WK6FFP6yCoBhrzguHUTP/N0FNBkBH
	awdyMQ1tze+rW3C8blrTNll2ZzBZZ9rgV1xwQwS37W6VGotfUivNeCFeWhLlBib0kSBjWhgaxuJ
	Ol2p4kJUwOSlyRW4DA4rxc/mojqhYzm7jnRaxrvSCoQPZmacL/9GxDsLyTcRlmljjuZaQbSG+cA
	uQyJ6TavCj6qzIAWYo7EvaE71JG3
X-Google-Smtp-Source: AGHT+IEGoYiB8pxUq02irm/CU5MvTVOQlUDfWzGd8n7ZsLH5KxtqKlPFWXhqlXZi0kPwplHWCVM1fg==
X-Received: by 2002:a17:902:f64f:b0:216:3e87:c9fc with SMTP id d9443c01a7336-21f17ddf80bmr102170675ad.5.1738825457907;
        Wed, 05 Feb 2025 23:04:17 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aecce52sm481627a12.18.2025.02.05.23.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 23:04:17 -0800 (PST)
Message-ID: <8b389981-c04a-4d4f-8a5a-043b4cd6e8db@daynix.com>
Date: Thu, 6 Feb 2025 16:04:11 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 6/7] tap: Keep hdr_len in tap_get_user()
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
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-6-15d0b32e87fa@daynix.com>
 <67a3d6706c01a_170d3929436@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <67a3d6706c01a_170d3929436@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/02/06 6:21, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> hdr_len is repeatedly used so keep it in a local variable.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
>> @@ -682,11 +683,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
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
> 
> I forgot earlier: this can also use single line statement
> 
>      copylen = max(copylen, ETH_HLEN);
> 
> And perhaps easiest to follow is
> 
>      copylen = hdr_len ?: GOODCOPY_LEN;
>      copylen = min(copylen, good_linear);
>      copylen = max(copylen, ETH_HLEN);

I introduced the min() usage as it now neatly fits in a line, but I 
found even clamp() fits so I'll use it in the next version:
copylen = clamp(hdr_len ?: GOODCOPY_LEN, ETH_HLEN, good_linear);

Please tell me if you prefer hdr_len ?: GOODCOPY_LEN in a separate line:
copylen = hdr_len ?: GOODCOPY_LEN;
copylen = clamp(copylen, ETH_HLEN, good_linear);

> 
>>   		linear = copylen;
>>   		i = *from;
>> @@ -697,11 +695,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
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
>> +			copylen = ETH_HLEN;> > Same


I realized I mistakenly replaced linear with copylen here. Using clamp() 
will remove redundant variable references and fix the bug.

