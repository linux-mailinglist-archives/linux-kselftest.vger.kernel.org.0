Return-Path: <linux-kselftest+bounces-42080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 655C7B929D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 20:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 480CE7A817E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124DE31A05E;
	Mon, 22 Sep 2025 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCCeK5gF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D696D311940;
	Mon, 22 Sep 2025 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758566409; cv=none; b=D6YsyDPjVc5c2a/susX/hSjeawQu2BxnVKIZSwpsqoYE69V3bSgl2UI9U06WQpc8Ue73Pxr5/oQ2SY1kxZFT2PgVh6lhkSFW4RtBX0tBLyXNc489GLUyblYh+RCMuJRI3R7Mvy3jnPHHBlgVw+akqeb3civEYcanino+W+0l7I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758566409; c=relaxed/simple;
	bh=iQ8Rb4G1yxTHTIroTc9sy2bmogE7oGlyDYMo1IFFc6A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Aler4ZdLAOWIWilGMvA/SydDd6gzjLXKut7xZIKi6zmsIrtZYAqVhu+U1mZKHymvJcKjFel7+/h8bGbILS2DKLyp2ZxVMqDfsiqAnHP7R1qoTkZx5HwvcNN5jDzAkggMj/tAOSqldnfM8XHcoA5lyo4Irty6p2fIEfJ76e1f8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCCeK5gF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A98C4CEF5;
	Mon, 22 Sep 2025 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758566408;
	bh=iQ8Rb4G1yxTHTIroTc9sy2bmogE7oGlyDYMo1IFFc6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NCCeK5gFFxSwmexv4c4U7hnmYfVO3i8Erf21ohhidFtTEB1QjF6ir7uzwf5QTqfQt
	 tM83jnGARuoQnnOp4Fkx8D9LMP54rVk3u8/VxjS2SHadyAtcOyFJ9h0DQvzrQR3rST
	 hR9RQ3e259eYjTll/QX5rdOapUVbgtQGItg7BYOAY4CxmqvWy+gbqYR14caEtgh3f4
	 Vb86rA95IisZqVpL78pPHDlgnmRiJEJCSOO1mxNQsjY6E+V4ra7jf5Y5ejeggAID0/
	 LEXd8fzJK4u0hpqDY+RRb5vdRfHHCeQH6mVsEJDb5+XnlfZJEFJLddnDhkadiMCGki
	 axZpyy0IIygCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D1539D0C20;
	Mon, 22 Sep 2025 18:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests: forwarding: Reorder (ar)ping
 arguments
 to obey POSIX getopt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175856640626.1115890.11481273748881423232.git-patchwork-notify@kernel.org>
Date: Mon, 22 Sep 2025 18:40:06 +0000
References: <20250919053538.1106753-1-mmyangfl@gmail.com>
In-Reply-To: <20250919053538.1106753-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 petrm@nvidia.com, amcohen@nvidia.com, shuali@redhat.com,
 alessandro.zanni87@gmail.com, liuhangbin@gmail.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Sep 2025 13:35:33 +0800 you wrote:
> Quoted from musl wiki:
> 
>   GNU getopt permutes argv to pull options to the front, ahead of
>   non-option arguments. musl and the POSIX standard getopt stop
>   processing options at the first non-option argument with no
>   permutation.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: forwarding: Reorder (ar)ping arguments to obey POSIX getopt
    https://git.kernel.org/netdev/net-next/c/50d51cef555e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



