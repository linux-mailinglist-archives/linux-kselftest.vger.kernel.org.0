Return-Path: <linux-kselftest+bounces-7000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8739D895AAE
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 19:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1AC01C244EB
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 17:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D3E15A497;
	Tue,  2 Apr 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6KWprOh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C785D15A480;
	Tue,  2 Apr 2024 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079072; cv=none; b=EquWYUB2JJYRXZiKKoWJkgGfrGwYnfjUmExoFFvyMlWUv0lNSLarSf3Zjz42prolFaXAh4mhBBV68Z1+1SxbEGJukFt81OQxIgDxY4ut4214QoHPkcqwI3dquFJAz/0HcIWtdDQs9w0tY+rcuY+jFi0IQo3sSPDwgosCZ5AHaAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079072; c=relaxed/simple;
	bh=uXqer8xGUPzhTKDmmP4QK+Ndbq0iw1AxkoIhjNloHxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAknk9hRbcEzrumSJkKTgo7IlOrW3A4/qpD4lrIq1ynj05JWLuk1weVNcopo6+YP/52reakzWRdI+LaRrawAJm4wFWFtN/atsqM7n96WlFPv2SMYiAZHQodkWrcOnj7e09iPxFgLkYQ+Fp1J8qPssu1LT7sEwy9IR5TeswH1JgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6KWprOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1055BC433C7;
	Tue,  2 Apr 2024 17:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712079072;
	bh=uXqer8xGUPzhTKDmmP4QK+Ndbq0iw1AxkoIhjNloHxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R6KWprOh9o9bBKeo1I0Mh6XMIjJTi0E6JS49H88/P+iBPBaoBG2YvTIdReb0y/gus
	 6YyomJ3VwpiHxXtb4sLbgi9vVN/BZz/sOB143Y6KGUU6LztE90Ug3Rm0hBYCb4IwD7
	 LY9MWq11drIclFY1hw2D7k2pLHfLyD+E0RhXp13FzI2OSMP/woGTm1oFeiZJpIeirs
	 X6uao9UcNF79bZC/yDJqf53ZgQ2QQlsE6Juw/MVgNL+k5MsqEfjO1jqSRxAk+Ifxf6
	 Y4/xcWtFIgmjHedOf5NsEVhE/MNcQIcOvlopBvWda7bv5+Qps9UiEmaJ+8Opb3LT70
	 rvDwBPpXmAYug==
Date: Tue, 2 Apr 2024 10:31:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <shuah@kernel.org>, <sdf@google.com>,
 <donald.hunter@gmail.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 7/7] testing: net-drv: add a driver test for
 stats reporting
Message-ID: <20240402103111.7d190fb1@kernel.org>
In-Reply-To: <87bk6rit8f.fsf@nvidia.com>
References: <20240402010520.1209517-1-kuba@kernel.org>
	<20240402010520.1209517-8-kuba@kernel.org>
	<87bk6rit8f.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 18:37:44 +0200 Petr Machata wrote:
> Yeah, this would be usually done through context managers, as I mention
> in the other e-mail. But then cfg would be lexically scoped, which IMHO
> is a good thing, but then it needs to be passed around as an argument,
> and that makes the ksft_run() invocation a bit messy:
> 
>     with NetDrvEnv(__file__) as cfg:
>         ksft_run([lambda: check_pause(cfg),
>                   lambda: check_fec(cfg),
>                   lambda: pkt_byte_sum(cfg)])
> 
> Dunno, maybe it could forward *args **kwargs to the cases? But then it
> loses some of the readability again.

Yes, I was wondering about that. It must be doable, IIRC 
the multi-threading API "injects" args from a tuple.
I was thinking something along the lines of:

    with NetDrvEnv(__file__) as cfg:
        ksft_run([check_pause, check_fec, pkt_byte_sum],
                 args=(cfg, ))

I got lazy, let me take a closer look. Another benefit
will be that once we pass in "env" / cfg - we can "register" 
objects in there for auto-cleanup (in the future, current
tests don't need cleanup)

