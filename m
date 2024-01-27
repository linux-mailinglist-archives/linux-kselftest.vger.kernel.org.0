Return-Path: <linux-kselftest+bounces-3663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7257283EF34
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 18:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32420281E8A
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CC22D05C;
	Sat, 27 Jan 2024 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRRieITr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5B22D04F;
	Sat, 27 Jan 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706377975; cv=none; b=k5O79sk6+CkpJcpffQIAP15HMDUqaOnx3Ln97AFSky6L0mYKR2noxukIyOMharjhXmfKNA4h8p+Z8xvSsysyXG0xFSP+lqCTNHPrXQhHouyroFDcFo9RThs22t4gr46Tb+yZeimyCYRmf7SNnj+ZJCrBQel8ax9mi+TDMQAY8fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706377975; c=relaxed/simple;
	bh=ZwsqwUJlDVP1h28RN1QvwWqhZf5uSegsBDO8ixMVz3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2yjgqg2meRGJebgB9tO6C87mEP2MJiYysxWcDL5jGg6dZqykoztBpwVykg7k5b1Oo7FO9JDkVzg5vQjeObkNjQQDU6BCMskCc/FxZTsULWrNUYp7CzMnBI05uh1+oGFOflG8RlVC9hp9tpbrViYUldO8zC0dA2bXu4TiEBCPaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRRieITr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ef0908c84so3276095e9.0;
        Sat, 27 Jan 2024 09:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706377972; x=1706982772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aLV1PHlbi5Cz6WfYZSHeOC5ViguutB+3Sy48F+2cQ3E=;
        b=NRRieITr5//1pa4DTynKSPR6sf2Obeyii3by3JvjthZlc4PaC5XEW5Mq0uZkvTyxcD
         g1x74xs6+o2wdrWVvOgXK+B8B1z6IYui279Ky8Rnnq3Ba0BO7wfOhCyjTfGivnD0vAdW
         wZXRUoySyEqCjCXXO1As6aNjgnhXyUERwZwbiYmJPFdJ4ABb9gBKV5vOSWMHPEac/ub2
         7L9K1gB4PPeKBvMJp/TcSWFs2cuepJ0HHpqHclkMjarIfdBGhTJfYtQzILZaCsSeIBX8
         LOYJC0KLAQ3mPhcrMdM21jHLk+iEfcIaMvtoL9Jy/7QYnzqoVUP03b5qSOuQkJBI63Tq
         kGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706377972; x=1706982772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLV1PHlbi5Cz6WfYZSHeOC5ViguutB+3Sy48F+2cQ3E=;
        b=cpSlj6aEmsmR65yaISjZECiVNNhXSpyAeqtIKST25cApyEi2qj/vJZdg4FxBwT0KFd
         BbS49bjdpffFvcbuo3SfnMnt4StJPraPYtgcBx7UFb8oI4Xq/8euS37V4/NoRI/IB+TH
         8BPGgLFlBup7wHK7ddk2QJX4wJql8mGXmLeVqERl2YCH1HA2gSYD/6NALuGUwzlDTA6W
         d2dACaO9OaMxE0O+PMnj2w8OkkwB9gADYf62qnTtLwsgXMlBXqLcDh848VE8ScLh2rQv
         RurudeXVeOzHzCe25qsdAmuxlUjolLdVfFzuLGdYSEVRcO/vgYcGdN9bFyYQimoRa0cx
         84KA==
X-Gm-Message-State: AOJu0YzLqjNngrlq7MvRbD4/LPWOBC5P3znWbzvwthgNg+7lqmjlZgLf
	4/ea1B0bRj1Y2guILGnZDJhbpaIM7shrr+eeGk1WeJLdY/DZeZvv8kj69ww0dzhyZA==
X-Google-Smtp-Source: AGHT+IHydjHmX38PMpgKWMy8CTDf2DwkqrIvUnRXble1C1JnF1I2ur4zx3XgkZMyvYL7NUgkS3/kFQ==
X-Received: by 2002:adf:e64a:0:b0:33a:e7a8:2994 with SMTP id b10-20020adfe64a000000b0033ae7a82994mr153763wrn.138.1706377971498;
        Sat, 27 Jan 2024 09:52:51 -0800 (PST)
Received: from localhost ([185.220.101.170])
        by smtp.gmail.com with ESMTPSA id cw1-20020a170907160100b00a35404360a8sm819418ejd.119.2024.01.27.09.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 09:52:50 -0800 (PST)
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
Subject: [PATCH bpf-next v3 0/6] Improvements for tracking scalars in the BPF verifier
Date: Sat, 27 Jan 2024 19:52:31 +0200
Message-ID: <20240127175237.526726-1-maxtram95@gmail.com>
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

Patches 1-9 of the original series were previously applied in v2.

Patches 1-2 (Maxim): Support the case when boundary checks are first
performed after the register was spilled to the stack.

Patches 3-4 (Maxim): Support narrowing fills.

Patches 5-6 (Eduard): Optimization for state pruning in stacksafe() to
mitigate the verification complexity regression.

veristat -e file,prog,states -f '!states_diff<50' -f '!states_pct<10' -f '!states_a<10' -f '!states_b<10' -C ...

 * Without patch 5:

File                  Program   States (A)  States (B)  States    (DIFF)
--------------------  --------  ----------  ----------  ----------------
pyperf100.bpf.o       on_event        4878        6528   +1650 (+33.83%)
pyperf180.bpf.o       on_event        6936       11032   +4096 (+59.05%)
pyperf600.bpf.o       on_event       22271       39455  +17184 (+77.16%)
pyperf600_iter.bpf.o  on_event         400         490     +90 (+22.50%)
strobemeta.bpf.o      on_event        4895       14028  +9133 (+186.58%)

 * With patch 5:

File                     Program        States (A)  States (B)  States   (DIFF)
-----------------------  -------------  ----------  ----------  ---------------
bpf_xdp.o                tail_lb_ipv4         2770        2224   -546 (-19.71%)
pyperf100.bpf.o          on_event             4878        5848   +970 (+19.89%)
pyperf180.bpf.o          on_event             6936        8868  +1932 (+27.85%)
pyperf600.bpf.o          on_event            22271       29656  +7385 (+33.16%)
pyperf600_iter.bpf.o     on_event              400         450    +50 (+12.50%)
xdp_synproxy_kern.bpf.o  syncookie_tc          280         226    -54 (-19.29%)
xdp_synproxy_kern.bpf.o  syncookie_xdp         302         228    -74 (-24.50%)

v2 changes:

Fixed comments in patch 1, moved endianness checks to header files in
patch 12 where possible, added Eduard's ACKs.

v3 changes:

Maxim: Removed __is_scalar_unbounded altogether, addressed Andrii's
comments.

Eduard: Patch #5 (#14 in v2) changed significantly:
- Logical changes:
  - Handling of STACK_{MISC,ZERO} mix turned out to be incorrect:
    a mix of MISC and ZERO in old state is not equivalent to e.g.
    just MISC is current state, because verifier could have deduced
    zero scalars from ZERO slots in old state for some loads.
  - There is no reason to limit the change only to cases when
    old or current stack is a spill of unbounded scalar,
    it is valid to compare any 64-bit scalar spill with fake
    register impersonating MISC.
  - STACK_ZERO vs spilled zero case was dropped,
    after recent changes for zero handling by Andrii and Yonghong
    it is hard (impossible?) to conjure all ZERO slots for an spi.
    => the case does not make any difference in veristat results.
- Use global static variable for unbound_reg (Andrii)
- Code shuffling to remove duplication in stacksafe() (Andrii)

Eduard Zingerman (2):
  bpf: handle scalar spill vs all MISC in stacksafe()
  selftests/bpf: states pruning checks for scalar vs STACK_MISC

Maxim Mikityanskiy (4):
  bpf: Track spilled unbounded scalars
  selftests/bpf: Test tracking spilled unbounded scalars
  bpf: Preserve boundaries and track scalars on narrowing fill
  selftests/bpf: Add test cases for narrowing fill

 include/linux/bpf_verifier.h                  |   9 +
 kernel/bpf/verifier.c                         | 103 ++++--
 .../selftests/bpf/progs/verifier_spill_fill.c | 324 +++++++++++++++++-
 3 files changed, 404 insertions(+), 32 deletions(-)

-- 
2.43.0


