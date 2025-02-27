Return-Path: <linux-kselftest+bounces-27701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 510E5A47351
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 04:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558133B044E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 03:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0E0156230;
	Thu, 27 Feb 2025 03:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxbPrrdc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501F78F4B;
	Thu, 27 Feb 2025 03:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625799; cv=none; b=VOQJL1V6ll4Rr22GC6SZbshjMDrnSEMdg97PLNNF+sx0vxv0HIuUBGsIKWV4Nme0EzqBpw5K/Jb0LZsressYEl48Co25dTGZegmGg5/PmUcJQRpmb2PiuywrIxCzeymAoou5bUvuOe7aaR0am5p67ocoOEdBKxjj9a3iQPwLGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625799; c=relaxed/simple;
	bh=RgujR+m5YBqIcHeODOWwq2gtvylemdsXvfYXhRFHWUQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o3ELGfcpldtmzuyXEhFqnZFtc3cpI829iXyRLHFYy9i9oRM+xxmZ+RjUW4M+pbth/TJkqVNwh9SUgljfGGc3ruRncDZKDZRmcOaSNxnkwxWcglWBz6veyCbxVLIfB1KGhg1ydgwVosDAn1KSYqJKhdDq5DGDM2iibF4+JgqOiNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxbPrrdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1A5C4CED6;
	Thu, 27 Feb 2025 03:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740625798;
	bh=RgujR+m5YBqIcHeODOWwq2gtvylemdsXvfYXhRFHWUQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SxbPrrdcLqqZ5fTezHOfqY/lbpH5dDqhsW6N36W1xUrYvq0IZl7TMdDwa9Pi6kvIR
	 DgG7TGiOhSovczxXDbBiTIblCNvUzZEMFMImSJSL0p8DeCcqbLRVwiRTXwZEuretX+
	 Ja4wtkoGADvRassOVVJQmBnUPdVlLLIxWMXvK6932E4M9mwK3ThRJBk9pwsTv+QNPz
	 7VRsz2xVgGpGz65S5nlr1Z1c9KOA8mh/J3xK+Y7uWlEearYER2zdRxBE56aVP5KNC/
	 sOp9xLrXrjPN/A+/jst+Hk3gxy50rhOI+kl8nVO4oEC6NMN/Gcj+vIzo9YwO4P8LY6
	 DOWtIdesteQyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD19380CFE6;
	Thu, 27 Feb 2025 03:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] expand cmsg_ipv6.sh with ipv4 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174062583050.951105.16448796087818825466.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 03:10:30 +0000
References: <20250225022431.2083926-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250225022431.2083926-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, willemb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 21:23:57 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Expand IPV6_TCLASS to also cover IP_TOS.
> Expand IPV6_HOPLIMIT to also cover IP_TTL.
> 
> A series of two patches for basic readability (patch 1 is a noop),
> and so that git does not interpret code changes + file rename as
> a whole file del + add.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftests/net: prepare cmsg_ipv6.sh for ipv4
    https://git.kernel.org/netdev/net-next/c/c1d6d629ab0b
  - [net-next,2/2] selftests/net: expand cmsg_ipv6.sh with ipv4
    https://git.kernel.org/netdev/net-next/c/2e5584e0f913

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



