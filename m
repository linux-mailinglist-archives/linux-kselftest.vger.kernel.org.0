Return-Path: <linux-kselftest+bounces-39781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DA7B3271E
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 08:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E01AAC428D
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 06:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DA32222D2;
	Sat, 23 Aug 2025 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OWiqrWYa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E414822259D;
	Sat, 23 Aug 2025 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755931854; cv=none; b=WH2HHrXJAKEg0d8Ll8y6cY5p3gIMioacfp6/wq7WQC5NCAD+Wg0z+VJadi1WNMlhybTPo4kx7702b4+l2sruUa9CSz8mEC1/edWR30D462PQ0Oj69rP+3Lz7K3AWW4GSrXpPol/MBDwfCgvQveiBqpNJCqCXFT3f04oKUYwcVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755931854; c=relaxed/simple;
	bh=Xu1KTs9YrlqBzPX7FyCGl6pGbxsunB6DwjpVd1dZVwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aG6A/HTVpcw3I7LZ0EwLBSKwBKsqv4Hc9kPsHM9c7kKF+2VH4ujkznE7eW9b2ZctNSrBXolM5IhwPy6psBVMXvO9/hV92NR6+SrDs/Vlvxe+0avSOQnufdtsS6CrL+d0VMPnyfkVDco+1SBHHqWBug3k4k4USsVmiIpp/vTleDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OWiqrWYa; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ot
	0XN5hmrW5u2kJcpWmjJSBYnA+EPfGrLvdVTkcdShk=; b=OWiqrWYa7EoJKlRHNR
	B2iNdrmRuUrZn989UjeG4zhy9iUJSjojaDGe15eC7nl+k/Rav8q5iTnsPzo6fZLp
	6efLSvEyvsHoUjiesOcyzXI27+iCjOhTB4sQNx5vYr+Io71DG4hS/NNDhmPARCfY
	C9w5L3ooGU0k6ZyJfLw8PoPg4=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAn8USdZKlohCriDQ--.20793S2;
	Sat, 23 Aug 2025 14:50:07 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v14 0/2] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Sat, 23 Aug 2025 06:50:02 +0000
Message-ID: <20250823065005.1187181-1-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn8USdZKlohCriDQ--.20793S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4ktFy5Zr1xJr4UGF1UGFg_yoW5urWDpF
	WrGws8KrWqyas7GFsxWr42yw43Wan5GF4UJrn2qw1Yvr4rGFy7Ar4Igr15GrnxWa97X34Y
	vFs8tF98GasYvw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jopBfUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFAqyiGipWPbE8QAAs+

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


