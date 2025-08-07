Return-Path: <linux-kselftest+bounces-38430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B67B1D0F3
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 04:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AB118A2E3D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 02:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19D91D9346;
	Thu,  7 Aug 2025 02:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hq3TbBIj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89291D7999;
	Thu,  7 Aug 2025 02:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754534125; cv=none; b=ewZvF5gOmx70QBQKDII2//HMjMeCN8IcKqq+dLc8TTn/ra3YHcSmtyzdSeAmp/AOAEAA4cm3hdSEfRicjB+XqHOakYDZqyDceTEnau3/ikz6GYX9UXknDv98rv2jOjZyoMwpl846PzMEStYf3Zx+jkO3XcKIYoP5KuFWUeEFi4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754534125; c=relaxed/simple;
	bh=7hVAfcqAgaYpVQokh25xUgSQkQMcqBOkH/vqk/zJrd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Opzi/td/bYEHddHRpTgC0RMb/MMtNaveNwoAFpJp5iSSnWdag+9rUVE7M46FxywtQKY5lSNwJIv2EkMDE1NYNq9dvWDCXpxEwSbK8xYeEmfqhzSl4dbVDd6+CYKkcjuIT1sVH4iwkric5/6lOZ2Jcdbm8Qpkxe9SfKiw5DhH5Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hq3TbBIj; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vR
	dlolRxbfYcANPYTJRKuj40nKp0T7DfjSQFtFyllVM=; b=hq3TbBIji8IAngxR57
	SL0kR3zDkyX5oThCJ9SGje8Msbz8oTzoZesiYvremW1s03850+NpQFcrdsm8jYjp
	W+ZeiCpzO1b8bIvTM7HkWEvFE+5YN9khKm08vEQZWEYYOBgtjDzwTIlt41lJcFvo
	un7J3IMOkJVecp/tMOvsHFgaU=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD331O2EJRoF+MEAQ--.33482S2;
	Thu, 07 Aug 2025 10:34:32 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v8 0/2] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Thu,  7 Aug 2025 02:34:26 +0000
Message-ID: <20250807023430.4566-1-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD331O2EJRoF+MEAQ--.33482S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWxGr13ZF17Cw18Gry5CFg_yoW8tr4UpF
	WfK3s8trWjya47JFsxXr42yrW3Wan7GF4UCFn2qw1Yvw4rGFyxJrWxKw15GrnxGas3Xa4a
	vF1DtF15G3WFywUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBawSiiGiUBcBW7AABsH

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
- Add a bpf-next tag to the patch series.
- update the commit message of the second commit

Jiawei Zhao (2):
  libbpf: fix USDT SIB argument handling causing unrecognized register
    error
  selftests/bpf: Add an usdt_o2 test case in selftests to cover SIB
    handling logic

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


