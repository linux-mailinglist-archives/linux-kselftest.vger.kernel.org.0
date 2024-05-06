Return-Path: <linux-kselftest+bounces-9560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237A48BD6F9
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 23:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9DC282C14
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 21:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03C215B992;
	Mon,  6 May 2024 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+D3hDhV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B4415B969;
	Mon,  6 May 2024 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032227; cv=none; b=mzysoxLkM2KAelvvmBrI+zX+cj9asINgQHufuiHfS4tSMFQ7/H1TvEnUAJCKNCGKD35DNfnpUIM2qeTHJ/X1ULtXjoKn55nHHF3pq4MxJ5hL9j7m1RIbU3C78VpdLYjQd8sKLAnWRxnELxxnvCrnZ5cGiw0zJsY724bt9EzUGVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032227; c=relaxed/simple;
	bh=9Zd7+Ef8NQcoFhyrm671mnDTJo4rld+Mz0fnkSQYiMo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cg5nsEJ+9HGLSX6mMGhvtSA/1/NZonS5vSeG16Vy+gjqQDZoIfg1CYD/VxftYF2t/gP8HQYkna5Xti5dFqNGztOI5vvMUtReYcHtlGvN2qcTIuMHN3XWXZFWN21xFQs63HrZ1tjESTIR2b1EXcSlMeuB/wd4QIKCDVg5PeZjjA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+D3hDhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07433C4AF63;
	Mon,  6 May 2024 21:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715032227;
	bh=9Zd7+Ef8NQcoFhyrm671mnDTJo4rld+Mz0fnkSQYiMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u+D3hDhV5RrZ8fsVtQ3j0TxymbZg5bjw0NCNH50+TcgwFKRiTI+e5NeRijLmW02pU
	 6xoIBS7fo2IGmQyj4GImSU4B41AhUgesFZdn/Fp5qUXhQx8E4huf4zQVL/dl03/63A
	 XUMQoEejaZqC4MAAo3hQD4dKnV2nuoonO3IWvV774Nc2En2MofOVZwMnHVk39IkeBl
	 LEKZZ7hpZgbSYfw7YDvjudqVrZKeXoxJvFR8OE13ukl+qLJtuhGsqMsxaId+rHXZq/
	 T8kFvDd4QDnwAdHJKmn4+lqxih34vHonuJwy823UOw2ehvzAqCmcfY7YSArl8dth42
	 rWwZg9KtPrF0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DED32C43335;
	Mon,  6 May 2024 21:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpftool, selftests/hid/bpf: fix 29 clang warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171503222690.16829.11651014493089748418.git-patchwork-notify@kernel.org>
Date: Mon, 06 May 2024 21:50:26 +0000
References: <20240505230054.13813-1-jhubbard@nvidia.com>
In-Reply-To: <20240505230054.13813-1-jhubbard@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: shuah@kernel.org, jikos@kernel.org, bentiss@kernel.org,
 justinstitt@google.com, peter.hutterer@who-t.net, jason.gerecke@wacom.com,
 joshua@joshua-dickens.com, qmo@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-input@vger.kernel.org, kernel@valentinobst.de,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun,  5 May 2024 16:00:54 -0700 you wrote:
> When building either tools/bpf/bpftool, or tools/testing/selftests/hid,
> (the same Makefile is used for these), clang generates many instances of
> the following:
> 
>     "clang: warning: -lLLVM-17: 'linker' input unused"
> 
> Quentin points out that the LLVM version is only required in $(LIBS),
> not in $(CFLAGS), so the fix is to remove it from CFLAGS.
> 
> [...]

Here is the summary with links:
  - [v2] bpftool, selftests/hid/bpf: fix 29 clang warnings
    https://git.kernel.org/bpf/bpf-next/c/41b307ad756e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



