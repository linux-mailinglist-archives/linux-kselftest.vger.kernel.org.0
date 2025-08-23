Return-Path: <linux-kselftest+bounces-39782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1949B32730
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 09:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C521B67609
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 07:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C222153F1;
	Sat, 23 Aug 2025 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Vag11rd6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEF81E4AB;
	Sat, 23 Aug 2025 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755933555; cv=none; b=bsjN3Zw8llEqzW/0LC4EJLeq2fk7xZyhLDSyj2+dTGi1hcxxNyUE6sPOjxOU9ZfUqDEcJgvWD29RH04VpASqDp6oCmacOSV6H/LKnhbHs26Iurupgu3j1qSocOjRg9X/1tqkCWIewmrGOJrcBiEuYVgiVxb4cwvqrylf3bNP0yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755933555; c=relaxed/simple;
	bh=KitFibol2Aae7q/65u4KChsF9jZ+Luq0MZlvtX1tHAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4dWgEmPNlBSliLHspGGKwQbhjKcZaYIILLTPcgDcadAy2cxEsFxwICbXZ7dED0wKct9fqLatSSncgHQ4Cvc4P9qGhrAF00OCvPbncwOatX0on6NRSSxQBQgRJ14MxXmBpBS+Xmo1rZ/TCrJWmfzmsGZdBtVeCIVwnHrncITSuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Vag11rd6; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=OI
	Z18m9fJcHtCDCLIheqxHmmUxmgzQxXPzdeaAhEmr8=; b=Vag11rd6X7YDF1TntE
	Rj62heAmp9mt4NbloFqpfxoxJe2mZUIMVL6fs2l2wVn1BOGX+82yFfP7+3HDrnHj
	ZH5H46IJOOjS/nIcKWUsCWyYGWVai9rtjVFBlZjW7f/WQEsn2lZIyVkV0p4n4C8W
	RYmY4aqY+ZOrl0TgqcXxckXmc=
Received: from phoenix.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBHfPRQa6loSD0TAQ--.40650S2;
	Sat, 23 Aug 2025 15:18:42 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v15 0/2] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Sat, 23 Aug 2025 07:18:37 +0000
Message-ID: <20250823071839.1191350-1-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBHfPRQa6loSD0TAQ--.40650S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4ktFy5Zr1xJr4UGF1UGFg_yoW5uw1rpF
	WrWws8trWqyas7GFsxWr42yw43Wan5GF4UJrn2qw1Yvr4rGF17Ar4Igr15GrnxWa97X34Y
	vFs8tFs8GasYvw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrdb8UUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBawqyiGipYPOxzgAAs2

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

Change since v12:
- This patch is same with the v12 but with a new version number.

Change since v13(resolve some review comments):
- https://lore.kernel.org/bpf/CAEf4BzZWd2zUC=U6uGJFF3EMZ7zWGLweQAG3CJWTeHy-5yFEPw@mail.gmail.com/
- https://lore.kernel.org/bpf/CAEf4Bzbs3hV_Q47+d93tTX13WkrpkpOb4=U04mZCjHyZg4aVdw@mail.gmail.com/

Change since v14:
- fix a typo in __bpf_usdt_arg_spec

Jiawei Zhao (2):
  libbpf: fix USDT SIB argument handling causing unrecognized register
    error
  selftests/bpf: Enrich subtest_basic_usdt case in selftests to cover
    SIB handling logic

 tools/lib/bpf/usdt.bpf.h                      | 44 ++++++++++++-
 tools/lib/bpf/usdt.c                          | 57 +++++++++++++++--
 tools/testing/selftests/bpf/prog_tests/usdt.c | 62 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_usdt.c | 32 ++++++++++
 4 files changed, 186 insertions(+), 9 deletions(-)

-- 
2.43.0


