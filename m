Return-Path: <linux-kselftest+bounces-42145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C290B95640
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 12:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBF0D4E1C41
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 10:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B590430FF25;
	Tue, 23 Sep 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAJwLRBR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735982BE7AC
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622136; cv=none; b=Ky++A2qPA0rGud7w2WGjzTGFg1E2K20ozT/VfftFNAGquCmzYHlDCAunuVW0YvOwMMwB8t7ON3bJI2elX9x51Rd601PJslhE5/IV8PE8ZpjretSAQCbO+n4cN25e2+tDDWarRVjZKeoS2+8c7566EwtH5z0hhHhDFAFvRFg5/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622136; c=relaxed/simple;
	bh=S3KOpBbqom2/3HrzTHThYA0lYWi/O5mMBlQ+qwi7tME=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p6pLeXNz4dyMV9Vmqsd81t8mYYCETXVg8urzfHPaKaHQT2sMsRVv6r0lfy9ebpFWrPX1jZzEQG+7vx470OY9NfzIK1TIURSuLoHY1HZ3i6FlESqk5uc/bHO9C3piuUw6i8BSwPy6KGK9TJO4uerndzxa7SADsTZNhs7vEQOz+sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TAJwLRBR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758622133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAJnOq7wJ5XI1FIJLe0LF85/fgqZuSixFEm3aUU2pcI=;
	b=TAJwLRBR0nuiHGR+/950zNyNaIIipgI424WncV0PcWCnmj1cUYv8brCKeDHHoOXy1VEg4g
	x+b+KECzKgFmRZ6/ds6VtSHLtXPw6LCoLnK++ekPrIfsEIVQRmhRyImHcLNNMko4BWNTtg
	lTAVsB6Pfw+CmNE+AQxboIYxPQIu6Rg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-P7J5ft2hMqiAmpyZSYPRWw-1; Tue, 23 Sep 2025 06:08:52 -0400
X-MC-Unique: P7J5ft2hMqiAmpyZSYPRWw-1
X-Mimecast-MFC-AGG-ID: P7J5ft2hMqiAmpyZSYPRWw_1758622131
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e19f00bc2so10865585e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 03:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758622131; x=1759226931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAJnOq7wJ5XI1FIJLe0LF85/fgqZuSixFEm3aUU2pcI=;
        b=nEDpWi+3RPsug8JGr2noeFmyTwFGBwK+ERSe/V2zk49RdLDB3ECemRt7C+rZdS/Csf
         MP8EIaR/Yz0ahlfL8adJ8f41fQx1EEr3VxUGy4vJhfktmZPqexlimr+JByzuc5XD3NbM
         MxSYbekIXJtEzHp/gZ6zgKXHPJ0bvzC6mu6kLnuEr2rnDg9JD0T7qxtwFeZYOME0MFei
         N+HhhYa0I8Nd6qr/MkLBOaXMtVxR4/PHD0LMAJW4zeH5bFynh1Rxr9Ijme0BrWPqhfHf
         x2zdqtgD6vim1a8S9crIrscsoBRTyt8LvR8dZjhwYGRzpDWX31d3v82e2QNVuhoj7OVK
         PLiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAhqapd3DpG03Rk10RxYsYVw5k2j0BVPhIoT9mQbgH05DdPCI0HmW68yWZ6DAInfxHseJ7bC+MTc5YlkZXu60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMahTYUN/ybgvBU18m+FxsYe13HODCHQhUkRu45afZ4W/5XgvZ
	k8tcBX2MnyQGZ614GsswGUgLG2w6urV6TL1eBJwmOkew2RjjWKbMHY3nzq5EsnT5QK9zVPs0e+4
	xmQQ0N0x//OcKhpWal8c98vlVnyNVS//wKSSJBnK0kVM0PH2EbAYU5DebHEgFvk9nXAdCoQ==
X-Gm-Gg: ASbGnct337lJ6YPOh8OzQqJXgSxF8Mm01Sh6nOf4slhyZp+W98ICmflwQz7FxMUUfyN
	EN8qIWmKJnC9IBaTvKSEyDXzWi/QQBZl1aqTGFKYa/0Lq/x8zrimmzCS5FxCzEDUoQVHBuckHjH
	WCutu8+5flHSJL7H+7vQzZKNA/UVkGYk3aXcTo8ahmurtIHtoDCa3Bh9tEGd+7lM2W8yJkVYprr
	V2xvUimkPPIARqLzNbGk2/tT1vuk0AKv2w2UijrxETlhCyutUffl3FS1BcII4u/T5vOF1cAA78T
	2wa7YmUm91mzQs48Y3ivDeZ3q0iYnF21/SNYHm0t2TJUEnN/GxvEXIPFOjkVjN8ewhC/NdDCbTM
	QKRaNTaxvlE2q
X-Received: by 2002:a05:600c:a48:b0:46d:45e:350a with SMTP id 5b1f17b1804b1-46e1dab50e6mr24290085e9.17.1758622130999;
        Tue, 23 Sep 2025 03:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGiVBoeiv8DFrvBqu78ojFZFjTSEy+NrpSObi8FAlZe/hiEW3VVmVz2sDexaIeGuLuj+QBIg==
X-Received: by 2002:a05:600c:a48:b0:46d:45e:350a with SMTP id 5b1f17b1804b1-46e1dab50e6mr24289565e9.17.1758622130617;
        Tue, 23 Sep 2025 03:08:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee1095489asm22527408f8f.24.2025.09.23.03.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 03:08:50 -0700 (PDT)
Message-ID: <790a6a0d-4611-4cad-b72d-a99daf7abb14@redhat.com>
Date: Tue, 23 Sep 2025 12:08:47 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 05/14] tcp: disable RFC3168 fallback
 identifier for CC modules
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
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-6-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918162133.111922-6-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -525,9 +527,10 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
>  	}
>  }
>  
> -static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
> +static inline void tcp_ecn_rcv_syn(struct sock *sk, const struct tcphdr *th,
>  				   const struct sk_buff *skb)
>  {
> +	struct tcp_sock *tp = tcp_sk(sk);

Minor nit: please leave an empty line between variable declarations and
code.

>  	if (tcp_ecn_mode_pending(tp)) {
>  		if (!tcp_accecn_syn_requested(th)) {
>  			/* Downgrade to classic ECN feedback */

/P


