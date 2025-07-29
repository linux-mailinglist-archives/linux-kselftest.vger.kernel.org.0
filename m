Return-Path: <linux-kselftest+bounces-38063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDF3B153EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 21:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0881E3B8E52
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 19:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB4623184F;
	Tue, 29 Jul 2025 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1hm72Ge"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A785E1F956;
	Tue, 29 Jul 2025 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818694; cv=none; b=g66pdA3rvk8bHRWXIol7MR3P1mvv1Z1Csh8AvwpGf73h7uFxQEQsptr8i5GVVea99+0b2B42xdB4ClJiFure0K12d6AsldldLMB9q2yOSf6JjQWTMkBnKaGmOUZT/PQrGRsYnuPrBagJ3WWviwD425rzFCPieCzJ81vI2IWaAz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818694; c=relaxed/simple;
	bh=XNfxzmmDIpYeiYraiW29b1GdQiwaVUmIfGwURLuLshQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Wz6xt3Ob+LQ0tOdyQhyYEtxV+WhHGeRzIL1iATcS9G0coYrGA7EBywYMuFOgwTcb/ADuOp5EWLmSvN1o1Zljk7Adfqwx9xmXXBiy47pRJe2vERXXJ0QCEb2Dcy5GNLEm3q/prXkVGDw7NsvqF9HP5kPiTlGif5dC/IYeVZRt+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1hm72Ge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C01BC4CEEF;
	Tue, 29 Jul 2025 19:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818694;
	bh=XNfxzmmDIpYeiYraiW29b1GdQiwaVUmIfGwURLuLshQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t1hm72GeaxxuVei4TUDxywstrf6Zd8rc10Td2c+amrK8K8DKv1xdMnICIH0uteLYe
	 KyUgNR9OQG/SXfwmDE7luemN4nyafxptHEgKiB0C7TKh53g4LcYgrzYrMzd2UmI8V5
	 Rsg49snY44TzultYijcckpiDeDnTi2x6qwrDETaaAd7P0bgNIjxJpkv5r77Sedbwfi
	 RpNCVljtdFO5ZOQoDJpfKDPvx6yR3rZI9kPfOh+HTZF6S/8lPXHuUAZ8np/ZKbhdNI
	 75SD8YrhCBB615fnP7XPCWhC67e6yb7EwEK8I3sjFwwy58aunT/J7Rn4LT8TgvWrRR
	 dvaauHP8P4Wjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0F5383BF5F;
	Tue, 29 Jul 2025 19:51:51 +0000 (UTC)
Subject: Re: [GIT PULL] kunit next update for Linux 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <c08408c3-a686-444c-9814-42d8c395d3ad@linuxfoundation.org>
References: <c08408c3-a686-444c-9814-42d8c395d3ad@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <c08408c3-a686-444c-9814-42d8c395d3ad@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.17-rc1
X-PR-Tracked-Commit-Id: 34db4fba81916a2001d7a503dfcf718c08ed5c42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f46e6fb4e267acf8741cb2c29d368b4de7b6c15
Message-Id: <175381871062.1621303.15904488225576401919.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 19:51:50 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 14:40:00 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f46e6fb4e267acf8741cb2c29d368b4de7b6c15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

