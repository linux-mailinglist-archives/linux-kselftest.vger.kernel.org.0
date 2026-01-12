Return-Path: <linux-kselftest+bounces-48795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA15AD157F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 22:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 528DC3009264
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 21:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD2C3446A4;
	Mon, 12 Jan 2026 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGAGjpk5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA33340A43;
	Mon, 12 Jan 2026 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768254808; cv=none; b=jBKUTb5uZst3a0YvDbY90ljuWs62f/KCOs5IJU4SY9DCN1w7BLajOFqG/gyaJbDJiNri5xBMkG2sCepxMNddrPRFXJ4PBS1od0/WjX8P2bhl1tiQYGju4DRKFN1t/6NKSOvih63zAjIGSbX9pRW0xh7ykS8P7kuEezpzBYRx0K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768254808; c=relaxed/simple;
	bh=bONbbeDRrFb8TPKJZAoc0eVUmaD8m9rNRWxknsAZ/ts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbOdnCJRsZEcRfLx+Ag7RqqKAhzPpLo0wjyHdMf5PUB4m2WlDULrDpzPQcXSKANog91ZE5eRD7HheXqBxpimKJS6hJ81hO4tdwXOfyo4FdtA0zMkluIEQ9BN0+eTCWFlwba5umH8aWGHc0Vse8dDqYsLLEAx9AMtB19jhaZbxUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGAGjpk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A163C116D0;
	Mon, 12 Jan 2026 21:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768254807;
	bh=bONbbeDRrFb8TPKJZAoc0eVUmaD8m9rNRWxknsAZ/ts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZGAGjpk5j5S9f0bNrvrmsFjin9rqLISsQZOJCSCgPvSCHwu8ruiy0ajZMTT24Dk1n
	 y/qQYU44xPYcWCS9q+IwKyjnMwYWInr78ZmCNeE5kYaSd6CPxG8Gmhz6ricl/utiKM
	 NeMwYUNi3ekE/H5QvlgLM37qf5WLKHVWBcf2xPE86cQ21PZmjNN1fBC3FC85hRiqmV
	 r9b8rwlKETvw26Vg9uZ7MHSL/JCNKU4xzd21syCXIRWy9cmgGUccs0Ok4Avq2jnaYK
	 MAAWUByvLKcmI1xt5XfIR2L1ZXBrvoQ0/0fAq6sqqUvtIsV1VHj0dKKUAIOKMS1OZ7
	 TXhpT40kr0maQ==
Date: Mon, 12 Jan 2026 13:53:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v10 7/7] selftests: netconsole: validate target
 resume
Message-ID: <20260112135326.7ce71119@kernel.org>
In-Reply-To: <aWVarVD7DQ4uG8YZ@archlinux>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
	<20260112-netcons-retrigger-v10-7-d82ebfc2503e@gmail.com>
	<20260112061642.7092437c@kernel.org>
	<uzrkzwqpy2mf5je44xz2xtody5ajfw54v7kqb2prfib3kz7gvj@wtsjtgde5thb>
	<aWVarVD7DQ4uG8YZ@archlinux>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 20:49:02 +0000 Andre Carvalho wrote:
> > Also, do you know why we got:
> > 
> > 	/srv/vmksft/testing/wt-18/tools/testing/selftests/kselftest/runner.sh: line 50: : No such file or directory
> > 
> > after the test failed?  
> 
> I think this might be caused by a change[2] in run_kselftest.sh/runner.sh which
> seems to cause runner.sh to fail when a test failed and runner.sh was not called
> from run_kselftest.sh.

Yes! FWIW we see it in all tests in netdev :( 
Who tests the test infra, right?

It's not actually causing any functional issues for use so
I haven't followed up on this, but would be awesome to get it fixed..

