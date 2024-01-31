Return-Path: <linux-kselftest+bounces-3779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5541B84327C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781241C24595
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 01:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A46A5F;
	Wed, 31 Jan 2024 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="s/LAlH4K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFC917BD7
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 01:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706663227; cv=none; b=e8n8RBsjcILfu2vXgZ0L+1/2GsImzXZ1zOMQ5YovE6plhscUyozBMF7tFZi7jHi86jIc+T0ezpz+57lF+hHDwrKUYGyOXUP6b0DUSE3lIQedK2N3WYzyjyUMbWu3V5T0STqyvGg6xtEHdUtnFgqYf9g44vSrZn4npzpYQ7dN3hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706663227; c=relaxed/simple;
	bh=3agc++PZjt4adgBO71Cp8EyaaOma0q0miHLEwYoM4tM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gdl0I0GzFHYEsn3hhKaccl1HTPeWh4jx9F+9TeAYXmFeDT5+OySfUyIhUw44vrTBPMVlA/WuRV/OLg+Eryky7q70O1sDAnMx98ID7tPqRAPMCx8iNr2CjmV2zNl10iHJvT4DqTsii9w0hA8OQ1MRhraLZGvrUK6s8zOE1L1Y1gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=s/LAlH4K; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d8a66a2976so41095985ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 17:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706663225; x=1707268025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISQ44kMse6Lkn35EK9G7PdGD5a4TdSkkmzrVy/QiW8Y=;
        b=s/LAlH4KYfzIG9i7MUYQHqhOQHjIGC7nOFBc25lm1enz8pGDTqsVDCnRzNRt3kIeAk
         tMPGA9fDaJtSKKM02P35uzSvWqSo8eucod8Wh8DwiYSN96d1AHpvdwhHO8expevUO1cE
         77LN669pNyFgJQ125KHOwgiBrBED542MRB61Syu/TmueG5dXrTBFFsFFiUgVu7yKxu2o
         uQ4dnfW3iSIj8hVIby5E4RWh2xVgQXkDH5BsEKVBGwyyuSZk2uc5gj9/vTdDs48QIp/t
         yboel+Ok+xlxtUGonkxysrg2rP1gIvOX7THZwCu1ka3quDXvvLtOmiDHgfGuFgYZk4/W
         FGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706663225; x=1707268025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISQ44kMse6Lkn35EK9G7PdGD5a4TdSkkmzrVy/QiW8Y=;
        b=dfpqAYdOKiUvyQWR6a/eXcWrZfwKlVmqyL0VTOqGYyPm+bDeDByubV/7o5na8dAJAp
         kk9pA83OMm9cJIk3y/N3R2YeuB3AblNpIAvLCbC2GFIUmbXRt8k/g07sz5tFE3Tw+DY4
         v7RCRuhUXmd8RwJmodl9C/ZMOeU3WefitEHcUD/fxwOylxA8JbRNjQUamP6CKAg2zOru
         xotzp92QpxC2qK5eMnrN0YCupdk50j/R0Vzrg8N6ludbyOKoPJu3WVlrPadVFC81EaHi
         2/LVssTCnUVz94v9in+70Ai9FW/Ze8HHseRR3xQMkS00NAjXBauJTDAiHHBO7y6rBEIz
         DGiQ==
X-Gm-Message-State: AOJu0YyHwgJFu0opZRl/CZGs9i6oPlVG0l8oBCtd7mEaqX660uX6BkDf
	01IZ3VWP7sQ4hFJcy7aanSC3tbjTypPv5zCt+G7UKUOfr1v4qH36fxKFzUf/ftY=
X-Google-Smtp-Source: AGHT+IF1fmnX78HPUX7rmBRccz3fIS+KOj7NE7osYGz6T48qtTIbzBRbCpuh11u5YSinOA7TvL7pUg==
X-Received: by 2002:a17:902:d891:b0:1d5:36e8:9ac0 with SMTP id b17-20020a170902d89100b001d536e89ac0mr323253plz.50.1706663225597;
        Tue, 30 Jan 2024 17:07:05 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id r12-20020a170903410c00b001d8d3c276c4sm4970822pld.35.2024.01.30.17.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 17:07:05 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 30 Jan 2024 17:07:00 -0800
Subject: [PATCH v3 1/3] riscv: mm: Use hint address in mmap if available
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-use_mmap_hint_address-v3-1-8a655cfa8bcb@rivosinc.com>
References: <20240130-use_mmap_hint_address-v3-0-8a655cfa8bcb@rivosinc.com>
In-Reply-To: <20240130-use_mmap_hint_address-v3-0-8a655cfa8bcb@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706663222; l=3095;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=3agc++PZjt4adgBO71Cp8EyaaOma0q0miHLEwYoM4tM=;
 b=AIKMSezNvXcphAUCcNCg21BBdaXUpcacXo54uEbl2OdGKMHckPpGf4N0pTfpvOAZ+GZExeI6t
 yXu3KlulVP2CvsGt2kGidzgw5nA924NJE/B8ZORdKYgHBzunKKkQbuk
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

On riscv it is guaranteed that the address returned by mmap is less than
the hint address. Allow mmap to return an address all the way up to
addr, if provided, rather than just up to the lower address space.

This provides a performance benefit as well, allowing mmap to exit after
checking that the address is in range rather than searching for a valid
address.

It is possible to provide an address that uses at most the same number
of bits, however it is significantly more computationally expensive to
provide that number rather than setting the max to be the hint address.
There is the instruction clz/clzw in Zbb that returns the highest set bit
which could be used to performantly implement this, but it would still
be slower than the current implementation. At worst case, half of the
address would not be able to be allocated when a hint address is
provided.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/processor.h | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index f19f861cda54..8ece7a8f0e18 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -14,22 +14,16 @@
 
 #include <asm/ptrace.h>
 
-#ifdef CONFIG_64BIT
-#define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
-#define STACK_TOP_MAX		TASK_SIZE_64
-
 #define arch_get_mmap_end(addr, len, flags)			\
 ({								\
 	unsigned long mmap_end;					\
 	typeof(addr) _addr = (addr);				\
-	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
+	if ((_addr) == 0 ||					\
+	    (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
+	    ((_addr + len) > BIT(VA_BITS - 1)))			\
 		mmap_end = STACK_TOP_MAX;			\
-	else if ((_addr) >= VA_USER_SV57)			\
-		mmap_end = STACK_TOP_MAX;			\
-	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
-		mmap_end = VA_USER_SV48;			\
 	else							\
-		mmap_end = VA_USER_SV39;			\
+		mmap_end = (_addr + len);			\
 	mmap_end;						\
 })
 
@@ -39,17 +33,18 @@
 	typeof(addr) _addr = (addr);				\
 	typeof(base) _base = (base);				\
 	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);	\
-	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
+	if ((_addr) == 0 ||					\
+	    (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
+	    ((_addr + len) > BIT(VA_BITS - 1)))			\
 		mmap_base = (_base);				\
-	else if (((_addr) >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) \
-		mmap_base = VA_USER_SV57 - rnd_gap;		\
-	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
-		mmap_base = VA_USER_SV48 - rnd_gap;		\
 	else							\
-		mmap_base = VA_USER_SV39 - rnd_gap;		\
+		mmap_base = (_addr + len) - rnd_gap;		\
 	mmap_base;						\
 })
 
+#ifdef CONFIG_64BIT
+#define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
+#define STACK_TOP_MAX		TASK_SIZE_64
 #else
 #define DEFAULT_MAP_WINDOW	TASK_SIZE
 #define STACK_TOP_MAX		TASK_SIZE

-- 
2.43.0


