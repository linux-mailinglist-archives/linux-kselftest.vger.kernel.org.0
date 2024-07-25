Return-Path: <linux-kselftest+bounces-14230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6420893C1CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 14:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C351C21E78
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 12:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F3819AA4E;
	Thu, 25 Jul 2024 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLRgXOtI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263FE19A2BE;
	Thu, 25 Jul 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910032; cv=none; b=trYVbUv7qSzkOyYVqme/z56dxWmkYhYU/bMvozSpYQl3idjbwjhJHOMNfUaQcB4KP6ZxmNO81HgdnCHyM/f7DGOHSx5TCZSHYYmcaOmYVhhHPIDCEHLTD/SVnzeI6MnPnViLEbjaYIvWPYsbeDuwz18E1cEEQBDj3C1zRRbBMa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910032; c=relaxed/simple;
	bh=DRX7Kwd+cvQXT4FVV15ImnwpeEa2tQ6zJz5/kGZD7V0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eI/8JTujNsKvUemktcUyysmBnwHgljSaFzJq3k+fy0IqS9tXB7AgoxxgHVxiLSUOdxjOoAtzXJBqT+FlCcLwi/FVdlA+IlBSjnRyUEcOtlt39HXl57Q6USdbtJUx9CpAZHQdmUk+Z1hvDxCPTLzJyQbvfot3/mjcDZeZo8wr7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLRgXOtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5D8AC4AF0B;
	Thu, 25 Jul 2024 12:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721910031;
	bh=DRX7Kwd+cvQXT4FVV15ImnwpeEa2tQ6zJz5/kGZD7V0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TLRgXOtIhJXJwz6sd/78Z1rQmCpciQl478R9PGWPbp785acXaEZHN1BI274+WZIHd
	 QUMVF/oj9jDv7QAtH3CkSFkIWXEoLpuXWziR4SPrdeZdl2mHHGmsSgya32Hq5Kdz/V
	 BLRkH/GfD1FF6erErtqVr5r7ucFHG/NrvIPSShhM4QcyQd+YU5Bnpe9EzcEOA9nuG0
	 CfCQOELh+RiHeVW/Fpj+51S98BD5mxo8yw8OXxsB7DeS23vxzbpg4z8yKUznfsB4c4
	 Q0yngGC7dvjsXGoL7XpPP8sygPXUyQhFQRXL59dPnhLXyikXBbJj+FiQHC4XXPqMZ3
	 jRIttnY4z5VGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E12CC4332D;
	Thu, 25 Jul 2024 12:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] selftests/bpf: convert test_xdp_veth to test_progs
 framework
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172191003164.2907.17086053402517059544.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 12:20:31 +0000
References: <20240721-convert_test_xdp_veth-v4-0-23bdba21b2f9@bootlin.com>
In-Reply-To: <20240721-convert_test_xdp_veth-v4-0-23bdba21b2f9@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 horms@kernel.org, ebpf@linuxfoundation.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 21 Jul 2024 21:33:02 +0200 you wrote:
> Hello everyone,
> 
> this small series is a first step in a larger effort aiming to help improve
> eBPF selftests and the testing coverage in CI. It focuses for now on
> test_xdp_veth.sh, a small test which is not integrated yet in test_progs.
> The series is mostly about a rewrite of test_xdp_veth.sh to make it able to
> run under test_progs, relying on libbpf to manipulate bpf programs involved
> in the test.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] selftests/bpf: update xdp_redirect_map prog sections for libbpf
    https://git.kernel.org/bpf/bpf-next/c/e33e15b62d44
  - [v4,2/2] selftests/bpf: integrate test_xdp_veth into test_progs
    https://git.kernel.org/bpf/bpf-next/c/6189fa6faa09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



