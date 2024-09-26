Return-Path: <linux-kselftest+bounces-18388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685CC986FA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 11:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9866C1C22AA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D553F1A76D9;
	Thu, 26 Sep 2024 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfhdRUX4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA141547E4;
	Thu, 26 Sep 2024 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341827; cv=none; b=GdmXMBivdKCUx61mmpoPnLGjhsWYTYskac3XAmAulAYHrsW0N9S4bGjOrtWvC2WOW3U86I2SPcXKYIsBiikNj3lABseeGPhfRq7nddq3vCL2IO36VmuWBWXfkgYMbmtAbd4j+RTwIsx3/3lBu8W6DCdMiXcsd5uOiijzznOJsWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341827; c=relaxed/simple;
	bh=oDSeriEUHMJ5EJ3zEdHu8qvnrqs10FJsZfG88aRg6+c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eTm2C1njyzHA2iyX2fVdVHBIveyzzgyNxiTKFkqHr4p3OOBuFM0nqLqx45X42J0q2qiz5rRAsvxrQvy6lxwmHOVzT8qla0IxObPFd2F51TnewrdycsfZC+9B/KoUlVwwWKHxsJU1QUH9B0lZtIStH0TVDYzkNoWR4Q7gv+g903Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfhdRUX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4219AC4CEC5;
	Thu, 26 Sep 2024 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727341827;
	bh=oDSeriEUHMJ5EJ3zEdHu8qvnrqs10FJsZfG88aRg6+c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NfhdRUX4nCOVeBdit6eevs+wxzr9TqphLpJ45hrxO2+dsbKPO3pHINxJNV6v6GxBL
	 9YOBDpzuMGsJNXTrVSVeF4iJQbjPeW2yI7ex/L7+WlHrPA6iBSvu2lsbrN7IP9NiGM
	 PkAIuYw9Cvl4ug/GFH454OuQafuSwqgwLgCVR7zlnI0bDHeVibdK/GRc2zBK2IOgBv
	 hhhD5XZZ+w6zuo3AJF8yxPutQ6q95Fk7yw5IFW50TPrJp2cqdeIYvrgU71R6qmHIRb
	 +mstM8Oo/Qh2uTpCfUXgrQm529uDZfah8MQKtyMTzto1N5Zgh2Hy/vAZFSXPZsabFd
	 FKZ7d94QkqF3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB35E380DBF5;
	Thu, 26 Sep 2024 09:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests/net: packetdrill: increase timing tolerance in
 debug mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172734182977.1180162.839307650436527669.git-patchwork-notify@kernel.org>
Date: Thu, 26 Sep 2024 09:10:29 +0000
References: <20240919124412.3014326-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240919124412.3014326-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, sdf@fomichev.me, matttbe@kernel.org,
 linux-kselftest@vger.kernel.org, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 19 Sep 2024 08:43:42 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Some packetdrill tests are flaky in debug mode. As discussed, increase
> tolerance.
> 
> We have been doing this for debug builds outside ksft too.
> 
> [...]

Here is the summary with links:
  - [net] selftests/net: packetdrill: increase timing tolerance in debug mode
    https://git.kernel.org/netdev/net/c/72ef07554c5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



