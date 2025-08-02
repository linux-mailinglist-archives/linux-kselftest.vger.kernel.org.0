Return-Path: <linux-kselftest+bounces-38205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1F8B18B73
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 10:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB50817DC4D
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 08:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC4620298E;
	Sat,  2 Aug 2025 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LtSECY5+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242961991DD;
	Sat,  2 Aug 2025 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754124529; cv=none; b=ooTILDAEuLRkPcGXZm/Y7R+XR9sExcgWyo3QVRKgsL5FYLaiZsJQW7YRSLn55hgVczbM1C+2KCBuB5K1BXxB23JuL+UhCW7WvJVxm8GxSyWzI550n+9hDxjBRVGmYoCELTSYX24qkU52cm6m1KlPuTbXqjDWXyBxetY3MCxzfvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754124529; c=relaxed/simple;
	bh=fREpQNUrtavxU8QayzqBdgeY5FpPd0Bho3ELIraYThQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=My0sDDTuWKYXT20V/jozyk4Z4AgVTo5rFPDpKYd7ZSRp+/cgcCn78TKkFB/JwB0xchhIoLPQvuvajN+ACLGxTEUolH1Wm9semglbjztzs1z4tD9t5jtERGIxojdEduZQfP7Eo5/EjmXFYHiJCKpYmvJEwsD0kIbLh+s0HQsV+CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LtSECY5+; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=zN
	AXx6WfWyovDgYFNAy9sMXGfSUDt+d5QpqplK6q7dk=; b=LtSECY5+NurLN2YZ0X
	ZcCNdigPQQ/TuxkwmMUFgKbenZbiIXjGVZy30P7zrj1gu92Twki9ocftJPevLro2
	zb1IIwhWxWbyilx6XbkSfBE8+1fRYtI9tT0ppemuHm+1IUJqrKC1lAVnkAwLNrmr
	NKEgamP62ONWy904XsX2sG/k0=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDX0bXE0I1oWsxLJQ--.56694S2;
	Sat, 02 Aug 2025 16:48:06 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Sat,  2 Aug 2025 08:48:01 +0000
Message-ID: <20250802084803.108777-1-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX0bXE0I1oWsxLJQ--.56694S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWxGr13ZF17Cw1UKr4xXrb_yoW8Kr18pF
	WrKwn8KFWqka43GFsrXr42yrWfWFs5GF4UGF17Xw1YyF4rGFnrZrWxK347CF9xGas3Xaya
	vF12yF98G3WrA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jopBfUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBgBmdiGiNzPBAzwAAsa


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
- force -O2 optimization for usdt.test.o to generate SIB addressing usdt
  argument spec.
- change the global variable t1 to a local variable, to avoid compiler
  generating PC-relative addressing mode for it.

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

 tools/lib/bpf/usdt.bpf.h                      | 33 +++++++++++++-
 tools/lib/bpf/usdt.c                          | 43 ++++++++++++++++---
 tools/testing/selftests/bpf/Makefile          |  8 ++++
 tools/testing/selftests/bpf/prog_tests/usdt.c | 18 +++++---
 4 files changed, 89 insertions(+), 13 deletions(-)

-- 
2.43.0


