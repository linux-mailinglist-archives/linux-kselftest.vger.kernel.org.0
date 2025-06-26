Return-Path: <linux-kselftest+bounces-35843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3EDAE9800
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 10:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0634E0154
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A277C25F793;
	Thu, 26 Jun 2025 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjFvrUMT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7549725C712;
	Thu, 26 Jun 2025 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925884; cv=none; b=DV3ezoSX5RhW9jifqNF7xl9TPmKvo7Al3uxsiTLDHTgiFANBJ7ztflNUYggwyX1DqnAH9KgCwMKGqq5D/ihy2bW1JK92x2AYRlBoMkJlVzQGskEUP8XnUNaEEk39Jg/psxstU9YeLetiuAdOQeuiDhb/h35RfrE6B7YyK8X+Zkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925884; c=relaxed/simple;
	bh=nw32RVdX+sPxj5/rkp3fDWbgLPASW4ZNwW2EgR81hY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwGi8u9Bnl5YtXCe4mLGci5ADeJahhAIXVDIARyRCIdc9yynXX9X2phujVY08uCRfAWClNe7XFPFc+NLqj57CzSxKc0i13qvnD19NzHG9Mzf4Bhklzdi3lJ41XeKOGuMiqgbPlKeoeUvhpTPXAzXxI/qo4957z6n/bOBbhZjLWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjFvrUMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C91DC4CEEB;
	Thu, 26 Jun 2025 08:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750925884;
	bh=nw32RVdX+sPxj5/rkp3fDWbgLPASW4ZNwW2EgR81hY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjFvrUMTZeqVFVWmPj6l/dNsJiepWMU78PBkVm726SNdtI5hGDmSJCu4+6RDkhLLn
	 qqmfmOMY5rHyIZBG9WcKcjp5QlMB4gG5YNg7EV2HqA/kxAkvKJqnPhbZc3b1m2LHEY
	 MU2F4I82+9A02ABknSba6WNFRG67ZpSwJ/aE0pzPxzCLDSCWe7tNnGAmXI0wDYTYHT
	 bzRjJOEvsETaGkZTq/YH/rbSnRYoP1/U3BKem0TveGfDFuBV4QsFRMtxsOOz3wvEaz
	 tbtD8siEMyDIS6Pwn/pEGZ3Y9sDvPUSyTdgXGqRsR8d3aZC0Mx/S1LtHgYWL80LvYp
	 CIy98Nay2IitA==
Date: Thu, 26 Jun 2025 09:17:59 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	bpf@vger.kernel.org, gustavold@gmail.com,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v2 0/4] selftest: net: Add selftest for netpoll
Message-ID: <20250626081759.GS1562@horms.kernel.org>
References: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
 <20250625184346.GM1562@horms.kernel.org>
 <20250625144604.3f60d09d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625144604.3f60d09d@kernel.org>

On Wed, Jun 25, 2025 at 02:46:04PM -0700, Jakub Kicinski wrote:
> On Wed, 25 Jun 2025 19:43:46 +0100 Simon Horman wrote:
> > # # Exception| Traceback (most recent call last):
> > # # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/net/lib/py/ksft.py", line 243, in ksft_run
> > # # Exception|     case(*args)
> > # # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./netpoll_basic.py", line 308, in test_netpoll
> > # # Exception|     do_netpoll_flush_monitored(cfg, netdevnl, ifname, target_name)
> > # # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./netpoll_basic.py", line 243, in do_netpoll_flush_monitored
> > # # Exception|     do_netpoll_flush(cfg, netdevnl, ifname, target_name)
> > # # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./netpoll_basic.py", line 278, in do_netpoll_flush
> > # # Exception|     if bpftrace_any_hit(join=False):
> > # # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./netpoll_basic.py", line 230, in bpftrace_any_hit
> > # # Exception|     raise KsftFailEx(f"bpftrace failed to run!?: {MAPS}")
> > # # Exception| net.lib.py.ksft.KsftFailEx: bpftrace failed to run!?: {}
> 
> Looks like I haven't added bpftrace to the image before.
> Fixed now.

Thanks, it looks good now.

