Return-Path: <linux-kselftest+bounces-18539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFB1989295
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 04:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84FE328542B
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 02:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7C714287;
	Sun, 29 Sep 2024 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFOwkDGf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046F218EB1
	for <linux-kselftest@vger.kernel.org>; Sun, 29 Sep 2024 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727575647; cv=none; b=lQ/nmKkYCfXRIRWm4eE7HaVx4czOjXb4dv6ZiDKlOmt7WwC+1/QQfhx7eFT70wb7H+EpvLzmGxQ1FFZoRjMCTll14ZB4xaDVRD6/6dhC/NYYt8bhcG7qgu8mF+LZnxzXFKia8vKApMqU4ZyH7P2Fio9+tC2a9IX1YPhylgLE0xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727575647; c=relaxed/simple;
	bh=TO6F9WUFFXlq7WPqrSDsnpUMpKF1xFzm56hCVzpmjMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYFg8QPMOxco57sfCz8qKZEzwZmn5J7PYlgF61i4PGYq8wj+1XTk7/JmZrDVP971eb/9mC8Nk3Dghrnc1TP9tfCetVtJqJVQzo5AH2sGruIsYs782zHu1iqMuDW+zoSMNYZwv9Ov3l8h22hvvMj5iFBqEc0z53c4cRWENJGr6k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFOwkDGf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727575645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TO6F9WUFFXlq7WPqrSDsnpUMpKF1xFzm56hCVzpmjMk=;
	b=PFOwkDGfqZRTdRa+vO2LbLy8UjqJg5awchQ37wMOJg5uTGD3IfXg3eIgD8DLcmn604+jcy
	nu7qpdTEj/tFiaOUHbCN06ICgvLZTOWoyqQbomCT0+HWBHDQGhmmOoBs1T+MA60iR0nsRq
	OYTOTkN77HTlLAFDLO3foo6zKFyztlE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-1R1gpU3iMWetVUoN56Kfzw-1; Sat, 28 Sep 2024 22:07:23 -0400
X-MC-Unique: 1R1gpU3iMWetVUoN56Kfzw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7e6cc094c2fso3986857a12.1
        for <linux-kselftest@vger.kernel.org>; Sat, 28 Sep 2024 19:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727575643; x=1728180443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TO6F9WUFFXlq7WPqrSDsnpUMpKF1xFzm56hCVzpmjMk=;
        b=m+d7xdluzreJV4cS2Pv4JXDujQBT2/Vq0vGTN/YVYYrUa6SMebAi9Mw33aHFb6v8BQ
         k6/+NybEijU3dAPa9sxqW7Re1P5ebihdmkNjnz+7Y6+gzoIgugyU0ZsweyYYiFSHxcr0
         OC+Hc7rP59zor8w3Ft0Wq+ZdQ703MiE/DoIMC2uyhiPDUKzb4dwhduYBFUt1MS9qtHI2
         VQ23waIu3n0ZcgKJAFS0LQQCf39/rNCva7DDQFHUMfs/TqNjptSPTPZOyfYS6JN4HqGJ
         PWWHyBxKcHqYZPVUljs2aqge/Rat2wICJeqjUbNIT8/SyS7vi2OYmNzmct0KqsffXaL0
         E3wg==
X-Forwarded-Encrypted: i=1; AJvYcCUBtvx6PUy+hmeMUL4HM2umjpfOjOdnCiRkTRi9Cxrw1xssk0SmU15ndscM+i8i0tXHaqBALO32b7/mXy5MbZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyitdnMuHhpo0bP2QiGXFGu6kcogHZ/MKt8kI246dt39hLSIoyT
	1FS/vHLsaI3S+jnyHmmNAZBlAiaV66kQ6yiQbFHVqKgSh4Jh/MWwy9//eEpEZhSCOgZA5NfqlMs
	on/E18nQsA1KcDi3Rz1m9d9tXxxc+WKFOThhi3Nd1dRLFu+VFMo2EFVoCFuL6OEcWadE01I2wDE
	XWy8cAgfMK1RlScP8Roy5u3Ap+ZC8puHs/WfslQfjZ
X-Received: by 2002:a17:90a:d994:b0:2d8:e6d8:14c8 with SMTP id 98e67ed59e1d1-2e0b72ebe66mr12848829a91.15.1727575642714;
        Sat, 28 Sep 2024 19:07:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj0CCQ8up3FJXqhdPxg4H3lCO7LjesFN419E2sMSG36WbFWRO8y7aomLGECK7sl9/s5dIhUxnui4OmPKl9ZQY=
X-Received: by 2002:a17:90a:d994:b0:2d8:e6d8:14c8 with SMTP id
 98e67ed59e1d1-2e0b72ebe66mr12848791a91.15.1727575642243; Sat, 28 Sep 2024
 19:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com> <CACGkMEvMuBe5=wQxZMns4R-oJtVOWGhKM3sXy8U6wSQX7c=iWQ@mail.gmail.com>
 <c3bc8d58-1f0e-4633-bb01-d646fcd03f54@daynix.com> <CACGkMEu3u=_=PWW-=XavJRduiHJuZwv11OrMZbnBNVn1fptRUw@mail.gmail.com>
 <6c101c08-4364-4211-a883-cb206d57303d@daynix.com>
In-Reply-To: <6c101c08-4364-4211-a883-cb206d57303d@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 29 Sep 2024 10:07:11 +0800
Message-ID: <CACGkMEtscr17UOufUtyPp1OvALL8LcycpbRp6CyVMF=jYzAjAA@mail.gmail.com>
Subject: Re: [PATCH RFC v4 0/9] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 3:51=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/09/27 13:31, Jason Wang wrote:
> > On Fri, Sep 27, 2024 at 10:11=E2=80=AFAM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>
> >> On 2024/09/25 12:30, Jason Wang wrote:
> >>> On Tue, Sep 24, 2024 at 5:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> >>>>
> >>>> virtio-net have two usage of hashes: one is RSS and another is hash
> >>>> reporting. Conventionally the hash calculation was done by the VMM.
> >>>> However, computing the hash after the queue was chosen defeats the
> >>>> purpose of RSS.
> >>>>
> >>>> Another approach is to use eBPF steering program. This approach has
> >>>> another downside: it cannot report the calculated hash due to the
> >>>> restrictive nature of eBPF.
> >>>>
> >>>> Introduce the code to compute hashes to the kernel in order to overc=
ome
> >>>> thse challenges.
> >>>>
> >>>> An alternative solution is to extend the eBPF steering program so th=
at it
> >>>> will be able to report to the userspace, but it is based on context
> >>>> rewrites, which is in feature freeze. We can adopt kfuncs, but they =
will
> >>>> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KV=
M
> >>>> and vhost_net).
> >>>>
> >>>
> >>> I wonder if we could clone the skb and reuse some to store the hash,
> >>> then the steering eBPF program can access these fields without
> >>> introducing full RSS in the kernel?
> >>
> >> I don't get how cloning the skb can solve the issue.
> >>
> >> We can certainly implement Toeplitz function in the kernel or even wit=
h
> >> tc-bpf to store a hash value that can be used for eBPF steering progra=
m
> >> and virtio hash reporting. However we don't have a means of storing a
> >> hash type, which is specific to virtio hash reporting and lacks a
> >> corresponding skb field.
> >
> > I may miss something but looking at sk_filter_is_valid_access(). It
> > looks to me we can make use of skb->cb[0..4]?
>
> I didn't opt to using cb. Below is the rationale:
>
> cb is for tail call so it means we reuse the field for a different
> purpose. The context rewrite allows adding a field without increasing
> the size of the underlying storage (the real sk_buff) so we should add a
> new field instead of reusing an existing field to avoid confusion.
>
> We are however no longer allowed to add a new field. In my
> understanding, this is because it is an UAPI, and eBPF maintainers found
> it is difficult to maintain its stability.
>
> Reusing cb for hash reporting is a workaround to avoid having a new
> field, but it does not solve the underlying problem (i.e., keeping eBPF
> as stable as UAPI is unreasonably hard). In my opinion, adding an ioctl
> is a reasonable option to keep the API as stable as other virtualization
> UAPIs while respecting the underlying intention of the context rewrite
> feature freeze.

Fair enough.

Btw, I remember DPDK implements tuntap RSS via eBPF as well (probably
via cls or other). It might worth to see if anything we miss here.

Thanks

>
> Regards,
> Akihiko Odaki
>


