Return-Path: <linux-kselftest+bounces-1998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCB1814093
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 04:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068BC283774
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C6C1C31;
	Fri, 15 Dec 2023 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIdHTHTd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A47A63B8;
	Fri, 15 Dec 2023 03:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54737C433C9;
	Fri, 15 Dec 2023 03:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702610424;
	bh=tmWdNB9hZsZGW4LzMyDRaX1WA5hh8PQ2ljdQx4iYZkg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WIdHTHTdc6va3NW41pfmybuglFuuBA5cvOHGOyRnopCk5xK718xQFFssfdvYPs8x4
	 jnW6j2KornMb68CaldEVmODfAJeVlR7Zs/Rnoqxiiva77qMsAJiR3aYDISsIrfMhor
	 Dqv+FcQQNMVFEePAHbUfpkiVLN1iAadjyeVH2VUNwoZi0yyMVQdMN4yEsFnp2uy2S8
	 Fiw4Vh6sgxpLN4KEuZ0LF93dQUcKOaDWAqzVOHVHGPAF2My1nQlWQMRLdbt+LF11mH
	 hqRUPB5lK5ic1fy/1YFrdVtatkkxi3ORQy4mkagzec7tpjJvZZRXlC7jssg5tyNxTH
	 0H2Rh4H6Fy5Dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B2A3DD4EFC;
	Fri, 15 Dec 2023 03:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] Various BPF exception improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170261042423.8096.11497491721460220225.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 03:20:24 +0000
References: <cover.1702594357.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1702594357.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 14 Dec 2023 15:56:24 -0700 you wrote:
> Two small improves to BPF exceptions in this patchset:
> 
> 1. Allow throwing exceptions in XDP progs
> 2. Add some macros to help release references before throwing exceptions
> 
> Note the macros are intended to be temporary, at least until BPF
> exception infra is able to automatically release acquired resources.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: xdp: Register generic_kfunc_set with XDP programs
    https://git.kernel.org/bpf/bpf-next/c/7489723c2e26
  - [bpf-next,2/3] bpf: selftests: Add bpf_assert_if() and bpf_assert_with_if() macros
    (no matching commit)
  - [bpf-next,3/3] bpf: selftests: Test bpf_assert_if() and bpf_assert_with_if()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



