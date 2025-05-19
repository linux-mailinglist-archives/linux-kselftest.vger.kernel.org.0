Return-Path: <linux-kselftest+bounces-33354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D77ABCBA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 01:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FA0189DB34
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 23:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6846021FF2C;
	Mon, 19 May 2025 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uc1fUYrG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F3A21CC71;
	Mon, 19 May 2025 23:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747698114; cv=none; b=nwO0nNRoRdQc+bInkSBM+WJ2tjCel5RjPnkQLLbPvOL7DXYo9PDj8lJtQPVdWt5eWdoH2z5gfc0C9pJrVq9a5ooFzCv3t8m9H9yrj7kCg1mA4dzH9f6s8lTcoD7yG6BbmFd+p70F0NkI1BjOR8puVi9q+cMcmye1hGuH4QI+lXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747698114; c=relaxed/simple;
	bh=5z1WM3OIDnbZGYJ0xBMhTVCHeat3pUrd1p1QkCOys8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdZcwRvKgr1tdBh/zj1Bf67h16kxL/gXIHhFQiA37i0cVp5NVkYimV9rlVhL0GdU5S+3agMEIdQZnZYo7hYzGPOaINHKJq7N6aso3rQoI0uvjKMjwPWGbdLsVt0VlDjfWLE2tadN9vMOTmAXFOJCS45xmbXdAMg6ZYR5awAlrN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uc1fUYrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD98C4CEE4;
	Mon, 19 May 2025 23:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747698113;
	bh=5z1WM3OIDnbZGYJ0xBMhTVCHeat3pUrd1p1QkCOys8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uc1fUYrGrFjHrUFU0vsNzNgh0WWGGedEzLe+9sWeAAJkMLjDsr89mF6fHjmRTwa9Z
	 ui+AlCQQ5hBDJb06omHxBaJ5farzURyH/nZJ21LCi1HphLFUbeOLr7S9m3UbOSFvnS
	 UZo5ebjB8ZIl5f9MG0900Z4JUUTlr+hMFRRH2uAu19AgahbNLHf3tBzWlyE0Zww+o6
	 TzdZFKoUsQwvVerXoxmjJRsXdvhV9GZ0OM4jQK30D2eLfdNf204BRYCVdC84LDNfdk
	 MgF1fF5jN9sLm7xyy8PFy2u6YeTahBW6rflqRKpZNIgpYqfbs5Es3VAjQJRdf9DCq5
	 ToHAitPNn930Q==
Date: Mon, 19 May 2025 16:41:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima
 <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
 ap420073@gmail.com, praan@google.com, shivajikant@google.com
Subject: Re: [PATCH net-next v1 4/9] net: devmem: ksft: remove
 ksft_disruptive
Message-ID: <20250519164152.63d74fc7@kernel.org>
In-Reply-To: <aCuSECZWisb5vQUE@mini-arch>
References: <20250519023517.4062941-1-almasrymina@google.com>
	<20250519023517.4062941-5-almasrymina@google.com>
	<aCtNYJo01UfMOLfr@mini-arch>
	<CAHS8izOMLm5jLr+778nY0AdFoOWPSb+UV+1sZmOkFb5SSqTGqg@mail.gmail.com>
	<aCuSECZWisb5vQUE@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 May 2025 13:18:24 -0700 Stanislav Fomichev wrote:
> On 05/19, Mina Almasry wrote:
> > On Mon, May 19, 2025 at 8:25=E2=80=AFAM Stanislav Fomichev <stfomichev@=
gmail.com> wrote: =20
> > >
> > > On 05/19, Mina Almasry wrote: =20
> > > > As far as I can tell the ksft_disruptive here is unnecessary. These
> > > > tests are largerly independent, and when one test fails, it's nice =
to
> > > > know the results from all the other test cases. =20
> > >
> > > We currently don't do anything special for disruptive tests. I'm assu=
ming
> > > anything that changes nic configuration is disruptive and was thinkin=
g of
> > > an option to run all disruptive tests at the end of the run. But so f=
ar we
> > > haven't had any problem with mixing disruptive and non-disruptive tes=
ts,
> > > so it's all moot. I'd prefer to keep everything as is for now (or rem=
ove
> > > this whole disruptive category). =20
> >=20
> > I've noticed that if all the tests are marked disruptive, and one test
> > fails, the others don't run at all, which seems unnecessary. I'd like
> > to see if the rx test passed if the tx one failed and vice versa for
> > example. Removing the disruptive tag seems to resolve that. =20
>=20
> I don't think that's the expected behavior. Disruptive should not
> have any effect on other tests if any one fails. Any idea why it happens?

Right, this sounds odd and needs investigating.

FWIW, in my mind disruptive tests were supposed to be the tests which
can cut a single NIC machine off the network. IOW the use case is that
the NIC under test is the same NIC over which we're SSH'ing into the
machine to run the test. So we shouldn't do things like take the link
down or flush the IP addresses because it may kill our SSH connection.

Obviously every test may be somewhat disruptive, but most shouldn't
break ssh?

