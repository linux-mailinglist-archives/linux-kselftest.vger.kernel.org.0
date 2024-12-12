Return-Path: <linux-kselftest+bounces-23258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D549EE8BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 15:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A7318889F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 14:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0451B2147F7;
	Thu, 12 Dec 2024 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRmWxufZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BEF8837;
	Thu, 12 Dec 2024 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013656; cv=none; b=ZhsFqxNS5YXFNopP5w1tkw5nnPHSpxbx4qkjeAkJhLb/aSJW7tt0TukMlpaHqZ5TOHtfJoeg/fHEQF8xlRCruMkt/TBqBfBId7r9ucNI1tV01Z28/V4TA8Fizi7/+ZMe/MEWYddIFNiU14uG2IHY6MpjBmKdpfBqInDBxNfe5jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013656; c=relaxed/simple;
	bh=THwrYGXIiz69ULgUOChLfT0Apz1xdUGNa3VyZHWINTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pt6a5uTOENtKAUEInNbNHII3u1Dhd6+NPJbpKJJxHi7BCmqDjj3W55fteAcvtGaUfVRbgbIDxNpWtDVwdJwcwl2cbVzVOOlw910C0dmCoHJAgoO8Y4a1cA0cum6g3TgKbc9gD9Xqx4VwKc59o8PpuE03qDrL8/CObbt+EERlREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRmWxufZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE736C4CECE;
	Thu, 12 Dec 2024 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734013656;
	bh=THwrYGXIiz69ULgUOChLfT0Apz1xdUGNa3VyZHWINTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZRmWxufZnautQhP11I8b96kLloJChzCpdvI/AftPcxettZ8H9AuEZKL2Ui/HEUzve
	 pCcnWHp6hX/FJ5nhs4B2d0X+wg8m2w2udD36pKcvGyi1D8Ql4pwZfCV9B9F07ubHBl
	 D2TNVkRBnz+R2xVvXBHnpq+BDroDWbRFZAwtAIXNRyofbn8DZ2FVtLMAABIt5UKB1I
	 tSgYWP80ND9XfYTngB39aNOqdhmqe8bpyUsodRePyqbSI+axC5UHyq/JDktDqV+ISY
	 0jkk4auyl5L+A2AMFoJMU+7Mm6kRnZ9dhAqs9OAsXn/dLwww2AO/wMtFE75JpB9DG6
	 PStC2/SauN4dg==
Date: Thu, 12 Dec 2024 06:27:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
 <andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] bond: fix xfrm offload feature during init
Message-ID: <20241212062734.182a0164@kernel.org>
In-Reply-To: <20241211071127.38452-1-liuhangbin@gmail.com>
References: <20241211071127.38452-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 07:11:25 +0000 Hangbin Liu wrote:
> The first patch fixes the xfrm offload feature during setup active-backup
> mode. The second patch add a ipsec offload testing.

Looks like the test is too good, is there a fix pending somewhere for
the BUG below? We can't merge the test before that:

https://netdev-3.bots.linux.dev/vmksft-bonding-dbg/results/900082/11-bond-ipsec-offload-sh/stderr

[  859.672652][    C3] bond_xfrm_update_stats: eth0 doesn't support xdo_dev_state_update_stats
[  860.467189][ T8677] bond0: (slave eth0): link status definitely down, disabling slave
[  860.467664][ T8677] bond0: (slave eth1): making interface the new active one
[  860.831042][ T9677] bond_xfrm_update_stats: eth1 doesn't support xdo_dev_state_update_stats
[  862.195271][ T9683] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:562
[  862.195880][ T9683] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 9683, name: ip
[  862.196189][ T9683] preempt_count: 201, expected: 0
[  862.196396][ T9683] RCU nest depth: 0, expected: 0
[  862.196591][ T9683] 2 locks held by ip/9683:
[  862.196818][ T9683]  #0: ffff88800a829558 (&net->xfrm.xfrm_cfg_mutex){+.+.}-{4:4}, at: xfrm_netlink_rcv+0x65/0x90 [xfrm_user]
[  862.197264][ T9683]  #1: ffff88800f460548 (&x->lock){+.-.}-{3:3}, at: xfrm_state_flush+0x1b3/0x3a0
[  862.197629][ T9683] CPU: 3 UID: 0 PID: 9683 Comm: ip Not tainted 6.13.0-rc1-virtme #1
[  862.197967][ T9683] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  862.198204][ T9683] Call Trace:
[  862.198352][ T9683]  <TASK>
[  862.198458][ T9683]  dump_stack_lvl+0xb0/0xd0
[  862.198659][ T9683]  __might_resched+0x2f8/0x530
[  862.198852][ T9683]  ? kfree+0x2d/0x330
[  862.199005][ T9683]  __mutex_lock+0xd9/0xbc0
[  862.199202][ T9683]  ? ref_tracker_free+0x35e/0x910
[  862.199401][ T9683]  ? bond_ipsec_del_sa+0x2c1/0x790
[  862.199937][ T9683]  ? find_held_lock+0x2c/0x110
[  862.200133][ T9683]  ? __pfx___mutex_lock+0x10/0x10
[  862.200329][ T9683]  ? bond_ipsec_del_sa+0x280/0x790
[  862.200519][ T9683]  ? xfrm_dev_state_delete+0x97/0x170
[  862.200711][ T9683]  ? __xfrm_state_delete+0x681/0x8e0
[  862.200907][ T9683]  ? xfrm_user_rcv_msg+0x4f8/0x920 [xfrm_user]
[  862.201151][ T9683]  ? netlink_rcv_skb+0x130/0x360
[  862.201347][ T9683]  ? xfrm_netlink_rcv+0x74/0x90 [xfrm_user]
[  862.201587][ T9683]  ? netlink_unicast+0x44b/0x710
[  862.201780][ T9683]  ? netlink_sendmsg+0x723/0xbe0
[  862.201973][ T9683]  ? ____sys_sendmsg+0x7ac/0xa10
[  862.202164][ T9683]  ? ___sys_sendmsg+0xee/0x170
[  862.202355][ T9683]  ? __sys_sendmsg+0x109/0x1a0
[  862.202546][ T9683]  ? do_syscall_64+0xc1/0x1d0
[  862.202738][ T9683]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  862.202986][ T9683]  ? __pfx_nsim_ipsec_del_sa+0x10/0x10 [netdevsim]
[  862.203251][ T9683]  ? bond_ipsec_del_sa+0x2c1/0x790
[  862.203457][ T9683]  bond_ipsec_del_sa+0x2c1/0x790
[  862.203648][ T9683]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  862.203845][ T9683]  ? __pfx_bond_ipsec_del_sa+0x10/0x10
[  862.204034][ T9683]  ? do_raw_spin_lock+0x131/0x270
[  862.204225][ T9683]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  862.204468][ T9683]  xfrm_dev_state_delete+0x97/0x170
[  862.204665][ T9683]  __xfrm_state_delete+0x681/0x8e0
[  862.204858][ T9683]  xfrm_state_flush+0x1bb/0x3a0
[  862.205057][ T9683]  xfrm_flush_sa+0xf0/0x270 [xfrm_user]
[  862.205290][ T9683]  ? __pfx_xfrm_flush_sa+0x10/0x10 [xfrm_user]
[  862.205537][ T9683]  ? __nla_validate_parse+0x48/0x3d0
[  862.205744][ T9683]  xfrm_user_rcv_msg+0x4f8/0x920 [xfrm_user]
[  862.205985][ T9683]  ? __pfx___lock_release+0x10/0x10
[  862.206174][ T9683]  ? __pfx_xfrm_user_rcv_msg+0x10/0x10 [xfrm_user]
[  862.206412][ T9683]  ? __pfx_validate_chain+0x10/0x10
[  862.206614][ T9683]  ? hlock_class+0x4e/0x130
[  862.206807][ T9683]  ? mark_lock+0x38/0x3e0
[  862.206986][ T9683]  ? __mutex_trylock_common+0xfa/0x260
[  862.207181][ T9683]  ? __pfx___mutex_trylock_common+0x10/0x10
[  862.207425][ T9683]  netlink_rcv_skb+0x130/0x360

