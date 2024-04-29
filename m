Return-Path: <linux-kselftest+bounces-9083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4178B64C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 23:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC4E1C20BCF
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 21:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6918410E;
	Mon, 29 Apr 2024 21:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTmRqZtO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE01836E9
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 21:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427139; cv=none; b=qsQJqbPNtQ7if9n7uxW3Gz7BuLjF8bLwxtFvRIf7c6PekNNARCncVvI8rTnTita+esyKJExXiMV45ys+kkscbvyGwpwF/qleCfF2rznjFsBWDP6F/eSl5t01iVa95fnvxKLqQzLXYX1qQ8jwVSiSKaEeW4z8WtNk97+0tI+sZ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427139; c=relaxed/simple;
	bh=CXdGvTleMNIv4GYdc9ZhHcot4PSSombN20TNzZWr8UI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=br/T/xQeY0KYwRF/u+Pv/Gd+0869IajlQfzAhU74D2JQQJ9ZVwzTUhW+0+h2D0SYD05HuXgioRAoIsOxxdiSHrgcFn5QV1vALR+e9PQSAxQD/UOYd1NY8fzh5B//2/qvnj+QbOfzNfT4ugNzjFFwRveyYiAlFaijzVP9VM+S6i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aTmRqZtO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de610854b8bso760965276.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 14:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714427137; x=1715031937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/r6j/W9mUWONQY7ovRYyi9uqUz9mWwrTm/AdOjdCX/U=;
        b=aTmRqZtOVSXV1y9fbysvl58xEMBmjBCCn/C6gvqq+WtcFkLq45ouCNdx1toBHuQJK/
         x6uJtavnxcB5MnzD13FfWUWK3abEhPpaMsCulU6W5JBQnQZWmMsHAsXtjHmY4CNRAXf7
         n0xBNohwEkTJaUmiRpOY59DG1G98jP6HqDsDk5xYtfhhyvl0UK4eCN/5YdTZicPAMS3h
         gm/Yr47FiBUh2C56vgURKHYV1V/lKerm/yTO237gEME9IGQn65e+57evPdwB6Igzz8gf
         mTqYFyjKhp42lOKTLIhzF6tBUXuHcFV3n1dnl5q4f0nBa5KB8hSZZ7jckudugjkqEghy
         Ac0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714427137; x=1715031937;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/r6j/W9mUWONQY7ovRYyi9uqUz9mWwrTm/AdOjdCX/U=;
        b=gOf86/DZL0OPvFGV1fCkY5vKoh90jRU1Po9c8BkVPbapYR3e7QLlMhmi6xwSm50s0A
         pSG6awcco1Hv2bzF8ekkXl0f6xcDkHCMxauIn/h0c3hIFh5L6RR+oghD9elVFmdCJpfY
         TBa3hn9GgJTHdFufDhqhxnrFAcj/kn6ALlxGwfgx8Knc3bdQrWKw/YXS0qJRhSxjrr8g
         jq/0YMRVDyRxNqgbMzakBqm2VC/etqNAO+1dIKzxbkhbJOzmLBKwGf4vgnqgJmwLc4t3
         g0EtL7kFTReSW96lDomxZd0Zy+mp86g9DzoHyHBaS8QSZy9XNKTSwyigGbWszUirdM8M
         WcJw==
X-Forwarded-Encrypted: i=1; AJvYcCU6gLDepAFghaFqzgcttzuODLFXXBE/23UJhgdne8j5WMaIy/taQJk3XEn3r3SsFw8AUR5vP5JIGOTliio2E/LhyX4LKTPU4HflXE8+8Rsz
X-Gm-Message-State: AOJu0YyEBOtkyjNtZKH+iQeQ5mxc325FRdTmS9u6kVBJBE26F2nVZYMF
	BoEgjUy9cb+qqRpt0Wr7QkQrn9KeL3meJdJ/e4L0pdmNN4JgsQUjcvZ3crAfyQxw+O5w5aerhA=
	=
X-Google-Smtp-Source: AGHT+IEAAO56xjTLfoNQSFLAwnATKrv+gLtp1W9DP3wLkwXTGkheUj3EN6qI3g4PUDC20KIcGFPosz2rsw==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:d8d1:0:b0:de5:5304:3206 with SMTP id
 p200-20020a25d8d1000000b00de553043206mr756562ybg.11.1714427136747; Mon, 29
 Apr 2024 14:45:36 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:45:17 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429214529.2644801-1-jrife@google.com>
Subject: [PATCH v3 bpf-next 0/6] selftests/bpf: Add sockaddr tests for kernel networking
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Benjamin Tissoires <bentiss@kernel.org>, Hou Tao <houtao1@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This patch series adds test coverage for BPF sockaddr hooks and their
interactions with kernel socket functions (i.e. kernel_bind(),
kernel_connect(), kernel_sendmsg(), sock_sendmsg(),
kernel_getpeername(), and kernel_getsockname()) while also rounding out
IPv4 and IPv6 sockaddr hook coverage in prog_tests/sock_addr.c.

As with v1 of this patch series, we add regression coverage for the
issues addressed by these patches,

- commit 0bdf399342c5("net: Avoid address overwrite in kernel_connect")
- commit 86a7e0b69bd5("net: prevent rewrite of msg_name in sock_sendmsg()")
- commit c889a99a21bf("net: prevent address rewrite in kernel_bind()")
- commit 01b2885d9415("net: Save and restore msg_namelen in sock_sendmsg")

but broaden the focus a bit.

In order to extend prog_tests/sock_addr.c to test these kernel
functions, we add a set of new kfuncs that wrap individual socket
operations to bpf_testmod and invoke them through set of corresponding
SYSCALL programs (progs/sock_addr_kern.c). Each test case can be
configured to use a different set of "sock_ops" depending on whether it
is testing kernel calls (kernel_bind(), kernel_connect(), etc.) or
system calls (bind(), connect(), etc.).

=======
Patches
=======
* Patch 1 fixes the sock_addr bind test program to work for big endian
  architectures such as s390x.
* Patch 2 introduces the new kfuncs to bpf_testmod.
* Patch 3 introduces the BPF program which allows us to invoke these
  kfuncs invividually from the test program.
* Patch 4 lays the groundwork for IPv4 and IPv6 sockaddr hook coverage
  by migrating much of the environment setup logic from
  bpf/test_sock_addr.sh into prog_tests/sock_addr.c and moves test cases
  to cover bind4/6, connect4/6, sendmsg4/6 and recvmsg4/6 hooks.
* Patch 5 makes the set of socket operations for each test case
  configurable, laying the groundwork for Patch 6.
* Patch 6 introduces two sets of sock_ops that invoke the kernel
  equivalents of connect(), bind(), etc. and uses these to add coverage
  for the kernel socket functions.

=======
Changes
=======
v2->v3
------
* Renamed bind helpers. Dropped "_ntoh" suffix.
* Added guards to kfuncs to make sure addrlen and msglen do not exceed
  the buffer capacity.
* Added KF_SLEEPABLE flag to kfuncs.
* Added a mutex (sock_lock) to kfuncs to serialize access to sock.
* Added NULL check for sock to each kfunc.
* Use the "sock_addr" networking namespace for all network interface
  setup and testing.
* Use "nodad" when calling "ip -6 addr add" during interface setup to
  avoid delays and remove ping loop.
* Removed test cases from test_sock_addr.c to make it clear what remains
  to be migrated.
* Removed unused parameter (expect_change) from sock_addr_op().

Link: https://lore.kernel.org/bpf/20240412165230.2009746-1-jrife@google.com/T/#u

v1->v2
------
* Dropped test_progs/sock_addr_kern.c and the sock_addr_kern test module
  in favor of simply expanding bpf_testmod and test_progs/sock_addr.c.
* Migrated environment setup logic from bpf/test_sock_addr.sh into
  prog_tests/sock_addr.c rather than invoking the script from the test
  program.
* Added kfuncs to bpf_testmod as well as the sock_addr_kern BPF program
  to enable us to invoke kernel socket functions from
  test_progs/sock_addr.c.
* Added test coverage for kernel socket functions to
  test_progs/sock_addr.c.

Link: https://lore.kernel.org/bpf/20240329191907.1808635-1-jrife@google.com/T/#u

Jordan Rife (6):
  selftests/bpf: Fix bind program for big endian systems
  selftests/bpf: Implement socket kfuncs for bpf_testmod
  selftests/bpf: Implement BPF programs for kernel socket operations
  selftests/bpf: Move IPv4 and IPv6 sockaddr test cases
  selftests/bpf: Make sock configurable for each test case
  selftests/bpf: Add kernel socket operation tests

 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 255 +++++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  27 +
 .../selftests/bpf/prog_tests/sock_addr.c      | 939 +++++++++++++++---
 .../testing/selftests/bpf/progs/bind4_prog.c  |  18 +-
 .../testing/selftests/bpf/progs/bind6_prog.c  |  18 +-
 tools/testing/selftests/bpf/progs/bind_prog.h |  19 +
 .../selftests/bpf/progs/sock_addr_kern.c      |  65 ++
 tools/testing/selftests/bpf/test_sock_addr.c  | 192 ----
 8 files changed, 1192 insertions(+), 341 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bind_prog.h
 create mode 100644 tools/testing/selftests/bpf/progs/sock_addr_kern.c

-- 
2.44.0.769.g3c40516874-goog


