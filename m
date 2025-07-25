Return-Path: <linux-kselftest+bounces-37967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D27B11625
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 04:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B122AE0550
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 01:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6732212F98;
	Fri, 25 Jul 2025 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUN/TI76"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE90B224F6;
	Fri, 25 Jul 2025 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753408808; cv=none; b=LUT3Jm9vG9fvVNPm1wUL44hcFdSugQ4mgckZxrMcd1l7InNuCXLrh77WDTTKuTLFCn/Z8c7jGQFNYhph3VQ5nylqVi4f+dm2+RRMWlSqCbmDsCCG8zmTCFzSYt2eMe+ymolQNHpnvQZx3VtixICUgEj/eSl31qU/kGqFwymuvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753408808; c=relaxed/simple;
	bh=p4VUMkWZj5UPgh+G88Uaxr6mxkTd9yM+pnM8+QZ4erU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TIs4V0/VDZxXs0AZMQRemJgrj05gfs03VozbCgqz3T7XAzbhHous3wXY4CEMm8zkB1i51taeNSxb8yC7WWHDFycd7YGEGnCRgZ6rntUpxP71KglF9JzKaHgDKf7ybSPF8I6jLJ9scQxlInTFn7N9vM+bRK2GkQb/QioHyIsf1sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUN/TI76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31106C4CEED;
	Fri, 25 Jul 2025 02:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753408808;
	bh=p4VUMkWZj5UPgh+G88Uaxr6mxkTd9yM+pnM8+QZ4erU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HUN/TI76nfA98aUuJDPv4iFyKZeuM3qmDq+NJGZj6oj8VyggBa8qS17MtAFolweUE
	 DQ53j1tZMhxLz0ObEU4v/3vOMBphBgJ5YGOzeVd4KDLb17CgIqMi+9/VYTB5gtXVkE
	 cvOywx/8GAdoLo8bqxO/uEYsvh3cNimcnTIxc18Wz2MKJW/Cr++gdcX+Rq4BEkPutP
	 UXEvW7+RWvXKTAJ5pByYF64bRGAvBE2ezHewiQCd9xqRSTsvOVXyaV9qcHrh3N0V1u
	 krLGocsEHwmAbpzamzbzCVZfCBTYZZEK4Pm7LWwepJUUMKN8eXiWAfNnLhAtzPo31I
	 haC/DdP23+oQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D98383BF4E;
	Fri, 25 Jul 2025 02:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] selftests: drv-net: Fix and improve command
 requirement checking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175340882599.2604761.7778521635617787106.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 02:00:25 +0000
References: <20250723135454.649342-1-gal@nvidia.com>
In-Reply-To: <20250723135454.649342-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 shuah@kernel.org, willemb@google.com, noren@nvidia.com,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Jul 2025 16:54:52 +0300 you wrote:
> This series fixes remote command checking and cleans up command
> requirement calls across tests.
> 
> The first patch fixes require_cmd() incorrectly checking commands
> locally even when remote=True was specified due to a missing host
> parameter.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftests: drv-net: Fix remote command checking in require_cmd()
    https://git.kernel.org/netdev/net-next/c/b4d52c698210
  - [net-next,2/2] selftests: drv-net: Make command requirements explicit
    https://git.kernel.org/netdev/net-next/c/d74cd9a02f02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



