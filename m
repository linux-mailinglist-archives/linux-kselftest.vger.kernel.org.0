Return-Path: <linux-kselftest+bounces-6907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B4C8926FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 23:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F27E2B21A43
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 22:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF2713E048;
	Fri, 29 Mar 2024 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbIbvdNz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7F13DDAC;
	Fri, 29 Mar 2024 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711753126; cv=none; b=CY7UxVKEc1jSoPwdA3nh0jfzXlEkInNsBWGfFQeUiZo86JOrRDF0cs4uaAelsfSLKUxeeR+YIHTf8mRE3/3UZACpvNzJvpY/QyY4jK84C/vuQKQLZKN6tVnb/41Ci2FdRgNb025bENbhM5/4D7Xdzq1g34K86YxDplEC2nBuYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711753126; c=relaxed/simple;
	bh=h13C2fjBsD9+gtdK3c3/Y7V1AWwt7k1UC0ZdmGte1Wg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PCm82tcjZjASkIOMvmssYd6UFBkAqhhiIs7rPaiErWspEknCvkReLT4IWLb93m3vZuhl/vxNDT3CekmYV7UJ/I1AheYmCFaQ02epvZFRthe9N6o9rsNz5RtCOUv8h5JuzNOw+N8rcIeuj3U1pQnGGG0i4UZ8fT013Xn7x0Kq2Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbIbvdNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D435C433C7;
	Fri, 29 Mar 2024 22:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711753125;
	bh=h13C2fjBsD9+gtdK3c3/Y7V1AWwt7k1UC0ZdmGte1Wg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CbIbvdNzm4kfeylRdPDxqiQ08Sl9exyjNAiyunUPnYWpoQICbaXzC2E8WuWFdDKiv
	 Jqku0OZ40+Q4dRPn44L/vR2GbZfcskHH77wqm68pamAUL4dreAeDkqHZUevxNhD7ns
	 JzOMi9XeyvqVFpPnVkqPIHAf8kbCQtwDbc+nwW7YXpzxTm3oJhL4UZVW57aWuzucD6
	 3gtuUiSnlD5bIf6FnskEDfQ//YZxDGw8c9U8Bjj6O7F1+sCfEEIj/jRBfLjhPHPufP
	 YsLhQDa4AUafSOgb1IGyVN9VJZqXLdcDb9rtprMkA3onkkV7tUu2ZftO04jMgJ4XWV
	 F0X9pSub2GJVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66AE1D2D0EE;
	Fri, 29 Mar 2024 22:58:45 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit fixes update for Linux 6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <0dea1005-3cd4-410e-aa3e-272712cca7b5@linuxfoundation.org>
References: <0dea1005-3cd4-410e-aa3e-272712cca7b5@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <0dea1005-3cd4-410e-aa3e-272712cca7b5@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.9-rc2
X-PR-Tracked-Commit-Id: cfedfb24c9ddee2bf1641545f6e9b6a02b924aee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2ad5d9e65474f7a06038f5a91fb4d8c973cbea2
Message-Id: <171175312541.6484.6405761777046737815.pr-tracker-bot@kernel.org>
Date: Fri, 29 Mar 2024 22:58:45 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>, David Gow <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, "kuba@kernel.org" <kuba@kernel.org>, Mark Brown <broonie@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Mar 2024 13:39:36 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2ad5d9e65474f7a06038f5a91fb4d8c973cbea2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

