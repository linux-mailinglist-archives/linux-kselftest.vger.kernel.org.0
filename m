Return-Path: <linux-kselftest+bounces-45680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779B9C5FD5F
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 02:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDAE3BAFEB
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 01:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B802B1EC01B;
	Sat, 15 Nov 2025 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8361eFx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807C813D521;
	Sat, 15 Nov 2025 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763170241; cv=none; b=U6IA6RipGDXi1WRS1AAvTx2dBmZup9vf5A3eBWAuCUnLWUu0WXPzRnYq6rTU+g6S26m0MzhaJJHk1hXAb8MDZpjnbEa2JZnTdlGvu1eE+LG0bzXFrTJKZptZ1WjGgNul9g7E9ELpuwYhicQ+dRKqFTxp9vzmh+aveZmSN2ad1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763170241; c=relaxed/simple;
	bh=j7e+NTjCwCCaQhyCSh4nJ7OZ9PrbAIJG6JUT8RWcHN0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HYHiQc/yAXJ5C1Blh1iADVlGibV9oA9rwO22cFnP84N4+Kgw22kte1dDWL3eqdam3qE0d9oJ/cdxwoidXqH8bhR0RXVP9AVV2CDN9Phu5qi9mM6epfqoVVBkF48b9kd9VR5QHK8RNFVnIDLKIexOvR6swgr0ehMU3FCvJVvbJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8361eFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E262C4CEF5;
	Sat, 15 Nov 2025 01:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763170241;
	bh=j7e+NTjCwCCaQhyCSh4nJ7OZ9PrbAIJG6JUT8RWcHN0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u8361eFxTqkREeJc1hN9rKRYJ4gbUUi2qbZbgyO2/SotDS8CXcOcYCDkjpi7qCEem
	 Gfn0OtqMm7l3KL5TMhVjs3D5xgyqiuFCpjZxgoyLC6nd/yb8yTO7Z/g6KLyWo//Mvo
	 jkRaWMRGa3J58raMC1W+Z1PTlnq/cXAIt7mOL1Wi6fCssCwFa4dDhjqcHeZOwcKY+D
	 pFSq8SrRc1A9L/QCJFZ9XPMh2rn1T1Yjdfh/O2ZI1MZBpinjDe+51/jwzS2lWJ392e
	 ze1c3cHZLSftXJFLobRoH7SbCzbr7/M8YF7iieCwz106tBfzOZDQIsZjmd5KHY+rpe
	 D7rYE/inq1puw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEB83A78A62;
	Sat, 15 Nov 2025 01:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] libbpf: fix BTF dedup to support recursive typedef
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317020950.1902092.15007973017309651020.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 01:30:09 +0000
References: <cover.1763037045.git.paul.houssel@orange.com>
In-Reply-To: <cover.1763037045.git.paul.houssel@orange.com>
To: Paul Houssel <paulhoussel2@gmail.com>
Cc: eddyz87@gmail.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, martin.horth@telecom-sudparis.eu,
 ouail.derghal@imt-atlantique.fr, guilhem.jazeron@inria.fr,
 ludovic.paillat@inria.fr, robin.theveniaut@irit.fr,
 tristan.daudibert@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 paul.houssel@orange.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 13 Nov 2025 13:39:49 +0100 you wrote:
> Pahole fails to encode BTF for some Go projects (e.g. Kubernetes and
> Podman) due to recursive type definitions that create reference loops
> not representable in C. These recursive typedefs trigger a failure in
> the BTF deduplication algorithm.
> 
> This patch extends btf_dedup_struct_types() to properly handle potential
> recursion for BTF_KIND_TYPEDEF, similar to how recursion is already
> handled for BTF_KIND_STRUCT. This allows pahole to successfully
> generate BTF for Go binaries using recursive types without impacting
> existing C-based workflows.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] libbpf: fix BTF dedup to support recursive typedef definitions
    https://git.kernel.org/bpf/bpf-next/c/3781413465df
  - [v4,2/2] selftests/bpf: add BTF dedup tests for recursive typedef definitions
    https://git.kernel.org/bpf/bpf-next/c/a69e09823ee9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



