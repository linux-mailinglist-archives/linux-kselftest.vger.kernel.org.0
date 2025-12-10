Return-Path: <linux-kselftest+bounces-47356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98103CB2532
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 08:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EDC830052AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 07:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E43C2882AF;
	Wed, 10 Dec 2025 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzZm/fX6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B13422578D;
	Wed, 10 Dec 2025 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765353192; cv=none; b=WoVTjAN/lzrWIsO+FLQGSM2azxWLI7rR8vPTQqQLSxcn3kZri5CrZwwORrR5dmPGi4nUchBMczqVWwKpZZaXCHFR0GCoPC5a+mXUOdbrpBITMv5qtrZ1XLfyPmsfzUHyEqdEAb8Vs4jXrqPTOwHBr41acFrx+lJ9kU6uyuWV40Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765353192; c=relaxed/simple;
	bh=0nzn63khGmeyO92wIH5lyhEhO2plqAVmt3Ik844pU2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ew/xlRMDIMR5u9gGbEErWXwWrWOSbEL4rrTP2bXGit1hYCmbFRN16o9wnkBvhX8xT8Fm34Y75Lu3cveU44l70T9Z1Aypl17nhZ9e12u87v6pHB6UX8BJRn5YtQj1OGOLhdvI1VufJYfXRDnmUCdq80b0XygfGy7dieCXADBJIfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzZm/fX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A54C116B1;
	Wed, 10 Dec 2025 07:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765353191;
	bh=0nzn63khGmeyO92wIH5lyhEhO2plqAVmt3Ik844pU2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PzZm/fX66rdrOYgS2xnN7KP4WdzWwEpgdYR9q9Cc347CYFmd7XCuq7FORIq1aSMe/
	 HLkSegfpAPZ+h0JN2guy/Sm8B4Sdx7C3q1arPajaTAJIQZNAQydrVSj8aCI5e/Z9M+
	 cByhFHtTaC8HeCh7ZjticooTC2HoOv4lEhTpTzI/hWRrc+gqFdxJzrHb4bQsn+cId7
	 z/mamv1wJEn6/SGY7gJ8dlvRCOmdjPsW4VEpeOykrgOlPFmxyhdt125EEcrvS6mZBY
	 c3oUzQ7IRzi4zJk8gpexisjbumdE0EURrlQCmvrIQnHzWzJYGWouBCnOmHWHZDKdLe
	 0Sbi366kasy9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B591D3809A18;
	Wed, 10 Dec 2025 07:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: Fix truncated dmabuf iterator reads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176535300655.493455.11967888577336619443.git-patchwork-notify@kernel.org>
Date: Wed, 10 Dec 2025 07:50:06 +0000
References: <20251204000348.1413593-1-tjmercier@google.com>
In-Reply-To: <20251204000348.1413593-1-tjmercier@google.com>
To: T.J. Mercier <tjmercier@google.com>
Cc: yonghong.song@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 android-mm@google.com, christian.koenig@amd.com, sumit.semwal@linaro.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  3 Dec 2025 16:03:47 -0800 you wrote:
> If there is a large number (hundreds) of dmabufs allocated, the text
> output generated from dmabuf_iter_seq_show can exceed common user buffer
> sizes (e.g. PAGE_SIZE) necessitating multiple start/stop cycles to
> iterate through all dmabufs. However the dmabuf iterator currently
> returns NULL in dmabuf_iter_seq_start for all non-zero pos values, which
> results in the truncation of the output before all dmabufs are handled.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: Fix truncated dmabuf iterator reads
    https://git.kernel.org/bpf/bpf/c/234483565dbb
  - [bpf,2/2] selftests/bpf: Add test for truncated dmabuf_iter reads
    https://git.kernel.org/bpf/bpf/c/9489d457d48b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



