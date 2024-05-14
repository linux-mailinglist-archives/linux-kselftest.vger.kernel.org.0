Return-Path: <linux-kselftest+bounces-10192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173BB8C5B3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 20:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F6B1C21D45
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 18:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9950B181319;
	Tue, 14 May 2024 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5Uzhu9w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7171B17F39F;
	Tue, 14 May 2024 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712117; cv=none; b=nv3NoIyagoIulD3c75BgnSLwBP0gzw2BHlescj1Cm2YOyPTPniRjFxRT5PBAU4dTXcFu+8p+PoWa09sRHbzO86cwuiUitt/bIa3vJ8IIfnt8x5J0hXtEhM6via/qfIhDgGCUVf4n/D6sBOPOt6abf5GQQXHc//jcHX9iekE07ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712117; c=relaxed/simple;
	bh=y/wfQYC0hWA/b5ghXxQQdWgODen5WHjvJfDJZyDLPqo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i2lP6Lw0mqjhm3EL6fXDw7xbBFps+sef7CYLioReAH/JGilBTSKILzoHbovkkOqyCp5kncjn9u+guIG2yDeF/GsEk37kD3INPxeYF1Rp6vzxugcYIaQn4w1a8EBT1jjAkQSGWa8pczHM9Rrm2a8t5m0I5YIk/TylFl9Y0rRr7QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5Uzhu9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54667C4AF09;
	Tue, 14 May 2024 18:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715712117;
	bh=y/wfQYC0hWA/b5ghXxQQdWgODen5WHjvJfDJZyDLPqo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=l5Uzhu9wHXxaq+TPT7tx9kfXG5FIPJuEYglKHPKVBpjc9oXatf0TufeUa3PeBc+vU
	 NFTrhespfRtBu0HDf8Bd8fXpJgoaNSinAMXt0olwPS8+rBx8XlN2apKWhDEOQwYCAK
	 Z0aca8CX/hgnTOfGyCEDbu6ipkI65eD5xeil2qGo76OJYyQVEe23APmck1TBd1TSVX
	 cdBzms8ICkPc2W8qELUElOyJ/1aPtid9vEpf3ThQ62lPxMv3vgqxus71RQudAk/7fl
	 aXOKqVVBkbdCEH3ov7Gex0r2yF8ZNGnCDLk7TcczcgPo6Yy5UBD5H9JnTNVU3wsSVI
	 zuwtwK6hlRGeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4BD32C3274D;
	Tue, 14 May 2024 18:41:57 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <2312d569-3c4b-4685-9678-746ae811c38b@linuxfoundation.org>
References: <2312d569-3c4b-4685-9678-746ae811c38b@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <2312d569-3c4b-4685-9678-746ae811c38b@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.10-rc1
X-PR-Tracked-Commit-Id: 2c3b8f8f37c6c0c926d584cf4158db95e62b960c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b95dc87362aa57bdd0dcbad109ca5e5ef3cbb6c
Message-Id: <171571211730.4202.6086721570364739143.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 18:41:57 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 11:38:51 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b95dc87362aa57bdd0dcbad109ca5e5ef3cbb6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

