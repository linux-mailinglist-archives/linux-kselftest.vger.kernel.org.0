Return-Path: <linux-kselftest+bounces-24969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD782A199EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 21:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CBB167479
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 20:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A631C5490;
	Wed, 22 Jan 2025 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM4dJY6Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CED1AF0BB;
	Wed, 22 Jan 2025 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737578291; cv=none; b=C63YbbuAhoqKv5JtutHlIJNBLump4cCSsS5WWIj9QteYxNHk0V6Q7j8dP1Tcrn6An8ocsn3MF7xz9UqqoA3WhoRHkGDMDuR7p9cNfdAz6ZbTou2EdJUoFbfc8CccLZXj7FP8zI/7VclEvWPTY+HlXnwTA8kT+X9RQEXBsmASN7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737578291; c=relaxed/simple;
	bh=JJ/fwRMeQOmV8K096IyJIroA4XU5wIwThBQScvjrCE8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i/kMTURyUjcaN1rVI/ZswWPueg96XnfVJVRx6ejNSYV0P5jcPDse841NpE7PJ1wpDhR1R9TQGln5Q4K16NwEFR7x42zAUb+cRLJWErXDvdV29tGm+MZawGmlXNq4LXGTubvLHS3yAsvgKfdba3whVS5fkdPxE+5J6J3WlIyy0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM4dJY6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0388AC4CED2;
	Wed, 22 Jan 2025 20:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737578291;
	bh=JJ/fwRMeQOmV8K096IyJIroA4XU5wIwThBQScvjrCE8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BM4dJY6Z7MxAkLQMG4DkOVIf5TuaT5CK4013JIW7D3qtlqlJaSBsSpKLr2nNmL+3+
	 A41Smbsn1b0w6ZQFINX1/9WwcZlgHHZXP0XAEsxo7YGvk3IsJS4200pTY4Zdmogs3M
	 /jvoBMRVFnzOD4lH4fKEPLPQuWhpfgtXbmBYm3DB0t6qGLGyPY9HOCuS5SyjPcO9IJ
	 B1JI60hOANE5CS1NKwih+omDz9cEV9OXmzJzbSNitMNcCygm2rI7lTlxmVzqgcLKxe
	 +B2NoYMgYDGHqcIgu668lrz1IzY7VXERlk/v5ca/gD5pK5TgqWxdHWb+j0D8MdWQjV
	 gCEY7vKH2Ud4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE109380AA62;
	Wed, 22 Jan 2025 20:38:36 +0000 (UTC)
Subject: Re: [GIT PULL] kselftest next update for Linux 6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <b6b8e447-732d-483b-bedb-e1a5d6725376@linuxfoundation.org>
References: <b6b8e447-732d-483b-bedb-e1a5d6725376@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <b6b8e447-732d-483b-bedb-e1a5d6725376@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.14-rc1
X-PR-Tracked-Commit-Id: 336d02bc4c6bec5c3d933e5d470a94970f830957
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fb1e2eed14dc347e1d04b8bf0bf52c606de6da1
Message-Id: <173757831533.811340.14812978113933038696.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jan 2025 20:38:35 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, sfr@canb.auug.org.au, kuba@kernel.org, skhan@linuxfoundation.org, shuah@kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 Jan 2025 13:56:32 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fb1e2eed14dc347e1d04b8bf0bf52c606de6da1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

