Return-Path: <linux-kselftest+bounces-39503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4AAB2FBFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 16:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9BA189FABD
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15E24397A;
	Thu, 21 Aug 2025 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YLL/UP3h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5E323D7C1;
	Thu, 21 Aug 2025 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785222; cv=none; b=ii8w/LD3mIWgBi96Z+HdbJl54QAGUNLsO52Qid7oX/t6p2ijG+xwoIplV4BPK62aI8SQHIkc6BFI1eeoBT5mMrV/ueVwFLP5t0A9/wIxgvcVf3qImae6R5PWWiUUxRCdpix7S+TN+6vSr8OYWjARo8g0wTpE+kCWyp6Ek0KrYuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785222; c=relaxed/simple;
	bh=Vail83RRNr80X7YdiV8bcd9lALKG736LnkAi6724cqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RpZ6Y17/KF2PEm2dBQE6zKoBajNtXcrhDKpNpnCdRmrlyujiqe/D9hnuvAzAtn8z+O5NluCNWuMJK3p+liOxAf5iw3su658reDxfcF5wV1PlqiSLZk9Ta9bsD4LOwWAFe9/dBythGwB+2jHkrqWjDxA7z9lKUsmjjWJiM2dw2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YLL/UP3h; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=u4
	YuSkPEHbpSteJpb/E58W6qZC/ILSmjwkLuynr2Zj8=; b=YLL/UP3hNqMwuCZrkj
	eLqmzsO/roaPyMZlLcWr5gZChGQRhz5aov8a3ixl06KCb8UqdBJ776UBvbmy+t+Z
	9Bh0OVgG5JUsGzDi0DMUKXAAQz1vaP0x+nVPLaEu7UcJXQL00c2eY9QYF0Nb5vfB
	q2lu24vwqy949eiOmR8Z5qS0U=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wB3RUngJ6doG2VUDA--.41400S2;
	Thu, 21 Aug 2025 22:06:26 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v12 0/2] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Thu, 21 Aug 2025 14:06:21 +0000
Message-ID: <20250821140623.971621-1-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3RUngJ6doG2VUDA--.41400S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4ktFy5Zr1xJr4UGF1UGFg_yoW5ArW5pF
	WrGws8trWqyas7GFsxXr4Iyw43Wan5GFWUJFn2qw1Yvr4rGF9rJrWxKw15GFnxGa97X34Y
	vF4qyFs8Gas5AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBgASwiGim-6KgjQADsB

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

Change since v10:
- Replace `__attribute__((optimize("O2")))` with `#pragma GCC optimize("O1")`
  to fix the issue where the optimized compilation condition works improperly. 
- Renamed test case usdt_o2 and relevant files name to usdt_o1 in that O1
  level optimization is enough to generate SIB addressing usdt argument spec.

Change since v11:
- Replace `STAP_PROBE1` with `STAP_PROBE_ASM`
- Use bit fields instead of bit shifting operations
- Merge the usdt_o1 test case into the usdt test case

Jiawei Zhao (2):
  libbpf: fix USDT SIB argument handling causing unrecognized register
    error
  selftests/bpf: Enrich subtest_basic_usdt case in selftests to cover
    SIB handling logic

 tools/lib/bpf/usdt.bpf.h                      | 47 ++++++++++++++-
 tools/lib/bpf/usdt.c                          | 58 +++++++++++++++++--
 tools/testing/selftests/bpf/prog_tests/usdt.c | 30 ++++++++++
 tools/testing/selftests/bpf/progs/test_usdt.c | 28 +++++++++
 4 files changed, 156 insertions(+), 7 deletions(-)

-- 
2.43.0


