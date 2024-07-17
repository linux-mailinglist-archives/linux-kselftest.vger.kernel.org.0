Return-Path: <linux-kselftest+bounces-13822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A03C9334CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 02:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B9E1C22607
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 00:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA2237E;
	Wed, 17 Jul 2024 00:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olagFaKm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D3CA934;
	Wed, 17 Jul 2024 00:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721177352; cv=none; b=n4lzbJXdd47f3kw0EZCg6eZeFvq8nx1BYUAcGbevcVWUp3xF2WoTGf1vtDGsvbKJxAcBR/1D3hUqHnw0gffnqSg07lxalUhqAbqvJq9HhiM4G8X310t4WhulHA6CTmraIQ5tgE66ElXzL/BunJhfGDkn8s02bjCONSzXtgVEp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721177352; c=relaxed/simple;
	bh=tBEauxdD/PNCC9oVulPrpkc7MsbW7J/hEtalGUWOAt0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dsxnzOC+9m9lzkuQW13Tz8Khmf1kdLl4c56XdY9QXVw0cTUDWD8y6Rq8GdDGYQSixrqMS60yEZOTXg7BLquinlii/2L9YcAZO2BAa3Ewo/YD5SJ+6pasTtfXJHlvAuUMvn6P5GXrtDC3pgFpzGgkkJ7/WUSzL5v4HJ1jzdjGZUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olagFaKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D94DC4AF10;
	Wed, 17 Jul 2024 00:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721177352;
	bh=tBEauxdD/PNCC9oVulPrpkc7MsbW7J/hEtalGUWOAt0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=olagFaKmRIlMMvOBg3ohu6eLx87JZV3Kddpyi87R2eSanTR2hV7StktWHQeXkvMCi
	 1rHSfGOADNEY9iRZS5kFcK2PV/e+gr44/miYO8pd5Kj8HmvqhgGLOcYh7Xu0Y4DjGd
	 HJzZCf6BjiIMoMtlIRLhotNask47bzhhnt1tJy4fWEYWzBZSzo7ceesy4nRFt9tqk1
	 jUstSBaSH4ZOKzW28i2v+W8kU0YSVq7EzDaO81SnnRQZ7dC+H+8fhNjbyiM0DGPchc
	 sdh4f5doH5LYBl4ioFStL4qQo2TjofoA4FT9CYOFxnBozkwWFypDCcaNLESZ4r/mnc
	 KPda8m7dkFJMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12F44C43445;
	Wed, 17 Jul 2024 00:49:12 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <328371a1-b4d7-491d-85fe-b7421a026367@linuxfoundation.org>
References: <328371a1-b4d7-491d-85fe-b7421a026367@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <328371a1-b4d7-491d-85fe-b7421a026367@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.11-rc1
X-PR-Tracked-Commit-Id: bb408dae9e73803eab8a648115d6c4a1bca4dba3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0434dbe32053d07d658165be681505120c6b1abc
Message-Id: <172117735207.30434.9174307437967740975.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 00:49:12 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 14:10:10 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0434dbe32053d07d658165be681505120c6b1abc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

