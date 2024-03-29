Return-Path: <linux-kselftest+bounces-6927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5788689334E
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Mar 2024 18:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B20E1C224C0
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Mar 2024 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985EE15624B;
	Sun, 31 Mar 2024 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm8qb98v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4F4148301;
	Sun, 31 Mar 2024 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902523; cv=fail; b=kKsyRV6KuupbY50V9TFDsmOHUVWt0hLwVANML+Psm+JYtLqHly1Y1YBCTwQwKSV4lZOhmRc54Ytf0Xp4m2TPCMoi0n9V4C3wtGJqYd990OQjPPIwq/aVbq7H8Vk0PkDvubZ08on3rOiDEgFZ5ntBt5+MvUNSlhL6fgfrsu9iqgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902523; c=relaxed/simple;
	bh=VCyTXA7wDoiUkGQYK52m4k+Emz+pmK31SqPX6uC7+oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpuEWBMKhlp5Z7W7VlM36nLxWdZxwTTsAk39EeTBmubfBEAj/mHc6t0aq3jiVOitj1/3jCsSL5zWak6LpCeYx56+wV02xLXr5Zyy3iUIxFRNB5MQMKN1uhCn47gYLU0iF50FWw5leWKcptsZe2bENFRpRQbI4QTbbVdCbyvADCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fm8qb98v reason="signature verification failed"; arc=none smtp.client-ip=209.85.215.169; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 80546208D1;
	Sun, 31 Mar 2024 18:28:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EUMHkouClTYE; Sun, 31 Mar 2024 18:28:35 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 54C8D208DE;
	Sun, 31 Mar 2024 18:28:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 54C8D208DE
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 47B04800058;
	Sun, 31 Mar 2024 18:28:31 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:28:31 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:36 +0000
X-sender: <netdev+bounces-83483-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAw5Tp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBtAAAAjYoAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 19895
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

X-sender: <netdev+bounces-83483-steffen.klassert=3Dcunet.com@vger.kernel.or=
g>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Dc822;steffen.klassert@se=
cunet.com NOTIFY=3DVER; X-ExtendedProps=3DAVABYAAgAAAAUAFAARAPDFCS25BAlDktI=
I2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSX=
NSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAA=
AUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChG=
WURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwA=
XAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG=
1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHc=
m91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29u=
ZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAw=
AAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC=
5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAAB=
QBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1V=
c2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1J=
lc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb=
3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=0A=
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAo5Tp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBuAAAAjYoAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=0A=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 19722
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DS1_2, cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 00:29:03 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DS1_2,
 cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Sat, 30 Mar 2024 00:29:03 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D07E8208A6
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 00:29:03 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.049
X-Spam-Level:
X-Spam-Status: No, score=3D.049 tagged_above=3D99 required=3D1
	tests=3DAYES_00=3D.9, DKIM_SIGNED=3D1, DKIM_VALID=3D.1,
	DKIM_VALID_AU=3D.1, FREEMAIL_FORGED_FROMDOMAIN=3D001,
	FREEMAIL_FROM=3D001, HEADER_FROM_DIFFERENT_DOMAINS=3D249,
	MAILING_LIST_MULTI=3D, RCVD_IN_DNSWL_MED=3D.3, SPF_HELO_NONE=3D001,
	SPF_PASS=3D.001] autolearn=3Dm autolearn_force=3D
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dss (2048-bit key) header.d=3Dail.com
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ex4lJg4QxVwR for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 00:29:02 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dilfrom; client-ip=139=
.178.88.99; helo=3D.mirrors.kernel.org; envelope-from=3Dtdev+bounces-83483-=
steffen.klassert=3Dcunet.com@vger.kernel.org; receiver=3Deffen.klassert@sec=
unet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1CA0120870
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1CA0120870
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 00:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E018C2831AB
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1120F13E40E;
	Fri, 29 Mar 2024 23:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dss (2048-bit key) header.d=3Dail.com header.i=3Dmail.com header.b=
=3Dm8qb98v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.2=
15.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE5347B6;
	Fri, 29 Mar 2024 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dne smtp.client-ip 9=
.85.215.169
ARC-Seal: i=3D a=3Da-sha256; d=3Dbspace.kernel.org; s=3Dc-20240116;
	t=1711754928; cv=3Dne; b=3DF0sOPYXhrbjY9cOS6Nmj4VXF++Yx8MtZjBDxanMefli+Bul=
HO4QXKn7qwpW3i+7uN65u5cLGhThPJZ2akcLjIgY9UcOJfH9j6D484gs+N5O8HXdnQzg8eZ93GR=
BeBoDesuvP5WyVY1RlteRQZLbYRhS27z9mKgIzxIt2bJ+ZoARC-Message-Signature: i=3D =
a=3Da-sha256; d=3Dbspace.kernel.org;
	s=3Dc-20240116; t=1711754928; c=3Dlaxed/simple;
	bh=3DCkTC/9QOPKjcAq26pJFK75aD0g4y2+LXJsB0P1JY0=3D=0A=
	h=3DME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=3D4xUrtWjk3J0kbVbPD5XAlV9JEyhRuyqvveB8mIxkffhtOM1Y7=
m4+o5XzftYMKn592GD5CBw41tS2CCKYzMtaJurKzqjxkWsFCCe3ELmR9AEyVvEBDa4PpVwvE2aS=
0et1z2P9rOIk0ldc7OMYPnDpWEu3jfzLxb8Y4CGi6sJbEARC-Authentication-Results: i=
=3D smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3Dne) header.from=3Dai=
l.com; spf=3Dss smtp.mailfrom=3Dail.com; dkim=3Dss (2048-bit key) header.d=
=3Dail.com header.i=3Dmail.com header.b=3D8qb98v; arc=3Dne smtp.client-ip 9=
.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3D=
ne) header.from=3Dail.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dss smtp.mailfrom=3D=
ail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d3907ff12=
8so1860607a12.3;
        Fri, 29 Mar 2024 16:28:46 -0700 (PDT)
DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=3Dail.com; s 230601; t=1711754926; x=1712359726; darn=3Der.kernel=
.org;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DV1tZGanDBSafK6edOdycvbQYDEdHbTCxngJvsvk3c=3D=0A=
        b=3D8qb98vO+2rZQDr4ACVbzWOOBhMbNP973of56VDx+7dzKarS23b4VDs0QCZjE/ze=
y
         IJ/g2gwkTlDZp557gqFy6HVirUKvvI/RhzQOrPjsYmqnt0OS+LXZWxBGcD9ooJmS1u=
1N
         Wdq60dFcb/ee3JYL5bUFYzr07cJmwvvmIZoI/b1KQpo+K6ftMzexzXAN8iXh1nJo1Q=
dC
         4CFMaxfeoUIzc6fyg2ScGW/5rPdZFOXPIXIjGrA7V7Ij1KqAkHvKfDNzy1QS7jMz6z=
0E
         /W8l0QAzZuWpon/+MGFe6iPNG81xSsUfka4lIyvOK31ZY63E/sqixJRnh7RpDV18Ws=
JY
         CtMw=3D=0A=
X-Google-DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=1E100.net; s 230601; t=1711754926; x=1712359726;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DV1tZGanDBSafK6edOdycvbQYDEdHbTCxngJvsvk3c=3D=0A=
        b=3D6CYGdij3I8SMDFuLcEkXFxxuMDLhpfo6RmyHf+rD3z+RBxrsmoJ1YligUcYT3Vo=
L
         YtUHguMvFF7xT9YjyGrK4ujkEA13NT+X1hwUNhKsWaXhpLBG2Wyh4eNaw4zkHN28eY=
kq
         dj4reqkSxtXQvjpns3NtubA0ld6+woHqICxMQVR26maDt91aYEPooASIjOoCRnxMnI=
pI
         KqBMby8F8aarmJfc6c16rp9hDJK1Cr34usuvnIOrnJ2bdp2qTCOMpl6ARzTAtPA9p7=
n7
         9p9R345kssoRHOmDzo2WcF/0oG4wRjb+owNVpsCTExoqfee0d+FSjcyFxitgRQvMQz=
cC
         9Pqw=3D=0A=
X-Forwarded-Encrypted: i=3D AJvYcCVlnHyNUDZ0fbOQSV0NEVvOtJTaOmaxwPgZy047hqz=
taIz7SMsnLeomStI1EizImJzlky/xJNYIS4RJsXEX2rbQoVyo7MFG2+RfwxWnjGonfBHU0k5JSl=
RGPFtF8Te8neu3qxCi25AWVXDje1k1qkzJLjDnQ+s4R4WJmDmbw/KdNN4l/EBnMx0Wq+GOvmC+D=
kjFlyebAZoKGfgwdw8BgI1xISF1T+wxXijKToVLbwSSua486L4tXm8nE4lXExEMG+QxE02AxDYD=
KshvWmyLqPiNewg+cXpbihxLyg=3D=0A=
X-Gm-Message-State: AOJu0YwCezoL4rml44Ulwt5kaSYk47W3cr0evd5PMAYC8La4m9gnILH=
N
	FRelRR6zMz1Bz2qJo3eFKeNyq28N5Yo0kJIQ72rv0EkZFGKfSnjbac0fnT9zQAwbNl/tFnTmfu=
G
	Y3REKAMgIbWmVvmHWWGOk0v3R69UX-Google-Smtp-Source: AGHT+IFNbTnA2C1UowyvpIWf=
WMecar3RYOVPJRlOoVy5NMmPOOKB6ZhvqfzCxbpKkf/w3Z3THbX/GA+A1iwjf07EvPYX-Receiv=
ed: by 2002:a17:90a:be04:b0:2a2:1415:723d with SMTP id
 a4-20020a17090abe0400b002a21415723dmr3177860pjs.42.1711754926271; Fri, 29 =
Mar
 2024 16:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-2-dongmenglong.8@bytedance.com> <CAADnVQKQPS5NcvEo=
uH4JqZ2fKgQAC+LtcwhX9iXYoiEkF_M94Q@mail.gmail.com>
 <CALz3k9i5G5wWi+rtvHPwVLOUAXVMCiU_8QUZs87TEYgR_0wpPA@mail.gmail.com>
 <CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail.com>
 <CALz3k9icPePb0c4FE67q=3DU0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
 <CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
 <CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
 <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>
 <CALz3k9g-U8ih=3DJPRbyU9x_9cp00fNkU3PGQ6jP0WJ+=3DmqQ@mail.gmail.com>
 <CALz3k9jG5Jrqw=3Djt05yMkEF-1u909GbBYrV-02W0dQtm6KQQ@mail.gmail.com> <2024=
0328111330.194dcbe5@gandalf.local.home>
In-Reply-To: <20240328111330.194dcbe5@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 16:28:33 -0700
Message-ID: <CAEf4BzYgzOti+Hfdn3SUCjuofGedXRSGApVDD+K2TdG6oNE-pw@mail.gmail=
.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add suppo=
rt
 to record and check the accessed args
To: Steven Rostedt <rostedt@goodmis.org>
Cc: =3DTF-8?B?5qKm6b6Z6JGj?=3Dongmenglong.8@bytedance.com>,=20
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@kernel=
.org>,=20
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,=
=20
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux=
.dev>, Eddy Z <eddyz87@gmail.com>,=20
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,=20
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,=
=20
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,=20
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntra=
eger@linux.ibm.com>,=20
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.ne=
t>,=20
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com=
>,=20
	X86 ML <x86@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com=
>,=20
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>,=20
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kerne=
l@vger.kernel.org>,=20
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger=
.kernel.org>,=20
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kern=
el.org,=20
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, l=
inux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset=3DTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: netdev+bounces-83483-steffen.klassert=3Dcunet.com@vger.kernel.=
org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 23:29:03.8846
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: d7c7485a-e2b7-4948-127e-08dc=
50480570
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dx-dres=
den-01.secunet.de:TOTAL-HUB=3D432|SMR=3D337(SMRDE=3D034|SMRC=3D302(SMRCL=3D=
102|X-SMRCR=3D303))|CAT=3D093(CATOS=3D011
 (CATSM=3D011(CATSM-Malware
 Agent=3D011))|CATRESL=3D039(CATRESLP2R=3D020)|CATORES=3D041
 (CATRS=3D041(CATRS-Index Routing Agent=3D040)));2024-03-29T23:29:04.328Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 13304
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=CAs-essen-02.secunet.de:TOTA=
L-FE=3D012|SMR=3D009(SMRPI=3D007(SMRPI-FrontendProxyAgent=3D007))|SMS=3D002
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAfkHAAAPAAADH4sIAAAAAAAEAIVWzW7k=
xhHu0cxw/qQdIb
 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
 laGvWfeXXggjxWE3mLBYOMuzW4yEj7iFHq0CqD0i+o/JH0C86nVKie
 cMW/E0olB4K3aJ4jEhtxdxPyhPPb49oWz6dcaU1ovTqiJuPM2Jj7bt
 KEwKF50ixeq8Aa/2Xh0QwBzhC6wonoins1dceiPqT27As/jDxsEgGK
 vLrM+mRxrxqZlrFgNm4I/oAnmwwcnlRekz7xR7qYpyJGIue08hn+kF
 F4JeHLZJPkjojGQct6VQ9Sb438qE7HgBgYi1HmcyJ26xC8qlDf8aFh
 nmQ6akqmqUcmnCaySJJQn/Z/BIV/1au5EQAAAQLeAjw/eG1sIHZlcn
 Npb249IjEuMCIgZW5jb2Rpbmc9InV0Zi0xNiI/Pg0KPFRhc2tTZXQ+
 DQogIDxWZXJzaW9uPjE1LjAuMC4wPC9WZXJzaW9uPg0KICA8VGFza3
 M+DQogICAgPFRhc2sgU3RhcnRJbmRleD0iMTY2OSI+DQogICAgICA8
 VGFza1N0cmluZz5Db25zaWRlcmluZyB0aGF0IHdlIGFsc28gbmVlZC
 B0byBkbyBoYXNoIGxvb2t1cDwvVGFza1N0cmluZz4NCiAgICAgIDxB
 c3NpZ25lZXM+DQogICAgICAgIDxFbWFpbFVzZXIgSWQ9InJvc3RlZH
 RAZ29vZG1pcy5vcmciPlN0ZXZlbiBSb3N0ZWR0PC9FbWFpbFVzZXI+
 DQogICAgICA8L0Fzc2lnbmVlcz4NCiAgICA8L1Rhc2s+DQogIDwvVG
 Fza3M+DQo8L1Rhc2tTZXQ+AQrEAjw/eG1sIHZlcnNpb249IjEuMCIg
 ZW5jb2Rpbmc9InV0Zi0xNiI/Pg0KPEVtYWlsU2V0Pg0KICA8VmVyc2
 lvbj4xNS4wLjAuMDwvVmVyc2lvbj4NCiAgPEVtYWlscz4NCiAgICA8
 RW1haWwgU3RhcnRJbmRleD0iNDgiPg0KICAgICAgPEVtYWlsU3RyaW
 5nPnJvc3RlZHRAZ29vZG1pcy5vcmc8L0VtYWlsU3RyaW5nPg0KICAg
 IDwvRW1haWw+DQogICAgPEVtYWlsIFN0YXJ0SW5kZXg9IjEyNSI+DQ
 ogICAgICA8RW1haWxTdHJpbmc+ZG9uZ21lbmdsb25nLjhAYnl0ZWRh
 bmNlLmNvbTwvRW1haWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAgPC
 9FbWFpbHM+DQo8L0VtYWlsU2V0PgEM8AM8P3htbCB2ZXJzaW9uPSIx
 LjAiIGVuY29kaW5nPSJ1dGYtMTYiPz4NCjxDb250YWN0U2V0Pg0KIC
 A8VmVyc2lvbj4xNS4wLjAuMDwvVmVyc2lvbj4NCiAgPENvbnRhY3Rz
 Pg0KICAgIDxDb250YWN0IFN0YXJ0SW5kZXg9IjMyIj4NCiAgICAgID
 xQZXJzb24gU3RhcnRJbmRleD0iMzIiPg0KICAgICAgICA8UGVyc29u
 U3RyaW5nPlN0ZXZlbiBSb3N0ZWR0PC9QZXJzb25TdHJpbmc+DQogIC
 AgICA8L1BlcnNvbj4NCiAgICAgIDxFbWFpbHM+DQogICAgICAgIDxF
 bWFpbCBTdGFydEluZGV4PSI0OCI+DQogICAgICAgICAgPEVtYWlsU3
 RyaW5nPnJvc3RlZHRAZ29vZG1pcy5vcmc8L0VtYWlsU3RyaW5nPg0K
 ICAgICAgICA8L0VtYWlsPg0KICAgICAgPC9FbWFpbHM+DQogICAgIC
 A8Q29udGFjdFN0cmluZz5TdGV2ZW4gUm9zdGVkdCAmbHQ7cm9zdGVk
 dEBnb29kbWlzLm9yZzwvQ29udGFjdFN0cmluZz4NCiAgICA8L0Nvbn
 RhY3Q+DQogIDwvQ29udGFjdHM+DQo8L0NvbnRhY3RTZXQ+AQ7PAVJl
 dHJpZXZlck9wZXJhdG9yLDEwLDE7UmV0cmlldmVyT3BlcmF0b3IsMT
 EsMTtQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTAsMDtQb3N0RG9jUGFy
 c2VyT3BlcmF0b3IsMTEsMDtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdG
 ljT3BlcmF0b3IsMTAsMTtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGlj
 T3BlcmF0b3IsMTEsMDtUcmFuc3BvcnRXcml0ZXJQcm9kdWNlciwyMC wyOA=3D=0A=
X-MS-Exchange-Forest-IndexAgent: 1 3445
X-MS-Exchange-Forest-EmailMessageHash: 272706DD
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

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

X-sender: <linux-kernel+bounces-125526-steffen.klassert=3Dcunet.com@vger.ke=
rnel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Dc822;steffen.klassert@se=
cunet.com NOTIFY=3DVER; X-ExtendedProps=3DAVABYAAgAAAAUAFAARAPDFCS25BAlDktI=
I2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSX=
NSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAA=
AUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChG=
WURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwA=
XAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG=
1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHc=
m91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29u=
ZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAw=
AAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC=
5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAAB=
QBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1V=
c2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1J=
lc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb=
3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=0A=
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAw5Tp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBvAAAAjYoAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=0A=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 19736
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DS1_2, cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 00:29:11 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DS1_2,
 cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Sat, 30 Mar 2024 00:29:11 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 97DA5208A6
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 00:29:11 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.749
X-Spam-Level:
X-Spam-Status: No, score=3D.749 tagged_above=3D99 required=3D1
	tests=3DAYES_00=3D.9, DKIM_SIGNED=3D1, DKIM_VALID=3D.1,
	DKIM_VALID_AU=3D.1, FREEMAIL_FORGED_FROMDOMAIN=3D001,
	FREEMAIL_FROM=3D001, HEADER_FROM_DIFFERENT_DOMAINS=3D249,
	MAILING_LIST_MULTI=3D, RCVD_IN_DNSWL_NONE=3D.0001,
	SPF_HELO_NONE=3D001, SPF_PASS=3D.001]
	autolearn=3Davailable autolearn_force=3D
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dss (2048-bit key) header.d=3Dail.com
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id auCb2c0hRYxs for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 00:29:11 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dilfrom; client-ip=147=
.75.80.249; helo=3D.mirrors.kernel.org; envelope-from=3Dnux-kernel+bounces-=
125526-steffen.klassert=3Dcunet.com@vger.kernel.org; receiver=3Deffen.klass=
ert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com F33F320870
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id F33F320870
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 00:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFD21F22615
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4738413E6BF;
	Fri, 29 Mar 2024 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dss (2048-bit key) header.d=3Dail.com header.i=3Dmail.com header.b=
=3Dm8qb98v"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.2=
15.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE5347B6;
	Fri, 29 Mar 2024 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dne smtp.client-ip 9=
.85.215.169
ARC-Seal: i=3D a=3Da-sha256; d=3Dbspace.kernel.org; s=3Dc-20240116;
	t=1711754928; cv=3Dne; b=3DF0sOPYXhrbjY9cOS6Nmj4VXF++Yx8MtZjBDxanMefli+Bul=
HO4QXKn7qwpW3i+7uN65u5cLGhThPJZ2akcLjIgY9UcOJfH9j6D484gs+N5O8HXdnQzg8eZ93GR=
BeBoDesuvP5WyVY1RlteRQZLbYRhS27z9mKgIzxIt2bJ+ZoARC-Message-Signature: i=3D =
a=3Da-sha256; d=3Dbspace.kernel.org;
	s=3Dc-20240116; t=1711754928; c=3Dlaxed/simple;
	bh=3DCkTC/9QOPKjcAq26pJFK75aD0g4y2+LXJsB0P1JY0=3D=0A=
	h=3DME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=3D4xUrtWjk3J0kbVbPD5XAlV9JEyhRuyqvveB8mIxkffhtOM1Y7=
m4+o5XzftYMKn592GD5CBw41tS2CCKYzMtaJurKzqjxkWsFCCe3ELmR9AEyVvEBDa4PpVwvE2aS=
0et1z2P9rOIk0ldc7OMYPnDpWEu3jfzLxb8Y4CGi6sJbEARC-Authentication-Results: i=
=3D smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3Dne) header.from=3Dai=
l.com; spf=3Dss smtp.mailfrom=3Dail.com; dkim=3Dss (2048-bit key) header.d=
=3Dail.com header.i=3Dmail.com header.b=3D8qb98v; arc=3Dne smtp.client-ip 9=
.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3D=
ne) header.from=3Dail.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dss smtp.mailfrom=3D=
ail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d3907ff12=
8so1860607a12.3;
        Fri, 29 Mar 2024 16:28:46 -0700 (PDT)
DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=3Dail.com; s 230601; t=1711754926; x=1712359726; darn=3Der.kernel=
.org;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DV1tZGanDBSafK6edOdycvbQYDEdHbTCxngJvsvk3c=3D=0A=
        b=3D8qb98vO+2rZQDr4ACVbzWOOBhMbNP973of56VDx+7dzKarS23b4VDs0QCZjE/ze=
y
         IJ/g2gwkTlDZp557gqFy6HVirUKvvI/RhzQOrPjsYmqnt0OS+LXZWxBGcD9ooJmS1u=
1N
         Wdq60dFcb/ee3JYL5bUFYzr07cJmwvvmIZoI/b1KQpo+K6ftMzexzXAN8iXh1nJo1Q=
dC
         4CFMaxfeoUIzc6fyg2ScGW/5rPdZFOXPIXIjGrA7V7Ij1KqAkHvKfDNzy1QS7jMz6z=
0E
         /W8l0QAzZuWpon/+MGFe6iPNG81xSsUfka4lIyvOK31ZY63E/sqixJRnh7RpDV18Ws=
JY
         CtMw=3D=0A=
X-Google-DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=1E100.net; s 230601; t=1711754926; x=1712359726;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DV1tZGanDBSafK6edOdycvbQYDEdHbTCxngJvsvk3c=3D=0A=
        b=3D6CYGdij3I8SMDFuLcEkXFxxuMDLhpfo6RmyHf+rD3z+RBxrsmoJ1YligUcYT3Vo=
L
         YtUHguMvFF7xT9YjyGrK4ujkEA13NT+X1hwUNhKsWaXhpLBG2Wyh4eNaw4zkHN28eY=
kq
         dj4reqkSxtXQvjpns3NtubA0ld6+woHqICxMQVR26maDt91aYEPooASIjOoCRnxMnI=
pI
         KqBMby8F8aarmJfc6c16rp9hDJK1Cr34usuvnIOrnJ2bdp2qTCOMpl6ARzTAtPA9p7=
n7
         9p9R345kssoRHOmDzo2WcF/0oG4wRjb+owNVpsCTExoqfee0d+FSjcyFxitgRQvMQz=
cC
         9Pqw=3D=0A=
X-Forwarded-Encrypted: i=3D AJvYcCVlnHyNUDZ0fbOQSV0NEVvOtJTaOmaxwPgZy047hqz=
taIz7SMsnLeomStI1EizImJzlky/xJNYIS4RJsXEX2rbQoVyo7MFG2+RfwxWnjGonfBHU0k5JSl=
RGPFtF8Te8neu3qxCi25AWVXDje1k1qkzJLjDnQ+s4R4WJmDmbw/KdNN4l/EBnMx0Wq+GOvmC+D=
kjFlyebAZoKGfgwdw8BgI1xISF1T+wxXijKToVLbwSSua486L4tXm8nE4lXExEMG+QxE02AxDYD=
KshvWmyLqPiNewg+cXpbihxLyg=3D=0A=
X-Gm-Message-State: AOJu0YwCezoL4rml44Ulwt5kaSYk47W3cr0evd5PMAYC8La4m9gnILH=
N
	FRelRR6zMz1Bz2qJo3eFKeNyq28N5Yo0kJIQ72rv0EkZFGKfSnjbac0fnT9zQAwbNl/tFnTmfu=
G
	Y3REKAMgIbWmVvmHWWGOk0v3R69UX-Google-Smtp-Source: AGHT+IFNbTnA2C1UowyvpIWf=
WMecar3RYOVPJRlOoVy5NMmPOOKB6ZhvqfzCxbpKkf/w3Z3THbX/GA+A1iwjf07EvPYX-Receiv=
ed: by 2002:a17:90a:be04:b0:2a2:1415:723d with SMTP id
 a4-20020a17090abe0400b002a21415723dmr3177860pjs.42.1711754926271; Fri, 29 =
Mar
 2024 16:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-2-dongmenglong.8@bytedance.com> <CAADnVQKQPS5NcvEo=
uH4JqZ2fKgQAC+LtcwhX9iXYoiEkF_M94Q@mail.gmail.com>
 <CALz3k9i5G5wWi+rtvHPwVLOUAXVMCiU_8QUZs87TEYgR_0wpPA@mail.gmail.com>
 <CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail.com>
 <CALz3k9icPePb0c4FE67q=3DU0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
 <CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
 <CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
 <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>
 <CALz3k9g-U8ih=3DJPRbyU9x_9cp00fNkU3PGQ6jP0WJ+=3DmqQ@mail.gmail.com>
 <CALz3k9jG5Jrqw=3Djt05yMkEF-1u909GbBYrV-02W0dQtm6KQQ@mail.gmail.com> <2024=
0328111330.194dcbe5@gandalf.local.home>
In-Reply-To: <20240328111330.194dcbe5@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 16:28:33 -0700
Message-ID: <CAEf4BzYgzOti+Hfdn3SUCjuofGedXRSGApVDD+K2TdG6oNE-pw@mail.gmail=
.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add suppo=
rt
 to record and check the accessed args
To: Steven Rostedt <rostedt@goodmis.org>
Cc: =3DTF-8?B?5qKm6b6Z6JGj?=3Dongmenglong.8@bytedance.com>,=20
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@kernel=
.org>,=20
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,=
=20
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux=
.dev>, Eddy Z <eddyz87@gmail.com>,=20
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,=20
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,=
=20
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,=20
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntra=
eger@linux.ibm.com>,=20
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.ne=
t>,=20
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com=
>,=20
	X86 ML <x86@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com=
>,=20
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>,=20
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kerne=
l@vger.kernel.org>,=20
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger=
.kernel.org>,=20
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kern=
el.org,=20
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, l=
inux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset=3DTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: linux-kernel+bounces-125526-steffen.klassert=3Dcunet.com@vger.=
kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 23:29:11.6433
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 735e0fdb-3f55-4a65-f575-08dc=
50480a0f
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dx-dres=
den-01.secunet.de:TOTAL-HUB=3D422|SMR=3D341(SMRDE=3D034|SMRC=3D306(SMRCL=3D=
102|X-SMRCR=3D306))|CAT=3D080(CATOS=3D013
 (CATSM=3D012(CATSM-Malware
 Agent=3D012))|CATRESL=3D039(CATRESLP2R=3D019)|CATORES=3D027
 (CATRS=3D027(CATRS-Index Routing Agent=3D026)));2024-03-29T23:29:12.076Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 13320
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=CAs-essen-01.secunet.de:TOTA=
L-FE=3D011|SMR=3D008(SMRPI=3D005(SMRPI-FrontendProxyAgent=3D005))|SMS=3D003
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAfkHAAAPAAADH4sIAAAAAAAEAIVWzW7k=
xhHu0cxw/qQdIb
 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
 laGvWfeXXggjxWE3mLBYOMuzW4yEj7iFHq0CqD0i+o/JH0C86nVKie
 cMW/E0olB4K3aJ4jEhtxdxPyhPPb49oWz6dcaU1ovTqiJuPM2Jj7bt
 KEwKF50ixeq8Aa/2Xh0QwBzhC6wonoins1dceiPqT27As/jDxsEgGK
 vLrM+mRxrxqZlrFgNm4I/oAnmwwcnlRekz7xR7qYpyJGIue08hn+kF
 F4JeHLZJPkjojGQct6VQ9Sb438qE7HgBgYi1HmcyJ26xC8qlDf8aFh
 nmQ6akqmqUcmnCaySJJQn/Z/BIV/1au5EQAAAQLeAjw/eG1sIHZlcn
 Npb249IjEuMCIgZW5jb2Rpbmc9InV0Zi0xNiI/Pg0KPFRhc2tTZXQ+
 DQogIDxWZXJzaW9uPjE1LjAuMC4wPC9WZXJzaW9uPg0KICA8VGFza3
 M+DQogICAgPFRhc2sgU3RhcnRJbmRleD0iMTY2OSI+DQogICAgICA8
 VGFza1N0cmluZz5Db25zaWRlcmluZyB0aGF0IHdlIGFsc28gbmVlZC
 B0byBkbyBoYXNoIGxvb2t1cDwvVGFza1N0cmluZz4NCiAgICAgIDxB
 c3NpZ25lZXM+DQogICAgICAgIDxFbWFpbFVzZXIgSWQ9InJvc3RlZH
 RAZ29vZG1pcy5vcmciPlN0ZXZlbiBSb3N0ZWR0PC9FbWFpbFVzZXI+
 DQogICAgICA8L0Fzc2lnbmVlcz4NCiAgICA8L1Rhc2s+DQogIDwvVG
 Fza3M+DQo8L1Rhc2tTZXQ+AQrEAjw/eG1sIHZlcnNpb249IjEuMCIg
 ZW5jb2Rpbmc9InV0Zi0xNiI/Pg0KPEVtYWlsU2V0Pg0KICA8VmVyc2
 lvbj4xNS4wLjAuMDwvVmVyc2lvbj4NCiAgPEVtYWlscz4NCiAgICA8
 RW1haWwgU3RhcnRJbmRleD0iNDgiPg0KICAgICAgPEVtYWlsU3RyaW
 5nPnJvc3RlZHRAZ29vZG1pcy5vcmc8L0VtYWlsU3RyaW5nPg0KICAg
 IDwvRW1haWw+DQogICAgPEVtYWlsIFN0YXJ0SW5kZXg9IjEyNSI+DQ
 ogICAgICA8RW1haWxTdHJpbmc+ZG9uZ21lbmdsb25nLjhAYnl0ZWRh
 bmNlLmNvbTwvRW1haWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAgPC
 9FbWFpbHM+DQo8L0VtYWlsU2V0PgEM8AM8P3htbCB2ZXJzaW9uPSIx
 LjAiIGVuY29kaW5nPSJ1dGYtMTYiPz4NCjxDb250YWN0U2V0Pg0KIC
 A8VmVyc2lvbj4xNS4wLjAuMDwvVmVyc2lvbj4NCiAgPENvbnRhY3Rz
 Pg0KICAgIDxDb250YWN0IFN0YXJ0SW5kZXg9IjMyIj4NCiAgICAgID
 xQZXJzb24gU3RhcnRJbmRleD0iMzIiPg0KICAgICAgICA8UGVyc29u
 U3RyaW5nPlN0ZXZlbiBSb3N0ZWR0PC9QZXJzb25TdHJpbmc+DQogIC
 AgICA8L1BlcnNvbj4NCiAgICAgIDxFbWFpbHM+DQogICAgICAgIDxF
 bWFpbCBTdGFydEluZGV4PSI0OCI+DQogICAgICAgICAgPEVtYWlsU3
 RyaW5nPnJvc3RlZHRAZ29vZG1pcy5vcmc8L0VtYWlsU3RyaW5nPg0K
 ICAgICAgICA8L0VtYWlsPg0KICAgICAgPC9FbWFpbHM+DQogICAgIC
 A8Q29udGFjdFN0cmluZz5TdGV2ZW4gUm9zdGVkdCAmbHQ7cm9zdGVk
 dEBnb29kbWlzLm9yZzwvQ29udGFjdFN0cmluZz4NCiAgICA8L0Nvbn
 RhY3Q+DQogIDwvQ29udGFjdHM+DQo8L0NvbnRhY3RTZXQ+AQ7PAVJl
 dHJpZXZlck9wZXJhdG9yLDEwLDA7UmV0cmlldmVyT3BlcmF0b3IsMT
 EsMTtQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTAsMDtQb3N0RG9jUGFy
 c2VyT3BlcmF0b3IsMTEsMDtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdG
 ljT3BlcmF0b3IsMTAsMTtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGlj
 T3BlcmF0b3IsMTEsMDtUcmFuc3BvcnRXcml0ZXJQcm9kdWNlciwyMC wxNg=3D=0A=
X-MS-Exchange-Forest-IndexAgent: 1 3445
X-MS-Exchange-Forest-EmailMessageHash: 272706DD
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

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


