Return-Path: <linux-kselftest+bounces-42789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA17BBFA43
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 00:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 610C04E42F6
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Oct 2025 22:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56E91E9B1C;
	Mon,  6 Oct 2025 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXA5csi3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F7C11713
	for <linux-kselftest@vger.kernel.org>; Mon,  6 Oct 2025 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759788671; cv=none; b=r5tTKmrpez7yE7/TmJRzQ/L+rMvjKSa+7TBNpfhO5BLftY+TCG2Q1Cgd3a4arGITbrsmZ/mSEhJlVeXpGCr+OQ0wYw5XbdubvUTT5yTK8nqdO9ZiQyxxPc3WBQL/llF7bR7xn/sZiAOTXNWJM7IennrsZhVkwZ4K8ANl6WuCsw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759788671; c=relaxed/simple;
	bh=DHV3EiN0lxv+lYErWqmZujGIa1fkv0wlyETbSMIGW2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZOq63DTqtyQANJm86q2Gi1EiJNZporRpPte7dr5DkShmAVXWAiaBmf7xd28AQBuSEAD3QjN7zpt4LEvm91PuqK6imtZx/oj/PvzkvXP/A3k8lw8Ys+h7ibsO6jX/M6sK0PN7GO4jJHltgVTuiP0tR0uH5MqWQrOMGxsTCYCPBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXA5csi3; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3383ac4d130so5175457a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Oct 2025 15:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759788669; x=1760393469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1T1yZObjQDef09hirExvqobcRZlViu8SZOj9zM47Jo=;
        b=cXA5csi3Fno8i2kcihskI0vqmikD5lIbu0rnkIBRUScwYRioVY8UwfEVmAmvJZz7rt
         1GOvRLo7Xdp/jdmyOJxLAk6XkxCWbiFTl4lSw96SyOUHKRx0bZ2NhaszIm5XdadLw5lx
         MEKl7pxDINlZjgv0xnP5YxdEeDCC22EacYTkIhi2mgcyZmZ37OiyNwhh6AieuPJflNTd
         Mq/tL+QTGxrOoZlG5tDufHOKvO8Dn2td1ZVF1jclK15WKsngHC46uMYxk5/5FiIXBTPw
         g/7f8qcgeZslamwdc6tqO2bhC6E0mTVpVlMR3nPf0RlQnOphWWrmHXy22owPnc/p40Tj
         0DoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759788669; x=1760393469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1T1yZObjQDef09hirExvqobcRZlViu8SZOj9zM47Jo=;
        b=JsKg/si4HQwLnGwZ1feE4li7RlcGgUerpJtQmLkVLCZdKHFVeYtKhMxwS2weV0Ti10
         4I7OrHEZFdqsK4aMb9A9Q0aOxhotUUVpbQOvPLDHc1V9yGJ2/yJ6ovbkjFUDYcoemmUf
         ShmbSs099PXADHvn9Osc5GV2HzaeeslnbECJOyjuwnTiSz4XxqXnWnspzqbxYelGUGHB
         LaaC74DTPr9GieLazbZa6nVcXnL8WWtNnLX5O/QQDd8JvqhbvRu7UrK1nmYSbgGjgN0q
         wAFiDjjxqzIanObICtSqrJGqynqmCId9D46Ga1EXjClUzuVcjR10oQr46XqYPtewhjTb
         zlFw==
X-Forwarded-Encrypted: i=1; AJvYcCVhz1AIRv+rKk65OoRa4O8VTxdGJrIKvTV+jYdrRCCvbOHdSghztLIA5eplaBbOGGiYSRDoNP2RJ1zltrMHAsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzAsDij4LjUQ6PaMgR//WYbIcxzYkopQByPcB2BEQyjAYXTG6g
	avesj3s1l6mm0oBChwAsbxp4XtFBvndiiWECNEc0cIaQUaZpjhwJ7cHQCo8FKOhaaknJKhHm3jW
	3rTOASKyQgWrHphf+40soEnrGemv96Jw=
X-Gm-Gg: ASbGnctOUgRyIpHi63yrPEZnFzuq9wiE/BvawA3Czg8FwIO/Fr/PP1hhmfTVTr/f6HP
	cKQYYBLYKoiRR0q8kf/mxHFAA8dQHPDME5f7m/yEJrGMIHqzx/JZzzFIJX3uvtmwtnOeS3grnm9
	1Pp1r5t4EohAcyfEV4uEW2NgIRAaB2HpAu1BtqsMy7MT+B9k7L3SB6JgK8epYpBFbdLjA1VC7OX
	cQjmtRSIG447Yn7kKFNAkcrQYzwJdD8G2XWEqHDVoqmZuc=
X-Google-Smtp-Source: AGHT+IHz9NehlFhfmFmP4pMr9CTJIA862wujINDkFqnf4UqZwpRuRK6M6EHtCF/PZGuo8i83bQZyDh+NNd9gmZrXN7w=
X-Received: by 2002:a17:90b:1645:b0:336:9e78:c4c1 with SMTP id
 98e67ed59e1d1-339c276e987mr20729311a91.15.1759788668944; Mon, 06 Oct 2025
 15:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905150641.2078838-1-xukuohai@huaweicloud.com>
 <20250905150641.2078838-2-xukuohai@huaweicloud.com> <CAEf4BzaSEjQzF47BZeh0de9pFbKpaB8JqCs629hV9xZDhMyTgw@mail.gmail.com>
 <63272c95-9669-41c1-8e77-575ec37d36c0@huaweicloud.com>
In-Reply-To: <63272c95-9669-41c1-8e77-575ec37d36c0@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Oct 2025 15:10:54 -0700
X-Gm-Features: AS18NWBO6M2HICrYOohnJ3ZcBIkCBSv4Q3JzoIHKQHF3U7d0pFnbaajP30rEf9E
Message-ID: <CAEf4BzbYtaPf0jjoiv16iKWRKkv9ZTH_hBiZMUF+PkjVGOC53A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add overwrite mode for bpf ring buffer
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 6:41=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 9/20/2025 6:10 AM, Andrii Nakryiko wrote:
> > On Fri, Sep 5, 2025 at 8:13=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.=
com> wrote:
> >>
> >> From: Xu Kuohai <xukuohai@huawei.com>
> >>
> >> When the bpf ring buffer is full, new events can not be recorded util
> >
> > typo: until
> >
>
> ACK
>
> >> the consumer consumes some events to free space. This may cause critic=
al
> >> events to be discarded, such as in fault diagnostic, where recent even=
ts
> >> are more critical than older ones.
> >>
> >> So add ovewrite mode for bpf ring buffer. In this mode, the new event
> >
> > overwrite, BPF
> >
>
> ACK
>
> >> overwrites the oldest event when the buffer is full.
> >>
> >> The scheme is as follows:
> >>
> >> 1. producer_pos tracks the next position to write new data. When there
> >>     is enough free space, producer simply moves producer_pos forward t=
o
> >>     make space for the new event.
> >>
> >> 2. To avoid waiting for consumer to free space when the buffer is full=
,
> >>     a new variable overwrite_pos is introduced for producer. overwrite=
_pos
> >>     tracks the next event to be overwritten (the oldest event committe=
d) in
> >>     the buffer. producer moves it forward to discard the oldest events=
 when
> >>     the buffer is full.
> >>
> >> 3. pending_pos tracks the oldest event under committing. producer ensu=
res
> >
> > "under committing" is confusing. Oldest event to be committed?
> >
>
> Yes, 'the oldest event to be committed'. Thanks!
>
> >>     producers_pos never passes pending_pos when making space for new e=
vents.
> >>     So multiple producers never write to the same position at the same=
 time.
> >>
> >> 4. producer wakes up consumer every half a round ahead to give it a ch=
ance
> >>     to retrieve data. However, for an overwrite-mode ring buffer, user=
s
> >>     typically only cares about the ring buffer snapshot before a fault=
 occurs.
> >>     In this case, the producer should commit data with BPF_RB_NO_WAKEU=
P flag
> >>     to avoid unnecessary wakeups.
> >>
> >> To make it clear, here are some example diagrams.
> >>
> >> 1. Let's say we have a ring buffer with size 4096.
> >>
> >>      At first, {producer,overwrite,pending,consumer}_pos are all set t=
o 0
> >>
> >>      0       512      1024    1536     2048     2560     3072     3584=
       4096
> >>      +----------------------------------------------------------------=
-------+
> >>      |                                                                =
       |
> >>      |                                                                =
       |
> >>      |                                                                =
       |
> >>      +----------------------------------------------------------------=
-------+
> >>      ^
> >>      |
> >>      |
> >> producer_pos =3D 0
> >> overwrite_pos =3D 0
> >> pending_pos =3D 0
> >> consumer_pos =3D 0
> >>
> >> 2. Reserve event A, size 512.
> >>
> >>      There is enough free space, so A is allocated at offset 0 and pro=
ducer_pos
> >>      is moved to 512, the end of A. Since A is not submitted, the BUSY=
 bit is
> >>      set.
> >>
> >>      0       512      1024    1536     2048     2560     3072     3584=
       4096
> >>      +----------------------------------------------------------------=
-------+
> >>      |        |                                                       =
       |
> >>      |   A    |                                                       =
       |
> >>      | [BUSY] |                                                       =
       |
> >>      +----------------------------------------------------------------=
-------+
> >>      ^        ^
> >>      |        |
> >>      |        |
> >>      |    producer_pos =3D 512
> >>      |
> >> overwrite_pos =3D 0
> >> pending_pos =3D 0
> >> consumer_pos =3D 0
> >>
> >> 3. Reserve event B, size 1024.
> >>
> >>      B is allocated at offset 512 with BUSY bit set, and producer_pos =
is moved
> >>      to the end of B.
> >>
> >>      0       512      1024    1536     2048     2560     3072     3584=
       4096
> >>      +----------------------------------------------------------------=
-------+
> >>      |        |                 |                                     =
       |
> >>      |   A    |        B        |                                     =
       |
> >>      | [BUSY] |      [BUSY]     |                                     =
       |
> >>      +----------------------------------------------------------------=
-------+
> >>      ^                          ^
> >>      |                          |
> >>      |                          |
> >>      |                   producer_pos =3D 1536
> >>      |
> >> overwrite_pos =3D 0
> >> pending_pos =3D 0
> >> consumer_pos =3D 0
> >>
> >> 4. Reserve event C, size 2048.
> >>
> >>      C is allocated at offset 1536 and producer_pos becomes 3584.
> >>
> >>      0       512      1024    1536     2048     2560     3072     3584=
       4096
> >>      +----------------------------------------------------------------=
-------+
> >>      |        |                 |                                   | =
       |
> >>      |    A   |        B        |                 C                 | =
       |
> >>      | [BUSY] |      [BUSY]     |               [BUSY]              | =
       |
> >>      +----------------------------------------------------------------=
-------+
> >>      ^                                                              ^
> >>      |                                                              |
> >>      |                                                              |
> >>      |                                                    producer_pos=
 =3D 3584
> >>      |
> >> overwrite_pos =3D 0
> >> pending_pos =3D 0
> >> consumer_pos =3D 0
> >>
> >> 5. Submit event A.
> >>
> >>      The BUSY bit of A is cleared. B becomes the oldest event under wr=
iting, so
> >
> > Now it's "under writing" :) To be committed? Or "pending committing"
> > or just "pending", I guess. But not under anything, it just confuses
> > readers. IMO.
> >
>
> Once again, 'oldest event to be committed'.
>
> I should check it with an AI agent first.
>
> >>      pending_pos is moved to 512, the start of B.
> >>
> >>      0       512      1024    1536     2048     2560     3072     3584=
       4096
> >>      +----------------------------------------------------------------=
-------+
> >>      |        |                 |                                   | =
       |
> >>      |    A   |        B        |                 C                 | =
       |
> >>      |        |      [BUSY]     |               [BUSY]              | =
       |
> >>      +----------------------------------------------------------------=
-------+
> >>      ^        ^                                                     ^
> >>      |        |                                                     |
> >>      |        |                                                     |
> >>      |   pending_pos =3D 512                                  producer=
_pos =3D 3584
> >>      |
> >> overwrite_pos =3D 0
> >> consumer_pos =3D 0
> >>
> >> 6. Submit event B.
> >>
> >>      The BUSY bit of B is cleared, and pending_pos is moved to the sta=
rt of C,
> >>      which is the oldest event under writing now.
> >
> > ditto
> >
>
> Again and again :(
>
> >>
> >>      0       512      1024    1536     2048     2560     3072     3584=
       4096
> >>      +----------------------------------------------------------------=
-------+
> >>      |        |                 |                                   | =
       |
> >>      |    A   |        B        |                 C                 | =
       |
> >>      |        |                 |               [BUSY]              | =
       |
> >>      +----------------------------------------------------------------=
-------+
> >>      ^                          ^                                   ^
> >>      |                          |                                   |
> >>      |                          |                                   |
> >>      |                     pending_pos =3D 1536               producer=
_pos =3D 3584
> >>      |
> >> overwrite_pos =3D 0
> >> consumer_pos =3D 0
> >>
> >> 7. Reserve event D, size 1536 (3 * 512).
> >>
> >>      There are 2048 bytes not under writing between producer_pos and p=
ending_pos,
> >>      so D is allocated at offset 3584, and producer_pos is moved from =
3584 to
> >>      5120.
> >>
> >>      Since event D will overwrite all bytes of event A and the beginin=
g 512 bytes
> >
> > typo: beginning, but really "first 512 bytes" would be clearer
> >
>
> OK, I=E2=80=99ll switch to 'first 512 bytes' for clarity.
>
> >>      of event B, overwrite_pos is moved to the start of event C, the o=
ldest event
> >>      that is not overwritten.
> >>
> >>      0       512      1024    1536     2048     2560     3072     3584=
       4096
> >>      +----------------------------------------------------------------=
-------+
> >>      |                 |        |                                   | =
       |
> >>      |      D End      |        |                 C                 | =
D Begin|
> >>      |      [BUSY]     |        |               [BUSY]              | =
[BUSY] |
> >>      +----------------------------------------------------------------=
-------+
> >>      ^                 ^        ^
> >>      |                 |        |
> >>      |                 |   pending_pos =3D 1536
> >>      |                 |   overwrite_pos =3D 1536
> >>      |                 |
> >>      |             producer_pos=3D5120
> >>      |
> >> consumer_pos =3D 0
> >>
> >> 8. Reserve event E, size 1024.
> >>
> >>      Though there are 512 bytes not under writing between producer_pos=
 and
> >>      pending_pos, E can not be reserved, as it would overwrite the fir=
st 512
> >>      bytes of event C, which is still under writing.
> >>
> >> 9. Submit event C and D.
> >>
> >>      pending_pos is moved to the end of D.
> >>
> >>      0       512      1024    1536     2048     2560     3072     3584=
       4096
> >>      +----------------------------------------------------------------=
-------+
> >>      |                 |        |                                   | =
       |
> >>      |      D End      |        |                 C                 | =
D Begin|
> >>      |                 |        |                                   | =
       |
> >>      +----------------------------------------------------------------=
-------+
> >>      ^                 ^        ^
> >>      |                 |        |
> >>      |                 |   overwrite_pos =3D 1536
> >>      |                 |
> >>      |             producer_pos=3D5120
> >>      |             pending_pos=3D5120
> >>      |
> >> consumer_pos =3D 0
> >>
> >> The performance data for overwrite mode will be provided in a follow-u=
p
> >> patch that adds overwrite mode benchs.
> >>
> >> A sample of performance data for non-overwrite mode on an x86_64 and a=
rm64
> >> CPU, before and after this patch, is shown below. As we can see, no ob=
vious
> >> performance regression occurs.
> >>

[...]

> >> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> >> ---
> >>   include/uapi/linux/bpf.h       |   4 +
> >>   kernel/bpf/ringbuf.c           | 159 +++++++++++++++++++++++++++----=
--
> >>   tools/include/uapi/linux/bpf.h |   4 +
> >>   3 files changed, 141 insertions(+), 26 deletions(-)
> >>

[...]

> >> +
> >> +       over_pos =3D READ_ONCE(rb->overwrite_pos);
> >> +       return min(prod_pos - max(cons_pos, over_pos), rb->mask + 1);
> >
> > I'm trying to understand why you need to min with `rb->mask + 1`, can
> > you please elaborate?
>
>
> We need the min because rb->producer_pos and rb->overwrite_pos are read
> at different times. During this gap, a fast producer may wrap once or
> more, making over_pos larger than prod_pos.
>

what if you read overwrite_pos before reading producer_pos? Then it
can't be larger than producer_pos and available data would be
producer_pos - max(consumer_pos, overwrite_pos)? would that work?


> > And also, at least for consistency, use smp_load_acquire() for overwrit=
e_pos?
> >
>
> Using READ_ONCE here is to stay symmetric with __bpf_ringbuf_reserve(),
> where overwrite_pos is WRITE_ONCE first, followed by smp_store_release(pr=
oducer_pos).
> So here we do smp_load_acquire(producer_pos) first, then READ_ONCE(overwr=
ite_pos)
> to ensure a consistent view of the ring buffer.
>
> For consistency when reading consumer_pos and producer_pos, I=E2=80=99m f=
ine with
> switching READ_ONCE to smp_load_acquire for overwrite_pos.
>

I'm not sure it matters much, but this function is called outside of
rb->spinlock, while __bpf_ringbuf_reserve() does hold a lock while
doing that WRITE_ONCE(). So it might not make any difference, but I
have mild preference for smp_load_acquire() here.

> >>   }
> >>
> >>   static u32 ringbuf_total_data_sz(const struct bpf_ringbuf *rb)
> >> @@ -402,11 +419,43 @@ bpf_ringbuf_restore_from_rec(struct bpf_ringbuf_=
hdr *hdr)
> >>          return (void*)((addr & PAGE_MASK) - off);
> >>   }
> >>
> >> +

[...]

> >> +       /* In overwrite mode, move overwrite_pos to the next record to=
 be
> >> +        * overwritten if the ring buffer is full
> >> +        */
> >
> > hm... here I think the important point is that we search for the next
> > record boundary until which we need to overwrite data such that it
> > fits newly reserved record. "next record to be overwritten" isn't that
> > important (we might never need to overwrite it). Important are those
> > aspects of a) staying on record boundary and b) consuming enough
> > records to reserve the new one.
> >
> > Can you please update the comment to mention the above points?
> >
>
> Sure, I'll update the comment to:
>
> In overwrite mode, advance overwrite_pos when the ring buffer is full.
> The key points are to stay on record boundaries and consume enough
> records to fit the new one.
>

ok

[...]

>
> >> +                          unsigned long rec_pos,
> >> +                          unsigned long cons_pos,
> >> +                          u32 len, u64 flags)
> >> +{
> >> +       unsigned long rec_end;
> >> +
> >> +       if (flags & BPF_RB_FORCE_WAKEUP)
> >> +               return true;
> >> +
> >> +       if (flags & BPF_RB_NO_WAKEUP)
> >> +               return false;
> >> +
> >> +       /* for non-overwrite mode, if consumer caught up and is waitin=
g for
> >> +        * our record, notify about new data availability
> >> +        */
> >> +       if (likely(!rb->overwrite_mode))
> >> +               return cons_pos =3D=3D rec_pos;
> >> +
> >> +       /* for overwrite mode, to give the consumer a chance to catch =
up
> >> +        * before being overwritten, wake up consumer every half a rou=
nd
> >> +        * ahead.
> >> +        */
> >> +       rec_end =3D rec_pos + ringbuf_round_up_hdr_len(len);
> >> +
> >> +       cons_pos &=3D (rb->mask >> 1);
> >> +       rec_pos &=3D (rb->mask >> 1);
> >> +       rec_end &=3D (rb->mask >> 1);
> >> +
> >> +       if (cons_pos =3D=3D rec_pos)
> >> +               return true;
> >> +
> >> +       if (rec_pos < cons_pos && cons_pos < rec_end)
> >> +               return true;
> >> +
> >> +       if (rec_end < rec_pos && (cons_pos > rec_pos || cons_pos < rec=
_end))
> >> +               return true;
> >> +
> >
> > hm... ok, let's discuss this. Why do we need to do some half-round
> > heuristic for overwrite mode? If a consumer is falling behind it
> > should be actively trying to catch up and they don't need notification
> > (that's the non-overwrite mode logic already).
> >
> > So there is more to this than a brief comment you left, can you please
> > elaborate?
> >
>
> The half-round wakeup was originally intended to work with libbpf in the
> v1 version. In that version, libbpf used a retry loop to safely copy data
> from the ring buffer that hadn=E2=80=99t been overwritten. By waking the =
consumer
> once every half round, there was always a period where the consumer and
> producer did not overlap, which helped reduce the number of retries.

I can't say I completely grok the logic here, but do you think we
should still keep this half-round wakeup? It looks like an arbitrary
heuristic, so I'd rather not have it.

>
> > pw-bot: cr
> >
> >> +       return false;
> >> +}
> >> +
> >> +static __always_inline
> >
> > we didn't have always_inline before, any strong reason to add it now?
> >
>
> I just wanted to avoid introducing any performance regression. Before thi=
s
> patch, bpf_ringbuf_commit() was automatically inlined by the compiler, bu=
t
> after the patch it wasn=E2=80=99t, so I added always_inline explicitly to=
 keep it
> inlined.

how big of a difference was it in benchmarks? It's generally frowned
upon using __always_inline without a good reason.

[...]

