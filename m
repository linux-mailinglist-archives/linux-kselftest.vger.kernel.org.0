Return-Path: <linux-kselftest+bounces-971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 440CC800E8F
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 16:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CADB8B2149A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 15:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B224AF6A;
	Fri,  1 Dec 2023 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlkAVm0E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F76F103;
	Fri,  1 Dec 2023 07:26:53 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-423f2d0c8baso13722541cf.2;
        Fri, 01 Dec 2023 07:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701444412; x=1702049212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Y5uUpKThH5AlPxwZK/+8ce/JS/o6enGufFaGhxrFrA=;
        b=LlkAVm0E4GDkDf9KHlwLtfA44S2vZn7n7tu7k0Syq3g8Vy7TobnUZOEMLm+C4RRy5w
         mFd5f2BdgT3QF0mYiEuaOH/AbRTq2kRppiB6v6aPkzRYSYjMlz3c2fKVjbhLtLcawuDG
         qCafr0+1phPmkEYQt17zrgradddvlb5Zrg2LKgCmihhXFXJ3L2rtbtlRBjFEgpDFzINg
         iRvfhULsQ4GW4+2ptSo2Jt3k1yuo2X6PFUin3PfbQZ4rQHAxT7AD8Y7eLAfGApwuoSl+
         RMc+0TboXHMBzA9O2MmKiAXm0IBO3vRqUccFrZyekvQaZG1RIpGXmvcUWKAUHDVtYb61
         qI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701444412; x=1702049212;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Y5uUpKThH5AlPxwZK/+8ce/JS/o6enGufFaGhxrFrA=;
        b=HcPi8dnQXOmRsVhxlXHKJHskiCTfmvgJV22pBv4v2n5Bt/mbJuzaJes8/chvDpypVG
         KeqVR1gVjmUZuEDuo237m9s0sQ9HujJlzSH3dVYdg/ZfwHPLp09J7X2HT7Q/O64Em4by
         H6JQUAkFoSRWDeC4zQnaxGxM0NTGZFo1XVl3bHXbOH8I9xkQ4hOL/u17V4eV/NQuTQqn
         2l9F1m8BnphgYaSme3ZSV4wkav/Ib5dMfiiQHdL0EXGu5PM3/zi+R9HUdIQl1lWxMpGU
         mXGR3Yu8Lb2YqdqPnfJiEtTSnGmFkaRO4mT6/3F7HWkxHFs6ftkbKrlIO7d7U0TNoQTh
         vVyg==
X-Gm-Message-State: AOJu0YwcAhuwBdJQHhh0nab/5S9BUd54E+dNPmXYVWHpesvCj5uX2p27
	PoPpKwBkEGx4gSdgafvMD6s=
X-Google-Smtp-Source: AGHT+IE7pPHWo5O6L0cGSE4Vt8ZBvbgF4ZpSTi5qSKV/OfAW0SLGDPjTMnoWDJPMCufOEPTxcgQJbA==
X-Received: by 2002:a05:622a:1a89:b0:423:6e29:c149 with SMTP id s9-20020a05622a1a8900b004236e29c149mr30091182qtc.1.1701444412484;
        Fri, 01 Dec 2023 07:26:52 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id w2-20020ac87182000000b00423de58d3d8sm1567519qto.40.2023.12.01.07.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:26:51 -0800 (PST)
Date: Fri, 01 Dec 2023 10:26:51 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, 
 Song Yoong Siang <yoong.siang.song@intel.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Bjorn Topel <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@google.com>, 
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
 Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 bpf@vger.kernel.org, 
 xdp-hints@xdp-project.net, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <6569fb3b31fb6_1396ec2948@willemb.c.googlers.com.notmuch>
In-Reply-To: <5a660c0f-d3ed-47a2-b9be-098a224b8a12@kernel.org>
References: <20231201062421.1074768-1-yoong.siang.song@intel.com>
 <20231201062421.1074768-3-yoong.siang.song@intel.com>
 <5a660c0f-d3ed-47a2-b9be-098a224b8a12@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/3] net: stmmac: Add txtime support to XDP ZC
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jesper Dangaard Brouer wrote:
> 
> 
> On 12/1/23 07:24, Song Yoong Siang wrote:
> > This patch enables txtime support to XDP zero copy via XDP Tx
> > metadata framework.
> > 
> > Signed-off-by: Song Yoong Siang<yoong.siang.song@intel.com>
> > ---
> >   drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
> >   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
> >   2 files changed, 15 insertions(+)
> 
> I think we need to see other drivers using this new feature to evaluate
> if API is sane.
> 
> I suggest implementing this for igc driver (chip i225) and also for igb
> (i210 chip) that both support this kind of LaunchTime feature in HW.
> 
> The API and stmmac driver takes a u64 as time.
> I'm wondering how this applies to i210 that[1] have 25-bit for
> LaunchTime (with 32 nanosec granularity) limiting LaunchTime max 0.5
> second into the future.
> And i225 that [1] have 30-bit max 1 second into the future.
> 
> 
> [1] 
> https://github.com/xdp-project/xdp-project/blob/master/areas/tsn/code01_follow_qdisc_TSN_offload.org

Good point Jesper.

Can we also explicitly document what the type of the field is?
Nanoseconds against the NIC hardware clock, it sounds like.

We have some experience with this, too. Something needs to do the
conversion from host clock to NIC clock. It is not sufficent to just
assume that the host clock is synced against the NIC clock by PTP.


