Return-Path: <linux-kselftest+bounces-6588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7B088B5CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 01:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005EBB2D612
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2544D3DAC11;
	Mon, 25 Mar 2024 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8MsTo9Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5E46FDC;
	Mon, 25 Mar 2024 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392820; cv=none; b=tFn7x7KMYxqXqSPc0wNNkskEducJjE251MOO8EWIiNR43CoYeMloCeBm3Z/ggA/A4vNTu5i3DKIbHhkSGxC37iiCZljR2rA8obrQ8ZqJtLxkDYgqbfZ8pS6NcpAvf1FIahXKILUsnlsGFhlCdn5L6go2Pm+mhpwV4qjorRwFyKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392820; c=relaxed/simple;
	bh=dHJnqiu0d3Amh21YXYif8J99OePzMNkm5pLyOHnLViE=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tue1fJza5SsdSacrW2aQ/xtE5wSMAheuU/LEu7yqUgF1Al+4TXIDtpPUH784Mbg82n7peUxi9XcgnJZ2UTDfRxkZbqcASyR+m53llV8gn3gY2aBUcJ+xhVji8XbDWjX1/rsmCPgvSryZQyO0u8d9OD29aeCx8IvjQVql/fNLrr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8MsTo9Z; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60a0579a968so49991327b3.3;
        Mon, 25 Mar 2024 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711392817; x=1711997617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bp10ctRl8y8tt0avIquIVKHyA25BiReIcnLxTfH/WA=;
        b=I8MsTo9Z6eDEXCX81L7ehB8WvD1FPboKKynGCqtmFo2gDBps4KD1sewxbyJw7ll2jg
         g0G4SMVFRpyUMZUlx/wfFCx6+bDD8kF8LNzXiJyXzAsXIcGTMjR7GQBitVRwPF48a9pA
         OEqD13rejGwirjrToQKncNeQB8ykdHWP/GRCpoYfgVEW7iHSIepoI6maDrmCJdvT0Y0L
         Ot5dyfZX3xUynTI658uLDy0VgaGLdwCrCwpIfZAxcb3BriKwCB/EfKHtT9FNwcvkQeFy
         zO8JBmzRmVCSk1B7IzymU10yCr2sQ+LjCCteBZb6zVnqgvZuyklNDPXKT/rkPO8J5Qs0
         s4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711392817; x=1711997617;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bp10ctRl8y8tt0avIquIVKHyA25BiReIcnLxTfH/WA=;
        b=IBFmfyJNImWeNKtwifnZTPfmaxJ9mPBMq6QQm5i+7rI8b+RXYFpADKJVUPqv5FkHg5
         dsjSawGcI9ps7oo1uHGO0Z33IIThqGg82jQT956W9keSd18gqgaVmgkyS12L3Mm8Whjp
         c+ntSJ4EuDKWgsXZpogin8ZjOsBdAFDDtzMD568Aq5Sm8CKcJEKpO25Zz3V4eevvbAiH
         hP4ovMOeSkRqb6dh78coZT2ahaMFkowyJGLR3vMoOyqcJs9s++6uVpzHjQ4s3I3yDV2W
         /lkCc/0GpGbuMIn/ROkFF7hkqx2nlgZfETjZqwzC0cPJY7i9+BKZBTncayBIiRDgLSoE
         c0eA==
X-Forwarded-Encrypted: i=1; AJvYcCV49euTUqMToeN3+tT40DGdnIZstjrD5YFnM0RE059Sl5BCKDpphrabNAQnTMhtzw1r3XkbRUbgsxgZBqYY9B9yIn+Boemn5qGhclNqho8PNLP7wNcpw0Ddwg27UH4vZume3S/VldUE9iMUUjkEM533CpR+y0OeeiItViCsWsu4Aa7heezY
X-Gm-Message-State: AOJu0Yyk3+hrQp4e4GKUcJYHdto1Yx+dB1F/WrDi4eCM4sWmgdWm3B5K
	NdFLWTmN5OUKOfjBM61AqoRB2eYc6lR9LgJc7rIC3d7UxYgTGf4O
X-Google-Smtp-Source: AGHT+IEoRoxiwSZNxekFJF9ohPhsmxIG38hlQq9AgZwVYfGPaOM251BTFfL8/NS3lz/PfULLvN4gxQ==
X-Received: by 2002:a81:8805:0:b0:60c:ba36:1ff6 with SMTP id y5-20020a818805000000b0060cba361ff6mr6332111ywf.32.1711392817444;
        Mon, 25 Mar 2024 11:53:37 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id pc17-20020a05620a841100b007881a59042dsm2341233qkn.66.2024.03.25.11.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 11:53:37 -0700 (PDT)
Date: Mon, 25 Mar 2024 14:53:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 dsahern@kernel.org, 
 xeb@mail.ru, 
 shuah@kernel.org, 
 idosch@nvidia.com, 
 amcohen@nvidia.com, 
 petrm@nvidia.com, 
 jbenc@redhat.com, 
 bpoirier@nvidia.com, 
 b.galvani@gmail.com, 
 liujian56@huawei.com, 
 horms@kernel.org, 
 linyunsheng@huawei.com, 
 richardbgobert@gmail.com, 
 therbert@google.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <6601c830c1daa_11c6072943b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240325182543.87683-5-richardbgobert@gmail.com>
References: <20240325182543.87683-1-richardbgobert@gmail.com>
 <20240325182543.87683-5-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> iph->id, ...) against all packets in a loop. These flush checks are used
> currently only in tcp flows in GRO.
> 
> These checks need to be done only once in tcp_gro_receive and only against
> the found p skb, since they only affect flush and not same_flow.
> 
> Levaraging the previous commit in the series, in which correct network
> header offsets are saved for both outer and inner network headers -
> allowing these checks to be done only once, in tcp_gro_receive. As a
> result, NAPI_GRO_CB(p)->flush is not used at all. In addition - flush_id
> checks are more declarative and contained in inet_gro_flush, thus removing
> the need for flush_id in napi_gro_cb.
> 
> This results in less parsing code for UDP flows and non-loop flush tests
> for TCP flows.
> 
> For example, running 40 IP/UDP netperf connections:
> ./super_netperf.sh 40 -H 1.1.1.2 -t UDP_STREAM -l 120
> 
> Running perf top for 90s we can see that relatively less time is spent
> on inet_gro_receive when GRO is not coalescing UDP:
> 
> net-next:
>    1.26%  [kernel]  [k] inet_gro_receive
> 
> patch applied:
>    0.85%  [kernel]  [k] inet_gro_receive
> 
> udpgro_bench.sh single connection GRO improvement:
> net-next:
>    0.76%  [kernel]  [k] inet_gro_receive
> 
> patch applied:
>    0.61%  [kernel]  [k] inet_gro_receive
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

In v3 we discussed how the flush on network layer differences (like
TTL or ToS) currently only affect the TCP GRO path, but should apply
more broadly.

We agreed that it is fine to leave that to a separate patch series.

But seeing this patch, it introduces a lot of churn, but also makes
it harder to address that issue for UDP, as it now moves network
layer checks directly to the TCP code.

