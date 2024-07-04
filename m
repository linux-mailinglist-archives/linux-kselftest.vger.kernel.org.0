Return-Path: <linux-kselftest+bounces-13155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D54926D8A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 04:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37242827EB
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 02:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F5214A8B;
	Thu,  4 Jul 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7t0F+Dn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A377617557;
	Thu,  4 Jul 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060829; cv=none; b=bLQwqfYIh92zKB6G6J9422JY93k6tVIfAOiJiJaO5zMUnQkWeVFg7Sou9h4U9/yDCRTTp1PDt08lTYGKg0O3y0OgVCnjDRXjUvQN6feYheXH9+N1+RktUDzhhPHUhspM4dimT7ldcKBByu45EPDbvjRsnWamg9UKzWwnfbNIkn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060829; c=relaxed/simple;
	bh=2/wkO/DKiCzJSgP4LgFRca8mDh4nH/zUhrKYzOFIZew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NUSOuZMFbuT+CMIWxjRuVWJoDOYHCv9qEoE6ovfnrabaJNyCpgig7v9LbDBYTQtEPvsehb6xq5Ky+Ce0QRYFcByMROxulqh75RaQxBaNkD9m53kkixYnv6A/xC0X6f7WAImj15tX/ht6jbxFJ5JxGPRkh0rfZHucxl5cl/ep0LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7t0F+Dn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13391C32781;
	Thu,  4 Jul 2024 02:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720060829;
	bh=2/wkO/DKiCzJSgP4LgFRca8mDh4nH/zUhrKYzOFIZew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g7t0F+DnYiwuzwWK+rZhDf9d8eBcof/YJc5HmWQLJDfcZi4xrl+XvY2Z532uf2tyX
	 rCchU4DHwZqrolp4gzzF4NlG2ePt52A2oqQUeDP/iw495qNqQukPvbA8OYr5Hr9yjK
	 GniSDrFJooW6vc1MC3+Clgd8es5IawXG1feoxnXoK2DNFMbt2bFHju/YiOdB82txFu
	 GQV74EnQPq9NV+kU1RENfQaKFPAPnzHM8tGL5JZdcE9Ig8C7HpxlClH5OYBN2mCb9b
	 5jw2R4uTo5NFLZ7nPNhZfUiJfGWlzrjztVjQblBjg/tVywd4R39qW6u3ERYTMcW75k
	 zhDF4NMq8STaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0245CC43612;
	Thu,  4 Jul 2024 02:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] selftests: openvswitch: Address some flakes in
 the CI environment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172006082900.10999.9026063323208803275.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 02:40:29 +0000
References: <20240702132830.213384-1-aconole@redhat.com>
In-Reply-To: <20240702132830.213384-1-aconole@redhat.com>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 pshelar@ovn.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, amorenoz@redhat.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jul 2024 09:28:27 -0400 you wrote:
> These patches aim to make using the openvswitch testsuite more reliable.
> These should address the major sources of flakiness in the openvswitch
> test suite allowing the CI infrastructure to exercise the openvswitch
> module for patch series.  There should be no change for users who simply
> run the tests (except that patch 3/3 does make some of the debugging a bit
> easier by making some output more verbose).
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] selftests: openvswitch: Bump timeout to 15 minutes.
    https://git.kernel.org/netdev/net-next/c/ff015706fc73
  - [net-next,2/3] selftests: openvswitch: Attempt to autoload module.
    https://git.kernel.org/netdev/net-next/c/818481db3df4
  - [net-next,3/3] selftests: openvswitch: Be more verbose with selftest debugging.
    https://git.kernel.org/netdev/net-next/c/7abfd8ecb785

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



