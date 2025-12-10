Return-Path: <linux-kselftest+bounces-47357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAD6CB258F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 09:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA97D302C4E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 08:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFB72E1F11;
	Wed, 10 Dec 2025 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlqPFuBV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EC7225415;
	Wed, 10 Dec 2025 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765353794; cv=none; b=LukU2AtgORC02nq6Y3VB/UaQUfSKaQHoFXhez0btaRqC2/D5onZ7cl6xeDDY7IThVMHnDIZOwc0cQxZXGWlQTn2qcOpLWDFfv/apygsQ3OZxvHek/THt7DZmoZiZ6RHcPImltWbYe48cAKCx6m3IAKTlLCj2gZGp+CJhd0Rf6fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765353794; c=relaxed/simple;
	bh=eg6sqIrjSFRwMqCDvFPFBp9XRD0Q6ZvFkT/9lBl/LWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WR0zZM5tQNvDyQvFLNUpUpN448s3KxXsZWNdCVr+9t8sjQXrcgGGuHQUVFTEcIo0xWlHlmdGDZWsiKau/7OMS2k3eqEKr/kSQg/pYEmvuP845XzeTZKjrdavuEWvyG0tChFFXGCctU5nYxnvW3vUBw4b/w6ZI/U9PUTgHbxqWgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlqPFuBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F95C4CEF1;
	Wed, 10 Dec 2025 08:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765353794;
	bh=eg6sqIrjSFRwMqCDvFPFBp9XRD0Q6ZvFkT/9lBl/LWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qlqPFuBVKxzX/8TshxI44AbH7EEOyBEGQ95nU8/aj3Zc+UfXfDbsEwaQW5amF/Dms
	 okS0ljkM8eVlTrk6MY1U4DWcKcmug8RGfSgqxGi2/5y/sl1RU2FssP4jNAOvoM6T8l
	 xKxq+FWLqLmc57gZKTwnwYn6MDt7PBjJz00oYTFZJYWj4jfPQmmUsstg3souF2q8k5
	 tp6t766SvInbxo+/UA7ls6sF5t+6+pw+T9/oxp+kQPUB2u8Fh89cfZiE8GZZvSdejd
	 M0asV6o4d0mUQ0CctQtOuV3yNAF2dbG5m/XZ1ItD6Rxk/AuONsjWFSgwzICfQjD6wV
	 FxIMnkmYhSRYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BB693809A18;
	Wed, 10 Dec 2025 08:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: cpumap: improve error propagation in
 cpu_map_update_elem()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176535360904.496554.15981377214035277789.git-patchwork-notify@kernel.org>
Date: Wed, 10 Dec 2025 08:00:09 +0000
References: <20251208131449.73036-1-enjuk@amazon.com>
In-Reply-To: <20251208131449.73036-1-enjuk@amazon.com>
To: Kohei Enju <enjuk@amazon.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, shuah@kernel.org, toke@kernel.org, kohei.enju@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 8 Dec 2025 22:14:30 +0900 you wrote:
> This series improves error propagation in cpumap and adds selftests that
> cover the failure cases.
> 
> Currently, failures returned from __cpu_map_entry_alloc() are ignored
> and always converted to -ENOMEM by cpu_map_update_elem(). This series
> ensures the correct error propagation and adds selftests.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: cpumap: propagate underlying error in cpu_map_update_elem()
    https://git.kernel.org/bpf/bpf-next/c/48e11bad9a1f
  - [bpf-next,v2,2/2] selftests/bpf: add tests for attaching invalid fd
    https://git.kernel.org/bpf/bpf-next/c/18352f8fae91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



