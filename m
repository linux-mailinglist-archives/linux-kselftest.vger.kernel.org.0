Return-Path: <linux-kselftest+bounces-3283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B82FB8357C3
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jan 2024 21:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71A71C20A42
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jan 2024 20:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7E6381DD;
	Sun, 21 Jan 2024 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV5+8nbI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D9FBFA;
	Sun, 21 Jan 2024 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705869462; cv=none; b=D+dZ5u/N55l4IqMiLXbUj4tK5OfDJvRpa/0KMd1SDScx2ExoHmxBMjqKbwGAPYcULJLeUUtWpIgHiu2erPyMIwdiTsN0MulmZaANR2mflNaPHwuENjXACq5PRCrmxB7zEuV6F52vozESyQdwhBYf+MWlsPgTRVhFFt54PLtCkaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705869462; c=relaxed/simple;
	bh=j+XneB8yqzgw7KbVfrIoHPllO0NoodR4Ced4ScY6Mr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxFkW6EpaH2iYWTuzPgkS+mB5YUXPHV9PykXNGLGFghuQPY0ZjuSqZjr4AiXpIC5FoOzCevAyMC5tyefUTrXp9RobO2X+sJwqPLvYhyFtxAa/N1mbq07z/2TabirbNdHn0xruPvr9EKykulsN10sJ5yogNpmGzIQypdqxLJwHs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV5+8nbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0DFC433F1;
	Sun, 21 Jan 2024 20:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705869462;
	bh=j+XneB8yqzgw7KbVfrIoHPllO0NoodR4Ced4ScY6Mr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FV5+8nbIFmxiv1yLJL7fWB1JjU+YscWHRXhzjZsvHSnI2/EDdbctRSjvkBwopm1s+
	 VwLhwj2o8LQuDTlkwSNQ3L3259fg7lPnt0k0/F+p7f4wzxaPIj962yPGzgEUjeaPQa
	 6d38P/54TpQJL4XjtblNsOzEjmn9ZStv2jRirLxlXHwOhlAUjGTJhOGzE3i51t1U/S
	 NChxyUrOgyNiuiMJ6xoQYJ/AA5NyTG8SFyw08STRUD8Z3qxgl2b15P73ayRhd8ZnWf
	 bLcqFQVDVe8behfhaj+q0AFN+daET295Wj9ciCmovYUFMTJiAJiQjhc4lgGaqlswEq
	 HXW7Hi9hFBkVQ==
Date: Sun, 21 Jan 2024 20:37:38 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2] selftests: net: fix rps_default_mask with >32 CPUs
Message-ID: <20240121203738.GE110624@kernel.org>
References: <20240120210256.3864747-1-kuba@kernel.org>
 <20240121203433.GA119808@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121203433.GA119808@kernel.org>

On Sun, Jan 21, 2024 at 08:34:38PM +0000, Simon Horman wrote:
> On Sat, Jan 20, 2024 at 01:02:56PM -0800, Jakub Kicinski wrote:
> > If there is more than 32 cpus the bitmask will start to contain
> > commas, leading to:
> > 
> > ./rps_default_mask.sh: line 36: [: 00000000,00000000: integer expression expected
> > 
> > Remove the commas, bash doesn't interpret leading zeroes as oct
> > so that should be good enough.
> > 
> > Fixes: c12e0d5f267d ("self-tests: introduce self-tests for RPS default mask")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> > v2:
> >  - remove all commas
> > v1: https://lore.kernel.org/all/20240119151248.3476897-1-kuba@kernel.org/
> 
> Thanks,
> 
> this version looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Sorry, I may have been a bit hasty there.

When using bash the change seems to work just fine.

But when exercising this with dash I get:

sh: 10: Bad substitution

