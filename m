Return-Path: <linux-kselftest+bounces-36728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA50AFBC50
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 22:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79923B993F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 20:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D8E217701;
	Mon,  7 Jul 2025 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2AVmvJm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD9C215F48;
	Mon,  7 Jul 2025 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751919058; cv=none; b=KElsXBiWkfulC+6gkQFz16Hid0bnxA3BBtoASLu1qThZiV76pxfs2Qm+N/ROtjHgRHRMp+YxMaXWvkNSgkfq2kurPF4vtCBzxxj1oYco3JFzDsBuOu0/gnAzMBzgh9yHk5iOBriX6lBOYbSMqzkLr0YvQx6uLUqW+6d0kdxNm1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751919058; c=relaxed/simple;
	bh=yUmnhHtSXefGDv9A7H+00RO52EpPa5m3zD+x8bBJpoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFxWnsnseT2UutcirJQb8+PnYja62XeprEUuPVBFtf+ZA6aw0JfjejkWYtHR5v2OXsNbRXmNmUJEyeSVSdKcoEwGa8g1pnB+Z9TYRrm9Zn/YGLoE8SQeeZ7Mlp6P5y5VQHEi0Qsf/FrVKQtSDSH6XHHMkIHc1vyIv2rKsiAT6IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2AVmvJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DA4C4CEE3;
	Mon,  7 Jul 2025 20:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751919058;
	bh=yUmnhHtSXefGDv9A7H+00RO52EpPa5m3zD+x8bBJpoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R2AVmvJm9YMQkqfvdI/wGcLCo+JKRJJEFvPVii73/DDETfNEO4onHfVs26lAPxj/E
	 1Vqi0Srz6Mp/Qu9wWYb7wbBuiykC6dymIeAeU2Wf4/f6Uz/UnXBEzLfog45jH6Pd08
	 jzInsT6muDJJk81coPddTWmtVBRddpJELvE6DWaoOFflEzHtsXnz62P2HHezM56kOY
	 RtgQsJIFQmNajlRjuR21HIEhw4h9IG4cezwNH4Tj/GI+8Ua0ws3YH29hETqw3wwUH0
	 73JfRg9gDBCWLmpD9soaYN75rYpB8kGjyxYHEwehQcw2qLIEZIjSmb0P+CoFk08uvx
	 Dnh576rA8/ozQ==
Date: Mon, 7 Jul 2025 13:10:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, shuah@kernel.org,
 sdf@fomichev.me, jdamato@fastly.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 net-next] selftests: devmem: configure HDS threshold
Message-ID: <20250707131056.2d7971bd@kernel.org>
In-Reply-To: <CAHS8izPug-bFu3Tqc_sanCO-gip_e-pPY2Xx7qTAUV0+cKySXg@mail.gmail.com>
References: <20250702104249.1665034-1-ap420073@gmail.com>
	<20250702113930.79a9f060@kernel.org>
	<CAHS8izPug-bFu3Tqc_sanCO-gip_e-pPY2Xx7qTAUV0+cKySXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Jul 2025 11:48:53 -0700 Mina Almasry wrote:
> > On Wed,  2 Jul 2025 10:42:49 +0000 Taehee Yoo wrote:  
> > > The devmem TCP requires the hds-thresh value to be 0, but it doesn't
> > > change it automatically.
> > > Therefore, make configure_headersplit() sets hds-thresh value to 0.  
> >
> > I don't see any undoing of the configuration :(
> > The selftest should leave the system in the state that it started.
> > We should either add some code to undo at shutdown or (preferably)
> > move the logic to the Python script where we can handle this more
> > cleanly with defer().  
> 
> I'm sure you're aware but this test in general doesn't aim to undo any
> of it's configuration AFAIR :( that includes ethtool tcp-data-split,
> -X, -N and -L. Sorry about that.
> 
> I wonder if you want this series to clean that up completely such that
> all configurations are cleaned up, or if you're asking Taehee to only
> clean up the hds-thres configuration for now.

Just the hds-thrs config for now. Avoid adding more problems.

> Also, sorry for the late reply, but FWIW, I prefer the configuration
> cleanup to be in ncdevmem itself. We use it outside of the ksft to run
> stress tests, and folks are going to copy-paste ncdevmem for their
> applications, so having it be as nice as possible is a plus. But if
> you feel strongly about doing this outside of ncdevmem.c itself I
> don't mind that much.

Stan & Bobby added devmem support to kperf I think that's a better
choice for stress testing: https://github.com/facebookexperimental/kperf
selftests are for testing the kernel, in the context of upstream CIs.
The experience with netdevsim teaches me that having "out of tree"
use cases as an explicit goal is a road to nowhere.

