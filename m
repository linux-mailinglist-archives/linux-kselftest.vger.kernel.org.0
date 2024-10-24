Return-Path: <linux-kselftest+bounces-20544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2A79AE889
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 16:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF421F21208
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 14:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729AA1F669C;
	Thu, 24 Oct 2024 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Amt5/aYB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E5818A957;
	Thu, 24 Oct 2024 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779626; cv=none; b=F6xr9PVAB4109XoqLc4TQja7XesG7q0HZDzNAdvW7cs7TdiX8darqhqA+kkuA4XROvaB383OS2qWazzIo61CvdA6ulkBzokgmgU5eWCu+mR9NnoryXnKM8pjWlMl2mSt1+V+mKQnU2XpAUzFvO0dl+88r1ckF+W83zqK/pXVpf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779626; c=relaxed/simple;
	bh=LsE4I5BAU08czTQUbckblhpx9loz6yMCXJYom40bnDg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iD6Y2x57pg/kI5dJvmnYoLtoK/01dvLZ9068xiIQOLFqO528j6XbCZt57CQBZ/ngmCSiaPURm9R/453vfDSimZO6Im/vNzg4G9t06M1J5tHiJ8q8Iw/vN84vhF1M/HNde39ab6Qi1DAwPVnlGkbB9/wTEkoxAbB5UXnQshCQNA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Amt5/aYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6FDC4CEE4;
	Thu, 24 Oct 2024 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729779625;
	bh=LsE4I5BAU08czTQUbckblhpx9loz6yMCXJYom40bnDg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Amt5/aYBWQiEADi8s3vdNiBgFukAPa2ERv0UAMZ+KGaty6i+u6+2Rv61CreC6Axc9
	 4V2o1Ei0dDnnsTuYbIBkOyCIDPg4s9tDvs8KR1/mpZhPwKS9zBaEZyUMbEVtbYlWAc
	 7i29lcl0QkTKRyfBRGlXeVTrfQt/JwnsZPpLPYt83N/goF5XufF0LAs5snNmMsqN4/
	 b7tyqlr6fWbwAbStMJsrOCh4bNdtWzp3Sp8r/yKr55V0AUyuilf0Iy74DXWhROQa6x
	 ZLz+K4J2AcnvhQrfUKq3f4jIycuFeQ0n/aZovKsUDLjEIkt+nttLHrzX0X5VC2i7Pw
	 XdF3PU90B/rjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710AB380DBDC;
	Thu, 24 Oct 2024 14:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: tls: add a selftest for wrapping rec_seq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172977963201.2255496.11744635773632425765.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 14:20:32 +0000
References: <20775fcfd0371422921ee60a42de170c0398ac10.1729244987.git.sd@queasysnail.net>
In-Reply-To: <20775fcfd0371422921ee60a42de170c0398ac10.1729244987.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 18 Oct 2024 12:55:58 +0200 you wrote:
> Set the initial rec_seq to 0xffffffffffffffff so that it wraps
> immediately. The send() call should fail with EBADMSG.
> 
> A bug in this code was fixed in commit cfaa80c91f6f ("net/tls: do not
> free tls_rec on async operation in bpf_exec_tx_verdict()").
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: tls: add a selftest for wrapping rec_seq
    https://git.kernel.org/netdev/net-next/c/81bc949f640f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



