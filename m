Return-Path: <linux-kselftest+bounces-31668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FC1A9D6B6
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 02:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F101C0048D
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 00:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4CA1E5216;
	Sat, 26 Apr 2025 00:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfBEBwGP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F553189902;
	Sat, 26 Apr 2025 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745627578; cv=none; b=GsICfiJTGjSbHs+l6KaDy2AW3NeV8RYn3O9VVS5r131JdnXtt5ljSd0CA8gBNR1TvkeVvr9PyTepW1bx1W9XZuZa68/ZP8Ut+ztI9jnk9sUPVvoAcihxkz5iO7prgq4lvTrtQEWSH4xHQgm37z4JBWKhv9MdEpxWJVgO7PMnCoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745627578; c=relaxed/simple;
	bh=r4tbH7YrDazlJfWH5yYSSVu8DfUqSDZABMG/nfDicww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1tUEjif4Tpy1KHIlrdeK6zmUbZT8ubnQPmQIu1nfps4ngo3hYeiCcpjGiHx33MKdcR05Q7beKXtz3VKIL6SgWM+Fa3NXyNlx4nN5A5YQyeDOwO4fqxQITVZlAQv1x4L9lvgmCxSQ79A5CF0G8Yhd8h8uVcmg8CdyQIA4IOb30s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfBEBwGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD30C4CEE4;
	Sat, 26 Apr 2025 00:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745627577;
	bh=r4tbH7YrDazlJfWH5yYSSVu8DfUqSDZABMG/nfDicww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RfBEBwGPrTNBB+eJaHNdx42JeHWb1xdFDnJzgcQjCDwOjnke5IOv3vj6zAGeyL2UG
	 0vwSxrrsQbiGPJo2hJ5NhGeqLWJ/efkxfCTQqXGA//QgmzOqd6rkcCTZXcyyI6enRI
	 a2l8PQfja1ZMqww1WK79IjrsIqiAYoBWeN4po9aRLanoUy7cRCzgA+S9VhlgCK25K5
	 l5nxjIPr2ZWSyfQ3jte1kYkYt+0Ej5ZnIcApvItMUfKgWyWtnvNg7ozHsDPXDuA3Bo
	 Mhf9T/8TyaawKnThOdww1Qds+y3Ey0x4885e3xfdJNTpR1tJSizqRTrGue+nbKuYd5
	 j51QGDTNGo6YQ==
Date: Fri, 25 Apr 2025 17:32:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: ncardwell@google.com
Cc: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org, dsahern@kernel.org,
 kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dave.taht@gmail.com, pabeni@redhat.com, jhs@mojatatu.com,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v5 net-next 00/15] AccECN protocol patch series
Message-ID: <20250425173256.6880ece8@kernel.org>
In-Reply-To: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Apr 2025 17:35:47 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
> Chia-Yu Chang (1):
>   tcp: accecn: AccECN option failure handling
>=20
> Ilpo J=C3=A4rvinen (14):
>   tcp: reorganize SYN ECN code
>   tcp: fast path functions later
>   tcp: AccECN core
>   tcp: accecn: AccECN negotiation
>   tcp: accecn: add AccECN rx byte counters
>   tcp: accecn: AccECN needs to know delivered bytes
>   tcp: allow embedding leftover into option padding
>   tcp: sack option handling improvements
>   tcp: accecn: AccECN option
>   tcp: accecn: AccECN option send control
>   tcp: accecn: AccECN option ceb/cep heuristic
>   tcp: accecn: AccECN ACE field multi-wrap heuristic
>   tcp: accecn: try to fit AccECN option with SACK
>   tcp: try to avoid safer when ACKs are thinned

Hi Neal! Could you pass your judgment on these?
Given Eric is AFK / busy.

