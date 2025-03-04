Return-Path: <linux-kselftest+bounces-28136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C16C1A4D232
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 04:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 980987A8FC9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 03:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DA21F181F;
	Tue,  4 Mar 2025 03:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zeha4UDL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3F51F0E52
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 03:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741060439; cv=none; b=Opdo6hSzIj9AHT9W7xsiExdPbM1QSIZKnwhdNX9A7VrnOb5yYCQwWIgbvP3JbxhqQKsoB/ZX3/eY5TvL+YBl1RDwavrNtAdVZ7P97XLuw+cug0RgGQ0c69DL/JjeM5sAO3zy93YS0eZg80fp8nw7O5/LHEO5krPAPcXgPEQJPF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741060439; c=relaxed/simple;
	bh=v4ZIW03tXTq33ylUh9Hi3kvpmNUOTXtibE59mai2iZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdZTQN2kIdJ3Pfz68slzJegLijaC8xu4gFgB+l9BD8qg6T20QMiK05jXCUgO03MLrs94FreZkhHYxfXuv7BXiguETd7YeBSfXz33B+MERT5Tp8PtITwE/FwFOCrEsY0FeTy/NC0PhfMZutjyn7RIrybTv4pHZP8sOTP43NyhBYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zeha4UDL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22342c56242so97185ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 19:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741060437; x=1741665237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSFEb6cmbj6TrSKHrJmKO1hlYsPUC+0FUI58pDz1vl8=;
        b=Zeha4UDL+PUCz5e9lJQdQ12LAT7HMzDhQtuPE6EzaQxiOITpXFceZVvMq1+a2pKt0J
         y7za/dpejvEOzlvhE5g4JKZlZiTf2yr2hlGqc7LT/WGncgsyCnfOvk/sucC927Rr4ddm
         bUkywf/hRsJuweRVxy6NpyUhiY/0nyvBDrmiOEZ6IP4Mw2LUgvP6Cm/yxYbJAGyXIUX7
         JZUByRUTGpZisw9jgUXQVUHCipDQonZKeoCX66hEDsV+OEwk67XglZbZ8Bsx4gIXtx46
         wka3oEIwuZ1I8yNNu92/Oq7D9CxIeqXofDA3kyHn7TLGFqrYqQbZXiQQlcvBRE90saRt
         6a4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741060437; x=1741665237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSFEb6cmbj6TrSKHrJmKO1hlYsPUC+0FUI58pDz1vl8=;
        b=AcPs8Ekply3CyTvw/R1+mNY4XjY7ygnJYdsfCMx0OIan9TYUSTxKL5ZkCumS+K3nWH
         O3TNpYYNFZTe+OSPeE09kL93hVqXet1H3OtWv1F41rx8DoDkaBHMKwiBX0dJx8lNlsj3
         hZ9DeySYO1o0zN4/GWnxyKZtd0HHTMih0b0nduT4IB1WcyzGO7tIwHc5Ku7d0xzP+l2T
         dXWmhPMaZALC5vk1dMoJK4CnGwvtinuKdUldcIW6UETJqs4bESoVT00q1A6dCzppWbDV
         RSesjHMn6TkpRuHRpe9n1e9vcDYAVVXc7CtSqigh2Z8cXyw53PJHWwfukd3ls78uJVJ9
         qwVw==
X-Forwarded-Encrypted: i=1; AJvYcCWB1Du9MPMrs2R6Fg7JbkhqBiBBcW/yRGtGcNYWaSvLcIzFEWJW/fMbGSRQaI3AgUkgkv6fWL9uSl+AmaoGb58=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIrIWubwly5HPsV11LmMSm9O4DG9TWC9sQ+DNOt6HB0riY26ZZ
	mQ423NTZjNUI2G3oR4tZFTeCTfcvbiiCDdnQdYIeDbXJc6ErMqC9QcDMiYPmoyLYaf/z6Z4bYes
	tVs/1d6u7ZwAoh1hrQMOeygjOGqynSOdWxTSs
X-Gm-Gg: ASbGnctRuMZ1gDKCkcAngh63KjBQvR+B75R6Mem8xBZOHCzrz4p/RqWtGMuiBGCLVPa
	ojM0godjkcLPzb/VVcz63ML3fxT3kYwC7THoKQLQWX1kw+kfQhf1s7j5SiLD9ErCFCLAPdD/5iE
	rJB4QaDLiPT94B64/gH5jSQBXb3g==
X-Google-Smtp-Source: AGHT+IHSpmXymQz0Hg2Nfi/UMM95jLNI0Agz8LxyDxK7J1nuQGrVPSq5ZOQpmxKAyc8gv2/Tg1AhK763Ctub08I/iBk=
X-Received: by 2002:a17:902:e892:b0:217:8612:b690 with SMTP id
 d9443c01a7336-223d9e008f0mr1582615ad.8.1741060436769; Mon, 03 Mar 2025
 19:53:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227041209.2031104-1-almasrymina@google.com>
 <20250227041209.2031104-8-almasrymina@google.com> <20250228164301.07af6753@kernel.org>
 <CAHS8izO-N4maVtjhgH7CFv5D-QEtjQaYKSrHUrth=aJje4NZgg@mail.gmail.com> <20250303162901.7fa57cd0@kernel.org>
In-Reply-To: <20250303162901.7fa57cd0@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 3 Mar 2025 19:53:44 -0800
X-Gm-Features: AQ5f1JrYu9C4BjqccschILEVQXZn6ayr_hbqMYvwnSubi9nhcByOZkaDeGtsjTs
Message-ID: <CAHS8izOJfSCM+qZ=npPOK3kwuA1pyGHrPo73brRq2VXg8G450g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 7/8] net: check for driver support in netmem TX
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 4:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 28 Feb 2025 17:53:24 -0800 Mina Almasry wrote:
> > On Fri, Feb 28, 2025 at 4:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Thu, 27 Feb 2025 04:12:08 +0000 Mina Almasry wrote:
> > > > +     if (!skb_frags_readable(skb) && !dev->netmem_tx)
> > >
> > > How do you know it's for _this_ device tho?
> >
> > Maybe a noob question, but how do we end up here with an skb that is
> > not targeted for the 'dev' device? We are checking in
> > tcp_sendmsg_locked that we're targeting the appropriate device before
> > creating the skb. Is this about a packet arriving on a dmabuf bound to
> > a device and then being forwarded through another device that doesn't
> > own the mapping, bypassing the check?
>
> Forwarded or just redirected by nft/bpf/tc
>
> > > The driver doesn't seem to check the DMA mapping belongs to it either=
.
> > >
> > > Remind me, how do we prevent the unreadable skbs from getting into th=
e
> > > Tx path today?
> >
> > I'm not sure if this is about forwarding, or if there is some other
> > way for unreadable skbs to end up in the XT path that you have in
> > mind. At some point in this thread[1] we had talked about preventing
> > MP bound devices from being lower devices at all to side step this
> > entirely but you mentioned that may not be enough, and we ended up
> > sidestepping only XDP entirely.
> >
> > [1] https://lore.kernel.org/bpf/20240821153049.7dc983db@kernel.org/
>
> Upper devices and BPF access is covered I think, by the skbuff checks.
> But I think we missed adding a check in validate_xmit_skb() to protect
> the xmit paths of HW|virt drivers. You can try to add a TC rule which
> forwards all traffic from your devmem flow back out to the device and
> see if it crashes on net-next ?

No crash, but by adding debug logs I'm detecting that we're passing
unreadable netmem dma-addresses to the dma_unmap_*() APIs, which is
known to be unsafe. I just can't reproduce an issue because my
platform has the IOMMU disabled.

I guess I do need to send the hunk from validate_xmit_skb() as a fix
to net and CC stable.

Another thing I'm worried about is ip_forward() inserting an
unreadable skb into the tx path somewhere higher up the stack which
calls more code that isn't expecting unreadable skbs? Specifically
worried about skb_frag_ref/unref. Does this sound like a concern as
well? Or is it a similar code path to tc?

--
Thanks,
Mina

