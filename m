Return-Path: <linux-kselftest+bounces-31364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2F2A97ACB
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 01:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D783B96F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 23:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D070E2D0260;
	Tue, 22 Apr 2025 23:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSTPJmDW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EE91EA7EB
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362856; cv=none; b=ZMlGK+KuYhbpo2bKdF91TAow71WJQOYWULqkAyJa09Kic8XjiwbnHQOt9vKAwDrIrnpX7RKT/7d9R19+vCKhvzSIN5ZY/ry/ZhE8sPRDUg/flRvMK9MeEOeMk8SCbrFfG+E33pRHaXP05V5pJpqnW9HnfV+RES/2qqo5DhcSxmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362856; c=relaxed/simple;
	bh=vA0x1LF+TTujtzA/a9qIyOuUZvc6uTpZ8L2xS4rCm/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkjgeABn6S0pWvCgSUYG+gI7awWL+Q8P1qlymIloN3KECAouLk4tL5bWi1mv+5rtPH4gU/sMrp4XiLPVtc5Ma3eRgtfV60AJ1ZAVj4nmfYCkgaD0IDHlcvsO89b+A8W5nNaV1c/7ggbuT0XQfZ4DIWA6wzzLDvMlOp2RMRF3nXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vSTPJmDW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240aad70f2so102495ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 16:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745362854; x=1745967654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0wkS+mYcttDoYH2cbzpbLqiayCSdu0EeV0O89OnxB4=;
        b=vSTPJmDW/0RBiNQ+pXo+/ZFUu9NXOW/mYR/LTeXX0PDtkS2kzlnEhrDftAorprnLh9
         B/ocgO6V4ijHaBDVDYg9jL9VOb/JTTXw0+6S+4tY7MtwRoZ5UvWVUsbIXQaus6pT7WIM
         w9JyPlBFdKdDqkaPdhGNJyHXBD3R1sPHkcrer5Y+IzcoOu9zjO12veodho3lesqRnqS/
         ZAStMrBVqSDj4W5etdANq85mg8kvu8N2Yyfeq9+o7t2dSSKpzsDi4P2t4oGQC/1IFwHS
         Bak+lxuGPw4pkmdTAXPNdW6jRVAwnpbPvESvT2YSRlvhPL7TLc7E1y0fQt/+j6nPSPYZ
         Y8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745362854; x=1745967654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0wkS+mYcttDoYH2cbzpbLqiayCSdu0EeV0O89OnxB4=;
        b=klM5dSXafTdUY/4QuXfBkS4ErBilMFpDR7wlmT3fiJP0WInCBWczYyVpEbbQ+3zVti
         SFywlT4o5JqnUC8HicTac9ftTkm1n3Bg6PYXQEa6MSmWlOwHI8afwLb2betKgHTNMgXk
         JwFmiPLXbu41qM3scydvS4KN4zRdVTuyP4yl2N3+ef8MrDg/+BuiSUvTpODpxFm/K1NF
         RFhINypiq2sKHCyGzJi2Y0neNpyn1505oZEnXElKIPFQmY8wvomNt4LQoyS1QunNlNDn
         Biv38pNOxQmll46oxl41eBfcx0yHRoURg++npEBrEmPdveJjZB6ZLxE0gllt/YMOjyE8
         FW+g==
X-Forwarded-Encrypted: i=1; AJvYcCVz3JFFJEv+RkC5pOqjiIGhoK8EwZBa0Fekf6d6hBtmDlsH+P18ZJbxRfH69wOl6cYTHxB3WoOHTQa3q8m8qcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1aHAezTHWm+2ZifbbWFZwZLDaS/bapQTzI7lmGTiJIMSFdbHO
	AqhWE04C2M1YPtJiJ3g3/ieOAIVPpDnW4fr+3VKLcZX845y8jNezoR6ImXxUjTpS50xP4zsZ+sQ
	eReYXES58ep0KmWdPhB+2S+U2s8I00msdEpVL
X-Gm-Gg: ASbGnct6tYDbDuCgDkoT8lzaESnJix2nquaLUer2EMlWGmCKKauW4RRceya3wQA7RfC
	Rgahejwy7fIhyJzT43asKThqfLa/k3iSLfoEe6uevpWvfe2CwPMlV4XONfWAnLeH8G8k6EbfgBF
	q1tXffFy2QVoIjY9Mb2WFCh1IDgFqlQdAXwlWb1StsXLTFPyGay7NhPOQMw0xNnQ4=
X-Google-Smtp-Source: AGHT+IFcA8eNct2OIuHlbOvxzm3T6NVzaOSOXt3ivEIqSJ8wke0kgYVfmjCEtUHN4nE+IsPWRgGhH+7fhESmeCiNRMo=
X-Received: by 2002:a17:902:ef07:b0:215:86bf:7e46 with SMTP id
 d9443c01a7336-22da4ebcff9mr256305ad.7.1745362853731; Tue, 22 Apr 2025
 16:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com>
 <20250417231540.2780723-8-almasrymina@google.com> <CAEAWyHckGSYEMDqVDT0u7pFCpO9fmXpEDb7-YV87pu+R+ytxOw@mail.gmail.com>
 <CAHS8izNZXmG0bi15DpmX2EcococF2swM83Urk19aQBvz=z3nUQ@mail.gmail.com>
In-Reply-To: <CAHS8izNZXmG0bi15DpmX2EcococF2swM83Urk19aQBvz=z3nUQ@mail.gmail.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 22 Apr 2025 16:00:42 -0700
X-Gm-Features: ATxdqUGxkrayoAGMPm_qgEhKu-sQHz14vjXf4E7ZJdbEqvqiDvu9MHtNVHd91NA
Message-ID: <CAEAWyHf7Qzi8CDBeRMB5nMvvNawrFrUCh52k4JevbSHX1Y=zcw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 7/9] gve: add netmem TX support to GVE DQO-RDA mode
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 2:30=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Tue, Apr 22, 2025 at 10:43=E2=80=AFAM Harshitha Ramamurthy
> <hramamurthy@google.com> wrote:
> >
> > On Thu, Apr 17, 2025 at 4:15=E2=80=AFPM Mina Almasry <almasrymina@googl=
e.com> wrote:
> > >
> > > Use netmem_dma_*() helpers in gve_tx_dqo.c DQO-RDA paths to
> > > enable netmem TX support in that mode.
> > >
> > > Declare support for netmem TX in GVE DQO-RDA mode.
> > >
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > >
> > > ---
> > >
> > > v4:
> > > - New patch
> > > ---
> > >  drivers/net/ethernet/google/gve/gve_main.c   | 4 ++++
> > >  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 8 +++++---
> > >  2 files changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net=
/ethernet/google/gve/gve_main.c
> > > index 8aaac9101377..430314225d4d 100644
> > > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > > @@ -2665,6 +2665,10 @@ static int gve_probe(struct pci_dev *pdev, con=
st struct pci_device_id *ent)
> > >
> > >         dev_info(&pdev->dev, "GVE version %s\n", gve_version_str);
> > >         dev_info(&pdev->dev, "GVE queue format %d\n", (int)priv->queu=
e_format);
> > > +
> > > +       if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
> > > +               dev->netmem_tx =3D true;
> > > +
> >
> > a nit: but it would fit in better and be more uniform if this is set
> > earlier in the function where other features are set for the
> > net_device.
> >
>
> Thanks for taking a look. I actually thought about that while trying
> to implement this, but AFAIU (correct if wrong), gve_is_gqi and
> gve_is_qpl need priv to be initialized, so this feature set must be
> performed after gve_init_priv in this function. I suppose this feature
> checking maybe can be put before register_netdev. Do you prefer that?

Ah yes, you are right. Thanks for checking. That would be preferable.
Another option is to move it inside gve_init_priv() after the mode has
been set. Either is okay.

Thanks,
Harshitha
>
>
> --
> Thanks,
> Mina

