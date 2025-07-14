Return-Path: <linux-kselftest+bounces-37267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6062AB04330
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 17:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6B34A5009
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4758625A2D1;
	Mon, 14 Jul 2025 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETBqISfH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C4A25A645
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505950; cv=none; b=fRS4a4GBKrGbzWfnjIjAoWaNpp93AWDMk6acA5/FmzY3DOCqjXWkvuVVDHnUcfFzkavG135wHFYkxwpbLaKxorL9WoOqY/XB57yfna/Q8/HJ8DAqYX7ccXOkOlvQ1/PLd/1j+GsJDWIlnSy7QKyw8bOWEH2kKSFBwXHHgg2MHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505950; c=relaxed/simple;
	bh=nUBsyJw1CVVySBdkscf0wKBNx6+3aTki+UmriA4CZ7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=buVlN0sI5jgvRoNLWxUBnB6AZFUgfU52j9jplS5BuHsaAI4O9JqrJ5RPJRbiRlPZOq05iNh3wlM3kqL5lz1Kc2+HZ+Zp9eQ6/gsmYFAEOtZ/iZEoyTZIu6672scmFaFTgvs18sO2pdvblvFcIQzcwj/p+qQfSmK1L5Ddd6Ra2yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETBqISfH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752505947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MByh1M8hBJM6ZO7YZ21H+SItyH0RTixPX6ghJ1VgS10=;
	b=ETBqISfHJY3VDnaAVF83crtiScZNbQl2mOMgLQwbygjw8nRJVOBEw00d2lnzbi8zGVJlte
	a0l+fuXQcgI3+goPlRfDP3p04U5MTJN3fHqu+efSehBPoeRN4UmdfuAlsp3pcmq5JuDU7l
	57hTICfxvn21Ia18H/09zhcIkDoFSSo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-KiRds45JNu2fSJt-2CGx2w-1; Mon, 14 Jul 2025 11:12:26 -0400
X-MC-Unique: KiRds45JNu2fSJt-2CGx2w-1
X-Mimecast-MFC-AGG-ID: KiRds45JNu2fSJt-2CGx2w_1752505944
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45359bfe631so27339815e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 08:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505944; x=1753110744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MByh1M8hBJM6ZO7YZ21H+SItyH0RTixPX6ghJ1VgS10=;
        b=h2zo6PWrPXLxoix5kP1w2RFB+yCXwwr9CVjEdcdjis1C5Ezqt9XxJOFMRm8ncKh7HQ
         YYx9xJ1ibedjeMGQ8CK1Ur9vmqC00ZHQ6MB00JzeLoFHj4pi/jtqq/h1gzFhrkbw3nkV
         yRfE3Ao/hoaKGqril//QcvLcy7hPrH3vyLXoyR9V+k9v3s4NXycgj2kVbTfp7VpsW/G8
         lNa5tz7Fc6UXLq0ADL49uIBayKxLr0EVJQRBkxlS+lND9ZhQWeMrLyuO7epAybKBhhZ/
         nuJZpkTd5qm208aNrPSj2XwMFtRhckxywP4v1bDFMWPDx23nOQIB31T0E0E65MtYeKRQ
         exkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfftDpbxq9is6frfbffU3SVqGifOEHr+L0h/HnAjIlOQi9c8/QVlZLIyopp84Cc6NjigwMGtpbpwLB92VDN8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQ1G6j8F3uwNNY53wj1jZi7+qWKL4bQVfzkvqxyIyU9+3GCwi
	/2nF0S20UajDJ4fdq8WlOuvOKZ3jrCaHlXOcDhl7pRIMvwve5PM2+Te5y8JLekGuSOKPjhN1zTe
	j9FyI9CbO8/b5er58UH0ScvrT6qjh4DwNyzDbP2MFwm4WOGMqdjPAND72vPUMlk7xNFiOCA==
X-Gm-Gg: ASbGnctOu6Hv3AuufMog+932lqNSffN0NnMJGwr0WlctJkGhwANkPRlYSw5upbso3uu
	UzSVp7/aukeSgYJQRNp2iwCn7+hD6MI6ckkNYVmF4DelQhM437Ihwv0HrerrKx5dIBIIgHoCX53
	8HsBF0xPzs5e2/aI8FBTR1CmXuEtsEWq7PtZ83QD0xDfhFYJbTMKUm4s+ikFlyEp6yJJWYEK2HA
	UkAaiHegeB1M5fxhIsGe7+ST6CFNvzEPgKgA62mX93Bauc6NDZeLAp+C0Sp1TDqsrjHFTHNfDcQ
	153xVhN6EY7gFaV65ixLQHw+KRXj1eA8MCW+29f5S5k=
X-Received: by 2002:a05:600c:841a:b0:456:1b6b:daaa with SMTP id 5b1f17b1804b1-4561b6bdd3amr38487885e9.29.1752505944232;
        Mon, 14 Jul 2025 08:12:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI8sx2a/TCHL+bqItM/OhugxGKDQcaU6p5roxACLJIP/WtAGE/GxnvHPR1UMcQFIC+o2xoAQ==
X-Received: by 2002:a05:600c:841a:b0:456:1b6b:daaa with SMTP id 5b1f17b1804b1-4561b6bdd3amr38487625e9.29.1752505943842;
        Mon, 14 Jul 2025 08:12:23 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd56d936sm117404425e9.0.2025.07.14.08.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:12:23 -0700 (PDT)
Message-ID: <e3bef5ed-535f-4ce3-9ea4-f6a40df448ff@redhat.com>
Date: Mon, 14 Jul 2025 17:12:20 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 12/15] tcp: accecn: AccECN option send
 control
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
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-13-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-13-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -1151,7 +1155,10 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>  	}
>  
>  	if (tcp_ecn_mode_accecn(tp) &&
> -	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option)) {
> +	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
> +	    (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) >= TCP_ACCECN_OPTION_FULL ||
> +	     tp->accecn_opt_demand ||
> +	     tcp_accecn_option_beacon_check(sk))) {
>  		opts->use_synack_ecn_bytes = 0;
>  		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
>  					       MAX_TCP_OPTION_SPACE - size);

whoops, I almost missed it...

Please call READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) only
once, i.e.:

	if (tcp_ecn_mode_accecn(tp)) {
		int ecn_opt = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);

		if (ecn_opt && (ecn_opt >= TCP_ACCECN_OPTION_FULL || // ...

/P


