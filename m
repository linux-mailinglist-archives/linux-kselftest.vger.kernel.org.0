Return-Path: <linux-kselftest+bounces-14461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B50940C55
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 10:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72E61C20EEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 08:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B07C194A7C;
	Tue, 30 Jul 2024 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faJf7yM4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C01940B3;
	Tue, 30 Jul 2024 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329438; cv=none; b=QnbzlM+os3jXf2jTzgrqF71+za+l6QZrGZ43Q6kp8l38W2CnCdCXHiqCgsX6fyMJKJXc3VN2bqanVAxkckWbnMVCHQ1aMZVp9m3RYtIoBFmSI9XwcwQkYxIkj4v7osvNWlqy0jrCl41O4ILi8+4Jcq2Eb64paiZOk9eqYRtvKwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329438; c=relaxed/simple;
	bh=7xEjnu+XxywJICOBC6mbxvdShii78kN4dRkz0XvgP/4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fcmk6gxT+lQXyClvR23bXhZt9f4oToFk92VfmRAdQ0J5oiwXE6taDYwi66pZrlFfvCsGKo0r+B8EemBKlVsrR8KknXcSYSY8LJUEZ9TCeNgxe7yb0Yco9xlqVnkrBWVbcrWOLMK4xgw2YbIz8DQIIFwKI+nBZN60Ciggb/Ptqng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faJf7yM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6148AC4AF0B;
	Tue, 30 Jul 2024 08:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722329437;
	bh=7xEjnu+XxywJICOBC6mbxvdShii78kN4dRkz0XvgP/4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=faJf7yM4pW/Z8oVEhOY0PK+6doI9ABS/OqbbgJ8IIBlA0uejeK9fyfJYCK2Y8uoIJ
	 XeHWOozrBdwiqcjqM9/LPcCk+ac0aWyaz9jE+zHJXuktyX/zkAg8MEUxJnRIkHKOCx
	 4g65iScziMyJM4vt7SbCyOcq/+7MBcvIp4eE6pX4wLTu4FEB3KTgNXi5a8eSwm4+px
	 5qtTgBm3FTVRuLUkC5I5gm47Z0QJ+eNTJJh3HQKCTusaFwtbW+g4CiDjKUUjd/FoA+
	 5Ve4ay9Ff4eQ9vTr42bD/1Al0YVRfvaeCP/knmx7ZIQhzBp3cGDJULprkEms7PCAJ4
	 TrSFL++L889CQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 512B0C43619;
	Tue, 30 Jul 2024 08:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/7] mptcp: fix inconsistent backup usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172232943732.24083.9277579847408417971.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jul 2024 08:50:37 +0000
References: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-0-f50b31604cf1@kernel.org>
In-Reply-To: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-0-f50b31604cf1@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 fw@strlen.de, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 27 Jul 2024 12:01:22 +0200 you wrote:
> In all the MPTCP backup related tests, the backup flag was set on one
> side, and the expected behaviour is to have both sides respecting this
> decision. That's also the "natural" way, and what the users seem to
> expect.
> 
> On the scheduler side, only the 'backup' field was checked, which is
> supposed to be set only if the other peer flagged a subflow as backup.
> But in various places, this flag was also set when the local host
> flagged the subflow as backup, certainly to have the expected behaviour
> mentioned above.
> 
> [...]

Here is the summary with links:
  - [net,1/7] mptcp: sched: check both directions for backup
    https://git.kernel.org/netdev/net/c/b6a66e521a20
  - [net,2/7] mptcp: distinguish rcv vs sent backup flag in requests
    https://git.kernel.org/netdev/net/c/efd340bf3d77
  - [net,3/7] mptcp: pm: only set request_bkup flag when sending MP_PRIO
    https://git.kernel.org/netdev/net/c/4258b94831bb
  - [net,4/7] mptcp: mib: count MPJ with backup flag
    https://git.kernel.org/netdev/net/c/4dde0d72ccec
  - [net,5/7] selftests: mptcp: join: validate backup in MPJ
    https://git.kernel.org/netdev/net/c/935ff5bb8a1c
  - [net,6/7] mptcp: pm: fix backup support in signal endpoints
    https://git.kernel.org/netdev/net/c/6834097fc38c
  - [net,7/7] selftests: mptcp: join: check backup support in signal endp
    https://git.kernel.org/netdev/net/c/f833470c2783

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



