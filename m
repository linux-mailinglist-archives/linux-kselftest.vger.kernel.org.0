Return-Path: <linux-kselftest+bounces-31184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A78A93EE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 22:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1383A9167
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 20:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D812475C3;
	Fri, 18 Apr 2025 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J44ciqCz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5D6247298;
	Fri, 18 Apr 2025 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745008040; cv=none; b=m6m+8tftlgo7g33N610N8v/G9R4r1+aI+ep8Oos8lWYA1iIPRSeN45mPg86HAPDsmBKic3608DV1ytUkyjGdtPmrq4bO7XccQlOBXHnRtjriYNDpUl7wBGmfCyMIVWJE7wDgbO/veTwI1ErJao2GGWgOwLrNncpwI0RbLdL5Yos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745008040; c=relaxed/simple;
	bh=gYC+49VpA5qvRvjuG3eUQvOuP5TADZ1J38TFBOvjGsc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y6FHYhH8NzlE1mHUpxfAOcBi7X08Ho2nwrYPCG4yONORsHttFzmkWDPm91+yusWfCj87XcSVFQlM/9O9xtNihjvt1nB4If20bfsKLZQ4fvlZ2/OxrNJaXs1ag5vIvpYqLtj06eTJHHapZPfseXRI2Pyq9oM/avO8D9JPyFALXbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J44ciqCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9182FC4CEE2;
	Fri, 18 Apr 2025 20:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745008039;
	bh=gYC+49VpA5qvRvjuG3eUQvOuP5TADZ1J38TFBOvjGsc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=J44ciqCzTf68kqaV55Nc980AjdMhCIDNjgMZ1ges22hrA+J+GMIUOboVFD8QgagE9
	 M6y2hWR3GH7WtWDKiz42Km3ZJ/ETGQziy0275AVHodH7Ha9Hwnzj28+K0vXfosMJmm
	 vM6YHf+jb2QMssa+k6MPbq6J2AYOpqK/munaZ8xF4h/X0jTyxulxPIizKBrjzLrUeD
	 h7HV1oifdjCk/bVEZDAUS5/PrwEd9LSeRBV+FVSXiJ+vnB49T68LeLOkG8xLVUodO5
	 Intx67F1Rxe6HC/voQxoU3eAFFFHHhjKDSXyJsrFL5dOnqmXEneSquomccsw0vB6V9
	 IFJhvWlEFJvbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBF433822E09;
	Fri, 18 Apr 2025 20:27:58 +0000 (UTC)
Subject: Re: [GIT PULL] kunit fixes update for Linux 6.15-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <f8deb2a8-9e3e-4ab4-b28f-d685896bb702@linuxfoundation.org>
References: <f8deb2a8-9e3e-4ab4-b28f-d685896bb702@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f8deb2a8-9e3e-4ab4-b28f-d685896bb702@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.15-rc3
X-PR-Tracked-Commit-Id: b26c1a85f3fc3cc749380ff94199377fc2d0c203
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f424c6690df7a5e807548371b9546d51546fc54
Message-Id: <174500807764.316726.16553223218375012104.pr-tracker-bot@kernel.org>
Date: Fri, 18 Apr 2025 20:27:57 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Apr 2025 11:36:35 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f424c6690df7a5e807548371b9546d51546fc54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

