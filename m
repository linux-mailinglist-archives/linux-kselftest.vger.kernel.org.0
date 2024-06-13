Return-Path: <linux-kselftest+bounces-11894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB2B907B17
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 20:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871DB1F238CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBBB14B95A;
	Thu, 13 Jun 2024 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0pOpo0S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3983714AD1E;
	Thu, 13 Jun 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302831; cv=none; b=OCki5gR8nauUdFHkxl7lwNXzn9ZwKRzhznyJOLBGBMSWOcRPNtMIH41czfwBnoBr83tT8NnK5q2teCY7/T9S/WtrKJnWJoAMPyGF6ybKJsphPnFgRCg+LQuEOTYFpfi3zB80o30JlTVv1dEherVouIYWuxbfHo10DnCJtCkuX0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302831; c=relaxed/simple;
	bh=pgSDVWzajqamfEJi3ukbUVIaY2PON1AST8CHsFiaqSU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QoBQy7fNUDPkRicGNEJuuSlM4mImX3vNUMcyAbmwrsVIgC+X3hJJQRIE5+o+LRhQKgHabmcjQht19m/NQGcylie24D/d8uVlTmNM0qO+pfy0Va81aNyv5OP5uxpLgKDh9YmTG43hLODcP54MstOaHl+zi0Qj04Xlvbau9yZ62Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0pOpo0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD56DC3277B;
	Thu, 13 Jun 2024 18:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718302830;
	bh=pgSDVWzajqamfEJi3ukbUVIaY2PON1AST8CHsFiaqSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a0pOpo0S/OlS28H73rxI2e/f9sP4RLVPpzd5GM9w6ccUV8Mv5vRG7gO2y9x1vKt4R
	 myc3IUGeI60b9v1lfOIrTc4OylxCAZRRSwL8bAnq97qIiXjK/VO/a1Km1JsUhUZf8r
	 qRVWHSErfQiRgs8+ibu7yAn90y2bk9tk7tInqHJqPu+nFOpmxgL0nqY7ExH51Y08QP
	 PZby7p9nBxkFkZC1KA3iOlnqDHMxC9A1QWANdqcNmPo0St/7GrwSws4UOFMWIs45ej
	 0rWPdQQmAiqDpaEFvJKnvb9HzVl+K3NBxm478RbXrsNEDG4Gm/OGGsMcMHE+xyv/k3
	 YNv7H2XISrulA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1AE1C43612;
	Thu, 13 Jun 2024 18:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] Fixes for kfunc prototype generation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171830283072.12313.15051014857766473661.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 18:20:30 +0000
References: <cover.1718295425.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1718295425.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ast@kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, , ""@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 13 Jun 2024 10:19:24 -0600 you wrote:
> This patchset fixes new warnings and errors that kfunc prototype
> generation caused.
> 
> Daniel Xu (2):
>   bpf: Fix bpf_dynptr documentation comments
>   bpf: selftests: Do not use generated kfunc prototypes for arena progs
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Fix bpf_dynptr documentation comments
    https://git.kernel.org/bpf/bpf-next/c/78746f93e903
  - [bpf-next,2/2] bpf: selftests: Do not use generated kfunc prototypes for arena progs
    https://git.kernel.org/bpf/bpf-next/c/6a8260147745

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



