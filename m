Return-Path: <linux-kselftest+bounces-796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE017FCEFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 07:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8733281AA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 06:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F097462;
	Wed, 29 Nov 2023 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrEP/1Q1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D775673;
	Wed, 29 Nov 2023 06:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5D3FC433C9;
	Wed, 29 Nov 2023 06:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701238825;
	bh=wywDLsSU7iwTNOmigdxnxDtDCSA3ORpnWmHAGx50LVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UrEP/1Q1BA2mLZ+PALjBTcfo84tCunQ0NLZbeL2NDxZxdz6mGL/BPPsMbbiW2v6bV
	 AqYQbFJZxBeDcAoAHl70kzZIac434l/4M8jrTaEmmxP324dSWeaO4K8EyivvHmFDCi
	 MX8YjvZGegGrNXReU5GGDi2CGg1WKBKhtR8+WEqFvyq2HL7+YgZSjs6W82X5RHcUXZ
	 ew3ek47rqIoFuWpFnmxpXI81yY9r4B8pGtFflpK1EDu20jHyVdC9FR3/wHr+/Z3gx3
	 UNKjjzJxkMdZshWqKjsr2BiFE2Tm6KNAzNg4nrAVzyDAywBBrkT2WG35SOExyV5shT
	 jsSwXCUr9BtGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD00CDFAA89;
	Wed, 29 Nov 2023 06:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] selftests/bpf: Use pkg-config to determine ld
 flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170123882577.32761.1092609140496107416.git-patchwork-notify@kernel.org>
Date: Wed, 29 Nov 2023 06:20:25 +0000
References: <20231125084253.85025-1-akihiko.odaki@daynix.com>
In-Reply-To: <20231125084253.85025-1-akihiko.odaki@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: andrii@kernel.org, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, terrelln@fb.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 25 Nov 2023 17:42:49 +0900 you wrote:
> When linking statically, libraries may require other dependencies to be
> included to ld flags. In particular, libelf may require libzstd. Use
> pkg-config to determine such dependencies.
> 
> V4 -> V5: Introduced variables LIBELF_CFLAGS and LIBELF_LIBS.
>           (Daniel Borkmann)
>           Added patch "selftests/bpf: Choose pkg-config for the target".
> V3 -> V4: Added "2> /dev/null".
> V2 -> V3: Added missing "echo".
> V1 -> V2: Implemented fallback, referring to HOSTPKG_CONFIG.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] selftests/bpf: Choose pkg-config for the target
    https://git.kernel.org/bpf/bpf-next/c/2ce344b68916
  - [bpf-next,v5,2/3] selftests/bpf: Override PKG_CONFIG for static builds
    https://git.kernel.org/bpf/bpf-next/c/18f6f9de98d1
  - [bpf-next,v5,3/3] selftests/bpf: Use pkg-config for libelf
    https://git.kernel.org/bpf/bpf-next/c/8998a479fd96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



