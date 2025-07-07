Return-Path: <linux-kselftest+bounces-36706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37578AFB797
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 17:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F89A189DED8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DE01EF389;
	Mon,  7 Jul 2025 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFz1/JjF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A301E9B31;
	Mon,  7 Jul 2025 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902789; cv=none; b=jIOZ0d3ECgCogp/dtbACd+I/UTSnv2km+PYLOXFVqYZgLfMITcVNgjFyJ+rWMZeWsoeJ/JhiUs5QlsUbpTWj63YC8krVC/79vPlA36qnrLyw53jjBnHdeOeddnUi3Zf9L4an7/zS8KXeP+1vo9VJzM0PBhcXHuKDlIB2ORW+Ljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902789; c=relaxed/simple;
	bh=REZLQrlRb8EJsN7RuVszma03pCayuWgDp1TpIzshJZs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m9teBDJ3Gng8lYfmRbFWdspZE1UNGr4Q42wohgPn3A0AVG9KkgnM2Irpx+oai4Z/tWdzXthMHhVd12EPvsWAyjfOu+AMnGn0z+EGoAt9QNFeqnYmBHpZygmLe/F4dOM3Oi3uC9gpA7/Ct58kxDOjFX69FGzus0mN1OcCHgv1kgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFz1/JjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC19C4CEE3;
	Mon,  7 Jul 2025 15:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751902788;
	bh=REZLQrlRb8EJsN7RuVszma03pCayuWgDp1TpIzshJZs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iFz1/JjFtuU3YPv0UBNQpZf3JxMuM63gaMmJGqk/jMRWuYPFSqmdit7xgynU+km7P
	 RNmFWQNYQ9TBFnObWI1misfa0sl8s26Or13jt2SOwfUExNilF97v3CS3eohLXQpqnm
	 +ZhB1463qvUt/VCT4thCgsL0qfSCOOzL1VPTsxTPpCyzd2c8CE4cexM8jbda8mft3p
	 jrBhw7ZHvtwbLLKjY6MWzQUyCRj2/xI711hSqZo7Vy5R3ecY24YubHPo8616L2QsqO
	 ak6eYfhlvGIaYmpUhNvJoewP97lSI4DWmsalkIpNrTbvfGOPENYPD3QJHQQ6r0nqBD
	 h7Wg0unJ/fKhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB008383BA25;
	Mon,  7 Jul 2025 15:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Set CONFIG_PACKET=y for selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175190281175.3336255.8398481475533442439.git-patchwork-notify@kernel.org>
Date: Mon, 07 Jul 2025 15:40:11 +0000
References: <20250707071735.705137-1-skb99@linux.ibm.com>
In-Reply-To: <20250707071735.705137-1-skb99@linux.ibm.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, hbathini@linux.ibm.com, sachinpb@linux.ibm.com,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  7 Jul 2025 12:47:35 +0530 you wrote:
> BPF selftest fails to build with below error:
> 
>   CLNG-BPF [test_progs] lsm_cgroup.bpf.o
> progs/lsm_cgroup.c:105:21: error: variable has incomplete type 'struct sockaddr_ll'
>   105 |         struct sockaddr_ll sa = {};
>       |                            ^
> progs/lsm_cgroup.c:105:9: note: forward declaration of 'struct sockaddr_ll'
>   105 |         struct sockaddr_ll sa = {};
>       |                ^
> 1 error generated.
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Set CONFIG_PACKET=y for selftests
    https://git.kernel.org/bpf/bpf-next/c/0f626c98fd10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



