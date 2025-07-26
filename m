Return-Path: <linux-kselftest+bounces-38022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE074B12BFE
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 21:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B982F7A7397
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 19:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765A1289E05;
	Sat, 26 Jul 2025 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhq0TsIO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A01963CF;
	Sat, 26 Jul 2025 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753556997; cv=none; b=ppb5GfDyCk6CNg5msov9Cf7siGHYkgofFbkZkb2o14Hwwl1hIz0BeIGmcK75jtTew7IyVuuOG0DiBfPYhF8g05aZ7iDrkJNzxAtUGgSfIHmTtUWqH9i/VZ3ja0QD4bImb+3Lznep3e3V76FY34sqhHaiRNiGt4kNjxc2EAZczdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753556997; c=relaxed/simple;
	bh=E1FZ52HWY9TlqXJBqX9rTh4BM5QGWtbaIUhdNGCKjg0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XFvY2ydc5YHvBZ2M42JMsQNnVrMsPNh2i2vvazXmWWCtbsq1vGxJiKNHFMck7DSKwvNt31Jacb/g8YbGJ3hadYs2q+zs91PeqZ/lgCTrWpqLk0Q45TqsmtfRN2r+z1BKYAKayQDZYiIz1gqjUoRcjBLGh6A0BogiBW6Ompk1MqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhq0TsIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBD9C4CEED;
	Sat, 26 Jul 2025 19:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753556996;
	bh=E1FZ52HWY9TlqXJBqX9rTh4BM5QGWtbaIUhdNGCKjg0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fhq0TsIOEYCch8R6t9HWVuUWxTowe7O0QoaAvqzpPsfADmg5CX70Hmv8K3bJvzThn
	 OZc3j9hWDPt0S2EO4GwxkxWoLDAddaM0fBfBEkjHVRlNVnJ7i6QmcfTLkWe+ctO8xt
	 PSiQ4xGuhSR/t9tOrplonJUjLcGjhDUQJHKiEaEcnLap6tKrZfw/L4HLiRLldvlt/p
	 syN5uPNoUZ+/yCRIK/AuZ59uer3X3Nmn1OlCrZeprej9gY60/wt3rcDuLcyOUxush6
	 YxjFEeem54wYi4v8pX2PJrXmo3pu+XLSb3GUqdpX+As3tE5RyU+3x1wzq9Y8sXqxc0
	 NqgzHjYvnIu9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A29383BF4E;
	Sat, 26 Jul 2025 19:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: bpf: fix legacy netfilter options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175355701374.3670812.10207757334369224571.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 19:10:13 +0000
References: <20250726155349.1161845-1-kuba@kernel.org>
In-Reply-To: <20250726155349.1161845-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 pablo@netfilter.org, bigeasy@linutronix.de, fw@strlen.de,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 26 Jul 2025 08:53:49 -0700 you wrote:
> Recent commit to add NETFILTER_XTABLES_LEGACY missed setting
> a couple of configs to y. They are still enabled but as modules
> which appears to have upset BPF CI, e.g.:
> 
>    test_bpf_nf_ct:FAIL:iptables-legacy -t raw -A PREROUTING -j CONNMARK --set-mark 42/0 unexpected error: 768 (errno 0)
> 
> Fixes: 3c3ab65f00eb ("selftests: net: Enable legacy netfilter legacy options.")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: bpf: fix legacy netfilter options
    https://git.kernel.org/netdev/net-next/c/38b74b212a34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



