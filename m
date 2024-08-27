Return-Path: <linux-kselftest+bounces-16464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1850096184E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 22:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97FB284233
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 20:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CE11D3627;
	Tue, 27 Aug 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFrPQWOS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ED413CFB8;
	Tue, 27 Aug 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724788832; cv=none; b=ReLdhv8bBnA9ki+8X+vR/ySZ6g1En0ooL2g0pdC1yVXSvdWWOnCt3CLtZ7wetLwAf4z88hGbGiTe/KIydbwVmvVVBQx+vWF0uEZA8JA/2sTfPeNZAhRPODUU8m8CM0Nos28dwBYhFQnrN0kc+0QE3YP1at6cHj/PsTwBa57o+zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724788832; c=relaxed/simple;
	bh=W9kABLRdak7DuN+Eb2PnX0tfnMIYHa7LRvd0KaryRuU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=roag8anyXfz+Dc4LNKGrrZkms7+vK46UB+4OwC9QU8oQAIoc71kRA3hXzhpzqYte6OBn1Xe2grWRrAsg66iCS19FPEDvEjUelT0f8zDhvbBWLt2JbtuD/WDldmMVhzyd8d8bHdYODDlWmyYq0IbgMZCaVRrbPK/kZPVJvr+45qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFrPQWOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21956C567C2;
	Tue, 27 Aug 2024 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724788832;
	bh=W9kABLRdak7DuN+Eb2PnX0tfnMIYHa7LRvd0KaryRuU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nFrPQWOSb61lxNy8sBHGC+D2EfK+hLgMgqpPG4NjUCDT4REQEN3ZjUOliDY7zbdxp
	 brhUWVnOvPbF+KKqVbBw/eravbg5oM9C9k5p8+wv7NVxX1h+fILrLQA8ak2cyfPAod
	 HyZgOY+XM9vkBYz54pa0s0mE/sQ/FHyuLxtbX8vEUFNvfwKEszfqxD5YAFJ7S3v6gK
	 F7zeP3L6t8/r+Mw2RGxMxlH3dONjVYSU1vRosUPnb8fCfL5z2LQPzA2N2B96raacrS
	 6q8hHCPdqOlVeUednjlaPb/i9Y8xFKMLI19NFUUg/FbtRxV9rXglETTou3n59wGMuv
	 o4ZOTW+CYOP1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714E23822D6D;
	Tue, 27 Aug 2024 20:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: forwarding: local_termination: Down ports
 on cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172478883200.749473.14227979086325557036.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 20:00:32 +0000
References: <bf9b79f45de378f88344d44550f0a5052b386199.1724692132.git.petrm@nvidia.com>
In-Reply-To: <bf9b79f45de378f88344d44550f0a5052b386199.1724692132.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, vladimir.oltean@nxp.com,
 linux-kselftest@vger.kernel.org, shuah@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Aug 2024 19:15:11 +0200 you wrote:
> This test neglects to put ports down on cleanup. Fix it.
> 
> Fixes: 90b9566aa5cd ("selftests: forwarding: add a test for local_termination.sh")
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/local_termination.sh | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [net-next] selftests: forwarding: local_termination: Down ports on cleanup
    https://git.kernel.org/netdev/net/c/65a3cce43d5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



