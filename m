Return-Path: <linux-kselftest+bounces-6454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AC28818BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 21:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0F41F22DED
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 20:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD58D8593A;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW+aLSi5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C87481C0;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710967839; cv=none; b=iydSG9XPYgsv/BBc5NqEWTlbM0PwQEMj4XwxkCqTpGlXsu2n/vYYdRxcQL1yKrjniJZL8Mxrzk8oXrVXvo99B8jnksSPWoX5mQiKbUSEGbKDs3rMr0gQeIIxSF1Qt/h26HLmSoF102TONUAQz1mr4QIO0gx00scAVOJVGiQbpV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710967839; c=relaxed/simple;
	bh=feaZEDxIe578pwpNMawFSPwGBKbYYi/Q1YQaICgmoFw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uVZALs60pkJFV3W6BokmFzP5n03RMpTo7yCp03YINUqSG0EnFquTuzGFL6xYUKBciaeMhzmKDM0ldMZTRMTxuN1lrb9CtaVNdHuujeAAjg2GK4FplBhTc3LmmTs9mYvtoCPanGEi/kOWl9yAxh61P+n1bq3n+o4zHQ9eMYAFlPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW+aLSi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38841C433B2;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710967839;
	bh=feaZEDxIe578pwpNMawFSPwGBKbYYi/Q1YQaICgmoFw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cW+aLSi5jdXZfNarQIHyoYMGoUZea1B/zZBZrwJqpt3dZZ6YH9TRozAboosZRfmFt
	 nxtTN+rQq47DGxsMkZ90tqCtCQ1fS8in2Fi8i97aYL+l3VzKd0rr9YmBx90+t9O6gB
	 ldgCCliszdcKc+yPJUtSWjMSmQImrca0BcZ2QaaI+mNo5zVLAa5dnupRbHZ/tpN+QL
	 vUEAftYjaKRmhX3jErql7VgbO8tankxJtDSJor4D+PCk7ACvHjwRpSQPehkWfwkK6X
	 GsBmqkRJUigFl1y53JvBe6+RqtMUP0cl8Pz6KtxTrGNzf5yMF98WjngLGHNn2o/trb
	 lCSjMY+kxP0zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DA33D84BB1;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] riscv: mm: Extend mappable memory up to hint
 address
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171096783918.6804.10596170298204766032.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 20:50:39 +0000
References: <20240130-use_mmap_hint_address-v3-0-8a655cfa8bcb@rivosinc.com>
In-Reply-To: <20240130-use_mmap_hint_address-v3-0-8a655cfa8bcb@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, alexghiti@rivosinc.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 shuah@kernel.org, corbet@lwn.net, cyy@cyyself.name, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 30 Jan 2024 17:06:59 -0800 you wrote:
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
  - [v3,1/3] riscv: mm: Use hint address in mmap if available
    https://git.kernel.org/riscv/c/b5b4287accd7
  - [v3,2/3] selftests: riscv: Generalize mm selftests
    https://git.kernel.org/riscv/c/73d05262a2ca
  - [v3,3/3] docs: riscv: Define behavior of mmap
    https://git.kernel.org/riscv/c/371a3c2055db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



