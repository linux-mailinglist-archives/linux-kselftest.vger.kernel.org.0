Return-Path: <linux-kselftest+bounces-31864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC69AA083F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 12:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FCD246255A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 10:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869BE2741DD;
	Tue, 29 Apr 2025 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9mO1sDp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F184D02
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921664; cv=none; b=iGYc+0TD16nT2q0EMOUM5LQUbx6P7MVN+BdyLeyIwLboR1KkcUHjUe3lnrcUFGFuDprAUtDw8fnXxB9MpgYUZC6Sn0PFC9Kbkpvkr3M4lrDKzVh+m7x97UPkeT5f31eEMefECouwwUdmAPwcZSu08TBRem7cNPIPmbRRSN7HbLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921664; c=relaxed/simple;
	bh=cEIrYuPRZUs7ZJmrpUmdpxqXw7U5nJD6GFuhUWjnoYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeYVeA2TU64/oPfmC7JFdSOpC4qPRRJJC+5st/lH5GrPhSH/ien9685Q9wZaPKfn7uyYRUsBLpeBbhyiz/2TzXAH+ErpsVbMOZ4Wa/cQHOBHIMJ+t+AKkIGb6Fd9ST7W1SVDBxYdCQNra1RRsIGRuqno/MwGlde5EJWWFNd8lc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9mO1sDp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745921661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDnpwUOmOz7kzZb7HBQPT0GNq1K5yEXjiMWvxnB9eWw=;
	b=P9mO1sDpHWhuAuLFkX5ooIaDFfDwzMUJFf7nX/lWr54yIgLpzgNiaprz5s/mkydfVu3mH4
	VVW16DHDij+nFrF2xsSieADGHkvw0KLwcGCLa/MEJ5CE1vsJ+hgme5s8SaiPiDnSIcjhq4
	jQqcuw6896wEfNj682tbVxtVpIdYp10=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-fybHrqHeP26EEFj4RhIWtg-1; Tue, 29 Apr 2025 06:14:20 -0400
X-MC-Unique: fybHrqHeP26EEFj4RhIWtg-1
X-Mimecast-MFC-AGG-ID: fybHrqHeP26EEFj4RhIWtg_1745921659
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-acb66d17be4so430604566b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 03:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745921659; x=1746526459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDnpwUOmOz7kzZb7HBQPT0GNq1K5yEXjiMWvxnB9eWw=;
        b=gemz8DHr3uBB1kr4bjAeX3CWdY+MCAMsEJajg9kP4sTIYoSPY3pGH5RN035osPF2z+
         51IeoVUt705OdETm/QUphvtdtBGohZVmZngMkY3jB5aUh1iR2NlyVCVH2KG7IfQBs4o7
         iY1iZQVgzcvYYzp2LGZvhzwJlMEthofLeOEalDojCkaIJ5pfE00wTcZkUP5BvcSnQipf
         cnf7Pvh6LkKtMrtjZ97IDkxIYfHK6S3HkudDevu6rIQy4PIJa6072CmsCdVMNab9qO36
         SQvekwFlNUXkWherktpOppqECId+N68tsheJml9u7kJ4dK9tf5seJ0VLBl1X4zBH0WlI
         QuPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgQBtgvx+U4P85yODbiJ+V7T1aSbFWwnryEGhZd92eEXSemveKrnwy+qBAomUo/RvZY3Orn57w/FgHCncKx0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy28hWPxYbJi9LGzkl3rrmlofQ0mYBt3M4/WkgukxutpMhSfgf
	qWFD8VWWg+VL7Dt/c9+uTXswFj0g4a2JUDNBJWy3MOd1Blx8yRkw+07K9m3ZLiCkC6YdcnX4c9j
	znKhPHKQc71mubroJKAMiNnusUVFcPbKebqCYOsRdUwnV2HLYpB32yRvNgXoXT5t4mw==
X-Gm-Gg: ASbGncve4r5POuOtg3va4PlPQV6tY3TDfvtEcgfbwt4FgTNThMN/uoTAruKFGfJZc3Y
	5BIciABqatTwVcreDUnT3j3BKWsbF3baG8sWF/q5JBBrdvh6KPZMmWnIyZ91mFHh2lbfs6mU2JR
	5y7CuE2VmmuUxDRMQI5cSvlTSgVx6H+3rZvuZbT80lXyIJNzNJgkqyYkQDKugJqhLSlpYAGJ3pl
	9C2UgHFSo3LS/H6QV3okaL36blvWpU7DRcXpLoPBt+w02o2d3CF3/03NtmU3+ZzyLofs/4+ckwx
	rz93FMDV4jl95mCYF43Oi/4GQNMM1fWUO8EJQyvj0nHQNhUgpPduHJPZhB8=
X-Received: by 2002:a17:907:7f0f:b0:ac3:446d:142 with SMTP id a640c23a62f3a-acec84b8840mr215445466b.2.1745921659027;
        Tue, 29 Apr 2025 03:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAwg/f5jfjr9fEDrekbGYeHvluxL2RH3FHETuMmtFe0+8lfoKQ9k+3naGTi4EzFHoniRq+8g==
X-Received: by 2002:a17:907:7f0f:b0:ac3:446d:142 with SMTP id a640c23a62f3a-acec84b8840mr215442666b.2.1745921658572;
        Tue, 29 Apr 2025 03:14:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897? ([2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed49c2fsm750532966b.124.2025.04.29.03.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 03:14:18 -0700 (PDT)
Message-ID: <62a1b3ac-a36b-4812-a014-c04a078eed36@redhat.com>
Date: Tue, 29 Apr 2025 12:14:14 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 03/15] tcp: AccECN core
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org, dsahern@kernel.org,
 kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
 <20250422153602.54787-4-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422153602.54787-4-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -298,6 +298,9 @@ struct tcp_sock {
>  	u32	snd_up;		/* Urgent pointer		*/
>  	u32	delivered;	/* Total data packets delivered incl. rexmits */
>  	u32	delivered_ce;	/* Like the above but only ECE marked packets */
> +	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
> +	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
> +		unused2:4;

AFAICS this uses a 4 bytes hole present prior to this patch after
"rcv_wnd", leaving a 3 bytes hole after 'unused2'. Possibly should be
worth mentioning the hole presence.

@Eric: would it make sense use this hole for
'noneagle'/'rate_app_limited' and shrink the 'tcp_sock_write_txrx' group
a bit?

[...]
> @@ -5095,7 +5097,7 @@ static void __init tcp_struct_check(void)
>  	/* 32bit arches with 8byte alignment on u64 fields might need padding
>  	 * before tcp_clock_cache.
>  	 */
> -	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92 + 4);
> +	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 97 + 7);

Really? I *think* the change here should not move the cacheline end
around, due to holes. Could you please include the relevant pahole
(trimmed) output prior to this patch and after in the commit message?

[...]
> @@ -384,17 +387,16 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
>  		if (tcp_ca_needs_ecn(sk))
>  			tcp_ca_event(sk, CA_EVENT_ECN_IS_CE);
>  
> -		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR)) {
> +		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR) &&
> +		    tcp_ecn_mode_rfc3168(tp)) {
>  			/* Better not delay acks, sender can have a very low cwnd */
>  			tcp_enter_quickack_mode(sk, 2);
>  			tp->ecn_flags |= TCP_ECN_DEMAND_CWR;
>  		}
> -		tp->ecn_flags |= TCP_ECN_SEEN;

At this point is not entirely clear to me why the removal of the above
line is needed/correct.

[...]
> @@ -4056,6 +4118,11 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
>  
>  	tcp_rack_update_reo_wnd(sk, &rs);
>  
> +	if (tcp_ecn_mode_accecn(tp))
> +		ecn_count = tcp_accecn_process(sk, skb,
> +					       tp->delivered - delivered,
> +					       &flag);

AFAICS the above could set FLAG_ECE in flags, menaning the previous
tcp_clean_rtx_queue() will run with such flag cleared and the later
function checking such flag will not. I wondering if this inconsistency
could cause problems?

/P


