Return-Path: <linux-kselftest+bounces-32549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7802FAAD31A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 04:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B961BC875F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 02:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B42199FAC;
	Wed,  7 May 2025 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUQWIkYr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11297198A2F;
	Wed,  7 May 2025 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746583802; cv=none; b=B9jTIhV5G/KP56/jWn0Nbao60Vu3m4cC7dfZrrh4LPkD5l7vRbui/5GO8y4i9R4o4AenMZXPzJfAT7Qrvw8m7HxSu012/9qjn7J5V5DcDc93zKgFQXrdZA0nE3+or147UlFg2yL7OLjhpaE69M6Qy5Ykiw9Wm7aDszNS3MGFr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746583802; c=relaxed/simple;
	bh=2ZI9r5V5j2LEntyu9PWQDuxxPwrYshlRnySbkDgqWX0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Snyb0MU06IyYn5jNUVBRmRG7sDzHOYkBigXoSTpie414LOscLDstCuRZEF1AKH6bK5S5klt1xMfY177xBCZYl1Ob0aeamuKKfcgZhV6e5LBwcGP5PnzXId7y9gGnImrBjzvU1xOj9MObugAbmg57VdrBFzISqU8yW3bDbgk+vLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUQWIkYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B154C4CEE4;
	Wed,  7 May 2025 02:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746583801;
	bh=2ZI9r5V5j2LEntyu9PWQDuxxPwrYshlRnySbkDgqWX0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mUQWIkYrSkulCALl1knX/GDhk6O7EGjFxupmVHK8mUs6GNZSB87/z6ExChXayfHG0
	 d/04UrT1v0Xf6gvKxTogASJJc+NymXEx+OygtYBPmI0oTZ/Bb7oPcxjGv9nPvO7h4U
	 IWh/3vRhMMrrMDXTCNYdJSf5Za8y4SHDIKu8LjIaTkRGZX5lKsp0RR8rS5iO6tsLxk
	 +5fEr3fi8zGylpUw5NJ/feGj8QSTlMURKrqRre9vwYsHTAcnoMKNXHJse6Iqs3smrW
	 QNWX7hWNmeNmdISVXBhLEnwHyHlF2KoAdXxzwYh8sot/DPjnlgzczt4bHnBbRgROdz
	 gb/OdSmOHnyRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCE8380664B;
	Wed,  7 May 2025 02:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: Lock netdevices during dev_shutdown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174658384050.1710027.1966603658954406944.git-patchwork-notify@kernel.org>
Date: Wed, 07 May 2025 02:10:40 +0000
References: <20250505194713.1723399-1-cratiu@nvidia.com>
In-Reply-To: <20250505194713.1723399-1-cratiu@nvidia.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, sdf@fomichev.me, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 saeedm@nvidia.com, dtatulea@nvidia.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 5 May 2025 22:47:13 +0300 you wrote:
> __qdisc_destroy() calls into various qdiscs .destroy() op, which in turn
> can call .ndo_setup_tc(), which requires the netdev instance lock.
> 
> This commit extends the critical section in
> unregister_netdevice_many_notify() to cover dev_shutdown() (and
> dev_tcx_uninstall() as a side-effect) and acquires the netdev instance
> lock in __dev_change_net_namespace() for the other dev_shutdown() call.
> 
> [...]

Here is the summary with links:
  - [net] net: Lock netdevices during dev_shutdown
    https://git.kernel.org/netdev/net/c/08e9f2d584c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



