Return-Path: <linux-kselftest+bounces-37613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE5DB0AE9B
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 10:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AAB1C201DC
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 08:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C5923507E;
	Sat, 19 Jul 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJd5L2vA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AFA1D90C8;
	Sat, 19 Jul 2025 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752913316; cv=none; b=EEf9DKcwpHTSGdSw9Tn466bmE8sIhM+ThmlxYLx3NI7wYy5bMoHM5glnyYtvQXJt/WqMIutpXN8W0EFGWV3IDt6FUDbcuxv00iyuOmUyt6VfSTrTgtd268uA88ij9AixjwPaIdMenXdJiQ47kbiXpQS/97E6uQJvhCoye72EHn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752913316; c=relaxed/simple;
	bh=K3obeuqOlZ0dOsy9POpDIMdiMQA5/BwRN6ASQEjGPL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8J/R+yqOr9HoCyMg7NFp8aYpnJ41y2yfOwDiXq5u7JwpMix+0hqB71pMqTqNYoCuNOnTx5qeJGcsZbyiit3rKQJ8QZnzIZh+CsvaCJOMKI8SfiodpkTtlLO5Q+x4k3FyKG7vYMvyFVY1itPtRpb4GRy1ZcNHqopEHunMAMmBCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJd5L2vA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30A0C4CEF4;
	Sat, 19 Jul 2025 08:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752913315;
	bh=K3obeuqOlZ0dOsy9POpDIMdiMQA5/BwRN6ASQEjGPL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJd5L2vAZ3K4Zas346UWsng/P35XCs8z8hc2xSX+/KHx6hCr7ihi9CoLbdDu00uWJ
	 zRKNkNstvdtQ2VHxPgI0XQ/NDy+WiqPEDGLGsCrwUuFB6LOYT+7npgUxrDCHfNh20f
	 i7G3k0PFTV9vLfQbYku6SwKoMXoCDtSG1E7dNEvgS+p9W45uFeM8kc2sMnFK+30OVC
	 pJX0+z2xAn04DZnhGvFQNXDCl4nquEc637Xhb8p5FM35YR8rkw/ej8XX+z8IR95UvI
	 woI8vB1wOT4PpUlBLSZ18A9Sw9UiFb/FMbJb/4hcSjV/okUivVEaVviUYJelHt8uWy
	 bnpPNEcnoCtMA==
Date: Sat, 19 Jul 2025 09:21:47 +0100
From: Simon Horman <horms@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, linux-doc@vger.kernel.org,
	corbet@lwn.net, dsahern@kernel.org, kuniyu@amazon.com,
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com,
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net,
	liuhangbin@gmail.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, ij@kernel.org,
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v13 net-next 11/14] tcp: accecn: AccECN option send
 control
Message-ID: <20250719082147.GP2459@horms.kernel.org>
References: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
 <20250718142032.10725-12-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718142032.10725-12-chia-yu.chang@nokia-bell-labs.com>

On Fri, Jul 18, 2025 at 04:20:29PM +0200, chia-yu.chang@nokia-bell-labs.com wrote:

> @@ -549,4 +589,16 @@ tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
>  		th->ece = 1;
>  }
>  
> +static inline bool tcp_accecn_option_beacon_check(const struct sock *sk)
> +{
> +	u32 ecn_beacon = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon);
> +	struct tcp_sock *tp = tcp_sk(sk);

Hi Chia-Yu Chang,

This is not a full review, but I have observed a minor problem with this
patch.

Commit e9d9da91548b ("tcp: preserve const qualifier in tcp_sk()")
updated tcp_sk so that, as it's subject says, the const qualifier
of it's argument is preserved.

But here sk is not const while tp is not.

I think the solution here is to make tp const.

	const struct tcp_sock *tp = tcp_sk(sk);

Flagged by GCC 15.1.0 and Clang 20.1.8 allmodconfig builds.

> +
> +	if (!ecn_beacon)
> +		return false;
> +
> +	return tcp_stamp_us_delta(tp->tcp_mstamp, tp->accecn_opt_tstamp) * ecn_beacon >=
> +	       (tp->srtt_us >> 3);
> +}
> +
>  #endif /* _LINUX_TCP_ECN_H */

-- 
pw-bot: changes-requested

