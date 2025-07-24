Return-Path: <linux-kselftest+bounces-37903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AECB0FE97
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 04:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F181C24906
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 02:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DBE1C3BF7;
	Thu, 24 Jul 2025 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEhLvQuc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696771B532F;
	Thu, 24 Jul 2025 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753322425; cv=none; b=hhMbqo+9v2Xnv/+vg8lNbcl54Gc0hS5WJaLfMpU6Apa0h4lPj5wxj1lSlaeG6FeBDbUhPPXctu5sJoRlwIJknpHJlXmb7hc4uJkcpyaCd7nTO2N9KakdXsa7YduQJ3Fo5gBuaQ+lbx1fssgGDXbdgq8/3awH/mlyrnPMjqqB3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753322425; c=relaxed/simple;
	bh=Um9Eqm8PgST5EuPy1R9+oQVZy6aoSd+UuifTRZQrdaA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CO05ggLFweNbCwsyu6mtGyDfEXvRr7ASER6pNta64tvVGC16a9Exbc9ZKcW3Rjl58RQ8INFtunaMKAWR+gbFzv7Ei67QKz91nCYMVeQvNaKjcKleW1soZI8gWl9DNo7zEkqLaQj2X0akmpTjqi2KHNYdV0yVZ6eQ2/HCywwidBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEhLvQuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AB8C4CEEF;
	Thu, 24 Jul 2025 02:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753322424;
	bh=Um9Eqm8PgST5EuPy1R9+oQVZy6aoSd+UuifTRZQrdaA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iEhLvQuc1zIgSbIceOZEL/+1ZkKJbPzsqFBg4oS9wRWiXJyr6Vzdqs1RgAXUEuihl
	 r6YuptbDtETbBSqPVdoyAMKbOYbTRYUD1JbPGG/LHt+goiaKl4TrXPaZp4N73X7JoF
	 8FMg6aKY68Th7TwcHQRU027fe6Pkwh43YaOuLymyIM409EIEdqh94Mc+W2Bn6YUoBF
	 BmZmjRuhsBlV0wJliTRJLpfDVb2Mqm4L4QngmG7nayvyRT9DfgaRMiAUJmMw9bPTt0
	 cKcsXLyGRjiyZZmMozWWV+0DhFYJuVZOn3+4S8v7KI26g5jPnXcq5P4xb/rDHXWLa0
	 fJQSfR15UkW+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A8D383BF4E;
	Thu, 24 Jul 2025 02:00:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] devlink: Fix excessive stack usage in rate TC
 bandwidth parsing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175332244276.1844642.15811635856834310168.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 02:00:42 +0000
References: <1753175609-330621-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1753175609-330621-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, donald.hunter@gmail.com,
 jiri@resnulli.us, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mbloch@nvidia.com, jiri@nvidia.com, cratiu@nvidia.com, gal@nvidia.com,
 cjubran@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Jul 2025 12:13:29 +0300 you wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> The devlink_nl_rate_tc_bw_parse function uses a large stack array for
> devlink attributes, which triggers a warning about excessive stack
> usage:
> 
> net/devlink/rate.c: In function 'devlink_nl_rate_tc_bw_parse':
> net/devlink/rate.c:382:1: error: the frame size of 1648 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
> 
> [...]

Here is the summary with links:
  - [net-next] devlink: Fix excessive stack usage in rate TC bandwidth parsing
    https://git.kernel.org/netdev/net-next/c/1bbdb81a9836

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



