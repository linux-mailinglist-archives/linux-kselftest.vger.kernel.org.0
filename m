Return-Path: <linux-kselftest+bounces-30451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB067A8345F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 01:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F977AAE19
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 23:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACB8215198;
	Wed,  9 Apr 2025 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAl74skQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A6726ACD;
	Wed,  9 Apr 2025 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744239936; cv=none; b=QzUMegrUvZWd8wB2GWXqcvGVmwHunzRkHrVenP55mZS27ZGqMdViQDIFGJalcmjmVVi0Jl7+pcKEPMQkTWZ4VmWkZdrFXtQH2Sfk6IWJ/A/CbDXHhejON3RpW/kmFzrL5HU3TPPahhpe1nP6sA63/UNw/03vWb3e8A8nXw3MS1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744239936; c=relaxed/simple;
	bh=SfW0ThzQJnIdX0sLbnQ5XEedIU6Tx+wLJ9PW7IFJMPE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=myOwK7xAfGFPapfhdi8/woKS0r5FlcAVzp/eZiviENiqw8BoVjGRJrV2Fde8wqq0FzG+6aXuOJSPqK5YtHJtB2X72m664msFODkQ0PP+tFrGRB1RTSgEyacG8cXrp6YSurDBy3U5hIfI/CtvvcTBf1Rz+kJi9u+6p8okpjp4fKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAl74skQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB18C4CEE2;
	Wed,  9 Apr 2025 23:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744239934;
	bh=SfW0ThzQJnIdX0sLbnQ5XEedIU6Tx+wLJ9PW7IFJMPE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OAl74skQis+rwCbRA0YPbXPMcc9fmcIs7BLmvk6wKUU2AlUYdRRliJAnsoqXI4H33
	 PL1j/u/pVVysvINnhRClzdErlBoyIVXT3ESl7au8xcrSvopMMUXt0J6tVNrasinHbz
	 grsigiFbDf5lqocOy9bSqZsF0XbnnUTU3qdmtAHbSSW7VqIpjVo3h3kaLKwRsL6JKl
	 5+AzrWHrxrqsjG5JoaFTbZ5fQ4VInTizFMV1vlWm82KXe/PC/4cl2WUholl6U1/Dm6
	 TeZmf4tOFf0Co3RZbOH08+kI93hJRE/jhVTjBPwIt8zpoEWdX5K1VnAo+aFiswtYuS
	 RBvg4HEjfoL7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342BC38111DC;
	Wed,  9 Apr 2025 23:06:13 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.15-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aa092d10-f3d5-4714-98be-bd6fabd4225d@linuxfoundation.org>
References: <aa092d10-f3d5-4714-98be-bd6fabd4225d@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aa092d10-f3d5-4714-98be-bd6fabd4225d@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.15-rc2
X-PR-Tracked-Commit-Id: 197c1eaa7ba633a482ed7588eea6fd4aa57e08d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b07108ada81a8ebcebf1fe61367b4e436c895bd
Message-Id: <174423997170.3064103.18237993773982307772.pr-tracker-bot@kernel.org>
Date: Wed, 09 Apr 2025 23:06:11 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 9 Apr 2025 16:13:39 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.15-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b07108ada81a8ebcebf1fe61367b4e436c895bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

