Return-Path: <linux-kselftest+bounces-6930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 158E089348D
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Mar 2024 19:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80FF2B22CFB
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Mar 2024 17:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB6115F304;
	Sun, 31 Mar 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm8qb98v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE2315EFAA;
	Sun, 31 Mar 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903428; cv=fail; b=ByppSMj6PUTnaXq0AXSEXkz3hmbm+rkAYzZZP2yq4YNyRXBgX9xZj8YaJcNCas11wXAs6d9z6xOuV+we4uFu8ozod2XAwp5eg7xp7OBX7jsf6EFuv7av9Gu+uNo7YTcf3sCQAe+UzLTCMKiVmUe7VM8yNqh5nsjIQUUBZBqHOdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903428; c=relaxed/simple;
	bh=+ZbtEd24OimYPDQNp3fBs5mySaqN52R2qe88Kp7dJCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpiuZbtE7NmaYKQ708klOHWahwTTg42lv/SDRMLRRtLqVjeUQfVUTkoqRgX6GZEnjV4KJLeiq5vq6abupEZ6F3cJIUhv27QZDtCr5cm8tb2fLqJYlsCjZcFNLsfXY86/m1bKMnv76OOsccoMNZRv9gm7NRpR7UDln8PXkfqGxA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fm8qb98v reason="signature verification failed"; arc=none smtp.client-ip=209.85.215.169; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 42ACD208BE;
	Sun, 31 Mar 2024 18:43:44 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qCOHV2eYTu5k; Sun, 31 Mar 2024 18:43:43 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7CA62208CB;
	Sun, 31 Mar 2024 18:43:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7CA62208CB
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 6E0BC800060;
	Sun, 31 Mar 2024 18:43:40 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:40 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:45 +0000
X-sender: <netdev+bounces-83483-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=rfc822;peter.schumann@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAn0qmlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 13968
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83483-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com E81A7200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm8qb98v"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711754928; cv=none; b=BiF0sOPYXhrbjY9cOS6Nmj4VXF++Yx8MtZjBDxanMefli+BulHO4QXKn7qwpW3i+7uN65u5cLGhThPJZ2akcLjIgY9UcOJfH9j6D484gs+N5O8HXdnQzg8eZ93GRBeBoDesuvP5WyVY1RlteRQZLbYRhS27z9mKgIzxIt2bJ+Zo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711754928; c=relaxed/simple;
	bh=M+CkTC/9QOPKjcAq26pJFK75aD0g4y2+LXJsB0P1JY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lu4xUrtWjk3J0kbVbPD5XAlV9JEyhRuyqvveB8mIxkffhtOM1Y7m4+o5XzftYMKn592GD5CBw41tS2CCKYzMtaJurKzqjxkWsFCCe3ELmR9AEyVvEBDa4PpVwvE2aS0et1z2P9rOIk0ldc7OMYPnDpWEu3jfzLxb8Y4CGi6sJbE=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fm8qb98v; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711754926; x=1712359726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvV1tZGanDBSafK6edOdycvbQYDEdHbTCxngJvsvk3c=;
        b=Fm8qb98vO+2rZQDr4ACVbzWOOBhMbNP973of56VDx+7dzKarS23b4VDs0QCZjE/zey
         IJ/g2gwkTlDZp557gqFy6HVirUKvvI/RhzQOrPjsYmqnt0OS+LXZWxBGcD9ooJmS1u1N
         Wdq60dFcb/ee3JYL5bUFYzr07cJmwvvmIZoI/b1KQpo+K6ftMzexzXAN8iXh1nJo1QdC
         4CFMaxfeoUIzc6fyg2ScGW/5rPdZFOXPIXIjGrA7V7Ij1KqAkHvKfDNzy1QS7jMz6z0E
         /W8l0QAzZuWpon/+MGFe6iPNG81xSsUfka4lIyvOK31ZY63E/sqixJRnh7RpDV18WsJY
         CtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711754926; x=1712359726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvV1tZGanDBSafK6edOdycvbQYDEdHbTCxngJvsvk3c=;
        b=RU6CYGdij3I8SMDFuLcEkXFxxuMDLhpfo6RmyHf+rD3z+RBxrsmoJ1YligUcYT3VoL
         YtUHguMvFF7xT9YjyGrK4ujkEA13NT+X1hwUNhKsWaXhpLBG2Wyh4eNaw4zkHN28eYkq
         dj4reqkSxtXQvjpns3NtubA0ld6+woHqICxMQVR26maDt91aYEPooASIjOoCRnxMnIpI
         KqBMby8F8aarmJfc6c16rp9hDJK1Cr34usuvnIOrnJ2bdp2qTCOMpl6ARzTAtPA9p7n7
         9p9R345kssoRHOmDzo2WcF/0oG4wRjb+owNVpsCTExoqfee0d+FSjcyFxitgRQvMQzcC
         9Pqw==
X-Forwarded-Encrypted: i=1; AJvYcCVlnHyNUDZ0fbOQSV0NEVvOtJTaOmaxwPgZy047hqztaIz7SMsnLeomStI1EizImJzlky/xJNYIS4RJsXEX2rbQoVyo7MFG2+RfwxWnjGonfBHU0k5JSlRGPFtF8Te8neu3qxCi25AWVXDje1k1qkzJLjDnQ+s4R4WJmDmbw/KdNN4l/EBnMx0Wq+GOvmC+DkjFlyebAZoKGfgwdw8BgI1xISF1T+wxXijKToVLbwSSua486L4tXm8nE4lXExEMG+QxE02AxDYDKshvWmyLqPiNewg+cXpbihxLyg==
X-Gm-Message-State: AOJu0YwCezoL4rml44Ulwt5kaSYk47W3cr0evd5PMAYC8La4m9gnILHN
	FRelRR6zMz1Bz2qJo3eFKeNyq28N5Yo0kJIQ72rv0EkZFGKfSnjbac0fnT9zQAwbNl/tFnTmfuG
	Y3REKAMgIbWmVvmHWWGOk0v3R69U=
X-Google-Smtp-Source: AGHT+IFNbTnA2C1UowyvpIWfWMecar3RYOVPJRlOoVy5NMmPOOKB6ZhvqfzCxbpKkf/w3Z3THbX/GA+A1iwjf07EvPY=
X-Received: by 2002:a17:90a:be04:b0:2a2:1415:723d with SMTP id
 a4-20020a17090abe0400b002a21415723dmr3177860pjs.42.1711754926271; Fri, 29 Mar
 2024 16:28:46 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-2-dongmenglong.8@bytedance.com> <CAADnVQKQPS5NcvEouH4JqZ2fKgQAC+LtcwhX9iXYoiEkF_M94Q@mail.gmail.com>
 <CALz3k9i5G5wWi+rtvHPwVLOUAXVMCiU_8QUZs87TEYgR_0wpPA@mail.gmail.com>
 <CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail.com>
 <CALz3k9icPePb0c4FE67q=u1U0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
 <CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
 <CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
 <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>
 <CALz3k9g-U8ih=ycJPRbyU9x_9cp00fNkU3PGQ6jP0WJ+=uKmqQ@mail.gmail.com>
 <CALz3k9jG5Jrqw=BGjt05yMkEF-1u909GbBYrV-02W0dQtm6KQQ@mail.gmail.com> <20240328111330.194dcbe5@gandalf.local.home>
In-Reply-To: <20240328111330.194dcbe5@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 16:28:33 -0700
Message-ID: <CAEf4BzYgzOti+Hfdn3SUCjuofGedXRSGApVDD+K2TdG6oNE-pw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
To: Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Mar 28, 2024 at 8:10=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 28 Mar 2024 22:43:46 +0800
> =E6=A2=A6=E9=BE=99=E8=91=A3 <dongmenglong.8@bytedance.com> wrote:
>
> > I have done a simple benchmark on creating 1000
> > trampolines. It is slow, quite slow, which consume up to
> > 60s. We can't do it this way.
> >
> > Now, I have a bad idea. How about we introduce
> > a "dynamic trampoline"? The basic logic of it can be:
> >
> > """
> > save regs
> > bpfs =3D trampoline_lookup_ip(ip)
> > fentry =3D bpfs->fentries
> > while fentry:
> >   fentry(ctx)
> >   fentry =3D fentry->next
> >
> > call origin
> > save return value
> >
> > fexit =3D bpfs->fexits
> > while fexit:
> >   fexit(ctx)
> >   fexit =3D fexit->next
> >
> > xxxxxx
> > """
> >
> > And we lookup the "bpfs" by the function ip in a hash map
> > in trampoline_lookup_ip. The type of "bpfs" is:
> >
> > struct bpf_array {
> >   struct bpf_prog *fentries;
> >  struct bpf_prog *fexits;
> >   struct bpf_prog *modify_returns;
> > }
> >
> > When we need to attach the bpf progA to function A/B/C,
> > we only need to create the bpf_arrayA, bpf_arrayB, bpf_arrayC
> > and add the progA to them, and insert them to the hash map
> > "direct_call_bpfs", and attach the "dynamic trampoline" to
> > A/B/C. If bpf_arrayA exist, just add progA to the tail of
> > bpf_arrayA->fentries. When we need to attach progB to
> > B/C, just add progB to bpf_arrayB->fentries and
> > bpf_arrayB->fentries.
> >
> > Compared to the trampoline, extra overhead is introduced
> > by the hash lookuping.
> >
> > I have not begun to code yet, and I am not sure the overhead is
> > acceptable. Considering that we also need to do hash lookup
> > by the function in kprobe_multi, maybe the overhead is
> > acceptable?
>
> Sounds like you are just recreating the function management that ftrace
> has. It also can add thousands of trampolines very quickly, because it do=
es
> it in batches. It takes special synchronization steps to attach to fentry=
.
> ftrace (and I believe multi-kprobes) updates all the attachments for each
> step, so the synchronization needed is only done once.
>
> If you really want to have thousands of functions, why not just register =
it
> with ftrace itself. It will give you the arguments via the ftrace_regs
> structure. Can't you just register a program as the callback?
>
> It will probably make your accounting much easier, and just let ftrace
> handle the fentry logic. That's what it was made to do.
>

I thought I'll just ask instead of digging through code, sorry for
being lazy :) Is there any way to pass pt_regs/ftrace_regs captured
before function execution to a return probe (fexit/kretprobe)? I.e.,
how hard is it to pass input function arguments to a kretprobe? That's
the biggest advantage of fexit over kretprobe, and if we can make
these original pt_regs/ftrace_regs available to kretprobe, then
multi-kretprobe will effectively be this multi-fexit.

> -- Steve

X-sender: <linux-kernel+bounces-125526-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAoEqmlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 13867
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 00:29:11 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Sat, 30 Mar 2024 00:29:11 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 97DA5208A6
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 00:29:11 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.749
X-Spam-Level:
X-Spam-Status: No, score=-2.749 tagged_above=-999 required=2.1
	tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
	DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
	FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
	MAILING_LIST_MULTI=-1, RCVD_IN_DNSWL_NONE=-0.0001,
	SPF_HELO_NONE=0.001, SPF_PASS=-0.001]
	autolearn=unavailable autolearn_force=no
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=pass (2048-bit key) header.d=gmail.com
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id auCb2c0hRYxs for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 00:29:11 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125526-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com F33F320870
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id F33F320870
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 00:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFD21F22615
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4738413E6BF;
	Fri, 29 Mar 2024 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm8qb98v"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE5347B6;
	Fri, 29 Mar 2024 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711754928; cv=none; b=BiF0sOPYXhrbjY9cOS6Nmj4VXF++Yx8MtZjBDxanMefli+BulHO4QXKn7qwpW3i+7uN65u5cLGhThPJZ2akcLjIgY9UcOJfH9j6D484gs+N5O8HXdnQzg8eZ93GRBeBoDesuvP5WyVY1RlteRQZLbYRhS27z9mKgIzxIt2bJ+Zo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711754928; c=relaxed/simple;
	bh=M+CkTC/9QOPKjcAq26pJFK75aD0g4y2+LXJsB0P1JY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lu4xUrtWjk3J0kbVbPD5XAlV9JEyhRuyqvveB8mIxkffhtOM1Y7m4+o5XzftYMKn592GD5CBw41tS2CCKYzMtaJurKzqjxkWsFCCe3ELmR9AEyVvEBDa4PpVwvE2aS0et1z2P9rOIk0ldc7OMYPnDpWEu3jfzLxb8Y4CGi6sJbE=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fm8qb98v; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d3907ff128so1860607a12.3;
        Fri, 29 Mar 2024 16:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711754926; x=1712359726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvV1tZGanDBSafK6edOdycvbQYDEdHbTCxngJvsvk3c=;
        b=Fm8qb98vO+2rZQDr4ACVbzWOOBhMbNP973of56VDx+7dzKarS23b4VDs0QCZjE/zey
         IJ/g2gwkTlDZp557gqFy6HVirUKvvI/RhzQOrPjsYmqnt0OS+LXZWxBGcD9ooJmS1u1N
         Wdq60dFcb/ee3JYL5bUFYzr07cJmwvvmIZoI/b1KQpo+K6ftMzexzXAN8iXh1nJo1QdC
         4CFMaxfeoUIzc6fyg2ScGW/5rPdZFOXPIXIjGrA7V7Ij1KqAkHvKfDNzy1QS7jMz6z0E
         /W8l0QAzZuWpon/+MGFe6iPNG81xSsUfka4lIyvOK31ZY63E/sqixJRnh7RpDV18WsJY
         CtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711754926; x=1712359726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvV1tZGanDBSafK6edOdycvbQYDEdHbTCxngJvsvk3c=;
        b=RU6CYGdij3I8SMDFuLcEkXFxxuMDLhpfo6RmyHf+rD3z+RBxrsmoJ1YligUcYT3VoL
         YtUHguMvFF7xT9YjyGrK4ujkEA13NT+X1hwUNhKsWaXhpLBG2Wyh4eNaw4zkHN28eYkq
         dj4reqkSxtXQvjpns3NtubA0ld6+woHqICxMQVR26maDt91aYEPooASIjOoCRnxMnIpI
         KqBMby8F8aarmJfc6c16rp9hDJK1Cr34usuvnIOrnJ2bdp2qTCOMpl6ARzTAtPA9p7n7
         9p9R345kssoRHOmDzo2WcF/0oG4wRjb+owNVpsCTExoqfee0d+FSjcyFxitgRQvMQzcC
         9Pqw==
X-Forwarded-Encrypted: i=1; AJvYcCVlnHyNUDZ0fbOQSV0NEVvOtJTaOmaxwPgZy047hqztaIz7SMsnLeomStI1EizImJzlky/xJNYIS4RJsXEX2rbQoVyo7MFG2+RfwxWnjGonfBHU0k5JSlRGPFtF8Te8neu3qxCi25AWVXDje1k1qkzJLjDnQ+s4R4WJmDmbw/KdNN4l/EBnMx0Wq+GOvmC+DkjFlyebAZoKGfgwdw8BgI1xISF1T+wxXijKToVLbwSSua486L4tXm8nE4lXExEMG+QxE02AxDYDKshvWmyLqPiNewg+cXpbihxLyg==
X-Gm-Message-State: AOJu0YwCezoL4rml44Ulwt5kaSYk47W3cr0evd5PMAYC8La4m9gnILHN
	FRelRR6zMz1Bz2qJo3eFKeNyq28N5Yo0kJIQ72rv0EkZFGKfSnjbac0fnT9zQAwbNl/tFnTmfuG
	Y3REKAMgIbWmVvmHWWGOk0v3R69U=
X-Google-Smtp-Source: AGHT+IFNbTnA2C1UowyvpIWfWMecar3RYOVPJRlOoVy5NMmPOOKB6ZhvqfzCxbpKkf/w3Z3THbX/GA+A1iwjf07EvPY=
X-Received: by 2002:a17:90a:be04:b0:2a2:1415:723d with SMTP id
 a4-20020a17090abe0400b002a21415723dmr3177860pjs.42.1711754926271; Fri, 29 Mar
 2024 16:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-2-dongmenglong.8@bytedance.com> <CAADnVQKQPS5NcvEouH4JqZ2fKgQAC+LtcwhX9iXYoiEkF_M94Q@mail.gmail.com>
 <CALz3k9i5G5wWi+rtvHPwVLOUAXVMCiU_8QUZs87TEYgR_0wpPA@mail.gmail.com>
 <CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail.com>
 <CALz3k9icPePb0c4FE67q=u1U0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
 <CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
 <CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
 <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>
 <CALz3k9g-U8ih=ycJPRbyU9x_9cp00fNkU3PGQ6jP0WJ+=uKmqQ@mail.gmail.com>
 <CALz3k9jG5Jrqw=BGjt05yMkEF-1u909GbBYrV-02W0dQtm6KQQ@mail.gmail.com> <20240328111330.194dcbe5@gandalf.local.home>
In-Reply-To: <20240328111330.194dcbe5@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 16:28:33 -0700
Message-ID: <CAEf4BzYgzOti+Hfdn3SUCjuofGedXRSGApVDD+K2TdG6oNE-pw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
To: Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: linux-kernel+bounces-125526-steffen.klassert=secunet.com@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 23:29:11.6433
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 735e0fdb-3f55-4a65-f575-08dc50480a0f
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.secunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=cas-essen-01.secunet.de:TOTAL-FE=0.008|SMR=0.008(SMRPI=0.005(SMRPI-FrontendProxyAgent=0.005));2024-03-29T23:29:11.651Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 13320
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=Low
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy

On Thu, Mar 28, 2024 at 8:10=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 28 Mar 2024 22:43:46 +0800
> =E6=A2=A6=E9=BE=99=E8=91=A3 <dongmenglong.8@bytedance.com> wrote:
>
> > I have done a simple benchmark on creating 1000
> > trampolines. It is slow, quite slow, which consume up to
> > 60s. We can't do it this way.
> >
> > Now, I have a bad idea. How about we introduce
> > a "dynamic trampoline"? The basic logic of it can be:
> >
> > """
> > save regs
> > bpfs =3D trampoline_lookup_ip(ip)
> > fentry =3D bpfs->fentries
> > while fentry:
> >   fentry(ctx)
> >   fentry =3D fentry->next
> >
> > call origin
> > save return value
> >
> > fexit =3D bpfs->fexits
> > while fexit:
> >   fexit(ctx)
> >   fexit =3D fexit->next
> >
> > xxxxxx
> > """
> >
> > And we lookup the "bpfs" by the function ip in a hash map
> > in trampoline_lookup_ip. The type of "bpfs" is:
> >
> > struct bpf_array {
> >   struct bpf_prog *fentries;
> >  struct bpf_prog *fexits;
> >   struct bpf_prog *modify_returns;
> > }
> >
> > When we need to attach the bpf progA to function A/B/C,
> > we only need to create the bpf_arrayA, bpf_arrayB, bpf_arrayC
> > and add the progA to them, and insert them to the hash map
> > "direct_call_bpfs", and attach the "dynamic trampoline" to
> > A/B/C. If bpf_arrayA exist, just add progA to the tail of
> > bpf_arrayA->fentries. When we need to attach progB to
> > B/C, just add progB to bpf_arrayB->fentries and
> > bpf_arrayB->fentries.
> >
> > Compared to the trampoline, extra overhead is introduced
> > by the hash lookuping.
> >
> > I have not begun to code yet, and I am not sure the overhead is
> > acceptable. Considering that we also need to do hash lookup
> > by the function in kprobe_multi, maybe the overhead is
> > acceptable?
>
> Sounds like you are just recreating the function management that ftrace
> has. It also can add thousands of trampolines very quickly, because it do=
es
> it in batches. It takes special synchronization steps to attach to fentry=
.
> ftrace (and I believe multi-kprobes) updates all the attachments for each
> step, so the synchronization needed is only done once.
>
> If you really want to have thousands of functions, why not just register =
it
> with ftrace itself. It will give you the arguments via the ftrace_regs
> structure. Can't you just register a program as the callback?
>
> It will probably make your accounting much easier, and just let ftrace
> handle the fentry logic. That's what it was made to do.
>

I thought I'll just ask instead of digging through code, sorry for
being lazy :) Is there any way to pass pt_regs/ftrace_regs captured
before function execution to a return probe (fexit/kretprobe)? I.e.,
how hard is it to pass input function arguments to a kretprobe? That's
the biggest advantage of fexit over kretprobe, and if we can make
these original pt_regs/ftrace_regs available to kretprobe, then
multi-kretprobe will effectively be this multi-fexit.

> -- Steve


