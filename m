Return-Path: <linux-kselftest+bounces-20181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA559A49DB
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 01:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF649B21E91
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 23:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0A0191499;
	Fri, 18 Oct 2024 23:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx9qPpds"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA8D190696;
	Fri, 18 Oct 2024 23:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293299; cv=none; b=mj6j/nXTwQETsS7WdA7JxAGdT9Z1lcu5bVRuUTGQstLJlVSB8lxEYJ6vi9VDSU6bPihLpsW6Jh3wPQADbVxwyh2XwtjoCRFPavFhxt//yODM93cZ5CpdG+b9z9Ti2AA3Q1h/qzd3RxuAx9ZbVLsKSme1qnH4+aPlWHM4BidX8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293299; c=relaxed/simple;
	bh=v88NRLwImKSeZpHguAHBdTKvcQrygipNdMr3z1cycqo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mSOYWZRlfktLo00OSOW9lUa/pTolpA/6e/XKXCIFe8NBnp20FVdH/wtCs/e0MUe49jU+lb0rz52HF5TNP90RZJ+x5Rnys0sCumpvqnjkierDJmEURHBM+wHRBqT7cY7K70AUQtQPu5HKfGkSqXsanIAFIK5Zalj/ETSDrin+fHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qx9qPpds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69261C4CEC3;
	Fri, 18 Oct 2024 23:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729293299;
	bh=v88NRLwImKSeZpHguAHBdTKvcQrygipNdMr3z1cycqo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Qx9qPpds4HOvBcVgwYuq1/UbyHYH5Z49+P+Ul2ZxIhjTLt0OCly2mmUznWGpjobb0
	 NTay02PYxvjdXls0nJmWsBIqzTNpMewVjR7OQ6ovTv64soKX9p68yld+ApNfJvrctb
	 BeS1hYKTUlbKhe1nBPCEGmjZaoPTOJYlZIuV+TWGkPIPCN8BiRP/pgwicGmDRHpkzt
	 ZOUQ9cegXw2eP8uajH2N4RhkPd41GQCuhl6LPeO99URtnKjJVkbjb4rej8lcFKrq6F
	 aAcWORNLvQ6Rmj5jE0dcepz41BHEnSMRB56spebG12v1XgpcM9gfFE0Chwm+waQL2+
	 yHaOp6LLkyd+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34B493805CC0;
	Fri, 18 Oct 2024 23:15:06 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <399ec96b-1d84-4aa0-9030-0e42282a6d4a@linuxfoundation.org>
References: <399ec96b-1d84-4aa0-9030-0e42282a6d4a@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <399ec96b-1d84-4aa0-9030-0e42282a6d4a@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.12-rc4
X-PR-Tracked-Commit-Id: fe05c40ca9c18cfdb003f639a30fc78a7ab49519
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbafeddb9524bd459592f92432b90dd7c0b79568
Message-Id: <172929330466.3288798.12789700754651973418.pr-tracker-bot@kernel.org>
Date: Fri, 18 Oct 2024 23:15:04 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Oct 2024 14:05:04 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbafeddb9524bd459592f92432b90dd7c0b79568

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

