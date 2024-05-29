Return-Path: <linux-kselftest+bounces-10819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8A98D2C4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 07:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B043F1F247B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 05:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FAD15B569;
	Wed, 29 May 2024 05:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGrFFhng"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CAD13A412;
	Wed, 29 May 2024 05:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960032; cv=none; b=pNW/E0ZYSW1SUH8oLcp7Vv5UH3NDP9KKybWMAq0AhB9rTMnou9pK+UyAjLxDil7fEIRzJQztf74jHBIxElxGgluG4gnELz4rpoJssOO4hh8Z5eKu3Sw1XFHna2pIdhD0sN1jSdIPXDPc5CpZ0rMCF4HJIcoCl/ZCu8ovxt+lB2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960032; c=relaxed/simple;
	bh=vieGJHlfQpZiyq2y1y1K0BQbJnk/71/FgjcNHfym+Ew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cjt6o8vWnc9Qpeco3uPnuvQnBP9xLsVTErzPAXfb0/7nC0uOgQJ3zG5dKjPWrvisdkOrQcHNSg5jK06Il4atGoS3VarmgFQszwFdo/umeNe3CfuLxtDPWChcHjRHx/EG7WOZicp6aYXZvlC/ytLSPwZjmYqnyZfdDsIsTst/4Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGrFFhng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1EABC32782;
	Wed, 29 May 2024 05:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716960031;
	bh=vieGJHlfQpZiyq2y1y1K0BQbJnk/71/FgjcNHfym+Ew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qGrFFhngD1fvZY8NCCHOR/okCwU1mqG3I+iko1qDRHTNDlIFG6vqhDgTdlET8xPWY
	 p1Oh+UTcwvCbpewb7cK2zVsgXAvcyvHTD7AzYDpsy6R9++tWwMBrj3DEAC4z/VGnJA
	 kPFErRRrmRk57wVl9JDlJ2BUtrQ00SobvG6ttqnRstvLCbYCjwTUvCV9WDP2sZDpHt
	 k+RQ0TlsfYnfQ8HUWEXaHgQ6o78HHvSi8yLbjjquosAsuhFtwKOPbZh6FtUCIqp0S5
	 Y/ZabAGTM258chKurqTFifSbAA76O51zfPs2vaRfOTQ+EPZMwAIiij0WD944VOnPmY
	 6F3/rNMFcZ2wA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0D0BCF21FB;
	Wed, 29 May 2024 05:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/7] use network helpers, part 5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171696003165.24832.1440705271958853407.git-patchwork-notify@kernel.org>
Date: Wed, 29 May 2024 05:20:31 +0000
References: <cover.1716638248.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1716638248.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 tanggeliang@kylinos.cn, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sat, 25 May 2024 20:08:14 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patchset uses post_socket_cb and post_connect_cb callbacks of struct
> network_helper_opts to refactor do_test() in bpf_tcp_ca.c to move dctcp
> test dedicated code out of do_test() into test_dctcp().
> 
> v5:
>  - address Martin's comments in v4 (thanks)
>  - add patch 4, use start_server_str in test_dctcp_fallback too
>  - ASSERT_* is already used in settcpca, use this helper in cc_cb (patch 3)
>  and stg_post_socket_cb (patch 6)
>  - add ASSERT_* in stg_post_socket_cb in patch 6
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/7] selftests/bpf: Drop struct post_socket_opts
    https://git.kernel.org/bpf/bpf-next/c/ed31adf6874d
  - [bpf-next,v5,2/7] selftests/bpf: Add start_server_str helper
    https://git.kernel.org/bpf/bpf-next/c/6f802cb8988e
  - [bpf-next,v5,3/7] selftests/bpf: Use post_socket_cb in connect_to_fd_opts
    https://git.kernel.org/bpf/bpf-next/c/e078255abd53
  - [bpf-next,v5,4/7] selftests/bpf: Use post_socket_cb in start_server_str
    https://git.kernel.org/bpf/bpf-next/c/79b330c57deb
  - [bpf-next,v5,5/7] selftests/bpf: Use start_server_str in do_test in bpf_tcp_ca
    https://git.kernel.org/bpf/bpf-next/c/ed61271af523
  - [bpf-next,v5,6/7] selftests/bpf: Use connect_to_fd_opts in do_test in bpf_tcp_ca
    (no matching commit)
  - [bpf-next,v5,7/7] selftests/bpf: Add post_connect_cb callback
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



