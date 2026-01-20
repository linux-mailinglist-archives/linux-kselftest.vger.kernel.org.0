Return-Path: <linux-kselftest+bounces-49432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 498A6D3BD65
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 03:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 490783023536
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 02:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E9A257821;
	Tue, 20 Jan 2026 02:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb6Pke1G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C41123C50A
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874526; cv=pass; b=EfHxAhpEK3GMhU0/u1AVNAJKj13AGj3splwO5/vvgGlPd38kkpboVBqbfBQUxL8vSHmA1GyDFvfoVw85N7RMqvY49MVifpuG4T+NhP0tvigYrpOlSnb7IxX7FMR6YEZFpQw5f1Lw+uMmNvoGfQvYR7Kt+UgkX+yyNlK7lywigtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874526; c=relaxed/simple;
	bh=SqHrVPjT9vlZKR1UpPWYn/8KLOzcXgsoZh+2ANBrF50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMrvAZlIm+GzTSsAOu8MWPuft+tjjr8i7osivzMPx4AFUaf6UL/GlUuqqxpWscZ4r2Ln3gFI4n2vTOYd88SWxuf5jy4aAAaVHeylzEfdrgoGpUgN9qyEVAtet8u5GRQXkYT7y1RuPpB04DjL5kVDli5yuxLBQ7du9oaI0QD/OFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kb6Pke1G; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fb5810d39so3790274f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 18:02:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768874524; cv=none;
        d=google.com; s=arc-20240605;
        b=eX6hFjBH+B5gbmqnRCrsFUaUqGl/EnZKP/nEaRBdyVcryeGK6vPmpDvkhmrJ/fDIe5
         linamT/pojmr3oPCMZQmQ56FJLZHS57DvcW/49XoMEPycVKBh9WNB3XhpXuGmsvCvfNR
         UmHnIZbvB3yOL+YttaZbTELNjtQ+n3/oDLak3jWqIvJs3GFEPhAHRb8gOstLBSgPPPex
         mHR5mtLv3za40+BsJ1e3pIQ0ZNR2nxnoMYGj/O7pr5j+2fAE7CPKCOPLOqtAqrtdlJ6x
         yQX38SjqtrQOr6fnPk9VmBGyWjEzQQuOQ2nhR1DBeG1JtW0+R67ffAf3ehrluCfjQuzL
         u4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zF2yWK7zvI1C0O5oWVR36FsjQwZ4yq9cJQ9urhGlw/M=;
        fh=KdmoQgw1Ji8PbZosfJZ/HvlbUQ4NBjS8gv7j1LAEOhA=;
        b=OXBO7ckKV+JKXoZJSbexLlkz7MEaAXIvJUqTdE07WZjBN33WR/XJlc8dZpRCyyOGNB
         AM6w5hTjKpwodugdZa4niX1d5Dr93f9/5Gk7ix9i3yBBR35lz0+54HFCBkzcI+nzcCvY
         QJfUCSu+OC68M5snVZW3tsp8SSEBgPMAEDEnde+Zvr/wAVwu3ENKcYVx707zpX88u079
         S4FF4WR7zs5hO7hCDbWJigt+xeARwN8Ic6zXzyqPyVQYfWVRhReL4+D7qzfj2kAMyYn0
         TaCdYVh8kbbidviEPifqRYXWf/6uWzKbRbA+T1x2OzWC9sEpMPPtuM3r7Aip26T/Nvkx
         G2HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768874524; x=1769479324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zF2yWK7zvI1C0O5oWVR36FsjQwZ4yq9cJQ9urhGlw/M=;
        b=kb6Pke1GlOXAXgGwSiZ7pXuohgl5d0EYlZYrDyTpmJNyo5pPb1SlkyvT0iqfZ7KplY
         KDPXaqK6g6z90c4/anvf0IK2MaZpBsPET1BOhh/zCcwY4LOdVP5QBOborsbwOZNTV7VF
         7t8GrngxP1AzEHM/oLSm2HS8nSCIN+G2/XWV4oEgN863VVKJMVoFoQxjSCIPZtpLPU47
         RDQII2i8uIlvGTXyhDpxBGMJWwaMhyjEFUc0Y6rfYrQygcUh2vk/JxC6CcNTEbuYNubw
         COiJgXZZckQmTvoksTtgkF821uFmquGNsC1f0MY/kVr+aV+dplNJWSfnSkhyZHGCPXU2
         l6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768874524; x=1769479324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zF2yWK7zvI1C0O5oWVR36FsjQwZ4yq9cJQ9urhGlw/M=;
        b=lrhtL5u0lnJUSgtaLthomtEPKaKj2eNi+psC6DoZ4GQ1nai+UNTn7EVYY9aex61T6R
         BLkrmG0RGcl19f+x17uNPQ+IQTN9d65qhJZ8bZL15w5Q3wwiwv2a6k2edmvN1y1cSXj0
         PlYl3jHsY1N+sBfWgDUl5SzSlVq0z7rArM3XK4oWJ2iL1xAG9rYFqZKzli70b233uvbY
         a5OfkQR19Kx+t6xLVgOULbgexSKqFtFPdr7495QjrpyNFEkkdwz38N1D3LDmMOFqiuFj
         cQ+NkQ9VIekqYKxjv3IwuoTZSxnqWeL7Q6UzTj8QmeySg7JN1HaaXqQKGcg/5O1rwcKy
         cCmA==
X-Forwarded-Encrypted: i=1; AJvYcCUowU5rHgKSYBSq60qnC4yBRB/VacOPJcWXsBq7Y1o/DHnSrWL9X8PkxweTJqRaJEoLF4eIqkOgDrTGOdO7G8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIBNK0cDjCk0XlKrTumnjDjyb0NyZtVy8Gm70sDMyTDwCRe+dA
	rPGD6tE8mprmQlBPyktAxsj5CpfdlEe18s9+CR1kcTpV33US6fHimeqStYmHgws9DNGPQTPVM8j
	RBwCNHVj08AjMHIIc+zaEBw1Gf6yMJQA=
X-Gm-Gg: AZuq6aLcu4zCyRAe0v4T0jeja+sOxi4nFL8HSidd3LcsNzyhwCQQ2M+6QH/UcYybaRC
	U2vHFp+RBArlm8uP5kSEzZbYS7L66pyXNXASQGJ/uQxKxXLn9F5qcJY3AHcFEKIzPMoW36w4qO1
	xM7VwlxrYFWRudIwISo+9ym0yrbPH+zHiqFk2UATQmyQtsASmUdx5uT7Yqo+s8UKVwsYgtpGLD1
	cXVKMSrKB3TxLV0NbLpUAv9TNhUoOEKgeQf+M7G6+xGpBaORtn2aciujIjFP9N6DM+K3hhEe+lS
	w7JMy2igQfyhWllIyCNvBiFoBDXAeVoqXcLfOa8NzE87SQtAZTRidhhYwvoumCTFdCEIFjyVcXX
	r70rWoklARvXc2Q==
X-Received: by 2002:a05:6000:310d:b0:430:f58d:40e5 with SMTP id
 ffacd0b85a97d-4356a051bbamr14568717f8f.30.1768874523500; Mon, 19 Jan 2026
 18:02:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119142120.28170-3-leon.hwang@linux.dev> <a4904d743818169a9a8c1e30dd51ee7a8672bf2b883e973dcca489ff28a3e708@mail.kernel.org>
 <8ed48af7-8a85-4012-8b86-79e83f0689b6@linux.dev>
In-Reply-To: <8ed48af7-8a85-4012-8b86-79e83f0689b6@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 19 Jan 2026 18:01:52 -0800
X-Gm-Features: AZwV_QhpYBM9PhwiJJzku6_RURNwOkTgXHw-IKAun2oUPnbV12Zz2R3tusUhVBY
Message-ID: <CAADnVQKMOK8jMcYugtrjsqh3O-C_hUsKVL6jKfcGVD5g_1pVxQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Avoid deadlock using trylock when
 popping LRU free nodes
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 5:57=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 20/1/26 02:46, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
> >> index c091f3232cc5..03d37f72731a 100644
> >> --- a/kernel/bpf/bpf_lru_list.c
> >> +++ b/kernel/bpf/bpf_lru_list.c
> >
> > [ ... ]
> >
> >> @@ -451,13 +455,12 @@ static struct bpf_lru_node *bpf_common_lru_pop_f=
ree(struct bpf_lru *lru,
> >>
> >>      loc_l =3D per_cpu_ptr(clru->local_list, cpu);
> >>
> >> -    raw_spin_lock_irqsave(&loc_l->lock, flags);
> >> +    if (!raw_spin_trylock_irqsave(&loc_l->lock, flags))
> >> +            return NULL;
> >>
> >>      node =3D __local_list_pop_free(loc_l);
> >> -    if (!node) {
> >> -            bpf_lru_list_pop_free_to_local(lru, loc_l);
> >> +    if (!node && bpf_lru_list_pop_free_to_local(lru, loc_l))
> >>              node =3D __local_list_pop_free(loc_l);
> >> -    }
> >>
> >>      if (node)
> >>              __local_list_add_pending(lru, loc_l, cpu, node, hash);
> >
> > The trylock conversion here looks correct, but what about the steal pat=
h
> > that follows later in bpf_common_lru_pop_free()? Looking at the existin=
g
> > code (not shown in this diff), the steal loop still uses unconditional
> > raw_spin_lock_irqsave():
> >
> >     do {
> >         steal_loc_l =3D per_cpu_ptr(clru->local_list, steal);
> >
> >         raw_spin_lock_irqsave(&steal_loc_l->lock, flags);
> >         ...
> >     } while (...);
> >
> > If the goal is to avoid NMI-context deadlocks when acquiring LRU locks,
> > can the same deadlock scenario occur when NMI interrupts during the ste=
al
> > loop and the NMI handler tries to acquire the same steal_loc_l->lock?
> >
> > Similarly, after a successful steal, there is another unconditional loc=
k:
> >
> >     if (node) {
> >         raw_spin_lock_irqsave(&loc_l->lock, flags);
> >         __local_list_add_pending(lru, loc_l, cpu, node, hash);
> >         raw_spin_unlock_irqrestore(&loc_l->lock, flags);
> >     }
> >
> > Should these also use trylock to maintain consistency with the stated g=
oal
> > of avoiding NMI-context deadlocks?
> >
>
> This patch is not intended to eliminate all possible deadlock scenarios.
> Its goal is to avoid deadlocks caused by long-lived critical sections
> in the free-node pop paths, where lock contention can persist and lead
> to re-entrant lock acquisition from NMI context.
>
> The steal path and the post-steal update are both short-lived critical
> sections. They do not exhibit the same contention characteristics and
> have not been observed to trigger the reported deadlock scenarios.
> Converting these paths to trylock would add complexity without clear
> benefit, and is therefore unnecessary for the stated goal of this change.

AI is correct. Either everything needs to be converted or none.
Adding trylock in a few places because syzbot found them is not fixing anyt=
hing.
Just silencing one (or a few?) syzbot reports.
As I said in the other email, trylock is not an option.
rqspinlock is the only true way of addressing potential deadlocks.
If it's too hard, then leave it as-is. Do not hack things half way.

