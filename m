Return-Path: <linux-kselftest+bounces-33884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A82BAC5463
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 19:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BB71BA4C59
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 17:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE31828001F;
	Tue, 27 May 2025 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSArvkHK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CEC27FD61;
	Tue, 27 May 2025 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365202; cv=none; b=irB3h+fcmtqwePzkTIK2Vq7iqLXtkO96kbWOsGmCV+MC48UZdvEbhdH+DyGIMUx3fGYaNyp4PTTbPP7QMpWlWsqMXhHkK5EqLw1FIt7tdWIzbBT9BjMpEjIfxIOiiqj5bWw/RW3qUcj4S66c7wyfOnKVFFHTnmfQBQ6JqMpxUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365202; c=relaxed/simple;
	bh=YZ2oMVULHYa93hhilrUAyynPEjoYTyfzy2z4lPIc7Tg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jn9Vl5qHNn1+1TqkPsiTIvoKKA917To7pQfvb3lWuVOCL0NqUGGxDjcijxlK2aPrvSbNndoaHnqSEj4PjxhnEOrgDaYZocwRL2NwABuuyEgmt8Yqb+rLo/647iH1XFERRbSf1KyznRx+7m2eykG0rWJg5RBnyUSX4gF5ZEwbp5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSArvkHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F63BC4CEEB;
	Tue, 27 May 2025 17:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748365202;
	bh=YZ2oMVULHYa93hhilrUAyynPEjoYTyfzy2z4lPIc7Tg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iSArvkHKnbdfsIqUw+stBXLTL/Ke5U83Hr/h23PCKH2twhwaBkubimAvx+taEjhT+
	 17GlrF1mNeJ2qOU1eeQFgusqyTP1WRXOw7wtddnqrTKjnZLZXhJ4GxmKoP6fqH3adF
	 0z2L9LzHN+9Vy5fTKrqM/7c9uzziOcOKJ0MDEdzdO1qPK+X3ASzCKvacfPGOisD9+F
	 WKAGBUN79iYYo5BVjEit65FIDLp3Sp67mhiw4T5Bvx6D2IFu+Tqb3fSiLcz5O4kK1n
	 /YBV1WAXRqBb0V/YcRRV6HLwvAO05G2KHwpnU0EdoV5jkVxUdL9tc1RSwrXhIv1HM4
	 U6NdPKaAX22tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7228D380AAE2;
	Tue, 27 May 2025 17:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/5] Replace CONFIG_DMABUF_SYSFS_STATS with BPF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174836523626.1711047.17059127767778339738.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 17:00:36 +0000
References: <20250522230429.941193-1-tjmercier@google.com>
In-Reply-To: <20250522230429.941193-1-tjmercier@google.com>
To: T.J. Mercier <tjmercier@google.com>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 skhan@linuxfoundation.org, alexei.starovoitov@gmail.com,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com,
 simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org, song@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 22 May 2025 23:04:24 +0000 you wrote:
> Until CONFIG_DMABUF_SYSFS_STATS was added [1] it was only possible to
> perform per-buffer accounting with debugfs which is not suitable for
> production environments. Eventually we discovered the overhead with
> per-buffer sysfs file creation/removal was significantly impacting
> allocation and free times, and exacerbated kernfs lock contention. [2]
> dma_buf_stats_setup() is responsible for 39% of single-page buffer
> creation duration, or 74% of single-page dma_buf_export() duration when
> stressing dmabuf allocations and frees.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/5] dma-buf: Rename debugfs symbols
    https://git.kernel.org/bpf/bpf-next/c/89f9dba365e1
  - [bpf-next,v7,2/5] bpf: Add dmabuf iterator
    https://git.kernel.org/bpf/bpf-next/c/76ea95534995
  - [bpf-next,v7,3/5] bpf: Add open coded dmabuf iterator
    https://git.kernel.org/bpf/bpf-next/c/6eab7ac7c5ee
  - [bpf-next,v7,4/5] selftests/bpf: Add test for dmabuf_iter
    https://git.kernel.org/bpf/bpf-next/c/ae5d2c59ecd7
  - [bpf-next,v7,5/5] selftests/bpf: Add test for open coded dmabuf_iter
    https://git.kernel.org/bpf/bpf-next/c/7594dcb71ff8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



