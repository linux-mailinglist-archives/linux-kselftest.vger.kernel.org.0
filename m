Return-Path: <linux-kselftest+bounces-44681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCDBC2E2B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 22:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434853BC2A3
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 21:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D1E2D0606;
	Mon,  3 Nov 2025 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3Q1FgzP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6501917FB;
	Mon,  3 Nov 2025 21:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762205648; cv=none; b=gtxfM6w3GZfg9qw7zVBsdxDuwJL8TKYMc+5Qsn3ygqJRyd+fIV6yadB/w1txYp53J+1YCuRra/cRI/wVFd/H2Va+mbHxWbdGzFd+N6p78rGiFvIu+KVPqBBTHPdJ9Rtuc+J0WZClRNw7kw44iIlJ8CeGNh+LaM9c8tk+YvwR/xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762205648; c=relaxed/simple;
	bh=aBD983yiNNOnZiq3ASuKn2fSq6CQ0BIh2bd/3QuiWcE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=daf1H23WQeiw7dehBn0r5DxizKGm+WgGMDB1wYZ9HIPTM0X0srecBgsW10nPF3ylu5vpoLTRFRewjOImuh2BRIdhgRil1I7yc3t8YW4IlSlJ0FM4lxd7R6kCtH1ny5LCF/FJ7+m/X0wch1nq6MSj2ndA5pcwh2rRdZw1euqJWKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3Q1FgzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9888AC4CEF8;
	Mon,  3 Nov 2025 21:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762205647;
	bh=aBD983yiNNOnZiq3ASuKn2fSq6CQ0BIh2bd/3QuiWcE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y3Q1FgzPOTVfd50rVOXrHakdGLuazE7JhNzm3isFapNIr7TkSMRD9DlxX0m/JbJIW
	 ilEAv4D9o2zDD4MVFr3Z/8i6JQeLkcn1SnUQrkVoci+ZoX4N5sU3yQAijLa64QOnC2
	 XobW0xsbuzFG0BKPpM48+h3AdPioFG6Fg4aKk377czJhR8GmmiAxTCSoddek+gMdYW
	 PGtLBSUsSdtgMDtsBIBANJIZ1xKaD/AoFmqZ2Ha2RYaDWb/hZ4IC/0V+uWX5YkPQJi
	 3MPfMkbpixcUkpMimNRrh7Jyue3y8VVqaMapulgprtH2491fAD8yReIrayoLPdSI9H
	 h1RXjuMn6nn3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340893809A88;
	Mon,  3 Nov 2025 21:33:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] selftests/bpf: small improvements on
 tc_tunnel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176220562173.2193320.5516695846612752403.git-patchwork-notify@kernel.org>
Date: Mon, 03 Nov 2025 21:33:41 +0000
References: <20251031-tc_tunnel_improv-v1-0-0ffe44d27eda@bootlin.com>
In-Reply-To: <20251031-tc_tunnel_improv-v1-0-0ffe44d27eda@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ebpf@linuxfoundation.org, thomas.petazzoni@bootlin.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bastien.curutchet@bootlin.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 31 Oct 2025 10:01:40 +0100 you wrote:
> Hello,
> this series is a small follow-up to the test_tc_tunnel recent
> integration, to address some small missing details raised during the
> final review ([1]). This is mostly about adding some missing checks on
> net namespaces management.
> 
> [1] https://lore.kernel.org/bpf/1ac9d14e-4250-480c-b863-410be78ac6c6@linux.dev/
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: skip tc_tunnel subtest if its setup fails
    https://git.kernel.org/bpf/bpf-next/c/c076fd5bb4d7
  - [bpf-next,2/3] selftests/bpf: add checks in tc_tunnel when entering net namespaces
    https://git.kernel.org/bpf/bpf-next/c/e6e10c51fb17
  - [bpf-next,3/3] selftests/bpf: use start_server_str rather than start_reuseport_server in tc_tunnel
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



