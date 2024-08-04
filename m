Return-Path: <linux-kselftest+bounces-14776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A029946E04
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Aug 2024 11:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3235E1F21460
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Aug 2024 09:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A242374E;
	Sun,  4 Aug 2024 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sC8kizr5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE102261D;
	Sun,  4 Aug 2024 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722764877; cv=none; b=COoOC5hXPvrJr3oAWLiSuUI59C0ulBQOorcCi3lkKbjRo4p0/o4tqB8nOL8EoqOgnsvW75eR430cY5gE3hgdAPMYHCHCM4NIOH83NCDC/vzxXxCAON4VfsKb5xANUC/p86fAzhxiKkjz/eD9ZNGR1uuE627FMj0j3sNPfNakceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722764877; c=relaxed/simple;
	bh=Y4yAUSj7QlQcoQO23GqfLCmwwtbokos9WK+Uvxuiluk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kt2GDhtGDGNnYULQcSSwd+ewfoTwlTDKf5aYIl8bRR41pJzyh84h4/8BImHWksY9FhY8seu8+0k+Q1+eLIl/Ayt8cOkiDDZYUtydfQ42hcm4SOWmelYpLrr3ATS2iSFk/gNqaal85EvRp6vsiiRiwAMQTPSg0lKJpqxitok87ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sC8kizr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2571C4AF0C;
	Sun,  4 Aug 2024 09:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722764877;
	bh=Y4yAUSj7QlQcoQO23GqfLCmwwtbokos9WK+Uvxuiluk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sC8kizr5zjsY+Xtf1ki45epTasq37SPx/lADE2WXNHlexOHZagganrAH0grQ1QhBX
	 X0O67lmLxCllk2DcPRP2DF1VIQ7CNEJYblTiXS4meoLmLysPajy5E2cmEt3oUnOWGm
	 RQ0bH+384g3aKEQ9TTqRv4clfRWDGO4uT9+jaJjlUmaZqsNzkbWN1SahPoa+MDtbCN
	 1+WVUtwab/lTFbRxOZsBtAzr1fH12Sc878eY1ZRrhg+SpcDXO0cyJ9Hi6cBFD6zDY+
	 ulob7hlECqUapbuX7lwvHSvHPu0iFVvdBNAbU2s9/cGd2tpPZNGVWhK9CO0vI+lPqI
	 dnmjqp9VbV6iQ==
Date: Sun, 4 Aug 2024 10:47:51 +0100
From: Simon Horman <horms@kernel.org>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH net-next v2 6/7] selftests/net: Synchronize client/server
 before counters checks
Message-ID: <20240804094751.GH2504122@kernel.org>
References: <20240802-tcp-ao-selftests-upd-6-12-v2-0-370c99358161@gmail.com>
 <20240802-tcp-ao-selftests-upd-6-12-v2-6-370c99358161@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802-tcp-ao-selftests-upd-6-12-v2-6-370c99358161@gmail.com>

On Fri, Aug 02, 2024 at 10:23:30AM +0100, Dmitry Safonov via B4 Relay wrote:
> From: Dmitry Safonov <0x7f454c46@gmail.com>
> 
> On tests that are expecting failure the timeout value is
> TEST_RETRANSMIT_SEC == 1 second. Which is big enough for most of devices
> under tests. But on a particularly slow machine/VM, 1 second might be
> not enough for another thread to be scheduled and attempt to connect().
> It is not a problem for tests that expect connect() to succeed as
> the timeout value for them (TEST_TIMEOUT_SEC) is intentionally bigger.
> 
> One obvious way to solve this would be to increase TEST_RETRANSMIT_SEC.
> But as all tests would increase the timeouts, that's going to sum up.
> 
> But here is less obvious way that keeps timeouts for expected connect()
> failures low: just synchronize the two threads, which will assure that
> before counter checks the other thread got a chance to run and timeout
> on connect(). The expected increase of the related counter for listen()
> socket will yet test the expected failure.
> 
> Never happens on my machine, but I suppose the majority of netdev's
> connect-deny-* flakes [1] are caused by this.
> 
> Fixes:

Hi Dmitry,

I realise it probably wasn't intended to be a fixes tag,
but it turns out to be an invalid one. Could you express this
in a different way?

> > # selftests: net/tcp_ao: connect-deny_ipv6
> > # 1..21
> > # # 462[lib/setup.c:243] rand seed 1720905426
> > # TAP version 13
> > # ok 1 Non-AO server + AO client
> > # not ok 2 Non-AO server + AO client: TCPAOKeyNotFound counter did not increase: 0 <= 0
> > # ok 3 AO server + Non-AO client
> > # ok 4 AO server + Non-AO client: counter TCPAORequired increased 0 => 1
> ...
> 
> [1]: https://netdev-3.bots.linux.dev/vmksft-tcp-ao/results/681741/6-connect-deny-ipv6/stdout
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

...

