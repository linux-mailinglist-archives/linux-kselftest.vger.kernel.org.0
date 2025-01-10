Return-Path: <linux-kselftest+bounces-24214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CE9A0916C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 14:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFD6188DC4F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 13:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4326820E010;
	Fri, 10 Jan 2025 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cgMVMM0X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vnqKOQqc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902E20D4FD;
	Fri, 10 Jan 2025 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736514379; cv=none; b=pTFOB8sCCAnQSY85NhF2chGWFr1EKMhfE9umWEMML6I7Z0wv6K2C5HeBHNfX72Dtj/ygRKlWpc0z97SKu7w9O6xNRnpecOBP0ZEx/EBLrPOpW1XW/U7WhKa4BTqupE0r8yJlHRzCVMczuO7vMIcB7its8uDy+IPUp5Wrz41d9+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736514379; c=relaxed/simple;
	bh=bdSDA3kxsRphOJAe1hxQQ4SiKiKcoohRKkjKfuCnFKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y24YjCfMBe3jz/n2XJlxz4a8SYizJqv/GMLuE5qKjEvodnxNxVpYIC41z4cHpLfhPn4OLMlSqxzsyXx8bwE430EMMIv5hkkjTH6u9xNtBdiFb/mGhOrmbyNHYlPf3/d0OcE/3iNdYXg/doZ74pF6f16Ty/lBZao47xXZSASHRX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cgMVMM0X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vnqKOQqc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736514376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/HpKeU3nB17qCbgw45LzfDStDcTMTxJdySqt4LT06I=;
	b=cgMVMM0XMvPpgk7LQVls0/NjZqULU4tlyO7mR7tS+j2wRjYSlSDJj1NU5zpG7j3eU2jJG0
	RFR31a/9lS28uHmr5fDEca2yBUHlNtFks2HYxvKM9igXsAHf6VSe8gonN3qjICvqN6jeGv
	xqos6rZYmqHPdEixvDMfQdTPfVrFKQVEweEvgBMcnCOWHBzuI4IvcXz8ilknht6CFNqYbz
	rLVx5bNwFeFRmrti2Rkzn0CANvENJNbfUGCNDj4uAG3PEQd7rrtqgn7qx0kKr3OlcNGsKm
	8l2FXpnZyu5HLbFzfwPIGMNVChguSF/0q2e65AzVHOYHrfL7CVpcZ4EstcnZsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736514376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/HpKeU3nB17qCbgw45LzfDStDcTMTxJdySqt4LT06I=;
	b=vnqKOQqcnyThrY7uwgt10ODiZAJvUV1j7RK4XfnLpFpnSDHBblD4BPTaFhJM6d71HmumZy
	r3TkoT027CrLHjDg==
Date: Fri, 10 Jan 2025 14:05:52 +0100
Subject: [PATCH v2 3/3] selftests/mm: virtual_address_range: Avoid reading
 VVAR mappings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250110-virtual_address_range-tests-v2-3-262a2bf3c3d0@linutronix.de>
References: <20250110-virtual_address_range-tests-v2-0-262a2bf3c3d0@linutronix.de>
In-Reply-To: <20250110-virtual_address_range-tests-v2-0-262a2bf3c3d0@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 kernel test robot <oliver.sang@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736514373; l=1931;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=bdSDA3kxsRphOJAe1hxQQ4SiKiKcoohRKkjKfuCnFKc=;
 b=gKZeKPISRJ9eyZV3iQPMGCo8+Fm6utfH+O07hIoYZsNN5ZCKnoVoHyndhFCIolHxljj1aIu4l
 qp0SJjbKI5LBX7Q3yIWHuSlRgoFOxhE/K020QA06NXrxEPE/bZTtSOY
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The virtual_address_range selftest reads from the start of each mapping
listed in /proc/self/maps.
However not all mappings are valid to be arbitrarily accessed.
For example the vvar data used for virtual clocks on x86 [vvar_vclock]
can only be accessed if 1) the kernel configuration enables virtual
clocks and 2) the hypervisor provided the data for it.
Only the VDSO itself has the necessary information to know this.
Since commit e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
the virtual clock data was split out into its own mapping, leading
to EFAULT from read() during the validation.

Skip the various vvar mappings in virtual_address_range to avoid the issue.

Fixes: e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202412271148.2656e485-lkp@intel.com
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/mm/virtual_address_range.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index 4fc1c21a5e218eaec4d059b75c31a21dd4e8a215..993990aba56fc986c42084ffa91973558aa07e87 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -152,6 +152,10 @@ static int validate_complete_va_space(void)
 		if (prot[0] != 'r')
 			continue;
 
+		/* Only the VDSO can know if a VVAR mapping is really readable */
+		if (vma_name && !strncmp(vma_name, "[vvar", 5))
+			continue;
+
 		/*
 		 * Confirm whether MAP_CHUNK_SIZE chunk can be found or not.
 		 * If write succeeds, no need to check MAP_CHUNK_SIZE - 1

-- 
2.47.1


