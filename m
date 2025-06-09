Return-Path: <linux-kselftest+bounces-34448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB8AAD19F2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 10:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26D7188C245
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 08:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34255202F8F;
	Mon,  9 Jun 2025 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZKywxUl2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A81386B4;
	Mon,  9 Jun 2025 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749458686; cv=none; b=ax8pJjRMcBE3+pQA13y6cKAZ5KR8qAb2n/HvDHxsYs8isjMboni3UX+00hztC1nMxgeNepVU5AyMe8nz3S6lf30fCZm/kMLv0Di62bVb1vx0+1vGKNCkMlASHIXX/+UrWGAvjDgbUkP0/frWv4z0KnsgC2Y/KNi+7Wz6NguxjaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749458686; c=relaxed/simple;
	bh=wp40Vudve8zgArYeg3zEvVtbWz1jKw8+l2M/WqgdZwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R67PTR6617zbGdATvhHXF9c2Bhz8IfprdA1JD6brKaA9lQzppKpNBieE4/lP/GrPvSphXkzq76pkMrqQopJY7vsoCUcnFlTm1Ka3PPQuUt0Wn7S5AFY71WqLKyh7w6MVqMsBzJ3P2PQEEvg+8Jw9pbrbcD25QdJhQ+gGluKmvf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ZKywxUl2; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5598etjW2083203
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 9 Jun 2025 01:40:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5598etjW2083203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025052101; t=1749458459;
	bh=XeEjxj+5U43nnzoPolYaMN1k+UVx9E4Wu9VYzadiJnM=;
	h=From:To:Cc:Subject:Date:From;
	b=ZKywxUl2pkWaBaLMnCCvoJMtgIC/t/fWf+lc18NaGN1iHX13Jobig1Ibs9nYSJcg8
	 NVCk9F/2uCulnkkAxhHMlZTGpFLZNrnofXVtuB/qJCUQ2898jrj8vrPMQ80lDW0Zgu
	 ndWbVIwDaw6eI361C/rqS04j6ptscoqCs0o1X/6tHtTczX62qy7UlQCecT8Dj8r4y1
	 qbsl1p/Nq5vuCdDVamaZUZ6ViuCjDLreW8Wqbu8IdCusO+jym8UxS6TqEEIWRzlFAk
	 MGDz3qSQxVw896KAgeF1QrCLQIL7zLqercdYbnKpLOGOnCPCASp9yz8cofv82z5c4C
	 YurmKJfzB3q3A==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        shuah@kernel.org, andrew.cooper3@citrix.com, sohil.mehta@intel.com,
        stable@vger.kernel.org
Subject: [PATCH v6 0/2] x86/fred: Prevent immediate repeat of single step trap on return from SIGTRAP handler
Date: Mon,  9 Jun 2025 01:40:52 -0700
Message-ID: <20250609084054.2083189-1-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

IDT event delivery has a debug hole in which it does not generate #DB
upon returning to userspace before the first userspace instruction is
executed if the Trap Flag (TF) is set.

FRED closes this hole by introducing a software event flag, i.e., bit
17 of the augmented SS: if the bit is set and ERETU would result in
RFLAGS.TF = 1, a single-step trap will be pending upon completion of
ERETU.

However I overlooked properly setting and clearing the bit in different
situations.  Thus when FRED is enabled, if the Trap Flag (TF) is set
without an external debugger attached, it can lead to an infinite loop
in the SIGTRAP handler.  To avoid this, the software event flag in the
augmented SS must be cleared, ensuring that no single-step trap remains
pending when ERETU completes.

This patch set combines the fix [1] and its corresponding selftest [2]
(requested by Dave Hansen) into one patch set.

[1] https://lore.kernel.org/lkml/20250523050153.3308237-1-xin@zytor.com/
[2] https://lore.kernel.org/lkml/20250530230707.2528916-1-xin@zytor.com/


This patch set is based on tip/x86/urgent branch.


Link to v5 of this patch set:
https://lore.kernel.org/lkml/20250606174528.1004756-1-xin@zytor.com/


Changes in v6:
*) Replace a "sub $128, %rsp" with "add $-128, %rsp" (hpa).
*) Declared loop_count_on_same_ip inside sigtrap() (Sohil).
*) s/sigtrap/SIGTRAP (Sohil).
*) Add TB from Sohil to the first patch.


Xin Li (Intel) (2):
  x86/fred/signal: Prevent immediate repeat of single step trap on
    return from SIGTRAP handler
  selftests/x86: Add a test to detect infinite SIGTRAP handler loop

 arch/x86/include/asm/sighandling.h         |  22 +++++
 arch/x86/kernel/signal_32.c                |   4 +
 arch/x86/kernel/signal_64.c                |   4 +
 tools/testing/selftests/x86/Makefile       |   2 +-
 tools/testing/selftests/x86/sigtrap_loop.c | 101 +++++++++++++++++++++
 5 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/sigtrap_loop.c


base-commit: dd2922dcfaa3296846265e113309e5f7f138839f
-- 
2.49.0


