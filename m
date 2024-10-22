Return-Path: <linux-kselftest+bounces-20385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFFB9AA15E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 13:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572451F23CDF
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFABD19B5B2;
	Tue, 22 Oct 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmZxp+Kn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4EA45026;
	Tue, 22 Oct 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597826; cv=none; b=uQdUFAG56P77anWYH+O43/5DpWbr/gaW7PKRj+sln3VGolwJ0hdtSOqRtF207D9ZhxR80r90TEM6oUh0c0fIEem415tqK8iyoh5FE00bTWOIutahlj7bAanuaEmoGhrQ6QilWmeCMhyEw2+Cz1yFjNZYRyuUGPKWYV5Z2FtjWXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597826; c=relaxed/simple;
	bh=ePIKOQ17IOxRynZ7Lysj39uHoOsCMlQxkrG15XbYY8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GIkSnPBmbaFAQG4AzqfKXXkKZNjygJI5phby3Z6O5cwXzO/rM3NhPCQP0UB9xzDCTXzvps4Cck2Myk3dzhG8kFspZJZDWmDFlCmuGXXQozIadVxh7LhWmMNMLtx32TDT2Wh809KhgB7XLOoeItTPfIsxynIBxGN8THQBP2GN2eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmZxp+Kn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C483C4CEC3;
	Tue, 22 Oct 2024 11:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729597826;
	bh=ePIKOQ17IOxRynZ7Lysj39uHoOsCMlQxkrG15XbYY8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dmZxp+KnE/gL7fjp2rOiXsUmgPPXQGKuZ1LiV6hpi8n3R6mPny1JFUzYHkbEMRnJv
	 hsIxEOsnMRPYfP3MMUW0IeHG06xZpNvmVu5jaRk9kVkumE27gFd5rA/eQus/2MwSke
	 sRQvE1TPccAb91hAmdfJGYIbOyQVlz/YTCQNPpZDzmsSPgbILxCHjdSyUTRdUJNKNG
	 v/OVzxKhfKRIezyJ/9f2fzxeSATLXNbHTfHV8ZKqCdswcj/RldI2bTL4arko04+ERY
	 WRFRve+LiyeYaMwMotTLL5Rseosfel0nVd7rFBYZYNL7b7vbxKjRa9j6OhvWyOm5pY
	 nr6iEv0TV5r1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE5D3809A8A;
	Tue, 22 Oct 2024 11:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/10] selftests: net: Introduce deferred commands
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172959783250.942320.16165385423521166401.git-patchwork-notify@kernel.org>
Date: Tue, 22 Oct 2024 11:50:32 +0000
References: <cover.1729157566.git.petrm@nvidia.com>
In-Reply-To: <cover.1729157566.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, bpoirier@nvidia.com, liuhangbin@gmail.com,
 vladimir.oltean@nxp.com, idosch@nvidia.com, przemyslaw.kitszel@intel.com,
 willemb@google.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Oct 2024 11:45:42 +0200 you wrote:
> Recently, a defer helper was added to Python selftests. The idea is to keep
> cleanup commands close to their dirtying counterparts, thereby making it
> more transparent what is cleaning up what, making it harder to miss a
> cleanup, and make the whole cleanup business exception safe. All these
> benefits are applicable to bash as well, exception safety can be
> interpreted in terms of safety vs. a SIGINT.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/10] selftests: net: lib: Introduce deferred commands
    https://git.kernel.org/netdev/net-next/c/a6e263f125cd
  - [net-next,v2,02/10] selftests: forwarding: Add a fallback cleanup()
    https://git.kernel.org/netdev/net-next/c/b4b0549a4e59
  - [net-next,v2,03/10] selftests: forwarding: lib: Allow passing PID to stop_traffic()
    https://git.kernel.org/netdev/net-next/c/0e07d5dbfbd9
  - [net-next,v2,04/10] selftests: RED: Use defer for test cleanup
    (no matching commit)
  - [net-next,v2,05/10] selftests: TBF: Use defer for test cleanup
    https://git.kernel.org/netdev/net-next/c/a1b3741dcfd1
  - [net-next,v2,06/10] selftests: ETS: Use defer for test cleanup
    (no matching commit)
  - [net-next,v2,07/10] selftests: mlxsw: qos_mc_aware: Use defer for test cleanup
    (no matching commit)
  - [net-next,v2,08/10] selftests: mlxsw: qos_ets_strict: Use defer for test cleanup
    https://git.kernel.org/netdev/net-next/c/424745af5271
  - [net-next,v2,09/10] selftests: mlxsw: qos_max_descriptors: Use defer for test cleanup
    https://git.kernel.org/netdev/net-next/c/919419a8870b
  - [net-next,v2,10/10] selftests: mlxsw: devlink_trap_police: Use defer for test cleanup
    https://git.kernel.org/netdev/net-next/c/cebd281f3c75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



