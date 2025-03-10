Return-Path: <linux-kselftest+bounces-28573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 417F5A58A3E
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 03:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E2D3A76D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 02:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A58114F11E;
	Mon, 10 Mar 2025 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHqfK7rd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43E62C9A;
	Mon, 10 Mar 2025 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572657; cv=none; b=hd4kyucDNi6lq/nKGLk5kIIJsr71Nh69MrcMfaYhJM0xldszq7NqGPqqVd/cLwkrT4k2tiou/U4zF/GfXOQrggmtESZ4Xsoxc1TAKs/brUSjjBG272ilu5gNTE4Unh0C2LUAol/LXh3fk2zpqRdkK7bCdUKG3XP5nG33zibndzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572657; c=relaxed/simple;
	bh=gQ3FVNImk70lsIsYT/2Bexol3lH7poii9vWQ/Q7Skjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SA2eEtIsrbdg9S6k3tAvObSjLrO2pC7WROOK3IsRtrYcRW0mrSXRkhyVeqWUWlYHwXYVWTHyaqSgZw6TMN5XzFqSYJF6hTDg6xsYvKV0BgyETWef/suSQ6TSTrbWsPQoZIwBVQTyvvUMUvapKaoTPf5SR43Ru7SK9ADb21mkwQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHqfK7rd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5b572e45cso6472526a12.0;
        Sun, 09 Mar 2025 19:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741572654; x=1742177454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVn9TKPYoU1o+zU9Tsd+xvNpNPHPzpLsJr1Dohiegy4=;
        b=bHqfK7rdL+E+S3jMuJugNxDZIDKnlaM1nYH2kZNL7Tef5DDN7nmEknIfs2tH4pfHeA
         edfWaY15JghUULadwZLDsK80mvH0GaZUS1dZR95IzSoDOQ3qLTxpMR9LXNZJhrTdAPMm
         XtBpCxRMnUdGURT4fAmFQMZvmFh/4BDdyqY3dFFJ11J9iff/1KrCXVXtdj3+VVFL+2WK
         YP6CHqoE0Da1JrZkPIZmyG+zTFKEJJic06s7vQ7XYCzFaRkLK7SWWhwvQSRyQHWEZrUI
         GFz7aYqjJ5o0OVxvkz54df8Pl/V19RXj2hGJCC98Q42nr3qrr/Dkt55KgVUWQ7HCN8qI
         9dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741572654; x=1742177454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVn9TKPYoU1o+zU9Tsd+xvNpNPHPzpLsJr1Dohiegy4=;
        b=hmKiIt9zxNCtzF635Jo5u2AuQffOYkCaxtX+0dMiKHvwxnML4RrlsWb9yHv7ueYePz
         11myhoG25BRyGosbT7uKdoUGEAbgnhPtOFqKspiDo8arkENBMQhkg1EBHfttETrUDJCl
         XK3Hreza3dP9wLfkPQCrKcooLs8sFcBta8jwPeKywLeW641kUxlU+/XvB0tmBl4wi3a8
         RUVacgMVemg2MYGf0X2ccS0tstu90rA2orP8v/JtycXNCIgqvBxWfv5zBF9Qre2x+n/h
         PV2HkV1koolT7+/ChGYD+WKntf3Sn4D+N/NDNCLsOF1arN/UrXRqITQRyb54EQJTdwU8
         ueKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0OHMuJDLKglz7Vf7FO9d7mOEJHAGVutNEYgoGiwYwzMQgTbjeW9vJaIB1PBJOTEYj2wImKg8jAMJzKnoaGag=@vger.kernel.org, AJvYcCXU5baf9sMXfwkeCmc46XCDdrB46vDDnQvclOWN+X4JwTPx86zIP30FoQZ0nDJqbLothfP514dh@vger.kernel.org
X-Gm-Message-State: AOJu0YxtyogG2rIQgo81ufrrgfKTnUSvmhHjRBHQuMKad+QPRquj8NUW
	6SToioM/Cl7kR5xC5sVUI1GSxe3zhyjNkU/P8cQZ4cxbuAtjJv8BxB/dkv+AZB0VQFcLf8Co6k0
	uM67l9XywOf3+HbmPXNze+OMPVNY=
X-Gm-Gg: ASbGncvEJvya4S8yAnnr6t1AfL8MylObGvwnI8hQt9IFi6RjHqYlk00YGG5sQuRP/g9
	VuW/cBEEkopptCF9wYSFparrGprJRd5VfQXM8RgOQ7PNgUmf0W1a7ykRTCs93wNEGo+62v7yDN6
	AsQnM0M7+nF9jjb4OgohUz3Eh4pnsm
X-Google-Smtp-Source: AGHT+IEsQg9+az6t9RgESCFRUsW5+WSuKYH+ZO7HLMLL9nrcOVJoRM9POrAnQ7Hj6UAqFqjcKGC1dDCwaTUKMCODeYM=
X-Received: by 2002:a05:6402:1e94:b0:5e6:1caf:daa8 with SMTP id
 4fb4d7f45d1cf-5e61cafdacamr5348541a12.23.1741572653931; Sun, 09 Mar 2025
 19:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309134219.91670-1-ap420073@gmail.com> <20250309134219.91670-3-ap420073@gmail.com>
 <CAHS8izPH=FkfGjq_+CzGJhZ3Wt06njM2c6HcBK7W1Xv6C8d5xw@mail.gmail.com>
In-Reply-To: <CAHS8izPH=FkfGjq_+CzGJhZ3Wt06njM2c6HcBK7W1Xv6C8d5xw@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Mon, 10 Mar 2025 11:10:42 +0900
X-Gm-Features: AQ5f1JpOK6pCnVNWHvOtn-B6POgmO7eE4jwUJPvaIHwt0l_nGAvZ9mFoFskTjfM
Message-ID: <CAMArcTWv_arQCWSeYehk=uM_=M+Hx0W_2C2cbvogQS+CmJu2aA@mail.gmail.com>
Subject: Re: [PATCH v3 net 2/8] eth: bnxt: return fail if interface is down in bnxt_queue_mem_alloc()
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, horms@kernel.org, shuah@kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, willemb@google.com, kaiyuanz@google.com, 
	skhawaja@google.com, sdf@fomichev.me, gospo@broadcom.com, 
	somnath.kotur@broadcom.com, dw@davidwei.uk, amritha.nambiar@intel.com, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 6:44=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>

Hi Mina,
Thanks a lot for the review!

> On Sun, Mar 9, 2025 at 6:43=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
> >
> > The bnxt_queue_mem_alloc() is called to allocate new queue memory when
> > a queue is restarted.
> > It internally accesses rx buffer descriptor corresponding to the index.
> > The rx buffer descriptor is allocated and set when the interface is up
> > and it's freed when the interface is down.
> > So, if queue is restarted if interface is down, kernel panic occurs.
> >
> > Splat looks like:
> >  BUG: unable to handle page fault for address: 000000000000b240
> >  #PF: supervisor read access in kernel mode
> >  #PF: error_code(0x0000) - not-present page
> >  PGD 0 P4D 0
> >  Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> >  CPU: 3 UID: 0 PID: 1563 Comm: ncdevmem2 Not tainted 6.14.0-rc2+ #9 844=
ddba6e7c459cafd0bf4db9a3198e
> >  Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/=
01/2021
> >  RIP: 0010:bnxt_queue_mem_alloc+0x3f/0x4e0 [bnxt_en]
> >  Code: 41 54 4d 89 c4 4d 69 c0 c0 05 00 00 55 48 89 f5 53 48 89 fb 4c 8=
d b5 40 05 00 00 48 83 ec 15
> >  RSP: 0018:ffff9dcc83fef9e8 EFLAGS: 00010202
> >  RAX: ffffffffc0457720 RBX: ffff934ed8d40000 RCX: 0000000000000000
> >  RDX: 000000000000001f RSI: ffff934ea508f800 RDI: ffff934ea508f808
> >  RBP: ffff934ea508f800 R08: 000000000000b240 R09: ffff934e84f4b000
> >  R10: ffff9dcc83fefa30 R11: ffff934e84f4b000 R12: 000000000000001f
> >  R13: ffff934ed8d40ac0 R14: ffff934ea508fd40 R15: ffff934e84f4b000
> >  FS:  00007fa73888c740(0000) GS:ffff93559f780000(0000) knlGS:0000000000=
000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 000000000000b240 CR3: 0000000145a2e000 CR4: 00000000007506f0
> >  PKRU: 55555554
> >  Call Trace:
> >   <TASK>
> >   ? __die+0x20/0x70
> >   ? page_fault_oops+0x15a/0x460
> >   ? exc_page_fault+0x6e/0x180
> >   ? asm_exc_page_fault+0x22/0x30
> >   ? __pfx_bnxt_queue_mem_alloc+0x10/0x10 [bnxt_en 7f85e76f4d724ba07471d=
7e39d9e773aea6597b7]
> >   ? bnxt_queue_mem_alloc+0x3f/0x4e0 [bnxt_en 7f85e76f4d724ba07471d7e39d=
9e773aea6597b7]
> >   netdev_rx_queue_restart+0xc5/0x240
> >   net_devmem_bind_dmabuf_to_queue+0xf8/0x200
> >   netdev_nl_bind_rx_doit+0x3a7/0x450
> >   genl_family_rcv_msg_doit+0xd9/0x130
> >   genl_rcv_msg+0x184/0x2b0
> >   ? __pfx_netdev_nl_bind_rx_doit+0x10/0x10
> >   ? __pfx_genl_rcv_msg+0x10/0x10
> >   netlink_rcv_skb+0x54/0x100
> >   genl_rcv+0x24/0x40
> > ...
> >
> > Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> > Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
>
> Although I wonder if you wanna return -ENETDOWN from other queue API
> ops, if your driver doesn't handle them.

Okay, I will add -ENETDOWN return to the other queue API in the next
version.

Thanks a lot!
Taehee Yoo

