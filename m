Return-Path: <linux-kselftest+bounces-17703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6B4974711
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 02:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83BECB2561A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 00:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CB510F2;
	Wed, 11 Sep 2024 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5QQZxt7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9527010E5;
	Wed, 11 Sep 2024 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726012833; cv=none; b=XWkV0u5v0dGCVqebrqa41x4XMpsUnQwDcgDjdh4BDKJKLiDySk9NLmb/2pzheGjCW2soBgw3p+1J2kXTACjE3tpeNPmvBTAAZ1mCv7JPk91NDwhvCEWyzB2cojxQQhqht4J7Wun7thNPaAOGwQ4bUeEVmPY8DsF0rBaT1eKHots=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726012833; c=relaxed/simple;
	bh=PrllVenTkXG1LRXFMbPHq/EknXpdKOkrNpY9A9ODrhs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H4YNFeACOg2YI+xLvpsMy6W0Em72TPJLHER5l1CEEr/nakvOw9UfZeMtqRPArjKK4j7JsT2WlZXUdCgTA3P0HC2nSrSjxJ4kdbnj3qUrViGaYzyNs51aQvzGp2C2dAmGr/hITG3VJcy0WksajDFa5OmG4x46DVxGbw8MxeCYdgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5QQZxt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F522C4CEC3;
	Wed, 11 Sep 2024 00:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726012833;
	bh=PrllVenTkXG1LRXFMbPHq/EknXpdKOkrNpY9A9ODrhs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b5QQZxt7hIiiicmg74JHniPK5mJNMKwxRyUcu5glJXPhlsYf7c80qHLXupIKhjgeA
	 uDjJZqOiyg3JEHgAb60iul0YzvHvTeIdBIkVuEkjM62LHRhXYhdrkK9+dfC00zpEHs
	 G9+hnu6ShKEefQR9HXoaoKLfdsv7YffSs2hn6hv5pWbTKpHQ4P3zxsNX2icDkr0tqQ
	 d9c2GNJBhNIHbcK1DsQZI+TyogJMMHANoYso/0Wf6jVegmaaJoOArolks1dCf6K4L0
	 wPdxyvh631AJkRkhFQSXD79vTbtuAQHPy08A8PYzG0K75kalGZRPrMYHNBiGM1pE9j
	 dcMgj7ym2uF/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DE83822FA4;
	Wed, 11 Sep 2024 00:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: csum: Fix checksums for packets with
 non-zero padding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172601283427.434372.5027969398518197276.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 00:00:34 +0000
References: <20240906210743.627413-1-sean.anderson@linux.dev>
In-Reply-To: <20240906210743.627413-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, willemb@google.com,
 linux-kernel@vger.kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Sep 2024 17:07:43 -0400 you wrote:
> Padding is not included in UDP and TCP checksums. Therefore, reduce the
> length of the checksummed data to include only the data in the IP
> payload. This fixes spurious reported checksum failures like
> 
> rx: pkt: sport=33000 len=26 csum=0xc850 verify=0xf9fe
> pkt: bad csum
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: csum: Fix checksums for packets with non-zero padding
    https://git.kernel.org/netdev/net/c/e8a63d473b49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



