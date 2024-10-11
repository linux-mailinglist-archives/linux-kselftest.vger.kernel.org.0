Return-Path: <linux-kselftest+bounces-19507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BE3999BD2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 06:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9D71C22BD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 04:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5611CF7B5;
	Fri, 11 Oct 2024 04:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYWSu4x6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329A61392;
	Fri, 11 Oct 2024 04:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728622137; cv=none; b=AWhCGvg9eSxgnvMfkEVSlwPx/6/ykp8YbWgyL1DVNgPht2bmZHUwT7wiQJpFxjcThlGzFh6THpGkuzZ7V5aJ4/3eu+HwpN8kFqdCRhAC9CGh4QitKKioaRBMi+G9dx+J71s2YPrUbdKoh5oOEc5MHl6lfLC7lUs28wKnQjHigyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728622137; c=relaxed/simple;
	bh=zwHXvytxHWYApHuZhWuXV9y4BpitRuXsQiUi2DZ+684=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uHjCmU49Rzdp89QvYYDPuel/e9IuBtr4kI46EepLzML4JWG54MXHy416xY2/Vmcyv3yE22EfYPompk8Cb7dkebVZL4iVo0/oEpPEjaAyuG0EJiK3IAQLf231pVu9Ht4zWqtvC5DFRoHt0bpniFpa6scat5fT+nBiJGgOl7p5vbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYWSu4x6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71dfc250001so1432214b3a.2;
        Thu, 10 Oct 2024 21:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728622135; x=1729226935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TjuWKv1/VvvI91SM8aESOPdFGoef+lOHjkE2KkzByeE=;
        b=fYWSu4x6wIPNWPmX66SZjkAE2ThIG4a90X5Qtbi8Dch4FDE614FNpCBF32pM+xBLnG
         v5Xm51jGnoMko93ufcOX3Ilx303FAB7bdMOap8r4msntol5A2yAFQN/PkhGMVuUvZuh5
         huwp4FI9+t71mt++cxRFefd5dyuxmeuHF1JmDc98pKWcB5iinFaE8FGi1AJ37IjpeBl2
         tXFjThE0po2FjneyqV2Z8wftlb9uUDR3uTJsUQUVypgcKU0cJCAi0P73I+YXZknVX0oC
         RjR7bKNHn5oXyEen3vZgrcrg1O7pB5M3/jyoMzjd4i+CHuofIficp5XHHJCf42Wv9JdY
         nFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728622135; x=1729226935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjuWKv1/VvvI91SM8aESOPdFGoef+lOHjkE2KkzByeE=;
        b=Bs4DOAFcZPQ6PPtKBn4VZ+TCzQlWBon2mAGSYF1/tht/WDflWJte8fTlOf/yEkozwB
         32K0gzlKbuDEftQIJg+iHe031FvBFX6cxe+U0gJWUH8wLmbC9IOivwIzGbTVEeAVo6Kf
         vZAGe86ogOtzkWR8Nm4gYLXcfpy02FOe2XyxzY2xCp3JGRlR2X4nMDHelkjtP1ngrW+M
         mEuitK28CTvj1wTnqxAJ7lmLjsG2oGoIblA8l6TwrzGKC4DO+RqPbnJPoIsZOQ57Tc01
         5l1AP5NXsRwnMQ9l7vNifTyAm6J/DoltoWjKFyYr1jAS5oamX1WLzScY5Cv16HD5q25Q
         YfIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/NfcvDpcv59CIla93jMxicA8IC53m/BxF1ReRAgq7eCI2f4sWb3jQStPb9Dev96jnLGKSqZqAOOr6yKzUZ8aw@vger.kernel.org, AJvYcCWHe9ahUaAYfDD68hzDRCQxnWiyWIud1a2Shd+l3SlSKtqlooCxFfyFbmB5BgW6FOaTZTgSBOsWvjS4YvE=@vger.kernel.org, AJvYcCXG4fH6afET0k3bsNoBbqFZSN7EwDDE9I1b0tFvnDdHBWAMpGa3RiUWdJtNKZu3JaQka6FG7zt/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxib/0GwZtRaSsbhqGKeHDzl2k3nA5xeWbnErram985I/uwy/4R
	hhqr4A6HrA1IEOp/J7KrFomqughTmCWqTlZv9S1PEtBoYK7kBKs=
X-Google-Smtp-Source: AGHT+IGIVYPqLjuT0dZQiUi4eH3jJbSg0g1fVm5lrvkyroNQIFp/q6kGzvKfFQUybKB3cc1nc4ZMJw==
X-Received: by 2002:a05:6a00:3d52:b0:71e:620:8e0a with SMTP id d2e1a72fcca58-71e37e28291mr2277686b3a.5.1728622135357;
        Thu, 10 Oct 2024 21:48:55 -0700 (PDT)
Received: from vagrant.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab105f9sm1856692b3a.216.2024.10.10.21.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 21:48:54 -0700 (PDT)
From: "Daniel T. Lee" <danieltimlee@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH,bpf-next v3 0/4] selftests/bpf: migrate and remove cgroup/tracing related tests
Date: Fri, 11 Oct 2024 04:48:43 +0000
Message-ID: <20241011044847.51584-1-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF testing framework has evolved significantly over time. However,
some legacy tests in the samples/bpf directory have not kept up with
these changes. These outdated tests can cause confusion and increase
maintenance efforts.

This patchset focuses on migrating outdated cgroup and tracing-related
tests from samples/bpf to selftests/bpf, ensuring the BPF test suite
remains current and efficient. Tests that are already covered by
selftests/bpf are removed, while those not yet covered are migrated.
This includes cgroup sock create tests for setting socket attributes
and blocking socket creation, as well as the removal of redundant
cgroup and tracing tests that have been replaced by newer tests.

This patchset covers the following cgroup/tracing tests:
- test_overhead: tests the overhead of BPF programs with task_rename,
  now covered by selftests and benchmark tests (rename-*). [1]

- test_override_return: tests the return override functionality, now
  handled by kprobe_multi_override in selftests.

- test_probe_write_user: tests the probe_write_user functionality,
  now replaced by the probe_user test in selftests.

- test_cgrp2_sock: tests cgroup BPF's ability to set sk_bound_dev_if,
  mark, and priority during socket creation. Migrated to selftests as
  'sock_create' since no existing tests fully cover this.

- test_cgrp2_sock2: tests blocking socket creation for specific types
  (AF_INET{6}, SOCK_DGRAM, IPPROTO_ICMP{V6}). Migrated to selftests
  in 'sock_create' test for coverage.

- test_current_task_under_cgroup: tests bpf_current_task_under_cgroup()
  to check if a task belongs to a cgroup. Already covered by
  task_under_cgroup at selftest and other cgroup ID tests.

- test_cgrp2_tc: tests bpf_skb_under_cgroup() to filter packets based
  on cgroup. This behavior is now validated by cgroup_skb_sk_lookup,
  which uses bpf_skb_cgroup_id, making this test redundant.

[1]: https://patchwork.kernel.org/cover/13759916

---
Changes in v2:
- commit message fix
Changes in v3:
- Makefile fix

Daniel T. Lee (4):
  selftests/bpf: migrate cgroup sock create test for setting
    iface/mark/prio
  selftests/bpf: migrate cgroup sock create test for prohibiting sockets
  samples/bpf: remove obsolete cgroup related tests
  samples/bpf: remove obsolete tracing related tests

 samples/bpf/Makefile                          |  25 --
 samples/bpf/sock_flags.bpf.c                  |  47 ---
 samples/bpf/test_cgrp2_array_pin.c            | 106 ------
 samples/bpf/test_cgrp2_attach.c               | 177 ----------
 samples/bpf/test_cgrp2_sock.c                 | 296 ----------------
 samples/bpf/test_cgrp2_sock.sh                | 137 -------
 samples/bpf/test_cgrp2_sock2.c                |  95 -----
 samples/bpf/test_cgrp2_sock2.sh               | 103 ------
 samples/bpf/test_cgrp2_tc.bpf.c               |  56 ---
 samples/bpf/test_cgrp2_tc.sh                  | 187 ----------
 .../bpf/test_current_task_under_cgroup.bpf.c  |  43 ---
 .../bpf/test_current_task_under_cgroup_user.c | 115 ------
 samples/bpf/test_overhead_kprobe.bpf.c        |  41 ---
 samples/bpf/test_overhead_raw_tp.bpf.c        |  17 -
 samples/bpf/test_overhead_tp.bpf.c            |  23 --
 samples/bpf/test_overhead_user.c              | 225 ------------
 samples/bpf/test_override_return.sh           |  16 -
 samples/bpf/test_probe_write_user.bpf.c       |  52 ---
 samples/bpf/test_probe_write_user_user.c      | 108 ------
 samples/bpf/tracex7.bpf.c                     |  15 -
 samples/bpf/tracex7_user.c                    |  56 ---
 .../selftests/bpf/prog_tests/sock_create.c    | 333 ++++++++++++++++++
 22 files changed, 333 insertions(+), 1940 deletions(-)
 delete mode 100644 samples/bpf/sock_flags.bpf.c
 delete mode 100644 samples/bpf/test_cgrp2_array_pin.c
 delete mode 100644 samples/bpf/test_cgrp2_attach.c
 delete mode 100644 samples/bpf/test_cgrp2_sock.c
 delete mode 100755 samples/bpf/test_cgrp2_sock.sh
 delete mode 100644 samples/bpf/test_cgrp2_sock2.c
 delete mode 100755 samples/bpf/test_cgrp2_sock2.sh
 delete mode 100644 samples/bpf/test_cgrp2_tc.bpf.c
 delete mode 100755 samples/bpf/test_cgrp2_tc.sh
 delete mode 100644 samples/bpf/test_current_task_under_cgroup.bpf.c
 delete mode 100644 samples/bpf/test_current_task_under_cgroup_user.c
 delete mode 100644 samples/bpf/test_overhead_kprobe.bpf.c
 delete mode 100644 samples/bpf/test_overhead_raw_tp.bpf.c
 delete mode 100644 samples/bpf/test_overhead_tp.bpf.c
 delete mode 100644 samples/bpf/test_overhead_user.c
 delete mode 100755 samples/bpf/test_override_return.sh
 delete mode 100644 samples/bpf/test_probe_write_user.bpf.c
 delete mode 100644 samples/bpf/test_probe_write_user_user.c
 delete mode 100644 samples/bpf/tracex7.bpf.c
 delete mode 100644 samples/bpf/tracex7_user.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_create.c

--
2.43.0

