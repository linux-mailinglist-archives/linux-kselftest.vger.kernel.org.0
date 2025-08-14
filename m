Return-Path: <linux-kselftest+bounces-38994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D0DB26C46
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 18:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41CB6806C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 16:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0C224EAB1;
	Thu, 14 Aug 2025 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="n6/gSe5k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B3C184;
	Thu, 14 Aug 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187696; cv=none; b=W3BuMirIbEH+85Y2dvPqa5dYWqS0Iw80uwJENaibz1EoZaibvDfEgg4yEVWdvNJ/YwEtLB0AKEkXqykIFmTq+dSIgiko69da8mQRJt4utB9tfB+N99auBphkcg5P72KIl+ls30ZsrTNrmo7lgS8Lx5J6NNuy1qN5v8Cd2H8IYek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187696; c=relaxed/simple;
	bh=AkOJYAfSU03UNBem+zavN7JuyZKK1aByA5MBFV4pzmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkOQ5J12N7yWRpUuy7glhsU3a/qAC0GNvTJ5wf2Yg/nBnfF0RA7ewPr4LnFQzW+wQ8IFHX4Zi1/Z6yjg4gJ4TTc/fqcuL8twM2+PS7H9swpKX9tAgQpMxG6ynxNMige9lmyq52nH83+vRdYvXYOH6r56WjEcWDsw39fy1IVnXM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=n6/gSe5k; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=VN
	G5t39SRqkXzyt7mfNlVPiAWBTeAtA1OtCt+HC0uE8=; b=n6/gSe5kTSLFgZMh5y
	1JKvTmAyZC58i5w4CVdtcG81n7bvLukP54KIkNv8faQooJqBUsYbrfYkEaL5ya7z
	sFXL7nI9eA48gNT3RVP+ori3AMB8ndfwaBCxmua0U9RgqpRxyVc+aSmYvNxPdKOh
	Xk+C7ej5aoeNe/4Mc/qA2dsx8=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAnEgTMCZ5otf6bBw--.46198S2;
	Fri, 15 Aug 2025 00:07:43 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v10 0/3] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Thu, 14 Aug 2025 16:07:36 +0000
Message-ID: <20250814160740.96150-1-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnEgTMCZ5otf6bBw--.46198S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4ktFy5Zr1xJr4UGF1UGFg_yoW5Xr4xpa
	yrKws8trWjya47GFsxWr42qw4fGan3GFWUGFn2qw1Yvr4rGFyxJr4xKr15JFnxGa93Xa4Y
	vF1DtFs8Gas5AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBawWpiGid-FPtBAAAs8

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

Change since v9:
- Only enable the usdt_o2 test case on x86_64 and i386 architectures since the
  SIB addressing mode is only supported on x86_64 and i386.

Jiawei Zhao (3):
  libbpf: fix USDT SIB argument handling causing unrecognized register
    error
  selftests/bpf: Add an usdt_o2 test case in selftests to cover SIB
    handling logic
  selftests/bpf: make usdt_o2 reliably generate SIB USDT arg spec

 tools/lib/bpf/usdt.bpf.h                      | 54 ++++++++++++-
 tools/lib/bpf/usdt.c                          | 61 ++++++++++++--
 tools/testing/selftests/bpf/Makefile          |  1 +
 .../selftests/bpf/prog_tests/usdt_o2.c        | 79 +++++++++++++++++++
 .../selftests/bpf/progs/test_usdt_o2.c        | 37 +++++++++
 5 files changed, 225 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt_o2.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_o2.c

-- 
2.43.0


