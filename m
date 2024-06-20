Return-Path: <linux-kselftest+bounces-12330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752FB910800
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 16:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFCE7B24819
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103BE1AD9DA;
	Thu, 20 Jun 2024 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhbCmsiH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D916C1E48B;
	Thu, 20 Jun 2024 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893230; cv=none; b=k8Jx9vhs6eI3CDRMvnH2QrTkNhaCEcU8BHn8UdqvCwCpL/92Yvn0VRZW4G9bhOqeshirobCQC6zbWe5TSl+3Ol3c6B8RHGl121ShaiWXyYBF/YxgZ0f0Suab81/iRPjfpZ0V5UsEcEjLfdKEjiVabIaaa5HJCgk6diL3V0IZLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893230; c=relaxed/simple;
	bh=i0oBbz9+0HtZfagyCCJ6k91AeQdrU8fUCiWr14XCJ2Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TTg2RoiEIBXUChojTEsI/USKcsYUl4hU4FhI3E0aL0oYrsLwkGC9ItUELVymlp8vrwXHF386OQOECrXGRsqixFF6LGD4ahzAuSJSGukW8J4fCoRMeAKyr3fpqvv1qUwLiZwnDdv5bx6/Q32TFIg+41QT9pIvilWMNJyIZW2UsQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhbCmsiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F02EC4AF07;
	Thu, 20 Jun 2024 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718893229;
	bh=i0oBbz9+0HtZfagyCCJ6k91AeQdrU8fUCiWr14XCJ2Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LhbCmsiHU0AhhgZ3d6zcJk4wOD91wrlQfIxBCtgAn927gz2bXnJyXt3AW1LDjZ1Ke
	 vb+rsx330fxK7p9S0gI4EdaM4MzFwuG9h2YwAvvweWAbj4Bcd6WzsXej8JxzXrzIqz
	 9LMkoD8EWBlyWFZcbawahuqi6eTMEGF4/l2+helLot8nqkVFBTSZJScrAwZvEf/A73
	 PFXMdhfSPUbbK6OOss/t5Iy3nXNDvyaJNEHcRHqOVltdUhUW7+6ca0Pm+ZwAg0SjLZ
	 xw8lYEjVp4IcLvmg8bn3y/rtJ5e7qY2o6GEHG2jSYp8/t294w6vMcMhIppQCSbSEPx
	 cbyP17GhLYDyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DB67C4166F;
	Thu, 20 Jun 2024 14:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: virtio_net: add forgotten config options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171889322957.30997.16779069029833021252.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 14:20:29 +0000
References: <20240619061748.1869404-1-jiri@resnulli.us>
In-Reply-To: <20240619061748.1869404-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, matttbe@kernel.org,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, shuah@kernel.org, petrm@nvidia.com, pabeni@redhat.com,
 linux-kselftest@vger.kernel.org, virtualization@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Jun 2024 08:17:48 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> One may use tools/testing/selftests/drivers/net/virtio_net/config
> for example for vng build command like this one:
> $ vng -v -b -f tools/testing/selftests/drivers/net/virtio_net/config
> 
> In that case, the needed kernel config options are not turned on.
> Add the missed kernel config options.
> 
> [...]

Here is the summary with links:
  - [net] selftests: virtio_net: add forgotten config options
    https://git.kernel.org/netdev/net/c/48dea8f7bb01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



