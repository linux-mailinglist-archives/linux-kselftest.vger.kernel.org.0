Return-Path: <linux-kselftest+bounces-35632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABC6AE4B4C
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 18:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFBD189E4F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E09D26D4FC;
	Mon, 23 Jun 2025 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6t3/gDL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DAF2566;
	Mon, 23 Jun 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696780; cv=none; b=FzWgCaajgnin0VWUIJ97mZqzyEB8SQAzupNB82N6sECICZlBwAcswqWBlmCO+TqxnyMfEJpr5z2sIjtvn9IN4NetyRZyz3xoryPEgHY/5CQuAb1gBZXAgWV7fFSEkiWQRaZBazhcoEm0RQtLVU7H3DgdyStIFzuNCUwLx4JLKB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696780; c=relaxed/simple;
	bh=dezCiGqU5e28sywJ5KEaFI5ZLmyLKkXZkSwVklp0HN0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IcMgNW3ZUQ2HAWPxWMTz1eTa5T4hqlvcDxs9PATLdv7K69l38s6eJo/RzykTa0UaLP3/WGULqBsVDE4WzyDixE83EfGE53bP4t8ajPAFGhC9/9D/rKBvxgwXyTRUMWH3Yyqag7XdzmSebtbKJOYF5bvknqpABOmxMISgwVTFSeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6t3/gDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637E3C4CEED;
	Mon, 23 Jun 2025 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750696779;
	bh=dezCiGqU5e28sywJ5KEaFI5ZLmyLKkXZkSwVklp0HN0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L6t3/gDLxFc4hRb60+WeoSgQi84l9+DwQYQYTknZUQRqSmADFtvSfOxlWmAhFwTae
	 XJHF95vmMPa7oP8/nnCU5QBwI8qT5dOQvfjOzD+O787IPFoF5dSMUun8E5qEd3qfgY
	 y5KPw5AZSoEEq/yMCUU6sUwVyEKkR5yuj3IHxjjPX4gPyPIXjLXKY8Tx3+VRRz6xU3
	 RqfzsU9ZADNi5YcolEDA5jFK/JGFJW0tvCmVuLFAbxYnN9kre0KH9OWcElI9pd196T
	 Qmn27UiB+xZ0Xg9xcTZ0qPd6cekJbtX/XLi+PG83awJLI04MPrPLr1q07KKzKtxZtk
	 rrBt8kxiU3NMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE05C38111DD;
	Mon, 23 Jun 2025 16:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Support ppc64el in vmtest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175069680651.3229526.12855856215912953909.git-patchwork-notify@kernel.org>
Date: Mon, 23 Jun 2025 16:40:06 +0000
References: <20250619140854.2135283-1-luis.gerhorst@fau.de>
In-Reply-To: <20250619140854.2135283-1-luis.gerhorst@fau.de>
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, hbathini@linux.ibm.com,
 christophe.leroy@csgroup.eu, naveen@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 19 Jun 2025 16:08:53 +0200 you wrote:
> With a rootfs built using libbpf's BPF CI [1], we can run specific tests
> as follows:
> 
> $ ../libbpf-ci/rootfs/mkrootfs_debian.sh --arch ppc64el --distro noble
> $ PLATFORM=ppc64el CROSS_COMPILE=powerpc64le-linux-gnu- \
>     tools/testing/selftests/bpf/vmtest.sh \
>     -l libbpf-vmtest-rootfs-*-noble-ppc64el.tar.zst \
>     -- ./test_progs -t verifier_array_access
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Support ppc64el in vmtest
    https://git.kernel.org/bpf/bpf-next/c/3ce7cdde66e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



