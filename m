Return-Path: <linux-kselftest+bounces-40031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF4BB379D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 07:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B11E3B5747
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 05:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0557330F926;
	Wed, 27 Aug 2025 05:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PYyLAM/t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186D018FDDB;
	Wed, 27 Aug 2025 05:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756272725; cv=none; b=gKUf9s4fQytLXNecL0En8avjVhUC4TAukyXw2VPPPdGAcXLmHidjl3PMAZzMwIP216DJlYjwqGJwQEUj6dK2MTMdhLlrQsKNrn+tpjwBgtfVHkxvWRLbk16imz2k264Qwy+8aA3wrwq8Q/0bEnz8Km576zNqvdoSkhn/T0BEuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756272725; c=relaxed/simple;
	bh=1BHJF1h4JZLF7LABNHrdLQUa+nhGCuBTTqiPKQScGjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RuEIaGqW750arTlH6qXadwS5hGXZseWnAKOXsqSHhGBqcPRpiySMy1PXv4usl+aCy3xT5PW7W6myFEQ7gUH0IqJipGTHSAAhk8K/PdjoTExLRUrx0iyjyjMByTis4JblqnuR7DiGSYN3dtqibJeRLxEFBw8VaoJ8BhagcPfrT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PYyLAM/t; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Xb
	/sQq4p+ehlInw6xv3fSf5GeZqtRWl42FnrsJrIPHY=; b=PYyLAM/t33Js4LgT5L
	jzx44K2Y93yCyZ18VsooZUsVHHvoBlc9pAZf+TVpQOhdy4QUws9nWRvnMiCZwket
	M3hG/PTl7CjEd7G6K5QVEHLhTIKfzpz5Pw+XCwvcg111yT0EmWCxyujiL9QmsJAn
	+oLLClxx4iXgBp2OA5FGu92Ac=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXH3YxmK5oLPk1Ew--.15805S2;
	Wed, 27 Aug 2025 13:31:31 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v16 0/2] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Wed, 27 Aug 2025 05:31:26 +0000
Message-ID: <20250827053128.1301287-1-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXH3YxmK5oLPk1Ew--.15805S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4kGw1UKr1ftr1UKr4kJFb_yoWrJry5pF
	WrWws8KrWjy3Z7GFsxWr42yw43Gan5GF4UJr1vqw1Yvr48GF17Zr4Igr15WrnxXa92g34Y
	vFW3tFs8Gas5Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBgAW2iGiui+TTrwAAsu

When using GCC on x86-64 to compile an usdt prog with -O1 or higher
optimization, the compiler will generate SIB addressing mode for global
array, e.g. "1@-96(%rbp,%rax,8)".

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

Change since v15(resolve some review comments):
- https://lore.kernel.org/bpf/CAEf4BzaxuYijEfQMDFZ+CQdjxLuDZiesUXNA-SiopS+5+VxRaA@mail.gmail.com/
- https://lore.kernel.org/bpf/CAEf4BzaHi5kpuJ6OVvDU62LT5g0qHbWYMfb_FBQ3iuvvUF9fag@mail.gmail.com/
- https://lore.kernel.org/bpf/d438bf3a-a9c9-4d34-b814-63f2e9bb3a85@linux.dev/


Jiawei Zhao (2):
  libbpf: fix USDT SIB argument handling causing unrecognized register
    error
  selftests/bpf: Enrich subtest_basic_usdt case in selftests to cover
    SIB handling logic

 tools/lib/bpf/usdt.bpf.h                      | 44 +++++++++-
 tools/lib/bpf/usdt.c                          | 69 +++++++++++++--
 tools/testing/selftests/bpf/prog_tests/usdt.c | 84 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_usdt.c | 31 +++++++
 4 files changed, 219 insertions(+), 9 deletions(-)

-- 
2.43.0


