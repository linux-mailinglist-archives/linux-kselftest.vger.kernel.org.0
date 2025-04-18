Return-Path: <linux-kselftest+bounces-31162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3A9A93C0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 19:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CEB920249
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 17:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CD1215F48;
	Fri, 18 Apr 2025 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxWc9zaH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1278F77;
	Fri, 18 Apr 2025 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744997657; cv=none; b=CMwFSPrzt40Zctv/6TJfJhPmE+dU+s8cwYjDzhSSWwfy2isKkbECAUvDQ/n0sILkhHgice40hl/rqPyLWJt9+8WMmAO24xF/Fl3I/2TUiOEM7dVVmdYNyYvLr8qWD8ZsV5OfugDgpI8L8e0a66r1+N4NGrd+CeR5WmXuS1IlK5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744997657; c=relaxed/simple;
	bh=0Vsqm82xGueWkS0v5j9KrVRXmPSL9+vOrW6u6W0Lx+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXZNBzz3fYL1yCqAzR0e55IZC63Cf2c7cxEnUVLTJrvNVCy9vIdzR9j5MocZKWgBpDH75fT/T7MwTjbhVpOiVomGgSMIyUiSJ2lfX+0NMaoHRsVxQUMJW++9oCfguhdcrzZSQyEiAAj8vLlaFm3JLT8qTmnexh0P0TvSgiepxdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxWc9zaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD9CC4CEE2;
	Fri, 18 Apr 2025 17:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744997655;
	bh=0Vsqm82xGueWkS0v5j9KrVRXmPSL9+vOrW6u6W0Lx+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxWc9zaHLYgOlXhMXyN6/tIJlbWcy6JDHlN3FhdG/FnQUGA2qQ4oDGeRmaf11Lemx
	 3SdN0vebhzk6t6w72048OwQ8QgSwSBETJycZxnq/5QPS+d04jXPMTO4BaXWGR9exFh
	 NvAI+Ga8xa3ANJtzb2ZgTOCiUTqlC1/iM0Zk0q4eZfNteN4g/C+EySa/2I8JFIk9gg
	 pKhUi5sP4tWJcrVNVoVm4si4F6cswzBf87u8PV7gaT7L6mBrAy8Aw6YlSOILvJoPrC
	 3foaWKDuErlq+H+swjzGJpBa+6y/JqHPJ5JIDpX4eJIy9nlkdMPMvY8UY9UhEWzboZ
	 34VWY49uUOXIw==
Date: Fri, 18 Apr 2025 18:34:07 +0100
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
Subject: Re: [PATCH v4 net-next 10/15] tcp: accecn: AccECN option send control
Message-ID: <20250418173407.GC2676982@horms.kernel.org>
References: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
 <20250417230029.21905-11-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417230029.21905-11-chia-yu.chang@nokia-bell-labs.com>

On Fri, Apr 18, 2025 at 01:00:24AM +0200, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> Instead of sending the option in every ACK, limit sending to
> those ACKs where the option is necessary:
> - Handshake
> - "Change-triggered ACK" + the ACK following it. The
>   2nd ACK is necessary to unambiguously indicate which
>   of the ECN byte counters in increasing. The first
>   ACK has two counters increasing due to the ecnfield
>   edge.
> - ACKs with CE to allow CEP delta validations to take
>   advantage of the option.
> - Force option to be sent every at least once per 2^22
>   bytes. The check is done using the bit edges of the
>   byte counters (avoids need for extra variables).
> - AccECN option beacon to send a few times per RTT even if
>   nothing in the ECN state requires that. The default is 3
>   times per RTT, and its period can be set via
>   sysctl_tcp_ecn_option_beacon.
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/linux/tcp.h        |  3 +++
>  include/net/netns/ipv4.h   |  1 +
>  include/net/tcp.h          |  1 +
>  net/ipv4/sysctl_net_ipv4.c |  9 ++++++++
>  net/ipv4/tcp.c             |  5 ++++-
>  net/ipv4/tcp_input.c       | 36 +++++++++++++++++++++++++++++++-
>  net/ipv4/tcp_ipv4.c        |  1 +
>  net/ipv4/tcp_minisocks.c   |  2 ++
>  net/ipv4/tcp_output.c      | 42 ++++++++++++++++++++++++++++++--------
>  9 files changed, 90 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 0e032d9631ac..9619524d8901 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -309,7 +309,10 @@ struct tcp_sock {
>  	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
>  		unused2:4;
>  	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
> +		prev_ecnfield:2,/* ECN bits from the previous segment */
> +		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
>  		est_ecnfield:2;/* ECN field for AccECN delivered estimates */
> +	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
>  	u32	app_limited;	/* limited until "delivered" reaches this val */
>  	u32	rcv_wnd;	/* Current receiver window		*/
>  /*

...

> @@ -5113,7 +5116,7 @@ static void __init tcp_struct_check(void)
>  	/* 32bit arches with 8byte alignment on u64 fields might need padding
>  	 * before tcp_clock_cache.
>  	 */
> -	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 122 + 6);
> +	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 130 + 6);

Hi,

While this seems find on x86_64, x86_32 and arm64, it does not seem correct
on ARM (32-bit).

This is because the existing two byte hole after est_ecnfield grows
to 6 bytes. I assume this is because of alignment requirements.
But in any case, the result is that the overall group size increases
by 12 bytes rather than 8.

I believe that you can avoid the hole growing, and thus limit the overall
increase in size of the group to 12 bytes, by placing accecn_opt_tstamp
elsewhere, e.g. after app_limited rather than before it.

You can exercise this by cross compiling for ARM and examining
the structure layout using pahole.

Cross compilers available from [1] should be able to do that something
like this:

PATH=".../gcc-14.2.0-nolibc/arm-linux-gnueabi/bin:$PATH"
export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabi-

make allmodconfig
echo "CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y" >> .config
yes "" | make oldconfig

make net/ipv4/tcp.o

[1] https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/14.2.0/

