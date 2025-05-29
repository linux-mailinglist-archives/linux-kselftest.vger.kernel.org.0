Return-Path: <linux-kselftest+bounces-34016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B646AC854D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 01:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3EB1795C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 23:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7B1259C98;
	Thu, 29 May 2025 23:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VLQh6oQb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0C025487E
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562458; cv=none; b=LXPQIbna8wri5G/kogafPurBaACgL6ijSwq9V9P9lVet6JwDeC85+SD5novXLrTRczHgDTIrfP5g1Eku6aXl6mh3cBMSxtjABD25Nq9w5iVC/aGqKMAix85ojwwDys5bfFqA3R9BkP5H2jv20BRoU0HS0qwD2XRaPOeeDwOaslI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562458; c=relaxed/simple;
	bh=XiF7wGjABVa2ixJPGEc6toPofHwOMyBqL5d/ZjvYjTI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bt8lTd/gYLCkNLE+G+n3nnb3Y5z0JNroP1P6QxkA8dNqim79qDZr83uGv5SF3RcH2yIdjHfruOnIx3LwrdYsZD+Dh9KXRLUmd61EnU89gWLjfCaCVlBUJ0j9G/oPV8ZCpXs1Zcy5n+oLWYdmWjIqUY9x6GJsLj7qFwgyXlN5Ks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VLQh6oQb; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-234b440afa7so15708675ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 16:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748562455; x=1749167255; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jj3IjTnWdLVVuKoHpxyImOpar+R4KFFhXQKA1dsDs2o=;
        b=VLQh6oQbZXniBSfM/MjhSxX8KMAL/L6tSDGaCnvC/moaF4fp4UmZI0eb0Dor4juo7H
         w6gsSyLBdApd9ve2q9Eq4ioI1r3c1fZCHsoy/tQqxS73kibjL3edStbpcvZnHd/4ipy0
         tTaw+8jsP2KIhAUjr9aRdfxjWOa0RLXllyQvJBMU/3csCek+Ah6MgIoI4dwRmqamRGZE
         37nDpJ08tSoJLtY4ezWOZPI/hoYusGplbMMCbXwpnFXVYC7OeEoFqaXv1O04LmPmqMOz
         jZE+/fo1dats91vgu6AQ16rVlqgxjrOyngnDLjVX+LVm+QaCevjIHviJQGkzya+44sXA
         4g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562455; x=1749167255;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jj3IjTnWdLVVuKoHpxyImOpar+R4KFFhXQKA1dsDs2o=;
        b=WBgUFgZow7Xv9PowOGboCMPeicd2MiYaeruf9aoAHKy8xIcZQxM0MoqPDpqOHoFybP
         +dAHdCMuNw61ewBxowb4BBy/bMwaMRK/TlkeKdp+TRKa9OQweIQzSbhJyPFNqcP2sGMZ
         k0jzUiao8+Y1aJyzKpXhUWcPjXnpLerpbEWvTA6DqG2vL1yqn9hcMpthxtCzv99QlBxs
         c4occm6SMLwoojt5upG2ah7OmnMG7sJHlazqqKQEGNrqEwyzGBXr2Y2fu9OUoPTzbQgu
         +skIUlSHN0Pze3tkvCoHzEmJOFUNJWEelPCiM93AhGzmeawHgyZrUjpivvY35g3b05I3
         RrfA==
X-Forwarded-Encrypted: i=1; AJvYcCWsimzeI00Td7UCFmB2r/lv0UcaZYDvhYhnQI7kYFjOWnjPYbfC5vZN5qR3Tg0jJetb6SgRrx8RGBxkmOtyjRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30RetS7zn/yh2g9G4gtSwtz4wr76PZ6WW3rrBoMPMRU70FhDQ
	y35jAkTSlS+GbZDKZeywEErCSwSrTVVplwTYDW0jRLwfsWRlG+TVRreCOZX6J9GvnRFKvPeNpaQ
	3DM/DYIr7x8QPSOggC2PPi1E4FyoaJvA7eJt4
X-Gm-Gg: ASbGncuvdPmU8zBswp3weXcgc7OxNY5qFtUOII1wOdsdSCekq4jUFg4sHRDTw+XxSzv
	w/ib5Oa7gnjy4FNgeR4wdwpTHXvGH+L8Y5p0+UiGwyhx4jfKfUqLznguFyB48Ufht7me13ssdN1
	yzGeL5jvtXgitkJ1RIt8B3m0AsXZt6qEJdsRpTMzqJ+zoiOLaXQg0kIjCI3PrGzM1OtBG2FlFR7
	+69WMgfU46QgibAvOPVziDiXqKp6qT7sWyUeOp/KDPJLvwsJnn7N6ecYkLlPKKrvGHgnwyreHke
	hTVGLzmwPLRsKY9o5PnERZWYoh4KG4t1gRtMBESD+Not+g==
X-Google-Smtp-Source: AGHT+IHwYv3aS/UV/mIzpaJf/NinvhUhG4l1dgysG6d8oRv+uAJ7dWaE03S1YWGE1vvaDvNvVGXvA3OKvnB9
X-Received: by 2002:a17:902:d58e:b0:234:e3b7:5cd2 with SMTP id d9443c01a7336-23529a116e5mr19249165ad.46.1748562455349;
        Thu, 29 May 2025 16:47:35 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-23506bf8e52sm1349915ad.37.2025.05.29.16.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 16:47:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B4C6A340350;
	Thu, 29 May 2025 17:47:34 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id A7892E40F18; Thu, 29 May 2025 17:47:34 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH v8 0/9] ublk: decouple server threads from
 ublk_queues/hctxs
Date: Thu, 29 May 2025 17:47:09 -0600
Message-Id: <20250529-ublk_task_per_io-v8-0-e9d3b119336a@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP7xOGgC/3XQTW7DIBAF4KtErEs0DL/uqveoKgswJChtbEFst
 Yp89+JIVb0gy4f0vpnhTkrIKRTyeriTHJZU0nitwbwciD/b6ynQNNRMEFCCAENn93npb7Zc+in
 kPo3Uq477qMAM2pJam3KI6ftBvn/UfE7lNuafx4SFba8bJhgAIgrB9ZGDMZ1hlNG51JkXm9+mO
 YetZk/h6McvskEL/pWfbLIgBeo6bbQOKg4S2gzfMQwaDN8Yw1gwUUgpbJsRe0Y2GFEZKZCB65g
 VKrYZuWdUg5GV6VAxO2gXIz45Sv0zEnSDUZWxaLEz2nAPrM3oHYMtRlfGu8HZiIY72/ibdV1/A
 cP0aTxWAgAA
X-Change-ID: 20250408-ublk_task_per_io-c693cf608d7a
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

This patch set aims to allow ublk server threads to better balance load
amongst themselves by decoupling server threads from ublk_queues/hctxs,
so that multiple threads can service I/Os that are issued from a single
CPU. This can improve performance for workloads in which ublk server CPU
is a bottleneck, and for which load is issued from CPUs which are not
balanced across ublk_queues/hctxs.

Performance
-----------

First create two ublk devices with:

ublkb0: ./kublk add -t null -q 2 --nthreads 2
ublkb1: ./kublk add -t null -q 2 --nthreads 2 --per_io_tasks

Then run load with:

taskset -c 1 fio/t/io_uring -r5 -p0 /dev/ublkb0: 1.90M IOPS
taskset -c 1 fio/t/io_uring -r5 -p0 /dev/ublkb1: 2.18M IOPS

Since ublkb1 has per-io-tasks, the second command is able to make use of
both ublk server worker threads and therefore has increased max
throughput.

Caveats:
- This testing was done on a system with 2 numa nodes, but the penalty
  of having I/O cross a numa (or LLC) boundary in the per_io_tasks case
  is quite high. So these numbers were obtained after moving all ublk
  server threads and the application threads to CPUs on the same numa
  node/LLC.
- One might expect the scaling to be linear - because ublkb1 can make
  use of twice as many ublk server threads, it should be able to drive
  twice the throughput. However this is not true (the improvement is
  ~15%), and needs further investigation.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes in v8:
- Fix queue_rqs batch dispatch OOPS when dispatching a list of requests
  associated to > 1 ublk_queue (Ming Lei, Caleb Sander Mateos)
- Simplify queue_rqs (Caleb Sander Mateos)
- Narrow a couple of types (Ming Lei)
- Add stress test for per io daemons (Ming Lei)
- Link to v7: https://lore.kernel.org/r/20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com

Changes in v7:
- Fix queue_rqs batch dispatch for per-io daemons
- Kick round-robin tag allocation changes to a followup
- Add explicit feature flag for per-task daemons (Ming Lei, Caleb Sander
  Mateos)
- Move some variable assignments to avoid redundant computation (Caleb
  Sander Mateos)
- Switch from storing pointers in ublk_io to computing based on address
  with container_of in a couple places (Ming Lei)
- Link to v6: https://lore.kernel.org/r/20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com

Changes in v6:
- Add a feature flag for this feature, called UBLK_F_RR_TAGS (Ming Lei)
- Add test for this feature (Ming Lei)
- Add documentation for this feature (Ming Lei)
- Link to v5: https://lore.kernel.org/r/20250416-ublk_task_per_io-v5-0-9261ad7bff20@purestorage.com

Changes in v5:
- Set io->task before ublk_mark_io_ready (Caleb Sander Mateos)
- Set io->task atomically, read it atomically when needed
- Return 0 on success from command-specific helpers in
  __ublk_ch_uring_cmd (Caleb Sander Mateos)
- Rename ublk_handle_need_get_data to ublk_get_data (Caleb Sander
  Mateos)
- Link to v4: https://lore.kernel.org/r/20250415-ublk_task_per_io-v4-0-54210b91a46f@purestorage.com

Changes in v4:
- Drop "ublk: properly serialize all FETCH_REQs" since Ming is taking it
  in another set
- Prevent data races by marking data structures which should be
  read-only in the I/O path as const (Ming Lei)
- Link to v3: https://lore.kernel.org/r/20250410-ublk_task_per_io-v3-0-b811e8f4554a@purestorage.com

Changes in v3:
- Check for UBLK_IO_FLAG_ACTIVE on I/O again after taking lock to ensure
  that two concurrent FETCH_REQs on the same I/O can't succeed (Caleb
  Sander Mateos)
- Link to v2: https://lore.kernel.org/r/20250408-ublk_task_per_io-v2-0-b97877e6fd50@purestorage.com

Changes in v2:
- Remove changes split into other patches
- To ease error handling/synchronization, associate each I/O (instead of
  each queue) to the last task that issues a FETCH_REQ against it. Only
  that task is allowed to operate on the I/O.
- Link to v1: https://lore.kernel.org/r/20241002224437.3088981-1-ushankar@purestorage.com

---
Uday Shankar (9):
      ublk: have a per-io daemon instead of a per-queue daemon
      selftests: ublk: kublk: plumb q_id in io_uring user_data
      selftests: ublk: kublk: tie sqe allocation to io instead of queue
      selftests: ublk: kublk: lift queue initialization out of thread
      selftests: ublk: kublk: move per-thread data out of ublk_queue
      selftests: ublk: kublk: decouple ublk_queues from ublk server threads
      selftests: ublk: add functional test for per io daemons
      selftests: ublk: add stress test for per io daemons
      Documentation: ublk: document UBLK_F_PER_IO_DAEMON

 Documentation/block/ublk.rst                       |  35 ++-
 drivers/block/ublk_drv.c                           | 111 +++----
 include/uapi/linux/ublk_cmd.h                      |   9 +
 tools/testing/selftests/ublk/Makefile              |   2 +
 tools/testing/selftests/ublk/fault_inject.c        |   4 +-
 tools/testing/selftests/ublk/file_backed.c         |  20 +-
 tools/testing/selftests/ublk/kublk.c               | 344 ++++++++++++++-------
 tools/testing/selftests/ublk/kublk.h               |  73 +++--
 tools/testing/selftests/ublk/null.c                |  22 +-
 tools/testing/selftests/ublk/stripe.c              |  17 +-
 tools/testing/selftests/ublk/test_common.sh        |   5 +
 tools/testing/selftests/ublk/test_generic_12.sh    |  55 ++++
 tools/testing/selftests/ublk/test_stress_06.sh     |  36 +++
 .../selftests/ublk/trace/count_ios_per_tid.bt      |  11 +
 14 files changed, 512 insertions(+), 232 deletions(-)
---
base-commit: 533c87e2ed742454957f14d7bef9f48d5a72e72d
change-id: 20250408-ublk_task_per_io-c693cf608d7a

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


