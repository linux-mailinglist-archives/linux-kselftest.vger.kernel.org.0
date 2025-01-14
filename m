Return-Path: <linux-kselftest+bounces-24459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A29BA10BC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 17:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63123A84B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 16:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F80F1B6CF6;
	Tue, 14 Jan 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z/tZ0aXh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ztssdGuy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14B1607B4;
	Tue, 14 Jan 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870834; cv=none; b=mx+h5glRiSW0Y3iui7nNkd+ZyfT2uXGPRmJ/9Vt3m1tUUDTdcu7Pp36STywkHWQHIcLeQ2DmrfGQEgN3/oaL5Z3KIewOoon6O4Yjgaqo/Ry0bUao2Zn52c0sk4dgZbiZwMth6q4xFPMwfimxf/cU/zZOSu9fXLoZBSRws1M+PIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870834; c=relaxed/simple;
	bh=jY1f7K/6+plS20TimE67aTBJCu8JXlgGF6WROI3pbDA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jX1tuJoOTzSIhbbSvjYVKb4zVE8Xl5OrOxZ19NDjepoUfoVvE1RLdV9mveiwz+BIhN/nRCOuSytoMjdEERIMVPazb5Jf58uN6tqil3HIbygSJBpr5eWgq0Qb9Za1gYc1w989aa/i3FyqCI7P3Y4I5JQLepKUpGEieAanXKBHE+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z/tZ0aXh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ztssdGuy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736870828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MZHG5cplY7kOQjkYg0UFJ5wapfsIw4i4b0LWQfZHuc0=;
	b=z/tZ0aXh81J5YpaGd5ITORbmkhACMbvm9HjmELE72REQgA9EuMIPrhab4GCllreSpB4v1b
	gkCURpauuSfcRlmdhyL0THDvMnip9FQ7hdE+ZCk7m9gGo7LQF/z4ZJCZZvlS+0D13yfEkb
	B/mdHoSPx4KTyXh9oLbiFNk+SNycm7No3IEN2B83ysq3zBBVylaLDlyHPAhNUXxhjRODnZ
	6AVSYW1WKyro9YFgApTYR97wWdvShAk5fDRCwg/dVuIT2v/dm1Stko3Vj6/nEcdU09TQ+l
	6wWh6ggTrwvZ6Akm21udLjnEzhyk+HCTOkCqHZRdzkorC2LK5cDbta3R09fQTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736870828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MZHG5cplY7kOQjkYg0UFJ5wapfsIw4i4b0LWQfZHuc0=;
	b=ztssdGuyzyl7d4DYVeWXjNihOQFdu2SjfKrasg1ASUPcTFghF9jWeyEFxKRD0W1HvMlt04
	TPAJyyDUib5Bc3Cw==
Subject: [PATCH v4 0/4] selftests/mm: virtual_address_range: Reduce memory
 usage and avoid VM_IO access
Date: Tue, 14 Jan 2025 17:06:44 +0100
Message-Id: <20250114-virtual_address_range-tests-v4-0-6fd7269934a5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJSLhmcC/43OSwqDMBCA4atI1k2JSXy0q96jFIlmUgdESxKDR
 bx7oyspRbr8h+GbmYkDi+DINZmJhYAOhz6GPCWkaVX/BIo6NuGMZyxlBQ1o/ai6SmltwbnKbks
 enHf0kpVSFHlu1KUgUXhZMDht+v0Ru0XnB/vejoV0nf7nhpQyKkohFTe1LAzcOuxHb4cep7MGs
 tqB77yUHXs8ejznitdGNEKzX57Ye+LYE9EzUpWQ1/E70N/esiwf9N1sCGoBAAA=
X-Change-ID: 20250107-virtual_address_range-tests-95843766fa97
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>, 
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 kernel test robot <oliver.sang@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736870827; l=2074;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=jY1f7K/6+plS20TimE67aTBJCu8JXlgGF6WROI3pbDA=;
 b=5vgoHzJPyXAxCnx8bc1uNJMRsMHv/BNIZaNt9xqWXYnLMcD57iCcg37uUu6Nb+pKkTYM44AeG
 93quzhF3k6MCS4B6B4JoWonxhqon0Nnwg477bWYyDzhSIgAdptnxqUc
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The selftest started failing since commit e93d2521b27f
("x86/vdso: Split virtual clock pages into dedicated mapping")
was merged. While debugging I stumbled upon some memory usage
optimizations.

With these test now runs on a VM with only 60MiB of memory.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v4:
- Pick up review tags
- Correct Fixes: of patch 1
- Drop git rebase commit message artifacts
- Replace strtok_r() with strspn() and strcspn()
- Avoid uninitialized read on error in __get_smap_entry()
- Link to v3: https://lore.kernel.org/r/20250113-virtual_address_range-tests-v3-0-f4a8e6b7feed@linutronix.de

Changes in v3:
- Pick up review tags
- Fix naming around PR_SET_VMA_ANON_NAME helper functions
- Skip selftest if PR_SET_VMA_ANON_NAME is not supported
- Check for VM_IO instead of [vvar name prefix
- Link to v2: https://lore.kernel.org/r/20250110-virtual_address_range-tests-v2-0-262a2bf3c3d0@linutronix.de

Changes in v2:
- Drop /dev/null usage
- Avoid overcommit restrictions by dropping PROT_WRITE
- Avoid high memory usage due to PTEs
- Link to v1: https://lore.kernel.org/r/20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de

---
Thomas Weißschuh (4):
      selftests/mm: virtual_address_range: mmap() without PROT_WRITE
      selftests/mm: virtual_address_range: Unmap chunks after validation
      selftests/mm: vm_util: Split up /proc/self/smaps parsing
      selftests/mm: virtual_address_range: Avoid reading from VM_IO mappings

 tools/testing/selftests/mm/config                  |  1 +
 tools/testing/selftests/mm/virtual_address_range.c | 41 ++++++++++++--
 tools/testing/selftests/mm/vm_util.c               | 66 +++++++++++++++++-----
 tools/testing/selftests/mm/vm_util.h               |  1 +
 4 files changed, 92 insertions(+), 17 deletions(-)
---
base-commit: 3043cb9a517b707c12a3f5879f4970c97bfeb3fb
change-id: 20250107-virtual_address_range-tests-95843766fa97

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


