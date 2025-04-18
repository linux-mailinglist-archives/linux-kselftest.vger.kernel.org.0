Return-Path: <linux-kselftest+bounces-31176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB90A93CCD
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 20:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605A58E186A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0781E2253EF;
	Fri, 18 Apr 2025 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etV9sVuV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE69224228;
	Fri, 18 Apr 2025 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745001105; cv=none; b=b/9u3C9omKZg2HaNZsSdTC3Q4gi9Yz0Bz2JZawVY/pbEQtd97DnyzxgEGIUw30UkLSVZBrq+RLdUDwHDFb23pWNRA46uN7nQTnxOkFBszgGz9HMTxKs9D4SGMf5PdG5/xycIV+RmZtBfhspfSlYnzDAlLxqRGqU7VFgEJIwvH+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745001105; c=relaxed/simple;
	bh=9WknNj7arG4qVOlM0mtC8eG1okirSPP4BfX511789ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ama64mmVK9psG393ZP+N5HMeg/AipWkIcSiSN/V2/b61N8H6wd3MrLcwJp3QJ/1JFJNAKiqOIIOW1IUpvPAtvhZak1FitGxpu2RMFnSqA6WLCa4Nxuy1A51wN6nKoqykRaELPa0TB9Y1Gm3a4wfkQXeiX6LlaP1/VyXJYNAQCJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etV9sVuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2E1C4CEE2;
	Fri, 18 Apr 2025 18:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745001105;
	bh=9WknNj7arG4qVOlM0mtC8eG1okirSPP4BfX511789ZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=etV9sVuVVYPu1hl195bLq+oCLril1kpTJti8yaRL2L9ib/Yf8dGUTasI2DN0Z/U06
	 7fk/D73wkdFOfSZyOCEvcgzCLAJgKcaTy8P2AvjAK8AI+3Q+b02Ek1FJ5AEYVWl6K5
	 wUmCZpeiee1UPOHGytr++WdH7Zi4nEyhf6CCUq5fpvkr1bp7cD40ShftON4/OIWbvb
	 QorLxy5eg1uAeQOfa0MtZjQP4yanAtm4RQTWThKqC5X7gSHtXEp8jkIFDP1Th6QJTU
	 n4QtrHrwts5PQ1ywXG3kSW6YePtikGf3ZRH4QQH55SBMnq3tK2ecu1q82z+/89gfCh
	 Nh5tN/R9VJc/A==
Date: Fri, 18 Apr 2025 19:31:38 +0100
From: Simon Horman <horms@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
	ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, ij@kernel.org,
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v4 net-next 09/15] tcp: accecn: AccECN option
Message-ID: <20250418183138.GE2676982@horms.kernel.org>
References: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
 <20250417230029.21905-10-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417230029.21905-10-chia-yu.chang@nokia-bell-labs.com>

On Fri, Apr 18, 2025 at 01:00:23AM +0200, chia-yu.chang@nokia-bell-labs.com wrote:

...

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c

...

> @@ -766,6 +769,47 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  		*ptr++ = htonl(opts->tsecr);
>  	}
>  
> +	if (OPTION_ACCECN & options) {
> +		const u8 ect0_idx = INET_ECN_ECT_0 - 1;
> +		const u8 ect1_idx = INET_ECN_ECT_1 - 1;
> +		const u8 ce_idx = INET_ECN_CE - 1;
> +		u32 e0b;
> +		u32 e1b;
> +		u32 ceb;
> +		u8 len;
> +
> +		e0b = opts->ecn_bytes[ect0_idx] + TCP_ACCECN_E0B_INIT_OFFSET;
> +		e1b = opts->ecn_bytes[ect1_idx] + TCP_ACCECN_E1B_INIT_OFFSET;
> +		ceb = opts->ecn_bytes[ce_idx] + TCP_ACCECN_CEB_INIT_OFFSET;
> +		len = TCPOLEN_ACCECN_BASE +
> +		      opts->num_accecn_fields * TCPOLEN_ACCECN_PERFIELD;
> +
> +		if (opts->num_accecn_fields == 2) {
> +			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
> +				       ((e1b >> 8) & 0xffff));
> +			*ptr++ = htonl(((e1b & 0xff) << 24) |
> +				       (ceb & 0xffffff));
> +		} else if (opts->num_accecn_fields == 1) {
> +			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
> +				       ((e1b >> 8) & 0xffff));
> +			leftover_bytes = ((e1b & 0xff) << 8) |
> +					 TCPOPT_NOP;
> +			leftover_size = 1;
> +		} else if (opts->num_accecn_fields == 0) {
> +			leftover_bytes = (TCPOPT_ACCECN1 << 8) | len;
> +			leftover_size = 2;
> +		} else if (opts->num_accecn_fields == 3) {
> +			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
> +				       ((e1b >> 8) & 0xffff));
> +			*ptr++ = htonl(((e1b & 0xff) << 24) |
> +				       (ceb & 0xffffff));
> +			*ptr++ = htonl(((e0b & 0xffffff) << 8) |
> +				       TCPOPT_NOP);
> +		}
> +		if (tp)
> +			tp->accecn_minlen = 0;

Hi,

I'm sorry if this is a false positive: Smatch flags that here we assume
that tp might be NULL, while elsewhere in this function tp is dereferenced
unconditionally. So my question is, can tp be NULL here?

> +	}
> +
>  	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
>  		*ptr++ = htonl((leftover_bytes << 16) |
>  			       (TCPOPT_SACK_PERM << 8) |

...

