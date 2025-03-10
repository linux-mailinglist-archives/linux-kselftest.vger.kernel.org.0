Return-Path: <linux-kselftest+bounces-28600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E664CA5973A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 15:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EEA93A5843
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 14:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6678222C327;
	Mon, 10 Mar 2025 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GiBQ17U/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7894B3EA76;
	Mon, 10 Mar 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616007; cv=none; b=exYyfiSXipYizusHRooofiH4Az/pPPvMjoarAqN5rc7hWLxjghTPJmcGWe4nM9rXhMaKRMGsqMxGiPIGDHAHIVoWH43BIUGHIMFhMoCfN/sD+sBILRINMenGMsoFR3NxmpRD5gVJt5kLlJijpVBvlsPlNLNTilrez8tYp5VcTt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616007; c=relaxed/simple;
	bh=DmtnAJrjBv1ZpYTymNL6mSXrRlM01YbV56c2e4VO4G0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=lgrQoge3bRb5k5o9H+e9+xftAddgZSKpJ+HK+64iVd2ZCRyHeVFMfo9cUIc5fNc4AVz3L2S7mFUxGr9dpC8CxGyE+ESxtb8YGzvC86f/avfoQ5EaaHDMUuKGs+FPZNTfHCZvuRk4ozoErDEEepcxSmBSSqfnOmAEOn8OklQ2J04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GiBQ17U/; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741615993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nWSoLiRTEl1DjXdOcd+TwPvgMZDQndPcdIRX20wh1e0=;
	b=GiBQ17U/f6AC0XSjR0DITgXAMHz4ntd+PlDK0JYqhVUprheNASdM9fPwfaBunJw68x4LNx
	kjqu0Qae29dGXRRPEuHzSMmVv5gSrYWcE8HmXVkP3KimqVviZaMo4ETZ3ASM9/IEdsFtjI
	bUKeTfpqPBiaGjukSrSpI8RCC/5JCI4=
Date: Mon, 10 Mar 2025 14:13:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <fe664471a8933c894ac98029bd704ccfb010eae3@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v2 1/3] bpf, sockmap: avoid using sk_socket
 after free
To: "Michal Luczaj" <mhal@rbox.co>, xiyou.wangcong@gmail.com,
 john.fastabend@gmail.com, jakub@cloudflare.com, martin.lau@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 sgarzare@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mrpre@163.com, cong.wang@bytedance.com,
 syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
In-Reply-To: <d2d3eff9-23df-4098-87cc-d0ad5fde6e1e@rbox.co>
References: <20250228055106.58071-1-jiayuan.chen@linux.dev>
 <20250228055106.58071-2-jiayuan.chen@linux.dev>
 <baeca627-e6f1-4d0a-aea5-fa31689edc4d@rbox.co>
 <78ee737400721758fa67b4f285e8ba61dc6b893b@linux.dev>
 <d2d3eff9-23df-4098-87cc-d0ad5fde6e1e@rbox.co>
X-Migadu-Flow: FLOW_OUT

March 10, 2025 at 9:08 PM, "Michal Luczaj" <mhal@rbox.co> wrote:



>=20
>=20On 3/10/25 12:36, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> March 7, 2025 at 5:45 PM, "Michal Luczaj" <mhal@rbox.co> wrote:
> >=20
>=20>  ...
> >=20
>=20> >=20
>=20> > BTW, lockdep (CONFIG_LOCKDEP=3Dy) complains about calling AF_UNIX=
's
> > >=20
>=20> >  read_skb() under RCU read lock.
> > >=20
>=20>=20
>=20>  My environment also has LOCKDEP enabled, but I didn't see similar
> >=20
>=20>  warnings.
> >=20
>=20>  Moreover, RCU assertions are typically written as:
> >=20
>=20>=20=20
>=20>=20
>=20>  WARN_ON_ONCE(!rcu_read_lock_held())
> >=20
>=20>=20=20
>=20>=20
>=20>  And when LOCKDEP is not enabled, rcu_read_lock_held() defaults to
> >=20
>=20>  returning 1. So, it's unlikely to trigger a warning due to an RCU =
lock
> >=20
>=20>  being held.
> >=20
>=20>=20=20
>=20>=20
>=20>  Could you provide more of the call stack?
> >=20
>=20
> Sure, bpf-next with this series applied, test_progs -t sockmap_basic:
>=20
>=20=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>=20
>=20[ BUG: Invalid wait context ]
>=20
>=206.14.0-rc3+ #111 Tainted: G OE
>=20
>=20-----------------------------
>=20
>=20test_progs/37755 is trying to lock:
>=20
>=20ffff88810d9bc3c0 (&u->iolock){+.+.}-{4:4}, at: unix_stream_read_skb+0=
x30/0x120
>=20
>=20other info that might help us debug this:
>=20
>=20context-{5:5}
>=20
>=201 lock held by test_progs/37755:
>=20
>=20 #0: ffffffff833700e0 (rcu_read_lock){....}-{1:3}, at: sk_psock_verdi=
ct_data_ready+0x3e/0x2a0
>=20
>=20stack backtrace:
>=20
>=20CPU: 13 UID: 0 PID: 37755 Comm: test_progs Tainted: G OE 6.14.0-rc3+ =
#111
>=20
>=20Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
>=20
>=20Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linu=
x 1.16.3-1-1 04/01/2014
>=20
>=20Call Trace:
>=20
>=20 dump_stack_lvl+0x68/0x90
>=20
>=20 lock_acquire+0xcf/0x2e0
>=20
>=20 __mutex_lock+0x9c/0xcc0
>=20
>=20 unix_stream_read_skb+0x30/0x120
>=20
>=20 sk_psock_verdict_data_ready+0x8d/0x2a0
>=20
>=20 unix_stream_sendmsg+0x232/0x640
>=20
>=20 __sys_sendto+0x1cd/0x1e0
>=20
>=20 __x64_sys_sendto+0x20/0x30
>=20
>=20 do_syscall_64+0x93/0x180
>=20
>=20 entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
Thanks, I got this stack too after enabling CONFIG_PROVE_LOCKING.
It seems that we can't call sleepable lock such as mutex_lock under rcu-l=
ocked context.
I'm working on it.

