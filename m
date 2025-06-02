Return-Path: <linux-kselftest+bounces-34142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06EAACB590
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 17:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 978857A288B
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BF0235368;
	Mon,  2 Jun 2025 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOtXMxjN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BBB22A7E7;
	Mon,  2 Jun 2025 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876269; cv=none; b=qgEZ6q+g6sDhE/L4GcQ50YzIZ1df96EuoEnwA4XbhXOlMSWbaQOoSK5KFxcf+5SZckFnQ8rM69c7ngHNDXruDPIlQYw/jjipN2MabBX88b4lgCWepHT0V1sTE48xO4GBa77biIyXcPPa+VYxf9evbaFUfxvM1QhOy+FQid1cPR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876269; c=relaxed/simple;
	bh=7/GwFnUoybapJR599zoM5MB4TOiyfiBtcDw/J/8MSmo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGzJWkhRTcyld3OaNiRSLDcggp/XSHeKDdIfRtDJZsbHbKPDQC5o94OfJwFmkvbXe7jJahKXPqvHsxys0TEGPY1QnDt53tmau9ayluTte/49dDVw8V5pHylKq2r2FE1wELUo4Afl0JDlA5zbBz4WRx5HW7vhpnf7GtBXmBrFL38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOtXMxjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38107C4CEEE;
	Mon,  2 Jun 2025 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748876268;
	bh=7/GwFnUoybapJR599zoM5MB4TOiyfiBtcDw/J/8MSmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FOtXMxjNqidmvV5l1IZT/jKSFalSgXfIiBmU1qww2nUxJU3a2IrLLW37w5mQUwBc0
	 om3LXLou1Ks79KyuOO98VTP0vWd7h1nPu284l2KXaZ2YxkNR7uOL7Gzva0A9Og4lZ7
	 JdilPQYiar0U/MiuFEPq89clqDTU9GFliG3oVHNuRiWWsSLZ+IcBojP61u+MuGkq1G
	 XAlSQTt0EDb3mU6BovKT3loZUNbEvTfHSXgPNBFWRtheybXD0xktVcGobRrNjiw0aU
	 Hv9JEJZXEEE/jiHHuf1Rc2F9mmX3yaJEWmgqqzozIHLa1aFAcIrJaZlVmTxpNXASfj
	 RHhDs63c1vu5w==
Date: Mon, 2 Jun 2025 07:57:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 gustavold@gmail.com, Usama Arif <usamaarif642@gmail.com>,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/4] netconsole: Optimize console
 registration and improve testing
Message-ID: <20250602075747.5e659655@kernel.org>
In-Reply-To: <20250602-netcons_ext-v2-0-ef88d999326d@debian.org>
References: <20250602-netcons_ext-v2-0-ef88d999326d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 02 Jun 2025 03:34:40 -0700 Breno Leitao wrote:
> During performance analysis of console subsystem latency, I discovered that
> netconsole registers console handlers even when no active targets exist.
> These orphaned console handlers are invoked on every printk() call, get
> the lock, iterate through empty target lists, and consume CPU cycles
> without performing any useful work.
> 
> This patch series addresses the inefficiency by:
> 
> 1. Implementing dynamic console registration/unregistration based on target
>    availability, ensuring console handlers are only active when needed
> 2. Adding automatic cleanup of unused console registrations when targets
>    are disabled or removed
> 3. Extending the selftest suite to cover non-extended console format,
>    which was previously untested
> 
> The optimization reduces printk() overhead by eliminating unnecessary
> function calls and list traversals when netconsole targets are not
> configured, improving overall system performance during heavy logging
> scenarios.

Ah, I wasn't very clear, full form letter at the end.

But also the tests seem to have failed now:
https://netdev.bots.linux.dev/contest.html?branch=net-next-2025-06-02--12-00&executor=vmksft-net-drv&pw-n=0&pass=0


## Form letter - net-next-closed

Linus has already merged our PR with features for v6.16.
net-next is closed for new drivers, features, code refactoring and
optimizations for the remained for the merge window.

Please repost when net-next reopens after June 9th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed



