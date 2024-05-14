Return-Path: <linux-kselftest+bounces-10177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CF08C57C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 16:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072931F22F39
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 14:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E2E144D0D;
	Tue, 14 May 2024 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRHLFM1O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA991448FA;
	Tue, 14 May 2024 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696049; cv=none; b=BGAsBzSjfL2bDHvOCDzP/ZWIZFMrXGtAUenP37dUiW0Y/F/KY/ebEk9TDl/0Fvwf3lP6+/ov27AVKzY/eFdQWrqiaeTaOUkYnWY3xt2xk3Ya+GLGCRT0jhmpr7AhWZFul2OFbUM35I/N/TNV8t7zBsBIyjika0IOtpelohvtTpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696049; c=relaxed/simple;
	bh=+/XMlJVKnxry0HBzpovXflduCo1gSKAOkS2cYsvQ6BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVo9amqxw9V1gw0zThICeXDDf7pp0hQUFo0q6yKsBnaUgVyvM91izd2m1vSRIW0q2PCTSdRE045VOA6AqUxfGvVNZO8PEAy2+aEzb6U/WsNkNGFJeQAjT42IMrLhB1V1Ht1TNOkDu7dr09OajrCEoJ9fdJYGXCqpVBIhEjz3I0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRHLFM1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2930DC2BD10;
	Tue, 14 May 2024 14:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715696048;
	bh=+/XMlJVKnxry0HBzpovXflduCo1gSKAOkS2cYsvQ6BQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bRHLFM1O2KK0YrmD+afG+KI/52PlB9P4RUmbMEhqQ0QXjJeqbE7P+kMXYJrQiGtXU
	 MGothE7RUCv+OtPc6icUiX3CGY232Z4KLSw1RHos2UR0XHDflUXzj9ShUstAyUQJql
	 aicEBJQyolaH/2S3nTa9/g6vvNQZtizc94YekF92CufdUqPI+fu54nFQHQ+tc1HGbb
	 Qv9qImzK//kR0EUzX+MLQiUN5FaBJLmkXtezjyTQ/uVKh+hAUortGVMbEnqX8d8fh6
	 zOTfX4s9UV2nuPCr2za0ALTDZfazgo3gY/cBen0YI+8Rq346QgSKwF7TYMXSUPjxZd
	 7vRWfXia+DfeA==
Date: Tue, 14 May 2024 07:14:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
 dsahern@kernel.org, alexander.duyck@gmail.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v10 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
Message-ID: <20240514071407.257c0003@kernel.org>
In-Reply-To: <CAMuHMdXFJwxexojG+41ppD=2EmyXsVM6bwh+-cxCxfSsM_yJiw@mail.gmail.com>
References: <20240509190819.2985-1-richardbgobert@gmail.com>
	<20240509190819.2985-3-richardbgobert@gmail.com>
	<CAMuHMdXFJwxexojG+41ppD=2EmyXsVM6bwh+-cxCxfSsM_yJiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 May 2024 14:13:21 +0200 Geert Uytterhoeven wrote:
> On Thu, May 9, 2024 at 9:09=E2=80=AFPM Richard Gobert <richardbgobert@gma=
il.com> wrote:
> > {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> > iph->id, ...) against all packets in a loop. These flush checks are use=
d in
> > all merging UDP and TCP flows.
> >
> > These checks need to be done only once and only against the found p skb,
> > since they only affect flush and not same_flow.
> >
> > This patch leverages correct network header offsets from the cb for both
> > outer and inner network headers - allowing these checks to be done only
> > once, in tcp_gro_receive and udp_gro_receive_segment. As a result,
> > NAPI_GRO_CB(p)->flush is not used at all. In addition, flush_id checks =
are
> > more declarative and contained in inet_gro_flush, thus removing the need
> > for flush_id in napi_gro_cb.
> >
> > This results in less parsing code for non-loop flush tests for TCP and =
UDP
> > flows.
> >
> > To make sure results are not within noise range - I've made netfilter d=
rop
> > all TCP packets, and measured CPU performance in GRO (in this case GRO =
is
> > responsible for about 50% of the CPU utilization).
> >
> > perf top while replaying 64 parallel IP/TCP streams merging in GRO:
> > (gro_receive_network_flush is compiled inline to tcp_gro_receive)
> > net-next:
> >         6.94% [kernel] [k] inet_gro_receive
> >         3.02% [kernel] [k] tcp_gro_receive
> >
> > patch applied:
> >         4.27% [kernel] [k] tcp_gro_receive
> >         4.22% [kernel] [k] inet_gro_receive
> >
> > perf top while replaying 64 parallel IP/IP/TCP streams merging in GRO (=
same
> > results for any encapsulation, in this case inet_gro_receive is top
> > offender in net-next)
> > net-next:
> >         10.09% [kernel] [k] inet_gro_receive
> >         2.08% [kernel] [k] tcp_gro_receive
> >
> > patch applied:
> >         6.97% [kernel] [k] inet_gro_receive
> >         3.68% [kernel] [k] tcp_gro_receive
> >
> > Signed-off-by: Richard Gobert <richardbgobert@gmail.com> =20
>=20
> Thanks for your patch, which is now commit 4b0ebbca3e167976 ("net: gro:
> move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment")
> in net-next/main (next-20240514).
>=20
> noreply@ellerman.id.au reports build failures on m68k, e.g.
> http://kisskb.ellerman.id.au/kisskb/buildresult/15168903/
>=20
>     net/core/gro.c: In function =E2=80=98dev_gro_receive=E2=80=99:
>     ././include/linux/compiler_types.h:460:38: error: call to
> =E2=80=98__compiletime_assert_654=E2=80=99 declared with attribute error:=
 BUILD_BUG_ON
> failed: !IS_ALIGNED(offsetof(struct napi_gro_cb, zeroed), sizeof(u32))

Hi Richard, any chance of getting this fixed within the next 2 hours?
I can't send the net-next PR if it doesn't build on one of the arches..

