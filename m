Return-Path: <linux-kselftest+bounces-5451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A5086820C
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 21:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AB828EB2F
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 20:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7C4130AF0;
	Mon, 26 Feb 2024 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFTKedXe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EADF1E878;
	Mon, 26 Feb 2024 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980197; cv=none; b=CdfJjekNh+rxCs5edzht5nSzVfvsckvfGn+9F/KPSSHVqC974eXmrvhzkxPtlJxJO5BEiR/VG1QrQ+ExaRz9TCp4YYUyibqoQwh0/5uKRsO3Vyv0TTTpKAXdP6GPTNBMxi+38POFhCy74pvO1WjhIJTHhhfNpKxzjrUn/s3VXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980197; c=relaxed/simple;
	bh=MdpXJHvPFyl1RGvBDZHlVxvMYdSYQEzmwqbyhU9uefI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pllEUbQcNu5kfDFWYcoVSQG1kpnvMoibO3vFQbt3U2B92MjShMut4M4osFBxhVqbiW74QuLGPSTEkGpIe/M7YWmkFuDUtdeotifXzW2BErR2SZ/6dejajnwqMpKbJ1rGEl90amxZxWL6yWT2uIsOGXu+RU0XSLcCnrLLjjfQJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFTKedXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBD2C433F1;
	Mon, 26 Feb 2024 20:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708980197;
	bh=MdpXJHvPFyl1RGvBDZHlVxvMYdSYQEzmwqbyhU9uefI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFTKedXeGids3PFaNjc8pIdSTCfpY1rxt/VGX52eFORSwm45uc6U8Oly1UDpo09jC
	 wTbTQrcU68F418dMHqJgghcgJeLiGFJyM6Uyvyc4+kOs3rzNrEal2u4J9dZPH87xjA
	 679uJKZDD04T90Tn2sYH5JMv4RGiSa0d+OEUlICSJ89mBVtWQvvHuij2mPHyqpc4yQ
	 u1LQQM9X/HNRt23aBUqs/qQw/INSsjexkrkXS5jf6JAE7nmOWP5qiczWIN1T4CdAMm
	 3wzvIOMJo53sB3obX1HRSqbkiD7nbspgIgYdPSbxgsIiI5DJnfBK3SN9F/3kcogWp+
	 tvsvsWXuRs7qw==
Date: Mon, 26 Feb 2024 20:41:42 +0000
From: Simon Horman <horms@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH net-next 03/10] net/tcp: Move tcp_inbound_hash() from
 headers
Message-ID: <20240226204142.GJ13129@kernel.org>
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
 <20240224-tcp-ao-tracepoints-v1-3-15f31b7f30a7@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224-tcp-ao-tracepoints-v1-3-15f31b7f30a7@arista.com>

On Sat, Feb 24, 2024 at 09:04:11AM +0000, Dmitry Safonov wrote:
> Two reasons:
> 1. It's grown up enough
> 2. In order to not do header spaghetti by including
>    <trace/events/tcp.h>, which is necessary for TCP tracepoints.
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>

...

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index c82dc42f57c6..5fd61ae6bcc9 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4485,6 +4485,78 @@ EXPORT_SYMBOL(tcp_inbound_md5_hash);
>  
>  #endif
>  
> +/* Called with rcu_read_lock() */
> +enum skb_drop_reason
> +tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
> +		 const struct sk_buff *skb,
> +		 const void *saddr, const void *daddr,
> +		 int family, int dif, int sdif)
> +{
> +	const struct tcphdr *th = tcp_hdr(skb);
> +	const struct tcp_ao_hdr *aoh;
> +	const __u8 *md5_location;
> +	int l3index;
> +
> +	/* Invalid option or two times meet any of auth options */
> +	if (tcp_parse_auth_options(th, &md5_location, &aoh)) {
> +		tcp_hash_fail("TCP segment has incorrect auth options set",
> +			      family, skb, "");
> +		return SKB_DROP_REASON_TCP_AUTH_HDR;
> +	}
> +
> +	if (req) {
> +		if (tcp_rsk_used_ao(req) != !!aoh) {
> +			u8 keyid, rnext, maclen;
> +
> +			if (aoh) {
> +				keyid = aoh->keyid;
> +				rnext = aoh->rnext_keyid;
> +				maclen = tcp_ao_hdr_maclen(aoh);
> +			} else {
> +				keyid = rnext = maclen = 0;
> +			}

Hi Dmitry,

it looks like keyid is set but otherwise unused.

Flagged by W=1 builds with gcc-13 and clang-17.

> +
> +			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
> +			tcp_hash_fail("TCP connection can't start/end using TCP-AO",
> +				      family, skb, "%s",
> +				      !aoh ? "missing AO" : "AO signed");
> +			return SKB_DROP_REASON_TCP_AOFAILURE;
> +		}
> +	}
> +
> +	/* sdif set, means packet ingressed via a device
> +	 * in an L3 domain and dif is set to the l3mdev
> +	 */
> +	l3index = sdif ? dif : 0;
> +
> +	/* Fast path: unsigned segments */
> +	if (likely(!md5_location && !aoh)) {
> +		/* Drop if there's TCP-MD5 or TCP-AO key with any rcvid/sndid
> +		 * for the remote peer. On TCP-AO established connection
> +		 * the last key is impossible to remove, so there's
> +		 * always at least one current_key.
> +		 */
> +		if (tcp_ao_required(sk, saddr, family, l3index, true)) {
> +			tcp_hash_fail("AO hash is required, but not found",
> +					family, skb, "L3 index %d", l3index);
> +			return SKB_DROP_REASON_TCP_AONOTFOUND;
> +		}
> +		if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family))) {
> +			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
> +			tcp_hash_fail("MD5 Hash not found",
> +				      family, skb, "L3 index %d", l3index);
> +			return SKB_DROP_REASON_TCP_MD5NOTFOUND;
> +		}
> +		return SKB_NOT_DROPPED_YET;
> +	}
> +
> +	if (aoh)
> +		return tcp_inbound_ao_hash(sk, skb, family, req, l3index, aoh);
> +
> +	return tcp_inbound_md5_hash(sk, skb, saddr, daddr, family,
> +				    l3index, md5_location);
> +}
> +
>  void tcp_done(struct sock *sk)
>  {
>  	struct request_sock *req;
> 
> -- 
> 2.43.0
> 
> 

