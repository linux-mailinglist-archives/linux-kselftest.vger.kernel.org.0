Return-Path: <linux-kselftest+bounces-34406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75482ACF910
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 23:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7CE3AF78E
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 21:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED24828030B;
	Thu,  5 Jun 2025 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWqapLBI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF0B27703E;
	Thu,  5 Jun 2025 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749157204; cv=none; b=l4GpKD/ZYKokZnVaxlsiz8ljfpsgD55I7U/+S9h9rtGSp69Ae+a/1W0e3+lxDkhznFm/VlFhWq343JY8UTTUGcREC1Kpiz1qDQChpPVc0Iq8b4np57KGlRg5fyX+BeCm6hIKfhpA8juqZc1I/iXLUrrCqvRXR59oQEZD/O9Jjt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749157204; c=relaxed/simple;
	bh=Np29VEghXNFRrDmIwdo8IoqrgkTyjYUe/Nzr5GcwPwE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ptPymAbWe5u5wA8JKJRE0LjHlUYuZfzE3BfVDc6Mmru0naoHEzvMWUYQYq2X/P+/5KO72nkGDSA/Py/mz+cIHr8w9Z8zoKDblXorqMNVyGrI4lkEbWi3H7Y8zQ+0cX62aEiT1Njg9g1QKQPqCOu2lQu8EAf8NEkMum0CkpZgYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWqapLBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0C0C4AF0B;
	Thu,  5 Jun 2025 21:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749157204;
	bh=Np29VEghXNFRrDmIwdo8IoqrgkTyjYUe/Nzr5GcwPwE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EWqapLBIrteSn6G1HL1zkoZIlyU3mAeAleWff2+HZxRUABXy4UUACLdHbyVOeaLpe
	 v3krzzatrm05+7zfiT/WRbgS92Kw0kMC0mc74kNCFpD8iKYyCBjy4baseyRfkL3lOL
	 KI+gAgJH7RZZhwTWyoZYpVqgfkqQejBTyys/r1RqaJ+J9zhsr5aossyrrh8z0IRc/j
	 Ava6MfEuYOPmwywcUJIVNf6FA3u97Mwx9DVgOHpv7JYlPwt/Ti688oNdTaq5C3WAgc
	 omJEfPEoI+tupRRkau9Ltgjs19Flv9Be3hVqpMUUkvuKCUhgaPhd8FxpD1p26zSkR8
	 l1wuiaALXctMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FA939D60B4;
	Thu,  5 Jun 2025 21:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: rbtree: Fix incorrect global
 variable
 usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174915723575.3244853.11233965980667764500.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 21:00:35 +0000
References: <tencent_3DD7405C0839EBE2724AC5FA357B5402B105@qq.com>
In-Reply-To: <tencent_3DD7405C0839EBE2724AC5FA357B5402B105@qq.com>
To: Rong Tao <rtoax@foxmail.com>
Cc: rongtao@cestc.cn, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  5 Jun 2025 16:45:14 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Within __add_three() function, should use function parameters instead of
> global variables. So that the variables groot_nested.inner.root and
> groot_nested.inner.glock in rbtree_add_nodes_nested() are tested
> correctly.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: rbtree: Fix incorrect global variable usage
    https://git.kernel.org/bpf/bpf-next/c/64a064ce33b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



