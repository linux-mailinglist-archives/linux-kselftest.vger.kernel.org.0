Return-Path: <linux-kselftest+bounces-48789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AD4D151AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 20:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83B073009D43
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 19:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CEC324B27;
	Mon, 12 Jan 2026 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXdjx5kD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2505324B1C;
	Mon, 12 Jan 2026 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768246904; cv=none; b=oym3ylBa07yijmM8alPdD77257YBWhjAKxPb3+JDHGgitc0veJWG57Nc9C6AF4xk/yTTwHiAbDjAi31Fw0V4JK3U0t9+ZBS4MRtXcXL7InZKqPTLuzdLBRlHgZ/hE8fbfGhsSgIx4enpKfU4f240B2QPUnXcM1OIQk9MxJmjWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768246904; c=relaxed/simple;
	bh=zyqkNDHFGU/MEg1waOqqVWoyeIHM7JBsQ6lNCbINBKA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tVD3wA6mCNYPRKPhy5zVWkciskr5g0942Qp6fcvq2JPEXgh0/lno+SOPOq7/Eit7C23DjhNMjMn7745nmENXsaUaDo2RmM1qaHvkkE1KjaJonQuxw7M7SCwL4wrxnX08PXzGxKUDkl4JVgiv0+za7LMYS0tl8Di5KK9Xvat4m8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXdjx5kD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9551AC116D0;
	Mon, 12 Jan 2026 19:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768246903;
	bh=zyqkNDHFGU/MEg1waOqqVWoyeIHM7JBsQ6lNCbINBKA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cXdjx5kDqDOXnXiL10f8j7xdCQ/R24BZr9yNDPYkN5+KgOc4WQBrpomrSonx0gdl9
	 de52qcYyrlMo66qenITLNIJjiaRlLRNblpuA0+rwuefoVMXj+EkL8Ttz2Q8cMWTLL1
	 auaKtIYX6k6cBGbaI5vMSvwZKO2t1bDgr7Qw4D5U8U4q5b6G4MKq9wlC/McGtkyXnI
	 R//GpWr2E8MmHZO+zd02j8xhtBpHALO/fQy0rtfp9zpGR0z+AilKLeVyZhMVf5lmUk
	 MqHSYRjkDLzfSrs6B+xcT3XG3K6/5l3gAKRs5GVX9+hsLmg9KiAIgl24aU47YXbpPe
	 KC8cM8tY+H3tQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5B1F380CFC3;
	Mon, 12 Jan 2026 19:38:18 +0000 (UTC)
Subject: Re: [GIT PULL] kselftest fixes update for Linux 6.19-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <7bb8e251-6f09-42a8-bead-2ef9427bbe8e@linuxfoundation.org>
References: <7bb8e251-6f09-42a8-bead-2ef9427bbe8e@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7bb8e251-6f09-42a8-bead-2ef9427bbe8e@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.19-rc5
X-PR-Tracked-Commit-Id: 6e39903c73df08b256322d04c4dfe4a82ec63a45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b061fcffe336f1f1d1afe6a904f36962378c4026
Message-Id: <176824669742.1091852.14048973174393350135.pr-tracker-bot@kernel.org>
Date: Mon, 12 Jan 2026 19:38:17 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 10 Jan 2026 11:33:37 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.19-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b061fcffe336f1f1d1afe6a904f36962378c4026

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

