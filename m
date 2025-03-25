Return-Path: <linux-kselftest+bounces-29745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED97A70229
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 14:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8A0178E05
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57AC25A2BF;
	Tue, 25 Mar 2025 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpMnN8Ii"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8979F2580CD;
	Tue, 25 Mar 2025 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908807; cv=none; b=ooEnmovb0Em6sQZ3AegeNd0Ohu6f2+uoV0irEyySKGWYDUg3vN+DB0vrTp5cAgTaInrkr3Qxvd9F8qkGkolaPMqFcmRLC73nJZR3km20sUX2zvhOSI6gcBnZF8mmRIQWACgleRpkMGyG4jGw6rcx7A2225sXK253yqVIqhi+Umw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908807; c=relaxed/simple;
	bh=cK+5YAUzLq6jCKHW5OeuVB2g368h6AsALn6lCDxZysg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fhQZjT4+PpVpwsBvtgqXECQQ8m1LwS6HbuGCoypKYu95S5fSMwCOrQTlLbHC67gSMo8fY6B8eim7Srf52GtApCnD9tBBTrBTAzoTrQHT0n3+TN6dKTbH3OxDf+OH3y2SIyHAdS6q+ZfY1w9yJPMMByKNG/foJD5YTf/KjHCjM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpMnN8Ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFBCC4CEE4;
	Tue, 25 Mar 2025 13:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742908807;
	bh=cK+5YAUzLq6jCKHW5OeuVB2g368h6AsALn6lCDxZysg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WpMnN8IivBVyI7y/sbx70qAsbhiYfUPZoesYDqeHNxOeAPAUDFz6NX+Imca+YjU+V
	 gyGcHtm/ZhD8xFgTHIikddhriBS9ubWxYVFhbTU0PXvhxsWdYOQCLjGXXYxIGIPE3h
	 9acwbm+yfzl0brKBZ+nyygd5C/0nAy1i7hTvF4eRv4UIg6oICg0EOBa+Rm46ZLBpWt
	 ZSgu1SX0+U61Y4KoP3qiKMgIHhsw92lRp/mr8petY3DPcw8rTorHqsl7uq0c6SqAwY
	 u0yg3F23rzs2UorNoTzNILi8jD9gEZnUQa1+pGRT0Hb6ihJZycFNIHf0bh0PPG25Gm
	 U/TqcSFcm5Vag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA0380CFE7;
	Tue, 25 Mar 2025 13:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] selftests/net: Mixed select()+polling mode
 for TCP-AO tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174290884305.571725.8165425409134442696.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 13:20:43 +0000
References: <20250319-tcp-ao-selftests-polling-v2-0-da48040153d1@gmail.com>
In-Reply-To: <20250319-tcp-ao-selftests-polling-v2-0-da48040153d1@gmail.com>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 0x7f454c46@gmail.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Mar 2025 03:13:33 +0000 you wrote:
> Should fix flaky tcp-ao/connect-deny-ipv6 test.
> Begging pardon for the delay since the report and for sending it this
> late in the release cycle.
> 
> To: David S. Miller <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Simon Horman <horms@kernel.org>
> To: Shuah Khan <shuah@kernel.org>
> Cc: netdev@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] selftests/net: Print TCP flags in more common format
    https://git.kernel.org/netdev/net-next/c/65ffdf31be68
  - [net-next,v2,2/7] selftests/net: Provide tcp-ao counters comparison helper
    https://git.kernel.org/netdev/net-next/c/1fe4221093d1
  - [net-next,v2,3/7] selftests/net: Fetch and check TCP-MD5 counters
    https://git.kernel.org/netdev/net-next/c/5a0a3193f6c4
  - [net-next,v2,4/7] selftests/net: Add mixed select()+polling mode to TCP-AO tests
    https://git.kernel.org/netdev/net-next/c/3f36781e57b3
  - [net-next,v2,5/7] selftests/net: Print the testing side in unsigned-md5
    https://git.kernel.org/netdev/net-next/c/266ed1ace8ee
  - [net-next,v2,6/7] selftests/net: Delete timeout from test_connect_socket()
    https://git.kernel.org/netdev/net-next/c/1e1738faa2bb
  - [net-next,v2,7/7] selftests/net: Drop timeout argument from test_client_verify()
    https://git.kernel.org/netdev/net-next/c/edbac739e4d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



