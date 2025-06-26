Return-Path: <linux-kselftest+bounces-35864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87925AEA289
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 17:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22211C43105
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 15:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020152EBBB8;
	Thu, 26 Jun 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuUMdDzL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78DB1C84A5;
	Thu, 26 Jun 2025 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951409; cv=none; b=ozxEQUxmERTddzWnF/+qzqHibY8wotsl3tZGx96RrDRdwVler+AYR9tz58m1wcHwbBaxunU0CPl2NpyRdi/RxbhmbzhE3qJ/2d5EVzkPWCz5U1vzMexmbyRNJDuMDVNkkynREe3BScXE84yV/ZdBSUNRoEtVqNS0GiGPMcUqEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951409; c=relaxed/simple;
	bh=vEqq7SNHbKwDwRCpdljmiyEtoAVY0oQq3nQHD1jkexI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqHuQp5ORrOmiOWZcQaA0tMR/uj6rYenqNZTFSTwBqvSLQwr/ebUmjlfBUIaGJhLxC/o/LzfYSePvsOQgrq2go2nzeBSn8RvXP5hW6JuuC0oMSmHoT2TqaEAb/p2JsGhI+NKM0NlxpaLKnuYVSpVHx3Ldz3zjYmXoy7NDgFo5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuUMdDzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCE1C4CEEB;
	Thu, 26 Jun 2025 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750951409;
	bh=vEqq7SNHbKwDwRCpdljmiyEtoAVY0oQq3nQHD1jkexI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PuUMdDzLr64AVJAKs03VHy3Vi5+oEh4cbkl1OFo8nyb2z4jjLWG+VX9vDwKLSh8fi
	 FGEms3ioOVvNRk2oOmqlF/UQBap49c3rAowkPjrG8gCtgMrSNmIP9ak3OCudmixtTK
	 4kXevH81AzrqT7JISRAcLV9PQGz2QyUdGFW3bcriO1KuW8kwBbBLIJ530ktsWJqQDk
	 PsFsXqd/Md6Itb9vvf9/7uYUe95iOFD3mnsfkoLu3glevc3RM4/Pphjq4AV7Tcj0jG
	 iaYo7p6thiv/vDYkPk6kv6GAlEw+kOC+JqPlqzX5bFSV8iGSoMXbPcBcnCSVCWqTHG
	 r0d3BGHbMOLNg==
Date: Thu, 26 Jun 2025 08:23:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 hawk@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 ilias.apalodimas@linaro.org, toke@toke.dk
Subject: Re: [PATCH net-next v5] page_pool: import Jesper's page_pool
 benchmark
Message-ID: <20250626082327.59888c1f@kernel.org>
In-Reply-To: <CAHS8izO9=Q3W9zvq4Qtoi_NGTo6QShV7=rGOjxz3HiAB+6rZyw@mail.gmail.com>
References: <20250619181519.3102426-1-almasrymina@google.com>
	<175072801301.3355543.12713890018845780288.git-patchwork-notify@kernel.org>
	<CAHS8izMPWjmxLWJr+BSqd5jamsFHDOm71NkG7fmm-78SkLxQTg@mail.gmail.com>
	<20250625170305.40d8c27a@kernel.org>
	<CAHS8izO9=Q3W9zvq4Qtoi_NGTo6QShV7=rGOjxz3HiAB+6rZyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 17:22:56 -0700 Mina Almasry wrote:
> What I'm hoping to do is:
> 
> 1. Have nipa run the benchmark always (or at least on patches that
> touch pp code, if that's possible), and always succeed.
> 2. The pp reviewers can always check the contest results to manually
> see if there is a regression. That's still great because it saves us
> the time of cherry-pick series and running the tests ourselves (or
> asking submitters to do that).
> 3. If we notice that the results between runs are stable, then we can
> change the test to actually fail/warn if it detects a regression (if
> fast path is > # of instructions, fail).

That's fine. I don't think putting the data on a graphs would be much
work, and clicking old results out of old runs will be a PITA. Just a
little parsing in the runner to propagate it into JSON. And a fairly
trivial bit of charts.js to fetch the runs and render UI.

> 4. If we notice that the results have too much noise, then we can
> improve the now merged benchmark to somehow make it more consistent.
> 
> FWIW, when I run the benchmark, I get very repeatable results across
> runs, especially when measuring the fast path, but nipa's mileage may
> vary.

100% on board. But someone with Meta credentials needs to add a runner
and babysit it, I have enough CI wrangling as is.

Or we wait a couple of months until we migrate to a more public setup.

