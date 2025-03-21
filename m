Return-Path: <linux-kselftest+bounces-29537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C79A6B28F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 02:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6413BC2C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 01:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8984B288CC;
	Fri, 21 Mar 2025 01:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXqRXhqQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257F35948
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 01:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742519630; cv=none; b=hYrTMsNI2ru7niiRIeWuvOhf/odH1LQW5IakcD5TJSQGpx9CbUHAQIs9TV7X/grN0BtPw0ZWtokzdYDBtROsQLgZOzUyJmhXvo6RZ1VVxt+dgapfvH2tIk/44EXcI0WdElkZHfDZ46gcZmSOUi2g6v11PeM3ifFwhOCnmSn3a6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742519630; c=relaxed/simple;
	bh=CNMgfMs7PIXrUlbeDXFIimGEacCQ1lexRprF+m6OoNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBKgbEpRMvkMwVd/LWF1XdyVxZPO+TJczvLcqJq9ggjKBm0NBRlOnZy2LWgpeDzfxciK8oygQsAMU1hS6ynlLxOHiLgNwH34Lw5ju/s/S/3b5wJX9p9o3hvR5qW/4DnTbNWTEL0umwmXc4KHxz5MfZA/e9CORBHaNFBlK1LHe2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXqRXhqQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742519625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mxUWxALaqNN5lUvJMKMNpR6Ea0WgZ73Ozs73qhw7brI=;
	b=AXqRXhqQXqfnnkNEqitv+/LnviqX5NCXZ3n4RHBw87yXEmwEEYoxNYqPBepu/gva4k2mSJ
	oCXQ+4lXHLqdRiELB89J7T3X3BJYs48KrQEnCy/0e+55yGcib1/zBFAlTwm2RCg805H2jR
	TAW6zxeUnPOE3N9xQS6Y3DuOtEVfXeM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-MMbBQTooM1-Ou66yvIyz8w-1; Thu, 20 Mar 2025 21:13:43 -0400
X-MC-Unique: MMbBQTooM1-Ou66yvIyz8w-1
X-Mimecast-MFC-AGG-ID: MMbBQTooM1-Ou66yvIyz8w_1742519623
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so2075453a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 18:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742519623; x=1743124423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxUWxALaqNN5lUvJMKMNpR6Ea0WgZ73Ozs73qhw7brI=;
        b=r/+Ke291X3goGA2wGivuGgM6iJRENZKms4fAuDsBDj8LLZwl+WybNvpdfwRhkQX3vj
         69HX39YSvvFSJpUvwZCt0PDa08dMLa9PLSD3vn8a68iChrfawxxx+ljmRFb2NqKVnw2c
         ZCsoUDUQaaEINRN1lTHUp9vo+OnzaM42QOklVcitYcwoQdc+pG2Bi/PtATeUCEDT5MUt
         MkK2+30HRIOfw/2K5LXwLW9COYiiJEYcPZoK+licZDM/8LH4/g8Jr+mN3KB/ifxqtY8X
         gaPcI12zeZ4mis/B/2FjoEgANx8b7ubI4GxVj4OQ5TAvAXpwlbCCs/SVUEi9szLoygHa
         BXRw==
X-Forwarded-Encrypted: i=1; AJvYcCVDpZY7m9iaXh2K2QkCkNbCHys11FMwVlVlW3oT56niRwopleIi4bwKlzZwGDIw6DHKIRw/xneG6nb/fjm0cdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeXcQ9gGnbR7zGMPowzBwJcXKeR4C92c7FMPqvwflCcRnDCpt5
	EmS7dTfByAuGbjmnUPt1VPn++uHBDMeAX04SxZduqSFsjtVL0RQcNtS0+tqfOWdffebRU8Ne6xr
	NwyO+qPbunoT+vxn4V31kTN2D2TZG0A0K7+Ke/IZ/QWGSUTPEDEhC3NG8etzWZ/6IqjDR26GPeQ
	Xn0fbiK7CR4vxNyTTup6d9bkBizhWDwGF2O5qgy38a
X-Gm-Gg: ASbGncvoZEgoTLebkzUMdxPyzX+1fAnS/5uNB4IuCAVysU8kw6UGT9xmBI9zwLBZif4
	+zzej9aGqmYxlH3zggZY0EHjYHBpvsR2zilwBb1i2o5QK4R362IMfSNftwWzjP3bndD1oMb3M
X-Received: by 2002:a17:90b:35c4:b0:2fe:80cb:ac05 with SMTP id 98e67ed59e1d1-3030fe7f0fcmr2069320a91.9.1742519621908;
        Thu, 20 Mar 2025 18:13:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA5tf5etNYP52/vQ8cvatd+U1Kwj4L1D/KoXOrE733z/Yf8RIuUNtXjQREbJS5bfH8sqQLG96KeJet04uwVQc=
X-Received: by 2002:a17:90b:35c4:b0:2fe:80cb:ac05 with SMTP id
 98e67ed59e1d1-3030fe7f0fcmr2069247a91.9.1742519621064; Thu, 20 Mar 2025
 18:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-3-df76624025eb@daynix.com>
 <CACGkMEsNHba=PY5UQoH1zdGQRiHC8FugMG1nkXqOj1TBdOQrww@mail.gmail.com>
 <7978dfd5-8499-44f3-9c30-e53a01449281@daynix.com> <CACGkMEsR4_RreDbYQSEk5Cr29_26WNUYheWCQBjyMNUn=1eS2Q@mail.gmail.com>
 <edf41317-2191-458f-a315-87d5af42a264@daynix.com> <CACGkMEta3k_JOhKv44XiBXZb=WuS=KbSeJNpYxCdeiAgRY2azg@mail.gmail.com>
 <ff7916cf-8a9c-4c27-baaf-ca408817c063@daynix.com> <CACGkMEsVgbJPhz2d2ATm5fr3M2uSEoSXWW7tXZ_FrkQtmmu1wA@mail.gmail.com>
 <73250942-9ab9-4ee4-9bbe-e0a155a61f51@daynix.com> <CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com>
 <1f06b4b6-267a-4091-a3ba-e7b9dafae918@daynix.com> <CACGkMEsACb5S4rv-bWeBadDmnCcwFfnNp4MN7_4RQGB0MUWrzQ@mail.gmail.com>
 <20c34c80-7549-43e1-8bec-f7210a90f94e@daynix.com> <CACGkMEs8DyrusOsLPXSwhBvr3mKerzfNBQD3mLNfzLXhbCpR5A@mail.gmail.com>
 <ed72ad97-4ca7-40ba-ac47-9e776a07df64@daynix.com>
In-Reply-To: <ed72ad97-4ca7-40ba-ac47-9e776a07df64@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Mar 2025 09:13:29 +0800
X-Gm-Features: AQ5f1Jqvx1I2DgNNU612vc_-XVgNtGwswYCVUZGrSHFRpm4Q6X8kZ1aphzxyXPc
Message-ID: <CACGkMEt-Y5E11qhE=vJP95fV+JAtLA+BW9P1jFUoocxysQ=W_g@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/6] tun: Introduce virtio-net hash feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 1:33=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/20 10:31, Jason Wang wrote:
> > On Wed, Mar 19, 2025 at 1:29=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2025/03/19 9:58, Jason Wang wrote:
> >>> On Tue, Mar 18, 2025 at 6:10=E2=80=AFPM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> >>>>
> >>>> On 2025/03/18 9:15, Jason Wang wrote:
> >>>>> On Mon, Mar 17, 2025 at 3:07=E2=80=AFPM Akihiko Odaki <akihiko.odak=
i@daynix.com> wrote:
> >>>>>>
> >>>>>> On 2025/03/17 10:12, Jason Wang wrote:
> >>>>>>> On Wed, Mar 12, 2025 at 1:03=E2=80=AFPM Akihiko Odaki <akihiko.od=
aki@daynix.com> wrote:
> >>>>>>>>
> >>>>>>>> On 2025/03/12 11:35, Jason Wang wrote:
> >>>>>>>>> On Tue, Mar 11, 2025 at 2:11=E2=80=AFPM Akihiko Odaki <akihiko.=
odaki@daynix.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 2025/03/11 9:38, Jason Wang wrote:
> >>>>>>>>>>> On Mon, Mar 10, 2025 at 3:45=E2=80=AFPM Akihiko Odaki <akihik=
o.odaki@daynix.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 2025/03/10 12:55, Jason Wang wrote:
> >>>>>>>>>>>>> On Fri, Mar 7, 2025 at 7:01=E2=80=AFPM Akihiko Odaki <akihi=
ko.odaki@daynix.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Hash reporting
> >>>>>>>>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Allow the guest to reuse the hash value to make receive st=
eering
> >>>>>>>>>>>>>> consistent between the host and guest, and to save hash co=
mputation.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> RSS
> >>>>>>>>>>>>>> =3D=3D=3D
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> RSS is a receive steering algorithm that can be negotiated=
 to use with
> >>>>>>>>>>>>>> virtio_net. Conventionally the hash calculation was done b=
y the VMM.
> >>>>>>>>>>>>>> However, computing the hash after the queue was chosen def=
eats the
> >>>>>>>>>>>>>> purpose of RSS.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Another approach is to use eBPF steering program. This app=
roach has
> >>>>>>>>>>>>>> another downside: it cannot report the calculated hash due=
 to the
> >>>>>>>>>>>>>> restrictive nature of eBPF steering program.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Introduce the code to perform RSS to the kernel in order t=
o overcome
> >>>>>>>>>>>>>> thse challenges. An alternative solution is to extend the =
eBPF steering
> >>>>>>>>>>>>>> program so that it will be able to report to the userspace=
, but I didn't
> >>>>>>>>>>>>>> opt for it because extending the current mechanism of eBPF=
 steering
> >>>>>>>>>>>>>> program as is because it relies on legacy context rewritin=
g, and
> >>>>>>>>>>>>>> introducing kfunc-based eBPF will result in non-UAPI depen=
dency while
> >>>>>>>>>>>>>> the other relevant virtualization APIs such as KVM and vho=
st_net are
> >>>>>>>>>>>>>> UAPIs.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>>>>>>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>>         Documentation/networking/tuntap.rst |   7 ++
> >>>>>>>>>>>>>>         drivers/net/Kconfig                 |   1 +
> >>>>>>>>>>>>>>         drivers/net/tap.c                   |  68 ++++++++=
++++++-
> >>>>>>>>>>>>>>         drivers/net/tun.c                   |  98 ++++++++=
+++++++++-----
> >>>>>>>>>>>>>>         drivers/net/tun_vnet.h              | 159 ++++++++=
++++++++++++++++++++++++++--
> >>>>>>>>>>>>>>         include/linux/if_tap.h              |   2 +
> >>>>>>>>>>>>>>         include/linux/skbuff.h              |   3 +
> >>>>>>>>>>>>>>         include/uapi/linux/if_tun.h         |  75 ++++++++=
+++++++++
> >>>>>>>>>>>>>>         net/core/skbuff.c                   |   4 +
> >>>>>>>>>>>>>>         9 files changed, 386 insertions(+), 31 deletions(-=
)
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> diff --git a/Documentation/networking/tuntap.rst b/Documen=
tation/networking/tuntap.rst
> >>>>>>>>>>>>>> index 4d7087f727be5e37dfbf5066a9e9c872cc98898d..86b4ae8caa=
8ad062c1e558920be42ce0d4217465 100644
> >>>>>>>>>>>>>> --- a/Documentation/networking/tuntap.rst
> >>>>>>>>>>>>>> +++ b/Documentation/networking/tuntap.rst
> >>>>>>>>>>>>>> @@ -206,6 +206,13 @@ enable is true we enable it, otherwis=
e we disable it::
> >>>>>>>>>>>>>>               return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
> >>>>>>>>>>>>>>           }
> >>>>>>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> [...]
> >>>>>>>>>
> >>>>>>>>>>>>>> +static inline long tun_vnet_ioctl_sethash(struct tun_vnet=
_hash_container __rcu **hashp,
> >>>>>>>>>>>>>> +                                         bool can_rss, vo=
id __user *argp)
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> So again, can_rss seems to be tricky. Looking at its caller=
, it tires
> >>>>>>>>>>>>> to make eBPF and RSS mutually exclusive. I still don't unde=
rstand why
> >>>>>>>>>>>>> we need this. Allow eBPF program to override some of the pa=
th seems to
> >>>>>>>>>>>>> be common practice.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> What's more, we didn't try (or even can't) to make automq a=
nd eBPF to
> >>>>>>>>>>>>> be mutually exclusive. So I still didn't see what we gain f=
rom this
> >>>>>>>>>>>>> and it complicates the codes and may lead to ambiguous uAPI=
/behaviour.
> >>>>>>>>>>>>
> >>>>>>>>>>>> automq and eBPF are mutually exclusive; automq is disabled w=
hen an eBPF
> >>>>>>>>>>>> steering program is set so I followed the example here.
> >>>>>>>>>>>
> >>>>>>>>>>> I meant from the view of uAPI, the kernel doesn't or can't re=
ject eBPF
> >>>>>>>>>>> while using automq.
> >>>>>>>>>>       > >>
> >>>>>>>>>>>> We don't even have an interface for eBPF to let it fall back=
 to another
> >>>>>>>>>>>> alogirhtm.
> >>>>>>>>>>>
> >>>>>>>>>>> It doesn't even need this, e.g XDP overrides the default rece=
iving path.
> >>>>>>>>>>>
> >>>>>>>>>>>> I could make it fall back to RSS if the eBPF steeering
> >>>>>>>>>>>> program is designed to fall back to automq when it returns e=
.g., -1. But
> >>>>>>>>>>>> such an interface is currently not defined and defining one =
is out of
> >>>>>>>>>>>> scope of this patch series.
> >>>>>>>>>>>
> >>>>>>>>>>> Just to make sure we are on the same page, I meant we just ne=
ed to
> >>>>>>>>>>> make the behaviour consistent: allow eBPF to override the beh=
aviour of
> >>>>>>>>>>> both automq and rss.
> >>>>>>>>>>
> >>>>>>>>>> That assumes eBPF takes precedence over RSS, which is not obvi=
ous to me.
> >>>>>>>>>
> >>>>>>>>> Well, it's kind of obvious. Not speaking the eBPF selector, we =
have
> >>>>>>>>> other eBPF stuffs like skbedit etc.
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Let's add an interface for the eBPF steering program to fall b=
ack to
> >>>>>>>>>> another steering algorithm. I said it is out of scope before, =
but it
> >>>>>>>>>> makes clear that the eBPF steering program takes precedence ov=
er other
> >>>>>>>>>> algorithms and allows us to delete the code for the configurat=
ion
> >>>>>>>>>> validation in this patch.
> >>>>>>>>>
> >>>>>>>>> Fallback is out of scope but it's not what I meant.
> >>>>>>>>>
> >>>>>>>>> I meant in the current uAPI take eBPF precedence over automq. I=
t's
> >>>>>>>>> much more simpler to stick this precedence unless we see obviou=
s
> >>>>>>>>> advanatge.
> >>>>>>>>
> >>>>>>>> We still have three different design options that preserve the c=
urrent
> >>>>>>>> precedence:
> >>>>>>>>
> >>>>>>>> 1) Precedence order: eBPF -> RSS -> automq
> >>>>>>>> 2) Precedence order: RSS -> eBPF -> automq
> >>>>>>>> 3) Precedence order: eBPF OR RSS -> automq where eBPF and RSS ar=
e
> >>>>>>>> mutually exclusive
> >>>>>>>>
> >>>>>>>> I think this is a unique situation for this steering program and=
 I could
> >>>>>>>> not find another example in other eBPF stuffs.
> >>>>>>>
> >>>>>>> As described above, queue mapping could be overridden by tc-ebpf.=
 So
> >>>>>>> there's no way to guarantee the RSS will work:
> >>>>>>>
> >>>>>>> https://github.com/DPDK/dpdk/blob/main/drivers/net/tap/bpf/tap_rs=
s.c#L262
> >>>>>>>
> >>>>>>> Making eBPF first leaves a chance for the management layer to ove=
rride
> >>>>>>> the choice of Qemu.
> >>>>>>
> >>>>>> I referred to the eBPF steering program instead of tc-ebpf. tc-ebp=
f is
> >>>>>> nothing to do with the TUNSETSTEERINGEBPF ioctl, which this patch =
changes.
> >>>>>
> >>>>> I meant you can't do "full control" in any case, the point below
> >>>>> doesn't stand. Queue mapping could be restored even if RSS is set.
> >>>>
> >>>> What matters here is how we handle the control when tc didn't take i=
t.
> >>>> eBPF, RSS, or automq make take all of it; I referred that as "full c=
ontrol".
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>> The current version implements 3) because it is not obvious whet=
her we
> >>>>>>>> should choose either 1) or 2).
> >>>>>>>
> >>>>>>> But you didn't explain why you choose 3), and it leads to tricky =
code
> >>>>>>> (e.g the can_rss stuff etc).
> >>>>>>
> >>>>>> I wrote: "because it is not obvious whether we should choose eithe=
r 1)
> >>>>>> or 2)", but I think I can explain it better:
> >>>>>>
> >>>>>> When an eBPF steering program cannot implement a fallback, it mean=
s the
> >>>>>> eBPF steering program requests the full control over the steering.=
 On
> >>>>>> the other hand, RSS also requests the same control. So these two w=
ill
> >>>>>> conflict and the entity controlling the steering will be undefined=
 when
> >>>>>> both are enabled.
> >>>>>
> >>>>> Well, the fallback is orthogonal to the proposal here. We haven't h=
ad
> >>>>> that since the introduction of the eBPF steering program. This mean=
s
> >>>>> automq has been in "conflict" with eBPF for years. Again, another
> >>>>> advantage, allowing the eBPF program to be the first to allow the
> >>>>> management layer to override Qemu's steering.
> >>>>
> >>>> What if a VMM uses eBPF steering program and the management layer
> >>>> decides to override it with RSS?
> >>>
> >>> That's possible but I think we're seeking which approach is better. I=
n
> >>> this case, RSS could be implemented in eBPF but not the reverse.
> >>>
> >>> So my point is to start from something that is simpler. Simply allow
> >>> eBPF on top of RSS as automq. And optimize on top.
> >>
> >>
> >> The in-kernel RSS implementation is more optimized and capable of hash
> >> reporting. I don't think either eBPF steering program or in-kernel RSS
> >> is more capable than the other and there is a reason to place eBPF on
> >> top of RSS.
> >>
> >>>
> >>>>
> >>>> eBPF is obviously predecedent to automq as eBPF is an opt-in feature=
 and
> >>>> automq is the implicit default. But this logic cannot be applied to
> >>>> decide the order of eBPF and RSS because they are both opt-in featur=
es.
> >>>
> >>> This is from the perspective of kernel development. But let's try to
> >>> think from the userspace: A well written user space knows what it
> >>> does, rejecting eBPF while RSS is set doesn't help. But anyhow if you
> >>> stick, it doesn't harm.
> >>
> >> Yes, it not for the current userspace but for the future kernel
> >> development; the kernel can reserve the freedom to decide the priority
> >> of eBPF and RSS by rejecting eBPF while RSS.
> >>
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>> 3) eliminates the undefined semantics by rejecting to enable both.
> >>>>>
> >>>>> This would lead a usersapce noticeable change of the behaviour? And
> >>>>> what do you mean by "rejecting to enable both"?
> >>>>
> >>>> Existing userspace code should see no change as it only cares the ca=
se
> >>>> where RSS is enabled.
> >>>>
> >>>> Here, rejecting to enable both means to deny setting an eBPF steerin=
g
> >>>> program when RSS is enabled, and visa-versa.
> >>>>
> >>>>>
> >>>>>> An
> >>>>>> alternative approach is to allow eBPF steering programs to fall ba=
ck.
> >>>>>> When both the eBPF program and RSS are enabled, RSS will gain the
> >>>>>> control of steering under the well-defined situation where the eBP=
F
> >>>>>> steering program decides to fall back.
> >>>>>
> >>>>> How about just stick the eBPF precedence in this proposal and
> >>>>> introduce the fallback on top? This helps to speed up the iteration
> >>>>> (as the version has been iterated to 11).
> >>>>
> >>>> I don't think that helps much since we have another ongoing discussi=
on
> >>>> below and it is not the sole roadblock.
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>> But 1) will be the most capable option if
> >>>>>>>> eBPF has a fall-back feature.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> [...]
> >>>>>>>>>
> >>>>>>>>>>>>> Is there a chance that we can reach here without TUN_VNET_H=
ASH_REPORT?
> >>>>>>>>>>>>> If yes, it should be a bug.
> >>>>>>>>>>>>
> >>>>>>>>>>>> It is possible to use RSS without TUN_VNET_HASH_REPORT.
> >>>>>>>>>>>
> >>>>>>>>>>> Another call to separate the ioctls then.
> >>>>>>>>>>
> >>>>>>>>>> RSS and hash reporting are not completely independent though.
> >>>>>>>>>
> >>>>>>>>> Spec said:
> >>>>>>>>>
> >>>>>>>>> """
> >>>>>>>>> VIRTIO_NET_F_RSSRequires VIRTIO_NET_F_CTRL_VQ.
> >>>>>>>>> """
> >>>>>>>>
> >>>>>>>> I meant the features can be enabled independently, but they will=
 share
> >>>>>>>> the hash type set when they are enabled at the same time.
> >>>>>>>
> >>>>>>> Looking at the spec:
> >>>>>>>
> >>>>>>> Hash repot uses:
> >>>>>>>
> >>>>>>> """
> >>>>>>> struct virtio_net_hash_config {
> >>>>>>>         le32 hash_types;
> >>>>>>>         le16 reserved[4];
> >>>>>>>         u8 hash_key_length;
> >>>>>>>         u8 hash_key_data[hash_key_length];
> >>>>>>> };
> >>>>>>> """
> >>>>>>>
> >>>>>>> RSS uses
> >>>>>>>
> >>>>>>> """
> >>>>>>> struct rss_rq_id {
> >>>>>>>        le16 vq_index_1_16: 15; /* Bits 1 to 16 of the virtqueue i=
ndex */
> >>>>>>>        le16 reserved: 1; /* Set to zero */
> >>>>>>> };
> >>>>>>>
> >>>>>>> struct virtio_net_rss_config {
> >>>>>>>         le32 hash_types;
> >>>>>>>         le16 indirection_table_mask;
> >>>>>>>         struct rss_rq_id unclassified_queue;
> >>>>>>>         struct rss_rq_id indirection_table[indirection_table_leng=
th];
> >>>>>>>         le16 max_tx_vq;
> >>>>>>>         u8 hash_key_length;
> >>>>>>>         u8 hash_key_data[hash_key_length];
> >>>>>>> };
> >>>>>>> """
> >>>>>>>
> >>>>>>> Instead of trying to figure out whether we can share some data
> >>>>>>> structures, why not simply start from what has been done in the s=
pec?
> >>>>>>> This would ease the usersapce as well where it can simply do 1:1
> >>>>>>> mapping between ctrl vq command and tun uAPI.
> >>>>>>
> >>>>>> The spec also defines struct virtio_net_hash_config (which will be=
 used
> >>>>>> when RSS is disabled) and struct virtio_net_rss_config to match th=
e
> >>>>>> layout to share some fields. However, the UAPI does not follow the
> >>>>>> interface design of virtio due to some problems with these structu=
res.
> >>>>>
> >>>>> Copy-paste error. The above is copied from the virtio spec, but I
> >>>>> meant the existing uAPI in virtio_net.h:
> >>>>>
> >>>>> /*
> >>>>>     * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect=
 as
> >>>>>     * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configu=
res
> >>>>>     * the receive steering to use a hash calculated for incoming pa=
cket
> >>>>>     * to decide on receive virtqueue to place the packet. The comma=
nd
> >>>>>     * also provides parameters to calculate a hash and receive virt=
queue.
> >>>>>     */
> >>>>> struct virtio_net_rss_config {
> >>>>>            __le32 hash_types;
> >>>>>            __le16 indirection_table_mask;
> >>>>>            __le16 unclassified_queue;
> >>>>>            __le16 indirection_table[1/* + indirection_table_mask */=
];
> >>>>>            __le16 max_tx_vq;
> >>>>>            __u8 hash_key_length;
> >>>>>            __u8 hash_key_data[/* hash_key_length */];
> >>>>> };
> >>>>>>     #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
> >>>>>
> >>>>> /*
> >>>>>     * The command VIRTIO_NET_CTRL_MQ_HASH_CONFIG requests the devic=
e
> >>>>>     * to include in the virtio header of the packet the value of th=
e
> >>>>>     * calculated hash and the report type of hash. It also provides
> >>>>>     * parameters for hash calculation. The command requires feature
> >>>>>     * VIRTIO_NET_F_HASH_REPORT to be negotiated to extend the
> >>>>>     * layout of virtio header as defined in virtio_net_hdr_v1_hash.
> >>>>>     */
> >>>>> struct virtio_net_hash_config {
> >>>>>            __le32 hash_types;
> >>>>>            /* for compatibility with virtio_net_rss_config */
> >>>>>            __le16 reserved[4];
> >>>>>            __u8 hash_key_length;
> >>>>>            __u8 hash_key_data[/* hash_key_length */];
> >>>>> };
> >>>>>
> >>>>> This has been used by Qemu but I see a virtio-net version of:
> >>>>>
> >>>>> struct virtio_net_ctrl_rss {
> >>>>>            u32 hash_types;
> >>>>>            u16 indirection_table_mask;
> >>>>>            u16 unclassified_queue;
> >>>>>            u16 hash_cfg_reserved; /* for HASH_CONFIG (see
> >>>>> virtio_net_hash_config for details) */
> >>>>>            u16 max_tx_vq;
> >>>>>            u8 hash_key_length;
> >>>>>            u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >>>>>
> >>>>>            u16 *indirection_table;
> >>>>> };
> >>>>>
> >>>>> This is ugly and results in a tricky code when trying to submit
> >>>>> RSS/HASH commands to the device:
> >>>>>
> >>>>>            if (vi->has_rss) {
> >>>>>                    sg_buf_size =3D sizeof(uint16_t) * vi->rss_indir=
_table_size;
> >>>>>                    sg_set_buf(&sgs[1], vi->rss.indirection_table, s=
g_buf_size);
> >>>>>            } else {
> >>>>>                    sg_set_buf(&sgs[1], &vi->rss.hash_cfg_reserved,
> >>>>> sizeof(uint16_t));
> >>>>>            }
> >>>>
> >>>> The only reference to struct virtio_net_rss_config in QEMU is to der=
ive
> >>>> the offset of indirection_table. This is because the definition in
> >>>> virtio_net.h also includes indirection_table in the middle and the
> >>>> offsets of later part are unusable.
> >>>
> >>> Yes.
> >>>
> >>>>
> >>>> QEMU internally has a structure named VirtioNetRssData which just lo=
oks
> >>>> like struct virtio_net_ctrl_rss.
> >>>
> >>> It's a pity that it doesn't use uAPI. We might need to fix them.
> >>
> >> It doesn't want to use the UAPI structures for the internal storage
> >> because it wants to store them in native endians and QEMU is not
> >> interested in some fields in the UAPI structures. struct tun_vnet_hash
> >> and struct tun_vnet_hash_rss are easy to fill using VirtioNetRssData.
> >>
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Below is the definition of struct virtio_net_hash_config:
> >>>>>>
> >>>>>> struct virtio_net_hash_config {
> >>>>>>         le32 hash_types;
> >>>>>>         le16 reserved[4];
> >>>>>>         u8 hash_key_length;
> >>>>>>         u8 hash_key_data[hash_key_length];
> >>>>>> };
> >>>>>>
> >>>>>> Here, hash_types, hash_key_length, and hash_key_data are shared wi=
th
> >>>>>> struct virtio_net_rss_config.
> >>>>>>
> >>>>>> One problem is that struct virtio_net_rss_config has a flexible ar=
ray
> >>>>>> (indirection_table) between hash_types and hash_key_length. This i=
s
> >>>>>> something we cannot express with C.
> >>>>>
> >>>>> We can split the virtio_net_rss_config to ease the dealing with
> >>>>> arrays, more below.
> >>>>>
> >>>>>>
> >>>>>> Another problem is that the semantics of the key in struct
> >>>>>> virtio_net_hash_config is not defined in the spec.
> >>>>>
> >>>>> If this is the case. Let's fix that in the spec first to make sure =
our
> >>>>> uAPI aligns with spec without ambiguity. It would be a nightmare to
> >>>>> deal with the in-consistency between virtio spec and Linux uAPIs.
> >>>>
> >>>> The userspace doesn't need to do anything to deal with inconsistency
> >>>> since these fields are unused.
> >>>>
> >>>>>
> >>>>>>
> >>>>>> To solve these problems, I defined the UAPI structures that do not
> >>>>>> include indiretion_table.
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> A plot twist is the "types" parameter; it is a parameter that =
is
> >>>>>>>>>> "common" for RSS and hash reporting.
> >>>>>>>>>
> >>>>>>>>> So we can share part of the structure through the uAPI.
> >>>>>>>>
> >>>>>>>> Isn't that what this patch does?
> >>>>>>>
> >>>>>>> I didn't see, basically I see only one TUNSETVNETHASH that is use=
d to
> >>>>>>> set both hash report and rss:
> >>>>>>
> >>>>>> The UAPI shares struct tun_vnet_hash for both hash report and rss.
> >>>>>
> >>>>> I meant sharing structure in two ioctls instead of reusing a specif=
ic
> >>>>> structure for two semantics in one ioctl if possible. Though I don'=
t
> >>>>> think we need any sharing.
> >>>>
> >>>> The UAPI implemented in this patch already shares struct tun_vnet_ha=
sh
> >>>> and having two ioctls doesn't change that.
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> """
> >>>>>>> +/**
> >>>>>>> + * define TUNSETVNETHASH - ioctl to configure virtio_net hashing
> >>>>>>> + *
> >>>>>>> + * The argument is a pointer to &struct tun_vnet_hash.
> >>>>>>> + *
> >>>>>>> + * The argument is a pointer to the compound of the following in=
 order if
> >>>>>>> + * %TUN_VNET_HASH_RSS is set:
> >>>>>>> + *
> >>>>>>> + * 1. &struct tun_vnet_hash
> >>>>>>> + * 2. &struct tun_vnet_hash_rss
> >>>>>>> + * 3. Indirection table
> >>>>>>> + * 4. Key
> >>>>>>> + *
> >>>>>>> """
> >>>>>>>
> >>>>>>> And it seems to lack parameters like max_tx_vq.
> >>>>>>
> >>>>>> max_tx_vq is not relevant with hashing.
> >>>>>
> >>>>> It is needed for RSS and we don't have that, no?
> >>>>
> >>>> No. RSS is Receive Side Scaling but it's not about receiving.
> >>>
> >>> Just to make sure I understand this, max_tx_vq is part of the
> >>> virtio_net_rss_config, how would Qemu behave when it receives this
> >>> from guest?
> >>>
> >>> """
> >>> A driver sets max_tx_vq to inform a device how many transmit
> >>> virtqueues it may use (transmitq1=E2=80=A6transmitq max_tx_vq).
> >>> """
> >>
> >> It does nothing.
> >
> > Nope, see:
> >
> > commit 50bfcaedd78e53135ec0504302269b3b65bf1eff
> > Author: Philo Lu <lulie@linux.alibaba.com>
> > Date:   Mon Nov 4 16:57:06 2024 +0800
> >
> >      virtio_net: Update rss when set queue
> >
> >      RSS configuration should be updated with queue number. In particul=
ar, it
> >      should be updated when (1) rss enabled and (2) default rss configu=
ration
> >      is used without user modification.
> >
> >      During rss command processing, device updates queue_pairs using
> >      rss.max_tx_vq. That is, the device updates queue_pairs together wi=
th
> >      rss, so we can skip the sperate queue_pairs update
> >      (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
> >
> >      Also remove the `vi->has_rss ?` check when setting vi->rss.max_tx_=
vq,
> >      because this is not used in the other hash_report case.
> >
> >      Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS supp=
ort.")
> >      Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> >      Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >      Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >      Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >
> > RSS doesn't depend on MQ.
> >
> > If it is not handled by Qemu, it should be a bug?
>
> I was wrong; QEMU does handle this field, but it doesn't use the
> definition of struct virtio_net_rss_config and name it queue_pairs
> instead of max_tx_vq so I could not find it by grep.

Yes, another side effect is that uAPI is not even used there...

>
> For tap, max_tx_vq is handled by changing the number of open file
> descriptors so passing it via an ioctl is redundant.

See my reply below.

>
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> What's more, we've already had virito-net uAPI. Why not simply re=
using them?
> >>>>>>
> >>>>>> See the above.
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> RSS and hash reporting must share
> >>>>>>>>>> this parameter when both are enabled at the same time; otherwi=
se RSS may
> >>>>>>>>>> compute hash values that are not suited for hash reporting.
> >>>>>>>>>
> >>>>>>>>> Is this mandated by the spec? If yes, we can add a check. If no=
t,
> >>>>>>>>> userspace risk themselves as a mis-configuration which we don't=
 need
> >>>>>>>>> to bother.
> >>>>>>>>
> >>>>>>>> Yes, it is mandated. 5.1.6.4.3 Hash calculation for incoming pac=
kets says:
> >>>>>>>>      > A device attempts to calculate a per-packet hash in the f=
ollowing
> >>>>>>>>      > cases:
> >>>>>>>>      >
> >>>>>>>>      >   - The feature VIRTIO_NET_F_RSS was negotiated. The devi=
ce uses the
> >>>>>>>>      >     hash to determine the receive virtqueue to place inco=
ming packets.
> >>>>>>>>      >   - The feature VIRTIO_NET_F_HASH_REPORT was negotiated. =
The device
> >>>>>>>>      >     reports the hash value and the hash type with the pac=
ket.
> >>>>>>>>      >
> >>>>>>>>      > If the feature VIRTIO_NET_F_RSS was negotiated:
> >>>>>>>>      >
> >>>>>>>>      >   - The device uses hash_types of the virtio_net_rss_conf=
ig structure
> >>>>>>>>      >     as =E2=80=99Enabled hash types=E2=80=99 bitmask.
> >>>>>>>>      >   - The device uses a key as defined in hash_key_data and
> >>>>>>>>            hash_key_length of the virtio_net_rss_config structur=
e (see
> >>>>>>>>      >      5.1.6.5.7.1).
> >>>>>>>>      >
> >>>>>>>>      > If the feature VIRTIO_NET_F_RSS was not negotiated:
> >>>>>>>>      >
> >>>>>>>>      >   - The device uses hash_types of the virtio_net_hash_con=
fig structure
> >>>>>>>>      >     as =E2=80=99Enabled hash types=E2=80=99 bitmask.
> >>>>>>>>      >   - The device uses a key as defined in hash_key_data and
> >>>>>>>>      >     hash_key_length of the virtio_net_hash_config structu=
re (see
> >>>>>>>>      >      .1.6.5.6.4).
> >>>>>>>>
> >>>>>>>> So when both VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT are
> >>>>>>>> negotiated, virtio_net_rss_config not only controls RSS but also=
 the
> >>>>>>>> reported hash values and types. They cannot be divergent.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Note that spec use different commands for hash_report and rss.
> >>>>>>>>
> >>>>>>>> TUNSETVNETHASH is different from these commands in terms that it=
 also
> >>>>>>>> negotiates VIRTIO_NET_F_HASH_REPORT and VIRTIO_NET_F_RSS.
> >>>>>>>>
> >>>>>>>
> >>>>>>> There Are different "issues" here:
> >>>>>>>
> >>>>>>> 1) Whether or not we need to use a unified API for negotiating RS=
S and
> >>>>>>> HASH_REPORT features
> >>>>>>> 2) Whether or not we need to sue a unified API for setting RSS an=
d
> >>>>>>> HASH_REPORT configuration
> >>>>>>>
> >>>>>>> What I want to say is point 2. But what you raise is point 1.
> >>>>>>>
> >>>>>>> For simplicity, it looks to me like it's a call for having separa=
ted
> >>>>>>> ioctls for feature negotiation (for example via TUNSETIFF). You m=
ay
> >>>>>>> argue that either RSS or HASH_REPORT requires configurations, we =
can
> >>>>>>> just follow what spec defines or not (e.g what happens if
> >>>>>>> RSS/HASH_REPORT were negotiated but no configurations were set).
> >>>>>>
> >>>>>> Unfortunately TUNSETIFF does not fit in this use case. The flags s=
et
> >>>>>> with TUNSETIFF are fixed, but the guest can request a different fe=
ature
> >>>>>> set anytime by resetting the device.
> >>>>>
> >>>>> TUNSETIFF, enables the device to be able to handle RSS/HASREPORT.
> >>>>> TUNSETHASH/RSS. dealing with RSS/HASH command from userspace.
> >>>>
> >>>> We also needs to be able to disable them at runtime so that we can
> >>>> handle resets.
> >>>
> >>> Via TUNSETHASH/RSS? I think it should have a way to accept parameters
> >>> that disable RSS or hash report.
> >>
> >> That's what this patch implements. TUNSETVNETHASH accepts parameters t=
o
> >> choose what features to be enabled.
> >>
> >>>
> >>>>
> >>>>>
> >>>>> This is the way we used to do for multi queue and vnet header.
> >>>>> TUNSETIFF requires CAP_NET_ADMIN, this could be an extra safe guard
> >>>>> for unprivileged userspace.
> >>>>
> >>>> I intend to allow using this feature without privilege. A VMM is usu=
ally
> >>>> unprivileged and requiring a privilege to configure tuntap is too
> >>>> prohibitive.
> >>>
> >>> For safety, tun is not allowed to be created by unprivileged users.
> >>> And it's not to configure the tuntap dynamically, it's about telling
> >>> the function that tuntap can have (not necessarily enabled though) .
> >>
> >> I don't think we need another barrier for the new functions. Once an
> >> unprivileged user get a file descriptor of tuntap from a privileged
> >> user, they are free to enable RSS and/or hash reporting.
> >
> > Only if such a feature is allowed by the privileged user.
>
> I don't see a reason not to allow the feature to unprivileged users. It
> only complicates the setup.

For safety, e.g reduce the chance for unprivileged user to explore
part of the kernel codes.

>
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>>     > >> In the virtio-net specification, it is not defined what w=
ould
> >>>>>> happen if
> >>>>>>>> these features are negotiated but the VIRTIO_NET_CTRL_MQ_RSS_CON=
FIG or
> >>>>>>>> VIRTIO_NET_CTRL_MQ_HASH_CONFIG commands are not sent. There is n=
o such
> >>>>>>>> ambiguity with TUNSETVNETHASH.
> >>>>>>>
> >>>>>>> So I don't see advantages of unifying hash reports and rss into a
> >>>>>>> single ioctl. Let's just follow what has been done in the spec th=
at
> >>>>>>> uses separated commands. Tuntap is not a good place to debate whe=
ther
> >>>>>>> those commands could be unified or not. We need to move it to the=
 spec
> >>>>>>> but assuming spec has been done, it might be too late or too few
> >>>>>>> advantages for having another design.
> >>>>>>
> >>>>>> It makes sense for the spec to reuse the generic feature negotiati=
on
> >>>>>> mechanism, but the situation is different for tuntap; we cannot us=
e
> >>>>>> TUNSETIFF and need to define another. Then why don't we exploit th=
is
> >>>>>> opportunity to have an interface with well-defined semantics?
> >>>>>
> >>>>> That's perfectly fine, but it needs to be done in virtio-net's uAPI
> >>>>> not tun's. What's more, if you think two commands are not
> >>>>> well-defined, let's fix that in the virtio spec first.
> >>>>>
> >>>>>> The virtio
> >>>>>> spec does its best as an interface between the host and guest and =
tuntap
> >>>>>> does its best as an UAPI.
> >>>>>
> >>>>> See above, let's fix the uAPI first. We don't want DPDK to use tun'=
s
> >>>>> uAPI for RSS
> >>>>
> >>>> virtio-net's UAPI is for the virtio spec which has a capable generic
> >>>> feature negotiation mechanism. tuntap needs its own feature negotiat=
ion
> >>>> and it's nothing to do with virtio-net's UAPI.
> >>>
> >>> Well, I don't mean the part of the feature negotiation. I mean the
> >>> part for rss and hash report configuration.
> >>
> >> The feature negotiation still matters when deciding the granularity of
> >> ioctls. We need one ioctl for a feature negotiation, and to avoid havi=
ng
> >> an intermediate state,
> >
> > I don't understand this. For example, driver can choose to
> >
> > 1) negotiate RSS
> > 2) do something else.
> > 3) configure RSS
> >
> > Spec doesn't require those two to be configured at the same time, so
> > "intermediate state" is allowed.
>
> The spec doesn't define what should happen in the intermediate state eith=
er.

Yes but my point is that in the uAPI layer we don't need to care about
the intermediate state. It can just work as other features, e.g having
a default state after feature negotiation is more than enough. This is
the way we deal with other features like vnet header etc.

>
> For a hardware implementation I think it's fine whatever the
> implementation defines as the intermediate state. But for the UAPI, it's
> better avoiding having such a definition to keep the interface minimal
> and maximize the UAPI stability.

Well, even if you think there's an issue:

1) I don't see how we can avoid the intermediate state consider guest
have such state
2) We need to "fix" virtio spec and virito-net first, tuntap is not
the right place to workaround virtio specific issues

>
> >
> >> the ioctl should also do the configuration. Hence
> >> that one ioctl should do all of the feature negotiation and configurat=
ion.
> >>
> >>>
> >>>>
> >>>> The structures for two commands have unused or redundant fields and =
a
> >>>> flexible array in the middle of the structure, but they are ABIs so =
we
> >>>> can't change it.
> >>>>
> >>>> DPDK is another reason to define tuntap's own UAPIs. They don't care
> >>>> unused or redundant fields and a flexible array in middle that are
> >>>> present in the virtio spec. It will also not want to deal with the
> >>>> requirement of little endian. Constructing struct virtio_net_rss_con=
fig
> >>>> is an extra burden for DPDK.
> >>>
> >>> I meant for vhost-user implementation in DPDK, it needs to use
> >>> virtio-net uAPI not tuntap's for example.
> >>
> >> The vhost-user implementation will use tuntap's UAPIs for its ethernet
> >> device backend.
> >
> > That sounds pretty weird, vhost-user has nothing related to tuntap.
>
> My expression in the last email was weird. More precisely, the ethernet
> backend of tuntap will use the UAPIs, and the vhost-user will use the
> ethernet backend in turn.

I don't understand what "ethernet backend" means here.

>
> >
> >> It uses the generic interface of ethernet device so for
> >> RSS it will use functions like rte_eth_dev_rss_hash_update() for
> >> example. tuntap's UAPIs are more suited to implement these interfaces =
as
> >> they operate in native endian and don't have extra fields.
> >
> > Nope, for example it needs to use le for virtio_net_hdr if a modern
> > device is used. But it needs a "native" endian according to the guest
> > endian via TUNSETVNETLE/BE. We don't have a choice as virtio-net hdr
> > support in tuntap is much earlier than modern devices.
> >
> > Let's don't do the same thing (native endian) for tuntap as RSS
> > depends on modern, so we know it must be le.
>
> virtio_net_hdr is the data path while the current discussion is about
> the control path. All configuration knobs of tuntap operates in the
> native endian.

Because they are not directly related to virtio specification.  We
don't want to duplicate virtio-net with our own version every time E.g
once RSSv2 or aRFS were implemented. Or I would even introduce a
single uAPI to transport possible cvq commands then we can avoid
inventing new ioctls that just transport cvq commands.

>
> So I think we should stick to the little endian for the data path while
> we should stick to the native endian for the control path to maximize
> the consistency.

I don't see a reason to differ datapath from control path. Virtio-net
uAPI has been reused by tuntap for more than a decade.

>
> >
> >
> >>
> >> DPDk applications other than vhost-user also matter; they do not care
> >> what virtio does at all.
> >>
> >>   > >>
> >>>> On the other hand, Constructing tuntap-specific structures is not th=
at
> >>>> complicated for VMMs.
> >>>
> >>> Not complicated but redundant.
> >>>
> >>>> A VMM will need to inspect struct
> >>>> virtio_net_rss_config anyway to handle migration and check its size =
so
> >>>> it can store the values it inspected to struct tun_vnet_hash and str=
uct
> >>>> tun_vnet_hash_rss and pass them to the kernel.
> >>>
> >>> I don't see how rss and hash reports differ from what we have now.
> >>> Those inspections must be done anyhow for compatibility for example
> >>> the check of offloading features. Such steps could not be eliminated
> >>> no matter how we design the uAPI.
> >>
> >> I explained the difference between the virtio and tuntap UAPIs, not
> >> between RSS and hash reporting.
> >
> > See above.
> >
> >>
> >>>
> >>>>
> >>>> The overall userspace implementation will be simpler by having
> >>>> structures specifically tailored for the communication between the
> >>>> userspace and kernel.
> >>>
> >>> This is exactly how a good uAPI should behave. If uAPI in virtio-net
> >>> can't do this, I don't understand why uAPI in tuntap can solve it.
> >>
> >> The UAPI in virtio-net cannot do it because it's already fixed and it
> >> also needs to perform endian conversion for the VM use case. tuntap
> >> doesn't have these restrictions.
> >
> > Same here.
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>> I don't think there is an advantage to split ioctls to follow the =
spec
> >>>>>> after all. It makes sense if we can pass-through virtio commands t=
o
> >>>>>> tuntap, but it is not possible as ioctl operation codes are differ=
ent
> >>>>>> from virtio commands.
> >>>>>
> >>>>> I don't see a connection with the operation code. For example, we c=
an
> >>>>> add new uAPIs in virtio-net which could be something like:
> >>>>>
> >>>>>     struct virtio_net_rss_config_header {
> >>>>>          __le32 hash_types;
> >>>>>          __le16 indirection_table_mask;
> >>>>>          __le16 unclassified_queue;
> >>>>>          __le16 indirection_table[];
> >>>>> }
> >>>>>
> >>>>> struct virtio_net_rss_config_tailer {
> >>>>>          __le16 max_tx_vq;
> >>>>>          u8 hash_key_length;
> >>>>>          u8 hash_key_data[];
> >>>>> }
> >>>>>
> >>>>> These two are used by TUNSETVNETRSS. And simply reuse the
> >>>>> virtio_net_hash_config for TUNSETVETHASH.
> >>>>    > > With this, we can tweak the virtio-net driver with this new u=
API. Then
> >>>>> tap* can reuse this.
> >>>>
> >>>> I implemented a UAPI and driver change accordingly:
> >>>> https://lore.kernel.org/r/20250318-virtio-v1-0-344caf336ddd@daynix.c=
om
> >>>>
> >>>> This is a nice improvement for the driver, but I still don't think i=
t is
> >>>> suited for the UAPI of tuntap.
> >>>
> >>> Any reason for this? It should work like virtio_net_hdr.
> >>>
> >>>> The requirements of extra fields and
> >>>> little endian cannot be removed from the virtio spec but they are
> >>>> irrelevant for tuntap.
> >>>
> >>> I don't understand this part. What fields are "extra" and need to be
> >>> removed from the spec?
> >>
> >> All fields not included in struct tun_vnet_hash and struct
> >> tun_vnet_hash_rss. Namely, for struct virtio_net_hash_config:
> >> - reserved
> >> - hash_key_length
> >> - hash_key_data
> >>
> >> For struct virtio_net_rss_config:
> >> - max_tx_vq
> >> - hash_key_length
> >
> > See my above reply, and I basically meant
> >
> > TUNSETVETHASH accept struct virtio_net_hash_config;
> > TUNSETVETRSS accept struct virtio_net_rss_config_hdr + struct
> > virtio_net_rss_config_trailer;
>
> That still bring the extra fields I noted in the last email.

I don't know how to define "extra" here. Let's summarize here:

Method A:

1) virtio specification use separate commands for has_report and rss
2) hash_port ans rss doesn't depend on each other
3) reuse virtio-net uAPI

Method B:

1) trying to define and remove the "extra" fields in tuntap, and
redefine it in TUNTAP

It would always be much easier to start from simply reusing the
virtio-net uAPI. Method B makes both the implementation and reviewing
harder, as we need to

1) revisit the design of the virtio spec, this needs to be done in the
virtio community not here
2) audit the difference between virtio spec and TUN/TAP, that's why we
have a very long discussion here

For example, the root cause of why you think the max_tx_vq is "extra" is:

1) The spec defines VIRTIO_NET_F_RSS and VIRTIO_NET_F_MQ as independent fea=
tures
2) Your code tries to re-use IFF_MULTI_QUEUE for both VIRTIO_NET_F_RSS
and VIRTIO_NET_F_MQ, this would have a lot of implications, e.g
automatic steering might be applied when only RSS is negotiated etc

The correct way to implement this is:

1) Introduce IFF_RSS and only set it during TUNSETIFF when device only
offers RSS
2) reuse virtio-net uAPI and accept max_tx_vq and use that to change
the queue(or queue paris) if necessary

Then we have a clean and well defined behaviour (for example when
devices only support RSS but not MQ).

Thanks

>
> Regards,
> Akihiko Odaki
>
> >
> > Thanks
> >
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>>
> >>>>
> >>>>>
> >>>>>> The best possibility is to share structures, not
> >>>>>> commands, and I don't think even sharing structures makes sense he=
re
> >>>>>> because of the reasons described above.
> >>>>>
> >>>>> I don't want to share structures, I meant starting from something t=
hat
> >>>>> is simple and has been sorted in the virtio spec. Optimization coul=
d
> >>>>> be done on top.
> >>>>
> >>>> I meant to reuse the structures in virtio_net.h.
> >>>>
> >>>> Regards,
> >>>> Akihiko Odaki
> >>>
> >>> Thanks
> >>>
> >>>>
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>>
> >>>>>>
> >>>>>> Regards,
> >>>>>> Akihiko Odaki
> >>>>>>
> >>>>>>>
> >>>>>>> Thanks
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Regards,
> >>>>>>>> Akihiko Odaki
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> The paramter will be duplicated if we have separate ioctls for=
 RSS and
> >>>>>>>>>> hash reporting, and the kernel will have a chiken-egg problem =
when
> >>>>>>>>>> ensuring they are synchronized; when the ioctl for RSS is issu=
ed, should
> >>>>>>>>>> the kernel ensure the "types" parameter is identical with one =
specified
> >>>>>>>>>> for hash reporting? It will not work if the userspace may deci=
de to
> >>>>>>>>>> configure hash reporting after RSS.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> See my reply above.
> >>>>>>>>>
> >>>>>>>>> Thanks
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>
> >>>
> >>
> >
>


