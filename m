Return-Path: <linux-kselftest+bounces-15940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5667595A8DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 02:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17AA91C21978
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 00:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2443D76;
	Thu, 22 Aug 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olK/pFrK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124A91D12FF;
	Thu, 22 Aug 2024 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286628; cv=none; b=TXe/pE2aLhPpkuQzFT3eBsyRQFxOD/il8/sYuKlgoYaxPfYQnORENFzgwoRfDI1qFufS6QcBkOP6mre6vgubSM/h08Z9uIp7T+eSebMLOx/6uxd9BYF4QI8fa6/bDEPQWeKc6kwpvjuYRyvi35qSBom8kAWo1E5JnAZ0Izk0eoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286628; c=relaxed/simple;
	bh=6IEnWiDQI09GinNykqiFABecZ8CA/u434KaY0t3JcbM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lVzSfN+iAjnxmZC9pqTYQ4b5Y9+FdNMixsHnbSm75ivLdbtpQQCCNbsQAsuOQxF6owJdwmc2Yt8oab795XscZwPF/9tnmFGsTWdvwj6tsW9vTusDgy/UagTmA8xX3QVQGT8GkCSq4s/sqawGBczyIARgGu49pE5qkcjgpOlpJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olK/pFrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A408EC32781;
	Thu, 22 Aug 2024 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724286627;
	bh=6IEnWiDQI09GinNykqiFABecZ8CA/u434KaY0t3JcbM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=olK/pFrKr0GxQ9Lqd9bQm6WAZVZa2LwZyhozSjVyl6wlT0hnsp5+9lMDrdlmyT68c
	 hveUuwgnriq8m1PChgPK+W7ou5QLHi0Rue1KKCEoLgwBym/IXwOk4kxFc+fJ91IWvR
	 b+aMmkjhBjsQW5B1Bt1XC+YK6rXLET+9OE+890CLkJYQpvgOnUJcjHRMu3K/Ov2vcx
	 X2abrdKe70H5b7uOh5L3ks+xB543erOtqjcmmti2BHRDn9MadIwLoqIunUJmEYHtR+
	 VapoAHif+MVQM+PIQu6YQjAH2qKDiUw/wxAL4Zj7pyuj2sYiNFza7mpUqxgNneNUfR
	 uRbTMfXvlmE5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA33804CAB;
	Thu, 22 Aug 2024 00:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: mlxsw: ethtool_lanes: Source ethtool lib from
 correct path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172428662726.1870122.3233953050001811169.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 00:30:27 +0000
References: <2112faff02e536e1ac14beb4c2be09c9574b90ae.1724150067.git.petrm@nvidia.com>
In-Reply-To: <2112faff02e536e1ac14beb4c2be09c9574b90ae.1724150067.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 kuba@kernel.org, mlxsw@nvidia.com, idosch@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Aug 2024 12:53:47 +0200 you wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Source the ethtool library from the correct path and avoid the following
> error:
> 
> ./ethtool_lanes.sh: line 14: ./../../../net/forwarding/ethtool_lib.sh: No such file or directory
> 
> [...]

Here is the summary with links:
  - [net] selftests: mlxsw: ethtool_lanes: Source ethtool lib from correct path
    https://git.kernel.org/netdev/net/c/f8669d7b5f5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



