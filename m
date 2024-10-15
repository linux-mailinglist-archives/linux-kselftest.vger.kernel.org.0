Return-Path: <linux-kselftest+bounces-19756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BE999F39B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 19:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170861C22514
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 17:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24DF1F9ECC;
	Tue, 15 Oct 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSr+p1Rq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9242A17335C;
	Tue, 15 Oct 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011628; cv=none; b=WCc+Z9OmvtnzRx0DLKV/3ye9qoHQvxlPyJB/biABQfv6TJJHiNdeIa+gTfd9bpadvN6I35LyRIqL9IbDLiLNGsla/cBIKLWsoIXoYS8zon5MtHYaZa+UBpLc06/b5756k9hVBCels3g1G8OcniD/wqJiQ5DIPDHkGJAEwqRzpno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011628; c=relaxed/simple;
	bh=Nwu41dzaEWDp1rGNcRIVuBwHokJnoYbOl0yUqbY7HMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VlxAyAVcEBghxRmICsM6Xzf3RffM0ZfaXbc3BosEqkoIkvQT/2Yz8PD7bAOQmdBo1zr7BJ7l+dc7WFGE9gBDrnKslwTp237LTKcEDDCsch5kt7rOr30krZOJAmpwBCahWM8s8QDyQVtXMyG70HMiwocr9x9X537G3RRgJbyxEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSr+p1Rq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0E3C4CEC6;
	Tue, 15 Oct 2024 17:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729011628;
	bh=Nwu41dzaEWDp1rGNcRIVuBwHokJnoYbOl0yUqbY7HMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WSr+p1Rq29B+g8UY+/WKhao+uDg+uPRR913+Nz/mngJrbz73K3EFU+GOaHFsfGNIc
	 eqCBeWXUWPsdkuTIJ1RaGFtCrhJj5fkX29xMXlkniWw22rj1T57Rthi9HmibxqpDbe
	 vkgPOE5twI4C1gUjsz5u38LntmSlmC65kBRJ7Fsh5UXYlfTNFehkdYtnx9BXib0KIC
	 bqVclzo9H5DNeNHCCnSEZVkY8j/Wlcc/lr9xk3SuE9sH1ipytYon9BRUcrD76i0ZlR
	 /rVRkzDUHHtmm7QWD5RntVTW9hxkLTb/HWgRKn0nZwdwx1IuX60QfA0yULaCgY08/r
	 H0ACTe3bRfjcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E383809A8A;
	Tue, 15 Oct 2024 17:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v04 0/3] net: af_packet: allow joining a fanout when
 link is down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172901163324.1227877.13057096271460505473.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 17:00:33 +0000
References: <cover.1728802323.git.gur.stavi@huawei.com>
In-Reply-To: <cover.1728802323.git.gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 willemdebruijn.kernel@gmail.com, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Oct 2024 10:15:24 +0300 you wrote:
> PACKET socket can retain its fanout membership through link down and up
> and leave a fanout while closed regardless of link state.
> However, socket was forbidden from joining a fanout while it was not
> RUNNING.
> 
> This scenario was identified while studying DPDK pmd_af_packet_drv.
> Since sockets are only created during initialization, there is no reason
> to fail the initialization if a single link is temporarily down.
> 
> [...]

Here is the summary with links:
  - [net-next,v04,1/3] af_packet: allow fanout_add when socket is not RUNNING
    https://git.kernel.org/netdev/net-next/c/2cee3e6e2e4b
  - [net-next,v04,2/3] selftests: net/psock_fanout: socket joins fanout when link is down
    https://git.kernel.org/netdev/net-next/c/9317e8933e27
  - [net-next,v04,3/3] selftests: net/psock_fanout: unbound socket fanout
    https://git.kernel.org/netdev/net-next/c/7ec02a3aef05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



