Return-Path: <linux-kselftest+bounces-37292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1EDB04AB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 00:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97AA1AA19E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 22:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E242815E5BB;
	Mon, 14 Jul 2025 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViTU1Dhn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEED22083;
	Mon, 14 Jul 2025 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532255; cv=none; b=X9NatW7w9iX7EkfSrq5lbjHZU6NBxOixSRsItzGjokawXTlELmuWryLA5iA4Gkr4qivKflCExERaOROuxV89c8j4Zy64EjsNURrsBY1nZIHojs5oEHiUDKdeEw2gkIBndgKvkQ3DcYimJXygmN8c0Xyj/pCjkWRmaiI+gfFGt5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532255; c=relaxed/simple;
	bh=TCsmjyHIIm2+lcmx7bn49vsTYR9KkYs4YrWUY/AuaYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3l8u/ZwHg0FDeZfee6lCxtsyg7pdS579GeJicrn6IWUFKRjkR6KO8k2f+U+b9UEf6TNxhj6/xvDGb5epnNESLHvv/s6SHIaKpnSE3dHrW/Qqj9AJfles12QXXK1f6F18oZ+mo6jfAFVqw2OoRP7D/hPjsD9dD5/k7TID1b5hmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViTU1Dhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE35FC4CEED;
	Mon, 14 Jul 2025 22:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752532255;
	bh=TCsmjyHIIm2+lcmx7bn49vsTYR9KkYs4YrWUY/AuaYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ViTU1DhnEI2od3Wyh8PtadNY2e8Wdhj7LKY3/nNbmflqlQdW/6xZwomzw/Tcy5euT
	 W+kvbrEts0kTYBYq5R/x+R1IaubXf/gPQXyPnlUqLbQdgDfSdYvxidpcm82i+WjYcZ
	 IInigYJPXNVRj38wZRJcf3SIdayUI02HU8qd9/nnsFhYq3ys1HRLRVe93+y6R4WjQi
	 mj8/oPep97CgW2wTThDf5saJigSvuFT7n1SBy2f8oBWu5WiHLe/Kc7W4NfTPWgsk9U
	 DXLSPprFV1gsj3EyFOnhCmZZBD60wXurbayBcApy9y5NaUfCcVKgRWNzm1BCYGwDOJ
	 G+4mTgOt2rquw==
Date: Mon, 14 Jul 2025 15:30:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: rtnetlink: try double sleep to give WQ a
 chance
Message-ID: <20250714153054.07b2095e@kernel.org>
In-Reply-To: <aHSvbVcc0DKMGcYT@fedora>
References: <20250710145312.3361964-1-kuba@kernel.org>
	<aHBza5P50wcKjG_h@fedora>
	<20250711071729.14d727f6@kernel.org>
	<aHSvbVcc0DKMGcYT@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 07:19:09 +0000 Hangbin Liu wrote:
> > > How about use slowwait to check if the address still exists.  
> > 
> > Weirdly if we read the addresses twice they disappear, I haven't looked
> > into the code for the why, but seemed like using slowwait could
> > potentially mask the addresses sticking around when nobody runs 
> > the Netlink handlers for a while? Dunno..  
> 
> Not sure if I understand correctly. Do you mean the addresses will keep there
> if we use slowwait?

No, I mean there may be false negatives, not false positive.
But maybe it's fine, it will definitely prevent flakes.
Could you post the slowwait patch officially?
-- 
pw-bot: cr

