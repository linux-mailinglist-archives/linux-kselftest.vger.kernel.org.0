Return-Path: <linux-kselftest+bounces-17807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DE6976637
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 12:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B551C22185
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 10:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5228018BB9E;
	Thu, 12 Sep 2024 10:00:43 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C6D2629D;
	Thu, 12 Sep 2024 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135243; cv=none; b=tG+nWKSa22bDYs3cWZ7GgRYO7qy94pyp7ECsE2ciBBjythoOblRpb/6gMIvrsDgCik2DmUlxOfXgmwOpv4nuSU7zgK6OePafvkFsJ/heq0p4orpSvn3+gF/2NCz5dS6Gitnv8SxR5bGAbm4SuqdGyhqE2rwkGeZGu5iXp1yW1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135243; c=relaxed/simple;
	bh=OBD+dXqvWPqGp3jSNKUGmkOTrW32RsVIk9iVAbGrjkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FsRgawkr6GVD3wfYCeX34XwjZr+pssqgtj6rj0RI2GeGq43QCogkv0qml4/VZrxBoVHfRPRYLHrtN9t4PiLHS1JJcqnFpdW4J/F2TmhRlCstq0JXwROcWEoW2rMxSHZ97pXpSVxamKArtWMCIhQ2+nSR9YynThBw2DCs6cVaoEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.53.31])
	by APP-03 (Coremail) with SMTP id rQCowABXho61u+Jmfr4GAw--.13301S2;
	Thu, 12 Sep 2024 18:00:22 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] selftest/mm: Do not use hint for riscv mmap
Date: Thu, 12 Sep 2024 18:00:18 +0800
Message-Id: <20240912100018.736447-1-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXho61u+Jmfr4GAw--.13301S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1DCry3XFWkZF1xAFWDArb_yoW8Jw47pr
	97Gwn0kF1FqFnrJa1UXr17urWvkF1vqay0yr1Uu34S9r15Xr97uws7C3y7tFsxKFWrXrs3
	A3W0vw13uF4UX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
	DU0xZFpf9x07j5Z2-UUUUU=
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiBwsSB2bif7X3hgAAsm

When the virtual address range selftest is run on RISC-V platforms,
it is observed that using the hint address when calling mmap cannot
get the address in the range of that validate_addr() checks, also
that will cause '/proc/self/maps' have gaps larger than MAP_CHUNK_SIZE.

Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
---
 tools/testing/selftests/mm/virtual_address_range.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index 4e4c1e311247..25f3eb304999 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -64,6 +64,14 @@
 #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
 #endif
 
+#if defined(__riscv) && (__riscv_xlen == 64)
+static char *hind_addr(void)
+{
+	return NULL;
+}
+
+static void validate_addr(char *ptr, int high_addr) { }
+#else
 static char *hind_addr(void)
 {
 	int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
@@ -81,6 +89,7 @@ static void validate_addr(char *ptr, int high_addr)
 	if (addr > HIGH_ADDR_MARK)
 		ksft_exit_fail_msg("Bad address %lx\n", addr);
 }
+#endif
 
 static int validate_lower_address_hint(void)
 {
-- 
2.34.1


