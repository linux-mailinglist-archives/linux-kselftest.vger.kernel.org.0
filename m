Return-Path: <linux-kselftest+bounces-5250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDC585EBCF
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 23:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70902283B2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 22:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908E12AADC;
	Wed, 21 Feb 2024 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwMQgj3u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDB345C10;
	Wed, 21 Feb 2024 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554629; cv=none; b=sEs+tE1BJuGKobY2Y4N8Vx3vtgDcOViMViRCQ6wbjMkvoccn04c5hV4HiQzDu1iiJaUa4zu2zcx+i8ov8uds6sXGxNgiGtKssVlnf/Q2Dd+/ts1lanehrJ713jxqVNrpbALWDWnt32ORJL0HW02m8fqkkgH2DO0NPuMsuc//yqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554629; c=relaxed/simple;
	bh=UGvpYdwhKfNdL4uFNxnChzkqEIgJJ4MA7/7ZqJJmEcU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aNv4sAvx92dw75ogWQUxSOCn9XjJyyQyVNMathsxdtpSt7qtufRO66C6ZLGxDfCxAJYV11cL87B6eh9qEgQkJC6pLb5Xj2VjGzW4ZiyRW0I0Nge9nf89C2FIcTsTPIuLC5dPvmSOzyVTsSl43nNeJbOZGDdvBQ3/ElnQ8gsrkH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwMQgj3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CB06C43399;
	Wed, 21 Feb 2024 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708554629;
	bh=UGvpYdwhKfNdL4uFNxnChzkqEIgJJ4MA7/7ZqJJmEcU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XwMQgj3ugaoZiaZ+qc/o+3eo932wc6zvFjg0lOlX5fuL7cnZe8mHvc7rSWSwrKvu8
	 KdbM9OodmU/IlkvNnnB7vNaFciA1/BFplgtA2Iy8bgyq9Nx0/+seKLVAN8rEuloqbh
	 QvzD8DTRnw5r2w7xJFQXkuZ72sJAYT+ycPjyyEhVx461X+F0MTWlVwb2JkQFIpb1rx
	 PtDbk0FqhqGJH+hWCV9y0N8ccpYeqR43EkeKXEtI26lwEqi/gPgQOCTI9CVxPo3Hhy
	 zKU08jw+OYxJKm08Uk1covjJPS71NQJlopE0kUse/+MnjePlgEq+YJY/CMsSv4LlJY
	 QgCPIywCMfApw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11C91D84BC0;
	Wed, 21 Feb 2024 22:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] tls: fixes for record type handling with PEEK
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170855462906.28356.14505768197240352814.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 22:30:29 +0000
References: <cover.1708007371.git.sd@queasysnail.net>
In-Reply-To: <cover.1708007371.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, vakul.garg@nxp.com, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Feb 2024 17:17:28 +0100 you wrote:
> There are multiple bugs in tls_sw_recvmsg's handling of record types
> when MSG_PEEK flag is used, which can lead to incorrectly merging two
> records:
>  - consecutive non-DATA records shouldn't be merged, even if they're
>    the same type (partly handled by the test at the end of the main
>    loop)
>  - records of the same type (even DATA) shouldn't be merged if one
>    record of a different type comes in between
> 
> [...]

Here is the summary with links:
  - [net,1/5] tls: break out of main loop when PEEK gets a non-data record
    https://git.kernel.org/netdev/net/c/10f41d0710fc
  - [net,2/5] tls: stop recv() if initial process_rx_list gave us non-DATA
    https://git.kernel.org/netdev/net/c/fdfbaec5923d
  - [net,3/5] tls: don't skip over different type records from the rx_list
    https://git.kernel.org/netdev/net/c/ec823bf3a479
  - [net,4/5] selftests: tls: add test for merging of same-type control messages
    https://git.kernel.org/netdev/net/c/7b2a4c2a623a
  - [net,5/5] selftests: tls: add test for peeking past a record of a different type
    https://git.kernel.org/netdev/net/c/2bf6172632e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



