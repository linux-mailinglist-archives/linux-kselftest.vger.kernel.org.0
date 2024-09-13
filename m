Return-Path: <linux-kselftest+bounces-17912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162049776E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 04:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1CF1F22076
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 02:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE571D3197;
	Fri, 13 Sep 2024 02:27:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD0B2AD17;
	Fri, 13 Sep 2024 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726194459; cv=none; b=dLG8S5+6+BWrkVIRtJ+ZTpK9BQSIJRn/fdjdQQFC7TdkTeS6ca3RjngRzET1EsA3TQcGuWl7BtnLjoZKXeVJBMZxZyICaZ3oOWJk0T1nK1BTgHtbetrEHY6kN9+2hx0jx97jkVTKM2ulznnFT3GLiQXbMqUBpHVKrbDzbdid3EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726194459; c=relaxed/simple;
	bh=r+50XrLvRja1NEXa/UF8fLt3iWBZuI++7VM2OW/k5lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NvRig5keSdOAEX31wA/1EXF0awH9gzcSjAqQ4z1/4K0UKJtFzBaXWHe5Ja/C7hmVfVn79TKtlyP0K0z8E5lQPPf9exqjr5jw8OwtidDo/Ai/+22EgJA8Fyt/aPlN50O/ifVfe9nsv0H30bQkb4qL3+SRnvlA9aBPceLuBIQtP7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.53.31])
	by APP-01 (Coremail) with SMTP id qwCowAC3vh4Eo+NmTrhAAw--.28619S3;
	Fri, 13 Sep 2024 10:27:18 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 2/2] selftests/mm: skip virtual_address_range tests on riscv
Date: Fri, 13 Sep 2024 10:26:35 +0800
Message-Id: <20240913022635.751505-2-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913022635.751505-1-zhangchunyan@iscas.ac.cn>
References: <20240913022635.751505-1-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3vh4Eo+NmTrhAAw--.28619S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww13Kr13WryrGw1rAr13Jwb_yoW8ZFW7pa
	4xA34Yvr10gFn7JF1kur4DXFW8Ka1kGF48tFyUZryDur13Jry7ur4fKr4Ut3WagrWFqw4r
	Z3WfW3s3Z3WUJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPEb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280
	aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI
	1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjxUx5EfUUUUU
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiDAgTB2bjgUZ5HAAAs3

RISC-V doesn't currently have the behavior of restricting the virtual
address space which virtual_address_range tests check, this will
cause the tests fail. So lets disable the whole test suite for riscv64
for now, not build it and run_vmtests.sh will skip it if it is not present.

Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
---
 tools/testing/selftests/mm/Makefile       |  2 ++
 tools/testing/selftests/mm/run_vmtests.sh | 10 ++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 84573ddfcfa2..912778347213 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -112,7 +112,9 @@ endif
 
 ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 powerpc riscv64 s390x sparc64 x86_64))
 TEST_GEN_FILES += va_high_addr_switch
+ifneq ($(ARCH),riscv64)
 TEST_GEN_FILES += virtual_address_range
+endif
 TEST_GEN_FILES += write_to_hugetlbfs
 endif
 
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 03ac4f2e1cce..7caa624a2e5a 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -347,10 +347,12 @@ if [ $VADDR64 -ne 0 ]; then
 	# allows high virtual address allocation requests independent
 	# of platform's physical memory.
 
-	prev_policy=$(cat /proc/sys/vm/overcommit_memory)
-	echo 1 > /proc/sys/vm/overcommit_memory
-	CATEGORY="hugevm" run_test ./virtual_address_range
-	echo $prev_policy > /proc/sys/vm/overcommit_memory
+	if [ -x ./virtual_address_range ]; then
+		prev_policy=$(cat /proc/sys/vm/overcommit_memory)
+		echo 1 > /proc/sys/vm/overcommit_memory
+		CATEGORY="hugevm" run_test ./virtual_address_range
+		echo $prev_policy > /proc/sys/vm/overcommit_memory
+	fi
 
 	# va high address boundary switch test
 	ARCH_ARM64="arm64"
-- 
2.34.1


