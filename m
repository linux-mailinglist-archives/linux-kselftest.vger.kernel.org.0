Return-Path: <linux-kselftest+bounces-19552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B4299A958
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 19:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FD41C21FED
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059B01BD00A;
	Fri, 11 Oct 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NF45aIGe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925D81AD7;
	Fri, 11 Oct 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666027; cv=none; b=Udb/RiLo2DwL+C9i29mas/FXda+VWZVbM4Co48M7JB4MHG7FPs+3O8DTK69wyt+psddF4y+9/2GwHSwvKZevyqE5Gb3v4VMkD6LvUVv/rTbtk/PDsYwuWmVFggTHZfJGSQZ/1OEMRthSeNG10mIdMO0rL70mflVmDkUnlEWmzP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666027; c=relaxed/simple;
	bh=3PrcDyvK+Un7G7EbXkk1aEcgGFJg7JMH2EyFA1Zd40s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=asN/Ae2Ae0iRJzeBe+9mKzP5j5GdGOp8JablpFj/vvJW5IdqB5vEyVKXPcLNFEEEF0Kr5K8TelCkyuoQmEtx5rWBBKlUQBUSyDC9vzxv+6IJJeO74I82DR/DRfyQmRyJfNwdk1iQ2Fs9xj1GxVu7pEUUIjO/3bhIRCdJXiQ/hmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NF45aIGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F37C4CEC3;
	Fri, 11 Oct 2024 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728666027;
	bh=3PrcDyvK+Un7G7EbXkk1aEcgGFJg7JMH2EyFA1Zd40s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NF45aIGeUE3dN1DOwQdV4gwCURIqUz3HB0h9HKnzllIrTio0IJbMvxugq/gT6tZ47
	 HFvA6ed4DKTDE0qjR3gsye1SsKdhf/4S3MJf928YysCIk6rHcRop0BFr1ei5HHxSm4
	 uDCm05MWCiDQUuP4nkF4ZlQRuR5RoBVU6kuAEKSlfnVZu/mB9vKwGVoTYCxDmS8Ihg
	 GPoS+E/JWYI91RgLYP3CG/pNIm678Q7ZgeprtNaQy3YD+r64x6JGPqwIcE0c7cSTM0
	 n2F2rmUDqze23q2ZugE/YtSERsX39PCatAwYKv2dHL5/9w2eQX1CISPyZJBqJWMDVQ
	 RtJgQn/fBLGbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E32380DBC0;
	Fri, 11 Oct 2024 17:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH,bpf-next v3 0/4] selftests/bpf: migrate and remove
 cgroup/tracing related tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172866603225.2881487.4648695674968561173.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 17:00:32 +0000
References: <20241011044847.51584-1-danieltimlee@gmail.com>
In-Reply-To: <20241011044847.51584-1-danieltimlee@gmail.com>
To: Daniel T. Lee <danieltimlee@gmail.com>
Cc: daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 11 Oct 2024 04:48:43 +0000 you wrote:
> The BPF testing framework has evolved significantly over time. However,
> some legacy tests in the samples/bpf directory have not kept up with
> these changes. These outdated tests can cause confusion and increase
> maintenance efforts.
> 
> This patchset focuses on migrating outdated cgroup and tracing-related
> tests from samples/bpf to selftests/bpf, ensuring the BPF test suite
> remains current and efficient. Tests that are already covered by
> selftests/bpf are removed, while those not yet covered are migrated.
> This includes cgroup sock create tests for setting socket attributes
> and blocking socket creation, as well as the removal of redundant
> cgroup and tracing tests that have been replaced by newer tests.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] selftests/bpf: migrate cgroup sock create test for setting iface/mark/prio
    https://git.kernel.org/bpf/bpf-next/c/ec6c4be07323
  - [bpf-next,v3,2/4] selftests/bpf: migrate cgroup sock create test for prohibiting sockets
    https://git.kernel.org/bpf/bpf-next/c/64a4658d6f76
  - [bpf-next,v3,3/4] samples/bpf: remove obsolete cgroup related tests
    https://git.kernel.org/bpf/bpf-next/c/5ea68f0493d1
  - [bpf-next,v3,4/4] samples/bpf: remove obsolete tracing related tests
    https://git.kernel.org/bpf/bpf-next/c/118740b87015

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



