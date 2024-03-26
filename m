Return-Path: <linux-kselftest+bounces-6627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71EC88C4EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 15:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19121C61CF0
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 14:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE221350F1;
	Tue, 26 Mar 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZ1U4arH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23490134CC0;
	Tue, 26 Mar 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462432; cv=none; b=KO7fBxVm7ZywrMaM++/vzpGbWhA0Fk3cRDShJpSGZG3/Kewt1nyaqryldVeAluBb1tosmiTWUn9JagRv8tlVbwUh0J7tvhStCrb1ON0ZhMMbrzezG+BCV3S7ZwkrX6hgl3RNEr1lEiFlLfkpquFeV/644bRFe1jxj5UBxIyTgoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462432; c=relaxed/simple;
	bh=C9ltXwNqZQo96lMwqkKcPoi4KcfR+knsH3ht1Aww3SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndLBU0EOBVhziqnt1cXlmcSsfQ7/B2rL0A30RCvv2pYWCz1yZ86p8GfFM4oEIq+a0gD+xXTgR4SbXfwHOpWCy8/MUqJdxoN4AO71FtuTWpYYrUiMqcFlreAd3XNKgi2oj6QPqsvin4vNnCyZoCw9QceP9aEuHrKWlwRciJiOExA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZ1U4arH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54567C43390;
	Tue, 26 Mar 2024 14:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711462432;
	bh=C9ltXwNqZQo96lMwqkKcPoi4KcfR+knsH3ht1Aww3SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZ1U4arHDClwjJZp/GWMhnVixlJfivF2v9YSVg5afdw1ParcxW2/pXBhCsLEjgcdR
	 ibRTVUbHCwDqKnWx1EH+ljFuLHpJEclNYUM9I8lKpT4uFySp8jbz9im2EFHhjdcQX4
	 5dQYqCBOQWHAf+hyZbtB0/uSIud8hHVdGqV0cWmAefDCWEQaTt/SzWywUT1qXGUnSX
	 5d/BBOmQohsm2LNiNEEILeWASlV7WRx2Nfoc0RZovqWo+895/AtcZlxE9rZmloiOVt
	 BaxmYQn/a9rP/1JpktD4KspBtrBDIWENtnYfC0smMsJ85aLKDRhQkH85Z9agILupvW
	 4LevNp3PBMqnw==
Date: Tue, 26 Mar 2024 14:13:48 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org, dw@davidwei.uk,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: netdevsim: set test timeout to 10 minutes
Message-ID: <20240326141348.GV403975@kernel.org>
References: <20240325155612.2272174-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325155612.2272174-1-kuba@kernel.org>

On Mon, Mar 25, 2024 at 08:56:11AM -0700, Jakub Kicinski wrote:
> The longest running netdevsim test, nexthop.sh, currently takes
> 5 min to finish. Around 260s to be exact, and 310s on a debug kernel.
> The default timeout in selftest is 45sec, so we need an explicit
> config. Give ourselves some headroom and use 10min.
> 
> Commit under Fixes isn't really to "blame" but prior to that
> netdevsim tests weren't integrated with kselftest infra
> so blaming the tests themselves doesn't seem right, either.
> 
> Fixes: 8ff25dac88f6 ("netdevsim: add Makefile for selftests")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


