Return-Path: <linux-kselftest+bounces-28429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BD8A55794
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 21:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14C0176940
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 20:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6486F276D25;
	Thu,  6 Mar 2025 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1i7/cgf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A92249E5;
	Thu,  6 Mar 2025 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293602; cv=none; b=G8f6hHony2rVDHvb6VQFtgKPpdJ2mHYacaUI4u7K1CChwT3yLlkdihPEcc561oF/hZlTvQlrKj3zaew7QkBv1nq/lapLx16fzFcLheS2iW9GyWcvi0vyW/wChwCr+KWhpgTH48hqhWkDRD4Pe33sdCFfez0owm1ZtJ1Bs4RmOEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293602; c=relaxed/simple;
	bh=WpTquylpPERu/EGgiaXhIPQetlGdcCAvXf1ghOlVDq8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RCuTcSOLxTTUER8l7g4KJYHGfW2znZNZ/CtEiHrwM7xJZiDmfchaHSbhwKCFbXXgty6Wf60YphzAHFinVHw3A8Ighp5ILu3p2rVWNMtG7ooGH7La0VH0AuJWnhaAjW6LXX5ZwvxQ17cJ1F489mdAlNuAWc1/D6Iigp/BujTGzgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1i7/cgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898ABC4CEE0;
	Thu,  6 Mar 2025 20:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741293601;
	bh=WpTquylpPERu/EGgiaXhIPQetlGdcCAvXf1ghOlVDq8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P1i7/cgfjFM4Z0erfsxIZDrpB0fD05BsnHLHfDSFDe387ahjP/T5HmiP9SZiaDaja
	 pmjLxKipBtF87VcT5BHe2BwSXxB4Veh+GObr6t5b/u6QWgx0YLEYQqv/X4RwnwqlZd
	 WhbM/OTze8JV84OaWHz+5esg1hx5gh8JBjJ6i6R4xddeWz3GZTHD/qyq/wh4k3QctH
	 uaAbhukLZ9ncqMOgDJLndXdb9WUwqFFvblutuxWFlXVzZH65+PZqmbghtcsoimaysG
	 vRq8sOXodQg5ySiIF5If/vDaanoOI54Izaer2ZAYIayPu6gylrAz8rufy3nTAK0QE8
	 4iEo0Z1NLO6FQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEFF380CEE6;
	Thu,  6 Mar 2025 20:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/6] XDP metadata support for tun driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174129363479.1769540.9069391610888799796.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 20:40:34 +0000
References: <20250305213438.3863922-1-marcus.wichelmann@hetzner-cloud.de>
In-Reply-To: <20250305213438.3863922-1-marcus.wichelmann@hetzner-cloud.de>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, hawk@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed,  5 Mar 2025 21:34:32 +0000 you wrote:
> Hi all,
> 
> this v5 of the patch series is very similar to v4, but rebased onto the
> bpf-next/net branch instead of bpf-next/master.
> Because the commit c047e0e0e435 ("selftests/bpf: Optionally open a
> dedicated namespace to run test in it") is not yet included in this branch,
> I changed the xdp_context_tuntap test to manually create a namespace to run
> the test in.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/6] net: tun: enable XDP metadata support
    https://git.kernel.org/bpf/bpf-next/c/c2315ebb0588
  - [bpf-next,v5,2/6] net: tun: enable transfer of XDP metadata to skb
    https://git.kernel.org/bpf/bpf-next/c/0ca23a4d64ce
  - [bpf-next,v5,3/6] selftests/bpf: move open_tuntap to network helpers
    https://git.kernel.org/bpf/bpf-next/c/d5ca409c86d3
  - [bpf-next,v5,4/6] selftests/bpf: refactor xdp_context_functional test and bpf program
    https://git.kernel.org/bpf/bpf-next/c/b46aa22b66d3
  - [bpf-next,v5,5/6] selftests/bpf: add test for XDP metadata support in tun driver
    https://git.kernel.org/bpf/bpf-next/c/73eeecc3cdfe
  - [bpf-next,v5,6/6] selftests/bpf: fix file descriptor assertion in open_tuntap helper
    https://git.kernel.org/bpf/bpf-next/c/49306d5bfc6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



