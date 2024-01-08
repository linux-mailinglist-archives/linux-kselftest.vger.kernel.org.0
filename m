Return-Path: <linux-kselftest+bounces-2723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E971D82797F
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5B9283EE3
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2196754BDA;
	Mon,  8 Jan 2024 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqsaWkrU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E5955E46;
	Mon,  8 Jan 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2ac304e526so120871666b.0;
        Mon, 08 Jan 2024 12:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704747142; x=1705351942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pt5ZBMAmBsmSRV69wcHOG+kyXrXealjLznmp8t+4vXs=;
        b=JqsaWkrU8WEgInv5qAVCSNDP2gREWCF7JMvEhcrZd1A/vU9k9Ke5yuuAZTbW+PZVJf
         VonW9nTlzi5ja3NQ77BOv8hHNOThTiS4nFNEfSldyJzHd1Gn6j1HY0WN5k1zr6DsW1ZM
         qtgLxMaOIsAE47wGAlNV64Ix63FDLPOtsM7H1Y0dgJXJ5KMsAhyfzjQqzjpsF39y3YZF
         4RET/jatxb415cZVOUebbPmaqFK1wtQW6tSUPfyhRJj+kWLcBAaglZOKQnC1Aq4lGMBJ
         OsawXOTYzFVbkgFdUwJJq/IaB8cqlYJ96NJeM4ezf1D8w0LQ+8VtpBrswgs4oiYYLtvt
         f3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747142; x=1705351942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pt5ZBMAmBsmSRV69wcHOG+kyXrXealjLznmp8t+4vXs=;
        b=PaUITy8RYeGLsmHGBiW/yPLSt93f0dly9LLyJ2kuoGui4O10RbtMe/zwBLJLP6NizJ
         /7yzDcuL1QzDF6EmF/GTAiR49pW+y5I26vvIpqCGzTpouUyp3Z2Zq6zSt9w0UHE9WbZG
         voGvyOkIrHiGQRyZ8vsQ6pW871hvQNb9Q9JhSmuZeIA/nhJBEgUNkZ/TAHleHLwXPUFP
         Kz1/2GZs3Frp8McFS3moaTya90tVx3AHFaUbnL8bVwUADdeAgAbgar+/Bo5+UYwu084p
         1WQdJZ5vAl7xRLOqq1vMRpbl/azXkLkwx+IM0CGTIPtTIRHVq/YuYSThdBVUlLlU2xXq
         6Ucg==
X-Gm-Message-State: AOJu0Yy5CnbRbJ7ncr4DUvWeUWCJHmVG6m3++i16EiWPGVEOGFpZVnt7
	kCAUfrO6gRtAXwIYmR9ehLE=
X-Google-Smtp-Source: AGHT+IFqN6+gjU6/FmZMQH3eFTlQMUeABxDMRt7hv7vBNJphODGfuL+eU8WN5ynT1iAAytnaXuSitw==
X-Received: by 2002:a17:907:500f:b0:a2b:1a20:36b7 with SMTP id fw15-20020a170907500f00b00a2b1a2036b7mr11421ejc.49.1704747142437;
        Mon, 08 Jan 2024 12:52:22 -0800 (PST)
Received: from localhost ([185.220.101.66])
        by smtp.gmail.com with ESMTPSA id gl16-20020a170906e0d000b00a28bf7969cdsm240864ejb.180.2024.01.08.12.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:52:22 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH bpf-next v2 00/15] Improvements for tracking scalars in the BPF verifier
Date: Mon,  8 Jan 2024 22:51:54 +0200
Message-ID: <20240108205209.838365-1-maxtram95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

The goal of this series is to extend the verifier's capabilities of
tracking scalars when they are spilled to stack, especially when the
spill or fill is narrowing. It also contains a fix by Eduard for
infinite loop detection and a state pruning optimization by Eduard that
compensates for a verification complexity regression introduced by
tracking unbounded scalars. These improvements reduce the surface of
false rejections that I saw while working on Cilium codebase.

Patch 1 (Maxim): Fix for an existing test, it will matter later in the
series.

Patches 2-3 (Eduard): Fixes for false rejections in infinite loop
detection that happen in the selftests when my patches are applied.

Patches 4-5 (Maxim): Fix the inconsistency of find_equal_scalars that
was possible if 32-bit spills were made.

Patches 6-11 (Maxim): Support the case when boundary checks are first
performed after the register was spilled to the stack.

Patches 12-13 (Maxim): Support narrowing fills.

Patches 14-15 (Eduard): Optimization for state pruning in stacksafe() to
mitigate the verification complexity regression.

veristat -e file,prog,states -f '!states_diff<50' -f '!states_pct<10' -f '!states_a<10' -f '!states_b<10' -C ...

 * Without patch 14:

File                  Program       States (A)  States (B)  States    (DIFF)
--------------------  ------------  ----------  ----------  ----------------
bpf_xdp.o             tail_lb_ipv6        3877        2936    -941 (-24.27%)
pyperf180.bpf.o       on_event            8422       10456   +2034 (+24.15%)
pyperf600.bpf.o       on_event           22259       37319  +15060 (+67.66%)
pyperf600_iter.bpf.o  on_event             400         540    +140 (+35.00%)
strobemeta.bpf.o      on_event            4702       13435  +8733 (+185.73%)

 * With patch 14:

File                  Program       States (A)  States (B)  States  (DIFF)
--------------------  ------------  ----------  ----------  --------------
bpf_xdp.o             tail_lb_ipv6        3877        2937  -940 (-24.25%)
pyperf600_iter.bpf.o  on_event             400         500  +100 (+25.00%)

v2 changes:

Fixed comments in patch 1, moved endianness checks to header files in
patch 12 where possible, added Eduard's ACKs.

Eduard Zingerman (4):
  bpf: make infinite loop detection in is_state_visited() exact
  selftests/bpf: check if imprecise stack spills confuse infinite loop
    detection
  bpf: Optimize state pruning for spilled scalars
  selftests/bpf: states pruning checks for scalar vs STACK_{MISC,ZERO}

Maxim Mikityanskiy (11):
  selftests/bpf: Fix the u64_offset_to_skb_data test
  bpf: Make bpf_for_each_spilled_reg consider narrow spills
  selftests/bpf: Add a test case for 32-bit spill tracking
  bpf: Add the assign_scalar_id_before_mov function
  bpf: Add the get_reg_width function
  bpf: Assign ID to scalars on spill
  selftests/bpf: Test assigning ID to scalars on spill
  bpf: Track spilled unbounded scalars
  selftests/bpf: Test tracking spilled unbounded scalars
  bpf: Preserve boundaries and track scalars on narrowing fill
  selftests/bpf: Add test cases for narrowing fill

 include/linux/bpf_verifier.h                  |   4 +-
 include/linux/filter.h                        |  12 +
 kernel/bpf/verifier.c                         | 155 ++++-
 .../bpf/progs/verifier_direct_packet_access.c |   2 +-
 .../selftests/bpf/progs/verifier_loops1.c     |  24 +
 .../selftests/bpf/progs/verifier_spill_fill.c | 533 +++++++++++++++++-
 .../testing/selftests/bpf/verifier/precise.c  |   6 +-
 7 files changed, 685 insertions(+), 51 deletions(-)

-- 
2.43.0


