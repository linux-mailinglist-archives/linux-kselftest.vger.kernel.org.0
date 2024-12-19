Return-Path: <linux-kselftest+bounces-23579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547EB9F77BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 09:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B8D77A3ECA
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A293E21D586;
	Thu, 19 Dec 2024 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeIENP0N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC831FC7DB
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734598473; cv=none; b=slGgKSrcJfplbsbYgQxIteNRTTKWIqG2loo/0jGJTl/wRveccO/O/46vqAAzbI8IlFRZvNKHqpdiO8krXqsL6vMtmga2LikGd5WNEqk7tNzgWNaNuPZUQh9s0rnciI3Xldl81aT4xnXgj/RgTpYLtQ7uVm+95twVsIbin/v3YeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734598473; c=relaxed/simple;
	bh=AbZVrsl5rcNSdQpiQSZHZhwFsv98yfZDMrhu36UQQ0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FywxvTnYQAemmRqXvkEkr9dA3tW8Of1KhdMmVfNIBjnDSSd0blrRBregEAqo0wiE7wIgRDs0VQPq5bUTKQKgCXzh9/vqYPbd9dIx6VpPCd2a0/rsa4owlkxUZeXtQw9KnYFEl1cL86gGdg2vT93PBWu0I/AL6CGtMKKDgsb9jUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SeIENP0N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734598470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ln73Acm3j+A5OSP5LEbrk72iNmfw3DGuza7Hn+SfBsI=;
	b=SeIENP0Nll5cRZY3Osvfh1QCzciC0X9fMJ/3Rg+7fw6p1YwvfhZU+gdCjeIoZex3POn1yI
	8boqzvFhNZpxkffd5UAE1xXIU5oSqlRVOE9OoPv/7OPmaXt4Aq+nmbp/0WtK5opGMQ4knI
	c19S9qL4jxeB6ntYGQ7CDcDXfBerdqo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-CSKynVH_NPOdBHy6FlLkeQ-1; Thu, 19 Dec 2024 03:54:29 -0500
X-MC-Unique: CSKynVH_NPOdBHy6FlLkeQ-1
X-Mimecast-MFC-AGG-ID: CSKynVH_NPOdBHy6FlLkeQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4362b9c15d8so3023925e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 00:54:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734598468; x=1735203268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln73Acm3j+A5OSP5LEbrk72iNmfw3DGuza7Hn+SfBsI=;
        b=esxULJHiWXOyaOIN2ey2LPDOMaQ1xXpCNTidZRIHnc0sy67QWNbq3pTrziEv8WbQnt
         ra0hf0lhWzch77GQ/tuwBUulejSRqb35SEd8bLFu3A2zubh9o0YgzYesR3/vUp3j65bm
         lnByZmTj0nsQDBJlXHAxzINmVyxGK9yE1gcmuQyeekvULXaAjL1LaeAVTKnPaBPlMcGt
         uTCYI4lu8NpWbOM7TtPISNxPvYKsSU15AGSngV7Ob49OchROu8SAwuNpPyTM3n8z1JBn
         +oRznJBKdLgpQ84hLllHc3Xy5vl76tDs4Kgsb8upYSbubzytAYGdvsJ8KAbuptVcTPtD
         4D+w==
X-Forwarded-Encrypted: i=1; AJvYcCURmByJPWV1ZLS6+nGRgLyG1f89iuBW3QEeZbCYTO7SxsUKVehyTj9yDMz94RXu6KSpb/3qI8MoqMM1It6+VMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFwEbBUdZBydjayIozQ0wFHD8FYDHoGfdeoroIV47mIFEkkltO
	WTyuPeC4ZfnC1ue9g9cPawKOEabSmcKrQ4CkLwPBZSBB+6ancM/yxE3jwUl/GaIBRM6/CStr2ZO
	tS0rc9LSq8YgfBdvhsUa0aFqg4sKE+unxeVSevpWtZHJEssT5ZzikO7MpgLPOEw2Eag==
X-Gm-Gg: ASbGncsRXIQj1rYoafNJ1R0slhHgRLMq3JFsRKFwGr9jaNBZZi8EIzeUNzMKqX/urah
	o8RXjweNgl5ZyFAhB3NIFKsbuB+VYBVTHDWEGMv5Rid7T+kspm5ABaqcWZPeZeMKyPrwofn9/OA
	F03MEqJzMo9n0DslKKxgqzwQ8l2UYLMnR10BCXN/rze6s6LqanjIYXt9NxsejJxaPy4OyLvA/j5
	v9afOrbkRY8e7Wqo3iT39RGKOIeE10sZs5W6OyR/4gXLZcZIDKHNhe1P35Zbnx/txGQRkH68PZx
	Bfimk+6rcQ==
X-Received: by 2002:a05:6000:4a18:b0:385:fd24:3303 with SMTP id ffacd0b85a97d-388e4c94037mr5970409f8f.0.1734598467830;
        Thu, 19 Dec 2024 00:54:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8u3gkOMLTQkOjSqvv39VU4biDyXs1jALCJ+S0HqVLmGxgtgTo7tJ8iRysWUI+BMylGj423w==
X-Received: by 2002:a05:6000:4a18:b0:385:fd24:3303 with SMTP id ffacd0b85a97d-388e4c94037mr5970386f8f.0.1734598467277;
        Thu, 19 Dec 2024 00:54:27 -0800 (PST)
Received: from [192.168.88.24] (146-241-69-227.dyn.eolo.it. [146.241.69.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c833149sm1020867f8f.39.2024.12.19.00.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 00:54:26 -0800 (PST)
Message-ID: <19df2c4d-c40c-40c5-8fec-bb3e63e65533@redhat.com>
Date: Thu, 19 Dec 2024 09:54:25 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] selftests/net: packetdrill: import multiple
 tests
To: Soham Chakradeo <sohamch.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 linux-kselftest@vger.kernel.org, Soham Chakradeo <sohamch@google.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20241217185203.297935-1-sohamch.kernel@gmail.com>
 <20241218100013.0c698629@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241218100013.0c698629@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 19:00, Jakub Kicinski wrote:
> On Tue, 17 Dec 2024 18:51:57 +0000 Soham Chakradeo wrote:
>> Import tests for the following features (folder names in brackets):
>> ECN (ecn) : RFC 3168
>> Close (close) : RFC 9293
>> TCP_INFO (tcp_info) : RFC 9293
>> Fast recovery (fast_recovery) : RFC 5681
>> Timestamping (timestamping) : RFC 1323
>> Nagle (nagle) : RFC 896
>> Selective Acknowledgments (sack) : RFC 2018
>> Recent Timestamp (ts_recent) : RFC 1323
>> Send file (sendfile)
>> Syscall bad arg (syscall_bad_arg)
>> Validate (validate)
>> Blocking (blocking)
>> Splice (splice)
>> End of record (eor)
>> Limited transmit (limited_transmit)
> 
> Excellent, thanks for adding all these! I will merge the patches
> momentarily but I do see a number of flakes on our VMs with debug
> configs enabled:
> https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=packetdrill-dbg
> 
> In the 7 runs so far we got 2 flakes on:
> 
>  tcp-timestamping-client-only-last-byte-pkt

Quickly skimming over this one, it looks like it does not account for
the increased default 'tolerance_us'. Kernel packetdrill set it by
default to 14K (instead of 10K IIRC).

I guess this statement:

// SCM_TSTAMP_SCHED for the last byte should be received almost immediately
// once 10001 is acked at t=20ms.

the the follow-up check should be updated accordingly. In the failures
observed so far the max timestamp is > 35ms.

Cheers,

Paolo


