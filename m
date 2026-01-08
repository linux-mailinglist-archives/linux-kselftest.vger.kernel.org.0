Return-Path: <linux-kselftest+bounces-48472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7764BD027A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 12:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C862530E6301
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 11:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACC43446B5;
	Thu,  8 Jan 2026 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBurWId2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0ZaHClA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2157033EB02
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861716; cv=none; b=PJ6lIarnJo7zC95o+r0AVBWDf2r9EXClW8ePv9I6pV3WUCPVB/K/W9lOHkRIotlwEFNrkfqF4Jk595w8PUgpBh59F4a0xnFy70XdNO/qPYlv6vg6seqYqThTB3BHAhI2tz3BGTaiXjdUzWcSSnaliqocCxjW7kvU3fglzRg+NOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861716; c=relaxed/simple;
	bh=T3g1hkv59Wof+KEXGfr6rRK1rS6rPS46Y5/WRoZTizA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=auwxx/aMgMcY+xJ1671SZCHfXkQlXL+NZx89GgWlvVemdNIah9Ht3uQgHpNQDGx4I/SYk80FectZiC2Mu8mCuK+aa0IYMDcHAiKvf1z+Glhk6Uomaos7irg/U1sbrxJfniu94qPwSr95BzLkJv30bQ2SVY7HfJVwjsAGvHhiauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBurWId2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0ZaHClA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767861703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5RGxvIn5fQFYR3/ngtCtv4UC6h+IZmTY0D3VzGMTF2k=;
	b=VBurWId2HqDrerkVnZFpzr+u2oijSKw/y5AwinLgSSqHcGcgpuwRuA5rqmcZWF2crUSpTe
	RgcDPzslfnlUj/2Hr/2KycWtH0/2yuS2lGUT6xY69D3DF84Za6K3U2G1Z4229diie6+XUQ
	c2Y1jJGUlznxQPsD4sy68uJajZBycuA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-U3XrNKBoPRetWvXfsNTyIA-1; Thu, 08 Jan 2026 03:41:42 -0500
X-MC-Unique: U3XrNKBoPRetWvXfsNTyIA-1
X-Mimecast-MFC-AGG-ID: U3XrNKBoPRetWvXfsNTyIA_1767861701
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477964c22e0so14115345e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 00:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767861701; x=1768466501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5RGxvIn5fQFYR3/ngtCtv4UC6h+IZmTY0D3VzGMTF2k=;
        b=H0ZaHClA6c3KoNXD+3tXrJmCoOMCR4qT4eAFmnf2dOeabJW5fsJqAWfno/Hnr6IrJF
         PZsl7U0+3YU3OI4CFlEzjkH45/HO0+BSrGX9ycowVi6hz+rbrBz7lDIeSMLATjJQ8fpj
         4bcunlq7X/5aKBSUWaT5w7dl3OVtHYcGXCexzwle5no4JMZ2LS/+MjdiFTy4ANdhEH/D
         EyZTVPMJdL1rs56ukgozYGLyIfpVz8OLhjT6Pu9aHsf61+U5LHYQAbpy+Mb13jGJg28V
         njkHf0BGhtJDYMe/xcmy1utfrDHkmj/67hrPfw1S16/xnMmMbWsfk3Xjx2at6abqluqP
         Y8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767861701; x=1768466501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RGxvIn5fQFYR3/ngtCtv4UC6h+IZmTY0D3VzGMTF2k=;
        b=psr5gd1p7PVYXd+ZnTmHSI/z4zv+CWjYSq1eO0haI+16z8J80y28hWuUHohSmdlkTf
         r6YiECurcESn4PiHkScSiLf9BdiKFy6Zft8FCq7pqjqGmBJjKACPPg7affQ9K8TJhmsB
         wGpXPPbojTrL+dnIQu8fMi3OWCpLmr5o8+HdrDNIJRtyWz4JjDb2ULFgH4bH43ahByH0
         F2gHz2kXh2t1xShgHBZP3ILX2BbIV+WSGAingmS2t1BvHq3xeA+tI8RkDjcK4eE6jW3m
         oCY6B4HAMYWKUGGMJLVMPiC82wi0hqmArTbIGQuyO+soRmX6bwIgEoUX9P64uEXbaUKT
         yIyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ509PC7P7uIm+16MLky59rICq7zQSZl9gDuYKBc5neK6CLriVxrZ9luaQb6+RBVAc2z8WlrbxFD2rD5CHgB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyShPWqFFx4GJKhkt+fBmS9I+sNro48bDEq8cr+AygrgqxPofgl
	UoTgmVpZ5d/MSLgJZBs9BYT/xqE6p8qllRDm1ZmIdTpWeCyhVqv0lRJFvzUNbD/rOoxs19oIBE2
	al/JQC9i/Bpl8XzZ8d4ifAa4Pjv2RC3MS88tYm0hjKHqkbLiJpIC0pBf2Rqj5H+NzBMEZtw==
X-Gm-Gg: AY/fxX7xXmGbjShcP4fexgtBrdXjSmfOKgo6INqtUEGl6JDrzCOn4vO/Dv3RcXDmXSu
	oQ3zxv0yZgU0T0MCD/0Z5y9Y87BE4HUzthSXoq7WJUT+PjZS1Q/bGg61ida20wLak4WO8iDFtrt
	G2yOA6ra6iXWOkxZx3AObEjoToNtg26f1Np9v+SxmZm3O6VZU5jnM1oT/MUnjf6eCFtRF4pqiC9
	eYbjtm4gDtlfA84/cgknNxCc8zo5ou6wBNLnGwcLoaihLvzlbTwBA70mE0qaVLtE8epmXaJL42H
	skA/wVitRvNWxBSIWU8F5uFYRg9n+h2WwUWX693s39b+2RQr1UxB1oPyUwAtzUF5zmtX6I+rdSj
	C/E+fJUvt9RK5FA==
X-Received: by 2002:a05:600c:6749:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-47d84849fb2mr69624155e9.6.1767861700983;
        Thu, 08 Jan 2026 00:41:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMRmXfUT8h/fx23p3HVnSIevvQ/xZpWdXJvjJswXBBTxuR8fZK2hfXFsrWgfe2gcekBcZ2PQ==
X-Received: by 2002:a05:600c:6749:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-47d84849fb2mr69623615e9.6.1767861700621;
        Thu, 08 Jan 2026 00:41:40 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f703a8csm139970835e9.13.2026.01.08.00.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 00:41:40 -0800 (PST)
Message-ID: <56f6f3dd-14a8-44e9-a13d-eeb0a27d81d2@redhat.com>
Date: Thu, 8 Jan 2026 09:41:37 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 00/13] AccECN protocol case handling series
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/26 2:10 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> Plesae find the v7 AccECN case handling patch series, which covers
> several excpetional case handling of Accurate ECN spec (RFC9768),
> adds new identifiers to be used by CC modules, adds ecn_delta into
> rate_sample, and keeps the ACE counter for computation, etc.
> 
> This patch series is part of the full AccECN patch series, which is available at
> https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/
> 
> Best regards,
> Chia-Yu

I had just a minor comment on patch 11/13. I think this deserves
explicit ack from Eric, Neal or Kuniyuki; please wait a little longer
for them before resend.

Side note: it would be great to pair the AccECN behaviours with some
pktdrill tests, do you have plan for it?

Thanks,

Paolo


