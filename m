Return-Path: <linux-kselftest+bounces-6455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5048818C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 21:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3761C213D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 20:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4F885C6A;
	Wed, 20 Mar 2024 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJj/jQiL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393885C45;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710967840; cv=none; b=U1S2Ov4KA9tBjnZk9meMOUCV1L0xkxJiWZsrvD16H8kOU+sNpuj89czjKnZRAhH1bQ4RdjDEpeyqVqF/gq+wQxVDZXDJHbftB/N0TgHcfp5XupyQ8cvty7yyeA31uJfQuD4Rm3lfyE0/pTCnNQK82TAl8lM3W5KF6ug0o3C0YVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710967840; c=relaxed/simple;
	bh=i1YYsB3MkP8iWkMd09oORaDoitK5kjLZDlxRsz79N1Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UVrcitfpLqtGnEKUwavx3hw1mfCFrKa6s801OqqM2hlulgF7QNVhwCQ7lLesv/aMKdcOFJximX5djlBZSG8J5QTqCB74nrFxcLJDO4d42U3w6XNqC++N+OkvLf2nMuS4qx+QOM9eR/zZLR6Ht9MGZKh4Nt4PFM9V9lRcrevepek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJj/jQiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73813C4167D;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710967839;
	bh=i1YYsB3MkP8iWkMd09oORaDoitK5kjLZDlxRsz79N1Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iJj/jQiLmTJUJiTcmVysHQ35TqjzpH6Xv7OMXSzge7zuIjAgmJkWNvKGx5ly7nUKd
	 w1mJzh9SXKMmv/6yq9A5uNV6GwWJkwn7rL7h5/uwndCaBH2Nnjw0K/N4jqnZtNBoCS
	 a89v3+a3sav5bNZZ9DhDJanqyKwWR96AOgQzJ+7AjWggcdTwCRZreXQQGV+ov65WjF
	 8lcQ1/9IFMyafWO2P2jv5h92222ipyp3uP1y4pTncDD2xQvquj9elRnYTsdRSvKi5T
	 me5vXqyw/h3lLTQyTT/dQDDlRppUVMQqdWsHkF7AuqC3E5uiOBzcqnCH/LTqb0S6s5
	 JfUdxK6D1jcuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 699D8D98302;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] riscv: mm: Use hint address in mmap if available
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171096783942.6804.4445478539972921604.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 20:50:39 +0000
References: <20240130-use_mmap_hint_address-v2-0-f34ebfd33053@rivosinc.com>
In-Reply-To: <20240130-use_mmap_hint_address-v2-0-f34ebfd33053@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, alexghiti@rivosinc.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 shuah@kernel.org, corbet@lwn.net, cyy@cyyself.name, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 30 Jan 2024 11:04:29 -0800 you wrote:
> On riscv, mmap currently returns an address from the largest address
> space that can fit entirely inside of the hint address. This makes it
> such that the hint address is almost never returned. This patch raises
> the mappable area up to and including the hint address. This allows mmap
> to often return the hint address, which allows a performance improvement
> over searching for a valid address as well as making the behavior more
> similar to other architectures.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] riscv: mm: Use hint address in mmap if available
    (no matching commit)
  - [v2,2/3] selftests: riscv: Generalize mm selftests
    (no matching commit)
  - [v2,3/3] docs: riscv: Define behavior of mmap
    https://git.kernel.org/riscv/c/371a3c2055db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



