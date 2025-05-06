Return-Path: <linux-kselftest+bounces-32476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC86AAB8DD
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 08:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181241C41DBB
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 06:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042ED2980AB;
	Tue,  6 May 2025 03:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa9XyYup"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0FA3507EF;
	Tue,  6 May 2025 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493189; cv=none; b=DOPK9uhL8gyNuJoW5/4B88E3tEAuNe+ah6vY90B3KFQFSmpiiTkBgdLe4ja0hMSddobI7klaR4WGbSiy3QYZRJSU0NPk5WRKm2zgKtAwl+yj5W6BXDvGsC1brJI/DfrSUhHFqsJtb41vRK0xqYYs0Ny1T6u8hvMf4tJXZqQ+LeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493189; c=relaxed/simple;
	bh=2QUNPdvPmZlydnPDCRCXr7/Fn9MjlbeS1E1q///KdoM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hi2VpBchYMhmCacp0cd2Z411UOjmB+Qvbp1hGojmSFxxY3Y7dMtSYAPSQRCEh1PA+Vy9HVJnPr5ELsgU7ZYSmX0raxBLx+3EEU8CY9fcme+WtF+HTp3I4O4EOL5Nz6cZwg35VYj5S1bbphL2OI57+j1v6MC1rcy6X7LJVFK9+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa9XyYup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDE9C4CEE4;
	Tue,  6 May 2025 00:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746493187;
	bh=2QUNPdvPmZlydnPDCRCXr7/Fn9MjlbeS1E1q///KdoM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fa9XyYup/nsKloTGMlwGBPQRvnl+HzCMXPuAj2wds782Rks36WkRzyXJFk6eNK/TZ
	 AXdXuW5LrHlWhIZ+G4kG67ltWX2j7262qr8WGVmncgy0TpiAAzSe0xvMt6CjUE+lCB
	 2CVwdBHItmOVaR2TTD1UCXkScI7+Hj8WnaQZLVW4D//ZUOyXfcov7D0D+GEL0IRxJz
	 dZz1vt2g2gnVCmZTNFVSyCQfB55YGIEzoxVyKTINR3lPLTtYf0C3SGeZUG7cLa632k
	 P3+OtmbnGii+geIkHMY3agAx5NOY+vhzxxtwnEDLzi2pFLaSa+0dBzIjMBKE+QCixw
	 KXcRQpDgI5usw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC8C380CFD9;
	Tue,  6 May 2025 01:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: iou-zcrx: Clean up build warnings for
 error format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174649322675.999857.16419366433840326813.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 01:00:26 +0000
References: <20250502175136.1122-1-haiyuewa@163.com>
In-Reply-To: <20250502175136.1122-1-haiyuewa@163.com>
To: Haiyue Wang <haiyuewa@163.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 dw@davidwei.uk, axboe@kernel.dk, horms@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  3 May 2025 01:50:25 +0800 you wrote:
> Clean up two build warnings:
> 
> [1]
> 
> iou-zcrx.c: In function ‘process_recvzc’:
> iou-zcrx.c:263:37: warning: too many arguments for format [-Wformat-extra-args]
>   263 |                         error(1, 0, "payload mismatch at ", i);
>       |                                     ^~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: iou-zcrx: Clean up build warnings for error format
    https://git.kernel.org/netdev/net-next/c/953d9480f7d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



