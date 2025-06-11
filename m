Return-Path: <linux-kselftest+bounces-34756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B74AD5FFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 22:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5701188E13F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 20:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D441233707;
	Wed, 11 Jun 2025 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMuFaECk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311FC221F1C;
	Wed, 11 Jun 2025 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749673199; cv=none; b=GSDsu1l0Pdb/lqPV+7UaCWljWgUs7JkS8VW9fe3ui6oldlrjySi+Py1QxNwH3VaKgYRDOiBrjdnfOYzjwNb0Mr9faICaWE6o+qKSadF7ro2nJirsHuQc0sRlXhH1UNs/CEqBggihD0TbQPMjlvSP2rOKopg9dngQT06SuOtHrv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749673199; c=relaxed/simple;
	bh=sVPJNnU4KUdgzcWkpA0/cHyEhadQYNuxyP1hdsqxzbs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LPhL8dZMW0Dps4GlpBwt5RcSeAD1pbG1kFgC+CtTJ9EEY2syVPfeq/fJNW2qW6SSuBYBH1mqTYzl+tDMNWcINPnpNy4rinJuWygaBVVAqQ3jf6RfuWgF4nGAn64BI862aPv41YRmvO5nPmBoT9lGtILYKPUfKSVXk0cBf00802A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMuFaECk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E65C4CEE3;
	Wed, 11 Jun 2025 20:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749673198;
	bh=sVPJNnU4KUdgzcWkpA0/cHyEhadQYNuxyP1hdsqxzbs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NMuFaECkTyG3OMTtDySYQDoyUlHeHX4Lv9neEBaGb8qPWbjmFrohhi8Jk+6BNreCZ
	 khX8woBUHD0XJPDbue2fIJ+iRvCBUDjrt2N5ZWIb6bn6SbBPFPrA2EWnaekuIiL5gQ
	 cj4RT8zzd1XstyzPT+p49sTfXzrtp5XL8MLc/LXyBXOe5XYXhORIjiEh2oVZFiRDuc
	 vtt91AsI4NKvDQ5x3VSDiaSUR114rLsGmpTnRM/wuceV2e8B5w/3BNDFAUcLc60421
	 v5+4pKkun/8ZpCrRBvSIGoJyKpl8ZsFj2cz0qhXvZAz+N3gWVf7KrDtOXCns4cKfWD
	 rO5EsQZmvkBaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE4B380DBE9;
	Wed, 11 Jun 2025 20:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10] selftests/vsock: add initial vmtest.sh for
 vsock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174967322875.3469458.13217210613857945716.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 20:20:28 +0000
References: <20250609-vsock-vmtest-v10-1-7f37198e1cd4@gmail.com>
In-Reply-To: <20250609-vsock-vmtest-v10-1-7f37198e1cd4@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: sgarzare@redhat.com, stefanha@redhat.com, shuah@kernel.org,
 kvm@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Jun 2025 09:39:24 -0700 you wrote:
> This commit introduces a new vmtest.sh runner for vsock.
> 
> It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
> H2G, and loopback. The testing tools from tools/testing/vsock/ are
> reused. Currently, only vsock_test is used.
> 
> VMCI and hyperv support is included in the config file to be built with
> the -b option, though not used in the tests.
> 
> [...]

Here is the summary with links:
  - [net-next,v10] selftests/vsock: add initial vmtest.sh for vsock
    https://git.kernel.org/netdev/net-next/c/a4a65c6fe08b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



