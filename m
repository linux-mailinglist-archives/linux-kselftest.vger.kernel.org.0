Return-Path: <linux-kselftest+bounces-13341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FEE92AD22
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 02:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099752822E5
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 00:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0D14A08;
	Tue,  9 Jul 2024 00:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuaLewx/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FCF15BB;
	Tue,  9 Jul 2024 00:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720485184; cv=none; b=e8N7XRYHWchO5a6avN13/FxwtLDvELtcOqfjEgiwSBUZaGr74ZM3nFrUfH6gWBe2sVbHap8n6UuectW3R6diKlrKMp68XC+JUfH+kSZ9E5e3DE4oW1hh1u8VNzIkyrPGGegpck+r02lOuk4t257hc0sTF6KsDd6cSj0UJFjqMs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720485184; c=relaxed/simple;
	bh=k3/zS10JtPOCVxvS3f37FDn+IqhfPWXVJ3N/zYrYDJ0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=THc5Dqzai8yH825L6ei5UNF2qK/Lnig20QMIyBk8i1mBrJ1JEIsCnwv4VkgNRNOEqBuTzXXxw5OdKGn8hFT6Z7T9Xa+EKpbUyXu0Te+vFkB7HqvmvRHc2wP6ZQ75aOCPWZkTNLIF5S/2I17OpzwBJ3YZ+L7lAtYA+tafqZrYskY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuaLewx/; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6eab07ae82bso2348357a12.3;
        Mon, 08 Jul 2024 17:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720485182; x=1721089982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbmTmpGl9LGWIehww80/zM7iEVzfhtY6yCT6eHjeVS8=;
        b=HuaLewx/eQSod4JtyPVha+62O+HQ2sS4CF1SEKz6LQrfI5GbNGIHyeAb/gPxR2fJ1L
         tbDcq8Zkbxb6G1OfstfyvO1QEAj9MEzwpcbY3m5zKydrncXCAW2kz4GOOEyOivc9SKH3
         4x7nrzMF3wlyHBkMmoaRtRMdbl4+LsDvn3SCNngMXNJPBuxlprurI3ll510qGCwGijnW
         juDjrvQSoluR0r+swHm7h9rM/DHhUvqqEdFrsILCr5JRt+fpAP7GPyfc2iBh99FmaGzi
         Q2kQAvvikKm+5PyzfSjbFxNpqDUigu2WZMPX7lQnPG1Al6G+P+GTG4V4U62GCmcB8KgN
         gAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720485182; x=1721089982;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gbmTmpGl9LGWIehww80/zM7iEVzfhtY6yCT6eHjeVS8=;
        b=HuqurRBz/0UZk4klxir+9wPzj3FKfotgKbQb0Z1N+eNotVZhFp/n9I/PWVgQu/5b05
         29RMQstrpfxOQLteM/aEy2NZDZNYTILQfeJMU/fHSGBzdgggXY5uNSozR1d24Dr4+O03
         9cMHm+/XYsXHt4VMNdhfLk6LzlTrgcGbh6XGa8Jpt1/hgU0uKYcSd2KuAvOLYyO7zbeW
         8njrEHvBDm3fZ7hqdKJHwd4n/WHOXio4HOfUXOrwBLh48zddKwy+PeLon7/GyY30naRv
         mBuNVtxW7PoBkdwxd8tVkK9iVLoeaaBYRL7PBW/y0ytXUkaUI0YZsk5gDIg+zFUcNjPJ
         Gu8A==
X-Forwarded-Encrypted: i=1; AJvYcCUc26Cy+pNj+h1ROzG3ue4SDHgmyVIALl5n8kGxj9vqxVque5xIQB27vZf0otYjG9dotT/CNkWVZyHZXzBOREF+uCgnMEl4smov9MCzZMDkQkqylEEb3lWT7di5o1qVs4YKgulS07napQzkY7ul5/TotgtooBukC4zSsmMt
X-Gm-Message-State: AOJu0YzyA6+65eLgjFub7L4RtsIy748kyo5inZiJPyaQQEG3UGOkDkOq
	x4agzlPeKr2PqQGZrt3EZxzRCi3/qL3vSoxHTGP60u036XR+b5dB
X-Google-Smtp-Source: AGHT+IERW/eDq4h5+NOdDSAyiBCa54iY/xmob/DozhAnYntCHQ3fG5yPiIkvES8ODeOBUw9oOuq4LA==
X-Received: by 2002:a05:6a20:918d:b0:1be:c5ab:7388 with SMTP id adf61e73a8af0-1c298220a18mr1216126637.25.1720485181955;
        Mon, 08 Jul 2024 17:33:01 -0700 (PDT)
Received: from localhost ([98.97.32.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac7921sm4363165ad.232.2024.07.08.17.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 17:33:01 -0700 (PDT)
Date: Mon, 08 Jul 2024 17:33:00 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Geliang Tang <geliang@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, 
 David Ahern <dsahern@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Mykyta Yatsenko <yatsenko@meta.com>, 
 Miao Xu <miaxu@meta.com>, 
 Yuran Pereira <yuran.pereira@hotmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, 
 "D . Wythe" <alibuda@linux.alibaba.com>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <668c853cc8820_d7720867@john.notmuch>
In-Reply-To: <e3a16eacdc6740658ee02a33489b1b9d4912f378.1719992715.git.tanggeliang@kylinos.cn>
References: <e3a16eacdc6740658ee02a33489b1b9d4912f378.1719992715.git.tanggeliang@kylinos.cn>
Subject: RE: [PATCH net v5] skmsg: skip zero length skb in sk_msg_recvmsg
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Run this BPF selftests (./test_progs -t sockmap_basic) on a Loongarch
> platform, a kernel panic occurs:
> 
> '''
> Oops[#1]:
> CPU: 22 PID: 2824 Comm: test_progs Tainted: G           OE  6.10.0-rc2+ #18
> Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS Loongson-UDK2018
>    ... ...
>    ra: 90000000048bf6c0 sk_msg_recvmsg+0x120/0x560
>   ERA: 9000000004162774 copy_page_to_iter+0x74/0x1c0
>  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
>  PRMD: 0000000c (PPLV0 +PIE +PWE)
>  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
>  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
> ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
>  BADV: 0000000000000040
>  PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
> Modules linked in: bpf_testmod(OE) xt_CHECKSUM xt_MASQUERADE xt_conntrack
> Process test_progs (pid: 2824, threadinfo=0000000000863a31, task=...)
> Stack : ...
>         ...
> Call Trace:
> [<9000000004162774>] copy_page_to_iter+0x74/0x1c0
> [<90000000048bf6c0>] sk_msg_recvmsg+0x120/0x560
> [<90000000049f2b90>] tcp_bpf_recvmsg_parser+0x170/0x4e0
> [<90000000049aae34>] inet_recvmsg+0x54/0x100
> [<900000000481ad5c>] sock_recvmsg+0x7c/0xe0
> [<900000000481e1a8>] __sys_recvfrom+0x108/0x1c0
> [<900000000481e27c>] sys_recvfrom+0x1c/0x40
> [<9000000004c076ec>] do_syscall+0x8c/0xc0
> [<9000000003731da4>] handle_syscall+0xc4/0x160
> 
> Code: ...
> 
> ---[ end trace 0000000000000000 ]---
> Kernel panic - not syncing: Fatal exception
> Kernel relocated by 0x3510000
>  .text @ 0x9000000003710000
>  .data @ 0x9000000004d70000
>  .bss  @ 0x9000000006469400
> ---[ end Kernel panic - not syncing: Fatal exception ]---
> '''
> 
> This crash happens every time when running sockmap_skb_verdict_shutdown
> subtest in sockmap_basic.
> 
> This crash is because a NULL pointer is passed to page_address() in
> sk_msg_recvmsg(). Due to the difference implementations depending on the
> architecture, page_address(NULL) will trigger a panic on Loongarch
> platform but not on X86 platform. So this bug was hidden on X86 platform
> for a while, but now it is exposed on Loongarch platform.
> 
> The root cause is a zero length skb (skb->len == 0) is put on the queue.
> 
> This zero length skb is a TCP FIN packet, which is sent by shutdown(),
> invoked in test_sockmap_skb_verdict_shutdown():
> 
> 	shutdown(p1, SHUT_WR);
> 
> In this case, in sk_psock_skb_ingress_enqueue(), num_sge is zero, and no
> page is put to this sge (see sg_set_page in sg_set_page), but this empty
> sge is queued into ingress_msg list.
> 
> And in sk_msg_recvmsg(), this empty sge is used, and a NULL page is got by
> sg_page(sge). Pass this NULL page to copy_page_to_iter(), which passes it
> to kmap_local_page() and to page_address(), then kernel panics.
> 
> To solve this, we should skip this zero length skb. So in sk_msg_recvmsg(),
> if copy is zero, that means it's a zero length skb, skip invoking
> copy_page_to_iter(). We are using the EFAULT return triggered by
> copy_page_to_iter to check for is_fin in tcp_bpf.c.
> 
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Suggested-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> v5:
>  - update v5 as John suggested.
>  - skmsg: skip zero length skb in sk_msg_recvmsg
> 
> v4:
>  - skmsg: skip empty sge in sk_msg_recvmsg
> 
> v3:
>  - skmsg: prevent empty ingress skb from enqueuing
>    
> v2:
>  - skmsg: null check for sg_page in sk_msg_recvmsg
> ---
>  net/core/skmsg.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I don't have any better ideas so lets use this.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

