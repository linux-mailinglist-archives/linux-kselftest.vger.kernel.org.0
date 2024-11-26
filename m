Return-Path: <linux-kselftest+bounces-22528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CFA9D94DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 10:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9175AB2F56E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2257B1BC9EE;
	Tue, 26 Nov 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuuMsnd4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80DB1B86F6;
	Tue, 26 Nov 2024 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614020; cv=none; b=Lea1B1ShO/seFJhehLEQpj2mFvMMG3G22HFmEfLsowQqAwY9z67E3D/RpKf3qxWWYwihTgbJpgGx5xwCkUV2ht4G4Nch7ydHmrKdB2UD5zh/YrkbjzFafDCzn2iQEkE42Mf2NYqfSslQ4KZUimHe6DYij9zPH+zHaeJ9QHhX9AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614020; c=relaxed/simple;
	bh=DlQ3FEcvM/iB8RpvmO6gR2ljj0rmS9p+1Mhd1/bfHuE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ag5cANiAg8EtEJ8w8m8a+0vhP+FCXdMqPo5v1XBWZwh+eqbDqp8X3UJ82vk2ySY1AFZKTFWs5isBuuLEl0+5OtUV0ys5j3RAaKxibRop17uP7zDQijhax39RzSd5VBGBIhLnZ1/MaZHTRkvXjVhqu9Hvr6aRcFkJ46E06posdEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuuMsnd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FB6C4CECF;
	Tue, 26 Nov 2024 09:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732614019;
	bh=DlQ3FEcvM/iB8RpvmO6gR2ljj0rmS9p+1Mhd1/bfHuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kuuMsnd4JijKLmd8is5O6ChPEQJjL0Q9RSXr5NlMtgTq2lZjRThNiL1whh2woU4/6
	 TP1+G+3AwgDyoTLPaCsTjYQh8sm+jntr4ACaTCBV9LtmUMBpG3wqxFXeqT5LA3RFRn
	 aUClGFkKQ9tTo5j6Y5AanGYL4g6zz5o4tgUo3C3+JZTg9Vy7HVlAyi1/5zl7ktBV0S
	 YiUwJdMMZ59YxY8t8O4iLXLBD30PiDU/0iTYcoeDWLVSFSY3miDVcQj2odGBah915A
	 1Apo+DpdMR2JmX38x2RzAR5TVaeBk1S1QRzkwnNnIWEoRtB8vF+v05vVCsHlwdfIxw
	 OmAxOhNsKa7LA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F5D3809A00;
	Tue, 26 Nov 2024 09:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net 0/2] ipv6: fix temporary address not removed correctly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173261403225.326777.3409947795275004988.git-patchwork-notify@kernel.org>
Date: Tue, 26 Nov 2024 09:40:32 +0000
References: <20241120095108.199779-1-liuhangbin@gmail.com>
In-Reply-To: <20241120095108.199779-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, cfsworks@gmail.com, maze@google.com,
 alexhenrie24@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 20 Nov 2024 09:51:06 +0000 you wrote:
> Currently the temporary address is not removed when mngtmpaddr is deleted
> or becomes unmanaged. The patch set fixed this issue and add a related
> test.
> 
> v2:
> 1) delete the tempaddrs directly instead of remove them in  addrconf_verify_rtnl(Sam Edwards)
> 2) Update the test case by checking the address including, add Sam in SOB (Sam Edwards)
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net,1/2] net/ipv6: delete temporary address if mngtmpaddr is removed or unmanaged
    https://git.kernel.org/netdev/net/c/00b5b7aab9e4
  - [PATCHv2,net,2/2] selftests/rtnetlink.sh: add mngtempaddr test
    https://git.kernel.org/netdev/net/c/f6e1dcd64444

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



