Return-Path: <linux-kselftest+bounces-28447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC22EA55C97
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 02:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACA63B79D6
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 01:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F47D18FDDF;
	Fri,  7 Mar 2025 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEiaMT+S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3713D52E;
	Fri,  7 Mar 2025 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309201; cv=none; b=apKrNUACLS5y7Acw43f/1aYFVMmf5nC5E0hgl0wrpKShg1yw9Gl5J5aoor9e3dzIx6uyyIn5J89UBllTk6LU+JBHfr2lYLZ8HFgIqzsyP5uyfMbRsxsV8oFgcs5Xtb0HyBONVX+c4FcIgLZ944KToO6sW46dghGEDRH3KMSjngE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309201; c=relaxed/simple;
	bh=DLP1SeRWzG6iJPgv5Efqev3aQLJ91Lz2sSo6cQAKfSg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JgJqY73DyKW8zXY//rmajGwjPY/MMPuz1NvYfaqPxe6QGh3AJiBm5ENGZocvM/C2pFVXdKG84+nRFMf/E/kg7aw1r0yxHRGscFysaeHORd/ErK4UL1sNleGyUVlaq1sTS3WtpXfNkwm+zci8NyGEV5vi2qjMK6TM5vYDVWk/YD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEiaMT+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DA0C4CEFF;
	Fri,  7 Mar 2025 01:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741309200;
	bh=DLP1SeRWzG6iJPgv5Efqev3aQLJ91Lz2sSo6cQAKfSg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cEiaMT+Srjx2UQEHZJHbSimc2CV7OqTXFRuuzTL0I5DwXLcQ9yPaXvQoeEAF0Lk7s
	 GRd0q8x9HXBjrqfR/z6ccx53s2gH98/9qO/4TT4l5bvUqpzrKgnr0WIPQ3rB/qopyL
	 +0J0ee+Oi+5bRZtAM2Ew/4wePtajsKRt0mvbLCIMnR7j9y0TjA++MsG3sHHvqqtQgC
	 kzL5F0jqlRV71nngbLifdNC3uz72oTQeOggMG0hgPrnSJK4DuR5WCttSzK6u0MAOOk
	 y1jKSCBMowsnNf5aJh85EiXlks7hkG7BoljuQ/5tBsAnkQK8HnCrwo1vtwvqACQANy
	 gyYLHDJIY67iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B61380CFF6;
	Fri,  7 Mar 2025 01:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: openvswitch: don't hardcode the drop
 reason subsys
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174130923400.1838424.14777201199250790985.git-patchwork-notify@kernel.org>
Date: Fri, 07 Mar 2025 01:00:34 +0000
References: <20250304180615.945945-1-kuba@kernel.org>
In-Reply-To: <20250304180615.945945-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 pshelar@ovn.org, aconole@redhat.com, amorenoz@redhat.com,
 linux-kselftest@vger.kernel.org, dev@openvswitch.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Mar 2025 10:06:15 -0800 you wrote:
> WiFi removed one of their subsys entries from drop reasons, in
> commit 286e69677065 ("wifi: mac80211: Drop cooked monitor support")
> SKB_DROP_REASON_SUBSYS_OPENVSWITCH is now 2 not 3.
> The drop reasons are not uAPI, read the correct value
> from debug info.
> 
> We need to enable vmlinux BTF, otherwise pahole needs
> a few GB of memory to decode the enum name.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: openvswitch: don't hardcode the drop reason subsys
    https://git.kernel.org/netdev/net-next/c/1cc3462159ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



