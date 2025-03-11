Return-Path: <linux-kselftest+bounces-28708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF89A5BF51
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 12:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D85172E89
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 11:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5138D253331;
	Tue, 11 Mar 2025 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na0dopai"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE8E1EB9F2;
	Tue, 11 Mar 2025 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693200; cv=none; b=YlaKmapEzYjI/tGBhdcqF1WBeOHOca7lxZ87VQQf8zgACEugqASR3iXffi5K2zM2PumvOWC7rnAVe6YwvSX3qceNYDSKXOPnGhzq0WtdZwshrOrh02W7VNKbzlZPjz9qgpr/keO0q3Fe1oI4HtoPrHqR1nbQtdwFV1ehwXYuRPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693200; c=relaxed/simple;
	bh=Rg6zwDtHHphZQIVJITCRiSdyr/aRimHyJzha/DMh2hk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nzDdYTmtvUqLYzVEZkniWK9Kvppol48XDWdNV8KHP9fRbyojWVlml06vXHjQ/C8M7Wg/cwx4YilC7iHZADfUSJeLM0atvmzPUGKrzmdSak+PBiTi0TeBBui6gFGLDUwo0wJWYFpwYI3VXmZ/lsHsNEr7QllkbPZU64yIwg2ljys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na0dopai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E467C4CEE9;
	Tue, 11 Mar 2025 11:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741693199;
	bh=Rg6zwDtHHphZQIVJITCRiSdyr/aRimHyJzha/DMh2hk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=na0dopai5bOABwgiPMGVEmnUhmk8hNOakCY3ctWPmSD8I0Rgm3ME0hF0kjByW0Out
	 BXKppPbHm0nqTcEEl2oKoZLdc/n/LjSWbPCPFUuNNd5piJPwmaaqPgE31aa726htGI
	 njlX3DmYgyG/YcZvAstyHIajnDtSwXFqp0ZdLRKKakAXXSk+1WlcavJ5nvI0zX8EdP
	 mcS0X5iiPr7lnYYte/o4OLGitwyXV7p8mnExiRXRZEr9NtfUI4o+xwskTHuQZs92V5
	 8/lMHTNaWRIx85i0l3joZoHVL+xSj8K80nbBCeVtrQOrfmXOiknCuEIXHENAXYoVk6
	 qgnVIgIMr+aJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AFADC380AC1C;
	Tue, 11 Mar 2025 11:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 bpf-next 0/2] security: Propagate caller information in bpf
 hooks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174169323352.3916299.12862779814238590345.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 11:40:33 +0000
References: <20250310221737.821889-1-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250310221737.821889-1-bboscaccy@linux.microsoft.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, stephen.smalley.work@gmail.com,
 omosnace@redhat.com, mykolal@fb.com, shuah@kernel.org, memxor@gmail.com,
 mattbobrowski@google.com, xukuohai@huawei.com, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 10 Mar 2025 15:17:10 -0700 you wrote:
> Hello,
> 
> While trying to implement an eBPF gatekeeper program, we ran into an
> issue whereas the LSM hooks are missing some relevant data.
> 
> Certain subcommands passed to the bpf() syscall can be invoked from
> either the kernel or userspace. Additionally, some fields in the
> bpf_attr struct contain pointers, and depending on where the
> subcommand was invoked, they could point to either user or kernel
> memory. One example of this is the bpf_prog_load subcommand and its
> fd_array. This data is made available and used by the verifier but not
> made available to the LSM subsystem. This patchset simply exposes that
> information to applicable LSM hooks.
> 
> [...]

Here is the summary with links:
  - [v7,bpf-next,1/2] security: Propagate caller information in bpf hooks
    https://git.kernel.org/bpf/bpf-next/c/a8cd03532fc9
  - [v7,bpf-next,2/2] selftests/bpf: Add a kernel flag test for LSM bpf hook
    https://git.kernel.org/bpf/bpf-next/c/f563314d7293

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



