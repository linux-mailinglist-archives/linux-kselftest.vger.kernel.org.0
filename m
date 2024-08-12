Return-Path: <linux-kselftest+bounces-15134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA4794E3FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 02:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8E51F21DD4
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 00:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C6246B8;
	Mon, 12 Aug 2024 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkc9zTKa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D9117F7;
	Mon, 12 Aug 2024 00:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723423512; cv=none; b=QlgverSUUajn/Gz05x+8blZG05EUcB61x7tdfCXnorfTuVX4abSNZv+hcfVMoK9K/dT3OvaQ0oqzXsVOITkUG49GXNdSSc9JhHsU4UNGTDNL5hI9+UX9VRAR5Xm6jkljwxR1mbpcbqz0H5mP73rzWpWaWe5LXdBdjCkLS1bQIV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723423512; c=relaxed/simple;
	bh=e3qAwc0Aeu+mbFp/b/SF9cNN82FTnQEczLmN96Zd+6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SgasuRpvM/TN6Hfs/BenFsrcMK0eklnjPK4pcL0ri/t8cQmCCarGbZu2y7HdrfAcvhKRB9DqM5+Whl/gVBcZZrZUGVazZY0zVbKpiy1pdfcQ6NPsdXrzABsRrv+2OHmJJn8YxKbzXMYMUeL9GYYjAKPUZGPHDv0X6hQoL6Qo3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkc9zTKa; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-709428a9469so2516912a34.3;
        Sun, 11 Aug 2024 17:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723423510; x=1724028310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3aMFoIwNR0Edj/iivZ/M+kTHJdTXmIm3MXh1tRQRaLw=;
        b=hkc9zTKa9TnjN2/BVyEV2ylVQrMQpyZVn1CESZ5xjgVZKgwKkhnO1zVLlnD7OE9KVM
         rZx2YfSshxNAXvzIic0IykIvMLd3hTmNL6MgnB5LxfrqoXi9Lo0B2cBZW1sOXCNKsSyt
         6BtE3odqeREXz1UI0AMPkaC7AROnGeLGkkNkcNt1/XV7zdoM8Nptv47cimXJ9Jnf6PL3
         1WoNdo05UpgcMx4D31DlBrgt88KgqQV+5jF7k7c+M0gM4+7bk0bUwXbOk8G7vvUOLs8x
         I1CZ0f7bINUSp/Ms1lJgiWZJ2J0woVvAPCugo2bc04qW9KSwBRFMHNIV9rpdyNn+eLT2
         oZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723423510; x=1724028310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3aMFoIwNR0Edj/iivZ/M+kTHJdTXmIm3MXh1tRQRaLw=;
        b=TmMmMvHCaqcNcxOa0qc6k818/Pgl/Jh19sdmEu00G7Ewr4NGrjra29oO4oRo6njOFf
         gj0ionX+gqhYcvdI2bjRatKdLyjhgO5kjmIUXd3VhWhrOzt86A3BUsldMJzYP7YbBRBw
         kqJ3KIQJ1MBQPYI6TpSDWJfYYr6JvZVVLh0gb13tSpjdOQHsjWp4S5ren61LMShuPdlr
         tTCL4xfoLJa0TZuRoDIJzfwTWW0ZvYhH9sNDPBn4h0NuS0AStwmljdN+wDzqjguWiJ58
         qVgLTUXPqC+F1j6d25+NLf60YEOg17+ItPCweyEMBzaKuHcJOwX4qYIpT3qgubazfAR0
         j/xA==
X-Forwarded-Encrypted: i=1; AJvYcCVrYhjAR9qGhrHNtUV1olICNrlhhhLt+q4tAUMjUrgSx4HRzob8bNaltQBvAfqD/gP0fXBbLFutFEZeKiqXWFdW@vger.kernel.org, AJvYcCWUzbu9HdtxI1JmDDsGJinOdvUiu998acxptvrUhPcSmLwBnaNHgFt35N6QS33EkEIw4Vs=@vger.kernel.org, AJvYcCX7iGC5HmlgdtdA9HSQG7m9hDlSjszqmZtSoP9utLEot1K5Sp85lBVu+ZSbd0zek1oVnzFAJeNm@vger.kernel.org
X-Gm-Message-State: AOJu0YydeQFLbcYnLrVSEhrGEKywncqxTzCt10uMck+eqhxtTR2WwaJ2
	ygtFHzuZ88gNwtELKpxFnIiLVjkiJoE/wPLk57V616ZoPAVUca4=
X-Google-Smtp-Source: AGHT+IFbcPfZngKB0iIBqbqfAFXPEfEhza5xNhDnMzBqASZHCreomPYUhbCvpBAIsrNMLeBOCSLT5Q==
X-Received: by 2002:a05:6358:7202:b0:1aa:bc42:eb01 with SMTP id e5c5f4694b2df-1b176f47141mr1117891055d.7.1723423510331;
        Sun, 11 Aug 2024 17:45:10 -0700 (PDT)
Received: from vagrant.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58ade4fsm2891966b3a.51.2024.08.11.17.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 17:45:09 -0700 (PDT)
From: "Daniel T. Lee" <danieltimlee@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
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
	Yipeng Zou <zouyipeng@huawei.com>,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [bpf-next 0/3] samples/bpf: Remove obsolete tracing-related tests
Date: Mon, 12 Aug 2024 00:45:00 +0000
Message-ID: <20240812004503.43206-1-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF tracing infrastructure has undergone significant evolution,
leading to the introduction of more robust and efficient APIs.
However, some of the existing tests in the samples/bpf directory have
not kept pace with these developments. These outdated tests not only
create confusion among users but also increase maintenance overhead.

For starter, this patchset focuses on cleaning up outdated 'tracing'
related tests within the BPF testing framework. The goal is to
modernize and streamline selftests by removing obsolete tests and
migrating necessaries to more appropriate locations.

Daniel T. Lee (3):
  selftests/bpf: migrate tracepoint overhead test to prog_tests
  selftests/bpf: add rename tracepoint bench test
  samples/bpf: remove obsolete tracing related tests

 samples/bpf/Makefile                          |  12 -
 samples/bpf/test_overhead_kprobe.bpf.c        |  41 ----
 samples/bpf/test_overhead_raw_tp.bpf.c        |  17 --
 samples/bpf/test_overhead_tp.bpf.c            |  23 --
 samples/bpf/test_overhead_user.c              | 225 ------------------
 samples/bpf/test_override_return.sh           |  16 --
 samples/bpf/test_probe_write_user.bpf.c       |  52 ----
 samples/bpf/test_probe_write_user_user.c      | 108 ---------
 samples/bpf/tracex7.bpf.c                     |  15 --
 samples/bpf/tracex7_user.c                    |  56 -----
 tools/testing/selftests/bpf/bench.c           |   2 +
 .../selftests/bpf/benchs/bench_rename.c       |  16 ++
 .../selftests/bpf/benchs/run_bench_rename.sh  |   2 +-
 .../selftests/bpf/prog_tests/test_overhead.c  |  14 +-
 .../selftests/bpf/progs/test_overhead.c       |  11 +-
 15 files changed, 39 insertions(+), 571 deletions(-)
 delete mode 100644 samples/bpf/test_overhead_kprobe.bpf.c
 delete mode 100644 samples/bpf/test_overhead_raw_tp.bpf.c
 delete mode 100644 samples/bpf/test_overhead_tp.bpf.c
 delete mode 100644 samples/bpf/test_overhead_user.c
 delete mode 100755 samples/bpf/test_override_return.sh
 delete mode 100644 samples/bpf/test_probe_write_user.bpf.c
 delete mode 100644 samples/bpf/test_probe_write_user_user.c
 delete mode 100644 samples/bpf/tracex7.bpf.c
 delete mode 100644 samples/bpf/tracex7_user.c

-- 
2.43.0


