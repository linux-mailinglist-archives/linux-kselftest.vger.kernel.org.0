Return-Path: <linux-kselftest+bounces-6882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB9B892407
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2EDC284D7B
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 19:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132E61327ED;
	Fri, 29 Mar 2024 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y1MeY2VW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640241EA8F
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739997; cv=none; b=pX/loY/Anmvl7gbEFPzquOriVr1UbZ0Dg5sV7yt6q36LUruCaAEkGhsKmE0dvm4fv+Dg01Tgkl5q91oL2VWH4tr3bpJX745O/QWaMyBT2WaXtrwa5/bn+v9dUKO1XcYyjVzI2ipP/ciy2SOtN94oWlfVh7bgH5M+qgERwKHWjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739997; c=relaxed/simple;
	bh=ovPBlX0Ihsgr+OXnRHxmJaWespcjwWWYmxe5wOJl6Ho=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ezEk2BRG5ZYoUlDIhn12u8bnMlndPCM0N4We+lTHti0byBEFkNasfep1s+MSEYQchTpCjb+ZpTdz9cff3GnbHqN3mS2xwYRcrFdy2scCNx0ywuM189xoNtm2NxqUZCQJ71yHwC6hGKVwAW0bhKLTSWL3GGQfWoaL/kgRBQp/Xf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y1MeY2VW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so3006950276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 12:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711739994; x=1712344794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HiQR+qeN0eLMe3Qk5Mv3315ozNW20sD67mSC+AnfNXU=;
        b=y1MeY2VWyRzRi3szEB8NGM6jryQ80B/vyJ30PdOML5vBes6BBxlHYc9uySGZvoXKGB
         Tfh9lq6CZWlZyGj0OXGjt17Gl9deRI0Hq5pC30n16zB0CFM1DA3W9knJIxU7NOSK62V2
         NT8pQ2Ss8GOWnfVMda0lkBQ0emdwnV7BTIV5iNxGDHUx8zSf6EdqMpB5ewresPTPfazH
         yX19W3TXy+VoN9KOKeGzER6yV7wLhGlGJVwgxE/jfTh5Is7KE00NalKejIHjKFlZS6x5
         dGv/uaHO0gwPxMM8ijXvHjbum/TdxJYFjUpdeoYEue3JRwlyiwGUaV9Cy/8zApqlM9qO
         eFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711739994; x=1712344794;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiQR+qeN0eLMe3Qk5Mv3315ozNW20sD67mSC+AnfNXU=;
        b=ERVuZBABuZq9+dnDnf+eMk9fT4f5BpqavvgKUT3CRZBJhimDnbIP1utvErQ1IXuQkZ
         oMonQEsavfFTZ6bia8TtH3iWyYOZX8JO3xp2e9fX8tYawobcjBtIEC9GxeU/OHxdibsj
         VpSCy14BaB8PSxcfzwkPX6NofN55hWKH2SxWd1L3KR3L6iNoFQX4usfvWDmPw39ndKpr
         whutprAi8jIJPZh3nYs+NneiMU03422rBgZIf2auPWgNc1NAUvudbSHf5EzQ74VX0WNX
         AlApUveLYUfPZ13XR3WtHAq2CY4WwCG8xpmGM2QHOKji2xZWg0F+py9pfJY6FwLox1uy
         aJxg==
X-Forwarded-Encrypted: i=1; AJvYcCW8yQkFuMwe3+fzNj4SlwbwoKhzvmVI2qWuG7g+n6l5qGM+evx+B7OIv/y+Kao4Fi8t1+8U4HSwnD7miu35q0vttaVOCaELn2OnobKh0QTz
X-Gm-Message-State: AOJu0YwLC5MHdrsc+qdL5fIV7uCU1DgGj6T2o091/w1VqAvWCwwnmHsS
	8J7srMiHlle4WNtEke8Lo2YfKfA3oFqRA0qCHir/U2ltMsjvhD2/IAZzQBb9TMIAZnbhg6Zzxw=
	=
X-Google-Smtp-Source: AGHT+IHycKiXa1fVoT16hnvaid8fq66fVG7ZtR0jHYoKj27g6QeRVdrX50QU8Fj9LTBMv/pVRbHzVHaFKw==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6902:110c:b0:dda:c566:dadd with SMTP id
 o12-20020a056902110c00b00ddac566daddmr234524ybu.4.1711739994444; Fri, 29 Mar
 2024 12:19:54 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:18:45 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329191907.1808635-1-jrife@google.com>
Subject: [PATCH v1 bpf-next 0/8] selftests/bpf: Add sockaddr tests for kernel networking
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

In a follow up to these patches,

- commit 0bdf399342c5("net: Avoid address overwrite in kernel_connect")
- commit 86a7e0b69bd5("net: prevent rewrite of msg_name in sock_sendmsg()")
- commit c889a99a21bf("net: prevent address rewrite in kernel_bind()")
- commit 01b2885d9415("net: Save and restore msg_namelen in sock_sendmsg")

this patch series introduces BPF selftests that test the interaction
between BPF sockaddr hooks and socket operations in kernel space. It
focuses on regression test coverage to ensure that these operations do not
overwrite their address parameter and also provides some sanity checks
around kernel_getpeername() and kernel_getsockname().

It introduces two new components: a kernel module called sock_addr_testmod
and a new test program called sock_addr_kern which is loosely modeled after
and adapted from the old-style bpf/test_sock_addr.c selftest. When loaded,
the kernel module will perform some socket operation in kernel space. The
kernel module accepts five parameters controlling which socket operation
will be performed and its inputs:

MODULE_PARM_DESC(ip,   "IPv4/IPv6/Unix address to use for socket operation");
MODULE_PARM_DESC(port, "Port number to use for socket operation");
MODULE_PARM_DESC(af,   "Address family (AF_INET, AF_INET6, or AF_UNIX)");
MODULE_PARM_DESC(type, "Socket type (SOCK_STREAM or SOCK_DGRAM)");
MODULE_PARM_DESC(op,   "Socket operation (BIND=0, CONNECT=1, SENDMSG=2)");

On module init, the socket operation is performed and results of are
exposed through debugfs.

- /sys/kernel/debug/sock_addr_testmod/success
  Indicates success or failure of the operation.
- /sys/kernel/debug/sock_addr_testmod/addr
  The value of the address parameter after the operation.
- /sys/kernel/debug/sock_addr_testmod/sock_name
  The value of kernel_getsockname() after the socket operation (if relevant).
- /sys/kernel/debug/sock_addr_testmod/peer_name
  The value of kernel_getpeername(() after the socket operation (if relevant).

The sock_addr_kern test program loads and unloads the kernel module to
drive kernel socket operations, reads the results from debugfs, makes sure
that the operation did not overwrite the address, and any result from
kernel_getpeername() or kernel_getsockname() were as expected.

== Patches ==

- Patch 1 introduces sock_addr_testmod and functions necessary for the test
  program to load and unload the module.
- Patches 2-6 transform existing test helpers and introduce new test helpers
  to enable the sock_addr_kern test program.
- Patch 7 implements the sock_addr_kern test program.
- Patch 8 fixes the sock_addr bind test program to work for big endian
  architectures such as s390x.

Jordan Rife (8):
  selftests/bpf: Introduce sock_addr_testmod
  selftests/bpf: Add module load helpers
  selftests/bpf: Factor out cmp_addr
  selftests/bpf: Add recv_msg_from_client to network helpers
  selftests/bpf: Factor out load_path and defines from test_sock_addr
  selftests/bpf: Add setup/cleanup subcommands
  selftests/bpf: Add sock_addr_kern prog_test
  selftests/bpf: Fix bind program for big endian systems

 tools/testing/selftests/bpf/Makefile          |  46 +-
 tools/testing/selftests/bpf/network_helpers.c |  65 ++
 tools/testing/selftests/bpf/network_helpers.h |   5 +
 .../selftests/bpf/prog_tests/sock_addr.c      |  34 -
 .../selftests/bpf/prog_tests/sock_addr_kern.c | 631 ++++++++++++++++++
 .../testing/selftests/bpf/progs/bind4_prog.c  |  18 +-
 .../testing/selftests/bpf/progs/bind6_prog.c  |  18 +-
 tools/testing/selftests/bpf/progs/bind_prog.h |  19 +
 .../testing/selftests/bpf/sock_addr_helpers.c |  46 ++
 .../testing/selftests/bpf/sock_addr_helpers.h |  44 ++
 .../bpf/sock_addr_testmod/.gitignore          |   6 +
 .../selftests/bpf/sock_addr_testmod/Makefile  |  20 +
 .../bpf/sock_addr_testmod/sock_addr_testmod.c | 256 +++++++
 tools/testing/selftests/bpf/test_sock_addr.c  |  76 +--
 tools/testing/selftests/bpf/test_sock_addr.sh |  10 +-
 tools/testing/selftests/bpf/testing_helpers.c |  44 +-
 tools/testing/selftests/bpf/testing_helpers.h |   2 +
 17 files changed, 1196 insertions(+), 144 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_addr_kern.c
 create mode 100644 tools/testing/selftests/bpf/progs/bind_prog.h
 create mode 100644 tools/testing/selftests/bpf/sock_addr_helpers.c
 create mode 100644 tools/testing/selftests/bpf/sock_addr_helpers.h
 create mode 100644 tools/testing/selftests/bpf/sock_addr_testmod/.gitignore
 create mode 100644 tools/testing/selftests/bpf/sock_addr_testmod/Makefile
 create mode 100644 tools/testing/selftests/bpf/sock_addr_testmod/sock_addr_testmod.c

-- 
2.44.0.478.gd926399ef9-goog


