Return-Path: <linux-kselftest+bounces-1047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 990778037A4
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 15:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F84C1F21273
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07CF28DD7;
	Mon,  4 Dec 2023 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djGA3vkY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA174B2;
	Mon,  4 Dec 2023 06:54:42 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77f04969d2eso118246985a.1;
        Mon, 04 Dec 2023 06:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701701682; x=1702306482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg3OAjxlhkHVroLExkyXrSp7hB9PGqxL9CSH3f9aKos=;
        b=djGA3vkYo8G+q2TTThXo9BVdxjoCSq+LWK32Jr+vl6pAMG9MOC8vm26p6saOT8DAz3
         T61gB42MXGBvCKb92s0QN7eu/XtT3XKvcDdPOjXoOdPjBT1n0hUmNHqMQKG3oa9fgM6W
         Po0NF3ZvhXwUuSQ05HSensVvaeMvtP64e6orfyw3FTn8N1BMsIgqVGmZd3tlTmPQZFMl
         n50KiMFXX+BBC/rvzuQamRBuXRwyEA54sR4wYHyakTJ1WoWoGSTmLMs4mTddMg4ym2OJ
         qOwmlzXYUDNdJ0TMd4fSeOdOLoD9oo8OfpTV/PSKWBVXm4OEdNqejvHN++Hdfr9nQuQd
         MKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701701682; x=1702306482;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bg3OAjxlhkHVroLExkyXrSp7hB9PGqxL9CSH3f9aKos=;
        b=hco7fJrQvU4px6ozxo+5xYz2P5p68Xo0gdYChioSRFte/VK3gCMWWRQ7y7+n9Gc12h
         oxf/jwjEfvqRIFNeVY2SXKXyxOkV30amrp5y9JuFN14qfqCWQZMELmpZKysCfsDD/Ntz
         cctLaHLXi5rQBbnD/tUnW4rlI1l6iifFJMqzBTzYa2pGZ6MpGEj8BHaFCdFiIYufEOl0
         6U4M6IB2Z6AbwPk1/nT8VnjqsNZHgp1qReQEvw9+HIuhb4SGcJO2xnpTsxYma/k4Sxtj
         CaioBTfcws3dSp8LMsdrMGZc2qSef0R/feoHHvDrOOK7U5A+XQihBNZ+3lzdirzwE8F4
         /B7Q==
X-Gm-Message-State: AOJu0YyeVMq7tMvB+EbPmnyQO/Ilvr3h0xbbGrfAesGtXOrap7SR8BpC
	1Zl8DVy2VdNMQpto4/W0548=
X-Google-Smtp-Source: AGHT+IHmGk8EW1nYxUJzot/wHNOP9alDTyqyX08Vu4COc7aS8T/1IoLrhxMpc+DSC3CEsmazSLPpyg==
X-Received: by 2002:a05:6214:11a4:b0:67a:ad71:ce63 with SMTP id u4-20020a05621411a400b0067aad71ce63mr4980388qvv.90.1701701681739;
        Mon, 04 Dec 2023 06:54:41 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id l4-20020ac84584000000b00421b14f7e7csm4356420qtn.48.2023.12.04.06.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:54:41 -0800 (PST)
Date: Mon, 04 Dec 2023 09:54:40 -0500
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
Message-ID: <656de830e8d70_2e983e294ca@willemb.c.googlers.com.notmuch>
In-Reply-To: <43b01013-e78b-417e-b169-91909c7309b1@kernel.org>
References: <20231203165129.1740512-1-yoong.siang.song@intel.com>
 <20231203165129.1740512-3-yoong.siang.song@intel.com>
 <43b01013-e78b-417e-b169-91909c7309b1@kernel.org>
Subject: Re: [PATCH bpf-next v3 2/3] net: stmmac: add Launch Time support to
 XDP ZC
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
> On 12/3/23 17:51, Song Yoong Siang wrote:
> > This patch enables Launch Time (Time-Based Scheduling) support to XDP zero
> > copy via XDP Tx metadata framework.
> > 
> > Signed-off-by: Song Yoong Siang<yoong.siang.song@intel.com>
> > ---
> >   drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
> 
> As requested before, I think we need to see another driver implementing 
> this.
> 
> I propose driver igc and chip i225.
> 
> The interesting thing for me is to see how the LaunchTime max 1 second
> into the future[1] is handled code wise. One suggestion is to add a 
> section to Documentation/networking/xsk-tx-metadata.rst per driver that 
> mentions/documents these different hardware limitations.  It is natural 
> that different types of hardware have limitations.  This is a close-to 
> hardware-level abstraction/API, and IMHO as long as we document the 
> limitations we can expose this API without too many limitations for more 
> capable hardware.

I would assume that the kfunc will fail when a value is passed that
cannot be programmed.

What is being implemented here already exists for qdiscs. The FQ
qdisc takes a horizon attribute and

    "
    when a packet is beyond the horizon
        at enqueue() time:
        - either drop the packet (default policy)
        - or cap its delivery time to the horizon.
    "
    commit 39d010504e6b ("net_sched: sch_fq: add horizon attribute")

Having the admin manually configure this on the qdisc based on
off-line knowledge of the device is more fragile than if the device
would somehow signal its limit to the stack.

But I don't think we should add enforcement of that as a requirement
for this xdp extension of pacing.

