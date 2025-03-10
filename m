Return-Path: <linux-kselftest+bounces-28598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1200A5959E
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 14:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39978188F7EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 13:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9AE22A4E9;
	Mon, 10 Mar 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="A8BFc6kb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1570022576C;
	Mon, 10 Mar 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612128; cv=none; b=hIirzFdTdKnW4nESTe8u1fqLr0RU+fCyIW/cEM3QedI+9iiqKwXG6gLVwG2JyM2EICBM8MBhC4esv0Fm9LyD+y8xCv3l3S6ty+wN5FFnjZ2wmDkL2bDZ/eovdXAybur8KpstUjrOtPNi2UFymHMcWO5YQyY31I1li4sB10E06aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612128; c=relaxed/simple;
	bh=rdAP5tZXO/e6X0g9/aj7v6Q8fYYTM/HQGTEow6hWTxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CF5/1JXXEQXRdxOIoDLkEDIa4pMPxBP94/vvqP+nEcDc+Qzci4/+nSrMkDj0xcUrNTqkhHmkSOOpojhvcHcqouT5fxODaRzCw6SQtYRY8zgdRIrB2w2MPReqFAHv43omfKOw81wD3zKRexB6HfF87RhusUxdk/rrUGNj+d5yH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=A8BFc6kb; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1trcrp-00Brbe-7O; Mon, 10 Mar 2025 14:08:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=YMtG22Pqun0Tp+q9j4j91l8TFa4W5ET+k4wRnt7+fP0=; b=A8BFc6kbFm87pNoML1HwqDmRTf
	UJA/GzevYwKdN5F5BZrgi//pgOyudJoiTj1cK1jqvTlnhZursG3xtzsBooyMMx4vLOx+Py6kxhz8u
	hIEVjCM4oc8/5KNIerC9JWvKACQGvBa3WFWLxq6inZH8tyNEnNemy3BsVbvmoAWRn+/snlLvSHaXk
	ddO8bi7iUrcF5CFLUzM58GA01OsGXH138lYeRHo1EjItfLMyknx62msIBc85WDunVEuay4pTlM87c
	oHaOor4nkaHnadScKgfH3p4cxyNGqYOaGlUCpKQVr2CTHSgJL4J7b442qLYS5+VhMNWyP9iroaqxJ
	2zf7qkeA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1trcrc-0006oZ-M9; Mon, 10 Mar 2025 14:08:13 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1trcrZ-007B3j-Vc; Mon, 10 Mar 2025 14:08:10 +0100
Message-ID: <d2d3eff9-23df-4098-87cc-d0ad5fde6e1e@rbox.co>
Date: Mon, 10 Mar 2025 14:08:07 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] bpf, sockmap: avoid using sk_socket after
 free
To: Jiayuan Chen <jiayuan.chen@linux.dev>, xiyou.wangcong@gmail.com,
 john.fastabend@gmail.com, jakub@cloudflare.com, martin.lau@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, sgarzare@redhat.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mrpre@163.com, cong.wang@bytedance.com,
 syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
References: <20250228055106.58071-1-jiayuan.chen@linux.dev>
 <20250228055106.58071-2-jiayuan.chen@linux.dev>
 <baeca627-e6f1-4d0a-aea5-fa31689edc4d@rbox.co>
 <78ee737400721758fa67b4f285e8ba61dc6b893b@linux.dev>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <78ee737400721758fa67b4f285e8ba61dc6b893b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 12:36, Jiayuan Chen wrote:
> March 7, 2025 at 5:45 PM, "Michal Luczaj" <mhal@rbox.co> wrote:
> ...
>> BTW, lockdep (CONFIG_LOCKDEP=y) complains about calling AF_UNIX's
>> read_skb() under RCU read lock.
>>
> My environment also has LOCKDEP enabled, but I didn't see similar
> warnings.
> Moreover, RCU assertions are typically written as:
> 
> WARN_ON_ONCE(!rcu_read_lock_held())
> 
> And when LOCKDEP is not enabled, rcu_read_lock_held() defaults to
> returning 1. So, it's unlikely to trigger a warning due to an RCU lock
> being held.
> 
> Could you provide more of the call stack?

Sure, bpf-next with this series applied, test_progs -t sockmap_basic:

=============================
[ BUG: Invalid wait context ]
6.14.0-rc3+ #111 Tainted: G           OE
-----------------------------
test_progs/37755 is trying to lock:
ffff88810d9bc3c0 (&u->iolock){+.+.}-{4:4}, at: unix_stream_read_skb+0x30/0x120
other info that might help us debug this:
context-{5:5}
1 lock held by test_progs/37755:
 #0: ffffffff833700e0 (rcu_read_lock){....}-{1:3}, at: sk_psock_verdict_data_ready+0x3e/0x2a0
stack backtrace:
CPU: 13 UID: 0 PID: 37755 Comm: test_progs Tainted: G           OE      6.14.0-rc3+ #111
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
Call Trace:
 dump_stack_lvl+0x68/0x90
 lock_acquire+0xcf/0x2e0
 __mutex_lock+0x9c/0xcc0
 unix_stream_read_skb+0x30/0x120
 sk_psock_verdict_data_ready+0x8d/0x2a0
 unix_stream_sendmsg+0x232/0x640
 __sys_sendto+0x1cd/0x1e0
 __x64_sys_sendto+0x20/0x30
 do_syscall_64+0x93/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e


