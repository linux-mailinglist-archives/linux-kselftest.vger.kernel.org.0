Return-Path: <linux-kselftest+bounces-18547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DC098961D
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 17:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8357284F1A
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 15:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2067C17DFF2;
	Sun, 29 Sep 2024 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="J3HT3WJ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8530414287
	for <linux-kselftest@vger.kernel.org>; Sun, 29 Sep 2024 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727624000; cv=none; b=t8327QJvvbJB1acIKlLya1Msc3FHgtPTtkpwTJjY3sQDcBui22zsoppeidgeTCf57+lfaj0Q9rpMe3GDbZfu7n8ylq5uiV/emA0MmKrmonrcaxCeBIbTXluNaZ9Cn9NtIFae1NuGiPcscIVu+kfpS5WkSWh1RUedeaYsnLZbFSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727624000; c=relaxed/simple;
	bh=R/KAIucJR64DhM14PlnEqlxirD95bh38Qn5Yl/jW8RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+Kbs8aQtLwcrhZU9ayZwr441uGcSnDWhB9z8ogRvwLGLkjq/GF312uytuB6lJ9/nqPeuP7/kZ1a0Y2Nznrjl+tX93v7OSGx1E87rCKIOfvdlGRC0fUVH3N3WxnSeSSTboW4+GhU48TQVs6sveBHQURtF57hUh2j9O71lQXb4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=J3HT3WJ1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-719b17b2da1so2587026b3a.0
        for <linux-kselftest@vger.kernel.org>; Sun, 29 Sep 2024 08:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1727623997; x=1728228797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/KAIucJR64DhM14PlnEqlxirD95bh38Qn5Yl/jW8RQ=;
        b=J3HT3WJ1ODhyZS+D6fqWY31XG5Rmjejjj5TPherTRHTzGub0LRGY/onYj592EpEfRF
         7z2qL2RRSnluUeNAMhYm2d7DDTGg9IoQYdAGA3phzWyH4oGjMV6HwCJnzqjrqiSgIlZi
         zDkHYVE84Lm3ITRZUYvoBTPj6lEv0/PxMpYPyvlaDzcyxwGHgugQub2ual0/cSAyEbnm
         O9+ApCxNc7w5qemKLvpCZoP9uuQug3w8T1rjexsA1EscddCE/o2b35nYmhVbcn/YZvdk
         Lp8a8d6Yn/GY5uX24SwqRaU75WmyoNQLazKyrQy5jUWF6Q4UDv3AsHWP/C4HUZ1NKy5K
         m3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727623997; x=1728228797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/KAIucJR64DhM14PlnEqlxirD95bh38Qn5Yl/jW8RQ=;
        b=Nb2MMSc8+eO7QzdMU96iwn3x+K7GihS5CL/FtuVqNWKCQhmVNXtoCdLZShTMXqf5/m
         fBXUZYHqrYQOy9PIE0DEeju1AgLjV2HqfN8bRc10JgZDHg0L6BRTLnpRkLPvxgYmtBeH
         IeSpw5mGUUDDrk0SjKSUUrFmRg2fQimUHFtnXjMMKT5bEjgzMQqHFxiRsPtTGEe8etdj
         xs+0+fk3g/EiI7p/tTI8uGfDT2GqWbnCCUGo53SVuU+GMqvbkUjG4hKCgLnnrAQscrxb
         tFQiP3f3GIdEV0DvBgF8+QpxByiVmFNWrRP9orpj46B2FkeWZNroQFy/lqpVtOi2fBrk
         FmUw==
X-Forwarded-Encrypted: i=1; AJvYcCVWDS4ZVBbPPRbCudAtKPCG5BNn1Oj3HMMl5uSCgYIvPyZnh6cZXEEossQpX2mIXKweZms5NAwL5MSnoVVxvVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ZzhD+qpQk2ViXv0PCReGsAI45de7woy/x5CH1o1aI9H1gQS8
	2b8189daKEXgXpY9PnkDznA7nv2/AiHWjxNQQJDwAozOv8yKZfP3ejxBmHBRAxQ=
X-Google-Smtp-Source: AGHT+IGuZ2ZQ2xF0vqQIURXhh3/WO6fyMaueh6tDYx0LjIXGb2PeQu34yIj5VrsYQjGUWlhTfeQehQ==
X-Received: by 2002:a05:6a00:80f:b0:71b:64c:814b with SMTP id d2e1a72fcca58-71b26062754mr15148322b3a.23.1727623997547;
        Sun, 29 Sep 2024 08:33:17 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2653663asm4681814b3a.187.2024.09.29.08.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 08:33:17 -0700 (PDT)
Date: Sun, 29 Sep 2024 08:33:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan
 <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko
 <andrew@daynix.com>, gur.stavi@huawei.com
Subject: Re: [PATCH RFC v4 0/9] tun: Introduce virtio-net hashing feature
Message-ID: <20240929083314.02d47d69@hermes.local>
In-Reply-To: <447dca19-58c5-4c01-b60e-cfe5e601961a@daynix.com>
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
	<CACGkMEvMuBe5=wQxZMns4R-oJtVOWGhKM3sXy8U6wSQX7c=iWQ@mail.gmail.com>
	<c3bc8d58-1f0e-4633-bb01-d646fcd03f54@daynix.com>
	<CACGkMEu3u=_=PWW-=XavJRduiHJuZwv11OrMZbnBNVn1fptRUw@mail.gmail.com>
	<6c101c08-4364-4211-a883-cb206d57303d@daynix.com>
	<CACGkMEtscr17UOufUtyPp1OvALL8LcycpbRp6CyVMF=jYzAjAA@mail.gmail.com>
	<447dca19-58c5-4c01-b60e-cfe5e601961a@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 29 Sep 2024 16:10:47 +0900
Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> On 2024/09/29 11:07, Jason Wang wrote:
> > On Fri, Sep 27, 2024 at 3:51=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote: =20
> >>
> >> On 2024/09/27 13:31, Jason Wang wrote: =20
> >>> On Fri, Sep 27, 2024 at 10:11=E2=80=AFAM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote: =20
> >>>>
> >>>> On 2024/09/25 12:30, Jason Wang wrote: =20
> >>>>> On Tue, Sep 24, 2024 at 5:01=E2=80=AFPM Akihiko Odaki <akihiko.odak=
i@daynix.com> wrote: =20
> >>>>>>
> >>>>>> virtio-net have two usage of hashes: one is RSS and another is hash
> >>>>>> reporting. Conventionally the hash calculation was done by the VMM.
> >>>>>> However, computing the hash after the queue was chosen defeats the
> >>>>>> purpose of RSS.
> >>>>>>
> >>>>>> Another approach is to use eBPF steering program. This approach has
> >>>>>> another downside: it cannot report the calculated hash due to the
> >>>>>> restrictive nature of eBPF.
> >>>>>>
> >>>>>> Introduce the code to compute hashes to the kernel in order to ove=
rcome
> >>>>>> thse challenges.
> >>>>>>
> >>>>>> An alternative solution is to extend the eBPF steering program so =
that it
> >>>>>> will be able to report to the userspace, but it is based on context
> >>>>>> rewrites, which is in feature freeze. We can adopt kfuncs, but the=
y will
> >>>>>> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (=
KVM
> >>>>>> and vhost_net).
> >>>>>> =20
> >>>>>
> >>>>> I wonder if we could clone the skb and reuse some to store the hash,
> >>>>> then the steering eBPF program can access these fields without
> >>>>> introducing full RSS in the kernel? =20
> >>>>
> >>>> I don't get how cloning the skb can solve the issue.
> >>>>
> >>>> We can certainly implement Toeplitz function in the kernel or even w=
ith
> >>>> tc-bpf to store a hash value that can be used for eBPF steering prog=
ram
> >>>> and virtio hash reporting. However we don't have a means of storing a
> >>>> hash type, which is specific to virtio hash reporting and lacks a
> >>>> corresponding skb field. =20
> >>>
> >>> I may miss something but looking at sk_filter_is_valid_access(). It
> >>> looks to me we can make use of skb->cb[0..4]? =20
> >>
> >> I didn't opt to using cb. Below is the rationale:
> >>
> >> cb is for tail call so it means we reuse the field for a different
> >> purpose. The context rewrite allows adding a field without increasing
> >> the size of the underlying storage (the real sk_buff) so we should add=
 a
> >> new field instead of reusing an existing field to avoid confusion.
> >>
> >> We are however no longer allowed to add a new field. In my
> >> understanding, this is because it is an UAPI, and eBPF maintainers fou=
nd
> >> it is difficult to maintain its stability.
> >>
> >> Reusing cb for hash reporting is a workaround to avoid having a new
> >> field, but it does not solve the underlying problem (i.e., keeping eBPF
> >> as stable as UAPI is unreasonably hard). In my opinion, adding an ioctl
> >> is a reasonable option to keep the API as stable as other virtualizati=
on
> >> UAPIs while respecting the underlying intention of the context rewrite
> >> feature freeze. =20
> >=20
> > Fair enough.
> >=20
> > Btw, I remember DPDK implements tuntap RSS via eBPF as well (probably
> > via cls or other). It might worth to see if anything we miss here. =20
>=20
> Thanks for the information. I wonder why they used cls instead of=20
> steering program. Perhaps it may be due to compatibility with macvtap=20
> and ipvtap, which don't steering program.
>=20
> Their RSS implementation looks cleaner so I will improve my RSS=20
> implementation accordingly.
>=20

DPDK needs to support flow rules. The specific case is where packets
are classified by a flow, then RSS is done across a subset of the queues.
The support for flow in TUN driver is more academic than useful,
I fixed it for current BPF, but doubt anyone is using it really.

A full steering program would be good, but would require much more
complexity to take a general set of flow rules then communicate that
to the steering program.


