Return-Path: <linux-kselftest+bounces-9755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0639E8C098B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 04:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9958C1F22430
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 02:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFE313D2B6;
	Thu,  9 May 2024 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nphQV9UO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5452313C8F6;
	Thu,  9 May 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220033; cv=none; b=j+pNgzxerwIVZc+ugk8m4M9MCJ7UAPOkkfh3vjnQQBuNqUtu6oPumUM9465UF2j0QhV4PLilOUSfKuNvnaLOds8KN1g/Yp4rBX33Z0nIa/KS6lSWK5nUZEmywnacGcwLNvFzE+HpogjYf8KHgl8W4J+lug9ttqRAEExQ7QuTv/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220033; c=relaxed/simple;
	bh=6i+I/JOB5cJg8LK5CtqpSVKgo8Z4dmMIfKUKOGjS/Nw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z3x7yPSEvY1P5SaBdqA85xXDZ3uTd3u2uNlffXTGxuliQTPF2LSWa+BMp0GCxSrIqXX/RbmfdDR05L1uybZealwIokLyFiPAhtphnYR0eZeYbZmfxGZ26Y6ZbuVGu2MFZSe8xrj1XUr4Et9LGBQLFsMBFdHMUZb2s/z8TEs8aNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nphQV9UO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB404C2BD10;
	Thu,  9 May 2024 02:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715220031;
	bh=6i+I/JOB5cJg8LK5CtqpSVKgo8Z4dmMIfKUKOGjS/Nw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nphQV9UOCtapHmrm6z1cief3WtN+IRA809iEuRI6qZ/bKqD7dA68A84I0en68/pzT
	 pqh8y+nlbZrJBCG/StJjVLrbqLYIwKV7dyMglqytP91A3VuiwM3EVAHlNxeRv+wPa1
	 9lPX+bqcaRP9oTyCvdEhEwKS2yb8YXL0Xl3y1shxYaSqG2xsXaUgCPJGXPzhgovVA0
	 J/r3aARc7D8TjNv/OjUUEV9d+45ivSOkRvqcwiA1CsDddwl+XMDC58/LVypdIhaDN1
	 dPdTIXa7LGPBhc2Hej+UluP4emwBFeiUNrVwNSW9J4tQ+ulJuOXgew/wb82TNjqZHR
	 TQVlaW7Lf0ZFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0463C43330;
	Thu,  9 May 2024 02:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests: drv-net: add checksum tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171522003178.32544.16453321824669095343.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 02:00:31 +0000
References: <20240507154216.501111-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240507154216.501111-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-kselftest@vger.kernel.org,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 May 2024 11:40:58 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Run tools/testing/selftest/net/csum.c as part of drv-net.
> This binary covers multiple scenarios, based on arguments given,
> for both IPv4 and IPv6:
> 
> - Accept UDP correct checksum
> - Detect UDP invalid checksum
> - Accept TCP correct checksum
> - Detect TCP invalid checksum
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: drv-net: add checksum tests
    https://git.kernel.org/netdev/net-next/c/1d0dc857b5d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



