Return-Path: <linux-kselftest+bounces-37138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4562B02320
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 19:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF49CA440AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 17:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1999C2F199A;
	Fri, 11 Jul 2025 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un5vH3Ov"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A612F0E59;
	Fri, 11 Jul 2025 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256196; cv=none; b=TUxMtw3+vO933vHT/OElj+g+/66nYcJ/VNHY2PLXxnDX5eXJjaA5R5STQ5rWI/hp4XKqv9kwZzkDiTBarUm9L5+gF97++9HjA93V+TXvQeZczCcOWhtlQdd8PjSdvNXWaFtUvIQkXfeRww11zE+yuIai57I9dQ4H2nrAs4p3Qf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256196; c=relaxed/simple;
	bh=/MkA07c+dWNbSLuFOP7iyIQHic2zDExuAjUmWhSOOhQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MxOO/pUlBAtWDwPa/yIL3wewXLLfpJ+jfMNrdicD4fMJZHaxe+KMnBqGKh86NxgJspTazqCJlSFFbWOkRAI3/XM5VCb802LB+y5OPlDBHJA67x9WS9/jD/kcqnVFs3VL2aSbw3oobTj5/eyZmrvHB4/o67PgvGV0fRJAN4Duv50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un5vH3Ov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574A4C4CEED;
	Fri, 11 Jul 2025 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752256195;
	bh=/MkA07c+dWNbSLuFOP7iyIQHic2zDExuAjUmWhSOOhQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Un5vH3OvTCpmFaFPoo9XKUkWb6U/VcoVFLkxaE1R0zNnV9isQ3CBiMJZ8hxHrCkVh
	 PQ59ofal99qxQoi2ERPb/+aLmAPszgBaNDSlXngaSUsLJfkP/GZ/5XATkq/XLnyEcb
	 tGGoj6ZPmHb8BnqPXiAGRnnHK6cLenY8+6F+xVUiBkUHuvMtT0qS0K4vqGfSsMVwOw
	 DQ6M3YBMYqtSOKC/SOiQthkbMwiOgZ5G6gfe/CLI3v35HyeIcpd9uXXJnrsCe+Q4KY
	 FZ0OY8KunHUaL/GaOKLY+ye0er/5RZyCoPWm6z2/mZHNqg7/AlRMGBasOKjEDbkoXN
	 rqWA4pW2CYJyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D36383B275;
	Fri, 11 Jul 2025 17:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/5] selftests: drv-net: Test XDP native
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175225621699.2353625.7561288622143737480.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 17:50:16 +0000
References: <20250710184351.63797-1-mohsin.bashr@gmail.com>
In-Reply-To: <20250710184351.63797-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, horms@kernel.org, cratiu@nvidia.com, noren@nvidia.com,
 cjubran@nvidia.com, mbloch@nvidia.com, jdamato@fastly.com, gal@nvidia.com,
 sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Jul 2025 11:43:46 -0700 you wrote:
> This patch series add tests to validate XDP native support for PASS,
> DROP, ABORT, and TX actions, as well as headroom and tailroom adjustment.
> For adjustment tests, validate support for both the extension and
> shrinking cases across various packet sizes and offset values.
> 
> The pass criteria for head/tail adjustment tests require that at-least
> one adjustment value works for at-least one packet size. This ensure
> that the variability in maximum supported head/tail adjustment offset
> across different drivers is being incorporated.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] selftests: drv-net: Add bpftool util
    https://git.kernel.org/netdev/net-next/c/a339dd699a7a
  - [net-next,2/5] selftests: drv-net: Test XDP_PASS/DROP support
    (no matching commit)
  - [net-next,3/5] selftests: drv-net: Test XDP_TX support
    (no matching commit)
  - [net-next,4/5] selftests: drv-net: Test tail-adjustment support
    (no matching commit)
  - [net-next,5/5] selftests: drv-net: Test head-adjustment support
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



