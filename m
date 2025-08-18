Return-Path: <linux-kselftest+bounces-39202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A87B29B32
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5225E7ABC
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 07:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03EF2868B5;
	Mon, 18 Aug 2025 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eET8mUIi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6EB27E1C8;
	Mon, 18 Aug 2025 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503236; cv=none; b=ixuN4zJJTOHIJVhqK9IQVwQx4nmIAYVUZoVfXPl5HWUWtWqqNeoLqxFXFubP6nhSoZHGGrwxgpYpyin/JvhNvthyLNCwSJXDtg58zKC6RGcBRUCasXo3nRYHGr83vaEJCAl/1KNRkYNppixXpYTHjJhWruT+rEh0bDRBt7AsiAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503236; c=relaxed/simple;
	bh=rwXrd3njpzajUE9E2ug4U+hdjQ2cCrmu61zrixeVHkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bGr80If+VJpIYeAKuTgIuExFYaVNDAZBU/yVJFGC0JLzZTefWyCTVwzbYOox453lOHGCyU2ZTOAdoVLJs4lrN1wWAzBATV5O/HAOhJ/mjaU8GLwTYDQ9AbSxqAxrdT7YUftf2gzEDnwARTXiwB7o2itMfYJoeu67rh+SEFRDLrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eET8mUIi; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=fc
	l/qUgtOK2x1pXF/2n0HGFA61fzpDx32xvg4eEilws=; b=eET8mUIiP5fZcb/KTL
	iHp7S9Sivl5qNC6gSpEH9x6s4nweKf/SQy8z8fGpAnF0Yo7cS4vF8UvDEWFk5GRp
	NCZynpsP88QF5uCfgCxc9JOIMQkaN+XNYq2exewFROyDRUam6lHeBQJ2dZKuzbHf
	yFL7s99GdMMxs+nzUxinVCkdk=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBH_+VZ2qJoyxi9Cg--.52195S2;
	Mon, 18 Aug 2025 15:46:35 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v11 0/3] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Mon, 18 Aug 2025 07:46:29 +0000
Message-ID: <20250818074632.433008-1-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH_+VZ2qJoyxi9Cg--.52195S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4ktFy5Zr1xJr4UGF1UGFg_yoW5AF45pF
	WrGws8trWUta4xGFsxXr47tw4fGan5GFWUCFn2qw1Yvr4rGF97Jr4xKw15JFnxGa97X34Y
	vFWqyFn8GasYyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBawqtiGii1GyMcwAAsJ

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

Jiawei Zhao (3):
  libbpf: fix USDT SIB argument handling causing unrecognized register
    error
  selftests/bpf: Add an usdt_o1 test case in selftests to cover SIB
    handling logic
  selftests/bpf: make usdt_o1 reliably generate SIB USDT arg spec

 tools/lib/bpf/usdt.bpf.h                      | 54 +++++++++++-
 tools/lib/bpf/usdt.c                          | 61 ++++++++++++--
 .../selftests/bpf/prog_tests/usdt_o1.c        | 82 +++++++++++++++++++
 .../selftests/bpf/progs/test_usdt_o1.c        | 37 +++++++++
 4 files changed, 227 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt_o1.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_o1.c

-- 
2.43.0


