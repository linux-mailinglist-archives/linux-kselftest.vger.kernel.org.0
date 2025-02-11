Return-Path: <linux-kselftest+bounces-26324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDD1A30229
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 04:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B553A9870
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 03:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181A51D61A5;
	Tue, 11 Feb 2025 03:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbt18T0R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D884A1D6194;
	Tue, 11 Feb 2025 03:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739244614; cv=none; b=bYt7d2DFtTnFuDXDj/auNExGcnx948XsA/oloqEdlzipNInORCf18AqoHSFFusgd3h1uVXICETs+G++KGPJfVT2BoJeBXy53aTxaLaqzvp+WwMR+DriCJeVar07KAEdSMw639aBlvZ+JNA5l8JeqqBQsurJ9MbmLARYLAW24ehU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739244614; c=relaxed/simple;
	bh=Td1U0MsX4jwP0X608ibiA1txDzrYo+jkLqYHfL6unXc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qwqGY5CvkV25yXYpzyk/UL9w4wBS4eTpyZRH6oqn0uELQew9ShxsLhKL3zIbj9c+7XneNCLgitMrQT8PqW5+C657+9O5VcJ6x9oz2gmfYZq2imb2jxk5ZYaeiSHfYE3NNHl9elIRqXiuI4vFJJWa740Yj+FHzXXwqfP4joJFzHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbt18T0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A01C4CEEA;
	Tue, 11 Feb 2025 03:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739244613;
	bh=Td1U0MsX4jwP0X608ibiA1txDzrYo+jkLqYHfL6unXc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gbt18T0RcqqWiwoOTneZSCFnbdT9Fh21yaei243no3AOA6QOtjPweKQuRpUQSF1oP
	 z9Lztst6r2SkNca/uGAtFwlQ2IquVXqAUCAHbPY7tuhm5fMn8ebzZAk7fu4WeD3hnn
	 QOIQSJsL7MRnGD0JSM+yz9/9KmDw4PEuCi9rO5V+2O3lNm4INPGEfZsZba8sYwJVSi
	 vfyPUVCxJ4HjKfZlK4LiJPMIQJEg6dzI5wSYXdlXkcwxf2qqGjKW0lJYwl76oeWDY7
	 M+/QswcMvpB5c4SKp1VT6ExvkdahmqBBGejG54v2Ynq1kJPlPnNaSEO8Gu5gT97iWJ
	 QRNI6EVZuTfVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DDF380AA7A;
	Tue, 11 Feb 2025 03:30:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/7] tun: Unify vnet implementation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173924464176.3948401.17256177133677367804.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 03:30:41 +0000
References: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
In-Reply-To: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: corbet@lwn.net, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mst@redhat.com, xuanzhuo@linux.alibaba.com, shuah@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 yuri.benditovich@daynix.com, andrew@daynix.com, stephen@networkplumber.org,
 gur.stavi@huawei.com, devel@daynix.com, willemb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 07 Feb 2025 15:10:50 +0900 you wrote:
> When I implemented virtio's hash-related features to tun/tap [1],
> I found tun/tap does not fill the entire region reserved for the virtio
> header, leaving some uninitialized hole in the middle of the buffer
> after read()/recvmesg().
> 
> This series fills the uninitialized hole. More concretely, the
> num_buffers field will be initialized with 1, and the other fields will
> be inialized with 0. Setting the num_buffers field to 1 is mandated by
> virtio 1.0 [2].
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/7] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
    https://git.kernel.org/netdev/net-next/c/5a9c5e5d8a1b
  - [net-next,v6,2/7] tun: Keep hdr_len in tun_get_user()
    https://git.kernel.org/netdev/net-next/c/07e8b3bae2f8
  - [net-next,v6,3/7] tun: Decouple vnet from tun_struct
    https://git.kernel.org/netdev/net-next/c/60df67b94804
  - [net-next,v6,4/7] tun: Decouple vnet handling
    https://git.kernel.org/netdev/net-next/c/2506251e81d1
  - [net-next,v6,5/7] tun: Extract the vnet handling code
    https://git.kernel.org/netdev/net-next/c/1d41e2fa93f7
  - [net-next,v6,6/7] tap: Keep hdr_len in tap_get_user()
    https://git.kernel.org/netdev/net-next/c/74212f20f366
  - [net-next,v6,7/7] tap: Use tun's vnet-related code
    https://git.kernel.org/netdev/net-next/c/6a53fc5a8770

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



