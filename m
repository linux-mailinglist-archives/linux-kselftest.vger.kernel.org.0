Return-Path: <linux-kselftest+bounces-44178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1821C1488A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 13:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4581948001A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 12:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294EB32AACD;
	Tue, 28 Oct 2025 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKRHWTXY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2C329C7E
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653049; cv=none; b=kwtK7dXmygA85RatgUL+ow1GopRnkr97UjAYbL482v7OHKdXtt9DfTqMbbzr9jsVujfVk85pwTBXGc4cq5ApsUSZxbBe5hzg0luOoHFvxLlv7/po4pqvbNSIIjTBHfiTAYGx25cIhp6rkPPAxWivU1omZuFKmzFdobmfdl1SVBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653049; c=relaxed/simple;
	bh=WskojuOBnwIjjigUBWEDMhf7Assmbp3QvliKc3R2txY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOrIScd5DOJo00/I7ouqmK/vtCCEKV6cxEkqHzk5jnO66XjurqAXphfV9lgDRm0p2HFTzI407Ap799Dbn9t+k5UK5pw5JdL+8e2W8o2GMSPy92sauW8OC6pQOjRnjsWokkxavFgKbGgvkvYHdnJ5zkY08142LlgD67cPIZgNHrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKRHWTXY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761653046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xM3wpdALZDN/yyL3dIoanvrY9zgAvQNamISjAjH9Xc=;
	b=iKRHWTXYRpHQZ27rlx7kGAwC2yo4XM2TpZMwucl0zC+hcG19lq94AlUPg0Vults/8Nn4R1
	OvLhgzBT5Oc96e2HtXq0vWlECA8eDc60J/WmvNEeosRJGMQHEbOXET7NUa8hUpR5QNenC9
	VUm/5wY0H96ee+N1SHdSMMMcyKVpepk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-hrlhAVh8PNG0KFrDMX4iOg-1; Tue, 28 Oct 2025 08:04:04 -0400
X-MC-Unique: hrlhAVh8PNG0KFrDMX4iOg-1
X-Mimecast-MFC-AGG-ID: hrlhAVh8PNG0KFrDMX4iOg_1761653043
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso44549425e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 05:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761653042; x=1762257842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xM3wpdALZDN/yyL3dIoanvrY9zgAvQNamISjAjH9Xc=;
        b=Bc+TnRcZeLQs/38LyQNUqI9TOwVwjeIBF2+TIpi6cpYUVT1qF2d+s2ve0+MQqSwulV
         K9WRfGF3LlJ8PclWX9jLxYx4M6XDqNJ9WnfEWHOmmY+Kc/0zrTjeyXLBV1qvKvRm6ibk
         WRE8dPPQm/zUKZB3/Ms/FPbiim2eV7J7gARYa//4mMQ22WGATICnoXEtHgs3CIWv6qhg
         9oCGJCYkItYMYjx62LGGUAozoNLL30pQz57jliJS5lPlaKL3dIMUO+Moaa5IuEu1HqAQ
         Y+s71zxNyT3pDbW7c7bryY3+gzNX7U50yWKquR+9gJF0gF5d0c2OFfqZetexWzXvbRsw
         jxPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZiSVpBPFai31AVoW2EOXvnI4TLIZg4SmB4ji6DKondNBpS1LcyWmzd+gUD/oXop4Pf2jZhYz1ah4WTWNVnjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy02bd0vBPiext6shiBmknRALxZJ7AG0yUnqjbUo9RPy2mn+L31
	7DqSRKSIcj23CF2K3bIzSWX5I+Fppgx3gOq8+bFp24mUon09s1U2bawKR4jwx+zeWJlRTYGee4j
	viMZzTjFwlwmlhiZ1ZoiT1/ZDujgbQ1XcCVkS4xrtMdlLAzsxPfNxAvsQIvOFkClyGSzhEg==
X-Gm-Gg: ASbGnctw4FNKaBAkbLYE57C310zD8ncwInTzknM3H7WDAUZpiPrAFa5OAmvLHYkDneD
	gLJGTNBdVSylFxk0Vsljuwsp/0ju0gLUas6r43azNq9NUJDJVOAI6JWJZLdnR4fRuH1Q9lDkGKY
	tAeX+gU+aeLoaJV33z+MnlVv4jM0WXLK1jL96bnolswOJk3SATKTgkmQDKtBb38ax7ZY2ph6RhA
	wwHhU4O4MPeOBZ4trKbwuWGq6agEniD5Y0+P6ElXlvWOrUfjcxLOjnjXc8a1kOjN7HFTUcKPec3
	NlP7vFCGYm5grbQkgUbq82Hdf+T/U04CSrx1/3/Q6EVgop683SOTCtPddhGLXBGwVD/o2bZMfIy
	3Y9IJ/Zkem/KW/2f+LQFxxgVEQ1KYu/z+0jeDtjN+zHouq3E=
X-Received: by 2002:a05:600c:45d1:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-47717df9d11mr30659375e9.4.1761653042570;
        Tue, 28 Oct 2025 05:04:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6BMjF+yCSS1WwGmhw2kl9y9f0ddjV6c/A0RrHdROCvFXSSyoxTUbY0rSmrFqSolRY/cH10g==
X-Received: by 2002:a05:600c:45d1:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-47717df9d11mr30658905e9.4.1761653042071;
        Tue, 28 Oct 2025 05:04:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd035dc2sm196120995e9.5.2025.10.28.05.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 05:04:01 -0700 (PDT)
Message-ID: <c5021188-593c-431c-bf01-6775f5b2b2ed@redhat.com>
Date: Tue, 28 Oct 2025 13:03:58 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] bpf,sockmap: disallow MPTCP sockets from
 sockmap
To: Jiayuan Chen <jiayuan.chen@linux.dev>, mptcp@lists.linux.dev
Cc: stable@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <20251023125450.105859-3-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251023125450.105859-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 2:54 PM, Jiayuan Chen wrote:
> MPTCP creates subflows for data transmission, and these sockets should not
> be added to sockmap because MPTCP sets specialized data_ready handlers
> that would be overridden by sockmap.
> 
> Additionally, for the parent socket of MPTCP subflows (plain TCP socket),
> MPTCP sk requires specific protocol handling that conflicts with sockmap's
> operation(mptcp_prot).
> 
> This patch adds proper checks to reject MPTCP subflows and their parent
> sockets from being added to sockmap, while preserving compatibility with
> reuseport functionality for listening MPTCP sockets.

It's unclear to me why that is safe. sockmap is going to change the
listener msk proto ops.

The listener could disconnect and create an egress connection, still
using the wrong ops.

I think sockmap should always be prevented for mptcp socket, or at least
a solid explanation of why such exception is safe should be included in
the commit message.

Note that the first option allows for solving the issue entirely in the
mptcp code, setting dummy/noop psock_update_sk_prot for mptcp sockets
and mptcp subflows.

/P


