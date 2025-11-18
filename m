Return-Path: <linux-kselftest+bounces-45859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FD7C68DF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 11:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DF4A4E152C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64A4340DBE;
	Tue, 18 Nov 2025 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQb2bSsh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990833112BB;
	Tue, 18 Nov 2025 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763462442; cv=none; b=cfF80UUOsou7JV6Z5Zl1Okn97tBbX/U2EFL+s3C4qq/a9b2sPDV2p8v018ZwDESIXJD1ok2iamIkBijsq/7TZ9EwFaklCWWEZGo8O1Jum6h7LhA3Kq3m39Jsh5JfXa0fECnCQY4lhkDTRhp9m031T4vJahBbQd1meSfdNPKeG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763462442; c=relaxed/simple;
	bh=ugqbmJDGiYF6qRacwGL2VG/L3gey8JKa5v8pcJ3Sxxo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VWYuiXr3wTMJD3FuugVbFjCFrl5iAaMZYta/qMT1YMJGsAqxBGudwjWeRoooycbHHc920qHgaDPl9Uo6v87/RvbkWfsutTM5JPhFBYhk70I6pnblt8rMViwfIucSarCnN9Om1oeaIJYe9U0hpG+xNHSyun7LTCXLlDutZzTx3+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQb2bSsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC125C2BC86;
	Tue, 18 Nov 2025 10:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763462441;
	bh=ugqbmJDGiYF6qRacwGL2VG/L3gey8JKa5v8pcJ3Sxxo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NQb2bSshKGfpCak868DBiZaJiLe/ORQ+XSX1TTEK0qfVn1yShkNTq3rEA1eUssnC/
	 SU1b80JGmWPsBC8ootAEDeDz5+BtXCb/c/T2auobH6U0eBrWKojFAu4td7F4DDSI7i
	 eOhpATndmJ/JAWNYj/xRSPxOUqi2s1eeudBuMcK1vg9+Dv9GC59QcIbce1NwARArEu
	 kEui6q+URzTBjXyv/iV1ofYPA23+O+wjpNTNOevXnWIAAJPEJ+d5lV4h2vckpJJ/B6
	 Htf813wA2L6E4rSC4AwHfO79i3BJE7OeCsv/bnpzvEvtIVN2m1VJynF73wD005x8F4
	 hsOmYX+e+Qk7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710033809A84;
	Tue, 18 Nov 2025 10:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] selftests: af_unix: Add tests for ECONNRESET and EOF
 semantics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176346240626.4087956.15974083962638207959.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 10:40:06 +0000
References: <20251113112802.44657-1-adelodunolaoluwa@yahoo.com>
In-Reply-To: <20251113112802.44657-1-adelodunolaoluwa@yahoo.com>
To: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, kuniyu@google.com,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Nov 2025 12:28:02 +0100 you wrote:
> Add selftests to verify and document Linux’s intended behaviour for
> UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM) when a peer closes.
> The tests verify that:
> 
>  1. SOCK_STREAM returns EOF when the peer closes normally.
>  2. SOCK_STREAM returns ECONNRESET if the peer closes with unread data.
>  3. SOCK_SEQPACKET returns EOF when the peer closes normally.
>  4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread data.
>  5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
> 
> [...]

Here is the summary with links:
  - [v6] selftests: af_unix: Add tests for ECONNRESET and EOF semantics
    https://git.kernel.org/netdev/net-next/c/45a1cd8346ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



