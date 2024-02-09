Return-Path: <linux-kselftest+bounces-4481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE08584FE0D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 22:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0422841C4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 21:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCDE15AF1;
	Fri,  9 Feb 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLDuZ9Xs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5476612B79;
	Fri,  9 Feb 2024 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512431; cv=none; b=X+BRQYbkcNtpJTTBjUvQ5OvhjoX4UzqV2FKhouY0OryNAPOR4aByOwTMEvSS5lt0/Wc6C5eNhULHZSK2PqUdZmsiHKsutFVwFEh7pCsdmz1Mfdl5+lL/uEKcZivFUKoxl5CIPmvgbaFnxNEzEqmPmAdJL8TQBEW05Xk6DTjEHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512431; c=relaxed/simple;
	bh=SI2LJmBeBomZH+OUYEwj+ZAkonco7EuXhYvfIKHbf90=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k46DdGdFXlk/SNIQkj5rPS7AazbH0UKtonkN1+g5Ys3NoHq5/7ZNMZTprqZqF33C8CgNa4Y5psA3FVDFdDB/XsAnlD/wYNewTY5oqMYwL3CVi0ZbCDzlNX5F12n7mp0JgO67CtOdKIItn/ihh5mB++cCHamaLfzR498FLs9GJPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLDuZ9Xs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF107C43601;
	Fri,  9 Feb 2024 21:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707512430;
	bh=SI2LJmBeBomZH+OUYEwj+ZAkonco7EuXhYvfIKHbf90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LLDuZ9XsJqlr8oKREYKhgWOfaKLxGNq6rpEVZjyeTw1xiZi2Z2W+3SLJQ5NbEEudb
	 Gl3Q370iTZvgmE+FbhPOBcFtESL3llqg/4RodOZWYg4xuVAeIYf67oh5YsgXBVN93U
	 hImhFWzD0/8Kr1VgofBKV63Sk+GA1iOkkbZUYNWlQVoHe8f+S1R+wsArLBXfg+8HmR
	 bzft5ya+KtJUGn6I/wx4NbkCcmxiACnd83U7PIrghWWe51n90VFvtj2H8vfr8yF/3d
	 zYWQ6Yc1clcDXpf8Rb+hzY7y7PlcTLZeoN9j8qauTlb6Do+CRdrxovcI/9AChZ7QaL
	 Z72bJKUpwuz0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE03EC395F1;
	Fri,  9 Feb 2024 21:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: include forwarding lib
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170751243070.9207.408296797179580703.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 21:00:30 +0000
References: <f7b1e9d468224cbc136d304362315499fe39848f.1707298927.git.pabeni@redhat.com>
In-Reply-To: <f7b1e9d468224cbc136d304362315499fe39848f.1707298927.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Feb 2024 10:42:45 +0100 you wrote:
> The altnames test uses the forwarding/lib.sh and that dependency
> currently causes failures when running the test after install:
> 
>   make -C tools/testing/selftests/ TARGETS=net install
>   ./tools/testing/selftests/kselftest_install/run_kselftest.sh \
>       -t net:altnames.sh
>   # ...
>   # ./altnames.sh: line 8: ./forwarding/lib.sh: No such file or directory
>   # RTNETLINK answers: Operation not permitted
>   # ./altnames.sh: line 73: tests_run: command not found
>   # ./altnames.sh: line 65: pre_cleanup: command not found
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: include forwarding lib
    https://git.kernel.org/netdev/net-next/c/876e32473d1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



