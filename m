Return-Path: <linux-kselftest+bounces-28321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5E5A5056E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 17:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DCB1888CA6
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 16:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A2819F489;
	Wed,  5 Mar 2025 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="veW3wVRx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2CA1A317E
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192826; cv=none; b=AqHJOMP7tGk59tFHlKQZem0QUWzjVx0DADmbYQrLi4Daoy7SDnVoh6BiGbnkML6UrdDcdUvKyYHmXynybBPGAV3b8cAQboTlknvFpcJp2OSaPalPshdqp0hQVIeTbdB+nICEX/Fef54z7z/WsT1LUVhmomIxsLi1jvM7I28isko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192826; c=relaxed/simple;
	bh=IQV0Yy/1k1IBFJFocoUYByRRAozlm7jKeZVmuUQRG8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h4TpGd4nVLaRzeKM7OjkXFJjQtCMOPvkNr+p0C8r9mNeqG1FZoJJDR0ABriwWe+AD62mscP6opiuwrTg6WUJhlnHuahRXDcj/z9wuSbgYdlimy6z5qkdIEhVvb79HaUeT4reuX2NwscXOuZxO3ofm5IKJPHeecZU1UTG89WofCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=veW3wVRx; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1741192812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jdlcaeLgpRGJb4WYxQLcnWtC/c9dZ1uqwhfx8n90Igk=;
	b=veW3wVRx/5NFTXbzOGBD5dHeuKAc9xZrmmidqKHhtwZ8eqxAQZizfNIZflx2AxELm4Sy55
	tPvi19YwvxMctpqHZUZ+vbo95LC1Owaj0S/nyM0bY5QNucCJAL+V1KgUjssvd0UejzXTrA
	gCvbJEf+CtzD/4lxRc5Kw6PPtYO4m0itXLcmCVMs1zKY61hKQJwScPCtBdgdK+CnD3DPLm
	8GKFQ7v+V9/E8UNMT4wXtZKbnIjpai0+b5MQJdW2SJwqyqKTUjRYP4Rb+KRTphNMQYh7lT
	Ko/AK9ZQXPe3ugMsSRT5sKB2/EwnPeoz7vbPh3Z1HAInmM2osu2rAOl+lkSm/A==
From: Ignacio Encinas <ignacio@iencinas.com>
Date: Wed, 05 Mar 2025 17:39:28 +0100
Subject: [PATCH] selftests: riscv: fix v_exec_initval_nolibc.c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-fix-v_exec_initval_nolibc-v1-1-b87b60e43002@iencinas.com>
X-B4-Tracking: v=1; b=H4sIAD9+yGcC/x2MWwqAIBAArxL7nWDa+yoRYrrVQlhoSBDePelzY
 GZeCOgJA4zFCx4jBTpdhqoswOzabcjIZgbBRcMlr9hKD4sKHzSKHN1RH8qdBy2G1UNvh641shM
 Wcn95zPL/nuaUPqBdQ0lrAAAA
X-Change-ID: 20250301-fix-v_exec_initval_nolibc-498d976c372d
To: linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Ignacio Encinas <ignacio@iencinas.com>
X-Migadu-Flow: FLOW_OUT

Vector registers are zero initialized by the kernel. Stop accepting
"all ones" as a clean value.

Note that this was not working as expected given that
	value == 0xff
can be assumed to be always false by the compiler as value's range is
[-128, 127]. Both GCC (-Wtype-limits) and clang
(-Wtautological-constant-out-of-range-compare) warn about this.

Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
---
I tried looking why "all ones" was previously deemed a "clean" value but
couldn't find any information. It looks like the kernel always 
zero-initializes the vector registers.

If "all ones" is still acceptable for any reason, my intention is to 
spin a v2 changing the types of `value` and `prev_value` to unsigned 
char.
---
 tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
index 35c0812e32de0c82a54f84bd52c4272507121e35..b712c4d258a6cb045aa96de4a75299714866f5e6 100644
--- a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
+++ b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
@@ -6,7 +6,7 @@
  * the values. To further ensure consistency, this file is compiled without
  * libc and without auto-vectorization.
  *
- * To be "clean" all values must be either all ones or all zeroes.
+ * To be "clean" all values must be all zeroes.
  */
 
 #define __stringify_1(x...)	#x
@@ -46,7 +46,7 @@ int main(int argc, char **argv)
 			: "=r" (value));					\
 		if (first) {							\
 			first = 0;						\
-		} else if (value != prev_value || !(value == 0x00 || value == 0xff)) { \
+		} else if (value != prev_value || value != 0x00) {              \
 			printf("Register " __stringify(register)		\
 				" values not clean! value: %u\n", value);	\
 			exit(-1);						\

---
base-commit: 03d38806a902b36bf364cae8de6f1183c0a35a67
change-id: 20250301-fix-v_exec_initval_nolibc-498d976c372d

Best regards,
-- 
Ignacio Encinas <ignacio@iencinas.com>


