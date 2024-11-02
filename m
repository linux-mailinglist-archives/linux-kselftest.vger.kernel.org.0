Return-Path: <linux-kselftest+bounces-21335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E859B9DFD
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 09:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B06282EBD
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 08:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80C8158866;
	Sat,  2 Nov 2024 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTjfl0/t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1D3158535
	for <linux-kselftest@vger.kernel.org>; Sat,  2 Nov 2024 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730537371; cv=none; b=besiHSCo7CtEvEfCDpL79ZaN03Gg/ZpQSaFLpqQA4lvwVaoaHbKNEBPz7msdTp1Z9pga6iRUETOYjx6Xuo/QlVKexU73F66XXS1ST8LxK169HGvN5kf2dt5ROmUflKIgItKrouhksG0O4EkFLBu5wdjBzRocCymA77YO0zN9D6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730537371; c=relaxed/simple;
	bh=TkXP/cpJPOoj9LYdp1iBbWo8Xo1nzK3OzNqjR58yWVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JV3nLphrMcMYc+LCapIRrQfaTUT/j9fGZkNRH+h7a+emUSQm8YnR8TIX0LGQZ+ATSiAxfyzaxRmzgg2E8AyURKxndvL3x54kiHLkiI98xQQL1m78HvA/QZSkKzE7lM7vBjw5o64rhDKQ4Pm5KRca5onIya7kqgpghS4IdVA+ScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTjfl0/t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730537368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q70AFy3BRDCTA52EifChE7qnVGXhJX/bCjYQddkFvAo=;
	b=ZTjfl0/tNsv4RCdukQGBZDIFaUIcOdRrLhUhw8hJ0+d46wwby6Q1f6B8zZJFQhfDWMR9Lb
	Wv2KzznOmVAP9mqjRNJnYwVv8Q8rC+v0d2a5jw7u1hMFMImduEbvCzrEz1OPUPS92eNxwK
	r+EYeKof0xkGZiEVo0pxy1nOj+JWeu0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-rllRNNINOJC1b9mdgO-kwg-1; Sat, 02 Nov 2024 04:49:27 -0400
X-MC-Unique: rllRNNINOJC1b9mdgO-kwg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d662dd3c8so1252147f8f.1
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Nov 2024 01:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730537366; x=1731142166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q70AFy3BRDCTA52EifChE7qnVGXhJX/bCjYQddkFvAo=;
        b=sOKK/peDG8U/ep1eGHefLw3nQn4lnJ5HVkoeBjX1Ou0d+UcY2ufMkqV7MZCSqzDkKt
         dQueCBQ/LPYhqIV3bHirSXlFE8mlRK12dJQJfszeUyq7d1i9V0rVqTrWtpZYxUwRzTvv
         tMyZfTw+g4cV3ddvkoPt9k50siQpK44NVLFtEpgirHkKVE00QzSqxWlC0rSNlzxVSrC/
         50GoRwjy4O4GJtIAxYUq+HQo/YnOMniv7/W5zWny/pt6lJDtFwuOUNe+Op9j5o3Ln+DI
         gXJ+Jg8j17OtWa5o2lP3WV8EBc9YQ6i82JiWXvDptZHP2xit8E3wrAxDTlSxf69gpX9L
         u6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqMfR1Es76RCsHqywlPMAVvW44OM9sD5Fmctm4qVWhhsKjIrAe/wRwPZWsFPMpE+541POX9kctW9OdjwTdeN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEipqFaDCAYWaqmRnkpeUJ0LE7QaY/jsFl6EFfQhfgrWzLtRY5
	by48fkRqRWChTUUb5+J26Gmq2JEa1J/xc+aBzclRIWa0gehQJxag5Ai4/4Z5G79oNHhiwI4toT8
	VH14c2uaxSCjAazpxkgr7aoopsk2EmruBubayzbDaiwC6XlWmKQqU513eKSeUBBEdPg==
X-Received: by 2002:a5d:58d4:0:b0:37c:cca1:b1e3 with SMTP id ffacd0b85a97d-381b70f070amr9224349f8f.41.1730537365768;
        Sat, 02 Nov 2024 01:49:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+zLUnEC74BdsijZOr1b8YSLU7XQEs3dlPvpmKeaA99iIyoGz58ANXOMvTYvZenuUsyCqfxw==
X-Received: by 2002:a5d:58d4:0:b0:37c:cca1:b1e3 with SMTP id ffacd0b85a97d-381b70f070amr9224329f8f.41.1730537365402;
        Sat, 02 Nov 2024 01:49:25 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7c13sm7598384f8f.13.2024.11.02.01.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 01:49:24 -0700 (PDT)
Message-ID: <141acc87-19a4-44b5-a222-3f159835c711@redhat.com>
Date: Sat, 2 Nov 2024 09:49:23 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] net: ipv4: Cache pmtu for all packet paths if
 multipath enabled
To: Vladimir Vdovin <deliran@verdict.gg>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 idosch@idosch.org, edumazet@google.com, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, horms@kernel.org
References: <736cdd43-4c4b-4341-bd77-c9a365dec2e5@kernel.org>
 <20241101104922.68956-1-deliran@verdict.gg>
 <20241101064511.1ef698db@kernel.org> <D5B0U1C0N9JC.3PXNVEEH12786@verdict.gg>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <D5B0U1C0N9JC.3PXNVEEH12786@verdict.gg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/1/24 18:34, Vladimir Vdovin wrote:
> On Fri Nov 1, 2024 at 4:45 PM MSK, Jakub Kicinski wrote:
>> On Fri,  1 Nov 2024 10:48:57 +0000 Vladimir Vdovin wrote:
>>> +	pmtu_ipv4_mp_exceptions		ipv4: PMTU multipath nh exceptions		0"
>>
>> This new test seems to fail in our CI:
>>
>> # TEST: ipv4: PMTU multipath nh exceptions                            [FAIL]
>> #   there are not enough cached exceptions
>>
>> https://netdev-3.bots.linux.dev/vmksft-net/results/840861/3-pmtu-sh/stdout
> 
> Yes it failed in V4 patch, in this V5 its already ok:
> 
> # TEST: ipv4: PMTU multipath nh exceptions                            [ OK ]
> ok 1 selftests: net: pmtu.sh
> 
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/841042/2-pmtu-sh/stdout
> 
> But in V5, there is failed test, not sure that this patch causes fail:
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/841042/31-busy-poll-test-sh/stdout
> 
>>
>> Also some process notes:
>>  - please don't post multiple versions of the patch a day:
>>    https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
>>  - please avoid posting new versions in-reply-to the old one
> Thanks, will keep it in mind next time, sorry for my ignorance

Some additional notes:

- please do answer to Ido's question: what about ipv6?
- move the changelog after the SoB tag and a '---' separator, so that it
will not be included into the git commit message
- post new revisions of the patch in a different thread

Thanks,

Paolo


