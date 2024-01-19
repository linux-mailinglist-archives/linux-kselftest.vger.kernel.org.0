Return-Path: <linux-kselftest+bounces-3222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E624832370
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 03:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28236283709
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 02:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7496928E08;
	Fri, 19 Jan 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5xZ1PcE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF7528694;
	Fri, 19 Jan 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705632027; cv=none; b=CPnXyXQtubYGhxHSjDIh68/TV5OgkeslpIT1Y+LbEc10jIB8wrW/Bx1RAIb4RedwQoS8nWPDuHhqrQkbA4DBfSKlBDwIHuT9o67h+72Y3g6SfF0XX8t4PJKMWIp9t7Fmiqep9eOLSHo/2hiDwlL0eISCe3K0tO8B+m1jKJmyEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705632027; c=relaxed/simple;
	bh=N2PoJpyF/SCzb44WXtlMvpH3BCFPVcdqxnOojW9Qvzc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fAu1pElhmQwWk2WRuDGhyD204Tnvg925EJX/px2RhiTus91TiHz05IT0JALHmYtnvbHdxiQtGObBJ9u1sTogab1HhfZhzPg5NLz8GBBpc2JPN3sy6lg/vHK+rBYHXHieoiShveTuMysqg0L7lZcXNNAfY629WHOocDyky4Mu6EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5xZ1PcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28063C43330;
	Fri, 19 Jan 2024 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705632027;
	bh=N2PoJpyF/SCzb44WXtlMvpH3BCFPVcdqxnOojW9Qvzc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I5xZ1PcE3D2EpmDxiW+a0rD7DYxUWq5/RghcrQl/2bOK1I4HIZgnl6XUFYjaRfKOJ
	 VWAQAm3rPNpf+xdmdidAR8UDP5X1ScicTFQKzEzaa99qIlSqPh6ik9AUT6yxTYmae3
	 Raxo+hzWVXpJB/4AurXI4iHJbghqZA3sM3i6tc+/F8jtyPEcjW/Pq0LfWXfrNj9I+5
	 WGOW60Mqdyy+kgsadoO6eTsq6/Wz1SFWnLxZwZHwJTXkTtT4ARGVQ/5aniYJl1amYy
	 F4sTpv+Hom/4VnNm94chdC3uYFSnm9S5Xdw0XXZ1yZnttwahnkqarIrR/NxB5aHJr0
	 qsFL5OjeeHS/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10732D8C970;
	Fri, 19 Jan 2024 02:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: bonding: Increase timeout to 1200s
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170563202706.16011.14995129872521059655.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jan 2024 02:40:27 +0000
References: <20240118001233.304759-1-bpoirier@nvidia.com>
In-Reply-To: <20240118001233.304759-1-bpoirier@nvidia.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
 shuah@kernel.org, liali@redhat.com, liuhangbin@gmail.com, kuba@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 17 Jan 2024 19:12:32 -0500 you wrote:
> When tests are run by runner.sh, bond_options.sh gets killed before
> it can complete:
> 
> make -C tools/testing/selftests run_tests TARGETS="drivers/net/bonding"
> 	[...]
> 	# timeout set to 120
> 	# selftests: drivers/net/bonding: bond_options.sh
> 	# TEST: prio (active-backup miimon primary_reselect 0)                [ OK ]
> 	# TEST: prio (active-backup miimon primary_reselect 1)                [ OK ]
> 	# TEST: prio (active-backup miimon primary_reselect 2)                [ OK ]
> 	# TEST: prio (active-backup arp_ip_target primary_reselect 0)         [ OK ]
> 	# TEST: prio (active-backup arp_ip_target primary_reselect 1)         [ OK ]
> 	# TEST: prio (active-backup arp_ip_target primary_reselect 2)         [ OK ]
> 	#
> 	not ok 7 selftests: drivers/net/bonding: bond_options.sh # TIMEOUT 120 seconds
> 
> [...]

Here is the summary with links:
  - [net] selftests: bonding: Increase timeout to 1200s
    https://git.kernel.org/netdev/net/c/d7309c20ef3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



