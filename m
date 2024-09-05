Return-Path: <linux-kselftest+bounces-17188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3699296CB81
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 02:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A15281F4B
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 00:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19883EADB;
	Thu,  5 Sep 2024 00:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WU8snY3g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67A1C27;
	Thu,  5 Sep 2024 00:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494442; cv=none; b=hXibaZXB+fe2G2D5M4SxE2c0OSWh85U0mUjylfdpCeFC3EREGdtO8r7LWdjtOehyd42PFLGH1OJXC430xJ07Xy3MbhQKe8X1EQ3dn/kGEAs94jcKCyhhfvQlbOCQZhsrqcQ+loegiR6bCKDbGooFYyg8Gh5RDpnf/lPEHHIR2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494442; c=relaxed/simple;
	bh=hzPV3/MHpC/JimHpDFSYV8Yu913JXZWQ1tDa/Sh3TV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DUwcJLwYoJ8MXlYT/DdjShjuBxpW3O9n60imtjYlbTFfebGSA2T/TH4HcYqnB9EsXVGxd0Ht/4VeLDLc1l3ZZ+YsXyQVPRhHoUpoAM4QJ0+GPpt2l24u4dhQgzEw1Nzxd9BDxtX5gV1dTRll0XzvwkwOPUN/v0v3X2sA/3N5Wpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WU8snY3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75830C4CEC2;
	Thu,  5 Sep 2024 00:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725494441;
	bh=hzPV3/MHpC/JimHpDFSYV8Yu913JXZWQ1tDa/Sh3TV8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WU8snY3gYGCDuqQ6L96+Vqo2eWKs8nc9tHbObKtXI0vM2n7OQluV4ktdCpjBvj+oe
	 u2tJXtQBqs9HaexyhfBUxFvIla8taqG4rsl4oR31nYRXvfnox96r2wUBMkDbnEZYUU
	 44Jqx4ljSqhTrl85lYxyaopjcAl1RUUfqVus++YnhLHaeQXwC4k57kX49GE96VcJQp
	 V5y7SmdG9b737Ri2y5CHoPGnWUfpVc+aaMx2rsYVGSxvfwD5gMX6O2etu3uERX7nWN
	 +FuGS7HWRwKGNJFoxa2g2Msg18rlTORjbHwbmOss+wvbxwlFYQHu6g7nKEWhPjKcAk
	 xNhhazDCefCkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713183822D30;
	Thu,  5 Sep 2024 00:00:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests: net: convert comma to semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172549444199.1204284.9957982642293621560.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 00:00:41 +0000
References: <20240904014441.1065753-1-nichen@iscas.ac.cn>
In-Reply-To: <20240904014441.1065753-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Sep 2024 09:44:41 +0800 you wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> [...]

Here is the summary with links:
  - [v2] selftests: net: convert comma to semicolon
    https://git.kernel.org/netdev/net-next/c/6ffa72acc9c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



