Return-Path: <linux-kselftest+bounces-1317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F633807859
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 20:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1AA71C20E23
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5C649F8E;
	Wed,  6 Dec 2023 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a/b5xmrK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CADAD40
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 11:06:08 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5be10675134so57224a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 11:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701889567; x=1702494367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I409PBeV0vI0BSi/sNEko+BMZt4s00+VHGZ9Cxi/uGs=;
        b=a/b5xmrKgk/7uyzJAxjbIr2Xb7wyTKzTfLsjFb6oWW05EP6YlIjaNmUcBT0I1x8yq5
         TEXhXYDpVmPJELmA6eoz0fCoelVWgMttaxPwpp2tsf+r+jVlJvsoeSEE54lur5ShfBs9
         vWWXsgclEYLdYu/0MGT2L1AoCRq8ijqhLD8eQUf69H0NWlAR3WSH6EujcCYZmMaQNSsA
         RxiBPVWWa8zcJmmenYgCRNJWLyyIt8hm1H/4IR5q36cszbwoBHZzPaCwcWVv4MYTSRth
         RnwkyJJdnvKS5+Pj+G0Re10FUOBe8MuenPHZF2JltBxQGtxDUfQclF6ORuX7TPEyRPZK
         KxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701889567; x=1702494367;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I409PBeV0vI0BSi/sNEko+BMZt4s00+VHGZ9Cxi/uGs=;
        b=T+jPRH7EPg95oLrdJJ4Ery4EWKVv+oMAT6T2g1ZloCObgRMR8ghpr8mNn3cKRrMFTw
         m50HwrAUVnjbkgjt2EEo3ykceSbtEqglae96tOOXaRLQwsAjdnSSLjuqbm5JQWub6/Cb
         /XCK2pEeejDtw+7KHA2IjIDsCl6X8xcO83qJxb4J+u2bUnF0r4AQeq+iFaaNi9WmJNVb
         Y9F0swFn6+HQDAi+jyygoOIMTinjNJutdMUgCfuYHlTaz6wvNkWbylRbf66NQLW7C6LG
         AXsijh38vDTN+q3WFMg+Kh0RDcEQy5tkU8XrsWSFzkH0yj2CaTQNfoLBUe+I6FqOtD0z
         jdZA==
X-Gm-Message-State: AOJu0YxKtTzmaNV93zdiFREdaLTeN0ovVprb5SpXOETpP1+CFhdQ91GY
	c16dRWnVUTaXUkaJPVwNS+Cx2Yk=
X-Google-Smtp-Source: AGHT+IEqS0IGgMlSKmdLV1hbJusVKwZ8hKL8byL5eF/gGsSa+b+3KizaW4xrrV9KIs8i0M+jEvdFFF0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a65:67d2:0:b0:5c6:a4e5:2d6a with SMTP id
 b18-20020a6567d2000000b005c6a4e52d6amr14804pgs.7.1701889567399; Wed, 06 Dec
 2023 11:06:07 -0800 (PST)
Date: Wed, 6 Dec 2023 11:06:05 -0800
In-Reply-To: <CAJ8uoz3_XqavGt1DyFoQAuKS8Faa1Lc85b2t+whc-f6GN1Pvzw@mail.gmail.com>
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
 <CAKH8qBuXL8bOYtfKKPS8y=KJqouDptyciCjr0wNKVHtNj6BmqA@mail.gmail.com>
 <656f66023f7bd_3dd6422942a@willemb.c.googlers.com.notmuch>
 <ZW98UW033wCy9vI-@google.com> <CAJ8uoz3_XqavGt1DyFoQAuKS8Faa1Lc85b2t+whc-f6GN1Pvzw@mail.gmail.com>
Message-ID: <ZXDGHThTynXbSTJG@google.com>
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v3 2/3] net: stmmac: add Launch
 Time support to XDP ZC
From: Stanislav Fomichev <sdf@google.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Florian Bezdeka <florian.bezdeka@siemens.com>, yoong.siang.song@intel.com, 
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

On 12/06, Magnus Karlsson wrote:
> On Tue, 5 Dec 2023 at 20:39, Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On 12/05, Willem de Bruijn wrote:
> > > Stanislav Fomichev wrote:
> > > > On Tue, Dec 5, 2023 at 7:34=E2=80=AFAM Florian Bezdeka
> > > > <florian.bezdeka@siemens.com> wrote:
> > > > >
> > > > > On Tue, 2023-12-05 at 15:25 +0000, Song, Yoong Siang wrote:
> > > > > > On Monday, December 4, 2023 10:55 PM, Willem de Bruijn wrote:
> > > > > > > Jesper Dangaard Brouer wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > On 12/3/23 17:51, Song Yoong Siang wrote:
> > > > > > > > > This patch enables Launch Time (Time-Based Scheduling) su=
pport to XDP zero
> > > > > > > > > copy via XDP Tx metadata framework.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Song Yoong Siang<yoong.siang.song@intel.co=
m>
> > > > > > > > > ---
> > > > > > > > >   drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 =
++
> > > > > > > >
> > > > > > > > As requested before, I think we need to see another driver =
implementing
> > > > > > > > this.
> > > > > > > >
> > > > > > > > I propose driver igc and chip i225.
> > > > > >
> > > > > > Sure. I will include igc patches in next version.
> > > > > >
> > > > > > > >
> > > > > > > > The interesting thing for me is to see how the LaunchTime m=
ax 1 second
> > > > > > > > into the future[1] is handled code wise. One suggestion is =
to add a
> > > > > > > > section to Documentation/networking/xsk-tx-metadata.rst per=
 driver that
> > > > > > > > mentions/documents these different hardware limitations.  I=
t is natural
> > > > > > > > that different types of hardware have limitations.  This is=
 a close-to
> > > > > > > > hardware-level abstraction/API, and IMHO as long as we docu=
ment the
> > > > > > > > limitations we can expose this API without too many limitat=
ions for more
> > > > > > > > capable hardware.
> > > > > >
> > > > > > Sure. I will try to add hardware limitations in documentation.
> > > > > >
> > > > > > >
> > > > > > > I would assume that the kfunc will fail when a value is passe=
d that
> > > > > > > cannot be programmed.
> > > > > > >
> > > > > >
> > > > > > In current design, the xsk_tx_metadata_request() dint got retur=
n value.
> > > > > > So user won't know if their request is fail.
> > > > > > It is complex to inform user which request is failing.
> > > > > > Therefore, IMHO, it is good that we let driver handle the error=
 silently.
> > > > > >
> > > > >
> > > > > If the programmed value is invalid, the packet will be "dropped" =
/ will
> > > > > never make it to the wire, right?
> > >
> > > Programmable behavior is to either drop or cap to some boundary
> > > value, such as the farthest programmable time in the future: the
> > > horizon. In fq:
> > >
> > >                 /* Check if packet timestamp is too far in the future=
. */
> > >                 if (fq_packet_beyond_horizon(skb, q, now)) {
> > >                         if (q->horizon_drop) {
> > >                                         q->stat_horizon_drops++;
> > >                                         return qdisc_drop(skb, sch, t=
o_free);
> > >                         }
> > >                         q->stat_horizon_caps++;
> > >                         skb->tstamp =3D now + q->horizon;
> > >                 }
> > >                 fq_skb_cb(skb)->time_to_send =3D skb->tstamp;
> > >
> > > Drop is the more obviously correct mode.
> > >
> > > Programming with a clock source that the driver does not support will
> > > then be a persistent failure.
> > >
> > > Preferably, this driver capability can be queried beforehand (rather
> > > than only through reading error counters afterwards).
> > >
> > > Perhaps it should not be a driver task to convert from possibly
> > > multiple clock sources to the device native clock. Right now, we do
> > > use per-device timecounters for this, implemented in the driver.
> > >
> > > As for which clocks are relevant. For PTP, I suppose the device PHC,
> > > converted to nsec. For pacing offload, TCP uses CLOCK_MONOTONIC.
> >
> > Do we need to expose some generic netdev netlink apis to query/adjust
> > nic clock sources (or maybe there is something existing already)?
> > Then the userspace can be responsible for syncing/converting the
> > timestamps to the internal nic clocks. +1 to trying to avoid doing
> > this in the drivers.
> >
> > > > > That is clearly a situation that the user should be informed abou=
t. For
> > > > > RT systems this normally means that something is really wrong reg=
arding
> > > > > timing / cycle overflow. Such systems have to react on that situa=
tion.
> > > >
> > > > In general, af_xdp is a bit lacking in this 'notify the user that t=
hey
> > > > somehow messed up' area :-(
> > > > For example, pushing a tx descriptor with a wrong addr/len in zc mo=
de
> > > > will not give any visible signal back (besides driver potentially
> > > > spilling something into dmesg as it was in the mlx case).
> > > > We can probably start with having some counters for these events?
> > >
> > > This is because the AF_XDP completion queue descriptor format is only
> > > a u64 address?
> >
> > Yeah. XDP_COPY mode has the descriptor validation which is exported via
> > recvmsg errno, but zerocopy path seems to be too deep in the stack
> > to report something back. And there is no place, as you mention,
> > in the completion ring to report the status.
> >
> > > Could error conditions be reported on tx completion in the metadata,
> > > using xsk_tx_metadata_complete?
> >
> > That would be one way to do it, yes. But then the error reporting depen=
ds
> > on the metadata opt-in. Having a separate ring to export the errors,
> > or having a v2 tx-completions layout with extra 'status' field would al=
so
> > work.
>=20
> There are error counters for the non-metadata and offloading cases
> above that can be retrieved with the XDP_STATISTICS getsockopt(). From
> if_xdp.h:
>=20
> struct xdp_statistics {
>         __u64 rx_dropped; /* Dropped for other reasons */
>         __u64 rx_invalid_descs; /* Dropped due to invalid descriptor */
>         __u64 tx_invalid_descs; /* Dropped due to invalid descriptor */
>         __u64 rx_ring_full; /* Dropped due to rx ring being full */
>         __u64 rx_fill_ring_empty_descs; /* Failed to retrieve item
> from fill ring */
>         __u64 tx_ring_empty_descs; /* Failed to retrieve item from tx rin=
g */
> };
>=20
> Albeit, these are aggregate statistics and do not say anything about
> which packet that caused it. Works well for things that are
> programming bugs that should not occur (such as rx_invalid_descs and
> tx_invalid_descs) and requires the programmer to debug and fix his or
> her program, but it does not work for requests that might fail even
> though the program is correct and need to be handled on a packet by
> packet basis. So something needs to be added for that as you both say.
>=20
> Would prefer if we could avoid a v2 completion descriptor format or
> another ring that needs to be checked all the time, so if we could
> live with providing the error status in the metadata field of the
> packet at completion time, that would be good. Though having the error
> status in the completion ring would be faster as that cache line is
> hot, while the metadata section of the packet is likely not at
> completion time. So that speaks for a v2 completion ring format. Just
> thinking out loud here.

In this case, maybe adding tx_over_horizon_dropped to XDP_STATISTICS
is all we need here? We can have some new api to query this horizon
per netdev.

