Return-Path: <linux-kselftest+bounces-10122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D828C8C3994
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 02:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A62F1F2147A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 00:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D1280B;
	Mon, 13 May 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5jlwMkf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386FD36D;
	Mon, 13 May 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715559632; cv=none; b=Rv86QoVX+ayiRFKhB1qdjhy6xgiUcaTcpbgJ7m1aIDVIG8TTWSMXmjiqZaR4BeQsCbBmSyjGnz/6W4318U8BrZwNM6UWfoSDe3etcGdTMN6QrutKRCKYhgQfw2c3QUIdLWbFL5oK+8X+i4ZGkYUOzikyhw2P54Sxz7lR9G3HXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715559632; c=relaxed/simple;
	bh=Hq+b14LfAi+p9vzvNy3FeEV1czeiMaaQfbEyuwoO0Hc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J6tHMHZpMKmP6IFZcHZcDca4d/qfSyCLMlWJJ6+nrRL3bKtt4swDHdAjmi3ydMB5VdT0VLFZxuJ6Ar15lPpNuFrHrZVTgf4GB88xDRLGqfBZEpni3EiwC+tEidOvB/egrTbtYvWDVi+hD9Yld58v343WGwCCZTxKwSUAG8EUM5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5jlwMkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD22CC32783;
	Mon, 13 May 2024 00:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715559631;
	bh=Hq+b14LfAi+p9vzvNy3FeEV1czeiMaaQfbEyuwoO0Hc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b5jlwMkfYlxBlFxTHG5yEUCeT9HhDqwWoNGpGoN8wFNUDlt5qqy4NX9lRqIS/+NZ5
	 2fzCMbp/grX6egJYvUiSEFwVEYQYchxedLKqxNHItk+pKakau11OkmeEHi5aaARfPD
	 UW4j+JcYKjkXadI1XCH55ldhbHRXwelmdkd8lkz74Ji2Mbj0lkme1gokUYR7S08EX+
	 lhQuYKJ8jR9EdhfWjUNLL6GwANOf7UdEIEKOGp4yb0sFJcEp+kSjRU4CnVFbxBBJJS
	 C1oQYBZBMBzysYVxqSj9PKrp0ZtEvCQRB/k+2aZC4pVp26nxKoCcjDFwSB4fY3xVjZ
	 0S1DqWpFQBMMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B1E4C43336;
	Mon, 13 May 2024 00:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 bpf-next 00/17] Retire progs/test_sock_addr.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171555963163.28854.483246811366830977.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 00:20:31 +0000
References: <20240510190246.3247730-1-jrife@google.com>
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
To: Jordan Rife <jrife@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, tanggeliang@kylinos.cn, daan.j.demeyer@gmail.com,
 shung-hsi.yu@suse.com, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 10 May 2024 14:02:17 -0500 you wrote:
> This patch series migrates remaining tests from bpf/test_sock_addr.c to
> prog_tests/sock_addr.c and progs/verifier_sock_addr.c in order to fully
> retire the old-style test program and expands test coverage to test
> previously untested scenarios related to sockaddr hooks.
> 
> This is a continuation of the work started recently during the expansion
> of prog_tests/sock_addr.c.
> 
> [...]

Here is the summary with links:
  - [v1,bpf-next,01/17] selftests/bpf: Migrate recvmsg* return code tests to verifier_sock_addr.c
    https://git.kernel.org/bpf/bpf-next/c/73964e9085bb
  - [v1,bpf-next,02/17] selftests/bpf: Use program name for skel load/destroy functions
    https://git.kernel.org/bpf/bpf-next/c/86b65c6db019
  - [v1,bpf-next,03/17] selftests/bpf: Handle LOAD_REJECT test cases
    https://git.kernel.org/bpf/bpf-next/c/5eff48f33fb7
  - [v1,bpf-next,04/17] selftests/bpf: Handle ATTACH_REJECT test cases
    https://git.kernel.org/bpf/bpf-next/c/5a047b2226c0
  - [v1,bpf-next,05/17] selftests/bpf: Handle SYSCALL_EPERM and SYSCALL_ENOTSUPP test cases
    https://git.kernel.org/bpf/bpf-next/c/a2618c0d8542
  - [v1,bpf-next,06/17] selftests/bpf: Migrate WILDCARD_IP test
    https://git.kernel.org/bpf/bpf-next/c/d1b24fcf1c16
  - [v1,bpf-next,07/17] selftests/bpf: Migrate sendmsg deny test cases
    https://git.kernel.org/bpf/bpf-next/c/f46a10483b27
  - [v1,bpf-next,08/17] selftests/bpf: Migrate sendmsg6 v4 mapped address tests
    https://git.kernel.org/bpf/bpf-next/c/54462e8452f1
  - [v1,bpf-next,09/17] selftests/bpf: Migrate wildcard destination rewrite test
    https://git.kernel.org/bpf/bpf-next/c/8eaf8056a44b
  - [v1,bpf-next,10/17] selftests/bpf: Migrate expected_attach_type tests
    https://git.kernel.org/bpf/bpf-next/c/b0f3af0bffef
  - [v1,bpf-next,11/17] selftests/bpf: Migrate ATTACH_REJECT test cases
    https://git.kernel.org/bpf/bpf-next/c/cded71f595c0
  - [v1,bpf-next,12/17] selftests/bpf: Remove redundant sendmsg test cases
    https://git.kernel.org/bpf/bpf-next/c/9c3f17862fae
  - [v1,bpf-next,13/17] selftests/bpf: Retire test_sock_addr.(c|sh)
    https://git.kernel.org/bpf/bpf-next/c/61ecfdfce264
  - [v1,bpf-next,14/17] selftests/bpf: Expand sockaddr program return value tests
    https://git.kernel.org/bpf/bpf-next/c/1e0a8367c89f
  - [v1,bpf-next,15/17] sefltests/bpf: Expand sockaddr hook deny tests
    https://git.kernel.org/bpf/bpf-next/c/dfb7539b47b5
  - [v1,bpf-next,16/17] selftests/bpf: Expand getsockname and getpeername tests
    https://git.kernel.org/bpf/bpf-next/c/bc467e953e4f
  - [v1,bpf-next,17/17] selftests/bpf: Expand ATTACH_REJECT tests
    https://git.kernel.org/bpf/bpf-next/c/a3d3eb957ddc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



