Return-Path: <linux-kselftest+bounces-35262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C2ADE776
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 11:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A88174BE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 09:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FA7283FFF;
	Wed, 18 Jun 2025 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq7RJZUt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34D52836A3;
	Wed, 18 Jun 2025 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750240208; cv=none; b=GQKi4PvhwtWR6DTILxcHBnoLKaf1NOgUytu8sfEQzTzirOnUZCIhIsXFZrA4Wo2CzTAoxPvadRoEMpakWUaU7QudoYl89kcOUuGBNi6/lvGqyDZr1fEVtcP9KYZObvK7sMWqySEOiNfPvp0kYa039+Eg/wOObhsI2DrfyzqX8yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750240208; c=relaxed/simple;
	bh=soKC0MQXsCeUYvAW1ofKztAL2YR9lWwhjUadi7n4/6c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DGlf8zBrUAQhWTINMt85FMKAbOvba1Rt8UfseFCNXFAnJYIUAszTiWp7l737BjRr5abMX0jBGnRVMLKA0RBg7kvAPaIkZAGUK0aH6yUdaK30MPSCdBJScmFjlfFMWG/XlD/s4tzW610EnS3Sh2gb6YsQq/Ww/heRKGsKGzWlQY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq7RJZUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56248C4CEE7;
	Wed, 18 Jun 2025 09:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750240206;
	bh=soKC0MQXsCeUYvAW1ofKztAL2YR9lWwhjUadi7n4/6c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yq7RJZUtMbk9EkYgJ/lM48BgfqfQ7WQMN8kBarGlTzzVqDAVPzarJrh56nF1KUdqB
	 E1dMxv3fjjRZmUVqb2V/RFR5Mqpg6SS96wfB3HrPqouvYVMEvHi9losDUfowmjXV6R
	 B12nGGpOxLj8ZCeF/zIkDmwyeF0VLtFnBGtoWKbcWo0EMWSG/jI7x+SbSBtuseDVDi
	 1lzvJeW7huB7lLx1aGBBUZyOCG2fteA5EUyf525D+OMHZw8EYKyRJ42cqLOuFF02Nz
	 zKc02CSZOUdsD4mkjgVRcSSTYXtUiVVsZL/LCsqVXXPr3rrdvtSnbx857ip9cC/WWl
	 UyqwNKE0Df+5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE3239FEB77;
	Wed, 18 Jun 2025 09:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] netconsole: Add support for msgid in
 sysdata
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175024023475.40316.1054391502656210722.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 09:50:34 +0000
References: <20250616-netconsole-msgid-v3-0-4d2610577571@gmail.com>
In-Reply-To: <20250616-netconsole-msgid-v3-0-4d2610577571@gmail.com>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 horms@kernel.org, corbet@lwn.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 16 Jun 2025 10:08:34 -0700 you wrote:
> This patch series introduces a new feature to netconsole which allows
> appending a message ID to the userdata dictionary.
> 
> If the msgid feature is enabled, the message ID is built from a per-target 32
> bit counter that is incremented and appended to every message sent to the target.
> 
> Example::
>   echo 1 > "/sys/kernel/config/netconsole/cmdline0/userdata/msgid_enabled"
>   echo "This is message #1" > /dev/kmsg
>   echo "This is message #2" > /dev/kmsg
>   13,434,54928466,-;This is message #1
>    msgid=1
>   13,435,54934019,-;This is message #2
>    msgid=2
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] netconsole: introduce 'msgid' as a new sysdata field
    https://git.kernel.org/netdev/net-next/c/15b3c930a29f
  - [net-next,v3,2/5] netconsole: implement configfs for msgid_enabled
    https://git.kernel.org/netdev/net-next/c/53def0c4c857
  - [net-next,v3,3/5] netconsole: append msgid to sysdata
    https://git.kernel.org/netdev/net-next/c/c5efaabd45ad
  - [net-next,v3,4/5] selftests: netconsole: Add tests for 'msgid' feature in sysdata
    https://git.kernel.org/netdev/net-next/c/68707c079e58
  - [net-next,v3,5/5] docs: netconsole: document msgid feature
    https://git.kernel.org/netdev/net-next/c/8c587aa3fa54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



