Return-Path: <linux-kselftest+bounces-34205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE863ACC309
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 11:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E733A3ADF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB270281525;
	Tue,  3 Jun 2025 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv8ztuiT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CF64A0C;
	Tue,  3 Jun 2025 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942995; cv=none; b=HpysZyL3rE1I81qH54oRUH12gJLM66M7A+j85phXIt3WuF3V/QD+j5kXoST3a/Pcf1b27KwU2V21vsTg9ER+7TKajGstXdjs4w5YGN43L8EAYrOx0KYFj+bl9BAixaZq8wTocfmVX63I8+AYxdzzXa7m0imZKQlC7Kma4wGK43k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942995; c=relaxed/simple;
	bh=LzwPUjhuBI6Pb+CBk8pdzE9X5mPTdBhj6t1zg1EmHlU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qQ7hTyrvAs00pFOUOsKJ0OZCziBBRzkK+iq2SWvL1jnejDU9dfoSUvzgxehPgN9twPFKvkn07Mag/4nY4Sw9SCkJO+qZOX7TBdGrQNcwZNiZ0JphqA2KMkXX8K5gRvFWI0B0f8ZeBp04pvbmSdetcZt9ilRf8NkIPSqDfX4L8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv8ztuiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D96C4CEED;
	Tue,  3 Jun 2025 09:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748942995;
	bh=LzwPUjhuBI6Pb+CBk8pdzE9X5mPTdBhj6t1zg1EmHlU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cv8ztuiTg3+uUahxE3fK2dQBwyoXfBg93WRYhhtfHu83fzY+enIg2JfVLh/4u5+uY
	 HY7rIMPak5geHCVX6wIOHS+qVim5638Xxz8/nmrJ8JWnYcWSY/SQveK3bGXgLGGwEk
	 iwITzvhX6ufHmqQa+uDYkCSBVHeMzgtNiW2aKlhq5xsVoE5HAFEfrEWMQJpiro2KSD
	 /MeVCEcqPAqEuxT0p3SuCfhQeyWZ0sIrXsF7SbTDC5TvjMNCBcMTyu8h/SzeArswHW
	 NVTHqKLUO7AUbazWqxvedUQq+aV2B2hC9fTdjLCJEP6OgIxrQpTCY6iFY83M4BpCRi
	 d8nmHbKe+Kytg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE76380DBEC;
	Tue,  3 Jun 2025 09:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "kunit: configs: Enable
 CONFIG_INIT_STACK_ALL_PATTERN in all_tests"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174894302750.1439043.17678663765164181463.git-patchwork-notify@kernel.org>
Date: Tue, 03 Jun 2025 09:30:27 +0000
References: <20250530135800.13437-1-kuba@kernel.org>
In-Reply-To: <20250530135800.13437-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, brendan.higgins@linux.dev,
 davidgow@google.com, rmoar@google.com, broonie@kernel.org,
 rf@opensource.cirrus.com, mic@digikod.net, skhan@linuxfoundation.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 May 2025 06:58:00 -0700 you wrote:
> This reverts commit a571a9a1b120264e24b41eddf1ac5140131bfa84.
> 
> The commit in question breaks kunit for older compilers:
> 
> $ gcc --version
>  gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5)
> 
> [...]

Here is the summary with links:
  - [net] Revert "kunit: configs: Enable CONFIG_INIT_STACK_ALL_PATTERN in all_tests"
    https://git.kernel.org/netdev/net/c/f6695269dc52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



