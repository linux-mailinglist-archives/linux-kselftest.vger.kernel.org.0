Return-Path: <linux-kselftest+bounces-45580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17692C59D49
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 20:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 599074E16A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 19:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB4A315D29;
	Thu, 13 Nov 2025 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odDOX4il"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D5F2DEA78;
	Thu, 13 Nov 2025 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063257; cv=none; b=d2w/xixi2kP0QXSnqgbubE+CJWEzybj8OTsreZfNAW1uvs8SpW0vsXW4diFlbJfmCAbheArM7FOH+5Mj0p9P//8NxItTSaxfkrDxFwAgwlMb6YLMUzgGhqXY5nPJwiLwfBAOv8R/Z0mce2n8w7q7rJXheJNudGB7L1TpdOEeg8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063257; c=relaxed/simple;
	bh=XgXRddGjTSpisQYv3YQl+UbViBFhN7R3Y0bW+EhkY/g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bM7T/nk1MpUmQfNG99l7uOivAJs6CqzLUUEf9urT8ZrT+un7GSpDKkeaH8PfRtUqw4EGpMAGhW7c0/HBWAktd8V2kBUlAjygy9H1KrKy52q5xBfzN/r9u0G4Qin0tNnVb2BuGG03nQodef1aQ04/iqTtcpRd3kHvQm7gcHBf8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odDOX4il; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA4CC4CEF8;
	Thu, 13 Nov 2025 19:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763063257;
	bh=XgXRddGjTSpisQYv3YQl+UbViBFhN7R3Y0bW+EhkY/g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=odDOX4ilnm68kx9lobvlPgVXiEqz/XIeAbcZ3a9E5JgAn9oWSrTXrEnZVfwGsPcny
	 PCz7IrQeZI3RgnZnE7syheX7TooHS4/2GN6ogr/e6RLJ0ohD3cPGbgnle6ib4LjOpP
	 bWe0rqpFtCHkErv4TxsQurhKV1D46qDWD00Apl75UZ+IR94+v4PnMMAxxnie3+QyZQ
	 23bUg3JFpkDxTxZZNTWud2JPWkzT/vco8ZqBsNbuKNU39JpStDSvQdtWl4D6iWx7WZ
	 WenM8U3W+e1OZ6h377UC7hM3hIYCAOUO3XTcBkwtNACpdDJEflnPU+BU+/kxWL91yg
	 +aXREEenyS46A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714483A549BA;
	Thu, 13 Nov 2025 19:47:07 +0000 (UTC)
Subject: Re: [GIT PULL] kselftest fixes update for Linux 6.18-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <e7557516-343b-4dcf-920c-c0d46cde822b@linuxfoundation.org>
References: <e7557516-343b-4dcf-920c-c0d46cde822b@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <e7557516-343b-4dcf-920c-c0d46cde822b@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.18-rc6
X-PR-Tracked-Commit-Id: dd4adb986a86727ed8f56c48b6d0695f1e211e65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b4a014e2865a970c18c1e9bba2b5c5a7322045f
Message-Id: <176306322590.982125.17483975593130839793.pr-tracker-bot@kernel.org>
Date: Thu, 13 Nov 2025 19:47:05 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Nov 2025 11:52:37 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.18-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b4a014e2865a970c18c1e9bba2b5c5a7322045f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

