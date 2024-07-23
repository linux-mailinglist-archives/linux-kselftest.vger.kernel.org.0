Return-Path: <linux-kselftest+bounces-14099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C77E93A810
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47ADA1F22BDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 20:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652BA14387B;
	Tue, 23 Jul 2024 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyK2bd1D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A9113F01A;
	Tue, 23 Jul 2024 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721766636; cv=none; b=ouVuvu8jPJ0pEC/kHVETzwi+iH3VVGTccYktGQMm7VB7mHzuEcIjV6hiz6kXhNHATMZNWnAlxT/+0NH3YZONYnWluxpMiHb2y39Irvn3pvvkQ83j/vm3BrlVzI6iFQjcnzyeyLWBLa65tkK01N1A8IxbbRxP0fkpp2DNVauVWz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721766636; c=relaxed/simple;
	bh=ZGGHTSnF06IJ//J8AC6dFzbaUgf+xGPQrDv1rpW8QyE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B3xJScy4MQScts9890gf0HeMKI3lFOBRj2oGbfCiiCYNU2E7TUjFK332MBRRAUhKmiV77eHQAyBYXwDZBKVqyE6g8Bydw7JKMkZHbIoGmWwvEeIw8rViTtFHjD+ojjcrjKlPzz6NlusqOLFhtRSHuhgLcEMfjMn+RsY7c4puDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyK2bd1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF696C4AF13;
	Tue, 23 Jul 2024 20:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721766635;
	bh=ZGGHTSnF06IJ//J8AC6dFzbaUgf+xGPQrDv1rpW8QyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pyK2bd1D6B1zu1oMf1TrsuFKIGgtSo9CzqCkr4oXMKexiIEDHUK0BMh7tbJHawftg
	 6Y9p/vJQZtCBRa71b+9c9Hl074lMILOrg6CdQ4cnXGO2yvYuGLyH/8dIemSKVWHJXb
	 5D3bD/yOF0f/SOG2qNYpZRtPA72f2SqTk5B/ol94RbT6zuhhY8RyyYnbJ+4eSW5AJm
	 tvisI2xUG0bkSYfHfTgyEAUGu2F+fessApoyrdJTQ0rqTnRWI3u2/2jXXW3FWVpM5h
	 vKxKbw+XVN7BibaGVBkaBIO7zD8bmRYhxfwFv9j1kiPF9DQMWoj6RHrxNbDuMtQOcO
	 R2gVM4rEvqc9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADA86C43638;
	Tue, 23 Jul 2024 20:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix wrong binary in Makefile log
 output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172176663569.27466.11065049509700723720.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 20:30:35 +0000
References: <20240720052535.2185967-1-tony.ambardar@gmail.com>
In-Reply-To: <20240720052535.2185967-1-tony.ambardar@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 19 Jul 2024 22:25:35 -0700 you wrote:
> Make log output incorrectly shows 'test_maps' as the binary name for every
> 'CLNG-BPF' build step, apparently picking up the last value defined for the
> $(TRUNNER_BINARY) variable. Update the 'CLANG_BPF_BUILD_RULE' variants to
> fix this confusing output.
> 
> Current output:
>   CLNG-BPF [test_maps] access_map_in_map.bpf.o
>   GEN-SKEL [test_progs] access_map_in_map.skel.h
>   ...
>   CLNG-BPF [test_maps] access_map_in_map.bpf.o
>   GEN-SKEL [test_progs-no_alu32] access_map_in_map.skel.h
>   ...
>   CLNG-BPF [test_maps] access_map_in_map.bpf.o
>   GEN-SKEL [test_progs-cpuv4] access_map_in_map.skel.h
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Fix wrong binary in Makefile log output
    https://git.kernel.org/bpf/bpf-next/c/efb1d64030ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



