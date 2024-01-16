Return-Path: <linux-kselftest+bounces-3071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C95A82EE68
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 12:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6462285BC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 11:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755631B950;
	Tue, 16 Jan 2024 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKd8ktM0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581DC1B944;
	Tue, 16 Jan 2024 11:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DD5BC433C7;
	Tue, 16 Jan 2024 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705405825;
	bh=0jpKEVqhIuIpiwQQTmzgdT0+5NfPrDOvcfJEFUiBIOM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oKd8ktM05DoLNewQl+o5M/8VW2bcNW5Pv/I5VPsZMGGlHBcPm2ogYnRojtA+l5CUf
	 joQvhHKS/l6LiHvbPUF9mxLGgUaL6eVk99UtLTG3E+e5aU+14cVnKFQe9UOchQV3FO
	 I2vRmFgcdFSf7UxYawBYtMENjLZDJCPsvlYA4ryylnurAHbhfPv1reRmrbX1Er1RIA
	 M4blioovTbdDx1wjBk201v/8azpfb4kRHOkP921XIx1puI/jF+oWPoL+4830AAKzkV
	 /619IMbDLfx4Z77MuNTnAL17zM2UmBSymfMD24w7QebCDkInrl6JNp1mwEmp/r9Hml
	 okePrgavZC5BA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0154FD8C972;
	Tue, 16 Jan 2024 11:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: netdevsim: correct expected FEC strings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170540582500.11912.14325454740265986186.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jan 2024 11:50:25 +0000
References: <20240114224748.1210578-1-kuba@kernel.org>
In-Reply-To: <20240114224748.1210578-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 14 Jan 2024 14:47:48 -0800 you wrote:
> ethtool CLI has changed its output. Make the test compatible.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net] selftests: netdevsim: correct expected FEC strings
    https://git.kernel.org/netdev/net/c/4697381bd076

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



