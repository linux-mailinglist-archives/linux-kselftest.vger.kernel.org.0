Return-Path: <linux-kselftest+bounces-6908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD408926F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 23:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283A81F234FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 22:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCA313E3E6;
	Fri, 29 Mar 2024 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrsY92tk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486313E02F;
	Fri, 29 Mar 2024 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711753126; cv=none; b=aXZkZoT7HFUir6MVhgH8D89aI/bFcDPWdgAs8IDrhga29wK9iP9k+i/nPct1CwLU6emCmNcNx60olI0ZyLDP2hO3EL2pxgBQzlYywJzTFjOJXMR6muDmPVSNExUvCH2wS3qzoXNX+bo+3C5iZdQgMV/Ms2L9b2VP/DFEnx48o8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711753126; c=relaxed/simple;
	bh=r7eog8OAYAwAc4Ub3y0ZqHpjpXe8mxtRmL7m2zt0PVg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hQSu3+8UmB8b3vGGFLXx9xKYaKxWwg6gg66k0pdn3vVDESTKk8xf+xLZn87n5hvSM6NRcDQVO0oPIN5ONPhy0j9by3BzDceuZhZY7t8lMFNi4FskQZBwX7d3BVctmGV4MofpR1lbGH3bwyB9+lAMwlqu8xWd7LT4kEoxxiO3w+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrsY92tk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F849C43399;
	Fri, 29 Mar 2024 22:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711753125;
	bh=r7eog8OAYAwAc4Ub3y0ZqHpjpXe8mxtRmL7m2zt0PVg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IrsY92tkYi2dK8OiG77Q3u/jOB3ysGcbo0Wv59K1V2198LBCzzAXDzM4I5qRuljxs
	 x49/Z7iYm6EfPSYYrn2upcKLgy1khizrNAlOF6nD9qVrkbnqUXiHXA1InqnfNWbYPb
	 MESFdLRHb0YkXX1nI5OCIWC3iNQEBaU59jhsZ6oVqUheuWG49w1ytlu51E3cCfHAmB
	 gPaRuaDq61HioJjJ+qXjSjfmno7FGI4st3NjURWSealuBSqY4LbiAZIWNf7UcYQF8V
	 q+zZ/Z8OnpZp6jJ0FuKAZgnJp2ywTkAMLi0ej4TWcE90IY+DZ8w1Ch47rT2InBpfGR
	 +udChH1fyt4Bg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F6E1D84BAA;
	Fri, 29 Mar 2024 22:58:45 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <c9b1f203-a8b6-479f-86c2-49d6aac378bf@linuxfoundation.org>
References: <c9b1f203-a8b6-479f-86c2-49d6aac378bf@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <c9b1f203-a8b6-479f-86c2-49d6aac378bf@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.9-rc2
X-PR-Tracked-Commit-Id: 224fe424c356cb5c8f451eca4127f32099a6f764
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ab5c8a338c470ceda8221e3a00ad0fc0a3be55b
Message-Id: <171175312551.6484.10205593392982278683.pr-tracker-bot@kernel.org>
Date: Fri, 29 Mar 2024 22:58:45 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Mar 2024 14:19:52 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ab5c8a338c470ceda8221e3a00ad0fc0a3be55b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

