Return-Path: <linux-kselftest+bounces-13765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CC89320C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 08:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261071C2174B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 06:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A68B1CD2D;
	Tue, 16 Jul 2024 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwAqUG4w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDB02B9C7;
	Tue, 16 Jul 2024 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112824; cv=none; b=UyF39QPStlq/DlerzV3cVRXxiqiSaXhWsnBM2AKX+VWMM/bPpE27exEAZRrL5ILf2rnHm6AOSN9/nLoGqCrOeuAo+eAKqkjkhYtEe8lC/9s/O4g/y0uGM6lgNv31snDOEeMPOiHMC0QGBy7ibFDFy4luPbCmMCY9MqsrTIgJEJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112824; c=relaxed/simple;
	bh=6/dPIIDjzscjA+NmqaRp+QtUW7M0QDKcxy7D8rY7aCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HCdK2nyDi7aT1uxevpZKim6W7Y3rvRRl/mq2AfIYoLZsUeVxkk8hyuWXyvKBLFQD+lMwfkFzNhxxCGvJmPsEXItjRwDP+q3ODE31bq1ritd17PiyYTDhAk6QB6+EO9IbeHz+/jqgKMiiS7vcvYMZLkZXzj6YcN93beJJLRWhpBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwAqUG4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF8AC116B1;
	Tue, 16 Jul 2024 06:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721112823;
	bh=6/dPIIDjzscjA+NmqaRp+QtUW7M0QDKcxy7D8rY7aCA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rwAqUG4wOHGGLtPJ6UQbJdeXfcji0HfvO3XkFNfnb/uikd+ZijaO/Kfbim1rteCPU
	 Z7yB11OnNuRc4b4yA26ezbljHkAGS5ZeOgzFkGJkbEQ/Gmd6VNIVRjIuArleiNYiFP
	 5XlP6GzrmA/1D2VRIm4EAqcWD5vUqHhmXLpl1Dthmd9chifKmRqK+eK08XiqGU1BbK
	 s5wVflC4JOVOHrzlIURyOmP8OASpagwFnKWtieoWPG8JUuu2bW/L6keeJPpObB/i/K
	 QYG6zqHK9jU4QYPMUCl17NRK7DsIF2mv5buOkvM57wk9teZ+DgeBpsGivx7eeivE05
	 XXa4MuFuU99bA==
Message-ID: <c8f40c0e5d8f4e0dbf6f513864823d2d4c206679.camel@kernel.org>
Subject: Re: [PATCH net v3 2/2] skmsg: bugfix for sk_msg sge iteration
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki
	 <jakub@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "D. Wythe" <alibuda@linux.alibaba.com>, Geliang
 Tang <tanggeliang@kylinos.cn>, David Ahern <dsahern@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  Mykyta Yatsenko
 <yatsenko@meta.com>, Miao Xu <miaxu@meta.com>, Yuran Pereira
 <yuran.pereira@hotmail.com>, Huacai Chen <chenhuacai@kernel.org>, Tiezhu
 Yang <yangtiezhu@loongson.cn>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Tue, 16 Jul 2024 14:53:26 +0800
In-Reply-To: <9f5c3a9e10f46ef193abdd1c490972147b83a978.camel@kernel.org>
References: <cover.1719553101.git.tanggeliang@kylinos.cn>
	 <56d8ec28df901432e7bde4953795166ce2edd472.1719553101.git.tanggeliang@kylinos.cn>
	 <70d94a71-2654-4647-97f3-1017adee1fd4@linux.alibaba.com>
	 <9f5c3a9e10f46ef193abdd1c490972147b83a978.camel@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi John,

On Mon, 2024-07-01 at 18:29 +0800, Geliang Tang wrote:
> > > > > > > > Hello,
> > > > > > > > 
> > > > > > > > On Mon, 2024-07-01 at 17:00 +0800, D. Wythe wrote:
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > On 6/28/24 1:47 PM, Geliang Tang wrote:
> > > > > > > > > > > > > > > > > > > > > > > > From: Geliang Tang
> > > > > > > > > > > > > > > > > > > > > > > > <tanggeliang@kylinos.cn
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > > > > > > Every time run this BPF
> > > > > > > > > > > > > > > > > > > > > > > > selftests
> > > > > > > > > > > > > > > > > > > > > > > > (./test_sockmap) on a
> > > > > > > > > > > > > > > > > > > > > > > > Loongarch
> > > > > > > > > > > > > > > > > > > > > > > > platform,

This issue seems related to "txmsg_cork".

Every subtest of test_sockmap with a txmsg_cork value greater than 1
will trigger this issue. For example, this test_txmsg_cork_hangs test:

static void test_txmsg_cork_hangs(int cgrp, struct sockmap_options
*opt)
{
        txmsg_pass = 1; 
        txmsg_redir = 0; 
        txmsg_cork = 4097;
        txmsg_apply = 4097;
        test_send_large(opt, cgrp);

        txmsg_pass = 0; 
        txmsg_redir = 1; 
        txmsg_apply = 0; 
        txmsg_cork = 4097;
        test_send_large(opt, cgrp);

        txmsg_pass = 0; 
        txmsg_redir = 1; 
        txmsg_apply = 4097;
        txmsg_cork = 4097;
        test_send_large(opt, cgrp);
}

These tests will break the sk_msg sge iteration in
sk_msg_memcopy_from_iter().

I added the following test code:

'''
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index bbf40b999713..e1fd40aa8586 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -374,6 +374,7 @@ int sk_msg_memcopy_from_iter(struct sock *sk,
struct iov_iter *from,
 	void *to;
 
 	do {
+		pr_info("%s i=%d end=%d\n", __func__, i, msg->sg.end);
 		sge = sk_msg_elem(msg, i);
 		/* This is possible if a trim operation shrunk the
buffer */
 		if (msg->sg.copybreak >= sge->length) {
--
'''

And got this logs when running "test hanging corks" test:

'''
# 1/ 1  sockmap::txmsg test hanging corks:OK
# 2/ 1 sockhash::txmsg test hanging corks:OK
# 3/ 1 sockhash:ktls:txmsg test hanging corks:OK

[   55.751687] sk_msg_memcopy_from_iter i=0 end=8
[   55.751712] sk_msg_memcopy_from_iter i=1 end=8
[   55.751726] sk_msg_memcopy_from_iter i=2 end=8
[   55.751769] sk_msg_memcopy_from_iter i=3 end=8
[   55.751778] sk_msg_memcopy_from_iter i=4 end=8
[   55.751787] sk_msg_memcopy_from_iter i=5 end=8
[   55.751796] sk_msg_memcopy_from_iter i=6 end=8
[   55.751805] sk_msg_memcopy_from_iter i=7 end=8
[   55.752979] sk_msg_memcopy_from_iter i=8 end=16
[   55.752988] sk_msg_memcopy_from_iter i=9 end=16
[   55.752995] sk_msg_memcopy_from_iter i=10 end=16
[   55.753002] sk_msg_memcopy_from_iter i=11 end=16
[   55.753008] sk_msg_memcopy_from_iter i=12 end=16
[   55.753015] sk_msg_memcopy_from_iter i=13 end=16
[   55.753022] sk_msg_memcopy_from_iter i=14 end=16
[   55.753028] sk_msg_memcopy_from_iter i=15 end=16
[   56.087047] sk_msg_memcopy_from_iter i=0 end=1
[   56.087075] sk_msg_memcopy_from_iter i=1 end=1
[   56.087081] sk_msg_memcopy_from_iter i=3 end=1
[   56.087086] sk_msg_memcopy_from_iter i=5 end=1
[   56.087091] sk_msg_memcopy_from_iter i=7 end=1
[   56.087095] sk_msg_memcopy_from_iter i=9 end=1
[   56.087100] sk_msg_memcopy_from_iter i=11 end=1
[   56.087105] sk_msg_memcopy_from_iter i=13 end=1
[   56.087110] sk_msg_memcopy_from_iter i=15 end=1
[   56.087115] sk_msg_memcopy_from_iter i=17 end=1
'''

When "i" is greater than "end", the sge we get is empty, sge->length is
0. If we access this sge, this issue will occur. Kernel panics on some
machines.

To fix this, we can't "break" the loop like I did in this patch itself.
It will break test_sockmap with the following error logs:

# 1/ 1  sockmap::txmsg test hanging corks:OK
sendpage loop error: No space left on device
msg_loop_tx: iov_count 1024 iov_buf 256 cnt 2 err -1
tx thread exited with err 1.
# 2/ 1 sockhash::txmsg test hanging corks:FAIL
# 3/ 1 sockhash:ktls:txmsg test hanging corks:OK
Pass: 2 Fail: 1

We must "continue" the loop to get the next valid sge.

A better fix is here:

'''
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index bbf40b999713..bbaf909d0f9c 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -376,13 +376,8 @@ int sk_msg_memcopy_from_iter(struct sock *sk,
struct iov_iter *from,
 	do {
 		sge = sk_msg_elem(msg, i);
 		/* This is possible if a trim operation shrunk the
buffer */
-		if (msg->sg.copybreak >= sge->length) {
-			msg->sg.copybreak = 0;
-			sk_msg_iter_var_next(i);
-			if (i == msg->sg.end)
-				break;
-			sge = sk_msg_elem(msg, i);
-		}
+		if (msg->sg.copybreak >= sge->length)
+			goto next;
 
 		buf_size = sge->length - msg->sg.copybreak;
 		copy = (buf_size > bytes) ? bytes : buf_size;
@@ -399,6 +394,7 @@ int sk_msg_memcopy_from_iter(struct sock *sk,
struct iov_iter *from,
 		bytes -= copy;
 		if (!bytes)
 			break;
+next:
 		msg->sg.copybreak = 0;
 		sk_msg_iter_var_next(i);
 	} while (i != msg->sg.end);
-- 
'''

WDYT? I want to hear your opinion.

Thanks,
-Geliang

> > > > > > > > > > > > > > > > > > > > > > > > a Kernel panic occurs:
> > > > > > > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > > > > > > '''
> > > > > > > > > > > > > > > > > > > > > > > >   Oops[#1]:
> > > > > > > > > > > > > > > > > > > > > > > >   CPU: 20 PID: 23245
> > > > > > > > > > > > > > > > > > > > > > > > Comm: test_sockmap
> > > > > > > > > > > > > > > > > > > > > > > > Tainted: G     OE
> > > > > > > > > > > > > > > > > > > > > > > > 6.10.0-
> > > > > > > > > > > > > > > > > > > > > > > > rc2+ #32
> > > > > > > > > > > > > > > > > > > > > > > >   Hardware name:
> > > > > > > > > > > > > > > > > > > > > > > > LOONGSON
> > > > > > > > > > > > > > > > > > > > > > > > Dabieshan/Loongson-
> > > > > > > > > > > > > > > > > > > > > > > > TC542F0, BIOS
> > > > > > > > > > > > > > > > > > > > > > > > Loongson-UDK2018
> > > > > > > > > > > > > > > > > > > > > > > >   ... ...
> > > > > > > > > > > > > > > > > > > > > > > >      ra:
> > > > > > > > > > > > > > > > > > > > > > > > 90000000043a315c
> > > > > > > > > > > > > > > > > > > > > > > > tcp_bpf_sendmsg+0x23c/0
> > > > > > > > > > > > > > > > > > > > > > > > x420
> > > > > > > > > > > > > > > > > > > > > > > >     ERA:
> > > > > > > > > > > > > > > > > > > > > > > > 900000000426cd1c
> > > > > > > > > > > > > > > > > > > > > > > > sk_msg_memcopy_from_ite
> > > > > > > > > > > > > > > > > > > > > > > > r+0xbc/0x220
> > > > > > > > > > > > > > > > > > > > > > > >    CRMD: 000000b0 (PLV0
> > > > > > > > > > > > > > > > > > > > > > > > -IE -DA +PG DACF=CC
> > > > > > > > > > > > > > > > > > > > > > > > DACM=CC -WE)
> > > > > > > > > > > > > > > > > > > > > > > >    PRMD: 0000000c
> > > > > > > > > > > > > > > > > > > > > > > > (PPLV0 +PIE +PWE)
> > > > > > > > > > > > > > > > > > > > > > > >    EUEN: 00000007 (+FPE
> > > > > > > > > > > > > > > > > > > > > > > > +SXE +ASXE -BTE)
> > > > > > > > > > > > > > > > > > > > > > > >    ECFG: 00071c1d
> > > > > > > > > > > > > > > > > > > > > > > > (LIE=0,2-4,10-12 VS=7)
> > > > > > > > > > > > > > > > > > > > > > > >   ESTAT: 00010000 [PIL]
> > > > > > > > > > > > > > > > > > > > > > > > (IS= ECode=1
> > > > > > > > > > > > > > > > > > > > > > > > EsubCode=0)
> > > > > > > > > > > > > > > > > > > > > > > >    BADV:
> > > > > > > > > > > > > > > > > > > > > > > > 0000000000000040
> > > > > > > > > > > > > > > > > > > > > > > >    PRID: 0014c011
> > > > > > > > > > > > > > > > > > > > > > > > (Loongson-64bit,
> > > > > > > > > > > > > > > > > > > > > > > > Loongson-3C5000)
> > > > > > > > > > > > > > > > > > > > > > > >   Modules linked in:
> > > > > > > > > > > > > > > > > > > > > > > > tls xt_CHECKSUM
> > > > > > > > > > > > > > > > > > > > > > > > xt_MASQUERADE
> > > > > > > > > > > > > > > > > > > > > > > > xt_conntrack
> > > > > > > > > > > > > > > > > > > > > > > > ipt_REJECT
> > > > > > > > > > > > > > > > > > > > > > > >   Process test_sockmap
> > > > > > > > > > > > > > > > > > > > > > > > (pid: 23245,
> > > > > > > > > > > > > > > > > > > > > > > > threadinfo=00000000aeb6
> > > > > > > > > > > > > > > > > > > > > > > > 8043,
> > > > > > > > > > > > > > > > > > > > > > > > task=...)
> > > > > > > > > > > > > > > > > > > > > > > >   Stack : ... ...
> > > > > > > > > > > > > > > > > > > > > > > >           ...
> > > > > > > > > > > > > > > > > > > > > > > >   Call Trace:
> > > > > > > > > > > > > > > > > > > > > > > >   [<900000000426cd1c>]
> > > > > > > > > > > > > > > > > > > > > > > > sk_msg_memcopy_from_ite
> > > > > > > > > > > > > > > > > > > > > > > > r+0xbc/0x220
> > > > > > > > > > > > > > > > > > > > > > > >   [<90000000043a315c>]
> > > > > > > > > > > > > > > > > > > > > > > > tcp_bpf_sendmsg+0x23c/0
> > > > > > > > > > > > > > > > > > > > > > > > x420
> > > > > > > > > > > > > > > > > > > > > > > >   [<90000000041cafc8>]
> > > > > > > > > > > > > > > > > > > > > > > > __sock_sendmsg+0x68/0xe
> > > > > > > > > > > > > > > > > > > > > > > > 0
> > > > > > > > > > > > > > > > > > > > > > > >   [<90000000041cc4bc>]
> > > > > > > > > > > > > > > > > > > > > > > > ____sys_sendmsg+0x2bc/0
> > > > > > > > > > > > > > > > > > > > > > > > x360
> > > > > > > > > > > > > > > > > > > > > > > >   [<90000000041cea18>]
> > > > > > > > > > > > > > > > > > > > > > > > ___sys_sendmsg+0xb8/0x1
> > > > > > > > > > > > > > > > > > > > > > > > 20
> > > > > > > > > > > > > > > > > > > > > > > >   [<90000000041cf1f8>]
> > > > > > > > > > > > > > > > > > > > > > > > __sys_sendmsg+0x98/0x10
> > > > > > > > > > > > > > > > > > > > > > > > 0
> > > > > > > > > > > > > > > > > > > > > > > >   [<90000000045b76ec>]
> > > > > > > > > > > > > > > > > > > > > > > > do_syscall+0x8c/0xc0
> > > > > > > > > > > > > > > > > > > > > > > >   [<90000000030e1da4>]
> > > > > > > > > > > > > > > > > > > > > > > > handle_syscall+0xc4/0x1
> > > > > > > > > > > > > > > > > > > > > > > > 60
> > > > > > > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > > > > > >   Code: ...
> > > > > > > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > > > > > >   ---[ end trace
> > > > > > > > > > > > > > > > > > > > > > > > 0000000000000000 ]---
> > > > > > > > > > > > > > > > > > > > > > > > '''
> > > > > > > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > > > > > > This crash is because a
> > > > > > > > > > > > > > > > > > > > > > > > NULL pointer is passed
> > > > > > > > > > > > > > > > > > > > > > > > to
> > > > > > > > > > > > > > > > > > > > > > > > page_address()
> > > > > > > > > > > > > > > > > > > > > > > > in
> > > > > > > > > > > > > > > > > > > > > > > > sk_msg_memcopy_from_ite
> > > > > > > > > > > > > > > > > > > > > > > > r(). Due to the
> > > > > > > > > > > > > > > > > > > > > > > > difference in
> > > > > > > > > > > > > > > > > > > > > > > > architecture,
> > > > > > > > > > > > > > > > > > > > > > > > page_address(0) will
> > > > > > > > > > > > > > > > > > > > > > > > not trigger a panic on
> > > > > > > > > > > > > > > > > > > > > > > > the
> > > > > > > > > > > > > > > > > > > > > > > > X86
> > > > > > > > > > > > > > > > > > > > > > > > platform but
> > > > > > > > > > > > > > > > > > > > > > > > will panic
> > > > > > > > > > > > > > > > > > > > > > > > on the Loogarch
> > > > > > > > > > > > > > > > > > > > > > > > platform. So this bug
> > > > > > > > > > > > > > > > > > > > > > > > was
> > > > > > > > > > > > > > > > > > > > > > > > hidden on the x86
> > > > > > > > > > > > > > > > > > > > > > > > platform, but
> > > > > > > > > > > > > > > > > > > > > > > > now it is exposed on
> > > > > > > > > > > > > > > > > > > > > > > > the Loogarch platform.
> > > > > > > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > > > > > > This bug is a logic
> > > > > > > > > > > > > > > > > > > > > > > > error indeed. In
> > > > > > > > > > > > > > > > > > > > > > > > sk_msg_memcopy_from_ite
> > > > > > > > > > > > > > > > > > > > > > > > r(),
> > > > > > > > > > > > > > > > > > > > > > > > an
> > > > > > > > > > > > > > > > > > > > > > > > invalid
> > > > > > > > > > > > > > > > > > > > > > > > "sge" is always used:
> > > > > > > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > > > > > >  if (msg->sg.copybreak
> > > > > > > > > > > > > > > > > > > > > > > > >= sge->length) {
> > > > > > > > > > > > > > > > > > > > > > > >  msg->sg.copybreak = 0;
> > > > > > > > > > > > > > > > > > > > > > > >  sk_msg_iter_var_next(i
> > > > > > > > > > > > > > > > > > > > > > > > );
> > > > > > > > > > > > > > > > > > > > > > > >  if (i == msg->sg.end)
> > > > > > > > > > > > > > > > > > > > > > > >  break;
> > > > > > > > > > > > > > > > > > > > > > > >  sge = sk_msg_elem(msg,
> > > > > > > > > > > > > > > > > > > > > > > > i);
> > > > > > > > > > > > > > > > > > > > > > > >  }
> > > > > > > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > > > > > > If the value of i is 2,
> > > > > > > > > > > > > > > > > > > > > > > > msg->sg.end is also 2
> > > > > > > > > > > > > > > > > > > > > > > > when entering
> > > > > > > > > > > > > > > > > > > > > > > > this
> > > > > > > > > > > > > > > > > > > > > > > > if
> > > > > > > > > > > > > > > > > > > > > > > > block.
> > > > > > > > > > > > > > > > > > > > > > > > sk_msg_iter_var_next()
> > > > > > > > > > > > > > > > > > > > > > > > increases i by 1, and
> > > > > > > > > > > > > > > > > > > > > > > > now i is 3,
> > > > > > > > > > > > > > > > > > > > > > > > which is
> > > > > > > > > > > > > > > > > > > > > > > > no longer
> > > > > > > > > > > > > > > > > > > > > > > > equal to msg->sg.end.
> > > > > > > > > > > > > > > > > > > > > > > > The break will not be
> > > > > > > > > > > > > > > > > > > > > > > > triggered, and
> > > > > > > > > > > > > > > > > > > > > > > > the
> > > > > > > > > > > > > > > > > > > > > > > > next
> > > > > > > > > > > > > > > > > > > > > > > > sge
> > > > > > > > > > > > > > > > > > > > > > > > obtained by
> > > > > > > > > > > > > > > > > > > > > > > > sk_msg_elem(3) will be
> > > > > > > > > > > > > > > > > > > > > > > > an invalid
> > > > > > > > > > > > > > > > > > > > > > > > one.
> > > > > > > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > > > > > > The correct approach is
> > > > > > > > > > > > > > > > > > > > > > > > to check (i ==
> > > > > > > > > > > > > > > > > > > > > > > > msg->sg.end) first,
> > > > > > > > > > > > > > > > > > > > > > > > and
> > > > > > > > > > > > > > > > > > > > > > > > then
> > > > > > > > > > > > > > > > > > > > > > > > invoke
> > > > > > > > > > > > > > > > > > > > > > > > sk_msg_iter_var_next()
> > > > > > > > > > > > > > > > > > > > > > > > if they are not equal.
> > > > > > > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > > > > > > Fixes: 604326b41a6f
> > > > > > > > > > > > > > > > > > > > > > > > ("bpf, sockmap: convert
> > > > > > > > > > > > > > > > > > > > > > > > to
> > > > > > > > > > > > > > > > > > > > > > > > generic
> > > > > > > > > > > > > > > > > > > > > > > > sk_msg
> > > > > > > > > > > > > > > > > > > > > > > > interface")
> > > > > > > > > > > > > > > > > > > > > > > > Signed-off-by: Geliang
> > > > > > > > > > > > > > > > > > > > > > > > Tang
> > > > > > > > > > > > > > > > > > > > > > > > <
> > > > > > > > > > > > > > > > > > > > > > > > tanggeliang@kylinos.cn>
> > > > > > > > > > > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > > > > > > > > > >   net/core/skmsg.c | 2
> > > > > > > > > > > > > > > > > > > > > > > > +-
> > > > > > > > > > > > > > > > > > > > > > > >   1 file changed, 1
> > > > > > > > > > > > > > > > > > > > > > > > insertion(+), 1
> > > > > > > > > > > > > > > > > > > > > > > > deletion(-)
> > > > > > > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > > > > > > diff --git
> > > > > > > > > > > > > > > > > > > > > > > > a/net/core/skmsg.c
> > > > > > > > > > > > > > > > > > > > > > > > b/net/core/skmsg.c
> > > > > > > > > > > > > > > > > > > > > > > > index
> > > > > > > > > > > > > > > > > > > > > > > > 44952cdd1425..1906d0d0e
> > > > > > > > > > > > > > > > > > > > > > > > eac 100644
> > > > > > > > > > > > > > > > > > > > > > > > --- a/net/core/skmsg.c
> > > > > > > > > > > > > > > > > > > > > > > > +++ b/net/core/skmsg.c
> > > > > > > > > > > > > > > > > > > > > > > > @@ -378,9 +378,9 @@ int
> > > > > > > > > > > > > > > > > > > > > > > > sk_msg_memcopy_from_ite
> > > > > > > > > > > > > > > > > > > > > > > > r(struct
> > > > > > > > > > > > > > > > > > > > > > > > sock *sk,
> > > > > > > > > > > > > > > > > > > > > > > > struct iov_iter *from,
> > > > > > > > > > > > > > > > > > > > > > > >    /* This is possible
> > > > > > > > > > > > > > > > > > > > > > > > if a trim operation
> > > > > > > > > > > > > > > > > > > > > > > > shrunk the
> > > > > > > > > > > > > > > > > > > > > > > > buffer */
> > > > > > > > > > > > > > > > > > > > > > > >    if (msg-
> > > > > > > > > > > > > > > > > > > > > > > > >sg.copybreak >= sge-
> > > > > > > > > > > > > > > > > > > > > > > > >length) {
> > > > > > > > > > > > > > > > > > > > > > > >    msg->sg.copybreak =
> > > > > > > > > > > > > > > > > > > > > > > > 0;
> > > > > > > > > > > > > > > > > > > > > > > > -
> > > > > > > > > > > > > > > > > > > > > > > > sk_msg_iter_var_next(i)
> > > > > > > > > > > > > > > > > > > > > > > > ;
> > > > > > > > > > > > > > > > > > > > > > > >    if (i == msg-
> > > > > > > > > > > > > > > > > > > > > > > > >sg.end)
> > > > > > > > > > > > > > > > > > > > > > > >    break;
> > > > > > > > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > > > > > > > sk_msg_iter_var_next(i)
> > > > > > > > > > > > > > > > > > > > > > > > ;
> > > > > > > > > > > > > > > > Reviewed-by: D. Wythe
> > > > > > > > > > > > > > > > <alibuda@linux.alibaba.com>
> > > > > > > > 
> > > > > > > > Thanks for your review.
> > > > > > > > 
> > > > > > > > But this change breaks test_sockmap. Will send a v4 to
> > > > > > > > fix
> > > > > > > > this.
> > > > > > > > 
> > > > > > > > Changes Requested.
> > > > > > > > 
> > > > > > > > -Geliang
> > > > > > > > 
> > > > > > > > > > > > > > > > > > > > > > > >    sge =
> > > > > > > > > > > > > > > > > > > > > > > > sk_msg_elem(msg, i);
> > > > > > > > > > > > > > > > > > > > > > > >    }
> > > > > > > > > > > > > > > > > > > > > > > >   
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > 
> > > > > > > > 
> > > > > > > > 


