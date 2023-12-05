Return-Path: <linux-kselftest+bounces-1179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F68805AF1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 18:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88AAC1C210A5
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D0C692B2;
	Tue,  5 Dec 2023 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INvWLb69"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAA01A4
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 09:13:53 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7c587a7446bso637859241.3
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Dec 2023 09:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701796432; x=1702401232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jhl4VBonzlc3pWBsupBzGj3hbqoDxmUEBnI+4/Xqy5c=;
        b=INvWLb69Nuq8+ZQA8vMqzrJ9w5J2kDoCjYvzeV4qYNUskJOa55C/hC0eZLdebuxs2K
         1EeYJVf0yzVjGvKtPKaB9z/BJud3na5s0gNmiLDWwNz7YHXU3ZVL2LHGXooY+M98nSUA
         /TS4yt/YPBvNdHjFxDjZsWmLib14zmzwegjIZaZaEulggP9KhnPnQAHhW1pFWQ1bl8b9
         k0jGi7E+XJatInlffVPWRX2796OLME6t1wGemRtJFe5gURqFJ5Br5SPwFMj4hBWtG0Na
         3y716aBWmqch5ispGWqjMBd1V1jrdEGbVT1mr5b/c5kVSqh4sGk7mt+X53fcu1aVhbOe
         vWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701796432; x=1702401232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jhl4VBonzlc3pWBsupBzGj3hbqoDxmUEBnI+4/Xqy5c=;
        b=ZYRYSyNLAFXtk+N31qbZdZo6Tw4tw+/fn8MCO4QPg9ECckHqOyO/1/a0TBYYcFnJ32
         IELf70ZkyZvHlD5PUVBjiwzNcL/vTayIW49IlD6ypQwre6t73dAxIHJNYEpXvhuH6tCD
         7GvxcD+H5AAKxBsyYept7c0ITnsL0QmHJRBhbEGkpGSNP1Y4jx1myE013GY52sDRMqdy
         YxnvnfPKq507Mn0UNC43Qi23bqoWTmHDVPDvATwH7Gvru2nXgkksRm8hji+FiSN5fCEq
         bpTT6O+8jXEQZXeCSaPX10k9PjWNHR8M25TpSsE+xtcS6wxm8voVKAPsoNLthaN1FAhK
         mhHQ==
X-Gm-Message-State: AOJu0Yyku19VhL8lWdC+/xGrCdHjTGfPUMpq0REhMlnKoYKIVWpu8obN
	14yw1OGsWTqpAygebq4RGu6AfiIuQ26YE/ejtCxPPQ==
X-Google-Smtp-Source: AGHT+IGZ2g2oFmmMcDVzmGa+ZZi/Dz9EWTryACUv6KZTkY8C1ML9of935relBOPEXVeT256piz2KyEWvu0yNMvy9fmw=
X-Received: by 2002:a1f:fc83:0:b0:4b2:7fa3:a965 with SMTP id
 a125-20020a1ffc83000000b004b27fa3a965mr4904643vki.11.1701796432618; Tue, 05
 Dec 2023 09:13:52 -0800 (PST)
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
In-Reply-To: <5a0faf8cc9ec3ab0d5082c66b909c582c8f1eae6.camel@siemens.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Tue, 5 Dec 2023 09:13:39 -0800
Message-ID: <CAKH8qBuXL8bOYtfKKPS8y=KJqouDptyciCjr0wNKVHtNj6BmqA@mail.gmail.com>
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v3 2/3] net: stmmac: add Launch
 Time support to XDP ZC
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Bjorn Topel <bjorn@kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Willem de Bruijn <willemb@google.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
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

On Tue, Dec 5, 2023 at 7:34=E2=80=AFAM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
>
> On Tue, 2023-12-05 at 15:25 +0000, Song, Yoong Siang wrote:
> > On Monday, December 4, 2023 10:55 PM, Willem de Bruijn wrote:
> > > Jesper Dangaard Brouer wrote:
> > > >
> > > >
> > > > On 12/3/23 17:51, Song Yoong Siang wrote:
> > > > > This patch enables Launch Time (Time-Based Scheduling) support to=
 XDP zero
> > > > > copy via XDP Tx metadata framework.
> > > > >
> > > > > Signed-off-by: Song Yoong Siang<yoong.siang.song@intel.com>
> > > > > ---
> > > > >   drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
> > > >
> > > > As requested before, I think we need to see another driver implemen=
ting
> > > > this.
> > > >
> > > > I propose driver igc and chip i225.
> >
> > Sure. I will include igc patches in next version.
> >
> > > >
> > > > The interesting thing for me is to see how the LaunchTime max 1 sec=
ond
> > > > into the future[1] is handled code wise. One suggestion is to add a
> > > > section to Documentation/networking/xsk-tx-metadata.rst per driver =
that
> > > > mentions/documents these different hardware limitations.  It is nat=
ural
> > > > that different types of hardware have limitations.  This is a close=
-to
> > > > hardware-level abstraction/API, and IMHO as long as we document the
> > > > limitations we can expose this API without too many limitations for=
 more
> > > > capable hardware.
> >
> > Sure. I will try to add hardware limitations in documentation.
> >
> > >
> > > I would assume that the kfunc will fail when a value is passed that
> > > cannot be programmed.
> > >
> >
> > In current design, the xsk_tx_metadata_request() dint got return value.
> > So user won't know if their request is fail.
> > It is complex to inform user which request is failing.
> > Therefore, IMHO, it is good that we let driver handle the error silentl=
y.
> >
>
> If the programmed value is invalid, the packet will be "dropped" / will
> never make it to the wire, right?
>
> That is clearly a situation that the user should be informed about. For
> RT systems this normally means that something is really wrong regarding
> timing / cycle overflow. Such systems have to react on that situation.

In general, af_xdp is a bit lacking in this 'notify the user that they
somehow messed up' area :-(
For example, pushing a tx descriptor with a wrong addr/len in zc mode
will not give any visible signal back (besides driver potentially
spilling something into dmesg as it was in the mlx case).
We can probably start with having some counters for these events?

