Return-Path: <linux-kselftest+bounces-15376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391B29527D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 04:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FDD1F24BC1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29839475;
	Thu, 15 Aug 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiW4xkfF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179C10A0E;
	Thu, 15 Aug 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723687831; cv=none; b=Me2E4eBKHrxbePwcapi/qCk+cYc/rO8k+HUn3TL8k6ZGq/BggjikiVskEeleDa8TbbDd8PtDhj+8+U/ABWGyZIQXlkTyQfkPVAYj9gUOYwqWMpkk063mFizPJ/8KoD1PMoj3qnfG48gKd9Q76KzNJI/AGuv5GUhc5jLR9cdVhzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723687831; c=relaxed/simple;
	bh=aHXL2fTzKyl3l6PGvG4Oke2JLvLAbEsecLeL3moCNkY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oTrou47Llb+Y5hRc+b9kIIPKauCz7NXO5moDGAk7mlYXwTtFokcv8ckNJE2fRnZV40EkrvZtxNSMKiHEU6/RTeG/qU3JGGHCL8DUXkSe78GbNKIc1/U3+ek3pVESB07AFRV+nQt/QnCIdIaBg/Zb6E/dGbLIbDm+/EhSDKhNeto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiW4xkfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD9BC116B1;
	Thu, 15 Aug 2024 02:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723687831;
	bh=aHXL2fTzKyl3l6PGvG4Oke2JLvLAbEsecLeL3moCNkY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RiW4xkfFT18rovAoUI3kbqbTUDq7zyDHgr6MqNBpEvUXMyvdk4uYgwznIhA0+ve3K
	 axrsIFZtKWRHeUJW/16z6eI4Nz/y0TaboWlc3o6DAPS0M47JOP5jfgkm7iUQW2BAa9
	 k13BPFlNwJXoE41WkFML9u4oA5AtCBu5nHwH6VTkSdYgKp2+7gim1PH9gSBtxvNb8y
	 bU02Yi0cHXrY5DLca5a+pQrXZVTdlO3oZTY7GK8O4PtS0IjUvdml5s60tMdMYBn/Vj
	 gGxYrfsJOv137P1T/kDV3RT4j+YQmHgkKzrufJedQOGXJ3tf7wSIEikV0QutqXlXet
	 PbvB7LpqRrfOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71BBD3810934;
	Thu, 15 Aug 2024 02:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/4] selftests/bpf: convert three other cgroup
 tests to test_progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172368783029.2443920.5802925440430731324.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 02:10:30 +0000
References: <20240813-convert_cgroup_tests-v4-0-a33c03458cf6@bootlin.com>
In-Reply-To: <20240813-convert_cgroup_tests-v4-0-a33c03458cf6@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, ebpf@linuxfoundation.org, thomas.petazzoni@bootlin.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, alan.maguire@oracle.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 13 Aug 2024 14:45:04 +0200 you wrote:
> Hello,
> this series brings a new set of test converted to the test_progs framework.
> Since the tests are quite small, I chose to group three tests conversion in
> the same series, but feel free to let me know if I should keep one series
> per test. The series focuses on cgroup testing and converts the following
> tests:
> - get_cgroup_id_user
> - cgroup_storage
> - test_skb_cgroup_id_user
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/4] selftests/bpf: convert get_current_cgroup_id_user to test_progs
    https://git.kernel.org/bpf/bpf-next/c/a4ae5c31e0f2
  - [bpf-next,v4,2/4] selftests/bpf: convert test_cgroup_storage to test_progs
    https://git.kernel.org/bpf/bpf-next/c/37a14cfd667a
  - [bpf-next,v4,3/4] selftests/bpf: add proper section name to bpf prog and rename it
    https://git.kernel.org/bpf/bpf-next/c/7b4400a0a69b
  - [bpf-next,v4,4/4] selftests/bpf: convert test_skb_cgroup_id_user to test_progs
    https://git.kernel.org/bpf/bpf-next/c/f957c230e173

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



