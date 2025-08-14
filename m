Return-Path: <linux-kselftest+bounces-38969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 346BDB26872
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 16:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CFD16BAB4
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 13:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7850F3019A7;
	Thu, 14 Aug 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="csk0K8fI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F76226AA93;
	Thu, 14 Aug 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179808; cv=none; b=QjF4b1VOCYQVodRyS2hVmZxDn+/ukq/NPGeezVnglkpJU16Ur1H88bxm1m0p+pBHwwNX1j8Z1KoggV6E86Mlz0iS77uioEJR28DtYB86+jhsRpksNb4YeM1PbPiUqdryuXA9hC9d8vnadxAZu7EjpW/HhzBcbdmpxZU3fyYL4lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179808; c=relaxed/simple;
	bh=Uu2O3jtVyIS9/ciZPoBNz3qbVI6T1MtCa6jVVaRiWrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZpZ4r+Zajavna8mzuRboYysRVF1xDO/l/s0ESbO4GrZ6ETYQabTg/CyAev+TzUxSXroTr2LtChsFhj3GZ1jVZ0r/3JhkmTigchzZImJbNPw+GEMiOxBuF3nCypCcdluu4/V06zNSRfFRjn4ydPknia1Jsa1BE7BIqchUi2hGowM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=csk0K8fI; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=umrLwulu5jJ3xEjT65s2rUeaj1kRZFdWVqxTzTWx0mo=;
	b=csk0K8fIL0JLlBe4jnV+5/rX9Osix1m9fWI7OT2yT/v6lQRY0Ynrk958PWrZV+
	dYRDINIRUjAzIdEqbGPAMFkscIh0KZirpcOlWsenmfeTEXvNJ8XRiboj3soEPAyT
	q9EqayyfzPTq4LAi3xbILheuufMaWxFIllpEwbxhgujS4=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wB3HU_66p1ojNG2BQ--.14442S2;
	Thu, 14 Aug 2025 21:56:12 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v9 0/3] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Thu, 14 Aug 2025 13:56:04 +0000
Message-ID: <20250814135609.74738-1-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3HU_66p1ojNG2BQ--.14442S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4ktFy5Zr1xJr4UGF1UGFg_yoW5GF4xpa
	yrJ3s8tFW7ta47JFsrWr47tw4fGan3GrWUGF10qw1Yvr4rGFyxJr4xKry3JrnxGa95Xa4Y
	vF1DtF45Ga4rA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jopBfUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBaw6piGid5dt5oAAAsW

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

 tools/lib/bpf/usdt.bpf.h                      |    54 +-
 tools/lib/bpf/usdt.c                          |    61 +-
 tools/testing/selftests/bpf/Makefile          |     1 +
 .../selftests/bpf/prog_tests/usdt_o2.c        |    73 +
 .../selftests/bpf/progs/test_usdt_o2.c        |    37 +
 tools/testing/selftests/bpf/record.log        | 22207 ++++++++++++++++
 6 files changed, 22426 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt_o2.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_o2.c
 create mode 100644 tools/testing/selftests/bpf/record.log

-- 
2.43.0


