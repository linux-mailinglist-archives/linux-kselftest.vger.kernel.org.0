Return-Path: <linux-kselftest+bounces-40964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 163FCB49691
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 19:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B863A9B99
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ACC3126D6;
	Mon,  8 Sep 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rp+sVRsW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5833126C5;
	Mon,  8 Sep 2025 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351409; cv=none; b=JtV81tw9p9hHbk+BSBKvg5RAFjLBwTiDKqphZlM7K6Qu1G0xp1fI9Na4V9XXMbs8tdsSs76xnPg9NuOk4vrrOCQsbJCbRW/tDdHVcocwAtyogp4cAPT6jrGinv5waViqWHsKM8uH/679BGaOjYGqw6Y8dqHv2tr1Wl3VgoYr35E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351409; c=relaxed/simple;
	bh=mkhf/7gtatGkQ7O1zYt4YTF5QS6JQdKkj+kGj8y33Fc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NbTH5dTR0XDscrBF/d86mhnfi4wWFl35n/TFG6WXYhvhmOK+6bvF+ZVuAcUDhTKjCNQ+UKXltHCaT1ppaUahO9af/nBlZxKJqQJ7amYicHg8grYp1hUHLoS5kkrzBkYXBIF6kayDi7pO5QYfgLj1KBuxC5a0hAViM9irbiAa0QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rp+sVRsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F865C4CEF7;
	Mon,  8 Sep 2025 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757351408;
	bh=mkhf/7gtatGkQ7O1zYt4YTF5QS6JQdKkj+kGj8y33Fc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rp+sVRsWaXORS+u283rGav++E0m38SoPMaR4j7gx2rAMdrvkZXNJCCTb8WaLyZkh6
	 zq3yNchOPGegJ9QEy7Q5VgZwmqaT41sTa38snXZtiTbKdiNsmBGLEqMmqamyz7U9Vd
	 yy6UljxLhLWAGO+f/5Owf7I6rh7itvqC6HFQEPjHC5BB0ynm0c01AATlEidGu1Kqx0
	 4OCcTpVWsjsu3o/509nKTDWFQYff14D6fZIrWAD9qdKzDSe/vw+g2ywb5as3kTImxJ
	 vGf7nEJAJPFs/SVivYnqYjb6bv92WeWbxz9f87zuebCWf8nSBB+nOtvN1K9MMB/rWN
	 q96tFhWTuUbSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E17383BF69;
	Mon,  8 Sep 2025 17:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Fix the issue where the error
 code
 is 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175735141225.4178020.16850270917605667422.git-patchwork-notify@kernel.org>
Date: Mon, 08 Sep 2025 17:10:12 +0000
References: <20250908060810.1054341-1-yangfeng59949@163.com>
In-Reply-To: <20250908060810.1054341-1-yangfeng59949@163.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon,  8 Sep 2025 14:08:10 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> The error message printed here only uses the previous err value,
> which results in it being printed as 0.
> When bpf_map__attach_struct_ops encounters an error,
> it uses libbpf_err_ptr(err) to set errno = -err and returns NULL.
> Therefore, Using -errno can fix this issue.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] selftests/bpf: Fix the issue where the error code is 0
    https://git.kernel.org/bpf/bpf-next/c/93a83d044314

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



