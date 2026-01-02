Return-Path: <linux-kselftest+bounces-48082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A863CEF523
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 21:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E4943024E72
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 20:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060F12D0601;
	Fri,  2 Jan 2026 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrUsrr98"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C9D2773E9;
	Fri,  2 Jan 2026 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767386333; cv=none; b=rDuPvU3jC0oCgw2vnORn1g2vsvSZSJeLW/w/dXcPE3noVO1LEMClxoB3rp0B1uqkqglIv3jg8FgiZUZNKxASGL1vsEpZRQ5PiYbP2HZadVT3ASRgFdhCuTSwGUbNBiyanlfzXokA+Mn8rgFLIWnhLegLR6/zX0ejt1zRThs/cZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767386333; c=relaxed/simple;
	bh=dk0igOAUTdr8UCH9DhMEvon+c6mDE6+akuF3cWNKZXM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GGf3YvzYvXCC1FbCPBYJ6F/7FpFaMzip2ICr16Tg0ZldiCzWJec2zkneG2v4VGDrVIwj4DsiUAosxR/ntMlzlJKamT9ihGCTibM6i+bXCMZuE4WE8omSVuD1XGUupzAlCDNn5A8DFkcjvU9pawSD2taOj+P5AkqoDuDZit07R3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrUsrr98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4133C116B1;
	Fri,  2 Jan 2026 20:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767386333;
	bh=dk0igOAUTdr8UCH9DhMEvon+c6mDE6+akuF3cWNKZXM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IrUsrr98NuGzN78w0yZYMrIN2yi7mp1qNtYzlCEII/FmaNyJnJf1OVFNSq+uzS4Y8
	 CVzPPCVY/nlQTandXb3X7+s+njzs2eBnmvNF7214Bdia399wpwQk4uWtOkohOVTO0F
	 KpUVOFhjjKwkETKoN7SN0xftPd2tpaf2YvOJdrY472sZDcS0YMNRibycaG/m7sKK3r
	 9lxZ4xZ8HrMEc7f3NKSmqRwBtdN5ktEzTqjU8yvNRK08JBU3VEHEMhDGGh21OhVzR/
	 61lvHAZ8FLfvZZnHe5bN87QBeOLGvUo2uYeo3yqdJVrpWtoy1mJyAaCjuzWCBrN+PI
	 HVmp66AMZ3txg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2BDC380A962;
	Fri,  2 Jan 2026 20:35:34 +0000 (UTC)
Subject: Re: [GIT PULL] kselftest fixes update for Linux 6.19-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <592f1743-ef62-4bfd-b91c-cb5e48201184@linuxfoundation.org>
References: <592f1743-ef62-4bfd-b91c-cb5e48201184@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <592f1743-ef62-4bfd-b91c-cb5e48201184@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.19-rc4
X-PR-Tracked-Commit-Id: 19b8a76cd99bde6d299e60490f3e62b8d3df3997
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d35fa1190a1b4d413cb1cfa4baf74215b0b9565
Message-Id: <176738613349.4003266.9426586164937792360.pr-tracker-bot@kernel.org>
Date: Fri, 02 Jan 2026 20:35:33 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Jan 2026 10:35:31 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d35fa1190a1b4d413cb1cfa4baf74215b0b9565

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

