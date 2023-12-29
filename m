Return-Path: <linux-kselftest+bounces-2515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BD481FE0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 09:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B998F1F238EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 08:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AA36AA8;
	Fri, 29 Dec 2023 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TL0uNxiH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968E963BD;
	Fri, 29 Dec 2023 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-3bbc649c275so1157539b6e.0;
        Fri, 29 Dec 2023 00:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703837734; x=1704442534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mls/lKeRuEJX81ADB8AP6pjIEWywIDX4oG7UfNICr7k=;
        b=TL0uNxiHJPqAkOLXCZMMojevWm2KC4EXJkibujsSdaqbumoGfxbG+8gUB1cQGA2VdP
         5FBufApeWTtKJ4zJqyoKDktTEdIdp1+ruO9TmmB0Wgocrh1BM4PEfXGtm/k2CnhytTp/
         0hhsYtYVsoJitwuz2D2TMgx3o+SXhdXMhT4qtFrc+wR2D5U+quG7bbJ7aqpIaB8egNJB
         CSv+E4/BgDQe9S2rSqR7rnRZ7NL7dWncr9aEJEisuwOHpRtgJ7Lrdhn1olOpGHmpXARK
         DWZtrs76Q5BR7YQRnAgDq/NfUbC5Q/W33eMZx3sAW4WuN2RZMnmSrOCQ8dFHmxZSF3u2
         teqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703837734; x=1704442534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mls/lKeRuEJX81ADB8AP6pjIEWywIDX4oG7UfNICr7k=;
        b=Ycjm+oUGZfqmMxDZoIQBJNBJyH/EhLzF/2lXDOIFm1tCEZ+uRntlXnys98dB8DNHj2
         HX3laOJn2R2jwUOBvuT3wowPbV9dPLJSDqTa0dbWlV6aw4scgZzTpPCTWtS5ThAfUnwJ
         DUk7pFiFGJagyF0F6zWBV61sKNj8jQxCQb3hpBi/BBLZhaeKl5Vcke7o3dX+ASfhtngk
         FnutpUoYhkb3GBUVkQaeVdcEKuRjOb9Qs8BVXcSvhg88Zbw3bZWsb4jgM5e6K3zJcpTA
         TqC420U1xpnH6wn5c3cN/ubJcE8Z6b2oRthAl1y3xSpV13+g38rP+eh4NgGVo3ZnpyVB
         ShDA==
X-Gm-Message-State: AOJu0Yxu7oOtop6ZTA23g8/hYKVBZlSdRxbJb/tAQCWijqwo77Ow+3Dk
	XDg7eKhxZWP1D7NbjA0Vw+U=
X-Google-Smtp-Source: AGHT+IHqrCvsUFLVr2LGXBlSiozkeXrZfKQwcvZIEeFWIKpzouqr1zjJvb4G1ZTQRWPnA8YiVZjhKQ==
X-Received: by 2002:a05:6808:138c:b0:3bb:7cce:1ed0 with SMTP id c12-20020a056808138c00b003bb7cce1ed0mr6911861oiw.81.1703837734600;
        Fri, 29 Dec 2023 00:15:34 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id h12-20020a63df4c000000b005bd2b3a03eesm14339412pgj.6.2023.12.29.00.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 00:15:34 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	horms@kernel.org,
	dhowells@redhat.com,
	linyunsheng@huawei.com,
	aleksander.lobakin@intel.com,
	joannelkoong@gmail.com,
	laoar.shao@gmail.com,
	kuifeng@meta.com,
	menglong8.dong@gmail.com,
	bjorn@rivosinc.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf: add csum/ip_summed fields to __sk_buff
Date: Fri, 29 Dec 2023 16:14:07 +0800
Message-Id: <20231229081409.1276386-1-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, we have to call some helpers when we need to update the csum,
such as bpf_l4_csum_replace, bpf_l3_csum_replace, etc. These helpers are
not inlined, which causes poor performance.

In fact, we can define our own csum update functions in BPF program
instead of bpf_l3_csum_replace, which is totally inlined and efficient.
However, we can't do this for bpf_l4_csum_replace for now, as we can't
update skb->csum, which can cause skb->csum invalid in the rx path with
CHECKSUM_COMPLETE mode.

What's more, we can't use the direct data access and have to use
skb_store_bytes() with the BPF_F_RECOMPUTE_CSUM flag in some case, such
as modifing the vni in the vxlan header and the underlay udp header has
no checksum.

In the first patch, we make skb->csum readable and writable, and we make
skb->ip_summed readable. For now, for tc only. With these 2 fields, we
don't need to call bpf helpers for csum update any more.

In the second patch, we add some testcases for the read/write testing for
skb->csum and skb->ip_summed.

If this series is acceptable, we can define the inlined functions for csum
update in libbpf in the next step.

Menglong Dong (2):
  bpf: add csum/ip_summed fields to __sk_buff
  testcases/bpf: add testcases for skb->csum to ctx_skb.c

 include/linux/skbuff.h                        |  2 +
 include/uapi/linux/bpf.h                      |  2 +
 net/core/filter.c                             | 22 ++++++++++
 tools/include/uapi/linux/bpf.h                |  2 +
 .../testing/selftests/bpf/verifier/ctx_skb.c  | 43 +++++++++++++++++++
 5 files changed, 71 insertions(+)

-- 
2.39.2


