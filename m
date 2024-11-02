Return-Path: <linux-kselftest+bounces-21333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 131D99B9C4C
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 03:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A6F1C212FC
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 02:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A045C13AA2F;
	Sat,  2 Nov 2024 02:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzgIM06l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B31139597;
	Sat,  2 Nov 2024 02:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513832; cv=none; b=IrjkSvUovJC3VPjSapcetOCK3FIxm9TNCXEew4J3eGGZthgzuqAf5KztAkQGMVXhlNv6NFmZJHawLz7YBLGGlbN8V9HSNYRvFqQFUaa4luDSPISicVU3PgSoUWFREKi/m63lfGjoTXf/lfRIN2KdaWhKXaV67IfQge+NTWg2qCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513832; c=relaxed/simple;
	bh=JVrqcpWaUy5FxFLsizrjjM02feaFRqfebF6pyG+RIkU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a/KMQ7TOPPK0Ksjm9B8UtAMlBRIuADFiF09Rim83esiKSK/srp5KUzxvqL9RaIU2c3AxekkqnC9hAmL3IavKhTqTklhnGaktV9CVYz3moiUYG1Uq9VZUL90vMnDT795XnIZU0TpynxrLuOZEuyFYEywjnfLZgnN38PavSssml4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzgIM06l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1404CC4CECD;
	Sat,  2 Nov 2024 02:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730513832;
	bh=JVrqcpWaUy5FxFLsizrjjM02feaFRqfebF6pyG+RIkU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mzgIM06lwgeX+0iVL7OzmP7ZVsfv0GkQXE3k5tCHfheYxF5YfprIMuEr0PB4VkcyD
	 /Y2U4E82JUJdzDLOSAXfQkD235M25LJrYVPl4+u3Zr8uFbTX+s9Qr7XndjmoL60ytQ
	 Vjb1u3iOW4P/mXsRHzesjc1eJioNaycfsig2MSiy2LgNnoR7XorDBOQsLbljbiSKvC
	 4Y+YS8u4XHtfwWHQcH/rxytWdHHy9284mHHz8Z1yAz+y+HvOZ96cI8JBP3kVyLAjQ0
	 a+G73xRO0v1/jSV0lUr97P1le7F+PDI4fKtXJH+TVSMbUlaraifPyRE4DBNBxnoPfG
	 yhIQFrlzYvZCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711163AB8A90;
	Sat,  2 Nov 2024 02:17:21 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <3ae64072-4327-4e92-b0f0-ead3743d4d54@linuxfoundation.org>
References: <3ae64072-4327-4e92-b0f0-ead3743d4d54@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3ae64072-4327-4e92-b0f0-ead3743d4d54@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.12-rc6
X-PR-Tracked-Commit-Id: dc1308bee1ed03b4d698d77c8bd670d399dcd04d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11066801dd4b7c4d75fce65c812723a80c1481ae
Message-Id: <173051384016.2894442.16671631034506234414.pr-tracker-bot@kernel.org>
Date: Sat, 02 Nov 2024 02:17:20 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Nov 2024 16:25:59 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11066801dd4b7c4d75fce65c812723a80c1481ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

