Return-Path: <linux-kselftest+bounces-22270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CAA9D25A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 13:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C36C6B23C03
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 12:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3181CCB34;
	Tue, 19 Nov 2024 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ac4OhrJj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4113E1CC174;
	Tue, 19 Nov 2024 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732018818; cv=none; b=nrMZaie3JOQn+Mk/pqYEh/cI4+f0tEuXg2IgVS+F4hWJnoyFzHeUu4x1oBDWF4rebizNwHu0JZrkKvwGLdZayHEj2WmNf1S9vFaD1Gb52EavS9ignAHgl1VB9VA+yxCvXK/lPAC7RSZcJ1swmYL9HWQ2mcmK6ceYn9nTJztKWyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732018818; c=relaxed/simple;
	bh=d4a1yeP4aywDL2DBdHc7SqVauFiOd2g07gX5lYzWhK0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EiQ14RaeWJceQ+Wy1AekLw2gtReIYzgwP5iHDImRMM/ut+5qfyVsf9iVanasiWTX12+cFgUXefqoaLheFqLdF3lzeYPz1QZEUlJ0TIvUGXzjPI/3ma0OVLy2RCXgUoR6JgKWOjuGhsvgl4r0x48//sHJWLMMWFXxAlf99Z7onlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ac4OhrJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B351BC4CECF;
	Tue, 19 Nov 2024 12:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732018816;
	bh=d4a1yeP4aywDL2DBdHc7SqVauFiOd2g07gX5lYzWhK0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ac4OhrJjmePGR95qdOTbEyPHy7aEzJsah5gUpHGiBTSPqDfGmi3fTgpfgA/Y6Pbfr
	 LycVjNatPaSZ61PQqakJTsqk6tThFV+nKP1lc01e6s21ZpePGa+WCQk6B+TCVRAnL4
	 k55riJIUjq1/OIZarYWVHDDCv6EDKjqhjvIb3BKqJ+X13WG+cXSKpnmqr005cNa7WR
	 IZTRskYAg1MqYHKEw85zsc0PRsnEhlXfXza8zNRFouYbWUwrI99zP0TxmNJLYfFGpV
	 1Aa9ZSqA4u7KRfhS+kh0vXJDIQFbt+kznyJEIXVKb0/e3J3BwmWyX9RChOE3YXj2hM
	 g0dzxaWo7KuNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E5C3809A80;
	Tue, 19 Nov 2024 12:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] mm: page_frag: fix a compile error when kernel is
 not compiled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173201882826.521115.7946425601495099550.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 12:20:28 +0000
References: <20241119033012.257525-1-linyunsheng@huawei.com>
In-Reply-To: <20241119033012.257525-1-linyunsheng@huawei.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, akpm@linux-foundation.org, alexanderduyck@fb.com,
 linux-mm@kvack.org, broonie@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 19 Nov 2024 11:30:11 +0800 you wrote:
> page_frag test module is an out of tree module, but built
> using KDIR as the main kernel tree, the mm test suite is
> just getting skipped if newly added page_frag test module
> fails to compile due to kernel not yet compiled.
> 
> Fix the above problem by ensuring both kernel is built first
> and a newer kernel which has page_frag_cache.h is used.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] mm: page_frag: fix a compile error when kernel is not compiled
    https://git.kernel.org/netdev/net-next/c/96ed62ea0298

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



