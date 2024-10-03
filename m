Return-Path: <linux-kselftest+bounces-18944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023A698E7DB
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 02:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20DF81C234A3
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 00:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC3C208A9;
	Thu,  3 Oct 2024 00:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGgGJXK/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24251EA90;
	Thu,  3 Oct 2024 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916040; cv=none; b=bl9fbEg5hnIrTOHpUPb3O4gEcZAE7fpJ+9T5NUCK5f1lhvUuIGRiU2CtesSCmYhkqAwATrdmzCg4s24hy2bstGq60uTQ4073Bfajy4qm4Q/dcKLELgjPbkGd8dBGnEv07UcFj1G+7dLjMokqHtrfcIT2eHCDkshOpRb4GZ5wvRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916040; c=relaxed/simple;
	bh=mAl25GBudnERd5uu9s0NAhaOQ7ZadO+xdSNec2wRQjM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tZ9IN/KokJEzixKpxlbLYV/2eUvy3kwqCXEfkq899y2xw8atVg3ZSl3D+aXVeoWQS9aWB9yPxhKr5QqdEKbnRACAHd47mlG8UKzX4Pna921xl3hBshOhGjPK7KiPhLYIfBxEb8cKLg4xI8bl4jy9rzg1mpH/8vmefvflsKla7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGgGJXK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCA4C4CEC2;
	Thu,  3 Oct 2024 00:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727916040;
	bh=mAl25GBudnERd5uu9s0NAhaOQ7ZadO+xdSNec2wRQjM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nGgGJXK/lzQ72HBTjSz8ldk9x68H8EdsgmgxcPNLYipRGLzGmqeZbSsT3P6YBl0VB
	 74RV3tbPH5I7M6vV+Ptxl+nWTmN2oD6XQipBZc18ca0JCXQuRUap0HVAXVhBq1pYUe
	 Q1f6CkPEWNHjB4XGaEJbda2i2AbZ04/z1uKVSuNQImmvoU6pLgTDj98CzM5NyyK2aI
	 gY+LdA3jEUe++2wkFypyp7HUkJ4KD6eqGQduPyuM9rVvrWbtC644ocq5a2zRT+iwwf
	 zg63K051jN0kIMDae4uETtc8P4R28I7wOTP8hTZeoGj3VqMdVwAcA3U6UbuJVOhp0I
	 B4s5v+SK5TalA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C9F380DBD1;
	Thu,  3 Oct 2024 00:40:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: rds: move include.sh to TEST_FILES
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172791604375.1387504.7631395798350455717.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 00:40:43 +0000
References: <20240927041349.81216-1-liuhangbin@gmail.com>
In-Reply-To: <20240927041349.81216-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, allison.henderson@oracle.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 vegard.nossum@oracle.com, chuck.lever@oracle.com, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Sep 2024 12:13:49 +0800 you wrote:
> The include.sh file is generated for inclusion and should not be executable.
> Otherwise, it will be added to kselftest-list.txt. Additionally, add the
> executable bit for test.py at the same time to ensure proper functionality.
> 
> Fixes: 3ade6ce1255e ("selftests: rds: add testing infrastructure")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] selftests: rds: move include.sh to TEST_FILES
    https://git.kernel.org/netdev/net/c/8ed7cf66f484

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



