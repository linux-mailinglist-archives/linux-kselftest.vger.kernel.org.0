Return-Path: <linux-kselftest+bounces-39692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8B9B31E4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 17:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34BA5A4E24
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 15:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF7023C505;
	Fri, 22 Aug 2025 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f3uNMi9/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2080C220685;
	Fri, 22 Aug 2025 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875810; cv=none; b=LjTBvVM+CdU6L669nYDoN0EDxhYE9ZExzaw+JH4GW2F477CMKrjQqWtOFL0dcL7qcvgXc7HPbWy+K09wdnXLf5N4xVHaY4q9eRxALOS9f/glcOOxdZJZ4ih7H20Xb5KhmVgnpYV6TI2RH/lRc4W5zNLk4FhbHoH8AeaQNZ0sDRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875810; c=relaxed/simple;
	bh=iK5wmQ+I3f5LF6dC/zmfN2jK4nfPtOFSHgDRkBZDTaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IEzERwDKce4uglTVrNdJDcSF60k6W6sZvpfzkvDvLjkwJlEZ6NeYuj8fLLE2p+WcTWbH6pZpj5QmpmIc3PcC3whznvLw+n0/3h8z+pZA+fuS+8BM/HclAmKbz377BHh6awDYbHjcxvdfvu4rI5JdoQ0x2vm3srJ3jNZfwCt3m4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f3uNMi9/; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=yl
	NXVlM9P4p/ikkluSZ10FXnbiODjfo2rjCRu5OPDIM=; b=f3uNMi9/IHszBhZuUt
	pxCtUszp1u+tUdwgiyeUfhaxKdH2H83Rzc89BQXIYYJDDQgYUsUvu4Evchmacn67
	WQUi+Of/BRq4MvAw7lmNQg5QvymrayBQGkK9AsgXt9EOFiny6Qjfh1FjQr1LaIRZ
	jDlKyvKtMzjWoS5hHiL7+SN1k=
Received: from phoenix.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBHTfm8iahoidrHAA--.29756S2;
	Fri, 22 Aug 2025 23:16:14 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v13 0/2] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Fri, 22 Aug 2025 15:16:09 +0000
Message-ID: <20250822151611.1084244-1-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBHTfm8iahoidrHAA--.29756S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4ktFy5Zr1xJr4UGF1UGFg_yoW5Cr1rpF
	WrGws8trWDtas7GFsxXr47tw43Wan5GFWUJFn2qw1Yvr4rGFnrJrWxKw15GrnxGa97X34Y
	vF4qyFZ8Gas5AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFB2xiGioZ+eKnAABsn

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

Jiawei Zhao (2):
  libbpf: fix USDT SIB argument handling causing unrecognized register
    error
  selftests/bpf: Enrich subtest_basic_usdt case in selftests to cover
    SIB handling logic

 tools/lib/bpf/usdt.bpf.h                      | 47 ++++++++++++++-
 tools/lib/bpf/usdt.c                          | 58 +++++++++++++++++--
 tools/testing/selftests/bpf/prog_tests/usdt.c | 44 +++++++++++++-
 tools/testing/selftests/bpf/progs/test_usdt.c | 30 ++++++++++
 4 files changed, 170 insertions(+), 9 deletions(-)

-- 
2.43.0


