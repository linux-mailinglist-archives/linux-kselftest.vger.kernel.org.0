Return-Path: <linux-kselftest+bounces-27251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F9EA4041E
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 01:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE2F57A6A96
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 00:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF8B4644E;
	Sat, 22 Feb 2025 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZdgRK5Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1315E273FE;
	Sat, 22 Feb 2025 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184204; cv=none; b=Of9QaD6l7I843TlOuQYvCF8wAI7XhZyUlEf8MIjbOp4XJkJ95lpGzP3lEUEP2cyGrpD2EAcZwNV88rT2dceyi1KmY4e0iPRkzSwBD9m3AJADJ32FD4gZo9CjLJL1xYmuxgHwpSGE91TDikId7x8twd0FrVsPO4/QbRmJpLyVvNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184204; c=relaxed/simple;
	bh=qjIrrIZH8zZ+J0gsrUQc8NEyI5+pHGqdI5MRWlN4Dsc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FDT9dp5KJzcf7rr63YIBK7WSy8IHsONWHw5xqn5lnxsuGZuxQtGRWaTIIwU/9GGTBMRN/yJmQ8CiTvYD4RLiJop0I3sj+CvDTzMuxRXhS7zB8VMVpyOuemmdous8Bknzkfgq/Ve2g8oa7jAYauzrsw2rc+VhOvg1nuoD8hUNQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZdgRK5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D858C4CED6;
	Sat, 22 Feb 2025 00:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740184203;
	bh=qjIrrIZH8zZ+J0gsrUQc8NEyI5+pHGqdI5MRWlN4Dsc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FZdgRK5Z484NrWS7V60Hqq74RG+iFiE3ogAjjmivSCVtNeDwgT7Yq9UE4xl3316S5
	 xGmM7S1oTr0ALHpbSYGu6kPLLYkHCCdl7AEC8QGmLYWGy9vTXD5sbnQKCKkVpdLJw9
	 wInaPG9a3f5IUbT1ZXJUdLhWVjuGh2PEWs+Ypy/TcS+ONP0CMNfd0PZnU92BkShY8P
	 Hg7vn9osq/WR1pctFnekR+bDXr5jJ5R0qoetd5VtptjyKCxFp0rdVpGWeuGb1x9Hsp
	 VrCgCoBcpw/Uz+HChmJ3rPydYPHsLaj+1kHtQpzbrw4sp9AlzABpsIrLQFVl42Zio7
	 i1SdwTyb/WIWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0DB380CEF0;
	Sat, 22 Feb 2025 00:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: fib_nexthops: do not mark skipped tests
 as failed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174018423451.2248733.628443033739337202.git-patchwork-notify@kernel.org>
Date: Sat, 22 Feb 2025 00:30:34 +0000
References: <20250220085326.1512814-1-liuhangbin@gmail.com>
In-Reply-To: <20250220085326.1512814-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Feb 2025 08:53:26 +0000 you wrote:
> The current test marks all unexpected return values as failed and sets ret
> to 1. If a test is skipped, the entire test also returns 1, incorrectly
> indicating failure.
> 
> To fix this, add a skipped variable and set ret to 4 if it was previously
> 0. Otherwise, keep ret set to 1.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: fib_nexthops: do not mark skipped tests as failed
    https://git.kernel.org/netdev/net-next/c/465b210fdc65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



