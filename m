Return-Path: <linux-kselftest+bounces-30938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E03CA8B4CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 11:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91297A3D1A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 09:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92345236429;
	Wed, 16 Apr 2025 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmgFrpnO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE0235345;
	Wed, 16 Apr 2025 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794429; cv=none; b=QuTkXHDwm/ti3/9QsmjK9g7KXHCAbibKUYP2tVXz+1RfAoavIru67y6JFhKlxP3qfAua4CQKiVgvsdru0Ce1xgov6mRqmKazf6b7ZVVLzV0KSIVWpSoz4VRf90nGiN/JZp/KQZggTuDpj+X3uB1ruw58NKjrZ5cTixBTN63SD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794429; c=relaxed/simple;
	bh=aS76//CkpHphM+5vU47H6mSdOiGK7gfAzI6mpLJ7h/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9bZWg0hIh5SmWkSxZEJ8XUQ4Aimbx7mXNqLwLFckjV5iUHwMiICqJuyTs0K6/8ib9PwfBvKYywjFiLzgbxeqPufFCMMUKPs9pM7uaEHVXeG2Ho448juhHSbLVvXh8Lp6FMRXYAajv4KEEENnACb8+NprShg9I5e1n1gVEzRq58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmgFrpnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBE8C4CEE2;
	Wed, 16 Apr 2025 09:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744794428;
	bh=aS76//CkpHphM+5vU47H6mSdOiGK7gfAzI6mpLJ7h/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmgFrpnOVJMwK7jZwRrTBccyaVktATEyzxBzSZ0sEbs/tV1XivEFMlu3YWUfz5OBK
	 DxxDmBEZUr135pyQbvUT49+b9U5KZL+UjAgpiyCu5zr5/ECa5r9FAd9O678aKc+ozS
	 EI9rpg0KZclVh3UE3tMC2sRC1qHIg+iuCPjHVUuSBjVDXKk2YFrKtwna6YCZ9RKGzp
	 ji52/CvuuSZ1Gi5SznbsrzlULpVnRxI0Yfpk3NTTE83OPoIxSzsrNcglnAI8qRkbq5
	 ottuiLKMUTHXUub5zmwKt8gQk9RQRB8T3euHbhMJMuO7LyDBpg+bz3vHC9xltUDox3
	 xc5J6y8EmWx/Q==
Date: Wed, 16 Apr 2025 10:07:01 +0100
From: Simon Horman <horms@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
	ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, ij@kernel.org,
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v3 net-next 05/15] tcp: accecn: add AccECN rx byte
 counters
Message-ID: <20250416090701.GK395307@horms.kernel.org>
References: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
 <20250414131315.97456-6-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250414131315.97456-6-chia-yu.chang@nokia-bell-labs.com>

On Mon, Apr 14, 2025 at 03:13:05PM +0200, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> These counters track IP ECN field payload byte sums for all
> arriving (acceptable) packets. The AccECN option (added by
> a later patch in the series) echoes these counters back to
> sender side.
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/linux/tcp.h      |  1 +
>  include/net/tcp.h        | 18 +++++++++++++++++-
>  net/ipv4/tcp.c           |  3 ++-
>  net/ipv4/tcp_input.c     | 13 +++++++++----
>  net/ipv4/tcp_minisocks.c |  3 ++-
>  5 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index af38fff24aa4..9cbfefd693e3 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -303,6 +303,7 @@ struct tcp_sock {
>  	u32	delivered;	/* Total data packets delivered incl. rexmits */
>  	u32	delivered_ce;	/* Like the above but only ECE marked packets */
>  	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
> +	u32	received_ecn_bytes[3];
>  	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
>  		unused2:4;
>  	u32	app_limited;	/* limited until "delivered" reaches this val */

...

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 73f8cc715bff..278990dba721 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -5092,6 +5092,7 @@ static void __init tcp_struct_check(void)
>  	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
>  	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
>  	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
> +	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
>  	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
>  	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
>  	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
> @@ -5099,7 +5100,7 @@ static void __init tcp_struct_check(void)
>  	/* 32bit arches with 8byte alignment on u64 fields might need padding
>  	 * before tcp_clock_cache.
>  	 */
> -	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 97 + 7);
> +	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 109 + 3);

Hi Ilpo,

I think that incrementing 97 to 109 is correct, as 12 bytes have been
added to this group.

However, I do not think it is correct to decrement 7 to 3.

On, at least, x86_64, x86_32 and arm64 that decrement does not
cause any problems. (I assume it is also fine without the rest of this
patch).

But on (32-bit) ARM, this causes the assertion to fail.
This is because on ARM an extra 4-byte hole is added just after pred_flags.
And the assertion checks an upper bound on the size of the group.

I assume this extra hole is due to alignment requirements.
In any case on ARM, with this patch applied, pahole shows
the group looking like this:

        __u8                       __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  1869     0 */

        /* XXX 3 bytes hole, try to pack */

        __be32                     pred_flags;           /*  1872     4 */

        /* XXX 4 bytes hole, try to pack */

        u64                        tcp_clock_cache;      /*  1880     8 */
        u64                        tcp_mstamp;           /*  1888     8 */
        u32                        rcv_nxt;              /*  1896     4 */
        u32                        snd_nxt;              /*  1900     4 */
        u32                        snd_una;              /*  1904     4 */
        u32                        window_clamp;         /*  1908     4 */
        u32                        srtt_us;              /*  1912     4 */
        u32                        packets_out;          /*  1916     4 */
        /* --- cacheline 30 boundary (1920 bytes) --- */
        u32                        snd_up;               /*  1920     4 */
        u32                        delivered;            /*  1924     4 */
        u32                        delivered_ce;         /*  1928     4 */
        u32                        received_ce;          /*  1932     4 */
        u32                        received_ecn_bytes[3]; /*  1936    12 */
        u8                         received_ce_pending:4; /*  1948: 0  1 */
        u8                         unused2:4;            /*  1948: 4  1 */

        /* XXX 3 bytes hole, try to pack */

        u32                        app_limited;          /*  1952     4 */
        u32                        rcv_wnd;              /*  1956     4 */
        struct tcp_options_received rx_opt;              /*  1960    24 */
        /* --- cacheline 31 boundary (1984 bytes) --- */
        u8                         nonagle:4;            /*  1984: 0  1 */
        u8                         rate_app_limited:1;   /*  1984: 4  1 */

        /* XXX 3 bits hole, try to pack */

        __u8                       __cacheline_group_end__tcp_sock_write_txrx[0]; /*  1985     0 */

So we are now at 3 cache lines. And perhaps it is worth trying to pack
things a bit. Or perhaps that becomes tricky to get right across
different architectures. I didn't explore that.

But, taking the naive approach: with the following update, tcp.c compiles
compiles with allmodconfig on x86_64, x86_32, ARM and arm64 (I did not test
others).

	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 109 + 7);

For the record, gcc 14.2.0 reports this problem as:

  CC      net/ipv4/tcp.o
In file included from <command-line>:
In function 'tcp_struct_check',
    inlined from 'tcp_init' at net/ipv4/tcp.c:5133:2:
././include/linux/compiler_types.h:557:45: error: call to '__compiletime_assert_
1403' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct tcp_sock, __cacheline_group_end__tcp_sock_write_txrx) - offsetofend(struct tcp_sock, __cacheline_group_begin__tcp_sock_write_txrx) > 109 + 3
  557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
././include/linux/compiler_types.h:538:25: note: in definition of macro '__compiletime_assert'
  538 |                         prefix ## suffix();                             \
      |                         ^~~~~~
././include/linux/compiler_types.h:557:9: note: in expansion of macro '_compiletime_assert'
  557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
      |         ^~~~~~~~~~~~~~~~
./include/linux/cache.h:160:9: note: in expansion of macro 'BUILD_BUG_ON'
  160 |         BUILD_BUG_ON(offsetof(TYPE, __cacheline_group_end__##GROUP) - \
      |         ^~~~~~~~~~~~
net/ipv4/tcp.c:5103:9: note: in expansion of macro 'CACHELINE_ASSERT_GROUP_SIZE'
 5103 |         CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 109 + 3);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~

...

-- 
pw-bot: changes-requested

