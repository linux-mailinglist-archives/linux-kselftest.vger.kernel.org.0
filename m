Return-Path: <linux-kselftest+bounces-35625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2706AE46BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 16:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6779189487D
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 14:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA85253F1B;
	Mon, 23 Jun 2025 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="gGG3Pc4H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00683239E76
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688930; cv=none; b=KMhg18MAuN3jDwOvafKOvlPcnEaTd2qHCl44v/VwFUmn6qdS1XjkP0IDP/yV81X0PqqC/yWaN/6iVkukrn+RFWRSOBHFCvdmAuIidi0Cim+odqmu/ln8/nKbWSTfowZkvmoJxfXO7d54179rmrdfVB9/dBOK7mZ1QbWlwzguLA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688930; c=relaxed/simple;
	bh=/14cwYyKwKubJFvYMHEKWQA22KWCV38zKaWXVdcaG2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYUCRRzuWnIUHjxQibd2XwhLBva8OyVCb0seiruhdO+CK9CRySTKFDCVKdN7uMT6hra6XWIlOni9OLcMu39BxdZ+COYeuhNb/Mw9QjmdZbc7g3Qg8bgSjeyE5Vk1NMGX4qWIMSeVfM/L4dnGx7BlAy/pZPO1pAVrVojVeYBV7Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=gGG3Pc4H; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a44b9b2af8so20584801cf.3
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1750688928; x=1751293728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/14cwYyKwKubJFvYMHEKWQA22KWCV38zKaWXVdcaG2g=;
        b=gGG3Pc4HaxosWf5dMaa+c/J3BbeyQ3nBdt1Z1bcgahYj/++kkU4K3oOnOzwDHkvgo5
         /fKJBOBLhmXf1XhwSejoDNSqtrdxIMLwS8bJyccDKvZzwbuyWbPQmKp/ccpNLnj1z+wU
         r+XcSMoUCpUEQ4N1C8Gobr6CozOBzG7Nebo4doxW6k/3FCl44cX+Dsd/e9EW0nQJz43X
         iBqk2APQE9NJt1OXz5SiZ3jYdqLizYH7JDip1faAfaMO1Rp3rJPuKBD5lwOcbx2epR4F
         +5WdhJ9ukYoSNwE0Cr5Mvm6TeunTmawLmGTxsq4L0i5VC92rTOREwNXhH1uLGVzAe1+w
         t4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688928; x=1751293728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/14cwYyKwKubJFvYMHEKWQA22KWCV38zKaWXVdcaG2g=;
        b=vlhEcj208woYvMqC4HI6mZVyN2PiOd6uUE2bFqVxaEWErwVoEIsH0Q4lNgig0IYDmU
         IBdLtFDJoT1IvF646vLUaju6VKer0ffCoSL52RMalY14F+GmybFRLHoXL0Z0qsy1nLT2
         W+ZBDPTNdPlaXSoymNwWeigcq4gxvdCdsfpNH6Ebs5GqLDK3nxmMldAjYxC/pInByLz5
         e7kpk6hXDEZ5krNLb3y7dor+iQ/zv0lfI6v4DvCfsnuxJoXLPt3rERIVsfd41kKJ3sbD
         o0RxuOzyLE5U7rx2VywVHRpeVTsAANQYTw+5wzjgXqVqMAR8O/+KWbH7ltYJFEiQrHVA
         x6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWfsVOf5A0bF9K3KJQa4JKkOYJ/h02BiO/03oVJ4fqAZ9pyWtVyQCTEilP9ttZXH9lSVeNJoII3V1LrtBSZ50o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR6bYoZE8e9teSPai1ybpDyBYgpPtU4xIsEv19vosiLJyJx2IG
	ANblwHsEqc3YyTF4yf1PqChD8teZBfmQHzPC9aW/qSCftEH8bmjNRMXEJAy9WE21facXXrnsgT2
	iyx4dE+PFlBNxbpeHtEelfEyZFW82N7DBjgC+WDlZPw==
X-Gm-Gg: ASbGnct03HNqyyKpJsi5rPshFEqcKJKB8smFdIA4gspxi1M578VKiQcYz2vNwXVcvGE
	Jv9b0lTqdnKu6vQuARcBz+1ddAD2G/aF3s3orG6hDpehwiATn2Mnv2girew4PlNhxady8X1Pywe
	FFqMV6q6LIfGDyzVAsPNU82OU4cr8yy9Jo5o1vNzv/ODiWofxIn+q5iUneYp0JgOthjH5InUKeW
	nZyTg==
X-Google-Smtp-Source: AGHT+IGAEU79vWFsEbGN71mgZpuPejwVzDs9CuFGRu/kIPPECPSaBJWX6S8IOXgJzNmRFrQ3GoKYDSjB9QaqmPokmug=
X-Received: by 2002:a05:622a:50f:b0:4a7:146b:c5e5 with SMTP id
 d75a77b69052e-4a77a20840emr222574351cf.21.1750688927718; Mon, 23 Jun 2025
 07:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-1-95d8b348de91@daynix.com>
 <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
 <95cb2640-570d-4f51-8775-af5248c6bc5a@daynix.com> <CACGkMEu6fZaErFEu7_UFsykXRL7Z+CwmkcxmvJHC+eN_j0pQvg@mail.gmail.com>
 <4eaa7aaa-f677-4a31-bcc2-badcb5e2b9f6@daynix.com> <CACGkMEu3QH+VdHqQEePYz_z+_bNYswpA-KNxzz0edEOSSkJtWw@mail.gmail.com>
 <75ef190e-49fc-48aa-abf2-579ea31e4d15@daynix.com> <CACGkMEu2n-O0UtVEmcPkELcg9gpML=m5W=qYPjeEjp3ba73Eiw@mail.gmail.com>
 <760e9154-3440-464f-9b82-5a0c66f482ee@daynix.com> <CACGkMEtCr65RFB0jeprX3iQ3ke997AWF0FGH6JW_zuJOLqS5uw@mail.gmail.com>
 <CAOEp5OcybMttzRam+RKQHv4KA-zLnxGrL+UApc5KrAG+op9LKg@mail.gmail.com> <CACGkMEsfxXtHce2HeYwYxmhB0e5cOjn17qM6zFEt75bQhbtrDw@mail.gmail.com>
In-Reply-To: <CACGkMEsfxXtHce2HeYwYxmhB0e5cOjn17qM6zFEt75bQhbtrDw@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 23 Jun 2025 17:28:36 +0300
X-Gm-Features: AX0GCFu3hePJcE8mBSHlKXkSVpPD8N_41tEP_O5fU60lBvVDsaWZNc7CeBwagRc
Message-ID: <CAOEp5Oet1P2EWTwLJnMYY4CVAzDWgdM8wbvV3+BH6aY0kE+O8g@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Andrew Melnychenko <andrew@daynix.com>, Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 11:07=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Jun 23, 2025 at 1:40=E2=80=AFAM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
> >
> > > Yuri, can you help to clarify this?
> >
> > I see here several questions:
> > 1. Whether it is ok for the device not to indicate support for XXX_EX h=
ash type?
> > - I think, yes (strictly speaking, it was better to test that before
> > submitting the patches )
> > 2. Is it possible that the guest will enable some XXX_EX hash type if
> > the device does not indicate that it is supported?
> > - No (I think this is part of the spec)
>
> There's another question, is the device allowed to fallback to
> VIRTIO_NET_HASH_TYPE_IPv6 if it fails to parse extensions?
MSFT expectations for that are at
https://learn.microsoft.com/en-us/windows-hardware/drivers/network/rss-hash=
ing-types
If I read them correctly, the answer is "no"
BTW, my personal opinion is that placing all these things with hash
calculations into kernel instead of ebpf does not make too much sense.

>
> > 3. What to do if we migrate between systems with different
> > capabilities of hash support/reporting/whatever
> > - IMO, at this moment such case should be excluded and only mechanism
> > we have for that is the compatible machine version
> > - in some future the change of device capabilities can be communicated
> > to the driver and _probably_ the driver might be able to communicate
> > the change of device capabilities to the OS
>
> Are you suggesting implementing all hash types? Note that Akihiko
> raises the issue that in the actual implementation there should be a
> limitation of the maximum number of options. If such a limitation is
> different between src and dst, the difference could be noticed by the
> guest.
>
> > 4. Does it make sense to have fine configuration of hash types mask
> > via command-line?
> > - IMO, no. This would require the user to have too much knowledge
> > about RSS internals
> >
> > Please let me know if I missed something.
> >
>
> Thanks
>

