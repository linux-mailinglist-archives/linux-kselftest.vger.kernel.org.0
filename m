Return-Path: <linux-kselftest+bounces-38978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC3AB26978
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 16:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE317607CFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 14:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB05A1F0E29;
	Thu, 14 Aug 2025 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Mzo6F6co"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72F51D6188;
	Thu, 14 Aug 2025 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181100; cv=none; b=aKYR7zyr4yqgvZ7kf9hasOvOJ7qfdveWb8B0is8gwS6Bq023tjSTiJIcHJkzmvqRbniDks3X3j2HGT9nN07uQQ4q+YjRy+eNd+uI7LwFEYoTXd3nhPMq24zzZJHNhlO8DbxhMBDPZGb3hY30xF6AJrFk5Lm52GrRo6GR1FPX82k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181100; c=relaxed/simple;
	bh=fkB8DkoZb1oZNbrYSSwnjyBm03Xw/im88bG42r7TEkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4foZsTh2IotsZYHBcxlPNUr7ZUr1A3iuu5mX4RT5ybGPo6HFNVsLdNYJm30a8tqJgNkq50mdKizyzQrmH3TfziLyGJcFplBjuUufU3cJ+QDi7Obl+GuEaJ+yxcU216ej0xg93ecOwA34t7pf08yhPbC5z9eZWt5yssawxU6qeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Mzo6F6co; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0O
	BOvNjE4rQN4ZWaV0+VTg3QRrUL9Y9ebRZMVvXEMMI=; b=Mzo6F6coua6wBtKhDi
	YgBghu9a/s8UbTedn382ewkp2uoFgSo5o2exy7iZlsi4RastDZVeSFytbqgLnJf6
	F0jE4NnXuM3qzG1Nd5HYkr8s7qP/8WgKErUHk2Pzg0tbSGdGK6hZmiYQ+tXOc1Ee
	18f7Q8EdTcTF1laF7O3Ar57Q0=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAXt8QG8J1otxnOBw--.45910S2;
	Thu, 14 Aug 2025 22:17:44 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v9 0/3] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Thu, 14 Aug 2025 14:17:37 +0000
Message-ID: <20250814141741.77698-1-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXt8QG8J1otxnOBw--.45910S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4ktFy5Zr1xJr4UGF1UGFg_yoW5Jw45pa
	yrK3s8tryjya47JFsxXr47tw4fGan3GrWUGF1Iqw1Yvr4rGFyxJr4xKr15JrnxGa95Xa4Y
	vF1DtF43Gas5A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrZ2fUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBgB2piGid6YUzlgABsB

When using GCC on x86-64 to compile an usdt prog with -O1 or higher
optimization, the compiler will generate SIB addressing mode for global
array and PC-relative addressing mode for global variable,
e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".

The current USDT implementation in libbpf cannot parse these two formats,
causing `bpf_program__attach_usdt()` to fail with -ENOENT
(unrecognized register).

This patch series adds support for SIB addressing mode in USDT probes.
The main changes include:
- add correct handling logic for SIB-addressed arguments in
  `parse_usdt_arg`.
- add an usdt_o2 test case to cover SIB addressing mode.

Testing shows that the SIB probe correctly generates 8@(%rcx,%rax,8) 
argument spec and passes all validation checks.

The modification history of this patch series:
Change since v1:
- refactor the code to make it more readable
- modify the commit message to explain why and how

Change since v2:
- fix the `scale` uninitialized error

Change since v3:
- force -O2 optimization for usdt.test.o to generate SIB addressing usdt
  and pass all test cases.

Change since v4:
- split the patch into two parts, one for the fix and the other for the
  test

Change since v5:
- Only enable optimization for x86 architecture to generate SIB addressing
  usdt argument spec.

Change since v6:
- Add an usdt_o2 test case to cover SIB addressing mode.
- Reinstate the usdt.c test case.

Change since v7:
- Refactor modifications to __bpf_usdt_arg_spec to avoid increasing its size,
  achieving better compatibility
- Fix some minor code style issues
- Refactor the usdt_o2 test case, removing semaphore and adding GCC attribute
  to force -O2 optimization

Change since v8:
- Refactor the usdt_o2 test case, using assembly to force SIB addressing mode.

Jiawei Zhao (3):
  libbpf: fix USDT SIB argument handling causing unrecognized register
    error
  selftests/bpf: Add an usdt_o2 test case in selftests to cover SIB
    handling logic
  selftests/bpf: make usdt_o2 reliably generate SIB USDT arg spec

 tools/lib/bpf/usdt.bpf.h                      | 54 +++++++++++++-
 tools/lib/bpf/usdt.c                          | 61 ++++++++++++++--
 tools/testing/selftests/bpf/Makefile          |  1 +
 .../selftests/bpf/prog_tests/usdt_o2.c        | 73 +++++++++++++++++++
 .../selftests/bpf/progs/test_usdt_o2.c        | 37 ++++++++++
 5 files changed, 219 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt_o2.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_o2.c

-- 
2.43.0


