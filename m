Return-Path: <linux-kselftest+bounces-11534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADC2901A06
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 06:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF29A282063
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 04:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698C555898;
	Mon, 10 Jun 2024 04:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YRpstOBK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1262554673
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 04:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717994760; cv=none; b=LEMy2KWNZ8kaC/kWTkd2TJTsF411Ja2VkhxUtE0Q6+X8t35a237Ap2srR3ON0JiM3trxesCgbaaD+A59C1egly7hHSjfHVbTcC6inKIMAygYZGHAlt/+We9sGnaQEVrtcINFIePsimHbyat29/9J6JIKx1ZiiZq8o2dwyWqC6fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717994760; c=relaxed/simple;
	bh=FGQxjkKFg6ikcL755lFMFBnsaceTJTK90HJM8u9R8ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OouPysPMRJg7Ft0xB76wEVWkMIVIW6lYHaw7nL+3gt5xsIEa3rWl3bwBF4+vu7kpeSYUY2uNiMtPU9SR8tIoc9P+HqEJ/wQPURUatGE7Rv0LxNmYvWTp/4FaVVyKDkaCh0n/sFDhuAuhVeVubOUNyLpXlu/kJy+LKossYsrAfi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YRpstOBK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f70c457823so3120465ad.3
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Jun 2024 21:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717994758; x=1718599558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8BieCexzaDREgF6SB/4DhCje3SwtC4a6MLqQwsxjuQ=;
        b=YRpstOBKXymk5/TeGfpOOWM8pL1omzzI4J2gDfxCtEYUeuNNgFkwX3bk5MG5gdEzml
         friEdq3YXMe1z26wAwjfQnjFR8yF/nfI525zUl7a2VqOTULbPtHVd/zQ6lqzIhQ8oSJb
         uTRhtWZmz1QlMqkojw8aw2WifSmN/y9qa+gIc0LEcUHx73nG5h+yyqSpZiQ7rVyR29uv
         Cr2ZZFAgX/BMb6TZvmp1Cy2j+1cbJblFwG/1OAdHc9ucURBz/rVvM2JFlIA4biL4xoJ1
         f1Rl9/lVqyDOcKu6uKsTb6m7qnGkhph6EPKqMXdH4dgCti5BMNL8QVMmuB/ql/moN+9y
         Vw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717994758; x=1718599558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8BieCexzaDREgF6SB/4DhCje3SwtC4a6MLqQwsxjuQ=;
        b=JkLMJuMFkjW7LbiE/iHhVwzT6xCJ1bz/+qx+yX+5MW+nB/7K04F4pcQ7aOBR7pGZSU
         tbgLSwLj9SvFARB8tltnh8U0K6TFLR6/6XskPdtOduH2KB54KwdzCZd6i0I4AGI2KbR7
         nF3xVeEcDosHGWa1kolqxniRaY7iwzQOv+IbOXzZo/iRwPS7srbiR5Ngi0lRtqDTU4F7
         HI3FS4ydiFcIB4Q5bfQ4FG3Q+qGmpQt9033JFzxPNKIhxlMZ4kQP1xpMD/x7d78cjtzw
         W8bWwhDSypQKSjAw8hmkSc2uBPrpRD4HL/rtas8GwomwmAgeRInJ9vjETbL1/8Hr6HqM
         KOyA==
X-Forwarded-Encrypted: i=1; AJvYcCU+KOtFkTOJ4RtCipS4x0XZsqIgh61/75kaMywIrIfoMQWPgOJAwNALpTvsnCedXy0jNh1ZJ4y8hA496YM+1yHy6LIj96ik3LN1aDh+y202
X-Gm-Message-State: AOJu0YwjUt+BsdCt5hG0Xko/XasQ621rE9pVv2rWnHZwypXiDj7LkkpZ
	1euCymhbANzChELIYUdrW36l39bCs+tXJRPvzdv5PXWDmItzrERTT9ZAAZcNBng=
X-Google-Smtp-Source: AGHT+IGT317oosIG3JNia7Pc2PgndKpOONadquoO+w7t4F+iRdDjWNQNIYmD2UUADman72ew5imj1g==
X-Received: by 2002:a17:902:e842:b0:1f7:1d78:db3f with SMTP id d9443c01a7336-1f71d78e31emr1364105ad.33.1717994758342;
        Sun, 09 Jun 2024 21:45:58 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76ce8asm73124095ad.77.2024.06.09.21.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 21:45:57 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Sun, 09 Jun 2024 21:45:16 -0700
Subject: [PATCH 11/13] riscv: hwprobe: Document thead vendor extensions and
 xtheadvector extension
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240609-xtheadvector-v1-11-3fe591d7f109@rivosinc.com>
References: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com>
In-Reply-To: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717994732; l=1250;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=FGQxjkKFg6ikcL755lFMFBnsaceTJTK90HJM8u9R8ek=;
 b=hOHF9McI+o1cU1DAmF1IXm7ZMdeqVzGBgk601RJJNOjyOk+/Oadw40msR5BmovQCOoTuHmcBF
 zkRQyUhxJRGCbqJNpLJekD/85gONlVrdLOUv5QHabXYSTiHWZC2HUUA
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Document support for thead vendor extensions using the key
RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 and xtheadvector extension using
the key RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 204cd4433af5..9c0ef8c57228 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -214,3 +214,13 @@ The following keys are defined:
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
+
+* :c:macro:`RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0`: A bitmask containing the
+  thead vendor extensions that are compatible with the
+  :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: base system behavior.
+
+  * T-HEAD
+
+    * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR`: The xtheadvector vendor
+        extension is supported in the T-Head ISA extensions spec starting from
+	commit a18c801634 ("Add T-Head VECTOR vendor extension. ").

-- 
2.44.0


