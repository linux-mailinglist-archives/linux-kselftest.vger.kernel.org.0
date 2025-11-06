Return-Path: <linux-kselftest+bounces-44949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8402DC3AA4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 12:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9021500278
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 11:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C3930F93B;
	Thu,  6 Nov 2025 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNBRTV7C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkXxIvsQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F47B30F938
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429134; cv=none; b=HC+ZXHijpvlcyyTY+Amiw3tiE6Qku8edyqBi9O0Z5SgKsVWtEMIdLq86hmn8dgZYrNwf/Whbh2IC8XbtQPcNwlhHEIRpIO9yo0EK1gXNHlgdKd/o/1lq0PuT9EAty2xZEzYrcgDZf2CuvLb6L887IgjvLlAs8fAdSXYK7DE+wQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429134; c=relaxed/simple;
	bh=1im8cEsSwPU3z1wUcIFZMYr3Hf80GzC/cfDI1HoTkEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHYdOm6kNVD6i6v7d4kv96NtQE9dlThHD9+z0JwYMOzb2SaaheNJOnhnW6xLCCeICYl9zWOGwc0uY+PFaJmZfz74IeByTlFEGOqJoZeAd0LP0t1yZhiiFjF+F5u+oPzy/rWVXip027in3MqeLdgSRwPA8T5oyX4ssemdg1VQxqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SNBRTV7C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkXxIvsQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762429132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsR7dUNbKYyGm3G2Ypb+Ygd27jeSq0CETiTbO/x2Dv8=;
	b=SNBRTV7Ceum6BIanmmbDHOlNoaUjHzIKV4FZHS8lRR2jq7CwOCzV/BXCsr16QxXDbOVl89
	7Xn48I4IepYJlDgUVfJJtg9dSg4dNhJhw9VSnX9MA8MO/yg4etHwSjG4/cz7c3sWspAeNa
	aMtLnM5asj29ymVPUse1JZfCYE6Es/0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-swARgmJEPbmMfOg7Uk8blg-1; Thu, 06 Nov 2025 06:38:50 -0500
X-MC-Unique: swARgmJEPbmMfOg7Uk8blg-1
X-Mimecast-MFC-AGG-ID: swARgmJEPbmMfOg7Uk8blg_1762429130
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471201dc0e9so7592525e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 03:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762429129; x=1763033929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qsR7dUNbKYyGm3G2Ypb+Ygd27jeSq0CETiTbO/x2Dv8=;
        b=CkXxIvsQ9x5e8EpPuwTJUCKNVCnZ2f0k0CWy/W+XEw78HvukKVA5U1U+Vu2WTT1awY
         4PyuuIaPZ57C/0apYFhcBfuOwlglqMbXHaEg5ydS5plXaa8X1U9Enus1QQshy/OZ8WA4
         80LfMFXFnkXVq1MJAGVQ4xkoghAXY8Sh3R1Nb0gV3Y566s9cYLaBwUW00z6MMqvNr4Lq
         IMa04RUxTWVhyM5O82G0uQYS18SbVaNLntkj3YCh0LUi6jnhOheaaaj1aO7oEeDjkwH/
         37hxIxYQ8/4Mzcb6EZMb3+v3LKv8KU57Cf/C7HU1Q/PIsuMK15rp2prP2YvW7yiRJiLF
         TaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429129; x=1763033929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qsR7dUNbKYyGm3G2Ypb+Ygd27jeSq0CETiTbO/x2Dv8=;
        b=nTp8atTb0GFHLN2YOqqiMBNGAkX8DH7xfo4jVRKL2ByyNrjl3yWyo5LiuUpqVD7otg
         d8/lkjDxXjpCqJxOUoImyV260beJfyMcwALmavvYSeWb1mv0RzNPUmyE3TU3Bwygg3Kr
         abSkKkB9rWc8gP5VYPhyHEuVOK0NIHRsXHe96yH+TnVY6xtkp5ehxLKHYY6M/lJT6Too
         luE8w3d9jvrA0POjOsRut49L7J/yb5nERlWY/O64/GbtLZ7904oAPb7rYJ6K3p/pv6xh
         Tmz8N4ixWejC+WjvWHFmS5j8wAFhrWP9FKTLlWhqDJLmgvwgwPyCZlb1pO9aWBXDWoZc
         ayTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZAhfhVrl73mUKa1pcvL21I/4ciw3FAcN1fm1e69FFz5GHh+HIFsdrNB/OukLs0JOZWmt0LkDgNu47TS+AuhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxavGYte7DY5m/CbSiqUAmN/vZ05EhCcTZUTQfbHCXCCdtvkMVk
	GN2WYHretGK8/7pxmNoNpQPXLyolWQXmyY1oqybtudm1Ru5zPCaJShVyo9kAn5g201LneHn57ww
	71h3d03DaRsjp7WlDL+bfMxVSLD03I+qAjNN5E0rXhQvSzbjL6LpFt3xFkE1hm/yFUYRgVw==
X-Gm-Gg: ASbGncvKU5a5k+7bBekBVG/S2BiJk7Y2P4EAC/juf6QryZDvVVSigBBvnZC8UVHFY1S
	fjDCKEzve/N/pGwT6VAZcPMXDbicSfR+GKDROmfVBnbg7G9TjxL/B0KQmH/qGTxs7k7Mb+ao9ET
	zot7k6ayjXEJjtq7wvA2s8mcYC9UmPvqVI2CQ7/5rWIFOlvQomMT4EA7rJpu/hMeU1nUT/tAfy9
	MibXnWG0Vm+DoIJSgnBjAKKcEU4XIno5zFZFE0H70vlL96Ex3cIcn8GPh6uwWKLrLrZ+rsncHG0
	oV1HuigSEgNZZl3dvkhLBmsItBuevQFbMlIeC0SH1gI2DHHUGfRjK+XS7zF8ifbxKbURCYBwkDe
	8iQ==
X-Received: by 2002:a05:600c:3551:b0:475:dd59:d8da with SMTP id 5b1f17b1804b1-4775ce2b673mr68256855e9.40.1762429129531;
        Thu, 06 Nov 2025 03:38:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7kUvneRaqEvt7Kh1+lSjkJl0uXf/wS14yYzwd3nHIQHFp+DgBSlRyvRM7xPYT467KsqDWCg==
X-Received: by 2002:a05:600c:3551:b0:475:dd59:d8da with SMTP id 5b1f17b1804b1-4775ce2b673mr68256395e9.40.1762429129057;
        Thu, 06 Nov 2025 03:38:49 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47764152a13sm13759115e9.13.2025.11.06.03.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:38:48 -0800 (PST)
Message-ID: <bc1ebcd0-c42c-4b59-a37a-13ee214e90a6@redhat.com>
Date: Thu, 6 Nov 2025 12:38:46 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 05/14] tcp: L4S ECT(1) identifier and
 NEEDS_ACCECN for CC modules
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-6-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-6-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 7f5df7a71f62..d475f80b2248 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -328,12 +328,17 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
>  			 struct tcphdr *th, int tcp_header_len)
>  {
>  	struct tcp_sock *tp = tcp_sk(sk);
> +	bool ecn_ect_1;
>  
>  	if (!tcp_ecn_mode_any(tp))
>  		return;
>  
> +	ecn_ect_1 = tp->ecn_flags & TCP_ECN_ECT_1;
> +	if (ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp))
> +		__INET_ECN_xmit(sk, true);

I'm possibly lost, but I can't find ecn_flags TCP_ECN_ECT_1 bit being
set here or elsewhere in this series.

Also why isn't this chunk under `if (tcp_ecn_mode_accecn(tp))` ?

/P


