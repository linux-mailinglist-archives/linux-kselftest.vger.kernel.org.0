Return-Path: <linux-kselftest+bounces-46962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9B0CA1FF3
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 00:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CFA9304199D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 23:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19932F547D;
	Wed,  3 Dec 2025 23:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYnakrc4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694802F533B;
	Wed,  3 Dec 2025 23:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764806007; cv=none; b=HO2U3YJ4VYkD8kuX4QV1zwJSXdz7PRvmlZWTpRlnWE4UXgo/QoK291p8C33FUNciD1KAWq53LUNPD9CeekCGtoMIS2vdXiZoD2E5NLrbYzBR8EpM26Nd8JNZUKwQHndBr/fs4UHnqlu8yZtad9INh0ZV0UhN7my6Maf4Iagaoqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764806007; c=relaxed/simple;
	bh=Z8iqPNpYfm2nUie5WNd6ZwAFoRA/CsbkY2WZl+UK2iU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DwjJ2G5BEEayvk2MpRkgMiTJS46VlNET+MykyeXdjJ77CDUm6eiF8MKIIDqcMEF7UiwZFlaA28IqApLX2aB1+6bzfSBL2+aPP4a8Fnlc++1Zc0VitZEu+oDLRqG+Ad1/gCi9RM+og8AFoJpZ+booiOCEFL39YqMLClracO/Ci+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYnakrc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4831FC4CEF5;
	Wed,  3 Dec 2025 23:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764806007;
	bh=Z8iqPNpYfm2nUie5WNd6ZwAFoRA/CsbkY2WZl+UK2iU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EYnakrc4UpSVaWYKZRM2yln2HJHEz+Bk7dry9vOUi/7jJ6bYJ75O8VqVkiSFctd9Q
	 lq2mrnbHEK+CApV5Jum7TKJLLtk9cuX7fcAgtUO0A2LSaMIWIMGmjjbHBD5Qs5zo0i
	 CY70rI0+iTaKLo5dRrm/SD8fNMR4jrtCU6c8F1V0vPoJzF+0431r1FBUJ1jP6GiUNd
	 j2Dk4XjpDWBgntcFRPzRKCqyxweSVp5wj/gWbA9dAU2FdhpBksbGpbVDRE7BciVFy3
	 Y2MJ4LzuzMPi647htRhV0hLJEn9YDn+06iE+H6Zff5Heuwz81pL0RxAg+ea3brl/XY
	 Ic9PgmfDDdf4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B6F63AA9A81;
	Wed,  3 Dec 2025 23:50:27 +0000 (UTC)
Subject: Re: [GIT PULL] kunit next update for Linux 6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <f2b2697b-3885-4631-8498-f07ac90d1485@linuxfoundation.org>
References: <f2b2697b-3885-4631-8498-f07ac90d1485@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f2b2697b-3885-4631-8498-f07ac90d1485@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.19-rc1
X-PR-Tracked-Commit-Id: 7bc16e72ddb993d706f698c2f6cee694e485f557
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6d993310a65b994f37e3347419d9ed398ee37a3
Message-Id: <176480582571.130731.16258243964218059341.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 23:50:25 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, raemoar63@gmail.com, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 2 Dec 2025 17:09:20 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6d993310a65b994f37e3347419d9ed398ee37a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

