Return-Path: <linux-kselftest+bounces-3756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC65842C4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 20:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7018289BE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 19:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C4D12BF02;
	Tue, 30 Jan 2024 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pZU2Fhzv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D64F69D1E
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641476; cv=none; b=hluk52pAxS2zHBt8hZBEgY8sHH4DjfFC+mzDRHfcoeg0jaNWOJ07vU7uDm4GqmeCbl2ufuXfLR0Wp2u0svV0vCf7n6Q6pYoughhwF9W+ZppM7AnACve+LZ9L9qoz4H0fg0BPBeo21qGAKWrUkY/9qHnl3KZsdraa1AK6AGjHRR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641476; c=relaxed/simple;
	bh=nYPj/fyg4PYV9oZH+Numr3TDNqlT2v60F+fZG4ppm6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qYT90vJK79naKZlaeG8fjsAbOaauGtW38YA8TlsQkHrBDqOO/U3XvAHmnLdYjwsjSQY9fbY2fp7zOmmb2Ky4mpPhy+RytVV04Nup6zQ32iWe8TPvWZ+eAvoKbyRK1coIXLnppUIXuVAd6j7X4BihzWzdCXIqxHHF7tn/wC6Djs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pZU2Fhzv; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29065efa06fso3349590a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 11:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706641474; x=1707246274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yR39BQnx5CuM7HVAKBGyTLeOeO2w4fzgWq8LHVFIrGc=;
        b=pZU2FhzvR1dDjf8g9kUgB26AA0jhd7S+JnyIybHVEw91/vZuOwk/f6pbMeDUrFDMIT
         F/RBafodH/FI30TwRkZ6Qh/Td60oM1XOOBG0FSdyTxLs5UK9M1fCF3yArE3bIaoHC1GO
         zlOUTJQMYcctJB//I7FonxUJKPiEX++6MbRgl0Vqm2ixVw4nVU/J4LzE/yA7xOJVGCU0
         8hO2IkGnkthpufymXQe7r/bS12DMSNwT8kNjdTDEo+VpJtLd9z65o0Ii9pAOjtXYs7kO
         0e1W7uTCzBFijUDTvq0MplTfDayRz3opIeK+jjtIshOavcXwsfOD1Fyega+WwETBJGFg
         qOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706641474; x=1707246274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR39BQnx5CuM7HVAKBGyTLeOeO2w4fzgWq8LHVFIrGc=;
        b=YCCtCt62yBzpnWv4fylQ31Y1OaCnIaEZWnYd6CSmfxOxPzwC0K3UH+/wxJNqziU49Y
         4Xz6BxCQfOTIQo4mZuSavsgGuDi6iTHJ35iGJ05h/BAytzJogNxoHVwm3C5DfjY8w8+N
         cWQBT0AAWumBbXohwekDM7A0S3aErQ2O0Q54ALun17koxje7g67FmnFOaKy+BbWuS6VX
         Sdbqd2ExAZ37JioGJSfsVi6SkBsNQyHI6M3cF0jTOkyUjTDExQ7a1VLtBqq1n7ZXMkad
         QHd6sQmxE6u/9jHkYCvDUqSGjoU93bOTC2N5C7cS2enIhyDMkg2+Z/B94m7y33FIKXiA
         +sog==
X-Gm-Message-State: AOJu0YyEBvG8RElzZRDmZWmUCk7qM0dLwqwyjzOsDndXJNKgUL+GR4zy
	irofoVexabkcdzip1O8YV+K82nk8v+d5ODAQ9C2tou37tZ10WEzLYK3qZWBkReQ=
X-Google-Smtp-Source: AGHT+IGj3hm3lZxg8Tv1mA9a7NdziJNVi1CzW076g8O+NcVAU25Ai6hKEgTL594gTw3Fe+w4FPditw==
X-Received: by 2002:a17:90b:1d82:b0:293:e466:e82b with SMTP id pf2-20020a17090b1d8200b00293e466e82bmr6560721pjb.38.1706641473865;
        Tue, 30 Jan 2024 11:04:33 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f6-20020a17090aec8600b00295c3bb9318sm1196541pjy.54.2024.01.30.11.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:04:33 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 30 Jan 2024 11:04:30 -0800
Subject: [PATCH v2 1/3] riscv: mm: Use hint address in mmap if available
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-use_mmap_hint_address-v2-1-f34ebfd33053@rivosinc.com>
References: <20240130-use_mmap_hint_address-v2-0-f34ebfd33053@rivosinc.com>
In-Reply-To: <20240130-use_mmap_hint_address-v2-0-f34ebfd33053@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706641471; l=2717;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=nYPj/fyg4PYV9oZH+Numr3TDNqlT2v60F+fZG4ppm6A=;
 b=8TpBPUYlMpe99Wy4MtFO+G5FMsAU594qBMLjaPbbTQaF/l0GF2Rgz5PEarXQGUC7U59m+QmVJ
 rouYGXoseN8DFOk/KglyX6LbcysJhd8mJLV8BDu96je7w6S40qMm4Tt
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
 arch/riscv/include/asm/processor.h | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index f19f861cda54..5d966ae81a58 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -22,14 +22,12 @@
 ({								\
 	unsigned long mmap_end;					\
 	typeof(addr) _addr = (addr);				\
-	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
-		mmap_end = STACK_TOP_MAX;			\
-	else if ((_addr) >= VA_USER_SV57)			\
-		mmap_end = STACK_TOP_MAX;			\
-	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
-		mmap_end = VA_USER_SV48;			\
+	if ((_addr) == 0 ||					\
+	    (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
+	    ((_addr + len) > BIT(VA_BITS - 1)))			\
+		mmap_end = STACK_TOP_MAX			\
 	else							\
-		mmap_end = VA_USER_SV39;			\
+		mmap_end = (_addr + len);			\
 	mmap_end;						\
 })
 
@@ -39,14 +37,12 @@
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
 

-- 
2.43.0


