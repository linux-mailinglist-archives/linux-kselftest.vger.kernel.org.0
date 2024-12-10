Return-Path: <linux-kselftest+bounces-23110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474DF9EB704
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 17:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F80D16226E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 16:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A033622FE07;
	Tue, 10 Dec 2024 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeuhTwDL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B681A76AC;
	Tue, 10 Dec 2024 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849415; cv=none; b=XgpIc8VhKjdQNOLC9ze8O6R0fALdlD/isVU594kRfTHgQq6R+NSv6BdpLxXSt7jISqVRunjFHHz+52aCLUMCkroKJ3qhAOkeniiELO+ahtcmVnfBWiBUxdAmY7ue2OvNhDoAYDE7W/t13ejSZLA/BBH41Z8+pMFGun0vLoWXRpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849415; c=relaxed/simple;
	bh=EzwAGQCNQjBDmSEsXEMzV3AoQPbQdGbQLJo5zAio39g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ATVHCwV7c1ad8CWcGQWVIzLHXYQZ/6CeWdUZ5nT0eoCIJM3JhguucqkgPUz/qH5pOSIImgBam9W4k1jisFkpUxM13uo++OihrcgpEvzht/361+tuBCjw7CbjjxGrM95j0Iie329lTr6+4SB7mOJFXSdqxvPEk1O+1VLD2NPIrC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeuhTwDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C99C4CED6;
	Tue, 10 Dec 2024 16:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733849415;
	bh=EzwAGQCNQjBDmSEsXEMzV3AoQPbQdGbQLJo5zAio39g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AeuhTwDLZbFU0OLAxdsQGiGypfa0Bfuk8OsS1QJNm0fDtqlamDe2OOmgE+jpn/OFB
	 490gWB9UPHuEmFw3lxCLSRnmav8NBAgXapt1N3uxoRKnt/IMRaz/Pk2oqEKmQgRbqL
	 CJolkQJ2IC9VgpiNkoPio/mQS+ma8AH4g5LCIwXeIlRVxVYePoy9MzfT4e/mbM7uoc
	 7xBtN9USj2ZsCQXsz8ftWw1/Grb08QTtDu+zJxoROqGPKml75Gf0Fh8Ry/7ozimPDh
	 4VPpxedNejc1fITip8Iw7aRDHSfcTTabUW0Pn0VksBIKjPtzw0cp/6bEciutTOFYeY
	 mG1VlGACznXNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4B3380A954;
	Tue, 10 Dec 2024 16:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/3] bpf, sockmap: Fix the element replace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173384943076.907573.13245503646453425882.git-patchwork-notify@kernel.org>
Date: Tue, 10 Dec 2024 16:50:30 +0000
References: <20241202-sockmap-replace-v1-0-1e88579e7bd5@rbox.co>
In-Reply-To: <20241202-sockmap-replace-v1-0-1e88579e7bd5@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 02 Dec 2024 12:29:22 +0100 you wrote:
> Series takes care of two issues with sockmap update: inconsistent behaviour
> after update with same, and race/refcount imbalance on element replace.
> 
> I am hesitant if patch 3/3 ("bpf, sockmap: Fix race between element replace
> and close()") is the right approach. I might have missed some detail of the
> current __sock_map_delete() implementation. I'd be grateful for comments,
> thanks.
> 
> [...]

Here is the summary with links:
  - [bpf,1/3] bpf, sockmap: Fix update element with same
    https://git.kernel.org/bpf/bpf/c/75e072a390da
  - [bpf,2/3] selftest/bpf: Extend test for sockmap update with same
    https://git.kernel.org/bpf/bpf/c/11d5245f608f
  - [bpf,3/3] bpf, sockmap: Fix race between element replace and close()
    https://git.kernel.org/bpf/bpf/c/ed1fc5d76b81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



