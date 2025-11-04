Return-Path: <linux-kselftest+bounces-44684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A9CC2E809
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 01:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BBF3B8A97
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 00:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEAA21348;
	Tue,  4 Nov 2025 00:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTZQ4D4D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA9B661;
	Tue,  4 Nov 2025 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762214494; cv=none; b=IdTIrDqkSTK1TksWKWiqUPyZLYi1gg0wyGa7pi2oZFqagPK8yVloUihmAcpYsFzoIBdTTUjV7PRZXDWIU37xeXc/1MDN5atQ2sZmwe0bGkL1MC/3I/TPe/Xi0Tb68ZtkmtsnbBwFD7NKDnEJPXZHKnj621XYvQPhJWV9Ng+RC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762214494; c=relaxed/simple;
	bh=PBI4TLs/d9YWbkZ4Mduu1E6dsNj4T7VlJlwsZu9cCE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxbiRxtd5WGv0jiGsO3K+6XvfShC5tys61wbUoxfXi/FIXxIU+yIWChWTn8srNWEJP9gU00+5+0Z9G0AW9kZfrZG3BrDngqARal/KXFq6skjAbp7HqQrDNgqHITs4cfXbnjYg1fs4DIjcJ2uIyhKwn9MjH4Mm4+2YMenneIV2xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTZQ4D4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7677C4CEE7;
	Tue,  4 Nov 2025 00:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762214494;
	bh=PBI4TLs/d9YWbkZ4Mduu1E6dsNj4T7VlJlwsZu9cCE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WTZQ4D4Dzr6znmNDw11fjr5z7Yb+svvo702I6nPxp8SFLay3OItYdxTnpDkpgt5vb
	 WpPCOrWEoVpZtx9fKT4K+KjhSYJleYkQrV5fIbebSyHk5tWRLl3kWTvWmUWj/G+pEV
	 ZTGk9XARDBOOwktcrCaoSNrIqfK8pDpxju98PGCNxefubCSDNHtmbqKj2N2c9Kv9RA
	 ejsOZ5vJLkjCif+yGjPm7nNFYmFlrjHtN+pbJIwfmcyFbpfakY0W6SNvFM+UkwTxdE
	 GFGtHU8RXjo035cdRFhcgu0w6JJp7d5wJuFCfCOxZ/fGurti/k6PLJD8/N2E4rvdEa
	 cNnrBQ46k9DJg==
Date: Mon, 3 Nov 2025 16:01:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Wang Liang <wangliang74@huawei.com>, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 yuehaibing@huawei.com, zhangchangzhong@huawei.com
Subject: Re: [PATCH net] selftests: netdevsim: Fix ethtool-features.sh fail
Message-ID: <20251103160133.31c856a4@kernel.org>
In-Reply-To: <aQiANPQU9ZEa0zCo@krikkit>
References: <20251030032203.442961-1-wangliang74@huawei.com>
	<aQPxN5lQui5j8nK8@krikkit>
	<20251030170217.43e544ad@kernel.org>
	<aQiANPQU9ZEa0zCo@krikkit>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Nov 2025 11:13:08 +0100 Sabrina Dubroca wrote:
> 2025-10-30, 17:02:17 -0700, Jakub Kicinski wrote:
> > On Fri, 31 Oct 2025 00:13:59 +0100 Sabrina Dubroca wrote:  
> > > I guess it's improving the situation, but I've got a system with an
> > > ethtool that accepts the --json argument, but silently ignores it for
> > >  -k (ie `ethtool --json -k $DEV` succeeds but doesn't produce a json
> > > output), which will still cause the test to fail later.  
> > 
> > And --json was added to -k in Jan 2022, that's pretty long ago.
> > I'm not sure we need this aspect of the patch at all..  
> 
> Ok.  Then maybe a silly idea: for the tests that currently have some
> form of "$TOOL is too old" check, do we want to remove those after a
> while? If so, how long after the feature was introduced in $TOOL?
> 
> Or should we leave them, but not accept new checks to exclude
> really-old versions of tools?  Do we need to document the cut-off ("we
> don't support tool versions older than 2 years for networking
> selftests" [or similar]) somewhere in Documentation/ ?

FWIW my current thinking is to prioritize test development and kernel
needs over the ability to run ksft on random old set of tools and have
clean skips. IOW avoid complicating writing tests by making the author
also responsible for testing versions of all tools.

The list of tools which need to be updated or installed for all
networking tests to pass is rather long. My uneducated guess
is all these one off SKIP patches don't amount to much. Here for
example author is fixing one test, I'm pretty sure that far more
tests depend on -k --json.

Integrating with NIPA is not that hard, if someone cares about us
ensuring that the tests cleanly pass or skip in their env they should
start by reporting results to NIPA..

