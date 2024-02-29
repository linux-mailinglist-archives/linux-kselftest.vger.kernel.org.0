Return-Path: <linux-kselftest+bounces-5595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A847D86BFD0
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 05:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEBD1F24C79
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 04:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E656337719;
	Thu, 29 Feb 2024 04:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsthZo2Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD23D374DD;
	Thu, 29 Feb 2024 04:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709180429; cv=none; b=Cy5Zz9lNSmCkc7DFy6Peqfv6aZnEx48D0b88pB302/4sXNusP7xNTQX0tJGk1skbXbOzlVVbGdE0p0I0Pt6L8ZV5pT4+QAXim+/77fTjSaOH4B0BuHzX/5j9r9n44Y/DnnlO9oJKuTuhXFb1n9MitA+gJW9JnpvRaLG845cGHbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709180429; c=relaxed/simple;
	bh=QqzeG1NrYdDPAMf0+K+9yBSPa8LUBuBht6i82C8qOUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h2j65A1+0WwZbTWTRPEWaw9ZtrwMLOXrR/Zsp16rpxRCFDnB1dHK7vJ8boeTmd2TN04zU+G2sA3Z/6qy06UXiKliVrdb/XRCc9VAs8K7uWUnzxmY8EUt+UK8XDsHd7dqr+nXlh4hEWqHohYT9LCFjnOzhQUDhmaxL6toAjL118Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsthZo2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BD24C433B1;
	Thu, 29 Feb 2024 04:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709180429;
	bh=QqzeG1NrYdDPAMf0+K+9yBSPa8LUBuBht6i82C8qOUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hsthZo2ZjDMcSgumiQ4xApsPAw5J8rQ6Bsail0CdnBotiA03xJVvRNKroKu1lYbJ5
	 QiR6mb1fWhvVXN2Tx15a7pk/PjYohP17to6k6r+6AU0eVcH9PbrYZSGyCqYpNZWOgJ
	 IjQjWN2BWltTuNtmId7x5GbQLKJNsgHwjAL2J0HrHGs4rquBPBrXKB3RDPzY2sSC6o
	 mWmeNOxBZtb+uJW5LBPcIdfn4ZcO49IA8t2FIB4lefK6ldLnPw7x2aJrW9qT+FCj2Q
	 xHv8CIMI1v6TSsawB9Lkdfp7TByA8AfxlRQ7XN8ch9vQtxF23b4ByvD4JNrU/yvmDQ
	 Esav7nuX5PJvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22C73D990A7;
	Thu, 29 Feb 2024 04:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: vxlan_mdb: Avoid duplicate test names
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170918042913.11535.17909812451014874551.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 04:20:29 +0000
References: <20240227170418.491442-1-idosch@nvidia.com>
In-Reply-To: <20240227170418.491442-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 shuah@kernel.org, yujie.liu@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Feb 2024 19:04:18 +0200 you wrote:
> Rename some test cases to avoid overlapping test names which is
> problematic for the kernel test robot. No changes in the test's logic.
> 
> Suggested-by: Yujie Liu <yujie.liu@intel.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> Yujie Liu, please verify this works for you.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: vxlan_mdb: Avoid duplicate test names
    https://git.kernel.org/netdev/net-next/c/8a7746982ed7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



