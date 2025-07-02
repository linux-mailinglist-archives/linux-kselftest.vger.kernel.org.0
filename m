Return-Path: <linux-kselftest+bounces-36281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F066AF0FE7
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 11:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772684A278A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 09:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D55246781;
	Wed,  2 Jul 2025 09:25:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B2523F41F;
	Wed,  2 Jul 2025 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448327; cv=none; b=FXy2QxLkJF1+N3sm1vpnb+O0KAQqz3q5EWZ7k9kV+HNdrUoExrujaaFT5MXRsUfmRIWyu0C9aRD9eWZvY3epJ0MaEmRi9nWxnGkMe8tfzOS81ZUB21HALwzkud1W6D3Opw8MDVvjgCCNsppUoYYdPGj0ym/lqGM7vQ4Q/PKQl6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448327; c=relaxed/simple;
	bh=l+OXJNIycwkqxDvtkEQQL47AAcEoLyHKZN6dUMteqI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsizR78jxAtRVWLPG7xg8uVaMBjOWoZlL2cmT/XYNBvnQSuVFfwM1dW5Ux0uVeifkaGuMtBb34WiDQAAJvbR3PMk06VJ51hqyXkrUKflTh7iboHR4u6CldFfRV7OzpwsSa1PQKKb66Jfmk8jIW14scoiLYEGir41C28oMP7xkEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0df6f5758so715155866b.0;
        Wed, 02 Jul 2025 02:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751448323; x=1752053123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXqizztXrc6l617heC/AMuPzhsNfzw+4PJx5K3hl0+k=;
        b=MryAo/6QeecAbzjwFSg26icdE9TF5htEpWRQJfS8IbieF5ROjtYqKdwLOOwPvO+/ot
         y1YlMflM3Iulf6h0j5GvD13OinIZ0vk5fMV+eQQbXr2OC7ZAkXwJ8fqfKQLp5YcefaKT
         Y13PEmsheI6t+p/zf0QlCjdBDEeH4E2wfj2PSSF0uSJwlwaYqIK6Y4WYXovecn1pzNit
         YMcWcBgCux9rzbQ9MPHliFDTWZ8za+QoFXZ+NiIrMrBxA6KXqsv8IjQyYGUUK5rnKGDE
         QOg0hrMuRErbqS/B3N/NlQ68Ugv8Pd2URu+LRnt3cVbct9GAjoOGvUfAm753YU/yE06N
         IlMA==
X-Forwarded-Encrypted: i=1; AJvYcCU+3IjLhCw00Dum6yE2dxFIi3/NCCiRNiR2pTt+GcwGXYbkk7hqk8x2Zi9cts+vniaAtFeBGMhdWbh53knOqM3J@vger.kernel.org, AJvYcCWfJLeoLZTvfU0HVtjNZvi4UMISxcKcvOd9bsVmCJBSbpn4+/IaKxDnioxofaEDbWy5IESfqmLsUYqsCuo=@vger.kernel.org, AJvYcCXlOfG1ytJEnYGTobvSBG1+T32AITwxqYjndapaVxbampIcIz60C/bjBqPyixT1a64hykdbp4eZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ8+KPEIIrUa4wzQeMTmWh29LD+EUoKsg/JGC8xdtzSRUVI6aD
	l04pA121klupbGOraIpRkOaq2115LsdvSWnZVtWtDfkzpbG+FFN3ma6a
X-Gm-Gg: ASbGnctux9zyp7xjw7thWPe85mPVDq+IScCH+Do8cHjxcCTipX6+tvGl3nzpT+5Af5A
	nzp5PjZiFKf6PE7Na+rJenhrg6HKeihqqsriK8vLXKU9J590bCn+8gm1WZKVeO8kMYK0qr/5Fhp
	v1y5P+UEJTTMGIXcQ++Vfonv++2WzIAhYQX7qDiN5xx1JrXi97CIHd9jMCukdB78XKtYnSD+5vv
	3jT+qLVsA9s1sYROn6fReqo1W4KXh6HWx8CMrQnAHbCv3DgAUAFcbYPLqqxOOy8hFwQcxgkBQxW
	eZcv/UGIRBP8VpFq1oa/CTbkuCHW2frjN9DmMh78xOn7jft2OI85
X-Google-Smtp-Source: AGHT+IFmRFolhslnQ3wJmOGKd1ZC652Hspez4xyKqE787ovmelWtlRNlsVeweq4XaspxJpAb3qWHMg==
X-Received: by 2002:a17:907:2d09:b0:ae0:d1f3:f7f4 with SMTP id a640c23a62f3a-ae3c2a963d8mr240306566b.13.1751448323235;
        Wed, 02 Jul 2025 02:25:23 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca2edcsm1027763066b.180.2025.07.02.02.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:25:22 -0700 (PDT)
Date: Wed, 2 Jul 2025 02:25:20 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, gustavold@gmail.com
Subject: Re: [PATCH net-next 6/7] netpoll: move Ethernet setup to push_eth()
 helper
Message-ID: <aGT7ALhW060Tv22l@gmail.com>
References: <20250627-netpoll_untagle_ip-v1-0-61a21692f84a@debian.org>
 <20250627-netpoll_untagle_ip-v1-6-61a21692f84a@debian.org>
 <20250701175325.5c1970b9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701175325.5c1970b9@kernel.org>

On Tue, Jul 01, 2025 at 05:53:25PM -0700, Jakub Kicinski wrote:
> On Fri, 27 Jun 2025 10:55:52 -0700 Breno Leitao wrote:
> > +static void push_eth(struct netpoll *np, struct sk_buff *skb)
> > +{
> > +	struct ethhdr *eth;
> > +
> > +	eth = eth_hdr(skb);
> > +	ether_addr_copy(eth->h_source, np->dev->dev_addr);
> > +	ether_addr_copy(eth->h_dest, np->remote_mac);
> > +}
> 
> Can you move the pushing of the header and setting h_proto here?
> 
> if the goal of the series is to slice up the code per network layer
> then its a bit odd for the IP layer handlers to be pushing the L2
> header and setting its proto.
> 
> Just:
> 
> 	if (np->ipv6)
> 		eth->h_proto = htons(ETH_P_IPV6);
> 	else
> 		eth->h_proto = htons(ETH_P_IP);
> 
> no?

yes. We can do it. In fact, if we want to do even better, we can move
the can move the skb_push(skb, ETH_HLEN) and skb_reset_mac_header() here
as well. This will slice up the code even better.

The function will look like the following:

	static void push_eth(struct netpoll *np, struct sk_buff *skb)
	{
		struct ethhdr *eth;

		eth = skb_push(skb, ETH_HLEN);
		skb_reset_mac_header(skb);
		ether_addr_copy(eth->h_source, np->dev->dev_addr);
		ether_addr_copy(eth->h_dest, np->remote_mac);
		if (np->ipv6)
			eth->h_proto = htons(ETH_P_IPV6);
		else
			eth->h_proto = htons(ETH_P_IP);
	}

