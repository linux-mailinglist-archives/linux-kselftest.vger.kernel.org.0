Return-Path: <linux-kselftest+bounces-6716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CAF88EACF
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 17:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D341F32854
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 16:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA05E139599;
	Wed, 27 Mar 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPaQC+Ta"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDAC13A255;
	Wed, 27 Mar 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555700; cv=none; b=fWy6dqkmcf0NBuBpzoyInJGJ01tHvwV9OPNlOuKFylH0Afb+UhvEzdPdSedIVIsW3DIaqRMLs/MWs7siheh3epQUB6/iRMc/37kZ69k5uL7MopBPPEcg96tOgrIyAkU/J9ZrF1R+UeXahjT2K2N9zqMrEbhwTgeB4wwPpsssD1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555700; c=relaxed/simple;
	bh=0iO16U+RcaIQj4aVKcNwp6XirUs1x1b9+4YFmPwZvGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmiJ6lG+i5GuFUoifmO7QWVRJeFLpS40H9GmzHaMaeT3vl6//3t+L6rnPdc/9igcXRT6IKgJItA/jvrmmUKXyl7HRDevl9quzkkohenMq/blMnw45Up4PfakYbAXAvDVrpCcJfBpc8DcHi+vGcNTOuP5EVvNhbpotBCn7cfKzTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPaQC+Ta; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d46dd5f222so82577451fa.1;
        Wed, 27 Mar 2024 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711555697; x=1712160497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CUv3CkTq//cWUwM4SJVOjx7HSDPtYW8lbxH5Dusfu0=;
        b=VPaQC+TaMcY8Q7dBbnUJeMB5sYp8VrjZYPiJMQFKx+52GP+oAO2APAqtghNVlu1ZM6
         MAshVGxOf++lOA9jzdGrcsPMN5+/sDxaVuBgkvhiri8wV2/ow8VHH/c/UEmgCLfDjgrZ
         +RkS8dFGMUFYqA6MUmqBV6WofT0xJY/PZwJXt4sFv8l1TF2dF90FIGzSKlQctS6K2mjh
         ui89FDdLxkwkw3+WoNe+ZHB6xAnLXJ8gbCJNm9EBxkR1f6RtXl5CfxwK8SSbbph/Pp7H
         nFjCkMf+5YijPkMYOPgOUca59P6Ij2QNTxqN9wM8HdBY2nBwol17QNFqgRqpL64Fx5LT
         bYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555697; x=1712160497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3CUv3CkTq//cWUwM4SJVOjx7HSDPtYW8lbxH5Dusfu0=;
        b=urIqav6J8OVP+iwa9cE4QIIEzlIajzfLqx6vO3sx9i5vYgCTWnFpx/wgIQriS7OJb4
         TbPLtZTW6mcY8ruTOUGbkmNSIaBrXeyoXcKcQ85GdOmeHnGrNp/LMPnb5DWFBgj8Dnni
         /66tiAO6K72g23qRsxuOoY4pDg1by+qG3A4nJCNfNkcXue2ge+B1Ms0oq49jgBE5dwJt
         CVEdghablR9LGWAB6irUs9SAz1vMjPGOjifhuyghavUNIx9uPvRNu0p7E6HTjvu2B8W6
         Q7t49eiTWOeVihWZt9242G5LbdOPhZSFeDv5HAkpkqeGxzQPlCqlcFF1poW+D3vaMulo
         IkJA==
X-Forwarded-Encrypted: i=1; AJvYcCWicKr4cFTJPH8JBro5mb6j9+L3gL2oGrMMU0UxTL+PEKMuk8sE0Rv/zqaD1eK2Hp2CW8PIit4rviz0Ct64TdsgfpU4mv6RYEibjf4eDxFWsa+L3kk6ZA6pMaYe+QJJKle0A78rhqhdml2NB3tJui/blVui+LDoSe6/cKz/lDDhWYE5/RHO
X-Gm-Message-State: AOJu0YzLnZV070K5eI6XbXm4mIKFHO1lI/N5v7un+R7wnBf/G7y8f91e
	Qp5jvJlu8AKv+u9auVUZZQuH7RuEc2aIzmCtQpKPiccSr6LJpNwl
X-Google-Smtp-Source: AGHT+IFzPUMFJ/CK9cR+qDyB9jS0Lqe2prJoSm3WpbtCPdC85ve6ooT6e0kSEkuhZJCLoZsPEXZhFg==
X-Received: by 2002:a2e:99d3:0:b0:2d6:f127:f5e7 with SMTP id l19-20020a2e99d3000000b002d6f127f5e7mr362090ljj.21.1711555696459;
        Wed, 27 Mar 2024 09:08:16 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id bn15-20020a056000060f00b00341e2802a30sm1669899wrb.98.2024.03.27.09.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 09:08:16 -0700 (PDT)
Message-ID: <f314f3c5-0641-42e3-be56-3173fdcf0977@gmail.com>
Date: Wed, 27 Mar 2024 17:07:46 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, willemdebruijn.kernel@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240325182543.87683-1-richardbgobert@gmail.com>
 <20240325182543.87683-5-richardbgobert@gmail.com>
 <CANn89iKzeTKuBA3NL0DQUmUHmmc0QzZ0X62DUarZ2Q7cKRZvSA@mail.gmail.com>
 <46e0c775-91e7-4bf6-88f3-53ab5e00414f@gmail.com>
 <CANn89iJkDbzLKmUGRHNFpfiaO8z19i44qgqkBA9Updt4QsRkyg@mail.gmail.com>
 <6566fd5f-fcdf-4dc7-b8a2-5e8a182f8c49@gmail.com>
 <d60c6185b8394da02479100981fa3f1306d9c81f.camel@redhat.com>
 <57bf675d-c2f0-4022-845c-166891e336be@gmail.com>
 <9f3509a7134f7e2dfd633ea62d24815e12b1f482.camel@redhat.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <9f3509a7134f7e2dfd633ea62d24815e12b1f482.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Paolo Abeni wrote:
> On Tue, 2024-03-26 at 18:25 +0100, Richard Gobert wrote:
>> Paolo Abeni wrote:
>>> Hi,
>>>
>>> On Tue, 2024-03-26 at 16:02 +0100, Richard Gobert wrote:
>>>> This patch is meaningful by itself - removing checks against non-relevant
>>>> packets and making the flush/flush_id checks in a single place.
>>>
>>> I'm personally not sure this patch is a win. The code churn is
>>> significant. I understand this is for performance's sake, but I don't
>>> see the benefit??? 
>>>
>>
>> Could you clarify what do you mean by code churn?
> 
> The diffstat of this patch is not negligible and touches very sensitive
> areas.
> 

diff mainly touches flush/flush_id/is_atomic, the new code should be
less complex. I agree this is sensitive as it is part of core GRO -
I checked all relevant flows manually, but I can also create more
tests and ensure that logic remains the same.

>>> he changelog shows that perf reports slightly lower figures for
>>> inet_gro_receive(). That is expected, as this patch move code out of
>>> such functio. What about inet_gro_flush()/tcp_gro_receive() where such
>>> code is moved?
>>>
>>
>> Please consider the following 2 common scenarios:
>>
>> 1) Multiple packets in the GRO bucket - the common case with multiple
>>    packets in the bucket (i.e. running super_netperf TCP_STREAM) - each layer
>>    executes a for loop - going over each packet in the bucket. Specifically,
>>    L3 gro_receive loops over the bucket making flush,flush_id,is_atomic
>>    checks. 
> 
> Only for packets with the same rx hash. 
> 

Right, but there are only 8 GRO buckets, so a collision can still happen
on multiple concurrent streams.

>> For most packets in the bucket, these checks are not
>>    relevant. (possibly also dirtying cache lines with non-relevant p
>>    packets). Removing code in the for loop for this case is significant.
>>
>> 2) UDP/TCP streams which do not coalesce in GRO. This is the common case
>>    for regular UDP connections (i.e. running netperf UDP_STREAM). In this
>>    case, GRO is just overhead. Removing any code from these layers
>>    is good (shown in the first measurement of the commit message).
> 
> If UDP GRO is not enabled, there are no UDP packet staging in the UDP
> gro engine, the bucket list is empty.
> 
>>> Additionally the reported deltas is within noise level according to my
>>> personal experience with similar tests.
>>>
>>
>> I've tested the difference between net-next and this patch repetitively,
>> which showed stable results each time. Is there any specific test you
>> think would be helpful to show the result?
> 
> Anything that show measurable gain. 
> 
> Reporting the CPU utilization in the inet_gro_receive() function alone
> is not enough, as part of the load has been moved into
> gro_network_flush()/tcp_gro_receive().
> 

Got it, the numbers I reported were only relevant to UDP flows (so
measuring perf top with -g flag showed the same improvement). I'll post in v5
numbers relevant to TCP as well.

Thanks

