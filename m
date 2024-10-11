Return-Path: <linux-kselftest+bounces-19491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763789998C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 03:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA1ACB22998
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 01:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5DA79E1;
	Fri, 11 Oct 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDSUzqZ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B6171AF;
	Fri, 11 Oct 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609027; cv=none; b=gnnHeJY1hkiF1YrkHaPdJWkRXdTlKLHmT0+UE+mHpyk9uM0JKnAIp2uk1dfxRVWWxvGIceZnZW6d+EYSSGDuXzTBTRSGB38cVC7u3HxHdWBy11MJWY5x0TZoKjnniG6DTF56YVnFdMVxyz33x799l0MiD2iLAeKYSEJZZY0q0WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609027; c=relaxed/simple;
	bh=ZI0A23ZM4MhhmeNAUdsZcQyjDinp01EptqoAMLrZoKw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eofvvmp1Rw5WW3Keb5WWGCVElL9ZfZWObG21KkMOWxTWHcm9HuDpwaJd29ECF0WZAVQ9B+uHgKx9tQaBiL0716qxYfOOcjplL+Pa59RUwGW0tvZJErZI4UYGOalBRiYi9dXB9nw+SKoFQhovfnbYkin6E5jAhkb062pGJdvadOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDSUzqZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1493CC4CEC6;
	Fri, 11 Oct 2024 01:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728609027;
	bh=ZI0A23ZM4MhhmeNAUdsZcQyjDinp01EptqoAMLrZoKw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sDSUzqZ79wL8hBXENQXAdTOA3E7PwihcVOAKKt2oFMEiQuERZkkAcf2rHkHBqbR75
	 UOAyxsNqIZDJ7eZ09imYbd4YKvK9aonWKV5BQYCMc7LlNznBbIA8v1P6mCtLAM4tpb
	 p/paLp4L54XBGO2vOpfFvlYwsdvqze4OWIuS8pjI8VR97Qbx6PzH6UH890FP8gYzqU
	 HlNAFalqRDutsnYD/mbfIXOZzy33ESkYk8wRZd10Ic6UTGEYGAcph1quIucGS8YxI3
	 eS97bTpBC4/+17fWFyD19H79Nk3QiRjfPrOKsWgePrmv6DsZH74k9CJJBBUxwyRCgO
	 g4CHDLCUlSPrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE25E3803263;
	Fri, 11 Oct 2024 01:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] selftests/bpf: add coverage for
 xdp_features in test_progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172860903151.2229933.3365379244670572288.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 01:10:31 +0000
References: <20241009-convert_xdp_tests-v3-0-51cea913710c@bootlin.com>
In-Reply-To: <20241009-convert_xdp_tests-v3-0-51cea913710c@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 ebpf@linuxfoundation.org, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 09 Oct 2024 12:12:06 +0200 you wrote:
> Hello,
> this small series aims to increase coverage of xdp features in
> test_progs. The initial versions proposed to rework test_xdp_features.sh
> to make it fit in test_progs, but some discussions in v1 and v2 showed
> that the script is still needed as a standalone tool. So this new
> revision lets test_xdp_features.sh as-is, and rather adds missing
> coverage in existing test (cpu map). The new revision is now also a
> follow-up to the update performed by Florian Kauer in [1] for devmap
> programs testing.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] selftests/bpf: fix bpf_map_redirect call for cpu map test
    https://git.kernel.org/bpf/bpf-next/c/ac8d16b2d377
  - [bpf-next,v3,2/3] selftests/bpf: make xdp_cpumap_attach keep redirect prog attached
    https://git.kernel.org/bpf/bpf-next/c/d5fbcf46ee82
  - [bpf-next,v3,3/3] selftests/bpf: check program redirect in xdp_cpumap_attach
    https://git.kernel.org/bpf/bpf-next/c/d124d984c8a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



