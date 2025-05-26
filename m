Return-Path: <linux-kselftest+bounces-33818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B236AC44DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 23:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6609F7ADA4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 21:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BE624113D;
	Mon, 26 May 2025 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NARhk3JU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85C72634;
	Mon, 26 May 2025 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748295511; cv=none; b=Ecz0alYb94gJ8Vo+DDgds5mdYfWTlXGCZ0+qreDLkdVzgrc6M3T+ZZu9bAxWigMm3EUJB/iMe/s8f1MDUXPJQaNaDQURxpB9oY5g/jBXwbs2I52LBR+rTrq3gBlssWxFkVbklmsSIXAnrMzNF/KZlggGL4DFI6xBaTvE6OI+SyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748295511; c=relaxed/simple;
	bh=8EbxoEHxOTTOAyFh3kIQL4xQp1JdkAaDvKMujtz07/U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HtIda9wGEocyBYxh0/TwlaHcDbSDeaMpJ8AeQJC8BtUGUtNfWaHR8Dv/a/RJ7QFFSxGzsiYuwX9GylqBjUlVELn+a12xjfmyEt9DFmV0bapjgd9dqiglS6Lz4ZYxLmeFl4qMchAP1H2qmVyyiikh1CSo0nDGfAVYuSl5CFThkN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NARhk3JU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495DDC4CEE7;
	Mon, 26 May 2025 21:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748295511;
	bh=8EbxoEHxOTTOAyFh3kIQL4xQp1JdkAaDvKMujtz07/U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NARhk3JUT+wpd2L74Sy/zpNBiB9vNG4z2qTGjuRmvOVBNnaXyD7xuT65ast+fcYeC
	 2nsYC4KKVkxSGiOaZigFmixk8QKc2jSvMZEJEUFINxwftPUmogSTt00prh3Bc879dX
	 mAH+mZ0bC7ZBPW+qoonCWwGuJeXfUa6OrdV3fGUUD+LMu1wcfNx8FqhyahFvQYSpnM
	 /DBjfqR1V3SHo/3LZ0BCRCapSQATxMUq+ZDedumypsp9huGQDsUWDwTZiPXAC7q3o5
	 SylxTTTP/4kVmRII5SValwTbcUjLUZb1A5kUR6sAFoL8UX9QkM6G4l2In9c+Kk6+uc
	 N3FhBWfsLlvyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECCC73805D8E;
	Mon, 26 May 2025 21:39:06 +0000 (UTC)
Subject: Re: [GIT PULL] kunit next update for Linux 6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ab676145-a8cb-4f0f-83e3-79e073c47380@linuxfoundation.org>
References: <ab676145-a8cb-4f0f-83e3-79e073c47380@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ab676145-a8cb-4f0f-83e3-79e073c47380@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.16-rc1
X-PR-Tracked-Commit-Id: 772e50a76ee664e75581624f512df4e45582605a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba450370980aeae32197b74c27e4563281cd3aaa
Message-Id: <174829554554.1063943.2345206098554311395.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 21:39:05 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 13:39:01 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba450370980aeae32197b74c27e4563281cd3aaa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

