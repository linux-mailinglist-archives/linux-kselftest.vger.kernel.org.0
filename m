Return-Path: <linux-kselftest+bounces-18801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC3E98C375
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 18:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7014D1C24370
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8D41CBE8C;
	Tue,  1 Oct 2024 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="vXQ7cLv9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDF81CBE88
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800272; cv=none; b=DQvAvv2NoxIiNDqP9ifV+ncuxvP2aqoQmWKe8FYpNuZhUtO3uSqm7ADHulv7nGkHNgU5L7h3iwBpseD4DyRvYN3Fe9JPFXYAe/EtR9NiGmhycfzu7Sko1KqMgrMCcCh8VDsZ/nbdD7vOXs88re8x4+fet8IeGvshBotPYIkeZLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800272; c=relaxed/simple;
	bh=tmCg5BWsCw59JIzvnnyzLDO7fHE1f4U4nQ8gTD+boTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGIHX5HBmsLcKRVzwL02f8NHDiKYTz+BTIBr4hTXL19fQE0xAEYk0bOG9jspmT92pl6VPtE2Fdbi7O+4und8/wysBXqHuYd1VEJc9lHRe1D2EUUxKtIXHxzqi7UPajhXllIySyeE73dM9W9lJJmO39toqm90smQQhQECADD0DOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=vXQ7cLv9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71db62281aeso1274464b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Oct 2024 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1727800269; x=1728405069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaOCtJBpmUXeW5fDjOcuOw2JadaIwq6wWesigL7oUQQ=;
        b=vXQ7cLv92aK8tiLsyyjo3pFZkW0D6qVdtFa1oIGlsHoHHQnhRYAPgUUBPiOeNcAZBO
         3UUMSjcq1nx56InsGdcqVu18nGdiCdFzM4Et39fVXe5g2sKJTFukl+BV9RcwTdzz9L0f
         AdiL0xDWxmDGaXgOa9GwDqH97tnUegBiUwBj3SEU6eIgbYMo54xxeGAT4WYn9/1m97GJ
         zeh32S5EMpnSLOCXGt1Z2H7LwIP5s3TESi12QgXoAp5GzVbQDLWtfip/cAPmLK+8HzeC
         xG+D5GgqNw4kmVnEp+maVqmrVggWCwxsAYQ9I+nSomqpO9hv2xEKrlQPZ2izSS3APNkQ
         oCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727800269; x=1728405069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaOCtJBpmUXeW5fDjOcuOw2JadaIwq6wWesigL7oUQQ=;
        b=lqNS13kjLr/RiLhR2NlSysOwlcqcYjBXwryUifEJQCpN96FSy8+wttIiQPXMS1YGn+
         a2mqN7t8waTXGnXtQ07j7QS8KRMzv/xcv/RLC62GqogkhOzSnDEaNGboXnPWG2I49LsC
         vxbMagr23HQOGRj+o9is7RraPNCr4ZsrPWaRZSH9Bkp5frZF/TpwdCSTJNwmxGkLTfPs
         XoWRk+srl8lcsZHRCMHKFNQcKa0VVFbm23/7uqhImnRwvCxjIwXINZPtUrq6DYbk3YjI
         qpVOcjK6wDOWx2wyPAUaE+S7XmczycNBM7Wj++fvubzX8+8aXFUnW+JL4j3JlwYbZNqv
         l2bA==
X-Forwarded-Encrypted: i=1; AJvYcCV42o0mDrkX8hXoEl2pbtErHS+32i8ikKQw5kqDhLguf2QG1SKry/dqtvtJB6duCxOsFWOE0cGJ6/SsR4qVvjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0wLrA/AuP8CZxum/kaat8AAE+D+AKmai5AA2Uwb14tcC1cx8N
	fhdOOMPeBZIVaANfn0oVrl5IZmBmVWihQJc0/wKCWsWTzY/1yDTjM8wfQkXaZNs=
X-Google-Smtp-Source: AGHT+IEJ1YSBFgA6XCPu/UKUAJZ+sUtJEj01EpSGftWy6BCcu9DYD9VOPkZdjd+3NzkAra9PlbsRcg==
X-Received: by 2002:a05:6a00:22ca:b0:717:9896:fb03 with SMTP id d2e1a72fcca58-71dc6010da0mr239138b3a.6.1727800268875;
        Tue, 01 Oct 2024 09:31:08 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bb2b8sm8246283b3a.61.2024.10.01.09.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:31:08 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:31:05 -0700
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
Message-ID: <20241001093105.126dacd6@hermes.local>
In-Reply-To: <f437d2d6-e4a2-4539-bd30-f312bbf0eac8@daynix.com>
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
	<CACGkMEvMuBe5=wQxZMns4R-oJtVOWGhKM3sXy8U6wSQX7c=iWQ@mail.gmail.com>
	<c3bc8d58-1f0e-4633-bb01-d646fcd03f54@daynix.com>
	<CACGkMEu3u=_=PWW-=XavJRduiHJuZwv11OrMZbnBNVn1fptRUw@mail.gmail.com>
	<6c101c08-4364-4211-a883-cb206d57303d@daynix.com>
	<CACGkMEtscr17UOufUtyPp1OvALL8LcycpbRp6CyVMF=jYzAjAA@mail.gmail.com>
	<447dca19-58c5-4c01-b60e-cfe5e601961a@daynix.com>
	<20240929083314.02d47d69@hermes.local>
	<f437d2d6-e4a2-4539-bd30-f312bbf0eac8@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Oct 2024 14:54:29 +0900
Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> On 2024/09/30 0:33, Stephen Hemminger wrote:
> > On Sun, 29 Sep 2024 16:10:47 +0900
> > Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >  =20
> >> On 2024/09/29 11:07, Jason Wang wrote: =20
> >>> On Fri, Sep 27, 2024 at 3:51=E2=80=AFPM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote: =20
> >>>>
> >>>> On 2024/09/27 13:31, Jason Wang wrote: =20
> >>>>> On Fri, Sep 27, 2024 at 10:11=E2=80=AFAM Akihiko Odaki <akihiko.oda=
ki@daynix.com> wrote: =20
> >>>>>>
> >>>>>> On 2024/09/25 12:30, Jason Wang wrote: =20
> >>>>>>> On Tue, Sep 24, 2024 at 5:01=E2=80=AFPM Akihiko Odaki <akihiko.od=
aki@daynix.com> wrote: =20
> >>>>>>>>
> >>>>>>>> virtio-net have two usage of hashes: one is RSS and another is h=
ash
> >>>>>>>> reporting. Conventionally the hash calculation was done by the V=
MM.
> >>>>>>>> However, computing the hash after the queue was chosen defeats t=
he
> >>>>>>>> purpose of RSS.
> >>>>>>>>
> >>>>>>>> Another approach is to use eBPF steering program. This approach =
has
> >>>>>>>> another downside: it cannot report the calculated hash due to the
> >>>>>>>> restrictive nature of eBPF.
> >>>>>>>>
> >>>>>>>> Introduce the code to compute hashes to the kernel in order to o=
vercome
> >>>>>>>> thse challenges.
> >>>>>>>>
> >>>>>>>> An alternative solution is to extend the eBPF steering program s=
o that it
> >>>>>>>> will be able to report to the userspace, but it is based on cont=
ext
> >>>>>>>> rewrites, which is in feature freeze. We can adopt kfuncs, but t=
hey will
> >>>>>>>> not be UAPIs. We opt to ioctl to align with other relevant UAPIs=
 (KVM
> >>>>>>>> and vhost_net).
> >>>>>>>>    =20
> >>>>>>>
> >>>>>>> I wonder if we could clone the skb and reuse some to store the ha=
sh,
> >>>>>>> then the steering eBPF program can access these fields without
> >>>>>>> introducing full RSS in the kernel? =20
> >>>>>>
> >>>>>> I don't get how cloning the skb can solve the issue.
> >>>>>>
> >>>>>> We can certainly implement Toeplitz function in the kernel or even=
 with
> >>>>>> tc-bpf to store a hash value that can be used for eBPF steering pr=
ogram
> >>>>>> and virtio hash reporting. However we don't have a means of storin=
g a
> >>>>>> hash type, which is specific to virtio hash reporting and lacks a
> >>>>>> corresponding skb field. =20
> >>>>>
> >>>>> I may miss something but looking at sk_filter_is_valid_access(). It
> >>>>> looks to me we can make use of skb->cb[0..4]? =20
> >>>>
> >>>> I didn't opt to using cb. Below is the rationale:
> >>>>
> >>>> cb is for tail call so it means we reuse the field for a different
> >>>> purpose. The context rewrite allows adding a field without increasing
> >>>> the size of the underlying storage (the real sk_buff) so we should a=
dd a
> >>>> new field instead of reusing an existing field to avoid confusion.
> >>>>
> >>>> We are however no longer allowed to add a new field. In my
> >>>> understanding, this is because it is an UAPI, and eBPF maintainers f=
ound
> >>>> it is difficult to maintain its stability.
> >>>>
> >>>> Reusing cb for hash reporting is a workaround to avoid having a new
> >>>> field, but it does not solve the underlying problem (i.e., keeping e=
BPF
> >>>> as stable as UAPI is unreasonably hard). In my opinion, adding an io=
ctl
> >>>> is a reasonable option to keep the API as stable as other virtualiza=
tion
> >>>> UAPIs while respecting the underlying intention of the context rewri=
te
> >>>> feature freeze. =20
> >>>
> >>> Fair enough.
> >>>
> >>> Btw, I remember DPDK implements tuntap RSS via eBPF as well (probably
> >>> via cls or other). It might worth to see if anything we miss here. =20
> >>
> >> Thanks for the information. I wonder why they used cls instead of
> >> steering program. Perhaps it may be due to compatibility with macvtap
> >> and ipvtap, which don't steering program.
> >>
> >> Their RSS implementation looks cleaner so I will improve my RSS
> >> implementation accordingly.
> >> =20
> >=20
> > DPDK needs to support flow rules. The specific case is where packets
> > are classified by a flow, then RSS is done across a subset of the queue=
s.
> > The support for flow in TUN driver is more academic than useful,
> > I fixed it for current BPF, but doubt anyone is using it really.
> >=20
> > A full steering program would be good, but would require much more
> > complexity to take a general set of flow rules then communicate that
> > to the steering program.
> >  =20
>=20
> It reminded me of RSS context and flow filter. Some physical NICs=20
> support to use a dedicated RSS context for packets matched with flow=20
> filter, and virtio is also gaining corresponding features.
>=20
> RSS context: https://github.com/oasis-tcs/virtio-spec/issues/178
> Flow filter: https://github.com/oasis-tcs/virtio-spec/issues/179
>=20
> I considered about the possibility of supporting these features with tc=20
> instead of adding ioctls to tuntap, but it seems not appropriate for=20
> virtualization use case.
>=20
> In a virtualization use case, tuntap is configured according to requests=
=20
> of guests, and the code processing these requests need to have minimal=20
> permissions for security. This goal is achieved by passing a file=20
> descriptor that represents a tuntap from a privileged process (e.g.,=20
> libvirt) to the process handling guest requests (e.g., QEMU).
>=20
> However, tc is configured with rtnetlink, which does not seem to have an=
=20
> interface to delegate a permission for one particular device to another=20
> process.
>=20
> For now I'll continue working on the current approach that is based on=20
> ioctl and lacks RSS context and flow filter features. Eventually they=20
> are also likely to require new ioctls if they are to be supported with=20
> vhost_net.

The DPDK flow handling (rte_flow) was started by Mellanox and many of
the features are to support what that NIC can do. Would be good to have
a tc way to configure that (or devlink).

