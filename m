Return-Path: <linux-kselftest+bounces-968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5AA800E16
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 16:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CA6281DDF
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 15:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77B7495EF;
	Fri,  1 Dec 2023 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZW2H/utz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748C010F9;
	Fri,  1 Dec 2023 07:09:17 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77d645c0e06so112311585a.3;
        Fri, 01 Dec 2023 07:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701443356; x=1702048156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLso2pmbW+pqec/n5hTLrdVINDT0pM+C03w8nh7HKns=;
        b=ZW2H/utzzf1N7CiaySlvo1Rf/2AEihSxENWVUquX4J/l39PzuK8dND9WNcVXu1taoX
         Rj7+SHZGsei6QlOGW9p8OZyqJXLHCh2i4c8hybn6eqz9mw30mwtTXz81AEMAE2jtfFhJ
         UgYS/PUTL/mjlV8uEoiyH4vyKHSIfDaGCB+RrUvSRorMWS7H2kcJV25cIOfjFGlU7Dvw
         u9RbeF1A90lzZJzDh189xT8bkgXIrd417KCDKsKVnVZ+BwSakSccGybZE2aB9ouJiQ8Z
         UOiRmPKUhUQQYtARmx4fNnb6LRFGEKroQOFtv1QlNoPhv62L+jjc0GLrT7120XYRMs15
         NsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443356; x=1702048156;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zLso2pmbW+pqec/n5hTLrdVINDT0pM+C03w8nh7HKns=;
        b=eFFRYwiS/0K9fqnRZIK4nTKrZI+AHpzU9i0L2JMXRFwUyBxhPPb9NLRn9JjPoQCtFU
         flSBTRW9Z6/5JuDkTQ9kGQohIMtwiFb1RA2gr9tDZE2L/0R7VMraOpZn7C1IGacXiTaq
         GdiC67/XivIrehsMTEyS8qWsM+uKQd+V9capxdJZMFD8wzDGlowRRRanSiSnf7TAc3y0
         WElU4YuiIfcrPIHCeZQkV+LIFwHNZrPDiksCnxwNJygmCfyidZHAdYOdicqTHOs8jrhi
         f3uXZ3NJsxUx/5brQHV1ehe9jTTtW88sCaUe/mIcxxbFQeqDj6l/+MSzf8NpQmPmGmY4
         M8Gw==
X-Gm-Message-State: AOJu0YyjQydEDG3m72cwB5wEfj+HUAm1KPUvfU6lJ5bwfs71NQqKXDo9
	xPSMiezz/FnMYilqTw6dRI0iVMZ5PtHgdA==
X-Google-Smtp-Source: AGHT+IH54DZX3epKyg6LRt2pdYZkL/+XeUYhSrEyKX4h3aISopJX9pTR0/tZhUxii4HdMqDmoQRtqg==
X-Received: by 2002:ad4:4511:0:b0:67a:8ed9:c9f with SMTP id k17-20020ad44511000000b0067a8ed90c9fmr3811562qvu.48.1701443356450;
        Fri, 01 Dec 2023 07:09:16 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id g12-20020a0caacc000000b0067a39a44ca5sm1106qvb.77.2023.12.01.07.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:09:15 -0800 (PST)
Date: Fri, 01 Dec 2023 10:09:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
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
 Jose Abreu <joabreu@synopsys.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>, 
 "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Message-ID: <6569f71bad00d_138af5294d@willemb.c.googlers.com.notmuch>
In-Reply-To: <PH0PR11MB58306C2E50009A6E22F9DAD3D881A@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20231201062421.1074768-1-yoong.siang.song@intel.com>
 <d4f99931-442c-4cd7-b3cf-80d8681a2986@kernel.org>
 <PH0PR11MB58306C2E50009A6E22F9DAD3D881A@PH0PR11MB5830.namprd11.prod.outlook.com>
Subject: RE: [PATCH bpf-next v2 0/3] xsk: TX metadata txtime support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Song, Yoong Siang wrote:
> On Friday, December 1, 2023 6:46 PM, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
> >On 12/1/23 07:24, Song Yoong Siang wrote:
> >> This series expands XDP TX metadata framework to include ETF HW offload.
> >>
> >> Changes since v1:
> >> - rename Time-Based Scheduling (TBS) to Earliest TxTime First (ETF)
> >> - rename launch-time to txtime
> >>
> >
> >I strongly disagree with this renaming (sorry to disagree with Willem).
> >
> >The i210 and i225 chips call this LaunchTime in their programmers
> >datasheets, and even in the driver code[1].
> >
> >Using this "txtime" name in the code is also confusing, because how can
> >people reading the code know the difference between:
> >  - tmo_request_timestamp and tmo_request_txtime
> >
> 
> Hi Jesper and Willem,
> 
> How about using "launch_time" for the flag/variable and
> "Earliest TxTime First" for the description/comments?  

I don't particularly care which term we use, as long as we're
consistent. Especially, don't keep introducing new synonyms.

The fact that one happens to be one vendor's marketing term does not
make it preferable, IMHO. On the contrary.

SO_TXTIME is in the ABI, and EDT has been used publicly in kernel
patches and conference talks, e.g., Van Jacobson's Netdev 0x12
keynote. Those are vendor agnostic commonly used terms.

But as long as Launch Time is not an Intel only trademark, fine to
select that.

