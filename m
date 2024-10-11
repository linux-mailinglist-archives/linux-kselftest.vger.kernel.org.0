Return-Path: <linux-kselftest+bounces-19497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C3E999B48
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 05:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A69D6B22E73
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 03:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF26D1F4720;
	Fri, 11 Oct 2024 03:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crUP0+8a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2401C9B60;
	Fri, 11 Oct 2024 03:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728618647; cv=none; b=F3VN0Ra0d7dU7ou8mK554Gkzxn6QLUJXM9WPEeLLoFPYkdUKcTmDAVwjpYDixgf15VPhKyjy07gpRoUcdcBfBek4TC4u7T6YjMOwcK0ChrBfiyU6bC859hRaejgsjSMQWiyIKlSJqZdtMldeiVUdkwPredrPihX7dwy4rQ6ESy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728618647; c=relaxed/simple;
	bh=4IErZhrcY/gQVUaJbqgqOV9mMy+Q/vCawF/nqRggqAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=utjSJ3HjC073iMhkR7LtjVFZ0XV+K5QLSRd5NnNuKjnc0qc0tjNkE6GFa3+0gTf+hWVxEaITCE+5ByoduM6nUBaaktx/CUMUPcV17TQ/zxUZK0zaLQRcLajKpKmlhVoHJ3inDG3DTClHtffgIu8x/CI/2Zj5uRt3ys70ncC4vtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crUP0+8a; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71de9e1f374so1219156b3a.1;
        Thu, 10 Oct 2024 20:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728618645; x=1729223445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+aAVaRVPbE8kFz8zzbA2BR+NSyCUvpab/gE0RtCNNPs=;
        b=crUP0+8alicTZmuwEHvaxotRepkle5EkrCG0dy9IbTVx7ivPby/1SC2GAVaswNxszY
         waGdLsM7FXb83p3R3/qIdSVTnm6Xffc6W+X3oV5SuViHV99AVaLA4wLAZ0G1uQ2OR89k
         JqmsKbNkh8W1NkuSW2oli/A2u18LkwOKJs92AJEPg9Pfqjm+bQsbNR0j1YsxAcul06/G
         1YybuNubZTe/bsnwq3DRWg5Z8/GFr+jOZ25sEKeeMbbM4nrm9KQR7PdBgQY14jigCNQ/
         azDx9BR2CYBpVpf/cIsmwzcqfFV2en90WfeQDVj+wxWh2fR9u8oZ4eBbN5a1K31RN9YM
         /NTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728618645; x=1729223445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aAVaRVPbE8kFz8zzbA2BR+NSyCUvpab/gE0RtCNNPs=;
        b=q4BaykVaEYZ35ihulO3PH5kQ/XrXM/nck6AZeHpG6Gey+LNmDd89DZmO3PS+kpEREf
         VcPmIT+LfazydBINSiBurP1JIXZXB3O9Aij8UmeHR9+iDaBjn/2oYDKFENwW0zbWjKBF
         s6tmIS2oBoi1lbVfuXxh6PQx3sng3EU+oiXQZpJNMeKB7fmBwAAzHJYZS0ukkhYTPQa1
         z1ShhUb99odHNWhweU+TtWpzmdOJwVrpSBxXspXxHhQqnAjgn8hi1HgQys9psoyWhjMY
         L1o2UNmGiBCDlZChhSppHzNaO83s3WX4W0Hf+anH9E04Pv9GoeJmmqCjfSSus+iq+X7K
         2h2A==
X-Forwarded-Encrypted: i=1; AJvYcCVszc0ciKS3qpYuEJHtxYzBJitTe0bKFZRowNK+IA2aDcqVa7YMSmnnipPFhRp1+x0ftiIxogN8@vger.kernel.org, AJvYcCWzpkKF55gJ3emka0iDb2g3JAzYeklzZgp3/OzGlnpMmvehAlNpq5VYkMuPVzWi2MeIPhv4VfhIeqfQSJpqEqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS+taPydjAE+W8SyfpnPFOLmflg5qDfZ72aGm8uW6uq/sxUrwK
	batSMeICdY/Pwk7eEN4qghrPfQREWP2S4I+mkafYQJFJlrWDv0w=
X-Google-Smtp-Source: AGHT+IEe37i0dLbs2klkX0c/Ug9HbWD47QiXW5Dq5xUf2EeRIrcQCXEf9NQPrHIolorQtWqX/L1CAw==
X-Received: by 2002:a05:6a00:1798:b0:70d:2a4d:2edc with SMTP id d2e1a72fcca58-71e37f4ee8dmr1925638b3a.20.1728618645371;
        Thu, 10 Oct 2024 20:50:45 -0700 (PDT)
Received: from vagrant.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aa0a645sm1858642b3a.94.2024.10.10.20.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 20:50:44 -0700 (PDT)
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
	linux-kselftest@vger.kernel.org
Subject: [bpf-next 0/4] selftests/bpf: migrate and remove cgroup/tracing related tests
Date: Fri, 11 Oct 2024 03:50:34 +0000
Message-ID: <20241011035038.97568-1-danieltimlee@gmail.com>
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

Daniel T. Lee (4):
  selftests/bpf: migrate cgroup sock create test for setting
    iface/mark/prio
  selftests/bpf: migrate sock create tests for prohibitig sockets
  samples/bpf: remove obsolete cgroup related tests
  samples/bpf: remove obsolete tracing related tests

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

