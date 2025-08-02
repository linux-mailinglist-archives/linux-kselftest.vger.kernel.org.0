Return-Path: <linux-kselftest+bounces-38199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C255DB18A4C
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 03:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3E6AA5328
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 01:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C767E154BF5;
	Sat,  2 Aug 2025 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PtHKbAuy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E9841C72;
	Sat,  2 Aug 2025 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754099667; cv=none; b=jT9KvBG5Xi4C5wM5JvxAma4dIxWUPbRy1Knalzp9Plx0lgXTRL4fmx1LegkIPJxrL8SqN+07c4PVBoOm4RnKivqNVk5U+u/d5KzEkbY4EM4yE/wPePtWeG6qzoDDadSSz0TWTJmx9+pqzWJ38Phqr6XzT3YitxaVCbYoQnkHavA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754099667; c=relaxed/simple;
	bh=YLHOKuGfZu3vREHo+0w4CEBCbzZhDkckOW2LcFryUUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C1NTbcKK4SahHpoGyJMeT05jG0XuOtw6/0+5l0C8U0vd1A8XELK5yjYbP09c2KXNg/rgWR3NrQWF2XKC42ceJDSZEtox/KVcz2bCRL7y/wDai8j6wloVjLrok627qUzvLqux/KpJoPU0KBHGkHYI9TmVDmNZtd/GhmXr1VwB3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PtHKbAuy; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3W
	svc3m2ST0JMIIEnY4LvKx4YmcyVEzHJONNtMWgZZI=; b=PtHKbAuymPnb4nFECp
	/H6G0snFv+bQh0CccH2s/Vc2iOQlwjj8+XO43r2v06DOIrJJOlWhbkBsVacI+4J/
	2K5lQh8UR/3A65aQIYHzfwK66xnsyVgbr5NCSl+y0vDPlYLtLtZjn2g6WqorP6pH
	myvb9Slnc0yfjcEPsA4VGKRxA=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAn9dGhb41owA7sJQ--.1054S2;
	Sat, 02 Aug 2025 09:53:39 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Sat,  2 Aug 2025 01:53:33 +0000
Message-ID: <20250802015336.823054-1-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn9dGhb41owA7sJQ--.1054S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWxGr13ZF17Cw1UKr4xXrb_yoW8tr1xpF
	WrKwn8KFWDKa43GFsxXrsFyrWfWFs5JF4UCF17Xw1YyF4rGFnrZrWxK3y3CF9xGas3Xay3
	ZF12yF98G3WrA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jopBfUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBgAOdiGiNYdH4yQAAsy

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
 tools/testing/selftests/bpf/Makefile          |  5 +++
 tools/testing/selftests/bpf/prog_tests/usdt.c | 18 +++++---
 4 files changed, 86 insertions(+), 13 deletions(-)

-- 
2.43.0


