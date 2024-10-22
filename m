Return-Path: <linux-kselftest+bounces-20424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163A79AB819
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 23:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5242845BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 21:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2251168488;
	Tue, 22 Oct 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCznACh0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451E153BE4;
	Tue, 22 Oct 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630827; cv=none; b=uX2urI5S1rEzS51F6wM9CXiS83jwvESy/i7dCXgzEYqo2ga4+xoVNUvQHGFqVmqPBe7Wj+HxnhwmJ5H4CfEeyAOlcMzDcB63gt2KLPjsN0tXp5GEebMT6T06cMQQgq7u2EtRNWO4RZ9Z2+37msX4KlcAEhZaeFCpqkJOWiCchyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630827; c=relaxed/simple;
	bh=fDzi9RGYOc5tqLfWbWTT7Yeano54TtYCbp4ZazQeiIE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jxYuk+h42+dQCTxkOX5uMeG0thYq/m2pHRFjJtD+gLCIrQyfgiZz7zvvrQfTBVMrJxWF6q6TR7L6aDeFSq+2x8DYkvLSAC/8qvJU32VAQjV/rzJFLOuTS7iE25Z8Rqk3AEM64FIuz+ur3VHrdzQxnNvKzBwR+gYZ/L+Vdf9A17o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCznACh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F86C4CEE8;
	Tue, 22 Oct 2024 21:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729630827;
	bh=fDzi9RGYOc5tqLfWbWTT7Yeano54TtYCbp4ZazQeiIE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hCznACh0OW5ztxW0Qauq/eFSpwV3rxLbVj1qRojTovmd/ab0HQGP2vEZkPrGMFFS/
	 70zU7XQ7m37JcG51zebouiuLqlWteD22oRBgru2rhIhUQAxK8ksYdg6ecDJHXVzObl
	 T54pDkErMFG8GGd1YJJVP7CDKFyteHuV9Vej18qwp44j0RIRVBTfbY2dG7rqe3i1BM
	 KaBeRGRKFMQEiYlSpzJuYfdfKwfZOnj5AzYxAI0OG0Sskmh7GD/qWlNUzHJhtCjKgH
	 0o3fNU4x863boIOTIjogAsP34TKv7D1DKVQu3/TkkqFfFiXAdgwdG6UBUK7/q3Bcno
	 C+F1fE9YMhS/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E1E3822D23;
	Tue, 22 Oct 2024 21:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] Retire test_sock.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172963083325.1081314.9099871949571085521.git-patchwork-notify@kernel.org>
Date: Tue, 22 Oct 2024 21:00:33 +0000
References: <20241022152913.574836-1-jrife@google.com>
In-Reply-To: <20241022152913.574836-1-jrife@google.com>
To: Jordan Rife <jrife@google.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, danieltimlee@gmail.com, john.fastabend@gmail.com,
 sdf@fomichev.me, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 22 Oct 2024 15:29:00 +0000 you wrote:
> This patch series migrates test cases out of test_sock.c to
> prog_tests-style tests. It moves all BPF_CGROUP_INET4_POST_BIND and
> BPF_CGROUP_INET6_POST_BIND test cases into a new prog_test,
> sock_post_bind.c, while reimplementing all LOAD_REJECT test cases as
> verifier tests in progs/verifier_sock.c. Finally, it moves remaining
> BPF_CGROUP_INET_SOCK_CREATE test coverage into prog_tests/sock_create.c
> before retiring test_sock.c completely.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] selftests/bpf: Migrate *_POST_BIND test cases to prog_tests
    https://git.kernel.org/bpf/bpf-next/c/94682d6ad969
  - [bpf-next,v2,2/4] selftests/bpf: Migrate LOAD_REJECT test cases to prog_tests
    https://git.kernel.org/bpf/bpf-next/c/c17f9734e35b
  - [bpf-next,v2,3/4] selftests/bpf: Migrate BPF_CGROUP_INET_SOCK_CREATE test cases to prog_tests
    https://git.kernel.org/bpf/bpf-next/c/af522f13e917
  - [bpf-next,v2,4/4] selftests/bpf: Retire test_sock.c
    https://git.kernel.org/bpf/bpf-next/c/eea6c14c10ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



