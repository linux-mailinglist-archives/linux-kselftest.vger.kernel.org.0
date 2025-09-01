Return-Path: <linux-kselftest+bounces-40500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CB1B3EF81
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 22:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8844809A9
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 20:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2927BF7C;
	Mon,  1 Sep 2025 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvH9qRFv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0371627B4E4;
	Mon,  1 Sep 2025 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758015; cv=none; b=cwMbsEAfC5Tq675U+pNaTCgOjGKLN1rleAA2+bCydAow61aLCdFgfCxL5wYZyxlaarKXteiAfmdupB/HF7cY2cxrqaxfkhBzAi5j+1HsV1vYIkCQX66uN7F3q6Ee0dMJejHheaolCwQUYtoEM5Q7HV3selWVx2ccwr2rdZNtffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758015; c=relaxed/simple;
	bh=/wHKmb5x4dVF5LLmkd2vR6bUl0B5d3Y3KDThI8+gBEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MfqltI9TvwRXy3PKON73TI0nczGAA30bHv5QjXTBc57ILsfyTjzF40qNjStXfGTHpTM5vT9bYyvPBU6SnHcsLwRZvAOJrIS9UqTjLkDL5gbkcfzCdgfhgMfafAaCPZDGHXSzFZgjpHuRALya4WIS3iaapH/QQrOQIrZlGQ0TwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvH9qRFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74026C4CEF8;
	Mon,  1 Sep 2025 20:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756758013;
	bh=/wHKmb5x4dVF5LLmkd2vR6bUl0B5d3Y3KDThI8+gBEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TvH9qRFvETPxVNMAuRj/0xEkXPg+k3OdaDqncr4D14qlHBgnqucaVSUyuOZCbEhoA
	 EMAatoVfYDb+Rgwx+2XFzLnIKJWB2KQPuhTMoemnoXTenXAkZm1DnFr/kWg+WBzRqU
	 jF0V4XzKbL8hjW4WhSe/aCnbs3uGGPMVaStKg3AVIRA2gAOPfbC18t6RBSDh1rTIuN
	 lgXhf851oE/ZCD6NHAdHpvzPoEuHMNYngqTvfqXnEzPq2GG/+suZe2N688DcuWv73v
	 IZVVS+1WAPimsLNvgrhUIARrFkEFF8S+o3l1PNT4pNStSJryHwjDkuDwlJcrerp9Iz
	 uq1CLW7nYZK+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E4B383BF4E;
	Mon,  1 Sep 2025 20:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: net: fix spelling and grammar mistakes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175675801899.3872744.1239896650395115620.git-patchwork-notify@kernel.org>
Date: Mon, 01 Sep 2025 20:20:18 +0000
References: <20250828211100.51019-1-praveen.balakrishnan@magd.ox.ac.uk>
In-Reply-To: <20250828211100.51019-1-praveen.balakrishnan@magd.ox.ac.uk>
To: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Aug 2025 22:11:00 +0100 you wrote:
> Fix several spelling and grammatical mistakes in output messages from
> the net selftests to improve readability.
> 
> Only the message strings for the test output have been modified. No
> changes to the functional logic of the tests have been made.
> 
> Signed-off-by: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>
> 
> [...]

Here is the summary with links:
  - selftests: net: fix spelling and grammar mistakes
    https://git.kernel.org/netdev/net-next/c/c85ae0240ee9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



