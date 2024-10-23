Return-Path: <linux-kselftest+bounces-20454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5839AC9E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 14:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0AF1283083
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B9D1AC42C;
	Wed, 23 Oct 2024 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmv2n/8r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1A1ABECB;
	Wed, 23 Oct 2024 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685990; cv=none; b=KpNuaY1avgEzq9haPx3YPU32JrIb2iUy/15yQByjMRc6bBHj7aNQP6AiqmkRLrM/PVMmITfczLC4gg+zoRMsX2GStAlhhmg2c1eHpnTo5aX/07beQBaE8ZMG55CywH/4G5ljbE5jJY4qUnjVE2R5ZYf3Z42lj099NupEvyFzbMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685990; c=relaxed/simple;
	bh=bHmIRav5p78QXwL8NtAQtzKAhGl1hwjcHaW1KtdCIZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZcpK/0KlqvHETZ1nz7Qclhn4hNqfYfpouspeEDmVoYogmWkSqO8Glc7G+LBUUZFRyHAYNP96TzkMfb7LMa5cML/O6tzk34WKiPnZqZl/8dg6rHl8MK90qpuNxUkVK8TCVzp6bAYOOy/XWHv+yBpiueqEtA9B5Afj3YXTgxzepc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmv2n/8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514EBC4CEC6;
	Wed, 23 Oct 2024 12:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729685990;
	bh=bHmIRav5p78QXwL8NtAQtzKAhGl1hwjcHaW1KtdCIZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jmv2n/8ryIThzxNHVTxpMfjpG8uVOugDTv0SpVyYn5mqpZFvF7ce5/ZtUjE1CK+kx
	 F0jv8YvMQ0p+g6e4jZY9rpsYWSRkf8MoNq5yTl5PC5cXTsjDHxsaf5u01cJjNooJbl
	 jiN7BmCwYcFVuBujNne6upnsofEAHEpMRXLMiYZ0Pn+ddLPVdBkBL9+kN3ca13ceOf
	 j5tPtewiAotnsedeIezPj2n+y2X+WOWOKU+PxO1tiGMN9sIlkhwHezEynZry5giU+j
	 Q6v1+7x/5BeaojvXFEqV7iDGYLvN9lhQWUq/7MqYBlCVlZJjinXrZGW8F0LU2sX12l
	 qF1j/Jd+bpcuA==
Date: Wed, 23 Oct 2024 13:19:45 +0100
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gregory Detal <gregory.detal@gmail.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/3] mptcp: init: protect sched with rcu_read_lock
Message-ID: <20241023121945.GS402847@kernel.org>
References: <20241021-net-mptcp-sched-lock-v1-0-637759cf061c@kernel.org>
 <20241021-net-mptcp-sched-lock-v1-1-637759cf061c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-net-mptcp-sched-lock-v1-1-637759cf061c@kernel.org>

On Mon, Oct 21, 2024 at 12:25:26PM +0200, Matthieu Baerts (NGI0) wrote:
> Enabling CONFIG_PROVE_RCU_LIST with its dependence CONFIG_RCU_EXPERT
> creates this splat when an MPTCP socket is created:
> 
>   =============================
>   WARNING: suspicious RCU usage
>   6.12.0-rc2+ #11 Not tainted
>   -----------------------------
>   net/mptcp/sched.c:44 RCU-list traversed in non-reader section!!
> 
>   other info that might help us debug this:
> 
>   rcu_scheduler_active = 2, debug_locks = 1
>   no locks held by mptcp_connect/176.
> 
>   stack backtrace:
>   CPU: 0 UID: 0 PID: 176 Comm: mptcp_connect Not tainted 6.12.0-rc2+ #11
>   Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
>   Call Trace:
>    <TASK>
>    dump_stack_lvl (lib/dump_stack.c:123)
>    lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822)
>    mptcp_sched_find (net/mptcp/sched.c:44 (discriminator 7))
>    mptcp_init_sock (net/mptcp/protocol.c:2867 (discriminator 1))
>    ? sock_init_data_uid (arch/x86/include/asm/atomic.h:28)
>    inet_create.part.0.constprop.0 (net/ipv4/af_inet.c:386)
>    ? __sock_create (include/linux/rcupdate.h:347 (discriminator 1))
>    __sock_create (net/socket.c:1576)
>    __sys_socket (net/socket.c:1671)
>    ? __pfx___sys_socket (net/socket.c:1712)
>    ? do_user_addr_fault (arch/x86/mm/fault.c:1419 (discriminator 1))
>    __x64_sys_socket (net/socket.c:1728)
>    do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1))
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> 
> That's because when the socket is initialised, rcu_read_lock() is not
> used despite the explicit comment written above the declaration of
> mptcp_sched_find() in sched.c. Adding the missing lock/unlock avoids the
> warning.
> 
> Fixes: 1730b2b2c5a5 ("mptcp: add sched in mptcp_sock")
> Cc: stable@vger.kernel.org
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/523
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

