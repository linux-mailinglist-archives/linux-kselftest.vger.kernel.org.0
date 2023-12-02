Return-Path: <linux-kselftest+bounces-1023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2799E801D32
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 15:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53ADC281A90
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 14:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EF518B1F;
	Sat,  2 Dec 2023 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XixYoi6g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD8711C;
	Sat,  2 Dec 2023 06:15:44 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77dc733b25cso181011485a.1;
        Sat, 02 Dec 2023 06:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701526543; x=1702131343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHjT/29o2cHv+uPSUDloG/9K5z+4mwtqcKQnCHqcHPk=;
        b=XixYoi6gWsVTI/OvkDXmzWnmpY0gqzoB5KNuJV9kiDvtTEuJHgp/FRlGCAuR/aj0h2
         AL5pIF4AFVP3A58/hheKs0LCmimp6wUV6Hu1hMpFcpzq47k6SQGZrow6ZTNv3HlEsW+6
         TtZIE/qt13UbV0X6BIhD9zQ+r4BFvUHWj7sNCVKyJIljmYyXmaMA4zGiXFU7sB395jUa
         cTUvMSa4Gjgw4nc75EwNsJaWKOG4Das3FHdE8R4h0R/d/4NmBd9oHIscM4zCcMDE/sL2
         bT06kZvqNtRMmOC02oXQvXfgUC+Kxt0u8a2fwwh1idNUUlc6bkgY5p5iBYBmGnsEy8M5
         kvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701526543; x=1702131343;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cHjT/29o2cHv+uPSUDloG/9K5z+4mwtqcKQnCHqcHPk=;
        b=cBvm2KIqrTFjx0Pq3m7EBk98PEmOp+ByOr1sJbLbzZbkpaHvnSGAaaexJEaiwxhZvr
         GgDcRCgU8MucLctsRXo2jk6PjpQ1UPPgvZqulm2uXKJn5ifsrLjzB+wavmCG91K+QUF4
         ldrDttvfUAfLi++7hsZWcoYeYYTWV3cL6Z98K9EwCVNH+nlv4eP2RRjtIUuGj1Rm1865
         6Hu1X6UKYbNPMWTJPqjEqmOiXyHhVC5hXyLGgK/N7DLHi+F1JRZBqlhgBZ0H57h3kKly
         oBs81mp7maycHvvOyjOEHpPsKQbQqtMdmGoFTxoafidjX299oMZDLDinsCUWDhR8a/Es
         QE+w==
X-Gm-Message-State: AOJu0YxbJADUsIyeYh3IlK5D8kytigttcfLylkSj3RMzcg6w+bEhNDDI
	ycvklnBfuMMT2m/6pgEAn6s=
X-Google-Smtp-Source: AGHT+IFMroJHDqq6Ir9gZVJ3R728hRmkVYJHVfNaHzVnIzw/nmWz3p78L6RXN42OK1k/cU3B+r7M9w==
X-Received: by 2002:ae9:f812:0:b0:77e:fba3:4f32 with SMTP id x18-20020ae9f812000000b0077efba34f32mr1152322qkh.136.1701526543353;
        Sat, 02 Dec 2023 06:15:43 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id br30-20020a05620a461e00b0077d742fb27esm2452534qkb.49.2023.12.02.06.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 06:15:42 -0800 (PST)
Date: Sat, 02 Dec 2023 09:15:42 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Bjorn Topel <bjorn@kernel.org>, 
 "Karlsson, Magnus" <magnus.karlsson@intel.com>, 
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, 
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
 Jose Abreu <joabreu@synopsys.com>, 
 Andre Fredette <afredette@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>, 
 "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Message-ID: <656b3c0ebb103_1a6a2c2947d@willemb.c.googlers.com.notmuch>
In-Reply-To: <179a4581-f7df-4eb1-ab67-8d65f856a2fe@kernel.org>
References: <20231201062421.1074768-1-yoong.siang.song@intel.com>
 <d4f99931-442c-4cd7-b3cf-80d8681a2986@kernel.org>
 <PH0PR11MB58306C2E50009A6E22F9DAD3D881A@PH0PR11MB5830.namprd11.prod.outlook.com>
 <6569f71bad00d_138af5294d@willemb.c.googlers.com.notmuch>
 <179a4581-f7df-4eb1-ab67-8d65f856a2fe@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/3] xsk: TX metadata txtime support
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
> On 12/1/23 16:09, Willem de Bruijn wrote:
> > Song, Yoong Siang wrote:
> >> On Friday, December 1, 2023 6:46 PM, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
> >>> On 12/1/23 07:24, Song Yoong Siang wrote:
> >>>> This series expands XDP TX metadata framework to include ETF HW offload.
> >>>>
> >>>> Changes since v1:
> >>>> - rename Time-Based Scheduling (TBS) to Earliest TxTime First (ETF)
> >>>> - rename launch-time to txtime
> >>>>
> >>>
> >>> I strongly disagree with this renaming (sorry to disagree with Willem).
> >>>
> >>> The i210 and i225 chips call this LaunchTime in their programmers
> >>> datasheets, and even in the driver code[1].
> >>>
> >>> Using this "txtime" name in the code is also confusing, because how can
> >>> people reading the code know the difference between:
> >>>   - tmo_request_timestamp and tmo_request_txtime
> >>>
> >>
> >> Hi Jesper and Willem,
> >>
> >> How about using "launch_time" for the flag/variable and
> >> "Earliest TxTime First" for the description/comments?
> > 
> 
> I don't follow why you are calling the feature:
>   - "Earliest TxTime First" (ETF).
>   - AFAIK this just reference an qdisc name (that most don't know exists)
> 
> 
> > I don't particularly care which term we use, as long as we're
> > consistent. Especially, don't keep introducing new synonyms.
> > 
> > The fact that one happens to be one vendor's marketing term does not
> > make it preferable, IMHO. On the contrary.
> >
> 
> These kind of hardware features are defined as part of Time Sensitive
> Networking (TSN).
> I believe these TSN features are defined as part of IEEE 802.1Qbv (2015)
> and according to Wikipedia[2] incorporated into IEEE 802.1Q.
> 
> [2] https://en.wikipedia.org/wiki/Time-Sensitive_Networking
> 
> 
> > SO_TXTIME is in the ABI, and EDT has been used publicly in kernel
> > patches and conference talks, e.g., Van Jacobson's Netdev 0x12
> > keynote. Those are vendor agnostic commonly used terms.
> > 
> 
> I agree that EDT (Earliest Departure Time) have become a thing and term
> in our community.
> We could associate this feature with this.
> I do fear what hardware behavior will be it if I e.g. ask it to send a
> packet 2 sec in the future on i225 which max support 1 sec.
> Will hardware send it at 1 sec?
> Because then I'm violating the *Earliest* Departure Time.

That should definitely not happen. At least not on a device that
implements EDT semantics.

This relates to Jakub's question in the previous thread on whether
this mechanism allows out-of-order transmission or maintains FIFO
behavior. That really is device specific.

Older devices only support this for low rate (PTP) and with a small
fixed number of outstanding requests. For pacing offload, devices need
to support up to linerate and out-of-order.

I don't think we want to enforce either in software, as the hardware
is already out there. But it would be good if drivers can somehow
label these capabilities. Including programmable horizon.

It is up to the qdisc to ensure that it does not pass packets to the
device beyond its horizon.

ETF and FQ already have a concept of horizon. And a way to queue
errors for packets out of bound (SO_EE_CODE_TXTIME_..).

> 
> > But as long as Launch Time is not an Intel only trademark, fine to
> > select that.
> 
> The IEEE 802.1Qbv is sometimes called Time-Aware Shaper (TAS), but I
> don't like to for us to name this after this.  This features is simply
> taking advantage of exposing one of the hardware building blocks
> (controlling/setting packet "launch time") that can be used for
> implementing a TAS.
> 
> I like the name "launch time" because it doesn't get easily confused
> with other timestamps, and intuitively describes packet will be send at
> a specific time (likely in future).
> 
> --Jesper

Understood on your point that txtime and tx_timestamp are too similar.
As said, I don't care strongly. Launch time sounds fine to me. Others
can speak up if they disagree.

I take launch time as a less strict than EDT: it is a request to send
at a certain time, with no strict definition on uncertainty. While EDT
more strictly ensures that a packet is not sent before the timestamp.

