Return-Path: <linux-kselftest+bounces-19250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE05995559
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 19:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC94286DE4
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871821E1052;
	Tue,  8 Oct 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB9klMht"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A36237708;
	Tue,  8 Oct 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407428; cv=none; b=eMl8B+FRHnbx1uQQbPch92ZuFCPhXl52aD7YytTJn3a8f+EojiCN3WHlw00Bl+soUhZptNVEyEqe0YEDOyfpGaqy8gyFa9A2Xtti26MCgfCrA+l3/Q/6PeGDUi3c5Sqj3pkfykTi2mQnN87TP1k4ps3CfWIFhF/3tivTIpv2Prw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407428; c=relaxed/simple;
	bh=335T6o6MePFWX0ru8e0PRl9FN/e2lZp97XLGIJ13O5k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c/ac+pHnTRzvLaN7YigorswZaHvyYeJikkclWmMr2Fg7CUZYE0J8P6m1mMFRbEN7CHlJYPtc280FtOSQ9ndW2mIFjcUFfUt+9oC14WpD3gTaiZ1T3cdBoxTNzZfX68nOto4e6UeMXlRVfTDFSTethLbV5bKu7R245+fIQWMKbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JB9klMht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909D1C4CEC7;
	Tue,  8 Oct 2024 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728407426;
	bh=335T6o6MePFWX0ru8e0PRl9FN/e2lZp97XLGIJ13O5k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JB9klMhtqN8vPw4H1xgj45L6afLe0iHNMRNCtD5zJYNgMRniGi//0R7hOwWKWV5Dm
	 DbUwo6xqo3GkWM9O0rqZc2LlqoxVGDqLI/M/K88qKRQSdsfm/64CatDq8F8NReOzaD
	 lBJYXwBALwkxKnSEzrk3ihE7+orWJcX2EkLcFD26dKGwulJxMFnlFdWs38nORQ0cOX
	 nuwoSfRTKeSzzJasowZXfgvyjnT30nEx9+m+dlDh/mhDY7oe7E4FhD1bpp4cbgukmP
	 thmFR/Uteny0m5hlvZm2bkf3KAdLKbd5kx8QgDwjtuZ6ciNmjp0VXHSpVVRqdEg/yE
	 Vjj4fi90VDvFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0503810938;
	Tue,  8 Oct 2024 17:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: make kselftest-clean remove libynl outputs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172840743075.616435.18300491397369115965.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 17:10:30 +0000
References: <20241005215600.852260-1-gthelen@google.com>
In-Reply-To: <20241005215600.852260-1-gthelen@google.com>
To: Greg Thelen <gthelen@google.com>
Cc: shuah@kernel.org, almasrymina@google.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  5 Oct 2024 14:56:00 -0700 you wrote:
> Starting with 6.12 commit 85585b4bc8d8 ("selftests: add ncdevmem, netcat
> for devmem TCP") kselftest-all creates additional outputs that
> kselftest-clean does not cleanup:
>   $ make defconfig
>   $ make kselftest-all
>   $ make kselftest-clean
>   $ git clean -ndxf | grep tools/net
>   Would remove tools/net/ynl/lib/__pycache__/
>   Would remove tools/net/ynl/lib/ynl.a
>   Would remove tools/net/ynl/lib/ynl.d
>   Would remove tools/net/ynl/lib/ynl.o
> 
> [...]

Here is the summary with links:
  - selftests: make kselftest-clean remove libynl outputs
    https://git.kernel.org/netdev/net/c/1fd9e4f25782

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



