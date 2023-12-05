Return-Path: <linux-kselftest+bounces-1148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B73828058D9
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA9EB210E0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4369E5F1EF;
	Tue,  5 Dec 2023 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="J+8+bbFX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54BFBF
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 07:34:35 -0800 (PST)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202312051534324fbf276ea830ab68dc
        for <linux-kselftest@vger.kernel.org>;
        Tue, 05 Dec 2023 16:34:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QLrrt7aQd3uFEGTkO/x97Sh3we90ObbwSexb6iVGv7A=;
 b=J+8+bbFXw8iqevTZ/1LFxb77bPK9BAi2TmeskopxbHBkn5POqgmVNCOYGcqwEep7uOPJpl
 zj+FDvGwqPNeHsljWo0kiWzfDFu9PDhQN6eGhzaJB7XFPDStPDo9SmhEyvxSfz3Nw8ezFswW
 bfVo1XvFDjaGtWxsO3vjq4Ss0mo2w=;
Message-ID: <5a0faf8cc9ec3ab0d5082c66b909c582c8f1eae6.camel@siemens.com>
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v3 2/3] net: stmmac: add Launch
 Time support to XDP ZC
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Bjorn Topel
 <bjorn@kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>,
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Willem de Bruijn <willemb@google.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose
 Abreu <joabreu@synopsys.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	 <linux-doc@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"xdp-hints@xdp-project.net"
	 <xdp-hints@xdp-project.net>, "linux-stm32@st-md-mailman.stormreply.com"
	 <linux-stm32@st-md-mailman.stormreply.com>, 
	"linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	 <linux-kselftest@vger.kernel.org>
Date: Tue, 05 Dec 2023 16:34:29 +0100
In-Reply-To: <PH0PR11MB583000826591093B98BA841DD885A@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20231203165129.1740512-1-yoong.siang.song@intel.com>
	 <20231203165129.1740512-3-yoong.siang.song@intel.com>
	 <43b01013-e78b-417e-b169-91909c7309b1@kernel.org>
	 <656de830e8d70_2e983e294ca@willemb.c.googlers.com.notmuch>
	 <PH0PR11MB583000826591093B98BA841DD885A@PH0PR11MB5830.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2023-12-05 at 15:25 +0000, Song, Yoong Siang wrote:
> On Monday, December 4, 2023 10:55 PM, Willem de Bruijn wrote:
> > Jesper Dangaard Brouer wrote:
> > >=20
> > >=20
> > > On 12/3/23 17:51, Song Yoong Siang wrote:
> > > > This patch enables Launch Time (Time-Based Scheduling) support to X=
DP zero
> > > > copy via XDP Tx metadata framework.
> > > >=20
> > > > Signed-off-by: Song Yoong Siang<yoong.siang.song@intel.com>
> > > > ---
> > > >   drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
> > >=20
> > > As requested before, I think we need to see another driver implementi=
ng
> > > this.
> > >=20
> > > I propose driver igc and chip i225.
>=20
> Sure. I will include igc patches in next version.
>=20
> > >=20
> > > The interesting thing for me is to see how the LaunchTime max 1 secon=
d
> > > into the future[1] is handled code wise. One suggestion is to add a
> > > section to Documentation/networking/xsk-tx-metadata.rst per driver th=
at
> > > mentions/documents these different hardware limitations.  It is natur=
al
> > > that different types of hardware have limitations.  This is a close-t=
o
> > > hardware-level abstraction/API, and IMHO as long as we document the
> > > limitations we can expose this API without too many limitations for m=
ore
> > > capable hardware.
>=20
> Sure. I will try to add hardware limitations in documentation.=20
>=20
> >=20
> > I would assume that the kfunc will fail when a value is passed that
> > cannot be programmed.
> >=20
>=20
> In current design, the xsk_tx_metadata_request() dint got return value.=
=20
> So user won't know if their request is fail.=20
> It is complex to inform user which request is failing.=20
> Therefore, IMHO, it is good that we let driver handle the error silently.
>=20

If the programmed value is invalid, the packet will be "dropped" / will
never make it to the wire, right?

That is clearly a situation that the user should be informed about. For
RT systems this normally means that something is really wrong regarding
timing / cycle overflow. Such systems have to react on that situation.

> =20
>=20
> > What is being implemented here already exists for qdiscs. The FQ
> > qdisc takes a horizon attribute and
> >=20
> >    "
> >    when a packet is beyond the horizon
> >        at enqueue() time:
> >        - either drop the packet (default policy)
> >        - or cap its delivery time to the horizon.
> >    "
> >    commit 39d010504e6b ("net_sched: sch_fq: add horizon attribute")
> >=20
> > Having the admin manually configure this on the qdisc based on
> > off-line knowledge of the device is more fragile than if the device
> > would somehow signal its limit to the stack.
> >=20
> > But I don't think we should add enforcement of that as a requirement
> > for this xdp extension of pacing.


