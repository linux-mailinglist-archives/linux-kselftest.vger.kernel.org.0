Return-Path: <linux-kselftest+bounces-1209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DC2805EB8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 20:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67AE281F71
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 19:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93476AB9D;
	Tue,  5 Dec 2023 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLk7Pqh4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BBE194
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 11:39:30 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c65e666609so3701881a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Dec 2023 11:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701805170; x=1702409970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfq67iLmriDqfduTRY0M8dju8QhNwul2zcs5mKn+Qdk=;
        b=qLk7Pqh4Pd9QsKsbP60577NqraCUiybzAGtjqVrmb3yTT0fZZDlCA6TsvS3vuT2iOB
         hky+24GulvywVn0x1HL0oSBsjpNVQ04MJOgVctAytLuBKCC0A+y/Pt0g3bt4ATD3Vxaj
         IcbSQMiQdvW4I+bTkBHWzxKZH+AsfGiDp0HuTB9q4TGD6VMcyVNzi/Goy5jxmvjqGVXx
         kxC+Po70jB5erw0iT79pdQ4U6jxwvQ2TenwMOfhXivYl6F34MyiOQ7l76PMAKah8nfri
         p66f0Nqqyb4v0l4v+r1q7uTuDTZij81VAvwIiwgqeG280+UTiohhLakX5684GNT0y4w1
         Po8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701805170; x=1702409970;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xfq67iLmriDqfduTRY0M8dju8QhNwul2zcs5mKn+Qdk=;
        b=do6A7BtjDGstYy85PuaFxkXAKhDsmKQYhuSvvbXdbgJUXxlua8lConwnS/1OyTwD1R
         /GzBwSOVwtkxL4AM+fPa/2Fih4tGYbAAkApv1rCKzonRP2LPVSvC54k/xN3oakJuCtkz
         xZ16yySOkwRvYvHGqdvIxzs0LneCccC/lVKn2Z/92iEKh+RctjcPEebySc8hof5yyaZx
         7qe7h5PAahyMO5ogrLgATz5Tg/oRZ2/1DNsv4U7Usua+O2/XLxGfu3ipc8U9SLO7or0k
         f8+ccg/mYAt5WTDuiwRhuyBF3Tb2t7UrOV1SL+PRv4x7784cnerRElBOcvSDRwlnQ4r1
         vfWA==
X-Gm-Message-State: AOJu0YwnWvCEZMGZplyY7QcRJJ4Dsi0oS2rDXNGR1057NUKvoTs2m66y
	2hTIG9+45aGs3BWFha/sZjog5r8=
X-Google-Smtp-Source: AGHT+IFIztxj2eUKXZ2GS1Ca6Xtk1G+ZaZVM3GaQJJGqcaBfxYyvfWdWIYuJqHVvsmWQlJgRFVSGrCQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:1220:0:b0:5c2:2f9:c374 with SMTP id
 h32-20020a631220000000b005c202f9c374mr4433763pgl.9.1701805169961; Tue, 05 Dec
 2023 11:39:29 -0800 (PST)
Date: Tue, 5 Dec 2023 11:39:28 -0800
In-Reply-To: <656f66023f7bd_3dd6422942a@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231203165129.1740512-1-yoong.siang.song@intel.com>
 <20231203165129.1740512-3-yoong.siang.song@intel.com> <43b01013-e78b-417e-b169-91909c7309b1@kernel.org>
 <656de830e8d70_2e983e294ca@willemb.c.googlers.com.notmuch>
 <PH0PR11MB583000826591093B98BA841DD885A@PH0PR11MB5830.namprd11.prod.outlook.com>
 <5a0faf8cc9ec3ab0d5082c66b909c582c8f1eae6.camel@siemens.com>
 <CAKH8qBuXL8bOYtfKKPS8y=KJqouDptyciCjr0wNKVHtNj6BmqA@mail.gmail.com> <656f66023f7bd_3dd6422942a@willemb.c.googlers.com.notmuch>
Message-ID: <ZW98UW033wCy9vI-@google.com>
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v3 2/3] net: stmmac: add Launch
 Time support to XDP ZC
From: Stanislav Fomichev <sdf@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, yoong.siang.song@intel.com, 
	Jesper Dangaard Brouer <hawk@kernel.org>, davem@davemloft.net, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Bjorn Topel <bjorn@kernel.org>, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	Jonathan Lemon <jonathan.lemon@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Willem de Bruijn <willemb@google.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 12/05, Willem de Bruijn wrote:
> Stanislav Fomichev wrote:
> > On Tue, Dec 5, 2023 at 7:34=E2=80=AFAM Florian Bezdeka
> > <florian.bezdeka@siemens.com> wrote:
> > >
> > > On Tue, 2023-12-05 at 15:25 +0000, Song, Yoong Siang wrote:
> > > > On Monday, December 4, 2023 10:55 PM, Willem de Bruijn wrote:
> > > > > Jesper Dangaard Brouer wrote:
> > > > > >
> > > > > >
> > > > > > On 12/3/23 17:51, Song Yoong Siang wrote:
> > > > > > > This patch enables Launch Time (Time-Based Scheduling) suppor=
t to XDP zero
> > > > > > > copy via XDP Tx metadata framework.
> > > > > > >
> > > > > > > Signed-off-by: Song Yoong Siang<yoong.siang.song@intel.com>
> > > > > > > ---
> > > > > > >   drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
> > > > > >
> > > > > > As requested before, I think we need to see another driver impl=
ementing
> > > > > > this.
> > > > > >
> > > > > > I propose driver igc and chip i225.
> > > >
> > > > Sure. I will include igc patches in next version.
> > > >
> > > > > >
> > > > > > The interesting thing for me is to see how the LaunchTime max 1=
 second
> > > > > > into the future[1] is handled code wise. One suggestion is to a=
dd a
> > > > > > section to Documentation/networking/xsk-tx-metadata.rst per dri=
ver that
> > > > > > mentions/documents these different hardware limitations.  It is=
 natural
> > > > > > that different types of hardware have limitations.  This is a c=
lose-to
> > > > > > hardware-level abstraction/API, and IMHO as long as we document=
 the
> > > > > > limitations we can expose this API without too many limitations=
 for more
> > > > > > capable hardware.
> > > >
> > > > Sure. I will try to add hardware limitations in documentation.
> > > >
> > > > >
> > > > > I would assume that the kfunc will fail when a value is passed th=
at
> > > > > cannot be programmed.
> > > > >
> > > >
> > > > In current design, the xsk_tx_metadata_request() dint got return va=
lue.
> > > > So user won't know if their request is fail.
> > > > It is complex to inform user which request is failing.
> > > > Therefore, IMHO, it is good that we let driver handle the error sil=
ently.
> > > >
> > >
> > > If the programmed value is invalid, the packet will be "dropped" / wi=
ll
> > > never make it to the wire, right?
>=20
> Programmable behavior is to either drop or cap to some boundary
> value, such as the farthest programmable time in the future: the
> horizon. In fq:
>=20
>                 /* Check if packet timestamp is too far in the future. */
>                 if (fq_packet_beyond_horizon(skb, q, now)) {
>                         if (q->horizon_drop) {
>                                         q->stat_horizon_drops++;
>                                         return qdisc_drop(skb, sch, to_fr=
ee);
>                         }
>                         q->stat_horizon_caps++;
>                         skb->tstamp =3D now + q->horizon;
>                 }
>                 fq_skb_cb(skb)->time_to_send =3D skb->tstamp;
>=20
> Drop is the more obviously correct mode.
>=20
> Programming with a clock source that the driver does not support will
> then be a persistent failure.
>=20
> Preferably, this driver capability can be queried beforehand (rather
> than only through reading error counters afterwards).
>=20
> Perhaps it should not be a driver task to convert from possibly
> multiple clock sources to the device native clock. Right now, we do
> use per-device timecounters for this, implemented in the driver.
>=20
> As for which clocks are relevant. For PTP, I suppose the device PHC,
> converted to nsec. For pacing offload, TCP uses CLOCK_MONOTONIC.

Do we need to expose some generic netdev netlink apis to query/adjust
nic clock sources (or maybe there is something existing already)?
Then the userspace can be responsible for syncing/converting the
timestamps to the internal nic clocks. +1 to trying to avoid doing
this in the drivers.

> > > That is clearly a situation that the user should be informed about. F=
or
> > > RT systems this normally means that something is really wrong regardi=
ng
> > > timing / cycle overflow. Such systems have to react on that situation=
.
> >=20
> > In general, af_xdp is a bit lacking in this 'notify the user that they
> > somehow messed up' area :-(
> > For example, pushing a tx descriptor with a wrong addr/len in zc mode
> > will not give any visible signal back (besides driver potentially
> > spilling something into dmesg as it was in the mlx case).
> > We can probably start with having some counters for these events?
>=20
> This is because the AF_XDP completion queue descriptor format is only
> a u64 address?

Yeah. XDP_COPY mode has the descriptor validation which is exported via
recvmsg errno, but zerocopy path seems to be too deep in the stack
to report something back. And there is no place, as you mention,
in the completion ring to report the status.

> Could error conditions be reported on tx completion in the metadata,
> using xsk_tx_metadata_complete?

That would be one way to do it, yes. But then the error reporting depends
on the metadata opt-in. Having a separate ring to export the errors,
or having a v2 tx-completions layout with extra 'status' field would also
work.

But this seems like something that should be handled separately? Because
we'd have to teach all existing zc drivers to report those errors back
instead of dropping these descriptors..

