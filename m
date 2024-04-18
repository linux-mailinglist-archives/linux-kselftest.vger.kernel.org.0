Return-Path: <linux-kselftest+bounces-8290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D19538A90A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 03:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F081B2192F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 01:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D959D8488;
	Thu, 18 Apr 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7B/Cum6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B903A27E;
	Thu, 18 Apr 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403829; cv=none; b=EdIP5JiIx8PYOfkbbfBEvSN2Cl5685C6xmicDB8qYcVeOQL8fPfnM5JPUrsWlvYZYTIyCxYK6wZH4Ztv77qOVBCf9H4Bhz2ObXsfwBCa0kAUGM0DwoiTMNCaMsa9UNX6MySDDZXvh/SFM2NMa15Wvzprja1dGZU8qbqaUWasJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403829; c=relaxed/simple;
	bh=37D7Qm9pn82o9Kl06A8JCo2MtQzsjr0UlaxhfTbtgIs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=krApiA6KSVVZXQ1E8E2jzUPVNW+tQj+UaPWQKRQY3b6g0pfcvFcI8HbnNszahB6pHzkhPMMEVVbS1vZxg8yXkiCPz9FUjxeLqv3Ln+AFrR4qYGoJ0ShYH/Wu+Es/w2QhYg1LZyTGqMJJirObwjW7DWHZMSSmSZmZXDsiQ3L0pNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7B/Cum6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79F66C3277B;
	Thu, 18 Apr 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713403829;
	bh=37D7Qm9pn82o9Kl06A8JCo2MtQzsjr0UlaxhfTbtgIs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d7B/Cum6/5GIc5W+gqWZSDXuaJYBJuaCQJ5LIC2MAEBunR6+lqNYB76tZTYFov26U
	 C92F06GJmdi/vxgUXXU2fZeOX1XzvsUnUSf7qIuPe16krdmDkgmCn7kVfdAcZKQxvi
	 gOsALURSB8lPoiDCZFvUYkXfZKhE0aqzewVFKz1st/GhD1aUW3cAcMJUWjMHw2AMq/
	 6ub3zT6RprqN96AUNnupw+Zhx/LGl0ijwIBFocRIN6Z/+ZLFFpTLeoot3raR4x53BK
	 n6AyTbWQB1MuTS07wS6WQZcuGKAna0vnxSl/m+SOJ8uH1j8q2wRRVj2RX1eomNJjYb
	 eJrE3iF6WBleQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6735AC43617;
	Thu, 18 Apr 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: adopt BPF's approach to quieter builds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171340382940.22183.477575234617803213.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 01:30:29 +0000
References: <20240411190534.444918-1-kuba@kernel.org>
In-Reply-To: <20240411190534.444918-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: shuah@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Apr 2024 12:05:34 -0700 you wrote:
> selftest build is fairly noisy, it's easy to miss warnings.
> It's standard practice to add alternative messages in
> the Makefile. I was grepping for existing solutions,
> and found that bpf already has the right knobs.
> 
> Move them to lib.mk and adopt in net.
> Convert the basic rules in lib.mk.
> 
> [...]

Here is the summary with links:
  - selftests: adopt BPF's approach to quieter builds
    https://git.kernel.org/netdev/net-next/c/6fc6d7f59376

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



