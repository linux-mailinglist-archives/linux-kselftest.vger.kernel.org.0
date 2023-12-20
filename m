Return-Path: <linux-kselftest+bounces-2277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBC281A858
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 22:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A401287387
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 21:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF44F4A9A6;
	Wed, 20 Dec 2023 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIX4x5/p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43434495E2;
	Wed, 20 Dec 2023 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-54f4f7e88feso157063a12.3;
        Wed, 20 Dec 2023 13:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703108425; x=1703713225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MzuubNkvst/9i8BFChAgxHMD9ThadUV92R9A6HcZzrE=;
        b=YIX4x5/p2cmHw83mm/O6yyGLKp6gNDmuqwznR5PYtNhFSS1CzBOE1BZ5bfdIwsevUR
         K0/8IgjyykVEFy30vnQ97Ztna7R+9ZSEylyMLG0PNf/hHr2gT7IZIHkduFf2SJVzRFh2
         pcU23sDGEcFEkOVwKIVoxTe1mrt5zzHVE+RGGBbxeCpu/5IXUVUTNo8BI3T+xaGaRZgx
         5P6V/TeguPVJkalBITSh1DMlPfZo3vA1xr2u2MnApJHz/fIgdipWFkrB7OnJXh/LENvy
         5KGeIINXGZPpRIN6g573Y0SQd9M6xg3c9pbnvdGXRG3lCUx+x3GXuYNRuYdd2NLyYuLz
         rj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108425; x=1703713225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzuubNkvst/9i8BFChAgxHMD9ThadUV92R9A6HcZzrE=;
        b=jMqt0hLDZgOWwEX+AvRovVTla31hb3jQhTh+EfN+8E6Ll3NtLsKb6nvjARCLfWjctJ
         t/1uJ+HfFhjCyimNBbw09X2tjcIcaIBHkHS/BoE4LlagPJxLdnlbmEHmOJ1i0kGJIlCA
         fidn2E+IguDKJcvq/zykZaDnM8z5msjK7leryqwhP7iO8pWiMlY93nzPP7ssJF6GXVJ3
         4xo20VFY+Q0BZA/4rWToyhn0/6rFO7zTMTqB0eJpXfE0tePtb9tLgrtt7UhBEn1KlDQK
         nxJ+L0sc/MWRv0CRYop8LFyibzQ6dL5LWeLiyDtk2AEFkEbaqMa8biKPK7QfIsiOQsaj
         19DQ==
X-Gm-Message-State: AOJu0Yw7rYOy+znShyJU0pxeyf+9Lf5BVX8M4L0rMgnQIEn9SO7XHq8V
	ctQqw1+l1cZdr1qTnUQxsAI=
X-Google-Smtp-Source: AGHT+IFgt5CHbyFocEJTyy1xKdfEag+/QY5YQzYz1KGsLP+apqD8OMxmN5u2n9D9p0Z6o71u/+sX5w==
X-Received: by 2002:a50:cd51:0:b0:553:5f4:7d81 with SMTP id d17-20020a50cd51000000b0055305f47d81mr4684928edj.61.1703108425239;
        Wed, 20 Dec 2023 13:40:25 -0800 (PST)
Received: from localhost ([185.220.101.166])
        by smtp.gmail.com with ESMTPSA id a5-20020aa7cf05000000b005537e39745csm296817edy.47.2023.12.20.13.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:40:24 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
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
Subject: [PATCH bpf-next 00/15] Improvements for tracking scalars in the BPF verifier
Date: Wed, 20 Dec 2023 23:39:58 +0200
Message-ID: <20231220214013.3327288-1-maxtram95@gmail.com>
X-Mailer: git-send-email 2.42.1
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

 include/linux/bpf_verifier.h                  |   2 +-
 kernel/bpf/verifier.c                         | 160 +++++-
 .../bpf/progs/verifier_direct_packet_access.c |   2 +-
 .../selftests/bpf/progs/verifier_loops1.c     |  24 +
 .../selftests/bpf/progs/verifier_spill_fill.c | 529 +++++++++++++++++-
 .../testing/selftests/bpf/verifier/precise.c  |   6 +-
 6 files changed, 677 insertions(+), 46 deletions(-)

-- 
2.42.1

