Return-Path: <linux-kselftest+bounces-37248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62891B03F52
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 15:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46AE16BBB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 13:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A673C24C060;
	Mon, 14 Jul 2025 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8hPPQfr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA208246771
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498654; cv=none; b=R7b7COlEXuKXO1vDx5DF/qPtu2tlpqLXaQwc2UJzgijWPA7GrtniOuolDxjblWi6jJ3uJH41jTRcF5aCUg0l88k4kRD0AMxxm05l+w+qHJPyNyeBaC8EbiEQEysLAI3Olo4vb/HG5UstuBG3bwS60F/53cBw5qior52ZGa6ZMpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498654; c=relaxed/simple;
	bh=OKHlmd7Qcr8AGinaQ5iuxYV6lu1d4kRrK0yKJPeVqJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQka2JIbxEaHGkGEVkqnZHmxYpxpgJNSzKWCKCqOmjbqClskX+D9TBABYb2JEZPjxCn0/DcGknsdyYC4qIO92SgwFTOqRac8RNejQgfvNG5Qstq77UI4PFO9xtXKWOVmzVd4d/3oxwuO9xg/nh3kXczwzlhjcGBgJe3673Q39Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8hPPQfr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752498652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Slopq6lqfpeoL26O5BVE+c/eBR9HrgDvIWj6vuGUSOU=;
	b=f8hPPQfrG3AYZwHJkl370+6azR5XGxj/zI98hqDcEcKFNLYTxDPBsZ7tYa3vpHgmKXo9S2
	7RBuDJ3/9vhO62NlJTaDLn681HMp4XBxkp5HrDkYMlTOrpa+rjz0iP9eK4zuQ9z3ZdnB2+
	fizE3pUC7oX/VpoUnrEDirbjYtV5G5g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-e5jMoOzKPbO1-IgvwxPrFA-1; Mon, 14 Jul 2025 09:10:50 -0400
X-MC-Unique: e5jMoOzKPbO1-IgvwxPrFA-1
X-Mimecast-MFC-AGG-ID: e5jMoOzKPbO1-IgvwxPrFA_1752498649
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso24940705e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 06:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752498649; x=1753103449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Slopq6lqfpeoL26O5BVE+c/eBR9HrgDvIWj6vuGUSOU=;
        b=dlq415SiHKdB6BhhiWEs7I6+2buAriLhRfaStJ6OKs3ilB/NUg/5OW3pqq7uEOK0dU
         uKI2WN4Hpp1jX3ZwDAE1CFbUyJZGb7ZGV0t5InNNiaPbme1z+BkDzNUtozA4rayiec0E
         1bXeMSFeqXymJIn9m3MVjudPNHUNJjkF4HJFd5qYLw/5f/oSntSPBT183vOBsKZ+MtP7
         tuvtyebkKZCFEmFfn/8WMW/4dVChAiK3wKZMzhgdH+Qh0BU4VsPzB0mInclWcyLYXpw9
         N+kG69hKllRy2Q4NT9yAeMfqFlFPbldwnAVGn1xavFqqKnm8corXQQtQhvTJshlOP5VY
         pfPg==
X-Forwarded-Encrypted: i=1; AJvYcCUpJ28p4kl7kWSwB9DpAnDTThccl8zuqQ9qANB5lnoEuxkfiPJ+yvq7iD7mqaj0V+aysbRtBtZOsw4t6A0WL08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw42jFnFAxBhAZQ5PQXvpZ6NYHuYP76MdiDmV4AWuUr9wcCbRrH
	oGonSiubVGW5DxAlRvykKSQwoZKd+aA9scfkxPxxH5N622kgIBLcqv06BzfM3Uni9AFP6MTHR9E
	rOYD/m9McnMBKsmNyuQsYCB08+zYanxbXUN7YKbJINNiSZfw1X9xe8wpicufKxZLmsrIIhw==
X-Gm-Gg: ASbGncvcauyo+eF6SSfFj0HHFXxNJiFdwkHvLjfr4T8tK9cf+XromJ5ONPrJbj/+um+
	6eGLUPAsqAMJD38jPfVv2S035Wu0CqGZMfg4XMyYOKRbVcgoie1SgR46/lz0mtCjJZ6mnwk+H9n
	Vswchng1nnqspbjArkJ/0p4y2LGJgfoUNNn/5siXLyvqZxM2Zuu9i+2eX6RPnk5xCuYQucJ9fcW
	j/p6+BpUWG3DL8DE2RjlCDyBjP38LP9CbjrPaRaWNGi4hLbAIXWpcTFGP7S6Kx3VDUHyZEq+VP0
	xpYe1cN1p0hC4Mw2uan+GhlmMxGpXNIGf/HVrEP2N3Q=
X-Received: by 2002:a05:600c:6095:b0:456:189e:223a with SMTP id 5b1f17b1804b1-456189e2325mr45725315e9.10.1752498649108;
        Mon, 14 Jul 2025 06:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4isJE0VuC1C1kTueLpR2HySlD/dQQOFEyhiZwFlkFPA9n3aecdOCB/5t4HOGIGIIR/iCaiw==
X-Received: by 2002:a05:600c:6095:b0:456:189e:223a with SMTP id 5b1f17b1804b1-456189e2325mr45724915e9.10.1752498648590;
        Mon, 14 Jul 2025 06:10:48 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e262c6sm12199695f8f.85.2025.07.14.06.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 06:10:48 -0700 (PDT)
Message-ID: <dc03363a-36d0-4a56-9247-baa75d516620@redhat.com>
Date: Mon, 14 Jul 2025 15:10:45 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 06/15] tcp: accecn: AccECN negotiation
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-7-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-7-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -375,7 +379,8 @@ struct tcp_sock {
>  	u8	compressed_ack;
>  	u8	dup_ack_counter:2,
>  		tlp_retrans:1,	/* TLP is a retransmission */
> -		unused:5;
> +		syn_ect_snt:2,	/* AccECN ECT memory, only */
> +		syn_ect_rcv:2;	/* ... needed durign 3WHS + first seqno */

Minor nit: typo above: durign -> during

> +/* Infer the ECT value our SYN arrived with from the echoed ACE field */
> +static inline int tcp_accecn_extract_syn_ect(u8 ace)
>  {
> -	tp->received_ce = 0;
> -	tp->received_ce_pending = 0;
> +	/* Below is an excerpt from Tables 2 of the AccECN spec:
> +	 * +================================+========================+
> +	 * |        Echoed ACE field        | Received ECT values of |
> +	 * |      AE      CWR      ECE      |  our SYN arrived with  |
> +	 * +================================+========================+
> +	 * |       0         1         0    |         Not-ECT        |
> +	 * |       0         1         1    |         ECT(1)         |
> +	 * |       1         0         0    |         ECT(0)         |
> +	 * |       1         1         0    |           CE           |
> +	 * +================================+========================+
> +	 */
> +	if (ace & 0x1)
> +		return INET_ECN_ECT_1;
> +	if (!(ace & 0x2))
> +		return INET_ECN_ECT_0;
> +	if (ace & 0x4)
> +		return INET_ECN_CE;
> +	return INET_ECN_NOT_ECT;

Nit: implementing the above with a static array lookup would probably
make the code simpler/more clear

> +/* Used to form the ACE flags for SYN/ACK */
> +static inline u16 tcp_accecn_reflector_flags(u8 ect)
> +{
> +	/* TCP ACE flags of SYN/ACK are set based on IP-ECN codepoint received
> +	 * from SYN. Below is an excerpt from Table 2 of the AccECN spec:
> +	 * +====================+====================================+
> +	 * |  IP-ECN codepoint  |  Respective ACE falgs on SYN/ACK   |
> +	 * |   received on SYN  |       AE       CWR       ECE       |
> +	 * +====================+====================================+
> +	 * |      Not-ECT       |       0         1         0        |
> +	 * |      ECT(1)        |       0         1         1        |
> +	 * |      ECT(0)        |       1         0         0        |
> +	 * |        CE          |       1         1         0        |
> +	 * +====================+====================================+
> +	 */
> +	u32 flags = ect + 2;
> +
> +	if (ect == 3)
> +		flags++;
> +	return FIELD_PREP(TCPHDR_ACE, flags);

Same here.

> +}
>  
> -	wire_ace = tp->received_ce + TCP_ACCECN_CEP_INIT_OFFSET;
> -	th->ece = !!(wire_ace & 0x1);
> -	th->cwr = !!(wire_ace & 0x2);
> -	th->ae = !!(wire_ace & 0x4);
> +/* AccECN specificaiton, 3.1.2: If a TCP server that implements AccECN

Minor nit: typo above: specificaiton -> specification

Otherwise LGTM,

Acked-by: Paolo Abeni <pabeni@redhat.com>


