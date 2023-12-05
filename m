Return-Path: <linux-kselftest+bounces-1212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FE8805EFB
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 21:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D167E1F21704
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 20:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472986ABBD;
	Tue,  5 Dec 2023 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+IDm2dA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363C7183;
	Tue,  5 Dec 2023 12:01:49 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77f0b8abd3aso136382585a.1;
        Tue, 05 Dec 2023 12:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701806508; x=1702411308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57/0OhXNeSQH9MeOrdfridw7DT7/gjMEM3JF3mFlNJc=;
        b=b+IDm2dAEuyAIKdNQLsbAC6ZrsT0uBv/WqhiqiZ7TOuvDBcmwrpY4dlROlbBuMIMKk
         o4Q3IfKrWKRCWRdK/4DaY69/wnVQi1iCNeORaRcqBNXj5Pz7qGlaoBpfXFm6f+hyLrhQ
         Dhy/8vuaOJMTud0Jf/OzABOpd6235AAutMJSu92LnlT3IQw1dR8Y104Ntu02qPQhXSLm
         sm8GHVBRvx5QpjKOxWK7Qy1HeFDZRH8JfVG3BeaPsjAifDWhr3iL0JMbfKonDTs5chrt
         Rfuy8Tn/p+uvOcYqsYIX+IH5PNk0hVf/EaTpgV6kuPaSvQ21SPpvXRybUYKTLlHKzxY6
         wARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701806508; x=1702411308;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=57/0OhXNeSQH9MeOrdfridw7DT7/gjMEM3JF3mFlNJc=;
        b=BKFhev7KGUXDtzvI4BI2D497ZGqh8V/h3K9xcymmttalbBlPIHJz1JJYtyUedpVzE5
         TeIBMsciQECYDXmwejr5H+uLawhBS81UG924oWZJFURSYOhmjdU8OhdMCGNpz3KVh0Ge
         2t5Py2Hh5P0M7sQS1oGZV01CaVcmmdiEbSsrJnwaCDLGXOD3aQyCAUgPc/s0CzzmunBo
         p0j5tpJDnSlTMAZi1MU59lJMo3qXKHX0maQpx68luAGAkCxTdAdrAGd1og6CfbCKGHJ0
         iZfXaOfrQ3ODmneFaN9khZzx4CB1jwbEzXxz4vf5mmT4+ayV7NRx+VD6slv1FLFgqD4J
         BJzQ==
X-Gm-Message-State: AOJu0YwW/z6HfaRoLM0cMbItzX3TLAo2tjvABs6dVHWDgp0Pv1AvOTFV
	tMLKH9b/NJQ56eEWeSWPCQw=
X-Google-Smtp-Source: AGHT+IHPJi2LHTZ5kQ7UCzMYZnsbaKN6UHzf0dQ/epfmYxKwG30UraQugSMbGBuSqNfNoCTEbhSZPA==
X-Received: by 2002:a05:620a:5372:b0:77d:cf48:9358 with SMTP id op50-20020a05620a537200b0077dcf489358mr1535978qkn.9.1701806508231;
        Tue, 05 Dec 2023 12:01:48 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id qj4-20020a05620a880400b0077589913a8bsm5267291qkn.132.2023.12.05.12.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 12:01:47 -0800 (PST)
Date: Tue, 05 Dec 2023 15:01:47 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <sdf@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 yoong.siang.song@intel.com, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 davem@davemloft.net, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Bjorn Topel <bjorn@kernel.org>, 
 magnus.karlsson@intel.com, 
 maciej.fijalkowski@intel.com, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>, 
 "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Message-ID: <656f81abaeee7_3f5f95294ef@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZW98UW033wCy9vI-@google.com>
References: <20231203165129.1740512-1-yoong.siang.song@intel.com>
 <20231203165129.1740512-3-yoong.siang.song@intel.com>
 <43b01013-e78b-417e-b169-91909c7309b1@kernel.org>
 <656de830e8d70_2e983e294ca@willemb.c.googlers.com.notmuch>
 <PH0PR11MB583000826591093B98BA841DD885A@PH0PR11MB5830.namprd11.prod.outlook.com>
 <5a0faf8cc9ec3ab0d5082c66b909c582c8f1eae6.camel@siemens.com>
 <CAKH8qBuXL8bOYtfKKPS8y=KJqouDptyciCjr0wNKVHtNj6BmqA@mail.gmail.com>
 <656f66023f7bd_3dd6422942a@willemb.c.googlers.com.notmuch>
 <ZW98UW033wCy9vI-@google.com>
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v3 2/3] net: stmmac: add Launch
 Time support to XDP ZC
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev wrote:
> On 12/05, Willem de Bruijn wrote:
> > Stanislav Fomichev wrote:
> > > On Tue, Dec 5, 2023 at 7:34=E2=80=AFAM Florian Bezdeka
> > > <florian.bezdeka@siemens.com> wrote:
> > > >
> > > > On Tue, 2023-12-05 at 15:25 +0000, Song, Yoong Siang wrote:
> > > > > On Monday, December 4, 2023 10:55 PM, Willem de Bruijn wrote:
> > > > > > Jesper Dangaard Brouer wrote:
> > > > > > >
> > > > > > >
> > > > > > > On 12/3/23 17:51, Song Yoong Siang wrote:
> > > > > > > > This patch enables Launch Time (Time-Based Scheduling) su=
pport to XDP zero
> > > > > > > > copy via XDP Tx metadata framework.
> > > > > > > >
> > > > > > > > Signed-off-by: Song Yoong Siang<yoong.siang.song@intel.co=
m>
> > > > > > > > ---
> > > > > > > >   drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 =
++
> > > > > > >
> > > > > > > As requested before, I think we need to see another driver =
implementing
> > > > > > > this.
> > > > > > >
> > > > > > > I propose driver igc and chip i225.
> > > > >
> > > > > Sure. I will include igc patches in next version.
> > > > >
> > > > > > >
> > > > > > > The interesting thing for me is to see how the LaunchTime m=
ax 1 second
> > > > > > > into the future[1] is handled code wise. One suggestion is =
to add a
> > > > > > > section to Documentation/networking/xsk-tx-metadata.rst per=
 driver that
> > > > > > > mentions/documents these different hardware limitations.  I=
t is natural
> > > > > > > that different types of hardware have limitations.  This is=
 a close-to
> > > > > > > hardware-level abstraction/API, and IMHO as long as we docu=
ment the
> > > > > > > limitations we can expose this API without too many limitat=
ions for more
> > > > > > > capable hardware.
> > > > >
> > > > > Sure. I will try to add hardware limitations in documentation.
> > > > >
> > > > > >
> > > > > > I would assume that the kfunc will fail when a value is passe=
d that
> > > > > > cannot be programmed.
> > > > > >
> > > > >
> > > > > In current design, the xsk_tx_metadata_request() dint got retur=
n value.
> > > > > So user won't know if their request is fail.
> > > > > It is complex to inform user which request is failing.
> > > > > Therefore, IMHO, it is good that we let driver handle the error=
 silently.
> > > > >
> > > >
> > > > If the programmed value is invalid, the packet will be "dropped" =
/ will
> > > > never make it to the wire, right?
> > =

> > Programmable behavior is to either drop or cap to some boundary
> > value, such as the farthest programmable time in the future: the
> > horizon. In fq:
> > =

> >                 /* Check if packet timestamp is too far in the future=
. */
> >                 if (fq_packet_beyond_horizon(skb, q, now)) {
> >                         if (q->horizon_drop) {
> >                                         q->stat_horizon_drops++;
> >                                         return qdisc_drop(skb, sch, t=
o_free);
> >                         }
> >                         q->stat_horizon_caps++;
> >                         skb->tstamp =3D now + q->horizon;
> >                 }
> >                 fq_skb_cb(skb)->time_to_send =3D skb->tstamp;
> > =

> > Drop is the more obviously correct mode.
> > =

> > Programming with a clock source that the driver does not support will=

> > then be a persistent failure.
> > =

> > Preferably, this driver capability can be queried beforehand (rather
> > than only through reading error counters afterwards).
> > =

> > Perhaps it should not be a driver task to convert from possibly
> > multiple clock sources to the device native clock. Right now, we do
> > use per-device timecounters for this, implemented in the driver.
> > =

> > As for which clocks are relevant. For PTP, I suppose the device PHC,
> > converted to nsec. For pacing offload, TCP uses CLOCK_MONOTONIC.
> =

> Do we need to expose some generic netdev netlink apis to query/adjust
> nic clock sources (or maybe there is something existing already)?
> Then the userspace can be responsible for syncing/converting the
> timestamps to the internal nic clocks. +1 to trying to avoid doing
> this in the drivers.

Perhaps. I'm just a bit hesitant since that is UAPI and this is all
quite hand-wavy still.

Some of the conversion necessarily has to be in the driver. Only the
driver knows the descriptor format, and limitations of that, such as
the bit-width that can be encoded.

If we cannot move anything out of the drivers (quite likely), then
agreed that a netdev/ethtool netlink query approach is helpful.

To be clear: I don't mean that that should be part of this series.
This is not an XSK specific concern.

> > > > That is clearly a situation that the user should be informed abou=
t. For
> > > > RT systems this normally means that something is really wrong reg=
arding
> > > > timing / cycle overflow. Such systems have to react on that situa=
tion.
> > > =

> > > In general, af_xdp is a bit lacking in this 'notify the user that t=
hey
> > > somehow messed up' area :-(
> > > For example, pushing a tx descriptor with a wrong addr/len in zc mo=
de
> > > will not give any visible signal back (besides driver potentially
> > > spilling something into dmesg as it was in the mlx case).
> > > We can probably start with having some counters for these events?
> > =

> > This is because the AF_XDP completion queue descriptor format is only=

> > a u64 address?
> =

> Yeah. XDP_COPY mode has the descriptor validation which is exported via=

> recvmsg errno, but zerocopy path seems to be too deep in the stack
> to report something back. And there is no place, as you mention,
> in the completion ring to report the status.
> =

> > Could error conditions be reported on tx completion in the metadata,
> > using xsk_tx_metadata_complete?
> =

> That would be one way to do it, yes. But then the error reporting depen=
ds
> on the metadata opt-in. Having a separate ring to export the errors,
> or having a v2 tx-completions layout with extra 'status' field would al=
so
> work.
> =

> But this seems like something that should be handled separately? Becaus=
e
> we'd have to teach all existing zc drivers to report those errors back
> instead of dropping these descriptors..

Agreed on both points :) A v2 tx-completions that supports status
could be useful. But again, this is out of scope of this specific
launch time feature.

