Return-Path: <linux-kselftest+bounces-13382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBCB92BE34
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 17:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0E88B21C9A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 15:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B8B19CD0D;
	Tue,  9 Jul 2024 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaqJmATu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1015EFBD;
	Tue,  9 Jul 2024 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538515; cv=none; b=M5QGmmmyaUlzw3dFgrYVJZagRYtU9bI+kl0Xlx1JjY6cNkVv3GXsDPa+zgkNEPSBxxvpxksiWxfTFilmp1Res4cJbdhv2u/vFwGQUeQd4ZWUeJvk2jBNG+sJWhQUH5cqBoaeXnUku04/yz+FWtCgbzaj5m7KXBRreGplQ6aMNHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538515; c=relaxed/simple;
	bh=NGYF3r+51VrPnLhaoABnquh6/Dcy7gNwQ9xgvekmjFI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tZoINLMlRCD1eng2q3avqewg4zKqwmJcDFPD28N3SS4kIJ0QdEeZrBuO4kx112tViedk/wHLS/r/Oqb9jWeg3oR4ydnXlNKNfFppLKr2vv3nlLMZ+qlZxZL++pGxvMI8DyNgtOi1Mephuk5leJ8+QTwvIGGH0wsSFqwEnBJ98C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaqJmATu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 654B4C3277B;
	Tue,  9 Jul 2024 15:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720538515;
	bh=NGYF3r+51VrPnLhaoABnquh6/Dcy7gNwQ9xgvekmjFI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RaqJmATu1Q1RfK+rfD0b8MnDsDWH2Vsr6EZtSbKV0aPoZGa72rquO4sUpLzur9EYZ
	 ZSfWshf1gCG9uhBn2cbzrPo80z8qIhOuLnHvSc9w3I//Au1GRUlWb/mJAfbbf0jk0G
	 oDN1DplOYNTlPwUI9+CoAf3crUKGFri1+bYZahJWPaUp3G+vSMFcucqc8OMbPiokZk
	 gAvjz9Wf4NqPYD2F3uxK0x77VWECBLQ7qi9JBPWAH8uU8KldH0KuFODaxct/sUz5yh
	 2bUlivrXr681l3PwRQ8oUBn+v204WzwIYdIJgB3YurN2KMSy8BCHez/b40DUHIrikU
	 OUitebNeFJD/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B05FC4332C;
	Tue,  9 Jul 2024 15:21:55 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes for Linux 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <7007e67e-0af4-4b01-a708-ba108208b217@linuxfoundation.org>
References: <7007e67e-0af4-4b01-a708-ba108208b217@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7007e67e-0af4-4b01-a708-ba108208b217@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.10
X-PR-Tracked-Commit-Id: 66cde337fa1b7c6cf31f856fa015bd91a4d383e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 920bc844baa92fe508d9cb7c72765d6f54dfebe1
Message-Id: <172053851529.32730.6447158470930026357.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jul 2024 15:21:55 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jul 2024 16:42:13 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/920bc844baa92fe508d9cb7c72765d6f54dfebe1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

