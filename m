Return-Path: <linux-kselftest+bounces-35844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3F5AE9834
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 10:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECB1B7A335A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A6828981B;
	Thu, 26 Jun 2025 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSW8sGjU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC30428935A;
	Thu, 26 Jun 2025 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926310; cv=none; b=TRqKQ7v9cxThUfgumNC9T9Ni2FVrYZjyONqPp40lRZz/oO7luDHBaw07QFXSQ7lkOX8Thi82eDIi6xds3NZY9722VwOC4InKj+PDPU39ALkU3jpj7S4ky3XZYlAhuXv03uOV3+36HjFPNl5MWNYgbSbcyQAQatlEr6gKxvaKc0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926310; c=relaxed/simple;
	bh=wi9NQ1zK0mlzZz//nHGzE0m6JGhSd7qTB251BohJYxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnSEGw1lxB7eZaEHXuJvRKEz8ZQoEJsWGXqVUCMLKjli8u3QVsjzrKjG7f+oMMCK8jBZFJCJcT9RvwBYuwYC3nZS8qIa5cUuw2pgb+YrqUWbHQNVYyVyx9qekKq5kmM7a9p4ix+45wBoDI0UN6/Fy7py0vclnyHLoGxfTHzeyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSW8sGjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF96C4CEEE;
	Thu, 26 Jun 2025 08:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750926310;
	bh=wi9NQ1zK0mlzZz//nHGzE0m6JGhSd7qTB251BohJYxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSW8sGjUfmwY6wSFjUi1W4iVVxZ93dCeSSogoVWh4om7huAMJZuccw/7Xdu5y+P27
	 +6/QOU1lfBinekZgWSvj1lLd3APT1MJXegdBhpSd8n6fUzLz/VCiByYZW0Qb3nfUBk
	 liBn4EmPzxwyy3JgvSU43AKFSQN1wV2Kb2pmVl9db2fzFHTfEXhxfTJScKx03i3tj0
	 poMh3/oUzFonnoes2kqDDwyUkODM4XoO+O66d3lgzPK6FqB6glDTrdx1umx89oWvri
	 dtP5dFKMGVsHWmrxHKqRVIpI3Ec3WlyclRDd7wxGehYMm02R/maaLS18zqbMS4xPOl
	 91dbCnu5RqDAQ==
Date: Thu, 26 Jun 2025 09:25:05 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	bpf@vger.kernel.org, gustavold@gmail.com
Subject: Re: [PATCH net-next v2 4/4] selftests: net: add netpoll basic
 functionality test
Message-ID: <20250626082505.GA183673@horms.kernel.org>
References: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
 <20250625-netpoll_test-v2-4-47d27775222c@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-netpoll_test-v2-4-47d27775222c@debian.org>

On Wed, Jun 25, 2025 at 04:39:49AM -0700, Breno Leitao wrote:
> Add a basic selftest for the netpoll polling mechanism, specifically
> targeting the netpoll poll() side.
> 
> The test creates a scenario where network transmission is running at
> maximum speed, and netpoll needs to poll the NIC. This is achieved by:
> 
>   1. Configuring a single RX/TX queue to create contention
>   2. Generating background traffic to saturate the interface
>   3. Sending netconsole messages to trigger netpoll polling
>   4. Using dynamic netconsole targets via configfs
>   5. Delete and create new netconsole targets after some messages
>   6. Start a bpftrace in parallel to make sure netpoll_poll_dev() is
>      called
>   7. If bpftrace exists and netpoll_poll_dev() was called, stop.
> 
> The test validates a critical netpoll code path by monitoring traffic
> flow and ensuring netpoll_poll_dev() is called when the normal TX path
> is blocked.
> 
> This addresses a gap in netpoll test coverage for a path that is
> tricky for the network stack.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Hi Breno,

As it looks like there will be another version,
could you run pylint over this. The NIPA invocation says:

  ************* Module netpoll_basic
  .../netpoll_basic.py:323:0: C0301: Line too long (111/100) (line-too-long)
  .../netpoll_basic.py:27:0: E0611: No name 'bpftrace' in module 'lib.py' (no-name-in-module)
  .../netpoll_basic.py:79:11: E0606: Possibly using variable 'rx_queue' before assignment (possibly-used-before-assignment)
  .../netpoll_basic.py:79:21: E0606: Possibly using variable 'tx_queue' before assignment (possibly-used-before-assignment)
  .../netpoll_basic.py:253:22: W0613: Unused argument 'netdevnl' (unused-argument)

