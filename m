Return-Path: <linux-kselftest+bounces-24000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A2AA043FB
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 16:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E78318867C4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 15:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C02B1F3D4B;
	Tue,  7 Jan 2025 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a9oDTS+H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MlKdOtsV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6541F2C51;
	Tue,  7 Jan 2025 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262901; cv=none; b=dAZYu0LAVLyvS1G7PuY0WI1ehOdr8aSjBxEXAP2Bs9+qgEvMAcFs23U1yAihSvO6nLqiT/vOBfNFxu3YJMQ7YTs7Ffp4OmvRXtePTfbDRuDAVwcTeasa6v8SrLFTaGDugIolnMCl4K5uNoVb0RvYCI+2e71xyWPRVN1CiKkBcD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262901; c=relaxed/simple;
	bh=JV1EmwhzZN8rbAZfsKr/X1cMrrhDBFJbY8LiCwcvoc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cPeZlUyMNNtHFLzAUujNZa78wfCrz8vushfj+eqY4ANQeZ0VjEZKDiNc+0c9WoG3WfCc3XCWl/HCCkMRJKXK9jjGdgFESokjdJuTrRmZ60dISAe2pC0+nLO27a0UQg+UxUfYecGPcLFqO6aapgqtXAP7aGRaV36h1YsS2XIyUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a9oDTS+H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MlKdOtsV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736262895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xr/B0xvK7sGkfKbzNUSoXapb4RwCqM0VBcWsRspXohE=;
	b=a9oDTS+H17gco4eQ8kGhsCqsv9PlMnDDDlrs5LYGf2TxvF6Hc5SBP64YFNV0nppAvZUusn
	M/G7DF0KH/LcmAEI1xWxZL+QNzgVlBsgjstoBDXG+O5kcLjbzcxJ73XRFUfad5bU/BSlXo
	A7Y1TLhJxAJJJUB1Cu+ZmF8o4HPSLIsSPIGcqtN8vDA3eYzeCZSbOkqrbjlbcq4O2qsS/n
	7bsoJ93HjH1DQiw0HcpeuRycJzpZhiOC/HLEyk8byYgd9q0UkBKXyK2nM17peGau2Mh0ah
	0BAgqvWbeo6MZ37fDRAIoWa1XTY/LDxATu4Oigy2pzOK7TSbTD+y5AJX8XyKGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736262895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xr/B0xvK7sGkfKbzNUSoXapb4RwCqM0VBcWsRspXohE=;
	b=MlKdOtsVGTXjDdT5TITCXHSRGRiOVe9EHCVyyPc/IRYFURbCmmQ3GfZsh8mk9woFCpH0+G
	JprG5Ns6Ac7MHGDQ==
Date: Tue, 07 Jan 2025 16:14:46 +0100
Subject: [PATCH 2/3] selftests/mm: virtual_address_range: Avoid reading
 VVAR mappings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250107-virtual_address_range-tests-v1-2-3834a2fb47fe@linutronix.de>
References: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
In-Reply-To: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736262892; l=2470;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=JV1EmwhzZN8rbAZfsKr/X1cMrrhDBFJbY8LiCwcvoc8=;
 b=UWmnjc1iTVSO0yiJVv6/4RPN2Sb/xWnNUD78AugJktpFzXZZymMS0+1ZQxMl27beVnu+e+YDZ
 8Nc8ASPkmPSCTTatBfxeZhgcl4WR/ohvWgXLmHZ4bc0wTeHWOo89/b8
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The virtual_address_range selftest reads from the start of each mapping
listed in /proc/self/maps.
However not all mappings are valid to be arbitrarily accessed.
For example the vvar data used for virtual clocks on x86 can only be
accessed if 1) the kernel configuration enables virtual clocks and 2)
the hypervisor provided the data for it, which can only determined by
the VDSO code itself.
Since commit e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
the virtual clock data was split out into its own mapping, triggering
faulting accesses by virtual_address_range.

Skip the various vvar mappings in virtual_address_range to avoid errors.

Fixes: e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202412271148.2656e485-lkp@intel.com
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/mm/virtual_address_range.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index d7bf8094d8bcd4bc96e2db4dc3fcb41968def859..484f82c7b7c871f82a7d9ec6d6c649f2ab1eb0cd 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -116,10 +116,11 @@ static int validate_complete_va_space(void)
 
 	prev_end_addr = 0;
 	while (fgets(line, sizeof(line), file)) {
+		int path_offset = 0;
 		unsigned long hop;
 
-		if (sscanf(line, "%lx-%lx %s[rwxp-]",
-			   &start_addr, &end_addr, prot) != 3)
+		if (sscanf(line, "%lx-%lx %4s %*s %*s %*s %n",
+			   &start_addr, &end_addr, prot, &path_offset) != 3)
 			ksft_exit_fail_msg("cannot parse /proc/self/maps\n");
 
 		/* end of userspace mappings; ignore vsyscall mapping */
@@ -135,6 +136,10 @@ static int validate_complete_va_space(void)
 		if (prot[0] != 'r')
 			continue;
 
+		/* Only the VDSO can know if a VVAR mapping is really readable */
+		if (path_offset && !strncmp(line + path_offset, "[vvar", 5))
+			continue;
+
 		/*
 		 * Confirm whether MAP_CHUNK_SIZE chunk can be found or not.
 		 * If write succeeds, no need to check MAP_CHUNK_SIZE - 1

-- 
2.47.1


