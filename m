Return-Path: <linux-kselftest+bounces-42644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B32BAE6DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 21:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF071944F0C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 19:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC9628643B;
	Tue, 30 Sep 2025 19:19:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4177628506B;
	Tue, 30 Sep 2025 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759259960; cv=none; b=owLkDvuNmTlTqJvGYmG2r/CqWEZ5EXj/kegH72fOWLF2y5qh0lY1FQw0kshNO2t9HUZmfZf2MbEfFnAL5Oy7x3H+QEylmYsVjjodujHBV5dvl4cFI6ncrRdNnl0xDYgu48nSyBcWZUwkqoWuMIHRD0wLIMV+uosKLZy7XIZUdvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759259960; c=relaxed/simple;
	bh=9MtwccQzyG79EXlHNlxXv9sOrdush53tWJ37W4IynnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyspokJVOmDUfAl63iUR24/rjI0fdhvywg/B15fOTUF2TiIEIoRDijSfDk+tDlz6j+KxKR+aAzwvfIKlIBlgQDXoInmCyCkZ8nlvubB/LDX4mrAwXY5VA8uscwOKIIOESuTbmEpeEJPynxvANdZm7o9XZ6trhUZYqpK7hbPhaok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D29D460326; Tue, 30 Sep 2025 21:19:14 +0200 (CEST)
Date: Tue, 30 Sep 2025 21:19:14 +0200
From: Florian Westphal <fw@strlen.de>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v3 nf-next] selftests: netfilter: Add
 bridge_fastpath.sh
Message-ID: <aNwtMiC22yOAO4Y6@strlen.de>
References: <20250925183341.115008-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925183341.115008-1-ericwouds@gmail.com>

Eric Woudstra <ericwouds@gmail.com> wrote:
> Add a script to test various scenarios where a bridge is involved
> in the fastpath. It runs tests in the forward path, and also in
> a bridged path.

Why is this still an RFC, what is missing to appy this?

Also:

PASS:  forward,        without vlan-device, without vlan encap, client1, without fastpath

net/bridge/br_private.h:1627 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
7 locks held by socat/410:
 #0: ffff88800d7a9c90 (sk_lock-AF_INET){+.+.}-{0:0}, at: inet_stream_connect+0x43/0xa0
 #1: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: __ip_queue_xmit+0x62/0x1830
 #2: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: ip_output+0x57/0x3c0
 #3: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: ip_finish_output2+0x263/0x17d0
 #4: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: process_backlog+0x38a/0x14b0
 #5: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: netif_receive_skb_internal+0x83/0x330
 #6: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: nf_hook.constprop.0+0x8a/0x440

stack backtrace:
CPU: 0 UID: 0 PID: 410 Comm: socat Not tainted 6.17.0-rc7-virtme #1 PREEMPT(full)
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 <IRQ>
 dump_stack_lvl+0x6f/0xb0
 lockdep_rcu_suspicious.cold+0x4f/0xb1
 br_vlan_fill_forward_path_pvid+0x32c/0x410 [bridge]
 br_fill_forward_path+0x7a/0x4d0 [bridge]
 ...

I did not see a mention of this, nor a bug fix.

Its a pre-existing bug, br_vlan_fill_forward_path_pvid uses
br_vlan_group() instead of _rcu version.

Will you send a patch for this?

