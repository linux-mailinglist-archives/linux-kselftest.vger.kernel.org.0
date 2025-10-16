Return-Path: <linux-kselftest+bounces-43315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 977BEBE2517
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 11:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D03734615E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 09:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386E9316193;
	Thu, 16 Oct 2025 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIoEoalG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E2330EF9D
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606050; cv=none; b=elMzrSVK+97g+jd4WG0dpLl3S4Len3MBD6JPl+QYdorGXxMBlvQgK09F/S84fxTwpWh+WPVuZ/wQXEpdPxDuJdHR/QnCF6qBc1Q/mUYj/B7DqHiAtr3viOidJU6oHMx5iL74sI4kLU4ILnYuAJDGH2NuBv1H64T/AZnC6e2rEak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606050; c=relaxed/simple;
	bh=ELmS2iqx46fL7UasEsDCyMyL+buB0jyC61nw+TSeRsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nf3VcURHivY5z+mhyNxy/aHIvOkiC+zoSbMRPB2uUCNT0YAMLxbU+5jgSEPcgd4rlF94VraIWcXf9LGECZ6TaMDSvRN9iL8qv5uJPbXxoQ83nxFYubVRbuegLvIGW9koxy+MLdY+qsCfV5Mt5cYoXM31qOVrjwKvlnSXxLlBeOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KIoEoalG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760606047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQC/nox2pPgKzpW6LX7hPXAhl0xagSfw6/n0g49FETc=;
	b=KIoEoalGRb0bu/zpqsEUKPGdMgX/ZPw+kL5XSzEg5yE0tXCx0k5c+s9CeDWnV4iDtyHDoO
	IvCpCpx+cbCLeO9JsOWgLIC5ePdu1LYnVB8iAXtcZUZM4pwGech7SFmiGnlOydZ2/vD+q0
	DIJvuDVpFIkPPCMiUTr7MXCg9Kmlyck=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-gK-mcVNeMZ-aLXMK3aAWWQ-1; Thu, 16 Oct 2025 05:14:05 -0400
X-MC-Unique: gK-mcVNeMZ-aLXMK3aAWWQ-1
X-Mimecast-MFC-AGG-ID: gK-mcVNeMZ-aLXMK3aAWWQ_1760606044
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-471144baa7eso2876665e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 02:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760606044; x=1761210844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQC/nox2pPgKzpW6LX7hPXAhl0xagSfw6/n0g49FETc=;
        b=BfmH+FDzz8UGe01gO/eHdorhI+fmngPYeveItVnmjaJgL8kwlpkIXyGURyDNlNy9+5
         OcCI97hIE/bBNjQgBL3efWpKtj5IE9sE+gH5p7onf+B58Fy8ehO8w61K/pXYZcc8TKJh
         3u7spJMSxa5EA3y+bLYaccCuuE+MOVow/ZvM9CjEAxQpYSdfkLLXkSglqXxrUccsn/C5
         bZbKyH6hSnv6t4o87e2bBxMOsrAsItk8huae7oH0dF7lr7X9NWNN1Otd7lWi229ow2YL
         2uEN+HIASGjELRjBPRCBXR4GT5YimOycFIJcnzPcQRpKrts74wnLvvqXsri0mxeFxuxm
         2uTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUawv4yR9zs6DOKCgVjWX7FwU6vFWoVdkH+cDgZ+5c0DZNO6TKZQenZPulr/X0IIfDdMdwX9OKNqulzOMxIivM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkWL+g39hk3QHbNCsXficCukBNlc5WVsJ1iSKQi9+JLI8lwD9Q
	NSp3cC/Y0I6v45jYBSyAv4FUiwNxzmUT4sl/2IBMnGPBOZTpWzHqxc9upE+tyWAnzlR6ywL5gDn
	IrYPVHHTcK4GVOnLD+tUSCNy0+lEdi77YirwGnl4TT/uUkP54peKByS1GRct3laihdngNkg==
X-Gm-Gg: ASbGnctxFLWDYbVnCon4CjVZEzCv0SBh09/XHjHzZejrQeJ7UzndR0q54qRk19Lx1a0
	ykJ0zmTPDpq6vgdpaYprQAcXybufWC31QSKGVW/pbIRKH00cGA12FtiHSDzspyCnFFdXU88ni22
	iIaEKewkiVk0b7XhIrD5cxoKYjAZtHvhj2Yl41oLVhZ8w4/tRw4UQ/i6gaxG6hUwulMM7FgBGC5
	2jNMC91uSKNgbcsLQ5BquACVWriKvl0yIO8mQzZZGJS/Gl0Vnk/d8zgNFFqhS/c3Rs4o5SeLfBa
	8xM8mPYERAyZCquOmhdnOXhqEQRonEHGHAULSpCbXouGriHC1jvY+eGi1BlrtzedQGwxOdvA3+b
	/8XkWpp1ZYI49JjGJxOc/ynhszsjj2X1OjrLaXMFjZESFweY=
X-Received: by 2002:a05:600c:4743:b0:46e:1fb7:a1b3 with SMTP id 5b1f17b1804b1-46fa9af1814mr216099105e9.23.1760606043965;
        Thu, 16 Oct 2025 02:14:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuLIFjtnAoI+JjoLtnLBFFwkqEMXB7AsH8mFt1MS1ibyoib4YpL7DpeFE1kmI6fKT2Oau5gw==
X-Received: by 2002:a05:600c:4743:b0:46e:1fb7:a1b3 with SMTP id 5b1f17b1804b1-46fa9af1814mr216098695e9.23.1760606043472;
        Thu, 16 Oct 2025 02:14:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114461debsm15463165e9.18.2025.10.16.02.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 02:14:00 -0700 (PDT)
Message-ID: <705f02b2-44c6-4012-a1f3-0040652acc36@redhat.com>
Date: Thu, 16 Oct 2025 11:13:58 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 08/13] tcp: accecn: retransmit SYN/ACK without
 AccECN option or non-AccECN SYN/ACK
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
 <20251013170331.63539-9-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013170331.63539-9-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 7:03 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> If the TCP Server has not received an ACK to acknowledge its SYN/ACK
> after the normal TCP timeout or it receives a second SYN with a
> request for AccECN support, then either the SYN/ACK might just have
> been lost, e.g. due to congestion, or a middlebox might be blocking
> AccECN Options. To expedite connection setup in deployment scenarios
> where AccECN path traversal might be problematic, the TCP Server SHOULD
> retransmit the SYN/ACK, but with no AccECN Option.
> 
> If this retransmission times out, to expedite connection setup, the TCP
> Server SHOULD retransmit the SYN/ACK with (AE,CWR,ECE) = (0,0,0)
> and no AccECN Option, but it remains in AccECN feedback mode.
> 
> This follows Section 3.2.3.2.2 of AccECN spec (RFC9768).
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/net/tcp_ecn.h | 14 ++++++++++----
>  net/ipv4/tcp_output.c |  2 +-
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
> index c66f0d944e1c..97a3a7f36aff 100644
> --- a/include/net/tcp_ecn.h
> +++ b/include/net/tcp_ecn.h
> @@ -651,10 +651,16 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
>  static inline void
>  tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
>  {
> -	if (tcp_rsk(req)->accecn_ok)
> -		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
> -	else if (inet_rsk(req)->ecn_ok)
> -		th->ece = 1;
> +	if (req->num_retrans < 1 || req->num_timeout < 1) {

I think the above condition does not match the commit message. Should be:
	if (!req->num_retrans && !req->num_timeout) {

/P


