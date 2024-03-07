Return-Path: <linux-kselftest+bounces-6033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0346187475E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 05:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920611F24AE6
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 04:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D37A1B27D;
	Thu,  7 Mar 2024 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAWeRYtH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587E110A34;
	Thu,  7 Mar 2024 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709786431; cv=none; b=n3Q7bnlROyhd2GTM8z/LeKrvguAnjxLkh3nPoF9cmFFNTHjqRK3WAaH5TY4uIvHyZLxWwlo67kPClhhfe6ade0oLXIez6c8MnOmHKFAO3lfcspLNY1p4fV/hub+iOjF762QRVuDQDBPpHmXX1Oyo2C5/yjylDoLTnyZUyBFp/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709786431; c=relaxed/simple;
	bh=OCCGs2R/jfWNK08TVuyK4J+/XOBbfsMRa86WcXYi0c8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aUi2C6vCJr1N0CDcOfkyoructhJqMCdcXY1mLVmUUi93vTqJCqDtspH8BbgUtWR/BfWjBChcYvDSjRWuQCNKy7RhKO4DgSeKoG7rhmVLHuX8T9PeFwB+6FwYvQyrgT37I9S3qFl4JtIEgyApgRIF2F3T5xWkIjG94SoSl2n4v2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAWeRYtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26D27C3277C;
	Thu,  7 Mar 2024 04:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709786431;
	bh=OCCGs2R/jfWNK08TVuyK4J+/XOBbfsMRa86WcXYi0c8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EAWeRYtHiSxM1vKulOzWemaUsGKIe8YCKv5l144TbgITqrQYS9xC3PbmlVjxaJDpq
	 MAVobScQ4UBcdqC438Xzz9OJQii8HFmQSh5qNR34+4aD0DhTrGEciHpEcEWnTJx79d
	 Ea5l51si7XlFQXMO5xg8afE5za9SoIlh1SyJsKqale9giYyi3PpuUUK3jliPPKru0p
	 mcjeiuvJFj6x1u8S3HBfI2FcF1DwykPjX++0D51DSSV+PJ12pri42LrTwtvnHM3CI3
	 Xy213F5Ryaj9PsK/Che/DK0jLaMS+ANAWc/P01tEOT7WLsrir5RyTKfi0IOW0OOhGb
	 vYFh4avBZ3iUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EAB12D88F82;
	Thu,  7 Mar 2024 04:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/harness: Fix TEST_F()'s vfork handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170978643095.7855.10065526694998979631.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 04:40:30 +0000
References: <20240305201029.1331333-1-mic@digikod.net>
In-Reply-To: <20240305201029.1331333-1-mic@digikod.net>
To: =?utf-8?b?TWlja2HDq2wgU2FsYcO8biA8bWljQGRpZ2lrb2QubmV0Pg==?=@codeaurora.org
Cc: davem@davemloft.net, kuba@kernel.org, keescook@chromium.org,
 broonie@kernel.org, shuah@kernel.org, gnoack@google.com, wad@chromium.org,
 edumazet@google.com, jakub@cloudflare.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Mar 2024 21:10:29 +0100 you wrote:
> Always run fixture setup in the grandchild process, and by default also
> run the teardown in the same process.  However, this change makes it
> possible to run the teardown in a parent process when
> _metadata->teardown_parent is set to true (e.g. in fixture setup).
> 
> Fix TEST_SIGNAL() by forwarding grandchild's signal to its parent.  Fix
> seccomp tests by running the test setup in the parent of the test
> thread, as expected by the related test code.  Fix Landlock tests by
> waiting for the grandchild before processing _metadata.
> 
> [...]

Here is the summary with links:
  - selftests/harness: Fix TEST_F()'s vfork handling
    https://git.kernel.org/netdev/net-next/c/41cca0542d7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



