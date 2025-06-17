Return-Path: <linux-kselftest+bounces-35239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB1DADDFAE
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 01:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991C817C0E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 23:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC011295DBA;
	Tue, 17 Jun 2025 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz9PRamX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBB51EA7D2;
	Tue, 17 Jun 2025 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203032; cv=none; b=Dr0R1YVLW3xrEQVB9xF9jNqqbSNKf3Ct6ClL4eElUJSOKHAk/dAXvQftB9SpZsm31P8ji9zhXWydpmfupefFv5xCE/DB9UmVf0nONflr/k30NfBDaFMmsV1J/2NYRUGirwHtKJSLJbdsH5JRIiiXgFaIB+73ClT08mpLaJMYooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203032; c=relaxed/simple;
	bh=xzrMAcEnfRM69WTjL20uKG/AKZ06N55tGbVgilMsrMA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iruTjfVmrxs28MZuXQ/X6H/2GBh3xNisggJJFZyEs0I4eebX24JCEOQlhsaCTXqJl6jR8Yh5k3uWdh1zSVk0TaUfblNjChwDU1avgNzMc0GjQIvIpl+sUbOiI8Ksfh7nWfxooS2kgrDJiCuAPH/LAUPtXTdmkeaIJvIW7vPBt7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz9PRamX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1FFC4CEED;
	Tue, 17 Jun 2025 23:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750203031;
	bh=xzrMAcEnfRM69WTjL20uKG/AKZ06N55tGbVgilMsrMA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iz9PRamXqF0jLCaiVQiYfqxMNVE8SiLDyQnfLxW31fnwoQ8Ltd3sNziB6RhFV9Ujc
	 x5LdL/EH2+ulCWfO1iGh9RG+Qqkf77uB7tzLs5879O6WbeVCtYY3C75RvU1I+7pFcj
	 auRGS68zQbLu46ryaCwPOEWrVqq2trjC03xtIGF7V8VHlTzBV1cHlRw2cep3H60NHE
	 +cL6OAEIn/KZaTskXVZIQY+rypglkKobp/kjiEcUYWH1F873LhppkndtE9PQ4TMEdF
	 JGvCm3zfcSs4wvIq/liKVrbGbvC8QltGsOeWkRp0vN30q9OIBo/MVSAPw49bDxZkXF
	 TFEiahTB86CAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADAE38111DD;
	Tue, 17 Jun 2025 23:31:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests: nettest: Fix typo in log and error messages
 for
 clarity
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175020305948.3735715.13926918048338586145.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 23:30:59 +0000
References: <20250615084822.1344759-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250615084822.1344759-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, darren.kenny@oracle.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Jun 2025 01:48:12 -0700 you wrote:
> This patch corrects several logging and error message in nettest.c:
> - Corrects function name in log messages "setsockopt" -> "getsockopt".
> - Closes missing parentheses in "setsockopt(IPV6_FREEBIND)".
> - Replaces misleading error text ("Invalid port") with the correct
>   description ("Invalid prefix length").
> - remove Redundant wording like "status from status" and clarifies
>   context in IPC error messages.
> 
> [...]

Here is the summary with links:
  - [v2] selftests: nettest: Fix typo in log and error messages for clarity
    https://git.kernel.org/netdev/net-next/c/416b6030e39e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



