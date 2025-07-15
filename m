Return-Path: <linux-kselftest+bounces-37378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8584FB0663A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 20:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3894A5B56
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 18:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3AF2BE7C2;
	Tue, 15 Jul 2025 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QERxyvXK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0242BE7BC;
	Tue, 15 Jul 2025 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605051; cv=none; b=q70vwet9cmlNd/6iYIHhUfhv6Jo0yZtgpvgyejjxxydaSLSDoshpBufpJ2p20wmNkcIgrAalTwwP+bwm3RQIMDZcH+mZQYFMFtyQHPNzrkoxVNlcGhkSk5CTNWKPTn5AYs5kH5U0t6jPz2b+aYaK0tU6Yk7JaSGyaE4ceBV1I9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605051; c=relaxed/simple;
	bh=twWOPRV1VrI1CbE4bPlKOZMQQlUM2qrAKjqbKz0yFKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=muJL3X8peba17cNTUkHZdqOQOhWGkcye1/HD44/GFKtMtDYEhFc6NulOEos1rWB4YIYHOACT/03/4ILpn2RXyxXkC3j8wvbQSnaLbteubbOol3WM5gejJhSBzVHayeoFeomvYhp+2uQCfoSuYmRHshKwXYTuPKpvDTLJoARw/3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QERxyvXK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234b440afa7so55901405ad.0;
        Tue, 15 Jul 2025 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752605049; x=1753209849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0LOyHt+XL2N6UmEuuxxL750YkILL6EjfbgiY3+whDOw=;
        b=QERxyvXK40vwL6PrWlWupYaZ3nVRTlzuP9tl2h9oMBY8nmxKf51JqUfjezkIp7qY6k
         ygcmNLd+1pF2QyWscNj3pn9M4h50BU6jQBqY6O4cvFB89Tb6UteQZ1DTkpqd5y9o7BG/
         XvJ9jxncpPkGLAKHlabzfPYwevG45iDu8NteAyBUnJ0QipG/2JJIikfRriHfLLCwznWn
         bri1XAkjBgI3MQHG1QzobQLGDmj6Rpu9GXMHuOoFUYQAFlv5AGGosXfSP5S/0QpWacV/
         q7ArxXklKGz4Hi0NLhSZf0acXUoxp/QaoNFlfZ+0psijVrAV0zS7X5O4ypT3SEtQhVV3
         p2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752605049; x=1753209849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LOyHt+XL2N6UmEuuxxL750YkILL6EjfbgiY3+whDOw=;
        b=TyplgO8sA9dV1zolOSjDpMqgjp2hNquWDDzKDEOb9h8kd+/ACWN4z7Fx7qhxqQJ9he
         4MRhnWIfD5CjIXXcqgBggjIwi3IdvCDnRJce1z2Na96zc+wFS8kjtIkeNeHhi2vAhtia
         RPSPSd4tLGtamShldQA+y63Rk49GUWrTQzhHSyxOEId/Cp9sYHZL5zAq07N15gBoCWxE
         /75SOHUWT2UqrgzupUDipfGijIizQV80A7tFkHEKowUapYIJ+7CytZQ2KEpkilRPCHJS
         ku6cF49fZpM/lod1XAcSQYiUud6DzQSgz+7S52tiCf5zm364Ka9SzYQEKWEqfD/gPI86
         rveg==
X-Forwarded-Encrypted: i=1; AJvYcCWdBiIPpoX9NDXtJS5UbQFQ5wFsCt1N+xHQg7Lt6YuwkikyT4bE0NI6A1NVn8JufDvafzU=@vger.kernel.org, AJvYcCXsoSxjLyCideuLYW4/DvWifyJTXP4ffDwVCExSOiAXvEzal8UFaY+EBnWtOOnrJamKgA4YU8+cFN3qvGn5cGZC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9x7me1A2TnJK8T8D7f6Vx229VR9TCY6cmO9/h3jxuwDmYAJWN
	t9yHxJLYnYQWo3yCE4oOd0tS+fjoRLkn8v7zMs6FaJwIPJogWxWBglnl
X-Gm-Gg: ASbGnctr7b5MrJwFXLIq5W3pIXdDHAYmz2ygwWSQp8wQ9ivmFoxGjrXslHKrhqMKJg+
	ixyVep2wSFJJTukORbGP8GBD2Ifu16NzCwfnpLZheLPsoRjFkHgZZUa1GKuhtk7c7zivRf3IqF0
	UWxG+TsSyeJhXri+HPx5wbjjM0fBMVDh9tUdw7iHAZ78fTazt/Q9ATnscDeqeIqTWf0uqS8Mm9Y
	2CoRi+tv13cHpYUkQ424gqv3/H0/NFyUvObV8TlQYy8f60IhfcEf50QqPGEXu4M4e7CbsDuoOEY
	Pol8+1P3Lm7oulGDqH3ygXkvjtjtZoz+AJANrFSaCEcgGbMqMlnaVHQG8cHzYlg0n9og1ZAyisi
	sPT+zty/cTeJ+9IBKVlhfO7nhiS4aM6hS0kKq+JIduf2j39rm72QIEXDKYR3e8rTbVNtUDbY=
X-Google-Smtp-Source: AGHT+IHgebwkEPA1b+HkridhZ18lk6t3YqEQprjL8yWy4rNgm9DyD80y86tQG+qvT7Cm9uSC1+PN9w==
X-Received: by 2002:a17:903:2287:b0:23c:6cc2:feb9 with SMTP id d9443c01a7336-23e24f55e49mr721515ad.45.1752605049379;
        Tue, 15 Jul 2025 11:44:09 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:84c:7dc6:2679:4c65? ([2620:10d:c090:500::5:31e8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e0debdc32sm40495595ad.185.2025.07.15.11.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 11:44:08 -0700 (PDT)
Message-ID: <f0bce278-4162-4003-bd60-072f7360d452@gmail.com>
Date: Tue, 15 Jul 2025 11:44:06 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V4 1/5] net: netdevsim: hook in XDP handling
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, cratiu@nvidia.com, noren@nvidia.com, cjubran@nvidia.com,
 mbloch@nvidia.com, jdamato@fastly.com, gal@nvidia.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250714210352.1115230-1-mohsin.bashr@gmail.com>
 <20250714210352.1115230-2-mohsin.bashr@gmail.com>
 <20250715134740.GA1341824@horms.kernel.org>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20250715134740.GA1341824@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> +	ns = netdev_priv(dev);
>> +	xdp_prog = rcu_dereference(ns->xdp.prog);
> 
> I'm somewhat confused by this because ns->xdp.prog doesn't appear to be
> protected by RCU.
> 
> Flagged by Sparse.

Right. Thanks for pointing out Simon. I'll fix it.

