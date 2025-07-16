Return-Path: <linux-kselftest+bounces-37429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D36AB077F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 16:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41651881738
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1037B23D282;
	Wed, 16 Jul 2025 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdvsUVtw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A511C2335;
	Wed, 16 Jul 2025 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675965; cv=none; b=dRx0tSIVPVOlvbvPt+cdKYUUiOJw5/MyuhePheTJLjndYWOvYLNZhNikZwfogliguRzkJ7+jtUjRen7g+erT/jrKVkVz1QOpEHqTGwPjInYa4XKPcpz8+4u7bWQSJ9OZUZ5DpNc+B0+qpz1LcW8Glgpe7szwCFs71ftf3r00V58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675965; c=relaxed/simple;
	bh=N9SUrkNq3KKn2zkzbDNcNNFbAR128RbgvLOba/W9yP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ef2wKTx7o5SfRms0TdXeaOTaHwmW7DGKhozdctRitbljFbIPKeJo8gPFk7iYYZtDi4+gIw+o3t9ktB7dLFWRb7wZfkyhDVYxJsojU5IdBIoyZMFigFpRM/GCjfSz6VSdwqrsXA4i7SZHL4N5cd6WiA+vDOV4QD/jM1boCXnZYiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdvsUVtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93A4C4CEE7;
	Wed, 16 Jul 2025 14:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752675964;
	bh=N9SUrkNq3KKn2zkzbDNcNNFbAR128RbgvLOba/W9yP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MdvsUVtwD7/K4fZw4qsxwDfsfa4G2P48z430/9vSItOs18NVSN/V15Phg1hxiF9B9
	 xQ42plymaXG4hmUGtDN9PwDvvIs7e9W33RCzzTG3u7PNj96kyDiwr/eLiNcHqA+0iR
	 gSTn1NwxK9dOS0GxGshLdH654wF8z2BAR91+m16lP9uQn/+QQ/PLR8ovzgdtKsyn5x
	 QBxpOgr3fSgE81Gx59A7N4/rhTbJefEUOyHJITtpszB0oYpihmk5U3783e/nK66EA7
	 c3m1ucMb8z10K+fBjSqgeOmC5X0M8eZgh7RfcyXel81eWYzrozWP9pf49j1LseC55M
	 7ig9rUiLxK7Ig==
Date: Wed, 16 Jul 2025 07:26:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Christoph Paasch
 <cpaasch@openai.com>, Davide Caratti <dcaratti@redhat.com>, Florian
 Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] selftests: mptcp: connect: cover alt modes
Message-ID: <20250716072602.386a8963@kernel.org>
In-Reply-To: <20250715185308.2ad30691@kernel.org>
References: <20250715-net-mptcp-sft-connect-alt-v2-0-8230ddd82454@kernel.org>
	<20250715185308.2ad30691@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Jul 2025 18:53:08 -0700 Jakub Kicinski wrote:
> On Tue, 15 Jul 2025 20:43:27 +0200 Matthieu Baerts (NGI0) wrote:
> > mptcp_connect.sh can be executed manually with "-m <MODE>" and "-C" to
> > make sure everything works as expected when using "mmap" and "sendfile"
> > modes instead of "poll", and with the MPTCP checksum support.
> >=20
> > These modes should be validated, but they are not when the selftests are
> > executed via the kselftest helpers. It means that most CIs validating
> > these selftests, like NIPA for the net development trees and LKFT for
> > the stable ones, are not covering these modes.
> >=20
> > To fix that, new test programs have been added, simply calling
> > mptcp_connect.sh with the right parameters.
> >=20
> > The first patch can be backported up to v5.6, and the second one up to
> > v5.14. =20
>=20
> Looks like the failures that Paolo flagged yesterday:
>=20
> https://lore.kernel.org/all/a7a89aa2-7354-42c7-8219-99a3cafd3b33@redhat.c=
om/
>=20
> are back as soon as this hit NIPA :(
>=20
> https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2025-07-16--=
00-00&executor=3Dvmksft-mptcp&pw-n=3D0&pass=3D0
>=20
> No idea why TBH, the tests run sequentially and connect.sh run before
> any of the new ones.
>=20
> I'm gonna leave it in patchwork in case the next run is clean,
> please use pw-bot to discard them if they keep failing.

It failed again on the latest run, in a somewhat more concerning way :(

# (duration 30279ms) [FAIL] file received by server does not match (in, out=
):
# -rw------- 1 root root 5171914 Jul 16 05:24 /tmp/tmp.W2c96hxSIz
# Trailing bytes are:=20
# w,=D1=90)-rw------- 1 root root 5166208 Jul 16 05:24 /tmp/tmp.s33PNcrN6M
# Trailing bytes are:=20
# (<v /&^<=D6=B1rnFsaC7INFO: with peek mode: saveAfterPeek

https://netdev-3.bots.linux.dev/vmksft-mptcp/results/211121/4-mptcp-connect=
-sh/stdout

BTW feeding the random data into hexdump-like formatter seems
advisable? :P

