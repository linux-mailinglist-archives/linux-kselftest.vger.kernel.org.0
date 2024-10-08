Return-Path: <linux-kselftest+bounces-19227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DAF9944AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 11:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0471F24964
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 09:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A12192D99;
	Tue,  8 Oct 2024 09:48:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9BB173336;
	Tue,  8 Oct 2024 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380885; cv=none; b=ZqTTpO4/257Q9n/3QcDvjBM18Foz3VJ0Fnu+ZCfAdC4X2A4R29bbKI6rG13+eh4mpPsgdKoN9kJIt0VhH/l7b9N7wXsdNOaPrm4BIC0WVeL+2FFjoCc9y6ZSCmaSF6iMdJtccWVz5zWja7S4GqOXNO+SZkQZnPYtiupd0QKhB9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380885; c=relaxed/simple;
	bh=bgNpPZQslkr9MduVhlHVndZOYG2A081Dk6naFqoAVeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RPmQbeEZnGgUfmkenVcPZzSNtMJ6kIfINJgjUOgtjos5j6n8CUvW0xtBgwBHgdiNhlVZ/1dRJ4NNmdj67mlQvpAcyhW4HHvL9TZci40q7v7V1lp1gpxw/6KpP77KEJPPeKrCm88qFORUEkFUVrahsqW6P/Jjuq2vVuj9/qacl3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.53.31])
	by APP-01 (Coremail) with SMTP id qwCowAAH7nxf_gRnEkoDBQ--.54511S6;
	Tue, 08 Oct 2024 17:41:52 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V2 4/4] selftests/mm: skip virtual_address_range tests on riscv
Date: Tue,  8 Oct 2024 17:41:41 +0800
Message-Id: <20241008094141.549248-5-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008094141.549248-1-zhangchunyan@iscas.ac.cn>
References: <20241008094141.549248-1-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAH7nxf_gRnEkoDBQ--.54511S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww13Kr13WryrGw1rAr13Jwb_yoW8uw1Dpa
	4xA34Yvw10gFy7JF1kWr4DXFW8Ka1kGF48tFy8XryDury3Jry7ur4fKa1Ut3Wa9rWFqw4r
	Z3WSgasa9a4UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmKb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxF4iUUUUU
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiCQ8EB2cExhf1+gAAs4

RISC-V doesn't currently have the behavior of restricting the virtual
address space which virtual_address_range tests check, this will
cause the tests fail. So lets disable the whole test suite for riscv64
for now, not build it and run_vmtests.sh will skip it if it is not present.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
---
V1: https://lore.kernel.org/linux-mm/ZuOuedBpS7i3T%2Fo0@ghost/T/
---
 tools/testing/selftests/mm/Makefile       |  2 ++
 tools/testing/selftests/mm/run_vmtests.sh | 10 ++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 02e1204971b0..76a378c5c141 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -115,7 +115,9 @@ endif
 
 ifneq (,$(filter $(ARCH),arm64 mips64 parisc64 powerpc riscv64 s390x sparc64 x86_64 s390))
 TEST_GEN_FILES += va_high_addr_switch
+ifneq ($(ARCH),riscv64)
 TEST_GEN_FILES += virtual_address_range
+endif
 TEST_GEN_FILES += write_to_hugetlbfs
 endif
 
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index c5797ad1d37b..4493bfd1911c 100755
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


