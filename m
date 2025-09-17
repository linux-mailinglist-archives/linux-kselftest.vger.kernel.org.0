Return-Path: <linux-kselftest+bounces-41789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2BAB8223E
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 00:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB453A8B5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 22:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3954F306490;
	Wed, 17 Sep 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH2U7y/h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A40A55;
	Wed, 17 Sep 2025 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758147613; cv=none; b=A9xl5JNEiGS0h8Oj7KTMDStvQ6/0djEYJUHOKP+fPd9nrOFbvkdKVaZGZpmjG4A16RJhGsj3hjr0FmvqIl16feXlJ8oFLdHADBRn6uisKsybt3c9vSZpXmelsQd6thDOmzCET+E41Jdov5NDL6XYknZdYcToYkf+lJsFP5ewNsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758147613; c=relaxed/simple;
	bh=o4PfQuf9sUzclCOUfQzaMOkovu5+0f7s4YkkE/laiiw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S/tZqIAfCDQG0cQWmG5lY45YVXK1NJCCpKZcU8/gLY7Nf0tgJDkOOsT4S4hmCVNkejYUoo2A25/ge9e5IATglyyChV3/217FyBypAG/8eJHwgL18IunxjuWml6YsxGXKbQuaxbYYKeXDcxUQxSJFzd0vir2dbbVhq9pQ5c1B/1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZH2U7y/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E3FC4CEE7;
	Wed, 17 Sep 2025 22:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758147611;
	bh=o4PfQuf9sUzclCOUfQzaMOkovu5+0f7s4YkkE/laiiw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZH2U7y/hFvjLa8bDwjnVnVpLm8nWY7E6Hm/EmN8QcnFjG54+sJPfbQ6qqE+PZGmt5
	 UgQVbjUAxMQPdY92323C+5Ymv23/ZEBE2OfvQ/GLiMEWcmKwhTB7aaT9EkTKi77EqI
	 VZpGYS0qLB/HjboCcmjqPJ2ir8UkRp3/4ArEHSFjn2AKWhwK6RHIcfWr8JMBwwm4Ki
	 CXPWWLHso1NIeFBHb0CazgbZ9l9/DW2UBhpjkAxhX3FXe488LyWoETsYIm+TrWiHa8
	 ujHafXbg3Y5MLLMJdYwxbigrhDD+dwnJrrl6loDW//550NSWguv4P5H4m4gjxaAKku
	 hMBALD39Uqh7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DDE39D0C3D;
	Wed, 17 Sep 2025 22:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 net 1/2] bonding: don't set oif to bond dev when getting
 NS
 target destination
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175814761201.2168096.8321259039985302148.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 22:20:12 +0000
References: <20250916080127.430626-1-liuhangbin@gmail.com>
In-Reply-To: <20250916080127.430626-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 wilder@us.ibm.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Sep 2025 08:01:26 +0000 you wrote:
> Unlike IPv4, IPv6 routing strictly requires the source address to be valid
> on the outgoing interface. If the NS target is set to a remote VLAN interface,
> and the source address is also configured on a VLAN over a bond interface,
> setting the oif to the bond device will fail to retrieve the correct
> destination route.
> 
> Fix this by not setting the oif to the bond device when retrieving the NS
> target destination. This allows the correct destination device (the VLAN
> interface) to be determined, so that bond_verify_device_path can return the
> proper VLAN tags for sending NS messages.
> 
> [...]

Here is the summary with links:
  - [PATCHv4,net,1/2] bonding: don't set oif to bond dev when getting NS target destination
    https://git.kernel.org/netdev/net/c/a8ba87f04ca9
  - [PATCHv4,net,2/2] selftests: bonding: add vlan over bond testing
    https://git.kernel.org/netdev/net/c/dc5f94b1ec8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



