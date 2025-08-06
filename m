Return-Path: <linux-kselftest+bounces-38366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2845B1C345
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 11:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625F13A8176
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 09:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBC628A40E;
	Wed,  6 Aug 2025 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gSYDDIZe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD019220F3E;
	Wed,  6 Aug 2025 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472350; cv=none; b=fUlS+8WjNxwKJup7A3CWZqTxlVC1cLHUrVt1D+BQSSup1q+Wy94Gk4c4W2qrmUgSehjyF+zO+wqoP9tLfNTYSvHEHPcSy0dOq9zoSlE0SsRltGpliarKNGbZawUqmJQfH2+up+nIZyHCoohGdaG0+HzamQ+zzPKZsRq5Lghc5fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472350; c=relaxed/simple;
	bh=wlRiPYOA8q9srWjuD6UhCcsZrRYRB2qJ2XcRO6hfw2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4XGK20Uc40531M5xHVo8uwUO5cUVKntb8F3gitlmWDvbp/9awPZOGD39tiGTOIpTW/sWMi7+jlZMu9fO/zJ94WK2jlnxSDQIpygzW0R/41RVSqaGSYP5tTHYa/EwIoP7U+7+tUyd0pcnEp2O9EfSJ4ShHr0kelmCESZclw6mDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gSYDDIZe; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=p/
	cPmG9YXhoJ/wdCOQQpCHTyhofwY3x5TXeOe7cKTm8=; b=gSYDDIZeeRWY/Y4hnv
	5CQ0aDpHoND1g4z5ZYB9hvl9rx+Y0hdjAwOeoJqqy/GXwGk4uA68pI/39UxcG4wn
	kYxKRrajQEqLnh654RQN9xrO7AGv2HqVUwKMi/gnw/tPuASODUluDAwbQ/8A263t
	dynn73zygLbL4AU8nRwdb/T0o=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnD0ZrH5NoufpdAA--.11721S2;
	Wed, 06 Aug 2025 17:25:02 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Wed,  6 Aug 2025 09:24:56 +0000
Message-ID: <20250806092458.111972-1-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnD0ZrH5NoufpdAA--.11721S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWxGr13ZF17Cw18Gry5CFg_yoW5JrWUpa
	yrKwn8KrWUKa47JFsxXr47trWfWan3GF4UGFn7Xw15Ar4rGF1xZr4xK343Ar9xGasaqa4Y
	vFnFyF98G3WrA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFBmhiGiTGhU14QABsF

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

Do we need to add support for PC-relative USDT argument spec handling in
libbpf? I have some interest in this question, but currently have no 
ideas. Getting offsets based on symbols requires dependency on the symbol
table. However, once the binary file is stripped, the symtab will also be
removed, which will cause this approach to fail. Does anyone have any
thoughts on this?


Jiawei Zhao (2):
  libbpf: fix USDT SIB argument handling causing unrecognized register
    error
  selftests/bpf: Force -O2 for USDT selftests to cover SIB handling
    logic

 tools/lib/bpf/usdt.bpf.h                      | 33 ++++++++-
 tools/lib/bpf/usdt.c                          | 43 +++++++++--
 tools/testing/selftests/bpf/Makefile          |  8 +++
 .../selftests/bpf/prog_tests/usdt_o2.c        | 71 +++++++++++++++++++
 .../selftests/bpf/progs/test_usdt_o2.c        | 37 ++++++++++
 5 files changed, 185 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt_o2.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_o2.c

-- 
2.43.0


