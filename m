Return-Path: <linux-kselftest+bounces-44366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92748C1DF46
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 01:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D32FC4E599F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 00:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E404721767D;
	Thu, 30 Oct 2025 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt7er47q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE41F2382;
	Thu, 30 Oct 2025 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761785446; cv=none; b=cU0COLxHCPWaq0+9pE4UZt2KRDLq+W31H8o3mY9qUuWqN0kugtSA5+pFy4C9Kchze75iHaSpNwpPn696iF60Kws378zqWUx+A6fziLlV8jwX+kcmL2LUBSmNccm6LfHsbK0uMoxbIPIUOXCvtnAHSLlgJFXWBJpN1efNK0ZDOXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761785446; c=relaxed/simple;
	bh=+DNxT3KQ5JB+d2Ywjk/LC5P+oSgjTwyQe1u8jQS7SRY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kER6/alP64alLmO+yGXQ99kgHYP429+6Nb9ax8YhT7zwiyfOGENrimBBl1yAFYtzQlJB+IHDvKzKMASRqeeGU8yRta4UQkLiIEQn6L/p4jwEKMINDrS4LhauAHtSYxgUbghirwja9bd2xF/DaRkIXmVudnk2Mt+P5aDQzmb5hzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt7er47q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B077C4CEF7;
	Thu, 30 Oct 2025 00:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761785446;
	bh=+DNxT3KQ5JB+d2Ywjk/LC5P+oSgjTwyQe1u8jQS7SRY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zt7er47q1NC7tLvAhddX50TUHGFIRO/3kEyQr221dntfSx1N6Wy+07rKL/Am45spE
	 stbwe4yh1GZQmtWkH5VemZsxg4/g86pb7hbn6O6kI7eI8fkCrZVaMs9wsdkLXe+CX7
	 bVR2SXlb0LLRTB7/Q4JTyUF/oFmYrMHaVDp4eo4DXUk8l9EYbqR14S3NV9NwG1J830
	 0SAkAINje/L0Wvvo8GDz+CD3ibRWzjwwcEZd5pOVbcxojskNeHUAPrp7paxCrApjmy
	 V8HXUi97wYNO9v+qXeOwhn9uo1uLtRDlDxyL4I423ezHcSmUHCUOiGU+Vu0RtcyllA
	 2FstgBNyvcxlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713243A55EC7;
	Thu, 30 Oct 2025 00:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftest: net: fix socklen_t type mismatch in
 sctp_collision test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178542306.3267234.14499254365702593744.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 00:50:23 +0000
References: <20251028172947.53153-1-ankitkhushwaha.linux@gmail.com>
In-Reply-To: <20251028172947.53153-1-ankitkhushwaha.linux@gmail.com>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, phil@nwl.cc,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 usama.anjum@collabora.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Oct 2025 22:59:47 +0530 you wrote:
> Socket APIs like recvfrom(), accept(), and getsockname() expect socklen_t*
> arg, but tests were using int variables. This causes -Wpointer-sign
> warnings on platforms where socklen_t is unsigned.
> 
> Change the variable type from int to socklen_t to resolve the warning and
> ensure type safety across platforms.
> 
> [...]

Here is the summary with links:
  - [v2] selftest: net: fix socklen_t type mismatch in sctp_collision test
    https://git.kernel.org/netdev/net-next/c/afb8f6567a5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



