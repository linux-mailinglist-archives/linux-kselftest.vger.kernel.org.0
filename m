Return-Path: <linux-kselftest+bounces-38185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E0AB1858E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 18:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41143BA051
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 16:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54D2279333;
	Fri,  1 Aug 2025 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FrgcFUGb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AC0156C40;
	Fri,  1 Aug 2025 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754064974; cv=none; b=pDK4TVddynM5VofubbZIHnOzCcYei7TTu3WUtqAgljr720X2d3Dl6sgHAyw/xB7nNDJoWYMWWj/JVrNe/CAA1ImMMjUHb7yiMjEo+AJGFerzh0Fg+0eIJw8SdMWmxLHsIvn9QFWbiY+q4CC+FsQXA/cOopE21PUGtxT22rxqxPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754064974; c=relaxed/simple;
	bh=/GDEpl+GURi2gAZ/4OZLKfziUx0o790Aio1JqXoFxrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZDNre8gGozv9aeGO/TneO4B8is1LzoLLqP/NH650+heooCzY6CP4o4uCszEgKPr3Hy+TFIZdH01h2G+HAZ2ClxoU29m2vQk2CTXsvvHkp1dUhcfhgMP9iLHwt1KLiDzrWita/k5nnvUfGk/sqHZpcS1c+D+Bwpyu5d9zrjEQfHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FrgcFUGb; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=JZ
	a4skPiXvCUobP8vOxW8boDrK4GqUNk6XWkfc60IGk=; b=FrgcFUGbminkPCG0mS
	c0MJFr97vSUl3ZcPk9roHXMtCIk5r5GmUdq/LYFjP02uQOBhZIRW1HHx/mj0LzRW
	CVS+lER9wO0/IeNfyGBydRHUxgz+N07OEWDJwWx1S96pe8k8BQUYkK7ayKEPosel
	lFXgXqA+UXFoTwtuI2l2Zi/tY=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDn7c0j6IxoIAufIw--.10599S2;
	Sat, 02 Aug 2025 00:15:34 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 0/1] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Fri,  1 Aug 2025 16:15:29 +0000
Message-ID: <20250801161531.816845-1-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7c0j6IxoIAufIw--.10599S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWxGr13ZF17Cw1UKr4xXrb_yoW8ZFWUpF
	WrKwn8KFWkta43GrsxXrsrtrWfWFZ5JF4UGF17Xw1YyF4rGFnrZrWxKay3Jr9xGas3Xay3
	ZF12yr98G3WrA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnhL8UUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBgAmciGiM5e83nQAAsZ

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


Do we need to add support for PC-relative USDT argument spec handling in libbpf?
I have some interest in this question, but currently have no ideas. Getting offsets
based on symbols requires dependency on the symbol table. However, once the binary
file is stripped, the symtab will also be removed, which will cause this approach
to fail. Does anyone have any thoughts on this?

Jiawei Zhao (1):
  libbpf: fix USDT SIB argument handling causing unrecognized register
    error

 tools/lib/bpf/usdt.bpf.h                      | 33 +++++++++++++-
 tools/lib/bpf/usdt.c                          | 43 ++++++++++++++++---
 tools/testing/selftests/bpf/Makefile          |  5 +++
 tools/testing/selftests/bpf/prog_tests/usdt.c | 18 +++++---
 4 files changed, 86 insertions(+), 13 deletions(-)

-- 
2.43.0


