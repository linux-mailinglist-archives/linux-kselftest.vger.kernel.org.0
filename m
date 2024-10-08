Return-Path: <linux-kselftest+bounces-19191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAFF993D7F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 05:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D70284BCF
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 03:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92AD42AB4;
	Tue,  8 Oct 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxL/dM75"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B740858;
	Tue,  8 Oct 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358229; cv=none; b=DDBXWMBTraChjauI90SLpZ9K31907PtIlqLFxhuHZDq6mL6Y7MHYu4eJ3CRQdIRtwiSCtVmKlGdc99XlrtQB8XZI6M4+F1aSIMg4eAIRbvM5sUxnjmMxl5pW+HOQEqN6A/7P+eKiy4gJBzbCeLCAqlDw858/vKcJzITsrVJJZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358229; c=relaxed/simple;
	bh=PSOIf+TyBQF57TpOyMNELr/Rx8demt9hWhySbu/LsRs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B6SZB5XmabmqWIUJBIU93al9pe1iClRF/5tdWKaTvFPPOWfGYXlM4vk5iMRn2yM1MvVMadUNJL6Bu5ldrnfLyJzYe606WWZRbHNm1ZYOEkJJ8JiRr3H98Z/DSMf5VE03HG4zFlzfq6YOeniifk1QpxJpGy7Dvu0b1jGorlFDny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxL/dM75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F478C4CECC;
	Tue,  8 Oct 2024 03:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728358229;
	bh=PSOIf+TyBQF57TpOyMNELr/Rx8demt9hWhySbu/LsRs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IxL/dM75Cv3V8A4ljrby9r3ouPy/31wVFYylG13rTWQHl8hVki9A/Ci9XSb2BzScJ
	 QyJ2jbL+H1YAoOhxT1vcMdctzCMcQTdxuwOtl5qgGrXaDgpB+0lDKxoPYW6I1tInK2
	 7ZkCy0LUlNo8zxRbA9tBUcMEnYVnFEAcOFLYICYqpaJG5AfNgHWE4BIuu0qQGMvVFQ
	 uQggEH/s9sgD68hA2f7XTnizUeu9eeqwNKw7M8VuonGcUqfFycg8RkRPKmK694kxdo
	 YAh/orE4txks1PLfJmBRkGCcyeS+/NktocqUYPrqTWNKFSF4P9YyBJQGW5TtzXAayN
	 mPAvrRWAKWe5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BFB3803262;
	Tue,  8 Oct 2024 03:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add missing per-arch include path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172835823300.66789.3704854116445399222.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 03:30:33 +0000
References: <20240927131355.350918-1-bjorn@kernel.org>
In-Reply-To: <20240927131355.350918-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, bjorn@rivosinc.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 charlie@rivosinc.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 27 Sep 2024 15:13:52 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> libbpf does not include the per-arch tools include path, e.g.
> tools/arch/riscv/include. Some architectures depend those files to
> build properly.
> 
> Include tools/arch/$(SUBARCH)/include in the libbpf build.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] libbpf: Add missing per-arch include path
    https://git.kernel.org/bpf/bpf-next/c/710fbca820c7
  - [bpf-next,2/2] selftests: bpf: Add missing per-arch include path
    https://git.kernel.org/bpf/bpf-next/c/19090f0306f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



