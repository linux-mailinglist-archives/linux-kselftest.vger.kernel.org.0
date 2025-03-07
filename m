Return-Path: <linux-kselftest+bounces-28446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B526A55C39
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 01:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042043AF167
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 00:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEA81494C9;
	Fri,  7 Mar 2025 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLP9O3qu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB81E868;
	Fri,  7 Mar 2025 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308609; cv=none; b=CpC1tMy/p2SLv9F4/wU882QMxzcXd7yBM7qXtWp146Al7kvf1aN2WVaT8DcxG/IdULKg7Pqtsxl9Ov+/53gLVyPHMJZC1ZO4wHxAKnol6avWLh7uKzLOAUSCqQGykgaiYLLk3aqfFhmhvIaA4Iy05FZv5JnGVW4Z3PlFlO0YGQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308609; c=relaxed/simple;
	bh=kOI8CLC+3Qf3DKglnyV5Y+WclIFVl7WyF7cg0ZSJCoM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PeOfy9Rk1EKYli1QLkrUfZRo+34rVtKZdBJzK98REqUT6paDxEru4T9/Zp9LPIebd3YjcJGvveeiDHo0lCsIvoiqOk+fIru4A78gOyzdiBQ4m5PN+Lf7nB/zGrMtowWn6nnVuta8QuAv+V9eNpFDqTtmZmcnxnO0BPkia552PVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLP9O3qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9335C4CEE8;
	Fri,  7 Mar 2025 00:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741308608;
	bh=kOI8CLC+3Qf3DKglnyV5Y+WclIFVl7WyF7cg0ZSJCoM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pLP9O3qu7AYmIBZflFZ2syG/M3jrMhSJH2jE8UATLYIRLV3dXOQr7uN0C+73/mGPH
	 YRklZgyZOtBJd9lja6AvoNtp8ZlvvYS5LxUbKQfG3oRhyCZFS4lcWs8jqboejZsOR4
	 bbb5XPfS+kP4kh9csN7BV9d2BKMW4L3IfoBOEprryql+NeVqhz++jkp/oJPO/hy9ME
	 5TfxZxXhHQoOf2VivBe8pJf43fpT3f+gfhXT81Egyf/pkSW/SFT+xMe3mpJ8fWFZQo
	 1bqf2HVhyAGsGc6HvLYC71wd0wdCavJaFRbUIYvL58uP00lH+oJ1SSb5BlC96fUAno
	 6YNqTDxsZbpaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E43380CFF6;
	Fri,  7 Mar 2025 00:50:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] selftests: net: fix error message in bpf_offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174130864207.1835493.4219904966399913707.git-patchwork-notify@kernel.org>
Date: Fri, 07 Mar 2025 00:50:42 +0000
References: <20250304233204.1139251-1-kuba@kernel.org>
In-Reply-To: <20250304233204.1139251-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Mar 2025 15:32:03 -0800 you wrote:
> We hit a following exception on timeout, nmaps is never set:
> 
>     Test bpftool bound info reporting (own ns)...
>     Traceback (most recent call last):
>       File "/home/virtme/testing-1/tools/testing/selftests/net/./bpf_offload.py", line 1128, in <module>
>         check_dev_info(False, "")
>       File "/home/virtme/testing-1/tools/testing/selftests/net/./bpf_offload.py", line 583, in check_dev_info
>         maps = bpftool_map_list_wait(expected=2, ns=ns)
>       File "/home/virtme/testing-1/tools/testing/selftests/net/./bpf_offload.py", line 215, in bpftool_map_list_wait
>         raise Exception("Time out waiting for map counts to stabilize want %d, have %d" % (expected, nmaps))
>     NameError: name 'nmaps' is not defined
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftests: net: fix error message in bpf_offload
    https://git.kernel.org/netdev/net-next/c/f9d2f5ddd47c
  - [net-next,2/2] selftests: net: bpf_offload: add 'libbpf_global' to ignored maps
    https://git.kernel.org/netdev/net-next/c/56a586961bf8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



