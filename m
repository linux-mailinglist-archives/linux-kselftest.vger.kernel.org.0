Return-Path: <linux-kselftest+bounces-46174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A645C771FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 04:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE4AD355666
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 03:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130FA2E5405;
	Fri, 21 Nov 2025 03:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvCB4Lxg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EBA2E0418;
	Fri, 21 Nov 2025 03:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763694647; cv=none; b=U/L3nefXTEfYIs3A77ErbkrVt/070nbYQ/ZneCDfl3YFKqgyGn6OPe6Kt8WUxazaK/t4fVteGIgUm60/AJgso/3h5WGZLvF/pgnFscOzjQXg7yAhV4ZoCyA2XfIh5QW+XpC0vhea/g72s/ecNp+q+UKz8zX7cdT70wLJbyZYx98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763694647; c=relaxed/simple;
	bh=vUzuRKiaFsYAF5jLm0H0Pp3e+s5tGDkeNxZpVFn7MQc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BwyntQyokhj73Rmn9Eiw7PvwQWb5wplWS78Tq+EcCQJ7MWjjbJ3SmtEwhGJtbL51Bh5+AqnTKKkNeZ6Noe6p07oHvu0IarBL4AbHBoiCf0clT2f0/GNSunoA4aVl3fo0b65rrFY8GsNgg5/ZroeourGtBjCroH4oYEDPecGy9MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvCB4Lxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7808DC4CEF1;
	Fri, 21 Nov 2025 03:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763694646;
	bh=vUzuRKiaFsYAF5jLm0H0Pp3e+s5tGDkeNxZpVFn7MQc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AvCB4LxgC02uDgHmydivnqOoY/cCbDwUhTtL8mK2HKoTf/XrnPZEPkwqN+Zz7lJUX
	 V7+a/q6BdFvThPPOzvPAdLqlYuayF0h0DTpFrl4YboZNwsuFdfERrwwUpRK5lsUwuN
	 EAOgkBhRIHR4avIF3ZhpfhyKrlpCvCFP7cFSMhKNG/BXMyCy1+SAYvW+JjeA2Sx4nT
	 c3eac0Mtxe7GYxVlGNMQq6wA1oExiNayP49lLCCWvDD3dohFIowe0mkq5qwEGOTx+l
	 Fbvm47qr5c+jcwUrza/yHfZBAwPwjaDc7WREh6wmmvYOV5Hj5Ht4vx8IBgot7chRpo
	 qTtpcovGYgcfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3FD3A41003;
	Fri, 21 Nov 2025 03:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] netconsole: Allow userdata buffer to grow
 dynamically
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176369461151.1878899.12543595195471306601.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 03:10:11 +0000
References: <20251119-netconsole_dynamic_extradata-v3-0-497ac3191707@meta.com>
In-Reply-To: 
 <20251119-netconsole_dynamic_extradata-v3-0-497ac3191707@meta.com>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: leitao@debian.org, asantostc@gmail.com, horms@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Nov 2025 16:14:48 -0800 you wrote:
> The current netconsole implementation allocates a static buffer for
> extradata (userdata + sysdata) with a fixed size of
> MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS bytes for every target,
> regardless of whether userspace actually uses this feature. This forces
> us to keep MAX_EXTRADATA_ITEMS small (16), which is restrictive for
> users who need to attach more metadata to their log messages.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] netconsole: Simplify send_fragmented_body()
    https://git.kernel.org/netdev/net-next/c/7279b718b431
  - [net-next,v3,2/4] netconsole: Split userdata and sysdata
    https://git.kernel.org/netdev/net-next/c/9dc10f50c430
  - [net-next,v3,3/4] netconsole: Dynamic allocation of userdata buffer
    https://git.kernel.org/netdev/net-next/c/eb83801af2dc
  - [net-next,v3,4/4] netconsole: Increase MAX_USERDATA_ITEMS
    https://git.kernel.org/netdev/net-next/c/5ad994534172

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



