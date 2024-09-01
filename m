Return-Path: <linux-kselftest+bounces-16908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CF5967B72
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 19:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7F12819C2
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E84517DFFC;
	Sun,  1 Sep 2024 17:24:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA9626AE8;
	Sun,  1 Sep 2024 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725211463; cv=none; b=N5T59xDMU3CR/zOO+ykSi2FnBtPmQszJyKG/rG8IBS8WpQycyt51LlYGbRe0m7EX442guzQhHPjU14o3bEyByLl6VgtLybcekqhPN/8k5VGIKIP6zhqf1HBRAt5lZ1xcQHMmpsfutjrXy4R3fdbL0O0lZRr1wJOeNoCq1p7SyCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725211463; c=relaxed/simple;
	bh=bs+qC6glSgwSCedgq3WLvudKNH/1oLu2pg4U7ZuhR8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HzRRDFikxWUQMxldQDGmZoFbsLrPLiaSIEts3pSKf9bDfUQea05tZDFURGJ7RLBGan+VO+y+LjfS6J2wxZCD+S4Bwj3gNsSNRPRjkqwzItGXyXh5gpqlFwIsN42gPVnqqzlpSFKvNtuhYbUOeWlf3G27muyv6lO0RQJWUVsN4gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WxdzL0BzQz9sSN;
	Sun,  1 Sep 2024 19:24:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TUoScOBEsnuO; Sun,  1 Sep 2024 19:24:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WxdzK6MP7z9sSK;
	Sun,  1 Sep 2024 19:24:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C43CA8B767;
	Sun,  1 Sep 2024 19:24:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Cn_kBlYynRVV; Sun,  1 Sep 2024 19:24:13 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.234.154])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 621E38B763;
	Sun,  1 Sep 2024 19:24:13 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Shuah Khan <shuah@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: vDSO: Build vDSO tests with O2 optimisation
Date: Sun,  1 Sep 2024 19:24:03 +0200
Message-ID: <46efa1f62e1604c98d10a1b6856a2b2aec0cfe9c.1725211324.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725211443; l=1306; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=bs+qC6glSgwSCedgq3WLvudKNH/1oLu2pg4U7ZuhR8k=; b=Tv9CZN256k/rxjkm7Waqxj89GaBVxfdFSDD8mxhQer/H94HByLm8t5CliDKIbNNciOGx4x4Mi 6xQ0AxpmqyoCJVNIYKtg06MzdHeHKUDcCdusJTxiCtP+s4w7Gn4RuUM
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Without -O2, the generated code for testing chacha function is awful.
GCC even implements rol32() as a function instead of just using the
rotlwi instruction, that function is 20 instructions long.

	~# time ./vdso_test_chacha
	TAP version 13
	1..1
	ok 1 chacha: PASS
	real    0m 37.16s
	user    0m 36.89s
	sys     0m 0.26s

Several other selftests directory add -O2, and the kernel is also
always built with optimisation active. Do the same for vDSO selftests.

With this patch the time is reduced by approx 15%.

	~# time ./vdso_test_chacha
	TAP version 13
	1..1
	ok 1 chacha: PASS
	real    0m 32.09s
	user    0m 31.86s
	sys     0m 0.22s

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/testing/selftests/vDSO/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index cfb7c281b22c..96f25aa2f84e 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -13,7 +13,7 @@ TEST_GEN_PROGS += vdso_test_correctness
 TEST_GEN_PROGS += vdso_test_getrandom
 TEST_GEN_PROGS += vdso_test_chacha
 
-CFLAGS := -std=gnu99
+CFLAGS := -std=gnu99 -O2
 
 ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
-- 
2.44.0


