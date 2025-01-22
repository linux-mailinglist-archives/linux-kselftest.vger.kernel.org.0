Return-Path: <linux-kselftest+bounces-24905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93253A18906
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 01:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1703AB6C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 00:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72F9182BD;
	Wed, 22 Jan 2025 00:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="J5hY5fbW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2D2249F9
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Jan 2025 00:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737506396; cv=none; b=Ce9xkKv9joBzxeSQHIgYEXPSu3YN975d1hXE6AkqrOZtZ4K/2uYWqsY/Jxcm3V9azdLITcOk+5qCtXcgYBCSJ1OVd3BvPzsSTC4/ClDetM5J320kbkmEiY8a87APeHdul65Lqp5Hb6pgDLItt6b4Zlzu59Fn/mrJfjbLBuj1DNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737506396; c=relaxed/simple;
	bh=SdZKzYOFjcvJbhaQdbT4IeimgpWNHjtjCmLbXbxOSjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvVpjmkZMVzMuO9ttsGm77IsmSrUbeEWWZpM9ukpQlHzXweUb8hMyft5TWf55uWQJ8kbWHz/x8j/JaQORCxeB2EwV5QutDp4Ym2k+cFgln+x+BObd2+B67BojG895b5HXLXF0xmzRZmq5vSN4bQ3DUZNs4w7cKBbSm7rcKTjjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=J5hY5fbW; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso1235890766b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 16:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1737506393; x=1738111193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xe4seuHvx9fyPEV4EIFNjwpAMDzJSfbeTTxyvfVQ/2o=;
        b=J5hY5fbWz6NYbIFOuVUMbjVajmDfl9EqXZJdTLPrfIA5PyJGiTXEO3VFgZWlj7C+Cu
         Yh3ufSgexafnvB2xvArWvdiIO+u2cJUtcisN2/oVFP+ZsN7miG3uTPnzk1aAxR+FLoHp
         HD33q9SozlERDgn2AJI4q4OAGRTprbNnW7AwiLu5Bx37z25R2OwUwHoN/P2J8cBOyBdS
         /JsGAIK3FTF/dEMvxbh1qfoUtYiiT3heHvh4OPGFlWk+dzWOt/KEbJJWqEqLvcdwG8mQ
         tkb0lSUVlGslNmRXdF96BgT9fBzhj88OVKU5i5DTgwp+vaY8HJRk7AevW06sQQpw51U3
         iXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737506393; x=1738111193;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xe4seuHvx9fyPEV4EIFNjwpAMDzJSfbeTTxyvfVQ/2o=;
        b=e4TpB+HClg9xhQq/fYoTt1NydYnmv79HT3vbUDRtz2zKpf+Ik+rMIn5/uQgBkY9F5Y
         LGk3MlboosJ+cRr4J1kSHedPchscf2KiqoR3+3a62dy+7ZqkhKmd3kn7c2HB8mxXzZq9
         XmoiqJ638bnomrMIJ/q1Q/E9dMIeyGqjQQgxvujdszBthf1hkfsSWMOt2OKqDEpxp9ky
         wqIEeFMhTanvWpzTz77P4tvxR1czOVxpesY/PXFRX7j0kKxZgonK5kGJy0RugcZd2OGI
         kL1gyNeO36s/Ld7PYsCOSgaYJxfcKzplbko3ETc4L6i2ST+fLjNinRGFQthd08CHCRfv
         xmIw==
X-Forwarded-Encrypted: i=1; AJvYcCXI5UCKtJn8xq5c6qf1xWnAD3gA+ePErK3iLAE4vQs8KsIzTBdmbSOqJzyh7qAQl9P+iDnDUtJm+Hqkmh7xo6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZyOx1HhvmwG/eO8Eptn5oeQQPHBSuLBZpEt7l4kVRNCX34Xq1
	eb1HrV98RXmoVHeOCLEvWvrh2UeVc8mykY75LR2Ppgr7bgn44mACzmNHAgEpFXQ=
X-Gm-Gg: ASbGncvcnf/vOgh6UkU/JILBjqaycNB9eoDPZ0B6O2LLcqpqPnxvLH/WRiRjYBn4y0Q
	GeFAQV3pDIOOnFYBrzUlSDtXlf0v7wM8IiW7GJj9olzXAlxB47gkH0+BT6O89vrkEgmF9wilPXO
	7QGtVwozUf3zF8Ffv12CHnmVeYq685SoHU/mZyRnxzaRQGQHB/+kXhP1ncYIGP2rAcRuToXC9bW
	la1qRPx31FLOBQkQMlT/FqEFjSpyDD7ZIrPWLygq7xI44Fqp4U2Y9CYhdud/0xlesN7HoKzNa23
	PCePqrVm49TXStBKweZIgV0ABjEawiny
X-Google-Smtp-Source: AGHT+IHwMvg7Jgf3gyg3QM1Kx9E3XAxotqb6sHHRIgnXn8fANxuPm4B1kK/hetMxfb3Gw+V7wK2sUQ==
X-Received: by 2002:a17:907:3f0b:b0:aa6:ab70:4a78 with SMTP id a640c23a62f3a-ab38b44de69mr2046519966b.37.1737506392922;
        Tue, 21 Jan 2025 16:39:52 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:2b1b:6df9:ad3c:c183? ([2001:67c:2fbc:1:2b1b:6df9:ad3c:c183])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dbe6de509esm1159790a12.70.2025.01.21.16.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 16:39:51 -0800 (PST)
Message-ID: <6f907895-4f5f-450f-8aa7-709625e4bb25@openvpn.net>
Date: Wed, 22 Jan 2025 01:40:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net> <Z4pDpqN2hCc-7DGt@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z4pDpqN2hCc-7DGt@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2025 12:48, Sabrina Dubroca wrote:
[...]
> With the delayed socket release (which is similar to what was in v11,
> but now with refcounting on the netdevice which should make
> rtnl_link_unregister in ovpn_cleanup wait [*]), we may return to
> userspace as if the peer was gone, but the socket hasn't been detached
> yet.
> 
> A userspace application that tries to remove the peer and immediately
> re-create it with the same socket could get EBUSY if the workqueue
> hasn't done its job yet. That would be quite confusing to the
> application.
> 
> So I would add a completion to wait here until the socket has been
> fully detached. Something like below.
> 
> [*] I don't think the current refcounting fully protects against that,
> I'll comment on 05/25

Sabrina, after the other changes I acknowledged, do you still have 
comments for 5/25?

Thanks a lot!

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


