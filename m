Return-Path: <linux-kselftest+bounces-38937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E34E4B25C19
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 08:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A421C24CD4
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 06:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B3F255F31;
	Thu, 14 Aug 2025 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Hx0l1JLy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D161A8F6D;
	Thu, 14 Aug 2025 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153935; cv=none; b=jP84zm24JjGl3Te6KqpogfJ+GrP4pftgYuEeAwhbPQ1jqsZQ9G4pLn++w7k4iq7XELxsL5bGZKPkZ9Oo9qtAOXmqfjjVs4tJ4FrW4l4rDl0NhjzHXkiI9APQlJF8OTKvMcx6nyEk9k0oS7X61JeY0MEuFnr50WQwMJOjoIRRXLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153935; c=relaxed/simple;
	bh=YNja6IVSOY6sdmIEGLejUQMYR8hr8Qkd8soi9Q7EB60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uLDnGreZ80SMi1HV61eLSqvuCZp+sWauhn1rTa2CTofb8R1SjQDusV5ILptc3Wb88Sug7n4+Yvspxikr3bJhQmrrX5wT7WzsyHYSi3rzsqHAb+ACnTaehatAlIS74Y/pLOMV4D+f6oOqr8/PmTfBlHcrG0wJsul+Bbi8V/QL3fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Hx0l1JLy; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Xj
	br36XZUwrrEazXviwGyEwfOeujlfh38MalOHv4Awg=; b=Hx0l1JLy3dRQNxeAoq
	YS1XrQSRNBG2Y67W8hQ5YB1OpBPtTt++DnToXTskG98IUG6J6cSzA2WeuP4kJB8b
	5RuS50BJWfaMA5YY4LvmJvUQbYQSn5RcRkYEzWju1YstvbeRbOMsD3QGFhWNH5zz
	frnZhqSAMAde79ROeWyBrdFws=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCHVEjxhZ1oTQ2nBQ--.36242S2;
	Thu, 14 Aug 2025 14:45:07 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v8 0/2] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Thu, 14 Aug 2025 06:45:02 +0000
Message-ID: <20250814064504.103401-1-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHVEjxhZ1oTQ2nBQ--.36242S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWxGr13ZF17Cw18Gry5CFg_yoW8KF4Dpa
	yrK3s8tryUta43JFsxXr47tr43Gan3Gr4UGFn2qw1Yvr4rGFyxJr4xKr15JrnxGa95Xa4Y
	vF1DtFs8Ga4rAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjtC7UUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFAapiGidgJR9xwAAso

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


Jiawei Zhao (2):
  libbpf: fix USDT SIB argument handling causing unrecognized register
    error
  selftests/bpf: Add an usdt_o2 test case in selftests to cover SIB
    handling logic

 tools/lib/bpf/usdt.bpf.h                      | 55 ++++++++++++++-
 tools/lib/bpf/usdt.c                          | 61 ++++++++++++++--
 tools/testing/selftests/bpf/Makefile          |  1 +
 .../selftests/bpf/prog_tests/usdt_o2.c        | 69 +++++++++++++++++++
 .../selftests/bpf/progs/test_usdt_o2.c        | 37 ++++++++++
 5 files changed, 216 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt_o2.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_o2.c

-- 
2.43.0


