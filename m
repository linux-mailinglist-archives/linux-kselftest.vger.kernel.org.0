Return-Path: <linux-kselftest+bounces-13081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4953F9249A2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 22:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3FA1C21EB7
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 20:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13A1201255;
	Tue,  2 Jul 2024 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK4VdKd+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9870A201253;
	Tue,  2 Jul 2024 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953811; cv=none; b=dXmL2ADoM8iuqOImvwbWIrhyTj0QDWG44f+Z7mCvunhWD2QD2+Y0gN9daeaK63UKPZOCDAawN4gx9kGB6Gae8AxUtHK1M1NEGY+G6WJdpJYbYaDg/A9ILVws2Pq5PiJarv/CwReRHBvMff4aVDwKmN4AMLxqlK/e8HSHyLrbY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953811; c=relaxed/simple;
	bh=G8YeaSu41JY0T99M2q2DXkxKV+kUg0JiMQk/DeSPrj4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FHESEkXpyz/yuz5ZAsLtvq7X/ab8oP2cD27ncuUMM6Btu+rrhyEC3DE9P1YBLNu4GJX+Fn37uVNRd65maZtsRqgYLFMso6AtpVX66W3r9/VTQrM/wLx0AgmQT1xp3luGl5JcPaeHwjhlQ0Th2Hb033vcF4zB9L3uQJJZ1BzP6TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK4VdKd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29D3DC116B1;
	Tue,  2 Jul 2024 20:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719953811;
	bh=G8YeaSu41JY0T99M2q2DXkxKV+kUg0JiMQk/DeSPrj4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZK4VdKd+5vVlgSzqeGe2LZwLbv028jGH2vzVH0z022e2L1H/FHdIai5Cxb/x3r2Sc
	 CZGH30oqLYhuNb9/TVdGR5dRKYE1NJQ6wkOyDDPWqGNHyTFhSyON8YoWEoslD1OJMz
	 jbVZO3aRz1BtjfyKCaXf+UU3TiBBMZARP/0VxIiUgGtMub2aQZZI1MU3+ZKoWVX4XJ
	 O5z4RBRfpqq++ncmRFYfxfXbzZTgRbwfTE6U+pQNFnN2ePtFY0wFQWPVzAfr6M6zEQ
	 fD8SoxFm3O3Tly4Kzt07ZM5W36z5/Y3udA8ocXkbikPqbDWCjvy3xcs31QZnhE3AVC
	 VW/iWiWnk0xkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A0ACC43332;
	Tue,  2 Jul 2024 20:56:51 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes for Linux 6.10-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <457af485-777d-4675-aea5-e3b77ccb8246@linuxfoundation.org>
References: <457af485-777d-4675-aea5-e3b77ccb8246@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <457af485-777d-4675-aea5-e3b77ccb8246@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.10-rc7
X-PR-Tracked-Commit-Id: 48236960c06d32370bfa6f2cc408e786873262c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9d22f7a6655941fc8b2b942ed354ec780936b3e
Message-Id: <171995381110.5346.125140324739356226.pr-tracker-bot@kernel.org>
Date: Tue, 02 Jul 2024 20:56:51 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 2 Jul 2024 14:49:16 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.10-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9d22f7a6655941fc8b2b942ed354ec780936b3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

