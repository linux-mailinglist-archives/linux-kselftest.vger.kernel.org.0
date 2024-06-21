Return-Path: <linux-kselftest+bounces-12450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B123C9126BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 15:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23781C25C64
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E078460;
	Fri, 21 Jun 2024 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSz0SJOJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3456FB2;
	Fri, 21 Jun 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976633; cv=none; b=dXaV67e9xicjJGU4Y//xDTXA+CYsyO1OMDbhBa3NwR3lWlPefzrIwUVe/P0935+zcE4JYNkeE+528RWhDWWdV7/iVIpSPwbMRE/kBaHQp7Lnj3/ee6Guca+lSXgV/CjU4n/TKvFyqOGkEKI3vv+TinuAFuF+rVVmMYEHS2VVlVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976633; c=relaxed/simple;
	bh=8XFJQJqOY+eqlziImQvj6P5EAIjL5twxgcjNBjQEqeA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f1Yq5LV+9/tKTicxs4IyUAL7g3NRj/IuPHtkhuyGMutbxg4Yt5zaeH2Mrfusyg/vHbi1Z/mLFQVMExvzjQZNgKYqtcLjQZEx2r79Bpn+FJjOV7jLZfsjvpdHbbN7b4VCmAQLFNBBqcyYEMt4UOVVUEyBO6vJ+MtCiRgJ839BU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSz0SJOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B811C4AF0D;
	Fri, 21 Jun 2024 13:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718976632;
	bh=8XFJQJqOY+eqlziImQvj6P5EAIjL5twxgcjNBjQEqeA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WSz0SJOJWZbSqkc7vG8ygiF9pyGt6bu/6tOUcqIs0GUUXoocrGHz6pQohmzBcn0fo
	 l4o5jV2Z8X/DEJEDxTiCYwFlxsmW7Ju3GjFX2w39tXrUy8n0h3uQsS7S15o5Uh5Ph9
	 HTYiZ9aFAXsHhvM95ZPLKS/9m7bd0ifP4vwGwIxd2k3e9kokEjyLfh8SXCrUO659Y7
	 qT0nr7omqC8aXtOIpDlCQLl4Kxu4PWPxwx6xku0Pc7V/KKj4Jel+5gzHG2TASCmFVf
	 94/YzU2/qaASLKp7LGyQos5rd8TrMDVFL+m5WoY3mk7c+yEHKe0llEVcG+ngYQF2tQ
	 0/kFNenf4Q+TQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FF2AE7C4C5;
	Fri, 21 Jun 2024 13:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: change shebang to bash in amt.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171897663206.12212.13380664641707906539.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 13:30:32 +0000
References: <20240621041637.3600944-1-ap420073@gmail.com>
In-Reply-To: <20240621041637.3600944-1-ap420073@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 21 Jun 2024 04:16:37 +0000 you wrote:
> amt.sh is written in bash, not sh.
> So, shebang should be bash.
> 
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>  tools/testing/selftests/net/amt.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] selftests: net: change shebang to bash in amt.sh
    https://git.kernel.org/netdev/net-next/c/3226607302ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



