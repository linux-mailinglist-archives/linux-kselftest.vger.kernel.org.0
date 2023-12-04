Return-Path: <linux-kselftest+bounces-1045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ABF8031C9
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 12:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D890F1F20F73
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 11:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74E122F10;
	Mon,  4 Dec 2023 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ph2h0h5j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77F3D5
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Dec 2023 03:55:02 -0800 (PST)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20231204115459d826aad05f6a119b77
        for <linux-kselftest@vger.kernel.org>;
        Mon, 04 Dec 2023 12:55:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DeAVJVh1/dmfA7n8KCr9e65gohS5SL4YYZz1yRamMmo=;
 b=ph2h0h5jvGxuWKVsNS0TMd+fNjmiTxwfMkny+Ro6YD2+HKnOLi/CClvCRs5tLNpmSk0jh2
 b2Xas1pUz9iB6dBJVNhJnkJ3JLnWbdX0OqFTVBA38AMksw93F1/n2DVd92g1cldYwMwE1iYt
 KYrV+sFm2RBFyevOjoDdSCwH2EABY=;
Message-ID: <8602c88c98fd722db8e164a1520c56aebfa64db7.camel@siemens.com>
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v3 2/3] net: stmmac: add Launch
 Time support to XDP ZC
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Song Yoong Siang
 <yoong.siang.song@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Bjorn Topel
 <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, bpf@vger.kernel.org, xdp-hints@xdp-project.net, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-kselftest@vger.kernel.org
Date: Mon, 04 Dec 2023 12:54:56 +0100
In-Reply-To: <43b01013-e78b-417e-b169-91909c7309b1@kernel.org>
References: <20231203165129.1740512-1-yoong.siang.song@intel.com>
	 <20231203165129.1740512-3-yoong.siang.song@intel.com>
	 <43b01013-e78b-417e-b169-91909c7309b1@kernel.org>
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

On Mon, 2023-12-04 at 11:36 +0100, Jesper Dangaard Brouer wrote:
> On 12/3/23 17:51, Song Yoong Siang wrote:
> > This patch enables Launch Time (Time-Based Scheduling) support to XDP z=
ero
> > copy via XDP Tx metadata framework.
> >=20
> > Signed-off-by: Song Yoong Siang<yoong.siang.song@intel.com>
> > ---
> >   drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
>=20
> As requested before, I think we need to see another driver implementing=
=20
> this.
>=20
> I propose driver igc and chip i225.

igc support would be really nice and highly appreciated. There are a
lot of tests running here with that chip (i225/i226) / driver (igc)
combination. Let me know if we can support somehow, testing included.

>=20
> The interesting thing for me is to see how the LaunchTime max 1 second
> into the future[1] is handled code wise. One suggestion is to add a=20
> section to Documentation/networking/xsk-tx-metadata.rst per driver that=
=20
> mentions/documents these different hardware limitations.  It is natural=
=20
> that different types of hardware have limitations.  This is a close-to=
=20
> hardware-level abstraction/API, and IMHO as long as we document the=20
> limitations we can expose this API without too many limitations for more=
=20
> capable hardware.
>=20
>   [1]=20
> https://github.com/xdp-project/xdp-project/blob/master/areas/tsn/code01_f=
ollow_qdisc_TSN_offload.org#setup-code-driver-igb
>=20
> This stmmac driver and Intel Tiger Lake CPU must also have some limit on=
=20
> how long into the future it will/can schedule packets?
>=20
>=20
> People from xdp-hints list must make their voice hear if they want i210=
=20
> and igb driver support, because it have even-more hardware limitations,=
=20
> see [1] (E.g. only TX queue 0 and 1 supports LaunchTime). BUT I know=20
> some have this hardware in production and might be motivated to get a=20
> functioning driver with this feature?

i210 support would be nice, that would allow us to compare some test
setups with different NICs. In addition it would simplify some test
setups. For now, IMHO igc is more important.

>=20
> --Jesper


