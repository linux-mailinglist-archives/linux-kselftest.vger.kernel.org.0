Return-Path: <linux-kselftest+bounces-19220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AE499418E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 10:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8F1284C51
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 08:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF9F1E2826;
	Tue,  8 Oct 2024 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AW3gkuYC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871191E2820
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373917; cv=none; b=pwEjHJVWZe3RYZlxQgKwldj6szlgbpbM9yFUJWz/ETrVloBaN61uBJLzQ36SfoDUSXgVhUC2H1Lehv5dmJUlNSKgaT9EOYIQc4uSPMsJwkTrbW6iVrqPvv8+d9zYWFkjlw3nnW+iIvAyu3ACe2Z6rG7UByKOquTLEkgctHxTVCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373917; c=relaxed/simple;
	bh=v89Trsi7SQvRJw0wTpV5EI7wlR5UDgvXEV3fUyW9w78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knHIlGBoPtX+wkkPN01/ZUZzJOtIdz+6Jb/UTXrIfpIcjcmSLjczKdCwO6o0Ry9JfZDqgMrTc6LuJjSn2WmmxkNUnai7Z4/ZRHfTWXVHGLq5zWfIL0Xg0TDAPd0ct3ukp9ev8JwD/sZOVAihAG17zmRpVreHzC47BR2PF5c/U6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AW3gkuYC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cc8782869so54456195e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 00:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1728373914; x=1728978714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KlYY3K3HC3a/CGEPLuJ09kBVSKmQ9xsYiFCNrU9twF0=;
        b=AW3gkuYCQ6vOT1Jn04alFy25pkH3BBkVwudDlJrknjmW6JYp8y3h3MJ3s7CgxIkaMI
         BF2imcPCkhTA+tmZsMxmEIjUR1kFRJmc5+lZSF+gmL7KNAkn7WjLE/hnwZ1Z3suMS9WB
         B0fNOAbmM38I624DTEtYLDCUUBAhooctl2oinWKeH5jx51+sUvigz21Auf8vOUWaz1nd
         MgLdoy86Dm81p3jOIJOMQXb5yvaYXVXC878SIUh48wENhdj6cqpOs8RV/uyVSP0+zWtc
         FLbbmQ/r/CjAdE3iHs18s/W+0YWaoWGPOhbIWpx6eLtMw/GXflNTHzsumqG4q+wT4GZW
         rhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728373914; x=1728978714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlYY3K3HC3a/CGEPLuJ09kBVSKmQ9xsYiFCNrU9twF0=;
        b=nik375z31UizmN3RFXCnsxoFyBkyTArtkOqaw0GZsr5bJ+Kp+oy1SRbYMULvWNZjS7
         LLZGxnZ6VXDbGD5vl98zkWN0UQ4MzBOSm1ZVsT4MQTDlfsA9vnt24z1ijCC8Vg9rgNyN
         oz5wj3G3aDHGTSYwtsEXKr4NesbS836wrrhQnX2USwwh7MrrPUZFrabdWXCdUznyFAjm
         eVW0Uq9GGJ2BmKYXnKZr38daFkIlRutbzrE7vUfMJtAWxT23Palex7Mq2+zn/VZP3Bg5
         TZEN/Cba19siMZVXeKEe3xh92djDJzM9kAI/UcWIfjWqX0qwrlYwt0URUP11g0GqhAH3
         HurQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz0Pzjl4kF0z7x/KSthKX5AgTmM+su8wha0qXIZizmO7BYBNE61H4w2y0epe1wgKnQttjy8kN5of2SPXebQZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR8SP+9fu83Mk0L6tCaoeb+mPqsUYNMSnIjreqihTgvnA3Zx2e
	gdnFT7uIzqeO5UthqanmcJos+Fsygb4hHG8MD5KIWyp6P+d7ucnekvGLtT6b7Lk=
X-Google-Smtp-Source: AGHT+IEhp5R1Yt+tZjJi2fQ9CxGOWVtmRo8DSNdX4sO7gq4VOLAgv39ttch8j+3FuqNhz1X667+Kwg==
X-Received: by 2002:a05:600c:215:b0:42c:b74c:d8c3 with SMTP id 5b1f17b1804b1-42f85b64a17mr96712845e9.32.1728373913811;
        Tue, 08 Oct 2024 00:51:53 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:2089:55b1:87be:76d4? ([2001:67c:2fbc:1:2089:55b1:87be:76d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f9384f648sm39404205e9.20.2024.10.08.00.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 00:51:52 -0700 (PDT)
Message-ID: <2d1a404e-c45d-4ea6-9f95-87364d3f34be@openvpn.net>
Date: Tue, 8 Oct 2024 09:51:50 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 01/24] netlink: add NLA_POLICY_MAX_LEN macro
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 sd@queasysnail.net, ryazanov.s.a@gmail.com
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
 <20241002-b4-ovpn-v8-1-37ceffcffbde@openvpn.net> <m2msjkf2jn.fsf@gmail.com>
 <20241004063855.1a693dd1@kernel.org>
 <e09ea6b5-fe0c-4f90-8943-83aa410ccc1f@openvpn.net>
 <20241007085337.2ffff440@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
In-Reply-To: <20241007085337.2ffff440@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/10/24 17:53, Jakub Kicinski wrote:
> On Mon, 7 Oct 2024 12:04:22 +0200 Antonio Quartulli wrote:
>>> Or we could check if len(self.checks) <= 1 early and throw our hands up
>>> if there is more, for now?
>>
>> We already perform the same check in the 'else' branch below.
>> It'd be about moving it at the beginning of the function and bail out if
>> true, right?
>>
>> Should I modify this patch and move the check above?
> 
> I just sent the refactor patch, that seemed easier than explaining ;)

Great, thanks :-)


-- 
Antonio Quartulli
OpenVPN Inc.

