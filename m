Return-Path: <linux-kselftest+bounces-17769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDE7975D35
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 00:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9A81F228BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 22:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D201509AF;
	Wed, 11 Sep 2024 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T09dSuDV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9E7224CF;
	Wed, 11 Sep 2024 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093830; cv=none; b=XCq8s2MfDXS1Txki2kA3S5KpXtMO4OkSosWIoxaEIAHAG3Y7ISOIunWAXVFqo0F5WUCIgsSPR/1iySCQhNTkdpdhbBWrR19Qd10dBC46S132yAWxOP9yUBvE2D+JSx0ELumX2N6iIEuSgDbH5I5zERLQ2fzbpQCWE9lvyrpzgtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093830; c=relaxed/simple;
	bh=9CY7jtiBhyePSX79v/9ohwRq9HgavX2rGlMwlGxscd0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gJftPhebrXFbcQyYKsk/goN4n3aiki1+kJjLirbsjgzckVUgGTG/k4lnxn95PQlY44PAuvMMd3MGD1BoxfC5Ogio0vHoiV7JitpaiAVr4vrGsvReEj+PyKMBAVTGsw7GilwD/YFOBfVqDeiY6yoqrH8T3IM88sfrIObl9I+GUTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T09dSuDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE67C4CEC0;
	Wed, 11 Sep 2024 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726093829;
	bh=9CY7jtiBhyePSX79v/9ohwRq9HgavX2rGlMwlGxscd0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T09dSuDVfXTXLXyPX/PYSlJS8rQOJqPKUmkttN7s8u3oHDbkVQ+UZ+a/MjQHUxb1m
	 4kmJUapHfZwGp7rnxo+fASXtisrz2Qus1BnysPIxZc1qtKKuF90EzUp3Dnj/MnqvAI
	 IxKpQ8BXd0i4d4d0GXlT0+RIIjtyl4IwPiem3eYVC/AoCpkugMRp9EZ+aS9/QXfZZQ
	 /JFM1jSgKg4BVozTUgWOgHKhGZWEqIb8QTYA7zmOYOtPGTtkPWUz57MpbGoWwwQ0Vd
	 vaF8rfYo23jDH+3o+m/+0lZKMknDyP0aM1JBOJPHZZjPQ4xvo2XMiy4fnyiHnJvCoI
	 d42Ij0O3OJCEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E373806656;
	Wed, 11 Sep 2024 22:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] selftests: mptcp: misc. small fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172609383002.1065358.12169361654383136843.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 22:30:30 +0000
References: <20240910-net-selftests-mptcp-fix-install-v1-0-8f124aa9156d@kernel.org>
In-Reply-To: <20240910-net-selftests-mptcp-fix-install-v1-0-8f124aa9156d@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Sep 2024 21:06:35 +0200 you wrote:
> Here are some various fixes for the MPTCP selftests.
> 
> Patch 1 fixes a recently modified test to continue to work as expected
> on older kernels. This is a fix for a recent fix that can be backported
> up to v5.15.
> 
> Patch 2 and 3 include dependences when exporting or installing the
> tests. Two fixes for v6.11-rc1.
> 
> [...]

Here is the summary with links:
  - [net,1/3] selftests: mptcp: join: restrict fullmesh endp on 1st sf
    https://git.kernel.org/netdev/net/c/49ac6f05ace5
  - [net,2/3] selftests: mptcp: include lib.sh file
    https://git.kernel.org/netdev/net/c/1a5a2d19e827
  - [net,3/3] selftests: mptcp: include net_helper.sh file
    https://git.kernel.org/netdev/net/c/c66c08e51b55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



