Return-Path: <linux-kselftest+bounces-32151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B6DAA6A1F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 07:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7284E7B509B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 05:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77EF1A5B8B;
	Fri,  2 May 2025 05:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3tGq5cE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA319FA92;
	Fri,  2 May 2025 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746163628; cv=none; b=ca+GgkKfxP0LN1tfyQ6t6Cg5GuQkx7fXsvURdsYtsweuYodJnNjiJDpTGaP1BqwglwNC0pUYzuX9QhZdom3mVrif6JJKxb9AQjHsZN4PDrZ9sZPYJMc3UNHOXmOPc9M8mxAt3rIYyoHYQcLj8K6apFRC3oAnykoYGLKniWSlflI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746163628; c=relaxed/simple;
	bh=odnSgFOdLirjt31NXo38qQN3PopxkzqFcHC2l+WN2jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdlWGam4n4Vaiqk8Lw/uQcUjH3MBebeQC6wPFG5OJiMLd113exSUEvm0r/ui2+EXZf4bN8F+VEcdMgaaIktokrRaxYNk4TaXN0+VfTorxkHrzaZYMn0lmAHeFbmMfi99yI+cEaGPAWr6ZglREtrFcdgmJBHUwlAz6kDctzzpg4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3tGq5cE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22c33677183so18577005ad.2;
        Thu, 01 May 2025 22:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746163626; x=1746768426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+W2gnRsUS77xnxOlsuFy4TaTnkNyy8cVJp3jeOpEsVI=;
        b=e3tGq5cEQQOJiWHk+T7m3vXOrOtzHDrOEepr1Xgq0tmxdsoXP2KHO8ZE8zhT9buPaT
         kVBkGbk1YcSzAAJ/8123PQnWLFjm8EvYOVDmPR5RBi7IYoCDaFh5QQWxhOr21YbJ8sg5
         NLgHXcb0kyf8MpwfRVukAuFkYZCn729Jd1dG8oH/uXKiJvZNufmBkKIriO52RLy0oCXi
         37jbajfbfKMCVmxTV4e8G3h9KuMXPCuKvfolWBHAf9Z9u+8SnWJAjpKT0oMYeY837qfP
         FaDv5HOuxC1XDPINZRmgAYdmPrYpX/J0gP/kZK4vzWLuGXqPJ11JwXgJeBi+JezCOOdG
         Ahlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746163626; x=1746768426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+W2gnRsUS77xnxOlsuFy4TaTnkNyy8cVJp3jeOpEsVI=;
        b=nhfw4qhPRXnasjmPaBq1zL+IdtLMpio0W8bLDpw+tBLHsUul/5l4FiqiLQrxWHjNDF
         4EdPknyQQK47P78Fyqvtpjm8JAResc443doWmRasDOmw2D4yTB1JFkbzF5bL8p0QCbO7
         MMz4cCkDJ5a/nDKIk5PvysqisSwz7fenknEriy3LUp3UzteJJU9niKOhEqt0jEpqw8IS
         DUuSQQn2YdVMkRXGgoO2W541L899zOwNdoDgbA+D4g9q5wNsFxO3790gGvzfCecAGDUg
         +nprx4TcLcNbPVUBGq/iMGFNGSBl0AAmRoWggq/yMOUzrb4cTyZGEMVY+fFuak/RpJls
         Ekaw==
X-Forwarded-Encrypted: i=1; AJvYcCVFlFpZXAp9z115/8DvElclSInPPU3V/TQ4BXt54TqibYWwusj8c82xwXyEqkysia6DsT4KFxC0@vger.kernel.org, AJvYcCVa7HjiNozwc+kbGaBLEkPOEidPqc9xML5Jtr4E4GqrGiLhQy02RDrhNDSSYavq/GbAxEXvd1PGXST9mgRyQfNc@vger.kernel.org, AJvYcCWCXBlfV5/iBqCkgBESSIo7lbNLsfrkYqnl866rpoEJwlik7iyC0uL1tRGfZU+n+63zHr/OJdnqgM3XZng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcB3wl3sTdApGuAWG5rIoXh3qCa8KQ7UqWcCBg38dSWCBeJpI2
	9fNbOedrrkycu0dLl95L6/EdOcUGtYQxvSdAzw7ZfkTIDkDGNXVz
X-Gm-Gg: ASbGncsAgg/AtQUJrTIpJy6tpgZC99l3wuXsNFcyrcP/khqtiFnb05dXv/gxSKaFeDu
	CtdrY57MhPByQaQAiW5hkP6I9D4ls7Oynw+O0tfDYxphFaXdcqTVUnIOZ2Z230/oAYzcxgSWAzy
	lE/PDO4hTuI6w1sjf+SX78IXEaiUmv3fFAeflRxUsmnPuubuKXGCu/nN21fLd83YBndQpi9W8nr
	35ErCSMa4q6Gn9Lj4bxbsuttfP4Bn6W21DmSXkQhWSk/K5jmkZfD0v/VtMmJ5cgds3RRNzYFVLq
	2tVYZi8sX1kPfo5CqjjPZAHxd2OFYJ9JBWOpPA0kx6Ysrp/nnU7L
X-Google-Smtp-Source: AGHT+IFWrQwlpkVyXxjGvHZeT39/NVv9qbuhV9CxCJCg9MzVFBK2ltUETHQhVW3N12k0BGHumI/KFg==
X-Received: by 2002:a17:903:990:b0:21f:988d:5756 with SMTP id d9443c01a7336-22e103dd494mr27747255ad.42.1746163626394;
        Thu, 01 May 2025 22:27:06 -0700 (PDT)
Received: from gmail.com ([98.97.38.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e10941869sm5612295ad.258.2025.05.01.22.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 22:27:05 -0700 (PDT)
Date: Thu, 1 May 2025 22:26:48 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, mrpre@163.com, Boris Pismenny <borisp@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 0/2] ktls, sockmap: Fix missing uncharge
 operation and add selfttest
Message-ID: <20250502052648.4tcxptx6xbcnpoyt@gmail.com>
References: <20250425060015.6968-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425060015.6968-1-jiayuan.chen@linux.dev>

On 2025-04-25 13:59:56, Jiayuan Chen wrote:
> Cong reported a warning when running ./test_sockmp:
> https://lore.kernel.org/bpf/aAmIi0vlycHtbXeb@pop-os.localdomain/T/#t
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 40 at net/ipv4/af_inet.c inet_sock_destruct+0x173/0x1d5
> Tainted: [W]=WARN
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
> Workqueue: events sk_psock_destroy
> RIP: 0010:inet_sock_destruct+0x173/0x1d5
> RSP: 0018:ffff8880085cfc18 EFLAGS: 00010202
> RAX: 1ffff11003dbfc00 RBX: ffff88801edfe3e8 RCX: ffffffff822f5af4
> RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff88801edfe16c
> RBP: ffff88801edfe184 R08: ffffed1003dbfc31 R09: 0000000000000000
> R10: ffffffff822f5ab7 R11: ffff88801edfe187 R12: ffff88801edfdec0
> R13: ffff888020376ac0 R14: ffff888020376ac0 R15: ffff888020376a60
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000556365155830 CR3: 000000001d6aa000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  __sk_destruct+0x46/0x222
>  sk_psock_destroy+0x22f/0x242
>  process_one_work+0x504/0x8a8
>  ? process_one_work+0x39d/0x8a8
>  ? __pfx_process_one_work+0x10/0x10
>  ? worker_thread+0x44/0x2ae
>  ? __list_add_valid_or_report+0x83/0xea
>  ? srso_return_thunk+0x5/0x5f
>  ? __list_add+0x45/0x52
>  process_scheduled_works+0x73/0x82
>  worker_thread+0x1ce/0x2ae
> 
> 
> When we specify apply_bytes, we divide the msg into multiple segments,
> each with a length of 'send', and every time we send this part of the data
> using tcp_bpf_sendmsg_redir(), we use sk_msg_return_zero() to uncharge the
> memory of the specified 'send' size.
> 
> However, if the first segment of data fails to send, for example, the
> peer's buffer is full, we need to release all of the msg. When releasing
> the msg, we haven't uncharged the memory of the subsequent segments.
> 
> This modification does not make significant logical changes, but only
> fills in the missing uncharge places.
> 
> This issue has existed all along, until it was exposed after we added the
> apply test in test_sockmap:
> 
> commit 3448ad23b34e ("selftests/bpf: Add apply_bytes test to test_txmsg_redir_wait_sndmem in test_sockmap")
> 
> 
> Jiayuan Chen (2):
>   ktls, sockmap: Fix missing uncharge operation
>   selftests/bpf: Add test to cover sockmap with ktls

For the series thanks Jiayuan for poking into the kTLS side. I doubt
anyone has used kTLS+apply_bytes yet. Thanks.

For me.

Acked-by: John Fastabend <john.fastabend@gmail.com>

