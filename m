Return-Path: <linux-kselftest+bounces-30038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA30DA7990F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 01:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2452172356
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 23:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF361F8EEC;
	Wed,  2 Apr 2025 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGoVU0Fs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2133D1F8BCC;
	Wed,  2 Apr 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743637201; cv=none; b=gDTd2vbxCOxyZ9VK3Onq6MpxuXENoHSLCENnmA7pFwXYv6+lVi9CTQS5QhmQs3LkyVPLEMCEpmron3J38/dbl+Zej2lYH2DNHPifn9uSY/TyVMUsKP5ldWOwqRV+09FbAn6yQ60hAoJirG6DKRfk5JQtWYBG5m5yaldnar0UTAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743637201; c=relaxed/simple;
	bh=zm4Rc4GCeKZtCxD8lh7jO+Cixg48kBq8dl95C4HpKZ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U7su7pw+NHbDDEijtM16rCUvSpYNUvcuJC17j+Hvi7tiMO5nVX9RheOS3QZ85WG8mDaAMhLJn0s4eXc4V9EuHMUlGk8ZeI179Lb689NLkXwY+K2+avygGlGXYl+0TV4O5AkzZvJZIbOPzw2mx6aXYlrHKRprm36E2mZxUJmPX3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGoVU0Fs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966BAC4CEE7;
	Wed,  2 Apr 2025 23:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743637200;
	bh=zm4Rc4GCeKZtCxD8lh7jO+Cixg48kBq8dl95C4HpKZ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bGoVU0FsSU6GDWCo3pnbqXK3+BFJmOOHV3EqsemhTdl9X+/LYRzg+tMrdKTSEzyBQ
	 Az15YlPEdBu55OxBulcqrfJDbQLYQgMASyEN569S5T0GC0usjvLFAsHRIMVR3hr5h5
	 6jirO612BJ4IUHlzxSBUBs7g2FQNP9HBdw6UstIcOJp2qMm3dJvMfflIYcZT8HjH/N
	 ZGLrwOspbPX6/IDw2kWQNvEaaAy/zgbUBBxb9wna2PPjcKm/KcJUH/zR2AwAqAKVo0
	 n+Y6QH5Ek/FFAOADhXD7FWctsxtpK+spHahl7WrrnZNJd7JxuHmNHf2dxFWmvi2kvR
	 mAHd/i+yxx7Cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5FB380CEE3;
	Wed,  2 Apr 2025 23:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] selftests: tc-testing: fix nat regex matching
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174363723725.1716091.11846384965576414092.git-patchwork-notify@kernel.org>
Date: Wed, 02 Apr 2025 23:40:37 +0000
References: <20250401144908.568140-1-pctammela@mojatatu.com>
In-Reply-To: <20250401144908.568140-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Apr 2025 11:49:08 -0300 you wrote:
> In iproute 6.14, the nat ip mask logic was fixed to remove an undefined
> behaviour[1]. So now instead of reporting '0.0.0.0/32' on x86 and potentially
> '0.0.0.0/0' in other platforms, it reports '0.0.0.0/0' in all platforms.
> 
> [1] https://lore.kernel.org/netdev/20250306112520.188728-1-torben.nielsen@prevas.dk/
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] selftests: tc-testing: fix nat regex matching
    https://git.kernel.org/netdev/net/c/ca9e5d3d9a4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



