Return-Path: <linux-kselftest+bounces-44950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D58FC3AB4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 12:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86725465504
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 11:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A643330FF28;
	Thu,  6 Nov 2025 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdEyq71R";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lnvYLxbr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7353330FC20
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429344; cv=none; b=kDNhPEWtjg6fVzYx0tMK/6Azm+OTFMrL0iMH0BNQHqRxUaaw/CiG8pwhNM4jg006b6PcAku7NtB65kItSeVM0ye0WS0n+aVbNY92gKkgG9TO9ON17RV9rbz7pzdYQLw/8y1AapabN8REjxdh+JuOtaw8aGiebxp4L20J2QlFS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429344; c=relaxed/simple;
	bh=skC26cRzfhs694yk1GvmPhOCKjrsCkj5WGjm2V3nag0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YADTbi6BeQjDilr6d9TTkERVwyZILZ6rOkw43v7WNU3P6vbB+hXHgauL4g4pYLwABpQR8+eg2IAHguN6R3DbBZLU7Wx+W3Bnk5VhGK+134EgrAzJDxe26KSEG5iu8a+mlaeXnFEph9z58CB0loWY7I4rK+mhfC7BHtYLTGOBE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdEyq71R; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lnvYLxbr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762429340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yI4sLrgM9n4bdj8hOJQf5//skDa3nIIok/oPWCQb8k=;
	b=YdEyq71RCqFAJgz6OBuuP0L5rIylrDW2XGpa3TRB8cM2kg2ZJ16bcBrK4INvzCGmaDRpln
	8NmXaQOf3uBxYgVR9JX5jVeBeqP84tr5dapc66jDyL8We145yR2bioCKhQ5ZSIahoZLoMr
	H78m8atfbyXFd/FhuR0u5QWpSzuK1ZU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-XgG58IQ-NQSqBTUhgDoUSA-1; Thu, 06 Nov 2025 06:42:19 -0500
X-MC-Unique: XgG58IQ-NQSqBTUhgDoUSA-1
X-Mimecast-MFC-AGG-ID: XgG58IQ-NQSqBTUhgDoUSA_1762429338
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b70b21e6cdbso170621866b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 03:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762429338; x=1763034138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2yI4sLrgM9n4bdj8hOJQf5//skDa3nIIok/oPWCQb8k=;
        b=lnvYLxbry/U9OU0LBYf5XlgU6ioCAzO2geBEsRSwpVkyfcxFo7PB8igo5pBex/t5Nr
         mQS76EBVyKHa8HMEf/zrL6c2Xm3dSs/KDGQq6F7gPC9gGvYCeeKrZmWb1flnQLlJVCgg
         zNgxJ1f6ZccUjKsUp9lZBqeYMLuy0szITyR5laghUJdL9Xriz2uMUE8/Tk/mz+20mwFV
         OL/zZ5csXkRH8Fz1N+n4qz3pnbBiRq0CtcOjOM4Ni5nhQbirr1gY3c4qUGWWobimbozM
         lz+vaURRuW6IbKx4uzcsglhScB2ybHUKjqSsIboOMCtl/5HchlUHgN5H4I9LtFYxviRV
         YK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429338; x=1763034138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yI4sLrgM9n4bdj8hOJQf5//skDa3nIIok/oPWCQb8k=;
        b=BUF5D8ynfurERpdJYX4hyW1Dyd9i+ivEnjtGHrC00kjLH2HLlEV/ozjUPK7UQtmexK
         8qDUqlw298wc9jfIiS2cKt/Ucwdh2YzD5JoN7XpcICYVqL8vhePAZHO6TmGaP4CensE6
         cFxkP/gWc9NqvhU92N/sualpe13pBfGaxsHgblOBk4l97zAjUQAQpUDd4/dd9iq8AhpR
         3Nq0BJzqw0heQwHuUntf1fnrC9w1wKyHM5wkQEkTd5uSd+ZIIHtnJvN7iMGAZP0xICbF
         9bsVkwsyC7cvo7e3K2jtDYc9zdiEFfC+G7DI8hUAQ8GcA2Pt8uYSypzk4aS/YJnFV1Lx
         FbCg==
X-Forwarded-Encrypted: i=1; AJvYcCWRYQhajovwhcw//nS4DPEgwZU1PkK8gSA3JozSKVt9Fk4v/S6Wv9FXRDMk/x9LkMMMGn/KwBTxDZED43KtZU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGD+vm9cvnvN72BGlOkpj1qhR6rbORdsy+q99QV2p4NGJ7eOE3
	EIQGqYk6pTRxFvNJmZs/b6tXe0ArVbcERBeUCW9JdCZge14SOhaECytCZKDRcK4YjLc7pbnRAkM
	6dcW8AgWEUjBHdvGlBSIEvHCDIEfusvGUuxb2qNCWp3OVhCOfR/M6f8T6bnhKiX/lyDRMyw==
X-Gm-Gg: ASbGncvG49Vc2BzPEZb86BVs0tNNYnMrwqwMFjlp8etTbl9HNe0FNrK62H+qTtA3vwC
	yETHIwL272Hzr0lGYm/kqZ0mIOWEXhGHaWeTgUf1nViE4qy/ViMN1WQ4WEub2SCPDT+6a0vC6FC
	Ia8TNWwoMw6gZH+PDdyDVIsT9kwcbGfdNfJdApvNJgb5J+hwh1y+kjPNRbx2rIQ3ohmzI4AqUAg
	BTSMmJQjXGB29ISuTVe+TqIBY+zfUIytqClsmfuuSyDxO3j4PL13d8aszkckacWWzGi09MKz6BC
	MWXeaW2r4vXYlhAogJApmB+OdfmalefNTj8xzNXm89XETZuy9KXvGYDhy7vyuuLQH/bWEvWG1GR
	IBQ==
X-Received: by 2002:a17:906:f591:b0:b70:c6ee:8956 with SMTP id a640c23a62f3a-b72893d8e8fmr339802566b.12.1762429337685;
        Thu, 06 Nov 2025 03:42:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOB8p8VKAkDWd7Zb5ZOoLgXt76WYCHhozdvWiOM8SoWc4iM6IK84Od+ej6rTPGojaDwrxUhw==
X-Received: by 2002:a17:906:f591:b0:b70:c6ee:8956 with SMTP id a640c23a62f3a-b72893d8e8fmr339798666b.12.1762429337263;
        Thu, 06 Nov 2025 03:42:17 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289645397sm194955666b.41.2025.11.06.03.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:42:16 -0800 (PST)
Message-ID: <aeaa5b5f-8697-4431-82b1-c890d67ebd41@redhat.com>
Date: Thu, 6 Nov 2025 12:42:14 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 06/14] tcp: disable RFC3168 fallback
 identifier for CC modules
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
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-7-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-7-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> When AccECN is not successfully negociated for a TCP flow, it defaults
> fallback to classic ECN (RFC3168). However, L4S service will fallback
> to non-ECN.
> 
> This patch enables congestion control module to control whether it
> should not fallback to classic ECN after unsuccessful AccECN negotiation.
> A new CA module flag (TCP_CONG_NO_FALLBACK_RFC3168) identifies this
> behavior expected by the CA.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


