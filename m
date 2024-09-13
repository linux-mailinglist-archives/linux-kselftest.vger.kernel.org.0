Return-Path: <linux-kselftest+bounces-17913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 138519776E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 04:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDD71C23FC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 02:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710E01D31A9;
	Fri, 13 Sep 2024 02:27:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5B84D2C;
	Fri, 13 Sep 2024 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726194459; cv=none; b=WpVg29x2Yd9vWPHw4ySBp6tx52zORtx09vng3ViTChUXQlPMC5o74bI1n3inHpS1tNwtboIup3uRGwhdARmw6UTQ3C3Z+zUSbTuwkd2iUOpRhkT1NNYhDxEUc/JpryyCuz+WWq+c4qEiYIbY7gAzcDXxb18RNI+0/+hgw+JL3EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726194459; c=relaxed/simple;
	bh=xrf9LMJ6PENE8uhAAkNO3tF7gaTWcljaji/FObqcAfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AvNHtWDJMnAxiF1n4Aa7T6ehY3L1RJ7Ulx9b3PteOi+a18dWq43z7BK5gPOIPFkkF/u0FFHJ63jIIHW04fN30ht1X8/E4wMEaxGW7sVkqYHxB2vSzdCYqL6Hb7FiOgM4cTsHui267wdrzLbP5ewbBxCnmAr08TnSmQsd0dJP8eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.53.31])
	by APP-01 (Coremail) with SMTP id qwCowAC3vh4Eo+NmTrhAAw--.28619S2;
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
Subject: [PATCH 1/2] selftest/mm: Fix typo in virtual_address_range
Date: Fri, 13 Sep 2024 10:26:34 +0800
Message-Id: <20240913022635.751505-1-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3vh4Eo+NmTrhAAw--.28619S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1UWrW8WryUtryrZw1fZwb_yoWDXwc_Xa
	1xt3s7ArZ093WY9r15JF1ruF4kCw15uFs7Cr1SqFyfJryUZF4fGFn5ur1DAF1ruFs8Gay3
	AFZxtFWfCr4YkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjxU7WrWUUUUU
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiBwsSB2bif7X3hgADsl

The function name should be *hint* address, so correct it.

Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
---
 tools/testing/selftests/mm/virtual_address_range.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index 4e4c1e311247..2a2b69e91950 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -64,7 +64,7 @@
 #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
 #endif
 
-static char *hind_addr(void)
+static char *hint_addr(void)
 {
 	int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
 
@@ -185,7 +185,7 @@ int main(int argc, char *argv[])
 	}
 
 	for (i = 0; i < NR_CHUNKS_HIGH; i++) {
-		hint = hind_addr();
+		hint = hint_addr();
 		hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
 			       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
-- 
2.34.1


