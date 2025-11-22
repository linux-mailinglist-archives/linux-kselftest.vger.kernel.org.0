Return-Path: <linux-kselftest+bounces-46301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC9BC7C819
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 06:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D27124E2BE3
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 05:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DF329E114;
	Sat, 22 Nov 2025 05:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RCqbhBk0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C37217F27;
	Sat, 22 Nov 2025 05:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763790679; cv=none; b=ZMoYvhG4VSYJzpc5jLcPlLCYEtKBlFnq1ZJ3nN0Cv4GBSRIXMFy6s5aeMe8uOGWgmoOImLk+CbTRFxyyjbC39No3rHCLrn3reaRJYag4fEk2oola8zhl1W2BwGvpLoF4lxCk+Ju2k71eUQN326RxCGauo1Zxv+g0/IAIkkKQ03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763790679; c=relaxed/simple;
	bh=1D5v/fKgYYKYaoFZC629XonJ3BD4SQaUT1WaNW00avI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jvtusJCJfrt+LAeoxPoP3uV+5H7GXSC6ayWkhKo47/0dP1oxp66ZWFhxdvrbNH98wTOlHvE288n2ZyShcNGZIteUBwRLsEDpfhZD0hQSIDNs8f/uSPE8pQpD9CIBei+TZ8c0lG98bqUTbHo+nTFHWPey0jlUCbpQ5CI1lI8liPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RCqbhBk0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gj9M11rG3nyucSNDtSY6uj9N6BoDcuHAIv9iGYYsw3E=; b=RCqbhBk0/S8X7gn8AWgj6lf8Bs
	M3V/C87MVc8rMRWDOlGj0rBu37ylVn/YOsVvkw/cJhy+QUetxDVatZbGTUSYIpUJqEMSQ36I8RArq
	8NC6V7Gte3Ey4QSY4FaF3xWytKQmhVc9e+RgiL7Gjb1Bu5fXNtBBIZLfymcV5fB8F4Cxrw+gwrWYr
	sS7SYTsklti4T03sQpIRumcN+BurWZb2Vm5/0gRCuSn4OGI1BaZXG1yKQaPEgwNyIwwEUoGhSD1Tt
	GWnWGWSeNnGB4pxis7A1S69bkk/gZmO60UiNK5jiybp10lL4YQBnjidp6nbvgaV+rTW6THFe0Fssw
	p/oesqlg==;
Received: from [187.101.0.152] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vMgWZ-003xEt-7p; Sat, 22 Nov 2025 06:51:06 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v6 0/9] futex: Create {set,get}_robust_list2() syscalls
Date: Sat, 22 Nov 2025 02:50:42 -0300
Message-Id: <20251122-tonyk-robust_futex-v6-0-05fea005a0fd@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADJPIWkC/23N0Q6CIBTG8VdpXEdDFIqueo/WGspRzyppgEznf
 PfQLlqbl/9vO78zEQ8OwZPzbiIOInq0XQq535Gq1V0DFE1qwhkXjHNBg+3GB3W27H24132AgUq
 mDYDRlVSCpMO3gxqHFb3eUrfog3Xj+iMWy/rlBGdbXCwoo1nGc6ZyEMrABRv9RH2o7IssXhQ/Q
 3K5aYjFOKpMFaY0cKr/jHmeP1YJqZT5AAAA
X-Change-ID: 20250225-tonyk-robust_futex-60adeedac695
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Waiman Long <longman@redhat.com>, Ryan Houdek <Sonicadvance1@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.3

Hello,

This version is a complete rewrite of the syscall (thanks Thomas for the
suggestions!). 

 * Use case

The use-case for the new syscalls is detailed in the last patch version:

  https://lore.kernel.org/lkml/20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com

 * The syscall interface

Documented at patches 3/9 "futex: Create set_robust_list2() syscall" and
4/9 "futex: Create get_robust_list2() syscall".

 * Testing

I expanded the current robust list selftest to use the new interface,
and also ported the original syscall to use the new syscall internals,
and everything survived the tests.

 * Changelog

Changes from v5:
 - Complete interface rewrite, there are so many changes but the main
   ones are the following points
 - Array of robust lists now has a static size, allocated once during the
   first usage of the list
 - Now that the list of robust lists have a fixed size, I removed the
   logic of having a command for creating a new index on the list. To
   simplify things for everyone, userspace just need to call
   set_robust_list2(head, 32-bit/64-bit type, index).
 - Created get_robust_list2()
 - The new code can be better integrated with the original interface
 - v5: https://lore.kernel.org/r/20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com

Feedback is very welcomed!

---
André Almeida (9):
      futex: Use explicit sizes for compat_robust_list structs
      futex: Make exit_robust_list32() unconditionally available for 64-bit kernels
      futex: Create set_robust_list2() syscall
      futex: Create get_robust_list2() syscall
      futex: Wire up set_robust_list2 syscall
      futex: Wire up get_robust_list2 syscall
      selftests/futex: Expand for set_robust_list2()
      selftests/futex: Expand for get_robust_list2()
      futex: Use new robust list API internally

 arch/alpha/kernel/syscalls/syscall.tbl             |   2 +
 arch/arm/tools/syscall.tbl                         |   2 +
 arch/m68k/kernel/syscalls/syscall.tbl              |   2 +
 arch/microblaze/kernel/syscalls/syscall.tbl        |   2 +
 arch/mips/kernel/syscalls/syscall_n32.tbl          |   2 +
 arch/mips/kernel/syscalls/syscall_n64.tbl          |   2 +
 arch/mips/kernel/syscalls/syscall_o32.tbl          |   2 +
 arch/parisc/kernel/syscalls/syscall.tbl            |   2 +
 arch/powerpc/kernel/syscalls/syscall.tbl           |   2 +
 arch/s390/kernel/syscalls/syscall.tbl              |   2 +
 arch/sh/kernel/syscalls/syscall.tbl                |   2 +
 arch/sparc/kernel/syscalls/syscall.tbl             |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl             |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl             |   2 +
 arch/xtensa/kernel/syscalls/syscall.tbl            |   2 +
 include/linux/compat.h                             |  13 +-
 include/linux/futex.h                              |  30 +-
 include/linux/sched.h                              |   6 +-
 include/uapi/asm-generic/unistd.h                  |   7 +-
 include/uapi/linux/futex.h                         |  26 ++
 kernel/futex/core.c                                | 140 ++++--
 kernel/futex/syscalls.c                            | 134 +++++-
 kernel/sys_ni.c                                    |   2 +
 scripts/syscall.tbl                                |   1 +
 .../selftests/futex/functional/robust_list.c       | 504 +++++++++++++++++++--
 25 files changed, 788 insertions(+), 105 deletions(-)
---
base-commit: c42ba5a87bdccbca11403b7ca8bad1a57b833732
change-id: 20250225-tonyk-robust_futex-60adeedac695

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


