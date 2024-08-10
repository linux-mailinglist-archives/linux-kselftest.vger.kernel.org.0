Return-Path: <linux-kselftest+bounces-15107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2CC94DA93
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 06:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0A61C20FB2
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 04:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9957B4409;
	Sat, 10 Aug 2024 04:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC+hdTAR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5A617991;
	Sat, 10 Aug 2024 04:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723262624; cv=none; b=j+hSR7w7OBhaSV/nk82OOpBapdjtPj1gFM0CQ9AnHqWuMD7XRoebS1gFrhrvnHcKLizPgb9ORV9F3PqgrMXkgRMai53hVjq2xaggeM3snq1FgIAPz7MLbdusdmL91OXeRwpB2OJSeDWzXb0+Fp781hSHJZ9IxYCsyCr/cFVy4dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723262624; c=relaxed/simple;
	bh=XeyjrPjqeCSM7AxOiENPWqFAphmS9vXzHj+AMdWB1/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WuQ+VnJyv7oUzpTkzcCDE5a7E73mDkAPQRq4K22qT+nQrvT1DUdLanv7Fq2OWVPCRuDP9c8YvUGocoTm+HbcAnfFlZaz+JZl6ln7NWJ7d95/Yjv2Lpr596bfaYZl/sY0OcGuzhhFIsbQU1kFi/kn3cpeC3G8x7y8eA3LYZ12mOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC+hdTAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AC0C32781;
	Sat, 10 Aug 2024 04:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723262623;
	bh=XeyjrPjqeCSM7AxOiENPWqFAphmS9vXzHj+AMdWB1/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oC+hdTARaSQMM2XjDPaZfts5E9Ne9ub9sbdwEU2iIENb4vJdc5/ymPXXYBQwK+b9y
	 IJ/R9tFZCFfAV/T0kT5xl74PyWvtak/GpMGFbiyIsGJMoSXWAlFRv4r3vcA/zYj7I0
	 MI+wVqGP5l6w71pL8mdOTK+Mn6j3ogpzvJSnK1W5WfGjpdoCECVHFRD90t+yy4N4YY
	 Sy4cUlK64ZXdYbgieDHh4DhGWsDu8sEi4znY2QRJxzMTQk9fmBhw1gBFubgriioa2c
	 LMPMQd8ifqkd+CqkrmLu8fPKcCG7xO4207+dYCzfevZXr9C32WUmAbUrYFiAS5YZ4I
	 KXXbMUVTp2T2g==
Date: Fri, 9 Aug 2024 21:03:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
 <shuah@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <willemb@google.com>, <dw@davidwei.uk>,
 <przemyslaw.kitszel@intel.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2] selftests: net: py: support verbose
 printing, display executed commands
Message-ID: <20240809210342.244413c1@kernel.org>
In-Reply-To: <87jzgpna14.fsf@nvidia.com>
References: <20240807002445.3833895-1-mohsin.bashr@gmail.com>
	<87jzgpna14.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Aug 2024 14:36:17 +0200 Petr Machata wrote:
> > +    env_level = env.get('VERBOSE')
> > +    set_verbosity(env_level)
> > +  
> 
> Actually, the ksft_setup() here was merged last week, and I think that
> would be a better place to put this stuff. It already handles
> DISRUPTIVE, it should IMHO handle VERBOSE as well.

I was wondering about that too, FWIW, but the counter argument is that
VERBOSE has little to do with ksft. It doesn't even include the #
prefix on the list it outputs by itself (unlike ksft_pr() which does).

Maybe we do as you suggest but rename verbose() to ksft_dbg() and
make it act more like ksft_pr()?

