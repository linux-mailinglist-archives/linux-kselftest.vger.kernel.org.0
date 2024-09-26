Return-Path: <linux-kselftest+bounces-18387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D9A986F80
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 11:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B4B2832C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 09:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB3B18BC21;
	Thu, 26 Sep 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilYAMrmW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE84610B
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341426; cv=none; b=jpOUzBJVlYUuveUCaySBLv9dDATJU3/2ZHVEUhpjs89lI7ocS5s5jTOhScrDZ4sLYKA4see9xVw+Nj48fF652ZF3ljiMB/lUNKQEC3HW1RmyoZZ3T9l+1hcyfTpbqNxmfrd4fME6j0BGmVuhyCWCXApOQJMIc5D35n3qEnPnHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341426; c=relaxed/simple;
	bh=5b9mweUAaDSj84VvXz+F6ZWoArtYwfW0voyzXonEC9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSHdcGHjwn2e90+aPEkT8PVSfu3Ac+lGACXvnh67Lkhbo1gxpHh7WGumNM+JpxevBqHsdQmCB+Oi24bTqCyWddIzvEe+EJcVeFnOguaaX0U6gcbuzCxch0dqvg/N3tlbfwaIryB0azhe/wupc1RbdecRrpNeGbzymrzXGsbhHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ilYAMrmW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727341424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeYgnZ1NLeFfc15a27WcTDPKUY4Xom7TLrWj14jy8pE=;
	b=ilYAMrmWqoWjzZNJhDWWWojwONBr0h7DsFcx6Z1gm7KrIeaN5G5x0D/aON/MCnoAqb5mAJ
	SuNlOXZAzF6+Q7KogUT53vrcwxERRHW6R5TP7EZ1lGfbTC2kSaN26um39ThZDAr33J8SLq
	xZs1MyosyAikFYX0W7muD/I20rDThdg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-_9egREInOJa2QbQKjX0hgA-1; Thu, 26 Sep 2024 05:03:42 -0400
X-MC-Unique: _9egREInOJa2QbQKjX0hgA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374bacd5cccso351709f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 02:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727341421; x=1727946221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zeYgnZ1NLeFfc15a27WcTDPKUY4Xom7TLrWj14jy8pE=;
        b=PrZnxRg4a9xCgp4/4XirznL+b8eapu0/BHjUHrpPpNOKSgV7sYr8AC47mF4yZqQKir
         VoHgSL/NMxa6p0kaSghceepMCNC62ta5eF1/QYrDib0TpiC9C2wo9AYXup0IoyucOAah
         QNA7xqXamaIyuay5X36tVlEjKe/9Ch4A+ndp/Rp5iQ1f2zyj+dYlgJX3lqQX0L39vflw
         wM1qUNG9+6aNjLgwhHlc+rSnt5keGx544/TlgqFYG6ULR4tKEiCKxxaPYG2d0ECuU53a
         Tu111ZZG0cd/HIVpmtl0BL2lgYx0HR7GyjwgE957pl1AMiYI7RjYfljOobGmn1IdWnsQ
         LZsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNW/szdJCe/wz+sZsvyvMTDGZyPssG/5mA+LmZze3wJQrjCGL6kSxRSfjxDFwWiU/Xo5LzaUQo0GpK/xacsLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzibymoFuicFgvDg68/V+f+nHXI/HXvmIsKW4XlqVisLvk5QzdX
	ijHFlxm7BqiUnaj5iHpOP13uqlYpIpl1V12I8F1olrvpet4WOGwZSDiHMrbd4Y3bXbdSWGi/IhW
	wRAaa8VZYCR+o2XuU96WDwjGIlKyCk6ZEuI3NFYPlVUjNz89UYJMZQB+0XPr3U0Dcig==
X-Received: by 2002:adf:c04c:0:b0:374:c8e0:d76b with SMTP id ffacd0b85a97d-37cc245b083mr3770708f8f.6.1727341421616;
        Thu, 26 Sep 2024 02:03:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk2ngBr1QbZQb/K4S/LQ0JgJDBPWxzQZCoDjZ0iQBJMVTjcdGhO4Q3QhXtAkiHpVsmTPOlPw==
X-Received: by 2002:adf:c04c:0:b0:374:c8e0:d76b with SMTP id ffacd0b85a97d-37cc245b083mr3770685f8f.6.1727341421145;
        Thu, 26 Sep 2024 02:03:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b? ([2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ccc93f115sm2469665f8f.21.2024.09.26.02.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 02:03:40 -0700 (PDT)
Message-ID: <fd29c5e5-219d-44ad-8403-1abe4015f75c@redhat.com>
Date: Thu, 26 Sep 2024 11:03:38 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests/net: packetdrill: increase timing tolerance
 in debug mode
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, sdf@fomichev.me, matttbe@kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
References: <20240919124412.3014326-1-willemdebruijn.kernel@gmail.com>
 <ZuyR0JuU_H3MvEmX@mini-arch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZuyR0JuU_H3MvEmX@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/24 23:04, Stanislav Fomichev wrote:
> On 09/19, Willem de Bruijn wrote:
>> From: Willem de Bruijn <willemb@google.com>
>>
>> Some packetdrill tests are flaky in debug mode. As discussed, increase
>> tolerance.
>>
>> We have been doing this for debug builds outside ksft too.
>>
>> Previous setting was 10000. A manual 50 runs in virtme-ng showed two
>> failures that needed 12000. To be on the safe side, Increase to 14000.
>>
>> Link: https://lore.kernel.org/netdev/Zuhhe4-MQHd3EkfN@mini-arch/
>> Fixes: 1e42f73fd3c2 ("selftests/net: packetdrill: import tcp/zerocopy")
>> Reported-by: Stanislav Fomichev <sdf@fomichev.me>
>> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Thanks! Should probably go to net-next though? (Not sure what's
> the bar for selftests fixes for 'net')

FTR, we want this kind of fixes in net, to reach self-test stability in 
both trees ASAP.

Cheers,

Paolo


