Return-Path: <linux-kselftest+bounces-1049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 155038037F5
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 15:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FD91F21026
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 14:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9393C28E22;
	Mon,  4 Dec 2023 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaZnbVEp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FA2C4;
	Mon,  4 Dec 2023 06:59:34 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-67aa3b62c35so19743756d6.0;
        Mon, 04 Dec 2023 06:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701701973; x=1702306773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEtXrarlRuJeVsqzYM4zb29M+XdIdGWvdhen3lEwn48=;
        b=BaZnbVEpUZvWZyVgtjKV6YGb+GMtZaVokK55J5t5WfagI0NqBSO9npMk9lqkmqOfF1
         zHfzBYvQb1dtKXCGSNNbf88clMoRwjuDdULMwU2yQHws1VFpsMEzEtx3y1d++yB0ik9T
         jbUUtO8DIrJH1uxE19peA6UEsC8qtRLtaypsKG0c9PdZ/8/1VV9quGEiDphOLmqIYd8S
         3vF21Mk3RhNp7SdAx7eB7UB1wk19s8plhwpuIm8bnBw6357H8BRsqMsRPBi//uh4Me6n
         mnagWahqm2ho6/89QBNxnJfYLJTvVxtnhAuJG4ARGoTr7LhQox8ojYIpinzrzN4yZo8p
         6dDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701701973; x=1702306773;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AEtXrarlRuJeVsqzYM4zb29M+XdIdGWvdhen3lEwn48=;
        b=LUIzcWuX8AZNse6/tJyIJOMAsJxleCCaerr4SvVphAD65yq98TW2pDKBLLTw23L/c6
         USTEBPxOJphzKl3q3f8ERz6uMzmYTp6c2ZJfGBmKcAT/EDlis5aabFG00Qml4upQtWOJ
         WNJTXeiUjtr0FkfIQSFfVS+een5QXfntiJlbyC0zsdYoj0e2X/lm8BxiaPswRRruoPuT
         WvAZ4VfFARKausV17QhBe2YAnvhFAvJ0r8iDxCOk0FTQ11sMZ6LdhZkI80xbkRyxXH++
         8xmdcM3GBRwu2vSTYN24iTqHLZ/h1A/4RsMoBcthdWZkpFFJlUQlZTHacDQfKaSwmcSG
         a88Q==
X-Gm-Message-State: AOJu0YzH8kSBCmqjAlNXRUltblkTY92SRDABsagJXn3tMPD6qrXhfLI0
	EVxG0lYpRmQ5vl55cbbEO4U=
X-Google-Smtp-Source: AGHT+IF3TI2GZnZQV+WfJ1hnsDQUoFtybL3uFMJvxXaDS9FsOiVBo0wGKwsO+64zak8Bz9G8HmuLxw==
X-Received: by 2002:a05:6214:3902:b0:67a:b6a3:834e with SMTP id nh2-20020a056214390200b0067ab6a3834emr5393712qvb.127.1701701973169;
        Mon, 04 Dec 2023 06:59:33 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id mh10-20020a056214564a00b0067a9235d5f0sm3704034qvb.105.2023.12.04.06.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:59:32 -0800 (PST)
Date: Mon, 04 Dec 2023 09:59:31 -0500
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
Message-ID: <656de953bcc82_2e983e2949a@willemb.c.googlers.com.notmuch>
In-Reply-To: <8e20031c-83cb-4927-ab6a-e6b4840e1e42@kernel.org>
References: <20231203165129.1740512-1-yoong.siang.song@intel.com>
 <20231203165129.1740512-4-yoong.siang.song@intel.com>
 <8e20031c-83cb-4927-ab6a-e6b4840e1e42@kernel.org>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: add Launch Time request to
 xdp_hw_metadata
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
> > This patch is tested with stmmac on Intel Tiger Lake platform. Refer to
> > result below, the delta between pre-determined launch time and actual HW
> > transmit complete time is around 24 us.
> 
> Is there any NIC setup (e.g. ethtool/qdisc) requirements to enable HW 
> for this feature?

Judging from how we currently use this with FQ and ETF, no.

See for instance tools/testing/selftests/net/so_txtime.sh


