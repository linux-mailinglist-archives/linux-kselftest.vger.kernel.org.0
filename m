Return-Path: <linux-kselftest+bounces-19502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 106DC999B67
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 06:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836941F24572
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 04:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE77B1F4736;
	Fri, 11 Oct 2024 04:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJNiDy0W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840162B9DD;
	Fri, 11 Oct 2024 04:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728619437; cv=none; b=DrZp97MpIfPU9QNHkV8JJ7As/RWYGnNjI0CeMooY9rIydG5DOprrHBvTS8g/ic+AizJrkEeGjBw4HYVEU748sYHueYpsKQWbzPNz97/1SKQqNTy3R45TNjbGPc6BQlN2TgtzcOo0nZAhllAYiE+DM9eCFtiEqVkrd2GRvOEJ7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728619437; c=relaxed/simple;
	bh=kop9Nd2elKaH2+h8OENbnJoiTLdrM1StZauqW5inWsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZzaM8qqZ03wNIUNRkJHPPZ/8ktvZt9pk2PXHS2ijv+lsnZOpfcFUFZjELGb9pPE6wK9ziYReaEKKjUBqPXP3nV0lsFHj5pd9FfYTWUfw2F4nkfcYRc4jue1D0iNKpzJLUaXLHJJGlJV16TaXH9lkmtwJcP+TBzGXyUUafn6Edw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJNiDy0W; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20ca388d242so1386445ad.2;
        Thu, 10 Oct 2024 21:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728619435; x=1729224235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fGaYfml5ckPbroiU1+VzVoQV4pETcTfidPlKqVInZ0U=;
        b=PJNiDy0WwyNytDR0G6CXyuzVpqF/1AfzWiYM0uzSYMevzvTFdd1HjyTPiOF7gH3B6Q
         uDXuWIheNEEjlovfw29CZl8uRjN8/XdBGoVIOZ6GkF+iqNjkWpWXybMhnyaZ5s5lw/oq
         fBFxoehA+E3G8ADvxydv8NcOdzN3fyajiHN68pt2FCxBGE669ogvnBYTWJFMaCEISHj2
         3nXFcMcWQNKsKhLHwpCqeKZceyL16L94mLnwya92iWtRmAzlLw33tRCaEclHQJ19x4RV
         LFI3BQHh2xr1ql7ar3XX1VSQXsfg+bciJq0sJ6tYOZgNnLDuEf8cfbehdpZlEv/9icOu
         dAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728619435; x=1729224235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGaYfml5ckPbroiU1+VzVoQV4pETcTfidPlKqVInZ0U=;
        b=xAPbHQbazbzDTkThZrtzej94rN2ziWe16sRHHHa5pQCzVbR1Evh65qr7HExRXTwoV6
         MsU+u5p05dJxJ8bekNN4Tn2e8iHlZwxj1gfJm9NIcJdgRD1FNZWj/i7Xyt4Yu3HkOFz1
         xHGI/npFQnvphxC9zVc12qRBDpvyO5Ycuir/0NnwNlh+2mP0e4OdGAaxh1W8Emeziwmn
         OLdOhMGyL7v86P7OsThU79WDBSBYQvOpR7WnEo37DrRwaL6oNJKvIA/qcR9WCnwYSCap
         A7lyoQCJDliJJOQXD5IgAtG1BUb6aSkzj/oeQqYmosn3j+cTnCQHRnZA7s5lxDbv9qTD
         vAWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4PUa3eogpRbiGxZ2LE6pYuvrxwE8VJjGdmHoG4A8/cB7NtufKGBN5LQXeN6Pb6LOAdMA22JmyB86kQYBeru1f@vger.kernel.org, AJvYcCXOUhJuD1Zn2KOwHu2BGCMjge9/beTjtPAvYibDm32M7hRdG2W4puCfkmBA5DXXXOJVUDLkuUE2VXT8us8=@vger.kernel.org, AJvYcCXvNb6QoYkn2t1XWyfmUjRTh8FZqfltScpcOaOZgrJFRZNhr1KZeSyQM82Po8NA87AdGflj+7y0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Rya4jwtA510pMG9vMMzpdZXkx1KOCJTN4wE2bwxAEUpGkBsr
	Lsx0plHM8l/Tcby7U3nUarCguk7iAJ+AqReXfo4NLKNOTV901KY=
X-Google-Smtp-Source: AGHT+IF1J/MGBY2xg6GNPrcypOmdJ571pI3bSNS89FSM9GHv3hpiJct0EPQoHwmo61mtlrGYojSjaQ==
X-Received: by 2002:a17:903:41cb:b0:20c:5c13:732e with SMTP id d9443c01a7336-20ca16a115amr19628325ad.38.1728619434625;
        Thu, 10 Oct 2024 21:03:54 -0700 (PDT)
Received: from vagrant.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e7716sm16443865ad.122.2024.10.10.21.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 21:03:54 -0700 (PDT)
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
Subject: [PATCH,bpf-next v2 0/4] selftests/bpf: migrate and remove cgroup/tracing related tests
Date: Fri, 11 Oct 2024 04:03:44 +0000
Message-ID: <20241011040348.98042-1-danieltimlee@gmail.com>
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

Daniel T. Lee (4):
  selftests/bpf: migrate cgroup sock create test for setting
    iface/mark/prio
  selftests/bpf: migrate cgroup sock create tests for prohibitig sockets
  samples/bpf: remove obsolete cgroup related tests
  samples/bpf: remove obsolete tracing related tests

---
Changes in v2:
- commit message fix

 samples/bpf/Makefile                          |  24 --
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
 22 files changed, 333 insertions(+), 1939 deletions(-)
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

