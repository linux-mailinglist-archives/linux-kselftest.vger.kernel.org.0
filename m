Return-Path: <linux-kselftest+bounces-41630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F0FB7CEE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C0F1886568
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 23:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF732ED167;
	Tue, 16 Sep 2025 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCr9w4Tp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2DA2ECE8F;
	Tue, 16 Sep 2025 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758064204; cv=none; b=Fmglxvj6iu70qAWxVhocyz8aw8gYCgyMwH7fLlmhUhxSt+jSG+rd9Tbri40iCtWH/3eZWYP8JxtnyGuvJv3fz9bDB5oqtTYy87cSh1ohT/+qIhwIaAXZpnLsHE0gV/hyoUPBTnSi2zwwIIvCBL3O/dpsJmA0a0QHcY5odKambEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758064204; c=relaxed/simple;
	bh=n3FyWfoe8IozA885qR+CjnEYK6+GNe7NsKd3GdP424g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A3qc67SW+IAPfz96glSXZOhzaCcTzc1PlDc1WbcxYkVgqIyINZEjLwqXt8aYFJys++7OlDMHrE8l2O+BNwCccmvcCbVU8GLwHhgEk5nbmsOC52o9EXLmjPFmCzQs6Z13PqJ+wnPuoZ76uLRYbYivhk9RmO+TxLaAONDrNFdBEqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCr9w4Tp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EDCC4CEEB;
	Tue, 16 Sep 2025 23:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758064204;
	bh=n3FyWfoe8IozA885qR+CjnEYK6+GNe7NsKd3GdP424g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GCr9w4TpV4FKq2KUSXKZ4Py8+zQ5dRBvsmNJWJnHSSqbkP99QhPtRaKXRFWe0DicF
	 g4ws4A/Mya8suHNO7+xIlQ9VTtk9u2o98MDZtP/qbPljznZ07fhXuTvwVtqg7WwuyP
	 jp7V3DGsoJXACo9/+cqHzoKsy8O/rYYdwFC92esWlCMMc92ssnuahozYz3e6bx/3A/
	 n6q7fEYnoRnKzW3LoeGaWwR3XdQF5z8BD6xaWNz310jPVoVDTGwS4sapMbR3mte7f2
	 3M5kyG9MnVTsTZaXz8f/6mNzGoayuSCc2iKhf8oUUX5U1ggYFdeCBo7JQutJzgcH72
	 ij0Drx/Oc+CbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE24D39D0C1A;
	Tue, 16 Sep 2025 23:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/Makefile: include $(INSTALL_DEP_TARGETS) in
 clean target to clean net/lib dependency
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175806420552.1395214.16357906113413765466.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 23:10:05 +0000
References: <20250910-selftests-makefile-clean-v1-1-29e7f496cd87@gmail.com>
In-Reply-To: <20250910-selftests-makefile-clean-v1-1-29e7f496cd87@gmail.com>
To: Nai-Chen Cheng <bleach1827@gmail.com>
Cc: shuah@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Sep 2025 19:30:32 +0800 you wrote:
> The selftests 'make clean' does not clean the net/lib because it only
> processes $(TARGETS) and ignores $(INSTALL_DEP_TARGETS). This leaves
> compiled objects in net/lib after cleaning, requiring manual cleanup.
> 
> Include $(INSTALL_DEP_TARGETS) in clean target to ensure net/lib
> dependency is properly cleaned.
> 
> [...]

Here is the summary with links:
  - selftests/Makefile: include $(INSTALL_DEP_TARGETS) in clean target to clean net/lib dependency
    https://git.kernel.org/netdev/net-next/c/d3f7457da7b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



