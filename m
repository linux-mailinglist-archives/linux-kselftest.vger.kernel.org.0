Return-Path: <linux-kselftest+bounces-34353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AFDACE811
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 03:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF53172977
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 01:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA191D63C0;
	Thu,  5 Jun 2025 01:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYe3L2h5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083781C3BFC
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Jun 2025 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749088548; cv=none; b=ZEqD2PB8deUx1LixoKZPvkihVp+wbHepRSh43OSo57LPMTVGENkn4p5Sqyd/85gC1Yq4a6V37ohop7rQwxAnUtHbYhXprMH1T/S6aQHKBiINbhtBcXFWirOwwMjYmeaBuYk25AinxsyJErc+fO7DNjVCbIyUmAuwPNpxtPUqClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749088548; c=relaxed/simple;
	bh=+c9Fev8/Meg10Uoay1ZU/kdCAOWZDW9/gdNngKjH6Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1aEeedOjKZJpdqt9g9jJx2t4umvwy/ZkE4cThNaxax0yk3gKk3SScgn8J7N8Lt5Kr8DqIV1CxXHlcUV3hL36nJdySnaOdt84FGyMTaHnyqJfzYnBtmxpv8f8VfBp8/30P7pjxNxCh5HSTGsMgDVNPrXcfpKLn1KltFs951BuqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYe3L2h5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749088544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9AwB0rFfcz08HKP4jJKt0w7l+d02ZrCK/l/MYo9cvhM=;
	b=AYe3L2h5+WV3v1fGRdDtOoJICmTJnX22XM5MagCWy/d10VhwQnJ3OkKRUs4gW6Ob4QRkUh
	cSr6I48iW8sQxg2KiULoYMhiVSWT6Tu5QIaWQ19LZiwhMbmrlObojNF+O19fRdzJJ928c6
	ZYhM/f1Aagunlq5WtXucK3lmWfZM6gg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-sPEYia-jN9udvIg_VcpKQg-1; Wed, 04 Jun 2025 21:55:43 -0400
X-MC-Unique: sPEYia-jN9udvIg_VcpKQg-1
X-Mimecast-MFC-AGG-ID: sPEYia-jN9udvIg_VcpKQg_1749088542
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74292762324so491515b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 18:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749088541; x=1749693341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AwB0rFfcz08HKP4jJKt0w7l+d02ZrCK/l/MYo9cvhM=;
        b=THed1M5opLDn/zFir8MdvUZwvAitkkSxY4GhTchK60LsTd+Hb6oELsH4Qw7FsZ6xYv
         GLSDLRmpSq1+iwFhlGeS82M53Lq0exHnSWGHOijUxd/cEgDneEdgIU4MZ9bm1FqLyWTS
         1G0ng7H1hRoOZ8DwH26hzePeFWdY0Dc7os58dT6WBcQFOLEALvxYiM+bpmRls6iOLRPs
         GtOA6/tIKbdMHNf1QzZOXlMapqKRuMDLjhge8hTAZ9r6smimZEgXJoiNCmW1FzhPjnbk
         vTtptoyJEtd2D1019asbJeRHwqmMspJbKNzqhL8LvR6fvOBiQJY7AJKv/+5A9D9+D7Ls
         8JaA==
X-Forwarded-Encrypted: i=1; AJvYcCWzh5eTBrY49GK6zVSLC+S1ni5KhVuZFNFzreNaOiVJ9jcNNQS15KTHk4dyRh1ITrypYDJGSSLVMsV/ZMOG1v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YylHSdaef8SMSUPjUVXAWCUaTFnotEL+gU+1uSyScREV1oNAuL1
	9SlH4EH4EI3lixCyhbkkH7rk6PxiGcfKbKS0l+L8JfK7OYSFJAIqhZxlyWSInFjkTs8mfYoyl86
	KDmv9KABJjsUzy3P1YREijhCsHcF3QsBENHbMTTDffUM/aKn9i+j3mKOhqnBN49eKzD/WPnQyXf
	gtm5kqEifXSIpQt6bPuQubQ1m20IlRE2hPR8FFTmuSLSiji282h5htU5w=
X-Gm-Gg: ASbGnctRCtsIGlJrpKbowk/I+D42pVPYrcGq0qoY+FBD7lzp7MKOVCruHqsPWyGSoMW
	5WTHlDcpuYxASQ9C1+XNxJDm0iwgsE4sGaf3RmonTr0aEIF0LFb6qH0F82+6Q1+UF0Sy8669JpD
	3fMvM=
X-Received: by 2002:a05:6a00:2388:b0:740:9d7c:aeb9 with SMTP id d2e1a72fcca58-7480b4d1082mr6213294b3a.21.1749088541563;
        Wed, 04 Jun 2025 18:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwnJcqWyBWgiV7ZC471A+qE9fAqmmsGEYcyWVU07xTy7Qtf9rwO6aj8PQ3oqhbhbV/So3yIUnkKqxQkvKzki0=
X-Received: by 2002:a05:6a00:2388:b0:740:9d7c:aeb9 with SMTP id
 d2e1a72fcca58-7480b4d1082mr6213256b3a.21.1749088541126; Wed, 04 Jun 2025
 18:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-3-95d8b348de91@daynix.com>
 <CACGkMEvVf0LrquZcWSv3vp-r44sTj0ZDnjwbwB20N0aU35+vxw@mail.gmail.com> <517d5838-3313-4b31-b96d-d471b062cd1a@daynix.com>
In-Reply-To: <517d5838-3313-4b31-b96d-d471b062cd1a@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Jun 2025 09:55:29 +0800
X-Gm-Features: AX0GCFurXm0NIffhahLwnERAjW3lh1v_d_xG6UdMjWsQHXxbHYsep8L113YBN6k
Message-ID: <CACGkMEvyaY0rdNTj_jP_4HF5TrCCNeTKZZ8U2LsMikLqyctkzA@mail.gmail.com>
Subject: Re: [PATCH net-next v12 03/10] tun: Allow steering eBPF program to
 fall back
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

On Wed, Jun 4, 2025 at 3:24=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> On 2025/06/04 10:27, Jason Wang wrote:
> > On Fri, May 30, 2025 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>
> >> This clarifies a steering eBPF program takes precedence over the other
> >> steering algorithms.
> >
> > Let's give an example on the use case for this.
> >
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   Documentation/networking/tuntap.rst |  7 +++++++
> >>   drivers/net/tun.c                   | 28 +++++++++++++++++----------=
-
> >>   include/uapi/linux/if_tun.h         |  9 +++++++++
> >>   3 files changed, 33 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/Documentation/networking/tuntap.rst b/Documentation/netwo=
rking/tuntap.rst
> >> index 4d7087f727be..86b4ae8caa8a 100644
> >> --- a/Documentation/networking/tuntap.rst
> >> +++ b/Documentation/networking/tuntap.rst
> >> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable=
 it::
> >>         return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
> >>     }
> >>
> >> +3.4 Reference
> >> +-------------
> >> +
> >> +``linux/if_tun.h`` defines the interface described below:
> >> +
> >> +.. kernel-doc:: include/uapi/linux/if_tun.h
> >> +
> >>   Universal TUN/TAP device driver Frequently Asked Question
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index d8f4d3e996a7..9133ab9ed3f5 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -476,21 +476,29 @@ static u16 tun_automq_select_queue(struct tun_st=
ruct *tun, struct sk_buff *skb)
> >>          return txq;
> >>   }
> >>
> >> -static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_bu=
ff *skb)
> >> +static bool tun_ebpf_select_queue(struct tun_struct *tun, struct sk_b=
uff *skb,
> >> +                                 u16 *ret)
> >>   {
> >>          struct tun_prog *prog;
> >>          u32 numqueues;
> >> -       u16 ret =3D 0;
> >> +       u32 prog_ret;
> >> +
> >> +       prog =3D rcu_dereference(tun->steering_prog);
> >> +       if (!prog)
> >> +               return false;
> >>
> >>          numqueues =3D READ_ONCE(tun->numqueues);
> >> -       if (!numqueues)
> >> -               return 0;
> >> +       if (!numqueues) {
> >> +               *ret =3D 0;
> >> +               return true;
> >> +       }
> >>
> >> -       prog =3D rcu_dereference(tun->steering_prog);
> >> -       if (prog)
> >> -               ret =3D bpf_prog_run_clear_cb(prog->prog, skb);
> >> +       prog_ret =3D bpf_prog_run_clear_cb(prog->prog, skb);
> >> +       if (prog_ret =3D=3D TUN_STEERINGEBPF_FALLBACK)
> >> +               return false;
> >
> > This seems to break the uAPI. So I think we need a new ioctl to enable
> > the behaviour
>
> I assumed it is fine to repurpose one of the 32-bit integer values since
> 32-bit integer is too big to specify the queue number, but it may not be
> fine. I don't have a concrete use case either.
>
> Perhaps it is safer to note that TUNSETSTEERINGEBPF takes precedence
> over TUNSETVNETRSS to allow such an extension in the future (but without
> implementing one now).

Yes, that's my original point. Let's start from something that is
simpler and safer.

Thanks


