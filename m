Return-Path: <linux-kselftest+bounces-26064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9882A2D1C4
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 00:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A32A87A55E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 23:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C891DB14C;
	Fri,  7 Feb 2025 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz//DkDY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEF01D5AAD;
	Fri,  7 Feb 2025 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738972208; cv=none; b=SVYQXiXFJNlCXD3eoBQVx4YmXtKPBjzCg9te0QezDO0DEjT+EIEUtUIqxF/acW+V5RdtGh3CR/ODkd5dgU/bO3qyXkVmOid31uZ4GivgJuO0NgmkTDRcrLvm/MoTgtYqcMMBGD0SD/2eroLf9/A3cmOviYEeFmeW/A5YNiZ5S0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738972208; c=relaxed/simple;
	bh=0l9I3ZTucJtgqHztfvDvwGt9VQWuNVYmxkptBfWwKNI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lc4rRi1nFbnED3tLXg+pS8lEz1OMAIRaxRO2LosCvyodIv294DpqCQpvn9nNcKseW//vvGxco8QeMTQoRXvoVWyMVFLQ1amQTnMO8bHCBfR0FL1VaScmzlaYaeynmGVLvqxURrFF9DRTtCmBgi9qq0Z237bL3TLB+KiHxVIVhYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz//DkDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79A4C4CED1;
	Fri,  7 Feb 2025 23:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738972207;
	bh=0l9I3ZTucJtgqHztfvDvwGt9VQWuNVYmxkptBfWwKNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iz//DkDYkKDjvBPjRjGNMBegPCKchCieBSWj26rT5IpyHxDJin/1kEj+4gm68LgNY
	 K9p2GhF5bZvMwIim/BsYa96mLa4YrC3Aynf+iOynuekMtx31qEFDqG96xM1vlrvNLI
	 ThHHmvTGCsVE2NdFi8YAWJSGNXdZzngi//gOCQLdiF8Th7CtUIY6LFrjwUe8qWonxD
	 WKKxuf+jQN5BCHSLPqg5D9WVu66wayftrnzR/x7nHN6guWhcJr0gc0mNQhsBpKViBR
	 vXW0fzdEjZRKiOwt7NjrmTG/45b4w+dKERXMyF6dY3mFiaWzqYw7uiLxoqEMUn4qxh
	 6H5mH/04Add9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB54C380AAEB;
	Fri,  7 Feb 2025 23:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] bpf: Some fixes for nullness elision
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173897223576.2425305.593273942477450759.git-patchwork-notify@kernel.org>
Date: Fri, 07 Feb 2025 23:50:35 +0000
References: <cover.1738689872.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1738689872.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, mhartmay@linux.ibm.com, iii@linux.ibm.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  4 Feb 2025 10:25:15 -0700 you wrote:
> Two fixes for nullness elision. See commits for more details.
> 
> === Changelog ===
> Changes from v1:
> * Reword commit message in patch 1
> * Add tags
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf: verifier: Do not extract constant map keys for irrelevant maps
    https://git.kernel.org/bpf/bpf/c/884c3a18dadf
  - [bpf-next,v2,2/3] bpf: selftests: Test constant key extraction on irrelevant maps
    https://git.kernel.org/bpf/bpf/c/973cb1382ead
  - [bpf-next,v2,3/3] bpf: verifier: Disambiguate get_constant_map_key() errors
    https://git.kernel.org/bpf/bpf/c/7968c6581507

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



