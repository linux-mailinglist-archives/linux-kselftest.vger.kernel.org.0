Return-Path: <linux-kselftest+bounces-9144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AFA8B7A5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 16:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172DA286D3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 14:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFF917F36B;
	Tue, 30 Apr 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRZq1z6N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A072C17BB1F;
	Tue, 30 Apr 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488032; cv=none; b=XkyhBnZM7SzM2Ft3sBdsNalVGsZ3D7W/3GICMVeCiycMKQ9GG5+VakdgZmIcNoFbN0DlIp8oIrJLBUHQToW4ov17HBDQ3H0sAUu/3CsqPlNkJgiT7xJ6QJv1nbQSmhG5DEWVKtRWt64qIodyAcFgstp2tY4f877hRbAwZ2H+tLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488032; c=relaxed/simple;
	bh=wZ3H0M96hj1P2m3kZarPeySiAcASDaF12cW1p+c4xMA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YHbr7+nD/S/mCpte55FTms5K+q5EOK/qzoXxs809lrm5lAFzMoEH0rhng92RJKuzgKbdYtAXKE3nLnz8802vMX+JkvZ/jpzhZyduc0bqjGXMFqkDwlEEroerFrtrqq1J/Ly9rcXWLzTytwEA3yJLrLAXyL7UqwNvF9xDz3F9mKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRZq1z6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30A38C4AF1C;
	Tue, 30 Apr 2024 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714488031;
	bh=wZ3H0M96hj1P2m3kZarPeySiAcASDaF12cW1p+c4xMA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NRZq1z6NUxOKrltdgSSWxu90z8zc4alucw8nLYzgOyuNuYLRQDk89pewC9JiUbPdr
	 eOh8H04skdS23+aFzuXbPpQ3sAvtDQnPO4xLw2fvSFgQmDOgo67v9QzFjOIRO/JP/3
	 dVDFjzojQX70GRinruiJOxUwIc+FdZgIGdinafU0+HvLDe2uXFWVBSOu6XfOT+eaYF
	 3S3hiF9l8NdJqX8dpfrNzfJcEfPOgr1j9ZY+cofIVcnBR0eOwUP3DF01avnRPhVa1W
	 81oA70NOYZ5e90+iFCUfxnrLgBmInIxedeHDmLldQMXXcrFZfY20vZGhVzSQtnwOso
	 JGAnGb6PxjfbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18390C43617;
	Tue, 30 Apr 2024 14:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] bpf_wq followup series
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171448803109.2160.14624766767267201976.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 14:40:31 +0000
References: <20240430-bpf-next-v3-0-27afe7f3b17c@kernel.org>
In-Reply-To: <20240430-bpf-next-v3-0-27afe7f3b17c@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 30 Apr 2024 12:43:23 +0200 you wrote:
> Few patches that should have been there from day 1.
> 
> Anyway, they are coming now.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
> Changes in v3:
> - fixed bpf_test module not being able to be removed, because the bpf_wq
>   was never freed
> - Link to v2: https://lore.kernel.org/r/20240430-bpf-next-v2-0-140aa50f0f19@kernel.org
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: do not walk twice the map on free
    https://git.kernel.org/bpf/bpf-next/c/b98a5c68ccaa
  - [bpf-next,v3,2/3] bpf: do not walk twice the hash map on free
    https://git.kernel.org/bpf/bpf-next/c/a891711d0166
  - [bpf-next,v3,3/3] selftests/bpf: drop an unused local variable
    https://git.kernel.org/bpf/bpf-next/c/05cbc217aafb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



