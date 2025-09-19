Return-Path: <linux-kselftest+bounces-41982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727B8B8B70F
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 00:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D201C20C8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 22:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EE12C0F83;
	Fri, 19 Sep 2025 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id7eFbpo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF9021ABC9
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319821; cv=none; b=maASWADSTuGmB4H8mfrjzMgCo4xyp5diwTgArxf6Dtf2JHQLTrLa5CZKdVaQMR+J4eeel/wNNdKP+nEU7xH2P4U5+YZ0OVOjL+UwdF3rBJRphw/HfF4dR64xnE79N9A5h7k5YLJTfJ/vWZQNpB+Lxn2e9yOZp9A/xqX6HH+PpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319821; c=relaxed/simple;
	bh=FgqRRn6QGzeMyy8hkZX/0GC6vvMOLl1JywqBDzuuNTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmmSJbICH+70NORiRIaBuM6jO54EJPn/UZYnFSrsM06K+Qfgb+58L4RwmlUE0QHuVLphHkg5FriKBqyzvWUZyQD1rbe09oD40+cqa0lpGUbCRMPq6f/w/smm42GwSF6MOR47ji49psVPQnhqI3A6LgeAURBrW6F/BvkfDItU6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=id7eFbpo; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7725de6b57dso3491458b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 15:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758319819; x=1758924619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOxrwynMrdfg+Br57Gx7w3KWPr19Etx0Hp02BodKl50=;
        b=id7eFbpoU87u+8rxMSFPLKXu+lG2VGDRUmk/DuC5x2UkR4m5J0sRKbjoAjjp3ftUGp
         AmpXm1JhNJ23O+wzFNZARpzsF4QLI54ttrIUnQHA14qbCE5ugn4pCOWOA7CT2brTlieu
         0AJKPZ9AnvyJlyMJ1Knt5SQsIZOea1PNzqx/BxgH+IYcfUikti1auNttU6mE1iYx/uaV
         X4If8QlikDzlWO5o4ynKRLtOqgqHxWe5Po+UFcH7DmYXeaH3qBNutynvxK2wRL0nXFLm
         FapyrLHDNbYNxgI8nLttjbxNH/mpVz+SoL7t50jcmJi7Hckg4oh/UTm8x3ufXk1ppywq
         //5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319819; x=1758924619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOxrwynMrdfg+Br57Gx7w3KWPr19Etx0Hp02BodKl50=;
        b=JFi/I+Xz+4Yy8ezVPR9RtluOxlT74E8j6Gyr02IBLND5xiRasP0O/ivF8QI3o9HCnS
         Ycn411b7l1DKWN3SOa4pMhSZsMvuBmnvA2UpWpzNwaFc0sUk/o53KhX3/qKiV7GRWnWC
         YihLI5fldpoxucnv/eBNUP7py79TMCSrtCqSt1R8ANGxUXJI0/zFW+PCgFg+q246QLwX
         cskDBiBjk7yNDHlMS5JZLlQMG2CShfPtFbskPgTe4fg+YHF/884cX/ZHqEJn4oQg5tYr
         mQwms/euIoA61sN+6ZZSbQXKtELEx2bCtrZjgBJJ+5vDTh2U8lDP5sIJSj13hFIuSJzP
         ZKrw==
X-Forwarded-Encrypted: i=1; AJvYcCVMoTfIYWuhzVHTBB4D5Dfh2uE+rNLxAKpg3UCeNeBPAKBURWKnhuhFtM2rIcXVBA6wK3nSkVtOtd8yK3KtDwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZYadLqM7Co+pi0l6r7unc0lHkDnlTS4wSctbPGtB8R8GNFns
	zOz8PWbq7jRacrQItjDpY/7yhjOYHqSt24B79h9j0hQnfku5efMJLA/D/lIFNTNzbnHEg50qNL5
	D2IBWBAQ+NlglbUxq/ejltV+bYRIYuWI=
X-Gm-Gg: ASbGnct8QUb1NX8kD5YLD6Q5+tS0uv4fmVHWGwcTGQQz9Jdc/kmcQRw3WaKMZCQ6KM9
	zlSoPhY+kcETsK1g6RklQqvgfZNStH5Y67/5rmfGBjowFbsQNdMKH8dNpYBGNTrHuSAzaG54Tsd
	ILItLSyr4gqiSoxtOA+6owha4NjTGDZTVriwd+5q+8lmrNAO3EmLGe9CCji1xTs4tXKUbhhMOh9
	E2r1Pve21cxN9SwxCObJkk=
X-Google-Smtp-Source: AGHT+IGWfgHieWC6LhmnuwBiJ8tZb8Lp434YojhEEnUZFxIcE9ml9APPIZdaKbMjSuVzBEIHSCBz4vRGjR8FFtfwrjA=
X-Received: by 2002:a05:6a20:a11d:b0:262:cbbc:3125 with SMTP id
 adf61e73a8af0-29260d80e87mr7429819637.20.1758319818435; Fri, 19 Sep 2025
 15:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905150641.2078838-1-xukuohai@huaweicloud.com> <20250905150641.2078838-2-xukuohai@huaweicloud.com>
In-Reply-To: <20250905150641.2078838-2-xukuohai@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Sep 2025 15:10:04 -0700
X-Gm-Features: AS18NWBDl-cucID1iwQu57ZDeIRUPAjcdrTARABtDVmAmcKv0nLewP899rxwajA
Message-ID: <CAEf4BzaSEjQzF47BZeh0de9pFbKpaB8JqCs629hV9xZDhMyTgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add overwrite mode for bpf ring buffer
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, 
	Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Tao Chen <chen.dylane@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 8:13=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com>=
 wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> When the bpf ring buffer is full, new events can not be recorded util

typo: until

> the consumer consumes some events to free space. This may cause critical
> events to be discarded, such as in fault diagnostic, where recent events
> are more critical than older ones.
>
> So add ovewrite mode for bpf ring buffer. In this mode, the new event

overwrite, BPF

> overwrites the oldest event when the buffer is full.
>
> The scheme is as follows:
>
> 1. producer_pos tracks the next position to write new data. When there
>    is enough free space, producer simply moves producer_pos forward to
>    make space for the new event.
>
> 2. To avoid waiting for consumer to free space when the buffer is full,
>    a new variable overwrite_pos is introduced for producer. overwrite_pos
>    tracks the next event to be overwritten (the oldest event committed) i=
n
>    the buffer. producer moves it forward to discard the oldest events whe=
n
>    the buffer is full.
>
> 3. pending_pos tracks the oldest event under committing. producer ensures

"under committing" is confusing. Oldest event to be committed?

>    producers_pos never passes pending_pos when making space for new event=
s.
>    So multiple producers never write to the same position at the same tim=
e.
>
> 4. producer wakes up consumer every half a round ahead to give it a chanc=
e
>    to retrieve data. However, for an overwrite-mode ring buffer, users
>    typically only cares about the ring buffer snapshot before a fault occ=
urs.
>    In this case, the producer should commit data with BPF_RB_NO_WAKEUP fl=
ag
>    to avoid unnecessary wakeups.
>
> To make it clear, here are some example diagrams.
>
> 1. Let's say we have a ring buffer with size 4096.
>
>     At first, {producer,overwrite,pending,consumer}_pos are all set to 0
>
>     0       512      1024    1536     2048     2560     3072     3584    =
   4096
>     +--------------------------------------------------------------------=
---+
>     |                                                                    =
   |
>     |                                                                    =
   |
>     |                                                                    =
   |
>     +--------------------------------------------------------------------=
---+
>     ^
>     |
>     |
> producer_pos =3D 0
> overwrite_pos =3D 0
> pending_pos =3D 0
> consumer_pos =3D 0
>
> 2. Reserve event A, size 512.
>
>     There is enough free space, so A is allocated at offset 0 and produce=
r_pos
>     is moved to 512, the end of A. Since A is not submitted, the BUSY bit=
 is
>     set.
>
>     0       512      1024    1536     2048     2560     3072     3584    =
   4096
>     +--------------------------------------------------------------------=
---+
>     |        |                                                           =
   |
>     |   A    |                                                           =
   |
>     | [BUSY] |                                                           =
   |
>     +--------------------------------------------------------------------=
---+
>     ^        ^
>     |        |
>     |        |
>     |    producer_pos =3D 512
>     |
> overwrite_pos =3D 0
> pending_pos =3D 0
> consumer_pos =3D 0
>
> 3. Reserve event B, size 1024.
>
>     B is allocated at offset 512 with BUSY bit set, and producer_pos is m=
oved
>     to the end of B.
>
>     0       512      1024    1536     2048     2560     3072     3584    =
   4096
>     +--------------------------------------------------------------------=
---+
>     |        |                 |                                         =
   |
>     |   A    |        B        |                                         =
   |
>     | [BUSY] |      [BUSY]     |                                         =
   |
>     +--------------------------------------------------------------------=
---+
>     ^                          ^
>     |                          |
>     |                          |
>     |                   producer_pos =3D 1536
>     |
> overwrite_pos =3D 0
> pending_pos =3D 0
> consumer_pos =3D 0
>
> 4. Reserve event C, size 2048.
>
>     C is allocated at offset 1536 and producer_pos becomes 3584.
>
>     0       512      1024    1536     2048     2560     3072     3584    =
   4096
>     +--------------------------------------------------------------------=
---+
>     |        |                 |                                   |     =
   |
>     |    A   |        B        |                 C                 |     =
   |
>     | [BUSY] |      [BUSY]     |               [BUSY]              |     =
   |
>     +--------------------------------------------------------------------=
---+
>     ^                                                              ^
>     |                                                              |
>     |                                                              |
>     |                                                    producer_pos =3D=
 3584
>     |
> overwrite_pos =3D 0
> pending_pos =3D 0
> consumer_pos =3D 0
>
> 5. Submit event A.
>
>     The BUSY bit of A is cleared. B becomes the oldest event under writin=
g, so

Now it's "under writing" :) To be committed? Or "pending committing"
or just "pending", I guess. But not under anything, it just confuses
readers. IMO.

>     pending_pos is moved to 512, the start of B.
>
>     0       512      1024    1536     2048     2560     3072     3584    =
   4096
>     +--------------------------------------------------------------------=
---+
>     |        |                 |                                   |     =
   |
>     |    A   |        B        |                 C                 |     =
   |
>     |        |      [BUSY]     |               [BUSY]              |     =
   |
>     +--------------------------------------------------------------------=
---+
>     ^        ^                                                     ^
>     |        |                                                     |
>     |        |                                                     |
>     |   pending_pos =3D 512                                  producer_pos=
 =3D 3584
>     |
> overwrite_pos =3D 0
> consumer_pos =3D 0
>
> 6. Submit event B.
>
>     The BUSY bit of B is cleared, and pending_pos is moved to the start o=
f C,
>     which is the oldest event under writing now.

ditto

>
>     0       512      1024    1536     2048     2560     3072     3584    =
   4096
>     +--------------------------------------------------------------------=
---+
>     |        |                 |                                   |     =
   |
>     |    A   |        B        |                 C                 |     =
   |
>     |        |                 |               [BUSY]              |     =
   |
>     +--------------------------------------------------------------------=
---+
>     ^                          ^                                   ^
>     |                          |                                   |
>     |                          |                                   |
>     |                     pending_pos =3D 1536               producer_pos=
 =3D 3584
>     |
> overwrite_pos =3D 0
> consumer_pos =3D 0
>
> 7. Reserve event D, size 1536 (3 * 512).
>
>     There are 2048 bytes not under writing between producer_pos and pendi=
ng_pos,
>     so D is allocated at offset 3584, and producer_pos is moved from 3584=
 to
>     5120.
>
>     Since event D will overwrite all bytes of event A and the begining 51=
2 bytes

typo: beginning, but really "first 512 bytes" would be clearer

>     of event B, overwrite_pos is moved to the start of event C, the oldes=
t event
>     that is not overwritten.
>
>     0       512      1024    1536     2048     2560     3072     3584    =
   4096
>     +--------------------------------------------------------------------=
---+
>     |                 |        |                                   |     =
   |
>     |      D End      |        |                 C                 | D Be=
gin|
>     |      [BUSY]     |        |               [BUSY]              | [BUS=
Y] |
>     +--------------------------------------------------------------------=
---+
>     ^                 ^        ^
>     |                 |        |
>     |                 |   pending_pos =3D 1536
>     |                 |   overwrite_pos =3D 1536
>     |                 |
>     |             producer_pos=3D5120
>     |
> consumer_pos =3D 0
>
> 8. Reserve event E, size 1024.
>
>     Though there are 512 bytes not under writing between producer_pos and
>     pending_pos, E can not be reserved, as it would overwrite the first 5=
12
>     bytes of event C, which is still under writing.
>
> 9. Submit event C and D.
>
>     pending_pos is moved to the end of D.
>
>     0       512      1024    1536     2048     2560     3072     3584    =
   4096
>     +--------------------------------------------------------------------=
---+
>     |                 |        |                                   |     =
   |
>     |      D End      |        |                 C                 | D Be=
gin|
>     |                 |        |                                   |     =
   |
>     +--------------------------------------------------------------------=
---+
>     ^                 ^        ^
>     |                 |        |
>     |                 |   overwrite_pos =3D 1536
>     |                 |
>     |             producer_pos=3D5120
>     |             pending_pos=3D5120
>     |
> consumer_pos =3D 0
>
> The performance data for overwrite mode will be provided in a follow-up
> patch that adds overwrite mode benchs.
>
> A sample of performance data for non-overwrite mode on an x86_64 and arm6=
4
> CPU, before and after this patch, is shown below. As we can see, no obvio=
us
> performance regression occurs.
>
> - x86_64 (AMD EPYC 9654)
>
> Before:
>
> Ringbuf, multi-producer contention
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   rb-libbpf nr_prod 1  13.218 =C2=B1 0.039M/s (drops 0.000 =C2=B1 0.000M/=
s)
>   rb-libbpf nr_prod 2  15.684 =C2=B1 0.015M/s (drops 0.000 =C2=B1 0.000M/=
s)
>   rb-libbpf nr_prod 3  7.771 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 4  6.281 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 8  2.842 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 12 2.001 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 16 1.833 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 20 1.508 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 24 1.421 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 28 1.309 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 32 1.265 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 36 1.198 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 40 1.174 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 44 1.113 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 48 1.097 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 52 1.070 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>
> After:
>
> Ringbuf, multi-producer contention
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   rb-libbpf nr_prod 1  13.751 =C2=B1 0.673M/s (drops 0.000 =C2=B1 0.000M/=
s)
>   rb-libbpf nr_prod 2  15.592 =C2=B1 0.008M/s (drops 0.000 =C2=B1 0.000M/=
s)
>   rb-libbpf nr_prod 3  7.776 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 4  6.463 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 8  2.883 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 12 2.017 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 16 1.816 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 20 1.512 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 24 1.396 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 28 1.303 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 32 1.267 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 36 1.210 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 40 1.181 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 44 1.136 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 48 1.090 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 52 1.091 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>
> - arm64 (HiSilicon Kunpeng 920)
>
> Before:
>
>   Ringbuf, multi-producer contention
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   rb-libbpf nr_prod 1  11.602 =C2=B1 0.423M/s (drops 0.000 =C2=B1 0.000M/=
s)
>   rb-libbpf nr_prod 2  9.599 =C2=B1 0.007M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 3  6.669 =C2=B1 0.008M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 4  4.806 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 8  3.856 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 12 3.368 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 16 3.210 =C2=B1 0.007M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 20 3.003 =C2=B1 0.007M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 24 2.944 =C2=B1 0.007M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 28 2.863 =C2=B1 0.008M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 32 2.819 =C2=B1 0.007M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 36 2.887 =C2=B1 0.008M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 40 2.837 =C2=B1 0.008M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 44 2.787 =C2=B1 0.012M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 48 2.738 =C2=B1 0.010M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 52 2.700 =C2=B1 0.007M/s (drops 0.000 =C2=B1 0.000M/s=
)
>
> After:
>
>   Ringbuf, multi-producer contention
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   rb-libbpf nr_prod 1  11.614 =C2=B1 0.268M/s (drops 0.000 =C2=B1 0.000M/=
s)
>   rb-libbpf nr_prod 2  9.917 =C2=B1 0.007M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 3  6.920 =C2=B1 0.008M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 4  4.803 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 8  3.898 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 12 3.426 =C2=B1 0.008M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 16 3.320 =C2=B1 0.008M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 20 3.029 =C2=B1 0.013M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 24 3.068 =C2=B1 0.012M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 28 2.890 =C2=B1 0.009M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 32 2.950 =C2=B1 0.012M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 36 2.812 =C2=B1 0.006M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 40 2.834 =C2=B1 0.009M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 44 2.803 =C2=B1 0.010M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 48 2.766 =C2=B1 0.010M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-libbpf nr_prod 52 2.754 =C2=B1 0.009M/s (drops 0.000 =C2=B1 0.000M/s=
)
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  include/uapi/linux/bpf.h       |   4 +
>  kernel/bpf/ringbuf.c           | 159 +++++++++++++++++++++++++++------
>  tools/include/uapi/linux/bpf.h |   4 +
>  3 files changed, 141 insertions(+), 26 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 233de8677382..d3b2fd2ae527 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1430,6 +1430,9 @@ enum {
>
>  /* Do not translate kernel bpf_arena pointers to user pointers */
>         BPF_F_NO_USER_CONV      =3D (1U << 18),
> +
> +/* bpf ringbuf works in overwrite mode? */
> +       BPF_F_OVERWRITE         =3D (1U << 19),

let's call it BPF_F_RB_OVERWRITE as this is ringbuf-specific? And use
imperative voice in the comment:

/* Enable BPF ringbuf overwrite mode */

>  };
>
>  /* Flags for BPF_PROG_QUERY. */
> @@ -6215,6 +6218,7 @@ enum {
>         BPF_RB_RING_SIZE =3D 1,
>         BPF_RB_CONS_POS =3D 2,
>         BPF_RB_PROD_POS =3D 3,
> +       BPF_RB_OVER_POS =3D 4,

nit: BPF_RB_OVERWITE_POS?

>  };
>
>  /* BPF ring buffer constants */
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 719d73299397..6ca41d01f187 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -13,7 +13,7 @@
>  #include <linux/btf_ids.h>
>  #include <asm/rqspinlock.h>
>
> -#define RINGBUF_CREATE_FLAG_MASK (BPF_F_NUMA_NODE)
> +#define RINGBUF_CREATE_FLAG_MASK (BPF_F_NUMA_NODE | BPF_F_OVERWRITE)
>
>  /* non-mmap()'able part of bpf_ringbuf (everything up to consumer page) =
*/
>  #define RINGBUF_PGOFF \
> @@ -27,7 +27,8 @@
>  struct bpf_ringbuf {
>         wait_queue_head_t waitq;
>         struct irq_work work;
> -       u64 mask;
> +       u64 mask:48;
> +       u64 overwrite_mode:1;

Please, don't touch the mask field, it's a very hot field, no need to
make it a bit field. Just add a separate bool for overwrite_mode.

>         struct page **pages;
>         int nr_pages;
>         rqspinlock_t spinlock ____cacheline_aligned_in_smp;
> @@ -72,6 +73,7 @@ struct bpf_ringbuf {
>          */
>         unsigned long consumer_pos __aligned(PAGE_SIZE);
>         unsigned long producer_pos __aligned(PAGE_SIZE);
> +       unsigned long overwrite_pos;  /* to be overwritten in overwrite m=
ode */

Not a really precise comment, IMO. This is a position pointing to
after the last overwritten record, no?

>         unsigned long pending_pos;
>         char data[] __aligned(PAGE_SIZE);
>  };
> @@ -166,7 +168,8 @@ static void bpf_ringbuf_notify(struct irq_work *work)
>   * considering that the maximum value of data_sz is (4GB - 1), there
>   * will be no overflow, so just note the size limit in the comments.
>   */
> -static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_no=
de)
> +static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_no=
de,
> +                                            int overwrite_mode)
>  {
>         struct bpf_ringbuf *rb;
>
> @@ -183,17 +186,25 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t=
 data_sz, int numa_node)
>         rb->consumer_pos =3D 0;
>         rb->producer_pos =3D 0;
>         rb->pending_pos =3D 0;
> +       rb->overwrite_mode =3D overwrite_mode;
>
>         return rb;
>  }
>
>  static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
>  {
> +       int overwrite_mode =3D 0;
>         struct bpf_ringbuf_map *rb_map;
>
>         if (attr->map_flags & ~RINGBUF_CREATE_FLAG_MASK)
>                 return ERR_PTR(-EINVAL);
>
> +       if (attr->map_flags & BPF_F_OVERWRITE) {
> +               if (attr->map_type =3D=3D BPF_MAP_TYPE_USER_RINGBUF)
> +                       return ERR_PTR(-EINVAL);
> +               overwrite_mode =3D 1;
> +       }
> +
>         if (attr->key_size || attr->value_size ||
>             !is_power_of_2(attr->max_entries) ||
>             !PAGE_ALIGNED(attr->max_entries))
> @@ -205,7 +216,8 @@ static struct bpf_map *ringbuf_map_alloc(union bpf_at=
tr *attr)
>
>         bpf_map_init_from_attr(&rb_map->map, attr);
>
> -       rb_map->rb =3D bpf_ringbuf_alloc(attr->max_entries, rb_map->map.n=
uma_node);
> +       rb_map->rb =3D bpf_ringbuf_alloc(attr->max_entries, rb_map->map.n=
uma_node,
> +                                      overwrite_mode);

keep on single line, it fits under 100 characters

>         if (!rb_map->rb) {
>                 bpf_map_area_free(rb_map);
>                 return ERR_PTR(-ENOMEM);
> @@ -295,11 +307,16 @@ static int ringbuf_map_mmap_user(struct bpf_map *ma=
p, struct vm_area_struct *vma
>
>  static unsigned long ringbuf_avail_data_sz(struct bpf_ringbuf *rb)
>  {
> -       unsigned long cons_pos, prod_pos;
> +       unsigned long cons_pos, prod_pos, over_pos;
>
>         cons_pos =3D smp_load_acquire(&rb->consumer_pos);
>         prod_pos =3D smp_load_acquire(&rb->producer_pos);
> -       return prod_pos - cons_pos;
> +
> +       if (likely(!rb->overwrite_mode))
> +               return prod_pos - cons_pos;

nit: invert the condition to unlikely and handle that special case in
a nested if, moving "over_pos" inside the if itself

> +
> +       over_pos =3D READ_ONCE(rb->overwrite_pos);
> +       return min(prod_pos - max(cons_pos, over_pos), rb->mask + 1);

I'm trying to understand why you need to min with `rb->mask + 1`, can
you please elaborate? And also, at least for consistency, use
smp_load_acquire() for overwrite_pos?

>  }
>
>  static u32 ringbuf_total_data_sz(const struct bpf_ringbuf *rb)
> @@ -402,11 +419,43 @@ bpf_ringbuf_restore_from_rec(struct bpf_ringbuf_hdr=
 *hdr)
>         return (void*)((addr & PAGE_MASK) - off);
>  }
>
> +
> +static bool bpf_ringbuf_has_space(const struct bpf_ringbuf *rb,
> +                                 unsigned long new_prod_pos,
> +                                 unsigned long cons_pos,
> +                                 unsigned long pend_pos)
> +{
> +       /* no space if oldest not yet committed record until the newest
> +        * record span more than (ringbuf_size - 1)
> +        */
> +       if (new_prod_pos - pend_pos > rb->mask)
> +               return false;
> +
> +       /* ok, we have space in ovewrite mode */

typo: overwrite

> +       if (unlikely(rb->overwrite_mode))
> +               return true;
> +
> +       /* no space if producer position advances more than (ringbuf_size=
 - 1)
> +        * ahead than consumer position when not in overwrite mode

typo: ahead of consumer position

> +        */
> +       if (new_prod_pos - cons_pos > rb->mask)
> +               return false;
> +
> +       return true;
> +}
> +
> +static u32 ringbuf_round_up_hdr_len(u32 hdr_len)

use consistent naming, if you have bpf_ringbuf_has_space, then this
should have been bpf_ringbuf_round_up_len() or something like that.

> +{
> +       hdr_len &=3D ~BPF_RINGBUF_DISCARD_BIT;
> +       return round_up(hdr_len + BPF_RINGBUF_HDR_SZ, 8);
> +}
> +
>  static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
>  {
> -       unsigned long cons_pos, prod_pos, new_prod_pos, pend_pos, flags;
> +       unsigned long flags;
>         struct bpf_ringbuf_hdr *hdr;
> -       u32 len, pg_off, tmp_size, hdr_len;
> +       u32 len, pg_off, hdr_len;
> +       unsigned long cons_pos, prod_pos, new_prod_pos, pend_pos, over_po=
s;

100 character line length limit, just add over_pos to original single
line declaration

>
>         if (unlikely(size > RINGBUF_MAX_RECORD_SZ))
>                 return NULL;
> @@ -429,24 +478,39 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringb=
uf *rb, u64 size)
>                 hdr_len =3D READ_ONCE(hdr->len);
>                 if (hdr_len & BPF_RINGBUF_BUSY_BIT)
>                         break;
> -               tmp_size =3D hdr_len & ~BPF_RINGBUF_DISCARD_BIT;
> -               tmp_size =3D round_up(tmp_size + BPF_RINGBUF_HDR_SZ, 8);
> -               pend_pos +=3D tmp_size;
> +               pend_pos +=3D ringbuf_round_up_hdr_len(hdr_len);
>         }
>         rb->pending_pos =3D pend_pos;
>
> -       /* check for out of ringbuf space:
> -        * - by ensuring producer position doesn't advance more than
> -        *   (ringbuf_size - 1) ahead
> -        * - by ensuring oldest not yet committed record until newest
> -        *   record does not span more than (ringbuf_size - 1)
> -        */
> -       if (new_prod_pos - cons_pos > rb->mask ||
> -           new_prod_pos - pend_pos > rb->mask) {
> +       if (!bpf_ringbuf_has_space(rb, new_prod_pos, cons_pos, pend_pos))=
 {
>                 raw_res_spin_unlock_irqrestore(&rb->spinlock, flags);
>                 return NULL;
>         }
>
> +       /* In overwrite mode, move overwrite_pos to the next record to be
> +        * overwritten if the ring buffer is full
> +        */

hm... here I think the important point is that we search for the next
record boundary until which we need to overwrite data such that it
fits newly reserved record. "next record to be overwritten" isn't that
important (we might never need to overwrite it). Important are those
aspects of a) staying on record boundary and b) consuming enough
records to reserve the new one.

Can you please update the comment to mention the above points?

> +       if (unlikely(rb->overwrite_mode)) {
> +               over_pos =3D rb->overwrite_pos;
> +               while (new_prod_pos - over_pos > rb->mask) {
> +                       hdr =3D (void *)rb->data + (over_pos & rb->mask);
> +                       hdr_len =3D READ_ONCE(hdr->len);
> +                       /* since pending_pos is the first record with BUS=
Y
> +                        * bit set and overwrite_pos is never bigger than
> +                        * pending_pos, no need to check BUSY bit here.
> +                        */

honestly, this comment just confused me by implying that BUSY bit
might be important (and set) here. But in reality, we are just
overwriting already committed data which can't have BUSY bit set. It
would be more helpful to mention that bpf_ringbuf_has_space() check
above made sure we are not going to step over record that is being
actively worked on by some other producer.

> +                       over_pos +=3D ringbuf_round_up_hdr_len(hdr_len);
> +               }
> +               /* smp_store_release(&rb->producer_pos, new_prod_pos) at
> +                * the end of the function ensures that when consumer see=
s
> +                * the updated rb->producer_pos, it always sees the updat=
ed
> +                * rb->overwrite_pos, so when consumer reads overwrite_po=
s
> +                * after smp_load_acquire(r->producer_pos), the overwrite=
_pos
> +                * will always be valid.
> +                */
> +               WRITE_ONCE(rb->overwrite_pos, over_pos);
> +       }
> +
>         hdr =3D (void *)rb->data + (prod_pos & rb->mask);
>         pg_off =3D bpf_ringbuf_rec_pg_off(rb, hdr);
>         hdr->len =3D size | BPF_RINGBUF_BUSY_BIT;
> @@ -479,7 +543,50 @@ const struct bpf_func_proto bpf_ringbuf_reserve_prot=
o =3D {
>         .arg3_type      =3D ARG_ANYTHING,
>  };
>
> -static void bpf_ringbuf_commit(void *sample, u64 flags, bool discard)
> +static __always_inline
> +bool ringbuf_should_wakeup(const struct bpf_ringbuf *rb,

consistent naming: bpf_ringbuf_should_wakeup

> +                          unsigned long rec_pos,
> +                          unsigned long cons_pos,
> +                          u32 len, u64 flags)
> +{
> +       unsigned long rec_end;
> +
> +       if (flags & BPF_RB_FORCE_WAKEUP)
> +               return true;
> +
> +       if (flags & BPF_RB_NO_WAKEUP)
> +               return false;
> +
> +       /* for non-overwrite mode, if consumer caught up and is waiting f=
or
> +        * our record, notify about new data availability
> +        */
> +       if (likely(!rb->overwrite_mode))
> +               return cons_pos =3D=3D rec_pos;
> +
> +       /* for overwrite mode, to give the consumer a chance to catch up
> +        * before being overwritten, wake up consumer every half a round
> +        * ahead.
> +        */
> +       rec_end =3D rec_pos + ringbuf_round_up_hdr_len(len);
> +
> +       cons_pos &=3D (rb->mask >> 1);
> +       rec_pos &=3D (rb->mask >> 1);
> +       rec_end &=3D (rb->mask >> 1);
> +
> +       if (cons_pos =3D=3D rec_pos)
> +               return true;
> +
> +       if (rec_pos < cons_pos && cons_pos < rec_end)
> +               return true;
> +
> +       if (rec_end < rec_pos && (cons_pos > rec_pos || cons_pos < rec_en=
d))
> +               return true;
> +

hm... ok, let's discuss this. Why do we need to do some half-round
heuristic for overwrite mode? If a consumer is falling behind it
should be actively trying to catch up and they don't need notification
(that's the non-overwrite mode logic already).

So there is more to this than a brief comment you left, can you please
elaborate?

pw-bot: cr

> +       return false;
> +}
> +
> +static __always_inline

we didn't have always_inline before, any strong reason to add it now?

> +void bpf_ringbuf_commit(void *sample, u64 flags, bool discard)
>  {
>         unsigned long rec_pos, cons_pos;
>         struct bpf_ringbuf_hdr *hdr;
> @@ -495,15 +602,10 @@ static void bpf_ringbuf_commit(void *sample, u64 fl=
ags, bool discard)
>         /* update record header with correct final size prefix */
>         xchg(&hdr->len, new_len);
>
> -       /* if consumer caught up and is waiting for our record, notify ab=
out
> -        * new data availability
> -        */
>         rec_pos =3D (void *)hdr - (void *)rb->data;
>         cons_pos =3D smp_load_acquire(&rb->consumer_pos) & rb->mask;
>
> -       if (flags & BPF_RB_FORCE_WAKEUP)
> -               irq_work_queue(&rb->work);
> -       else if (cons_pos =3D=3D rec_pos && !(flags & BPF_RB_NO_WAKEUP))
> +       if (ringbuf_should_wakeup(rb, rec_pos, cons_pos, new_len, flags))
>                 irq_work_queue(&rb->work);
>  }
>
> @@ -576,6 +678,8 @@ BPF_CALL_2(bpf_ringbuf_query, struct bpf_map *, map, =
u64, flags)
>                 return smp_load_acquire(&rb->consumer_pos);
>         case BPF_RB_PROD_POS:
>                 return smp_load_acquire(&rb->producer_pos);
> +       case BPF_RB_OVER_POS:
> +               return READ_ONCE(rb->overwrite_pos);

do the smp_load_acquire() here just like with all other positions?

>         default:
>                 return 0;
>         }
> @@ -749,6 +853,9 @@ BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, =
map,
>
>         rb =3D container_of(map, struct bpf_ringbuf_map, map)->rb;
>
> +       if (unlikely(rb->overwrite_mode))
> +               return -EOPNOTSUPP;

why this check? We don't allow rb->overwrite_mode to be set for user
ringbuf, no?

> +
>         /* If another consumer is already consuming a sample, wait for th=
em to finish. */
>         if (!atomic_try_cmpxchg(&rb->busy, &busy, 1))
>                 return -EBUSY;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 233de8677382..d3b2fd2ae527 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1430,6 +1430,9 @@ enum {
>
>  /* Do not translate kernel bpf_arena pointers to user pointers */
>         BPF_F_NO_USER_CONV      =3D (1U << 18),
> +
> +/* bpf ringbuf works in overwrite mode? */
> +       BPF_F_OVERWRITE         =3D (1U << 19),
>  };
>
>  /* Flags for BPF_PROG_QUERY. */
> @@ -6215,6 +6218,7 @@ enum {
>         BPF_RB_RING_SIZE =3D 1,
>         BPF_RB_CONS_POS =3D 2,
>         BPF_RB_PROD_POS =3D 3,
> +       BPF_RB_OVER_POS =3D 4,
>  };
>
>  /* BPF ring buffer constants */
> --
> 2.43.0
>

