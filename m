Return-Path: <linux-kselftest+bounces-1253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9B9806B46
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 11:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD471C209DC
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 10:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E38628DA9;
	Wed,  6 Dec 2023 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEKwbpRS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C83FA;
	Wed,  6 Dec 2023 02:07:09 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-58d9a0ead0cso919624eaf.0;
        Wed, 06 Dec 2023 02:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701857228; x=1702462028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/vlq7pt9AeGEnRub01NvFpgsDNby2jk6O8E2xtdj9s=;
        b=SEKwbpRSt7+tHgwJpeZOsx36bBSW/nxilQiycK8FTEA1n7rr8NL6g/njLzuQHinLlJ
         iQ5onXqgo5uU5FhNue3HfUU4mzR+e7v/Qh5ssmbGi/iqtZu5ti2lvjcFjybFX9QVRnB9
         l2IIIgfSJg0ZMToW5b+jDFgtB+ikGim+Chqv+5i4T+uHgixrimQLYPSsl+mUUmxF1qzW
         m5X9e5ik/kWsx4xZtXpNLVSsxP50YR7AEsIHjaUJpZqEf527iuXWwZha0gDachs9fpUi
         nqAbvTjCOIgHtJwXUyizPtzUrXr4i9J5sNXreE0f1H+ZWvEGbKBAFEe84lKitqN2b93E
         k5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857228; x=1702462028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/vlq7pt9AeGEnRub01NvFpgsDNby2jk6O8E2xtdj9s=;
        b=XnWg1AD2n4VGpWXkOCogzZBUkJcNtiZ/8wzZznCX0gUwAaPkTy7iIwO4SmaNMVrytK
         3n4DdVFurAa3gNIVJGVAB69gx0ULZ6Ju+u//kBh1nzycrVEqRQghjNNKDnVrgaTeySHy
         EIBxz9BocnS8nylpgL/0ceVi5LnJwzEH7B09+F0FlmGRJc/8VyZ5q3BpfmTg8i3X5CYx
         uG2EzBBYWQrusnyNnH0EXvSu1ksSNiwHKvkuxhM6IBTyt61ypk1JUFxoGZhxtKns7Z+k
         0DM2XE/fng0xfWsUK1l/wy/zwPKuAzazIsunCrIy/9T5ifGvPR0YwuOp/lVgh9BBCCs9
         xZCQ==
X-Gm-Message-State: AOJu0YyOuVPy3fpD5wneCqY+UHgnZGnfDMOyonyojbRJhBobavbRVpXl
	W7K6U9LcCY92gsMngXrE20UrWbh/Xf48UO4T20o=
X-Google-Smtp-Source: AGHT+IFM6+SkktBbli78RNGNd8KWWCUqf7S2N+h7frD1ZfTKF9ggdkQwqOjS+jWDA8naLrSe5Bcn1Lp1etLJdeyYiUI=
X-Received: by 2002:a05:6830:39de:b0:6d9:b049:7e9b with SMTP id
 bt30-20020a05683039de00b006d9b0497e9bmr1160555otb.3.1701857228489; Wed, 06
 Dec 2023 02:07:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231203165129.1740512-1-yoong.siang.song@intel.com>
 <20231203165129.1740512-3-yoong.siang.song@intel.com> <43b01013-e78b-417e-b169-91909c7309b1@kernel.org>
 <656de830e8d70_2e983e294ca@willemb.c.googlers.com.notmuch>
 <PH0PR11MB583000826591093B98BA841DD885A@PH0PR11MB5830.namprd11.prod.outlook.com>
 <5a0faf8cc9ec3ab0d5082c66b909c582c8f1eae6.camel@siemens.com>
 <CAKH8qBuXL8bOYtfKKPS8y=KJqouDptyciCjr0wNKVHtNj6BmqA@mail.gmail.com>
 <656f66023f7bd_3dd6422942a@willemb.c.googlers.com.notmuch> <ZW98UW033wCy9vI-@google.com>
In-Reply-To: <ZW98UW033wCy9vI-@google.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 6 Dec 2023 11:06:57 +0100
Message-ID: <CAJ8uoz3_XqavGt1DyFoQAuKS8Faa1Lc85b2t+whc-f6GN1Pvzw@mail.gmail.com>
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v3 2/3] net: stmmac: add Launch
 Time support to XDP ZC
To: Stanislav Fomichev <sdf@google.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Dec 2023 at 20:39, Stanislav Fomichev <sdf@google.com> wrote:
>
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
> > > > > > > > This patch enables Launch Time (Time-Based Scheduling) supp=
ort to XDP zero
> > > > > > > > copy via XDP Tx metadata framework.
> > > > > > > >
> > > > > > > > Signed-off-by: Song Yoong Siang<yoong.siang.song@intel.com>
> > > > > > > > ---
> > > > > > > >   drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
> > > > > > >
> > > > > > > As requested before, I think we need to see another driver im=
plementing
> > > > > > > this.
> > > > > > >
> > > > > > > I propose driver igc and chip i225.
> > > > >
> > > > > Sure. I will include igc patches in next version.
> > > > >
> > > > > > >
> > > > > > > The interesting thing for me is to see how the LaunchTime max=
 1 second
> > > > > > > into the future[1] is handled code wise. One suggestion is to=
 add a
> > > > > > > section to Documentation/networking/xsk-tx-metadata.rst per d=
river that
> > > > > > > mentions/documents these different hardware limitations.  It =
is natural
> > > > > > > that different types of hardware have limitations.  This is a=
 close-to
> > > > > > > hardware-level abstraction/API, and IMHO as long as we docume=
nt the
> > > > > > > limitations we can expose this API without too many limitatio=
ns for more
> > > > > > > capable hardware.
> > > > >
> > > > > Sure. I will try to add hardware limitations in documentation.
> > > > >
> > > > > >
> > > > > > I would assume that the kfunc will fail when a value is passed =
that
> > > > > > cannot be programmed.
> > > > > >
> > > > >
> > > > > In current design, the xsk_tx_metadata_request() dint got return =
value.
> > > > > So user won't know if their request is fail.
> > > > > It is complex to inform user which request is failing.
> > > > > Therefore, IMHO, it is good that we let driver handle the error s=
ilently.
> > > > >
> > > >
> > > > If the programmed value is invalid, the packet will be "dropped" / =
will
> > > > never make it to the wire, right?
> >
> > Programmable behavior is to either drop or cap to some boundary
> > value, such as the farthest programmable time in the future: the
> > horizon. In fq:
> >
> >                 /* Check if packet timestamp is too far in the future. =
*/
> >                 if (fq_packet_beyond_horizon(skb, q, now)) {
> >                         if (q->horizon_drop) {
> >                                         q->stat_horizon_drops++;
> >                                         return qdisc_drop(skb, sch, to_=
free);
> >                         }
> >                         q->stat_horizon_caps++;
> >                         skb->tstamp =3D now + q->horizon;
> >                 }
> >                 fq_skb_cb(skb)->time_to_send =3D skb->tstamp;
> >
> > Drop is the more obviously correct mode.
> >
> > Programming with a clock source that the driver does not support will
> > then be a persistent failure.
> >
> > Preferably, this driver capability can be queried beforehand (rather
> > than only through reading error counters afterwards).
> >
> > Perhaps it should not be a driver task to convert from possibly
> > multiple clock sources to the device native clock. Right now, we do
> > use per-device timecounters for this, implemented in the driver.
> >
> > As for which clocks are relevant. For PTP, I suppose the device PHC,
> > converted to nsec. For pacing offload, TCP uses CLOCK_MONOTONIC.
>
> Do we need to expose some generic netdev netlink apis to query/adjust
> nic clock sources (or maybe there is something existing already)?
> Then the userspace can be responsible for syncing/converting the
> timestamps to the internal nic clocks. +1 to trying to avoid doing
> this in the drivers.
>
> > > > That is clearly a situation that the user should be informed about.=
 For
> > > > RT systems this normally means that something is really wrong regar=
ding
> > > > timing / cycle overflow. Such systems have to react on that situati=
on.
> > >
> > > In general, af_xdp is a bit lacking in this 'notify the user that the=
y
> > > somehow messed up' area :-(
> > > For example, pushing a tx descriptor with a wrong addr/len in zc mode
> > > will not give any visible signal back (besides driver potentially
> > > spilling something into dmesg as it was in the mlx case).
> > > We can probably start with having some counters for these events?
> >
> > This is because the AF_XDP completion queue descriptor format is only
> > a u64 address?
>
> Yeah. XDP_COPY mode has the descriptor validation which is exported via
> recvmsg errno, but zerocopy path seems to be too deep in the stack
> to report something back. And there is no place, as you mention,
> in the completion ring to report the status.
>
> > Could error conditions be reported on tx completion in the metadata,
> > using xsk_tx_metadata_complete?
>
> That would be one way to do it, yes. But then the error reporting depends
> on the metadata opt-in. Having a separate ring to export the errors,
> or having a v2 tx-completions layout with extra 'status' field would also
> work.

There are error counters for the non-metadata and offloading cases
above that can be retrieved with the XDP_STATISTICS getsockopt(). From
if_xdp.h:

struct xdp_statistics {
        __u64 rx_dropped; /* Dropped for other reasons */
        __u64 rx_invalid_descs; /* Dropped due to invalid descriptor */
        __u64 tx_invalid_descs; /* Dropped due to invalid descriptor */
        __u64 rx_ring_full; /* Dropped due to rx ring being full */
        __u64 rx_fill_ring_empty_descs; /* Failed to retrieve item
from fill ring */
        __u64 tx_ring_empty_descs; /* Failed to retrieve item from tx ring =
*/
};

Albeit, these are aggregate statistics and do not say anything about
which packet that caused it. Works well for things that are
programming bugs that should not occur (such as rx_invalid_descs and
tx_invalid_descs) and requires the programmer to debug and fix his or
her program, but it does not work for requests that might fail even
though the program is correct and need to be handled on a packet by
packet basis. So something needs to be added for that as you both say.

Would prefer if we could avoid a v2 completion descriptor format or
another ring that needs to be checked all the time, so if we could
live with providing the error status in the metadata field of the
packet at completion time, that would be good. Though having the error
status in the completion ring would be faster as that cache line is
hot, while the metadata section of the packet is likely not at
completion time. So that speaks for a v2 completion ring format. Just
thinking out loud here.

> But this seems like something that should be handled separately? Because
> we'd have to teach all existing zc drivers to report those errors back
> instead of dropping these descriptors..
>

