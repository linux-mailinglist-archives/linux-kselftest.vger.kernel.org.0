Return-Path: <linux-kselftest+bounces-21351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153289BA5F2
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Nov 2024 15:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3699BB211EB
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Nov 2024 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F09169AC5;
	Sun,  3 Nov 2024 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER+ns65A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193CB15A8;
	Sun,  3 Nov 2024 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730644510; cv=none; b=dMCI8gRtYi9rbAxIEUu2CfNlLjFRrERNYIlJ2f/bXZc2X0LSsESzu9oQBZwZQJtAjNSxUsUIudgdvUjsCJcXQbCavy5MqqMTNUNozSN9VVqwVCafRYFVGk237e1j0mWORqGuZ+f1OSMKWOSxZ5GlI6lAP9ZCz8KLHW7UKy52hb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730644510; c=relaxed/simple;
	bh=wG8Gn85Zge4Ab66VQVkdPkQl+aSYTS8FOKvqLK8bdKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SosFoT6eT1rX9jzHBkfiT+FzNpXOjroqj0hz/q7SHr+k++6uE9tWF138JdT85mEXgKrGPnSwQqtx9pk/OX+zCPvzObqH9q6GlqZmGy7Xwnc5fHXWhre8ALojp+pGX6B+F6PGtY385Mh2vzow8euimFCCg33AbCmJIIjtvUrWLuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER+ns65A; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20c803787abso25697515ad.0;
        Sun, 03 Nov 2024 06:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730644508; x=1731249308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=93+WiCi1ThC11RJJ36LYFSZWkX6cVfqzN1gwp+XLl5k=;
        b=ER+ns65Ao8o8EbUQPtQtbPZyAWi1Ely9BGBMzQzLAkywnutBlI7XxRs59lTtlq1Ebp
         bbLzL7OELZT8ba012YLwAdVHjkIZhaueDsXL2Cs0qcWHbQFsF7g9Bdtnze3cm2Vobk2B
         Vs3GhH+fEJOYKdoxnmTx3KgcY5IcA11CHdc3lZpEmc1Vveu920ZcKzFk7EqYn/yfjYMf
         0PH2CN6r3h21L5W/6lWVWuH8/V7Q9MOwFIavwj371qnolXD8JdiR5TPjxGvl8q4F6w4I
         wPxhKJeziFzOu5sjiPAn/9NCYrDEdAx6n6QTawmaoX8tyLbWEJbOYovTPgNbmah71qu1
         i+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730644508; x=1731249308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=93+WiCi1ThC11RJJ36LYFSZWkX6cVfqzN1gwp+XLl5k=;
        b=WO7MA+vuKnPLWPRxIHuslepqEZij8noBiXnPB7jUna9wSo/2nLyK8Ox82VKsuHfHvW
         jkwwyqPEmv1fe3dSapmLQMvDyZInXXR1oVimquO6k6rHTkt/mI22HBLUtldYaoOzawIi
         oUkJ1XLaGihGclmA3ZttxSnuHaj+WRaGywWQGncxFdouDPg/1sjdVusrMSjuW9hGznuE
         GcsW0QXX2/Bdw5tIoXpEbbvYIAM2TlQOlS+K8ME/bpDE3RZsGrv2/p14u3/awk2W503P
         eFbHP40Sfv3R46mTRgjuauhJqdJn5cQLV8x+lxG9eiWrNGUe/ul1i2N55QMLU9FYkNv+
         oIIg==
X-Forwarded-Encrypted: i=1; AJvYcCUcY+HkLD22WrzPwmC/JqIYO1oJOKyHnEKAuad8BwTCtrRGCR3TU9CHidH8NT256dtTvolrGMPMK76isJ8=@vger.kernel.org, AJvYcCXXzqlod4X3oVfBWnC/ZkXgtFT11pX/XaWW74X7FaHXK4sEX5Q8kBpiBuSPRIC5e5vVfwtQpNDvy2jiLC+6UJoF@vger.kernel.org
X-Gm-Message-State: AOJu0YyUT13G1M8BevCoKmAXUkxbSaXRcCqAnueTRM3laULwoV9Qj9JW
	qQFSxYal9JTc9vh4ydw3TnPbUuxVf/w3R0P2fKMWwzcJDe8j0q0x
X-Google-Smtp-Source: AGHT+IHYGry+rKSxu3RbntAF4BRm7OG8IenHRHObkVwbvCSJWy2jgB0XmNnR8jw0ENSyjQ9ZhweoDw==
X-Received: by 2002:a17:902:b185:b0:207:1845:bc48 with SMTP id d9443c01a7336-211057ea994mr122515045ad.30.1730644508249;
        Sun, 03 Nov 2024 06:35:08 -0800 (PST)
Received: from ?IPV6:2409:8a55:301b:e120:426:560f:2ff4:d2c2? ([2409:8a55:301b:e120:426:560f:2ff4:d2c2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d4624sm46410645ad.259.2024.11.03.06.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2024 06:35:07 -0800 (PST)
Message-ID: <1d8c55c7-1406-4af6-9dce-0b296cd40fc9@gmail.com>
Date: Sun, 3 Nov 2024 22:35:00 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/7] net: page_pool: create
 page_pool_alloc_netmem
To: Mina Almasry <almasrymina@google.com>,
 Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>
References: <20241029204541.1301203-1-almasrymina@google.com>
 <20241029204541.1301203-3-almasrymina@google.com>
 <763d9630-3064-4d88-8e99-549a07328ec8@huawei.com>
 <CAHS8izMgF8nx87D9pWPmq1pfDm1v8x5Z6gc_eMHcYo8zKX-Lrw@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <CAHS8izMgF8nx87D9pWPmq1pfDm1v8x5Z6gc_eMHcYo8zKX-Lrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/2024 9:10 PM, Mina Almasry wrote:

...

>>
>> Isn't it a little odd that old and new are not following the same
>> pattern?
> 
> Hi Yunsheng,
> 
> The intention is that page_pool_alloc_pages is mirrored by
> page_pool_alloc_netmems.
> 
> And page_pool_alloc is mirrored by page_pool_alloc_netmem.
> 
>>From your description, the behavior is the same for each function and
> its mirror. What is the gap in the pattern that you see?

I was mostly referring to the API naming pattern.

Isn't it better if page_pool_alloc is mirrored by netmem_pool_alloc and
netmem_pool_alloc_netmems is mirrored by page_pool_alloc_pages() from
API naming prespective?

And maybe page_pool_alloc_frag can be mirrored by netmem_pool_alloc_frag
in the future?

Also, it would be good to update Documentation/networking/page_pool.rst
for those new netmem APIs, or create a new doc file for them.

> 


