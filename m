Return-Path: <linux-kselftest+bounces-24704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92780A14C83
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 10:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA3A167E77
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 09:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012D81FA8EB;
	Fri, 17 Jan 2025 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+nbsboR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A77C1F9F72
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107604; cv=none; b=bPUhZgr4jHBFXGGJgc2VwkND5wdC/pBCKt5Dl8KHJ1YdZYugIuG4aSfINetEv31LH36WmVGPd80OXVxUS8A7UVHSJ9i+/QkQdK5o8N4TIEafyHeybFrxDWYDeJ0WcNqw8W5uf+dGmv0oMC033NcborRjfi4xDB/3foaxLSezOSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107604; c=relaxed/simple;
	bh=wkqSQHHnSgWe8OyCfRNa5E36/ta9z42ihBs/LvONaJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIXhhOnJosuXahEnpgxYkpepAAqfeavptFSkJOvGslTf9XfdBMCD7SaOHbcanbKb76z8iVYizQ4h8ENejF8kWscGQpeMajgsowS4VTBM8YJ77ZffrSrv9jaJdqyou+jzhGwrMoai99gkqVSNcZH1GOYwD5lRGyi/mbgXt5ldjCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+nbsboR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737107602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+ew9wKee4sfaNGy1/K4kJ/YCvyFpDgRZHFUYgrCC24=;
	b=V+nbsboR/6g4PQEtvud2PmUh8KQqiH1Ow3KkR5qgDq5rOYc4PL3dhaSsfnrCPurD2JD//B
	yVN/3WfefkE+MJMUqpCLiyPyVgEW2F5BwbezPCPq9GHmbQqq29InSF0Nu4AK7oWa3zievm
	3mX7FWYifvs40hjVzWsW14Jda/ITEtM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-GvCqvBDKMuCslF-WCEdw5g-1; Fri, 17 Jan 2025 04:53:20 -0500
X-MC-Unique: GvCqvBDKMuCslF-WCEdw5g-1
X-Mimecast-MFC-AGG-ID: GvCqvBDKMuCslF-WCEdw5g
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43623bf2a83so13509825e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 01:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737107599; x=1737712399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+ew9wKee4sfaNGy1/K4kJ/YCvyFpDgRZHFUYgrCC24=;
        b=vTtX3VqFzAFV1LaRe4YrT3Uvc4+afXNYXBSWTGk7EuXuyfi2626OWcyKhXkIsWSRuO
         Kv807uJ4IyAV5SFA+nQiRiLCR+AgUiANL26h136uJPuxMxhgPNsKG9hWKOw6/3r9jSKc
         aC3Z2gLtQA1TZqgaQbAObXsVU7YYkAVEd0El8DzPepZDKRugmS0iUV8/DXMCg6X3UYgg
         6eQbn4b/7zTCC19w2oxaq24vfYoncnSNdtS4Lzmw3LBPI3UhsCz5My+hZtAY+4D1yyc9
         VN8RlV/pGu9XdZVjv6yzP0jIgE3b7LSWWSivnjPjSfxSYJR8S1oqW6Q753rE41yp0aO0
         cLYw==
X-Forwarded-Encrypted: i=1; AJvYcCUfV/oJGHWgeCyThSh085rxtDGYIWeaRJsiWcXuX4eMEIiJ9hMHjY3PlW/s/cd4P8M55veDI9PhXSfLBcwAJhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym9bthR6bzhyiE333Otoz2zbwVO9npwpfC2pRWKU+YpmyLr545
	MPH0VTKWnZ2qKSPXSpMxCt4DEmjfFUVFl/nvUhMqrqybj3Fo5cTXYrHRgWj2639bdlhE/AdRBUo
	WuQy0OxqH0SXJbNZvHiDNV0siXoBs7LJyxSUl0KWhhVG7EYCDGuaoxM5N29Bs09dJJg==
X-Gm-Gg: ASbGnctcUjD/dWht5tP5rVQ8Zm39R1LWxfrjGJverdfZdMLo+p27iCVQ0tHQ5OHxqIU
	3NuRkUshcEs+I0Ie9sUziBKsreD+R99kJXzOD1fnkFl+Ea/8e5bjrv8sfrcZIpCVEdHRSb503Us
	Axf2nFRxLsnxiS61AL8mztgJtItFVjXvsbpKGo5lP21pvaLjygrQbQYWxDw3fYNpk6xbRx78wO7
	hJX4HHYWtSe1r2DvaSldt1OOkwzsDw+HBcDpdZBQ24B7tVTO2HHdqIjE6QSO0ktARhII2S2UDAV
	GJnpQYS7udQ=
X-Received: by 2002:a05:600c:4745:b0:434:f7e3:bfa0 with SMTP id 5b1f17b1804b1-4389143762fmr15732675e9.21.1737107599468;
        Fri, 17 Jan 2025 01:53:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzU6WepQhjIRl/jgjirjFlM2R9uSiD3Rd0d514gYxz218HynUrVX9eewi+TChtxusuHMrtow==
X-Received: by 2002:a05:600c:4745:b0:434:f7e3:bfa0 with SMTP id 5b1f17b1804b1-4389143762fmr15732405e9.21.1737107599111;
        Fri, 17 Jan 2025 01:53:19 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890413801sm27294795e9.15.2025.01.17.01.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 01:53:18 -0800 (PST)
Message-ID: <262b5dce-eca9-429d-92c8-205ce27e02a1@redhat.com>
Date: Fri, 17 Jan 2025 10:53:17 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next, v5] netlink: support dumping IPv4 multicast
 addresses
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Hangbin Liu <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20250114023740.3753350-1-yuyanghuang@google.com>
 <b7305f0a-fe4d-4dd4-aaaf-77a08fd919ac@redhat.com>
 <CADXeF1EiMaASLhRiNMEeXmUUT3dXhhbasOeReaNy=nuVwa1agw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CADXeF1EiMaASLhRiNMEeXmUUT3dXhhbasOeReaNy=nuVwa1agw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/17/25 7:56 AM, Yuyang Huang wrote:
> Hi Paolo
> 
> Thanks for the review feedback, I will adjust them in the patch v6.
> 
>> Why moving the struct definition here? IMHO addrconf.h is better suited
>> and will avoid additional headers dep.
> 
> The `struct inet_fill_args` is moved from devinet.c to igmp.h to make
> it usable in both devinet.c and igmp.c.
> I feel it is incorrect to move `struct inet_fill_args` to addrconf.h
> because that file contains IPv6 specific definition and it also
> contains `struct inet6_fill_args`. After refactoring, I will remove
> the usage of enum addr_type_t type, so we don't need to import
> addrconf.h anymore.

Do you mean that in the next iteration you are going to remove the 'enum
addr_type_t type' filed from struct inet_fill_args? That would be good.

As per the header file, I tend to think that the better choice in this
case would probably be creating a new one.

/P


