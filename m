Return-Path: <linux-kselftest+bounces-26560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C64CA3484A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 16:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D15597A1F52
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DEF18F2FC;
	Thu, 13 Feb 2025 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Crcp0V80";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="erq+gZpb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D244C7C;
	Thu, 13 Feb 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461580; cv=none; b=qIaPN1o/0SfSBGx3yUHJi43uUYLXuA46NnxU2Y74eHy6YfLSjqNsSDXp6YwYXZ3OI9+U21n7A39Mr93MlntYUMtdLA3x347BP+/xiM7fhpIOiWhqFZ0mAVwxhSoTNwBtIi61X+LZeisGkxdQy/f60IcYLbsK9iSMvGUmL4iZ+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461580; c=relaxed/simple;
	bh=gvUZcnnQ5S3I/6Ed9Im/T5u1wze2xU99aehyrFj4ZGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aj/F49WHKuf5Jgrg716MkQMoWn66MAa/Kp7cdGNZwvZeitzukNjeSvbk63ie3W0v/227+wLKxDfTjn+Og0ZRcUBQYIaTtDE730USzyVYG1co6b0BPq4NhJI8yDKDkvQTq+FyQjKk1W3e+th5snEnkX1uQ+GOJBGrgkXfcIPmBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Crcp0V80; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=erq+gZpb; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A812D1140105;
	Thu, 13 Feb 2025 10:46:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 13 Feb 2025 10:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739461574; x=
	1739547974; bh=flUcINtEEcqp3xh3oLozl64817tCecBtw4bDJgRumQM=; b=C
	rcp0V80x1cf0mq+BpDJSAYlErFSXbbhdvLiBBFJVaGKMfPih2bCOsnNSpeIAo2EM
	tHCKM4fekrRzm62x4Z2Ljy/qOIqE5vrY0YgtJ296dChT/plfDsybjU6+nfcgg4tF
	gK5kubDNE7ucFDKG4TcL4dRtERlYAuSjJTwppc/ytMJCPNLKCWKYdJS/AgXHgULG
	qLMBTW+7N47er+KX4GegfiKXXnPgKDa8DI6EyNMGPFgVcD2S/NxeFaGRziX8a3j4
	AvGg5+khktWWYSVIBg30O54OZVo/wOPydVTPhyINR/OVsnNhm7u+0KItz8xoUPwK
	jg26Q+tsyO5m0D6K3DwbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739461574; x=1739547974; bh=flUcINtEEcqp3xh3oLozl64817tCecBtw4b
	DJgRumQM=; b=erq+gZpbkIbDaZZuEIzUD7wvbwy8vVeVxjAGNsjd375/0HfE+4H
	hj/lwF/1RXPmws4Q3IskMOHPeXAkBGgZejqJSbzGIV8lc+bV1xRf3BdFUvzWCXj3
	jyUtSfS62C02TfTqumlBfjFhDdrRb23KhBKuD/F7QQuJV3JBYklEQ01MzllTNaWi
	oaz50IakiG7omIc+JrZ78SyreoW6MrBSqLzlnfioDE58ydwiQkFdvqwQLlnDO63S
	XVIURPfG67vKl8NggdO2lcbG9HO0fBRW+h4pJ/t4Ql6GPFindTxeuI4WeuqKfFCb
	uoCASrVthMaviR9jh+uJqjNJGUewdWGd3GA==
X-ME-Sender: <xms:xROuZy2mIyZeJDbj8B1k5QYFQC6NKBl_QDNzDTTCkc59OUNMWrSInA>
    <xme:xROuZ1FL7MMBa44A9pD_7PdXzHbldSZOGn38fYh5HkCY1mYeO-1sCH1WPpOSWyRvg
    PH1M03dp0hGhVUhVjA>
X-ME-Received: <xmr:xROuZ64vU1tDisaGoqwKxUqYia3WkAvhTbn3bQbgIXIccaC_IeI_CfFe4qu8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjeduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefh
    keegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtoh
    hnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:xROuZz0NjbwXMzJydHsm2742v2z4qALWwOm3wq8icwmkKBFdyHbd4Q>
    <xmx:xROuZ1E1c1gPBXYJGWxXLd6fpkC2YnrEmMzPSZDPb7eTQ_ttos-2aw>
    <xmx:xROuZ88VhxBCBghNvOXb0OPfZ6q0A9QnOqj4sJcDCFmGYvgLTXpzFQ>
    <xmx:xROuZ6nUjXZtrJM4B05ZutU4fPAGBCY4kxK_cwy1S63_mT1oblHUzA>
    <xmx:xhOuZwkmbS0PbxX_jvq7qHkyFKyWfYmY3Y1mXyxkUXeIYYaCdXdiT8Kv>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 10:46:13 -0500 (EST)
Date: Thu, 13 Feb 2025 16:46:11 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
	steffen.klassert@secunet.com, antony.antony@secunet.com,
	willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH net-next v19 00/26] Introducing OpenVPN Data Channel
 Offload
Message-ID: <Z64Tw02PO433bob8@hog>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
 <Z60wIRjw5Id1VTal@hog>
 <090524ac-724d-4915-8699-fe2ae736ab8c@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <090524ac-724d-4915-8699-fe2ae736ab8c@openvpn.net>

2025-02-13, 12:46:34 +0100, Antonio Quartulli wrote:
> On 13/02/2025 00:34, Sabrina Dubroca wrote:
> > Hello,
> > 
> > 2025-02-11, 01:39:53 +0100, Antonio Quartulli wrote:
> > > All minor and major reported problems have been finally addressed.
> > > Big thanks to Sabrina, who took the time to guide me through
> > > converting the peer socket to an RCU pointer.
> > 
> > Something is off (not sure if it's new to this version): if I use
> > test-tcp.sh to setup a set of interfaces and peers (I stop the test
> > just after setup to keep the environment alive), then remove all netns
> > with "ip -all netns delete", I expect all devices to go away, but they
> > don't. With debug messages enabled I'm seeing some activity from the
> > module ("tun0: sending keepalive to peer 3" and so on), and
> > ovpn_net_uninit/ovpn_priv_free never got called.
> 
> I can reproduce it. If later I rmmod ovpn I then get all the "Deleting peer"
> messages.
> So instances are not being purged on netns exit.
> 
> Will dive into it.

I think the socket holds a ref on the netns, so it's not getting
destroyed, simply "removed" from iproute's point of view. And the
socket isn't going away as long as it's used by a peer.

If I delete the peer(s) for the ovpn device and then the netns it was
in, the netns is fully removed, and the ovpn device is gone. Also no
issue if I delete the ovpn device before its netns, then everything is
destroyed as expected.

I'm not sure that can be solved, as least under the current refcount
scheme.

But I don't think there's a way to re-attach to that netns afterwards
if we wanted to clean up manually (something similar to "ip netns
attach <name> <pid>", but that won't work if whatever created the
socket is not running anymore -- as is the case with ovpn-cli).

> > 
> > [...]
> > > So there is NO risk of deadlock (and indeed nothing hangs), but I
> > > couldn't find a way to make the warning go away.
> > 
> > I've spotted another splat on strparser cleanup that looked like an
> > actual deadlock, but it's not very reproducible. Still looking into
> > it, but I'm not convinced it's ok to call strp_done (as is done from
> > ovpn_tcp_socket_detach) while under lock_sock, because AFAIU
> > cancel_work_sync(&strp->work) may be waiting for a work that needs to
> > lock the socket (cb.lock in do_strp_work). I guess tcp_tx_work would
> > have the same problem.
> 
> Will have a look here too.

The only ways I've managed to reproduce it is by using some ugly
kernel-side hacks to try to force that path being hit. Either forcing
the strp work to be queued just as we detach the socket (in
strp_stop), or this:

 - hack some code path to do a big sleep() under lock_sock(), to give
   me the time to do the next steps
 - ping over ovpn, or any other way to add packets on the receive
   socket
 - delete the peer for the sleeping socket (while it's still sleeping)

When that big sleep is over, strp_data_ready will kick off and queue
its worker (because at this point the socket lock is still owned),
then I think del_peer proceeds toward tcp_detach and I got the splat
below. So that's maybe a bit hard to trigger in real life (I don't
remember what I was doing the first time I got it, I think something
messing with the RCU stuff we discussed earlier).


[  922.681435][  T300] ======================================================
[  922.686247][  T300] WARNING: possible circular locking dependency detected
[  922.690971][  T300] 6.14.0-rc1-net-00276-g95f1f7ea224e-dirty #279 Tainted: G                 N
[  922.696584][  T300] ------------------------------------------------------
[  922.699697][  T300] kworker/1:2/300 is trying to acquire lock:
[  922.702105][  T300] ffff88800a662160 ((work_completion)(&strp->work)){+.+.}-{0:0}, at: start_flush_work+0x407/0xa50
[  922.705716][  T300] 
[  922.705716][  T300] but task is already holding lock:
[  922.707779][  T300] ffff8880113edd98 (sk_lock-AF_INET){+.+.}-{0:0}, at: ovpn_socket_release+0x8a/0x1a0
[  922.710238][  T300] 
[  922.710238][  T300] which lock already depends on the new lock.
[  922.710238][  T300] 
[  922.712628][  T300] 
[  922.712628][  T300] the existing dependency chain (in reverse order) is:
[  922.714443][  T300] 
[  922.714443][  T300] -> #1 (sk_lock-AF_INET){+.+.}-{0:0}:
[  922.716127][  T300]        __lock_acquire+0xc4d/0x1ee0
[  922.717250][  T300]        lock_acquire+0x1a9/0x500
[  922.718266][  T300]        lock_sock_nested+0x40/0xf0
[  922.719325][  T300]        strp_work+0x95/0x1e0
[  922.720240][  T300]        process_one_work+0xe28/0x1460
[  922.721307][  T300]        worker_thread+0x674/0xee0
[  922.722283][  T300]        kthread+0x3c3/0x760
[  922.723101][  T300]        ret_from_fork+0x46/0x80
[  922.723792][  T300]        ret_from_fork_asm+0x1a/0x30
[  922.724532][  T300] 
[  922.724532][  T300] -> #0 ((work_completion)(&strp->work)){+.+.}-{0:0}:
[  922.726038][  T300]        check_prev_add+0x1af/0x2400
[  922.726927][  T300]        validate_chain+0xdcf/0x1a10
[  922.727847][  T300]        __lock_acquire+0xc4d/0x1ee0
[  922.728721][  T300]        lock_acquire+0x1a9/0x500
[  922.729590][  T300]        start_flush_work+0x41a/0xa50
[  922.730434][  T300]        __flush_work+0xee/0x210
[  922.731213][  T300]        cancel_work_sync+0xb8/0xd0
[  922.732022][  T300]        strp_done.cold+0x51/0xcf
[  922.732830][  T300]        ovpn_tcp_socket_detach+0x28e/0x2de
[  922.733752][  T300]        ovpn_socket_release_kref+0x1ef/0x350
[  922.734713][  T300]        ovpn_socket_release+0xe7/0x1a0
[  922.735577][  T300]        ovpn_peer_remove_work+0x2b/0x90
[  922.736468][  T300]        process_one_work+0xe28/0x1460
[  922.737357][  T300]        worker_thread+0x674/0xee0
[  922.737985][  T300]        kthread+0x3c3/0x760
[  922.738545][  T300]        ret_from_fork+0x46/0x80
[  922.739177][  T300]        ret_from_fork_asm+0x1a/0x30
[  922.739846][  T300] 
[  922.739846][  T300] other info that might help us debug this:
[  922.739846][  T300] 
[  922.741159][  T300]  Possible unsafe locking scenario:
[  922.741159][  T300] 
[  922.742165][  T300]        CPU0                    CPU1
[  922.743055][  T300]        ----                    ----
[  922.743943][  T300]   lock(sk_lock-AF_INET);
[  922.744638][  T300]                                lock((work_completion)(&strp->work));
[  922.745786][  T300]                                lock(sk_lock-AF_INET);
[  922.746837][  T300]   lock((work_completion)(&strp->work));
[  922.747788][  T300] 
[  922.747788][  T300]  *** DEADLOCK ***
[  922.747788][  T300] 
[  922.748856][  T300] 4 locks held by kworker/1:2/300:
[  922.749474][  T300]  #0: ffff888008499b48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0xd80/0x1460
[  922.750588][  T300]  #1: ffffc90002527d30 ((work_completion)(&peer->remove_work)){+.+.}-{0:0}, at: process_one_work+0xddf/0x1460
[  922.751894][  T300]  #2: ffff8880113edd98 (sk_lock-AF_INET){+.+.}-{0:0}, at: ovpn_socket_release+0x8a/0x1a0
[  922.752983][  T300]  #3: ffffffff854de980 (rcu_read_lock){....}-{1:3}, at: start_flush_work+0x39/0xa50
[  922.754018][  T300] 
[  922.754018][  T300] stack backtrace:
[  922.754734][  T300] CPU: 1 UID: 0 PID: 300 Comm: kworker/1:2 Tainted: G                 N 6.14.0-rc1-net-00276-g95f1f7ea224e-dirty #279
[  922.754748][  T300] Tainted: [N]=TEST
[  922.754752][  T300] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[  922.754761][  T300] Workqueue: events ovpn_peer_remove_work
[  922.754779][  T300] Call Trace:
[  922.754785][  T300]  <TASK>
[  922.754791][  T300]  dump_stack_lvl+0xa5/0x100
[  922.754803][  T300]  print_circular_bug.cold+0x38/0x48
[  922.754820][  T300]  check_noncircular+0x2f2/0x3d0
[  922.754922][  T300]  check_prev_add+0x1af/0x2400
[  922.754942][  T300]  validate_chain+0xdcf/0x1a10
[  922.754991][  T300]  __lock_acquire+0xc4d/0x1ee0
[  922.755023][  T300]  lock_acquire+0x1a9/0x500
[  922.755104][  T300]  start_flush_work+0x41a/0xa50
[  922.755128][  T300]  __flush_work+0xee/0x210
[  922.755198][  T300]  cancel_work_sync+0xb8/0xd0
[  922.755211][  T300]  strp_done.cold+0x51/0xcf
[  922.755222][  T300]  ovpn_tcp_socket_detach+0x28e/0x2de
[  922.755237][  T300]  ovpn_socket_release_kref+0x1ef/0x350
[  922.755253][  T300]  ovpn_socket_release+0xe7/0x1a0
[  922.755268][  T300]  ovpn_peer_remove_work+0x2b/0x90
[  922.755282][  T300]  process_one_work+0xe28/0x1460
[  922.755330][  T300]  worker_thread+0x674/0xee0
[  922.755402][  T300]  kthread+0x3c3/0x760
[  922.755472][  T300]  ret_from_fork+0x46/0x80
[  922.755497][  T300]  ret_from_fork_asm+0x1a/0x30
[  922.755521][  T300]  </TASK>


And then come the hung task warnings:
 - del_peer waiting on the completion
 - strp waiting on lock_sock
 - peer cleanup/socket detach waiting on cancel_work_sync/strp

[ 1106.347400][   T39] INFO: task kworker/u16:0:11 blocked for more than 122 seconds.
[ 1106.348547][   T39]       Tainted: G                 N 6.14.0-rc1-net-00276-g95f1f7ea224e-dirty #279
[ 1106.349671][   T39] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1106.350748][   T39] task:kworker/u16:0   state:D stack:0     pid:11    tgid:11    ppid:2      task_flags:0x4208160 flags:0x00004000
[ 1106.352454][   T39] Workqueue: kstrp strp_work
[ 1106.353133][   T39] Call Trace:
[ 1106.353659][   T39]  <TASK>
[ 1106.354143][   T39]  __schedule+0xace/0x2620
[ 1106.360659][   T39]  schedule+0xd0/0x210
[ 1106.361266][   T39]  __lock_sock+0x137/0x230
[ 1106.365430][   T39]  lock_sock_nested+0xcb/0xf0
[ 1106.366173][   T39]  strp_work+0x95/0x1e0
[ 1106.366845][   T39]  process_one_work+0xe28/0x1460
[ 1106.369231][   T39]  worker_thread+0x674/0xee0
[ 1106.371594][   T39]  kthread+0x3c3/0x760
[ 1106.375692][   T39]  ret_from_fork+0x46/0x80
[ 1106.377040][   T39]  ret_from_fork_asm+0x1a/0x30
[ 1106.377851][   T39]  </TASK>
[ 1106.378355][   T39] INFO: task kworker/1:2:300 blocked for more than 122 seconds.
[ 1106.379590][   T39]       Tainted: G                 N 6.14.0-rc1-net-00276-g95f1f7ea224e-dirty #279
[ 1106.381079][   T39] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1106.382372][   T39] task:kworker/1:2     state:D stack:0     pid:300   tgid:300   ppid:2      task_flags:0x4208060 flags:0x00004000
[ 1106.384211][   T39] Workqueue: events ovpn_peer_remove_work
[ 1106.385072][   T39] Call Trace:
[ 1106.385648][   T39]  <TASK>
[ 1106.386139][   T39]  __schedule+0xace/0x2620
[ 1106.393518][   T39]  schedule+0xd0/0x210
[ 1106.394195][   T39]  schedule_timeout+0x18c/0x240
[ 1106.398840][   T39]  __wait_for_common+0x3e3/0x610
[ 1106.403079][   T39]  __flush_work+0x14f/0x210
[ 1106.406874][   T39]  cancel_work_sync+0xb8/0xd0
[ 1106.407519][   T39]  strp_done.cold+0x51/0xcf
[ 1106.408109][   T39]  ovpn_tcp_socket_detach+0x28e/0x2de
[ 1106.408851][   T39]  ovpn_socket_release_kref+0x1ef/0x350
[ 1106.409588][   T39]  ovpn_socket_release+0xe7/0x1a0
[ 1106.410271][   T39]  ovpn_peer_remove_work+0x2b/0x90
[ 1106.410973][   T39]  process_one_work+0xe28/0x1460
[ 1106.413075][   T39]  worker_thread+0x674/0xee0
[ 1106.416968][   T39]  kthread+0x3c3/0x760
[ 1106.419983][   T39]  ret_from_fork+0x46/0x80
[ 1106.421172][   T39]  ret_from_fork_asm+0x1a/0x30
[ 1106.421829][   T39]  </TASK>
[ 1106.422260][   T39] INFO: task ovpn-cli:1213 blocked for more than 122 seconds.
[ 1106.423215][   T39]       Tainted: G                 N 6.14.0-rc1-net-00276-g95f1f7ea224e-dirty #279
[ 1106.424451][   T39] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1106.425643][   T39] task:ovpn-cli        state:D stack:0     pid:1213  tgid:1213  ppid:514    task_flags:0x400100 flags:0x00000002
[ 1106.427145][   T39] Call Trace:
[ 1106.427610][   T39]  <TASK>
[ 1106.428005][   T39]  __schedule+0xace/0x2620
[ 1106.431820][   T39]  schedule+0xd0/0x210
[ 1106.432351][   T39]  schedule_timeout+0x18c/0x240
[ 1106.435050][   T39]  __wait_for_common+0x3e3/0x610
[ 1106.439809][   T39]  ovpn_nl_peer_del_doit+0x270/0x6e0
[ 1106.442825][   T39]  genl_family_rcv_msg_doit+0x1ea/0x2e0
[ 1106.445602][   T39]  genl_family_rcv_msg+0x3a7/0x5b0
[ 1106.450559][   T39]  genl_rcv_msg+0xb1/0x160
[ 1106.451154][   T39]  netlink_rcv_skb+0x13e/0x3d0
[ 1106.455220][   T39]  genl_rcv+0x29/0x40
[ 1106.455737][   T39]  netlink_unicast+0x491/0x730
[ 1106.457107][   T39]  netlink_sendmsg+0x77d/0xc00
[ 1106.458517][   T39]  ____sys_sendmsg+0x7c5/0xac0
[ 1106.461329][   T39]  ___sys_sendmsg+0x163/0x1b0
[ 1106.468146][   T39]  __sys_sendmsg+0x135/0x1d0
[ 1106.471564][   T39]  do_syscall_64+0x64/0x140
[ 1106.472173][   T39]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1106.472947][   T39] RIP: 0033:0x7faa76628e56
[ 1106.473558][   T39] RSP: 002b:00007ffe757311e0 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[ 1106.474674][   T39] RAX: ffffffffffffffda RBX: 00007faa7654f740 RCX: 00007faa76628e56
[ 1106.475715][   T39] RDX: 0000000000000000 RSI: 00007ffe75731270 RDI: 0000000000000003
[ 1106.476847][   T39] RBP: 00007ffe757311f0 R08: 0000000000000000 R09: 0000000000000000
[ 1106.477959][   T39] R10: 0000000000000000 R11: 0000000000000202 R12: 00005617490cf490
[ 1106.479064][   T39] R13: 00005617490d04f0 R14: 00007ffe75731270 R15: 0000561733d62d78
[ 1106.480175][   T39]  </TASK>
[ 1106.480646][   T39] INFO: lockdep is turned off.

-- 
Sabrina

