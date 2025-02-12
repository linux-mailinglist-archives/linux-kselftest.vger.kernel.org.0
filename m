Return-Path: <linux-kselftest+bounces-26463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09CDA32632
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 13:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5425C168E7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 12:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C5A20CCDA;
	Wed, 12 Feb 2025 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a9gReCmn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KzVnUi34"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ED2209696;
	Wed, 12 Feb 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364561; cv=none; b=j1m+K5vV+Ch+HZaMiHNLDse+3UMEOmHN9cXNh7+ZSlxwhZsQfT/ihTO5ugyLUAo0VGLNrA9brtOFCZHDTHTKCFNSB747I7UzbSo+RSR+i+kVy57MfsHnpP9l4D7BqtvVZIc/H4TAnV7UCza2FoZ8tXZOo7VtX/QUVAywyXBr0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364561; c=relaxed/simple;
	bh=Z3DuBWiolyR+/hYM6KNiu+IxGCZbOsuSr/Aoh4+JX5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/EFh0jS45EEs86ZX5x1P7s4qoZLy53Vs8ODSsDWYctuWb5Otww1gpjD8GE3PmLE4eVDKICrRGrySco1LIB2oOlsmxkNWlyMVnBfzEz5Z2UChGuq1hhXbKdN88IRq88rRy0O/wFYDBbO6/DjXnhgaOktQE4jbw3p2JrEpfnz3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a9gReCmn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KzVnUi34; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739364558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRO/aCcLz5c3u/REzsM4oOV5h4ZskKLpS8CU6v4XYto=;
	b=a9gReCmnC7XI7cxq9UB1Fw/AGRgKOd1XXL0iAYc+qorhU5jzfBJSSUjYAarb1x9RCOWz8x
	HGzrzeePWrOm8T/cxTfgtORX4YJdsF9/Ps1ryhXL8RCVCq0h6+hS2GTyekgdRuNdu1q5nS
	DKBiwoAACo6WV2Mmr/hNV9xk1/s6LZ1VkIFdcZadFZm6MnUTc6oi73qhPSwKRlfr2/cc6N
	Wi9QPEv6IYv6B52E3nPZkeOfUlgSzJgbTHs70i0F7Zo9GF14mfLwxGQSVIkpuiUBtUfISf
	Ki3/RD1+v3YvJrnK4iV6VUmpoJyWTwcKvW8dFlczZD1HsP5MRPlIo+G80AGQFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739364558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRO/aCcLz5c3u/REzsM4oOV5h4ZskKLpS8CU6v4XYto=;
	b=KzVnUi34OjDF9ollf//8mUXu1v9G83HTe0nbKZ4dXQTuxcC9M+JLjkbl9EA+1r+hOiuI6O
	+6ui9WzPSsR3gjCg==
Date: Wed, 12 Feb 2025 13:49:12 +0100
Subject: [PATCH 1/2] MIPS: mm: Avoid blocking DMA zone with memory map
 memblock allocation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250212-kunit-mips-v1-1-eb49c9d76615@linutronix.de>
References: <20250212-kunit-mips-v1-0-eb49c9d76615@linutronix.de>
In-Reply-To: <20250212-kunit-mips-v1-0-eb49c9d76615@linutronix.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Paul Burton <paulburton@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 linux-mm@kvack.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739364553; l=1909;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Z3DuBWiolyR+/hYM6KNiu+IxGCZbOsuSr/Aoh4+JX5A=;
 b=OXcSbIpxkSAcwRHlbs6HEkqNZAr1X0CIlnfLaAoT1SSEcEMDWPzWfdYZd9W5RQPoUd7KDBMI5
 FrUSOFE+ZgQDd8N90ifgnRot3jhDXJfoQTpI9U4z66GBsSI9+Wtcn33
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

On MIPS the memblock allocator is configured to allocate bottom-up.
The memory map is allocated by the mm core through memblock and uses
MEMBLOCK_LOW_LIMIT as minimal address. This constant is defined as zero because
it assumes that "we are using top down, so it is safe to use 0 here".
So the memory map is allocated as close to 0 as possible, right where the DMA
zone will end up. As the memory map is allocated permanently and also larger
than the DMA zone, it makes the DMA zone unusable.

Temporarily switch to top-down allocation for the call to free_area_init() so
the memory map allocation does not fall into the DMA zone.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---

Another solution would be to change alloc_node_mem_map() in the mm core
to use __pa(MAX_DMA_ADDRESS) for the min_addr when calling
memmap_alloc(), as is done by the other callers of memmap_alloc().
Looping in the memblock maintainers for discussion.

This is reliably reproducible in QEMU. To reproduce, use the kunit
configuration from patch 2 of this series and run it like so:

./tools/testing/kunit/kunit.py run --arch mips64el --cross_compile $CROSS_COMPILE cs_dsp_wmfwV3_err_halo.wmfw_v2_coeff_description_exceeds_block

To: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 arch/mips/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 4583d1a2a73e7ff36a42f6017d9aef008e45df6e..712eb4762917261416f1fca2d9925a42107ef6c1 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -435,7 +435,9 @@ void __init paging_init(void)
 #endif
 	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
+	memblock_set_bottom_up(false);
 	free_area_init(max_zone_pfns);
+	memblock_set_bottom_up(true);
 }
 
 #ifdef CONFIG_64BIT

-- 
2.48.1


