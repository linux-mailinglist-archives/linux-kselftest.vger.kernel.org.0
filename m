Return-Path: <linux-kselftest+bounces-39543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162CAB301DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD1C1C27E86
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 18:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D1634321C;
	Thu, 21 Aug 2025 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ftd5BTZk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA02019EED3;
	Thu, 21 Aug 2025 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800398; cv=none; b=c3o0Q2qKKDn/gJfBeOSRPqpw0970Ko5XybLx2AUh15tFB1l+fMexTw8AIp11hsAEt75hxSjQdcgchqH9x3BZVSiCipWyR4lU1F7SKjXvduik0ZB+2zZ0OeiAI2jvJ1DEsH8nz6xq7bEMrYXaurN55zE3r9yaIVZZM0SK7TmUoUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800398; c=relaxed/simple;
	bh=Ml4hUrMmhtCtc9egKvXHdw6ST7xy3d80Zu7REsvebCA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cp5ddv+stU4b00+J2I5XgXj9/Y/1ZCLaG7dLLBrdD/AyIWptMHoFuWpsw1bAD00MVfR4EhsJMZjS9wbrSuG4k6d6OYDGyHZ1eYW3nPlLRbdy3phkrRXrS7JhjOH97T8KcXtTWQtWFne2iQAoNC6K8+tDZXckX3UmgT+diLZ6flI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ftd5BTZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2222C4CEEB;
	Thu, 21 Aug 2025 18:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755800397;
	bh=Ml4hUrMmhtCtc9egKvXHdw6ST7xy3d80Zu7REsvebCA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ftd5BTZknHK64rWSsrS62LHqDwjoadMleUzUOx6gIhUhGa7klbrphYPRTBX+xDqi4
	 FxNVZTaLoi7aGQPpWNSZmXrOZt649aCF1FNk/28dcVRA0oTn50fHjxWFes5fdE5T2H
	 1mD4A4Z8lB2pgTDe0gWkc971N0eEUZ5zhMYX9dtIjH5zn5KhstFrH2c0LkGuUtpidv
	 VeKNVZgiThYMZARV9VEhAiyluMB3kRSTLvuWqWETT4LOcZ6sia5AJWsxNYS+uB4vwv
	 gcfzqT/Q9JQyXvmyk5PSEi9qFRUocaH58g88dKGFAuVyFqTjNtAj3punXqkj+gzKij
	 oryVJH1TqOyQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F93383BF5B;
	Thu, 21 Aug 2025 18:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: net: fix memory leak in tls.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175580040701.1138531.10293512687033473272.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 18:20:07 +0000
References: <20250819-memoryleak-v1-1-d4c70a861e62@uniontech.com>
In-Reply-To: <20250819-memoryleak-v1-1-d4c70a861e62@uniontech.com>
To: Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhanjun@uniontech.com, niecheng1@uniontech.com,
 guanwentao@uniontech.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Aug 2025 10:45:57 +0800 you wrote:
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> To free memory and close fd after use
> 
> Suggested-by: Jun Zhan <zhanjun@uniontech.com>
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> [...]

Here is the summary with links:
  - selftests: net: fix memory leak in tls.c
    https://git.kernel.org/netdev/net-next/c/e5b71dd3ad0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



