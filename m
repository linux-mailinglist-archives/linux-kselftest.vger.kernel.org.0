Return-Path: <linux-kselftest+bounces-14037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDEC939955
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2A62B2129F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E7D13C8F6;
	Tue, 23 Jul 2024 05:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJtHRTpi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5B3634;
	Tue, 23 Jul 2024 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714120; cv=none; b=l3yoV8FlylgLHsgmxGfiddFna0sX1X51mdxNjTthlWUEY/4BvbtZBqcbT9IAIv7Iq0RKv/Vd7T++D8i7cmOtOFeZXM/j7NfzkI9G3B3um8r26+0c9TzZIhPO3ZD6U19EsqWULLdp88hjf/pKgUoR9/1PMEORAy1NCqimHRfuLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714120; c=relaxed/simple;
	bh=LltZaSxZPypj0abxlQYbcXU8K33RkNUTwpbp/j8indE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eRkZyMu4kbwX/9n9NDcj6LMUMuLwrMq4Q75aHrM+sYxORUdgtYuy90r/XeSxJQtRbkf7rtSy8s+yb+HriAjXEQpm2A+S+Fu7N0aN5QNlyLugBLwo6edUGUvZCtf2oaz1mAs/sEOmzK4iOL5/Qu2prMoQMeVyZKoB5WssTLffaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJtHRTpi; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7a0b2924e52so174815a12.2;
        Mon, 22 Jul 2024 22:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714118; x=1722318918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mY6MkAWc7AG4OLoWCVmbO7Hx39wXhHZpS7O+C+mUVLg=;
        b=nJtHRTpilEFXZpDYwOCcpYli/rJpzykEbVmQEA5yRJlYGDnMEDOrohnZxU6mFILW3O
         XBdLNRba5LHszl9xsbdHuVd3gjj7uXkFhbB+ciHmlJ7JOdwizreIncZS9IM2EYmeBJK8
         bkqJ3TtPOA7Y+H29PnhD47qreC2S5Bxawb6k12dXdXaczv945YE0pn6PvsrG6s3/wpmS
         5pfguLK6racSs1vsiM4fO9C+3BwGAbDEHtz7ob3TSj9MyH8trSL6yMlCUyJa3PQ3Pi1w
         PajID475MhoUSeG6pjcpXtWW+PQhV0I9RWd6Pr/KYOqTbY4LzsPKm+KBVGeCrtexIjPu
         6V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714118; x=1722318918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mY6MkAWc7AG4OLoWCVmbO7Hx39wXhHZpS7O+C+mUVLg=;
        b=icWO0Usk36shxGsjsytdfwhnsxi4WGjI9EzLiM66buEP7rOhpxLRHnXcdzmUlqkPW5
         gLfHZbknOEMdxO8r/qvt1aaA+0f3Vh7IBtJtotIQX3iqVeteW1uI2kI7gohDj4noIKbH
         ugLo+BPlty1BmtsN2tqX5c1tLY2DQq5Za3+tTTXaW/5zovj7R3ZFFumHpqtk654FXYWi
         0gXRomBMH1qY3+idwrBtXrt17oo3FBGsSOL2ibs8r+vIXuXXh07s28pmXyZwbRcevrF7
         LGUZwMR6s1WCZR5h92drl6jxdcUGbrKB3mfBgiT70Xi3lfVKW673I4euKdZ0ic2MwmAR
         H5Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVyUCBTy44XkV9a9FoyYxqj6sRiYWOcjQmL0EcBUXp45lCo71UwiQfbJ27bZxX4tKjLr4H1rV+ZGvvtRLPusnpf8U5gQydwOkkJvfnyal2i
X-Gm-Message-State: AOJu0YzzsaBhQnmrnGW+NYS64DpSTh1bUS50TCkJSJD4XssxgD7CvVTR
	8WHU3/fe9fz85sP/owJNL5yqXsR8/yjpow8W7KhV1sd17Ojn1keCXN0KoPqU
X-Google-Smtp-Source: AGHT+IGGxY0/QyqFk2cCukn2OmfOVXyrPh0w4Oepzn9XCbLjwzxPbkNSEoIwb2WkCUTZEaGVszJr2g==
X-Received: by 2002:a17:902:fb44:b0:1fd:5fa0:e99b with SMTP id d9443c01a7336-1fd7462ba11mr50135365ad.57.1721714118453;
        Mon, 22 Jul 2024 22:55:18 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:55:17 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Yucong Sun <sunyucong@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	David Vernet <void@manifault.com>,
	Carlos Neira <cneirabustos@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Petar Penkov <ppenkov@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Yan Zhai <yan@cloudflare.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next v1 00/19] selftests/bpf: Improve libc portability / musl support (part 1)
Date: Mon, 22 Jul 2024 22:54:27 -0700
Message-Id: <cover.1721713597.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

This series includes the bulk of libc-related compile fixes accumulated to
support systems using musl, with smaller numbers to follow. These patches
are simple and straightforward, and the series has been tested with the
kernel-patches/bpf CI and locally using mips64el-gcc/musl-libc and QEMU
with an OpenWrt rootfs.

The patches address a few general categories of libc portability issues:

 - missing, redundant or incorrect include headers
 - disabled GNU header extensions (i.e. missing #define _GNU_SOURCE)
 - issues with types and casting

Feedback and suggestions for improvement are welcome!

Thanks,
Tony

Tony Ambardar (19):
  selftests/bpf: Use pid_t consistently in test_progs.c
  selftests/bpf: Fix compile error from rlim_t in sk_storage_map.c
  selftests/bpf: Fix error compiling bpf_iter_setsockopt.c with musl
    libc
  selftests/bpf: Drop unneeded include in unpriv_helpers.c
  selftests/bpf: Drop unneeded include in sk_lookup.c
  selftests/bpf: Drop unneeded include in flow_dissector.c
  selftests/bpf: Fix missing ARRAY_SIZE() definition in bench.c
  selftests/bpf: Fix missing UINT_MAX definitions in benchmarks
  selftests/bpf: Fix missing BUILD_BUG_ON() declaration
  selftests/bpf: Fix include of <sys/fcntl.h>
  selftests/bpf: Fix compiling parse_tcp_hdr_opt.c with musl-libc
  selftests/bpf: Fix compiling kfree_skb.c with musl-libc
  selftests/bpf: Fix compiling flow_dissector.c with musl-libc
  selftests/bpf: Fix compiling tcp_rtt.c with musl-libc
  selftests/bpf: Fix compiling core_reloc.c with musl-libc
  selftests/bpf: Fix errors compiling lwt_redirect.c with musl libc
  selftests/bpf: Fix errors compiling decap_sanity.c with musl libc
  selftests/bpf: Fix errors compiling crypto_sanity.c with musl libc
  selftests/bpf: Fix errors compiling cg_storage_multi.h with musl libc

 tools/testing/selftests/bpf/bench.c                          | 1 +
 tools/testing/selftests/bpf/bench.h                          | 1 +
 tools/testing/selftests/bpf/map_tests/sk_storage_map.c       | 2 +-
 tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/core_reloc.c          | 1 +
 tools/testing/selftests/bpf/prog_tests/crypto_sanity.c       | 1 -
 tools/testing/selftests/bpf/prog_tests/decap_sanity.c        | 1 -
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c      | 2 +-
 tools/testing/selftests/bpf/prog_tests/kfree_skb.c           | 1 +
 tools/testing/selftests/bpf/prog_tests/lwt_redirect.c        | 1 -
 tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/parse_tcp_hdr_opt.c   | 1 +
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c           | 1 -
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c             | 1 +
 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c        | 1 +
 tools/testing/selftests/bpf/progs/cg_storage_multi.h         | 2 --
 tools/testing/selftests/bpf/test_progs.c                     | 2 +-
 tools/testing/selftests/bpf/unpriv_helpers.c                 | 1 -
 18 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.34.1


