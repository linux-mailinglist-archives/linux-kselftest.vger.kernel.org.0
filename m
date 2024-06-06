Return-Path: <linux-kselftest+bounces-11298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F2E8FF0E5
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 17:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF99B28CA89
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 15:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F5A19751C;
	Thu,  6 Jun 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEPwr7FX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7781667E6;
	Thu,  6 Jun 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688430; cv=none; b=T598l6q8l1XrSGpktGciCC47QSaHFNmCC5pvt2voQjT+5NZzazFki5aMckGrsdCTe0XNtqbYLGUeiXe5/mlprEDXWraP3T9O/ON4/KhuIKTYYNLsbfDhlOubwZiuo+XBAetaK25OgHr2JbhfXlTL9U45HH4pxY+3eUpZotxfchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688430; c=relaxed/simple;
	bh=bOtc9xpVQTwyQV8Z4EEgfw4s9RXLbG1zVlhp5cDRID4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RMj4Pjvci63WpelpAjHjGIwmU/Qh0FE/2oJbHKm8RKLe7wLmbyZXNu+v3KVBPp9gxecZxJ9/py1Irm69HKE8eS9QNeYF/N3LfANzu3URF/jpnvSkOg126Jsr7Mzbd/BOuL4pFje9GlDzgHj3rSz6oaUl+sIo2W3lEyO7YsryLo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEPwr7FX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEAEDC32781;
	Thu,  6 Jun 2024 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717688429;
	bh=bOtc9xpVQTwyQV8Z4EEgfw4s9RXLbG1zVlhp5cDRID4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SEPwr7FX0HO8InWEnb9M1muMB5t3cu9RxHr1O32+4uK1/KoTf75dY16jTu2f9kpfq
	 xuZ7lcjYgUh2+NeszzhRILShEYeP4XOdigtWRbKe9H2jw6GFxJYGan/O50z2jSnABg
	 2MqN5BBeYXFmIPBomJ1xHqbymRC7DkL31oCvk5HLeWP9sBgIvWF2sTTvZ2z885HJ0/
	 iUqycHoQbMKs4rHN08ikwfO3C/sLTfnztUhwHXF3yq7OSIL3Ge6R4Pcuqx06IoVWeR
	 BhQ04UYSwuXEC+pvC+QNzURR6Du9aUIVLo9JWZZQfT/7FVHLIKSlZUcbpZH9MqI6Vn
	 kzq9xRgTAGjfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99D3BD20380;
	Thu,  6 Jun 2024 15:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] selftests: net: lib: small fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171768842962.28804.8836141710421199665.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 15:40:29 +0000
References: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
In-Reply-To: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 liuhangbin@gmail.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, geliang@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 05 Jun 2024 11:21:15 +0200 you wrote:
> While looking at using 'lib.sh' for the MPTCP selftests [1], we found
> some small issues with 'lib.sh'. Here they are:
> 
> - Patch 1: fix 'errexit' (set -e) support with busywait. 'errexit' is
>   supported in some functions, not all. A fix for v6.8+.
> 
> - Patch 2: avoid confusing error messages linked to the cleaning part
>   when the netns setup fails. A fix for v6.8+.
> 
> [...]

Here is the summary with links:
  - [net,1/3] selftests: net: lib: support errexit with busywait
    https://git.kernel.org/netdev/net/c/41b02ea4c0ad
  - [net,2/3] selftests: net: lib: avoid error removing empty netns name
    https://git.kernel.org/netdev/net/c/79322174bcc7
  - [net,3/3] selftests: net: lib: set 'i' as local
    https://git.kernel.org/netdev/net/c/84a8bc3ec225

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



