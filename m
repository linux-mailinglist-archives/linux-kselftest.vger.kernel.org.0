Return-Path: <linux-kselftest+bounces-7751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9C8A24DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 06:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC071C20D98
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 04:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6649482F4;
	Fri, 12 Apr 2024 04:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Do8dwcqa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B53945973
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 04:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895112; cv=none; b=Tn5QKWmD4uucUjEnBFxFLS6lbrrdgd818TAuth6oBK7kC5BxZNZmfzny8x4VrOdRGbNYmyDK0xZtguh+glBVBEVKYY6TW5Djzl+9jIV42+OIHZP5pdan0r8L3coktWilq1GaCR+KTetcZxfJ5K7/Xo6Qb2CgXt5Ew9pnI5GnvjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895112; c=relaxed/simple;
	bh=AjSOqPvk8pDaNRWNo6bJjXE2EKHaQE5Z9yM7TIyqWv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j6J15RCGwRPcbhfDJGQ1RoPdQ5uuzjTYx1W7V9W7PGqW71lIgB/RpzDRh/IhJx3LnQ8acnHvMviojtHaDOWTqzjNAdstv5tawrwiqvZT14k6lFXdTnutqNK1IiMfQQu254QwLO6Cg4dYDH5VJ7z0PihWdK648tQlNa6ezEybGWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Do8dwcqa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso471993b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 21:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712895110; x=1713499910; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMPIuwt6cMnmpNq4lu1wiuX0ZLQRNI3Tbplv0ws9fgg=;
        b=Do8dwcqa5vHeVNl4UCZAQqN3S71ZxHEfFnC3gAiMNk68N9TQ2fOVi1p5UmgvNjpjli
         JwpE2tmIuEpS8GvEsAHBgaRgyP6Ga2tFBWJVLGsgSxKhdL9rpvBU2oJfWr8GVYJBrlV3
         ByCRuUg3q9HurySVRbXt2qTl3CiEP0WDRe3Px+rPhK2ZX1xkKFtr6+5U5PNUB3MdBUcS
         frRQFCqa3EoMwZduML3l5FrTKJlZytQ704GqCGZXXOjMz7UUnA+I9tJuy5GlveJX7iwe
         PUpUOd6zmHi4GtOzBw1vUhXpM4CEP3dnmTNKLCrV5aAoZBVq+kT+lAdTFzmUvljFlnj1
         hRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712895110; x=1713499910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMPIuwt6cMnmpNq4lu1wiuX0ZLQRNI3Tbplv0ws9fgg=;
        b=QNSFa7xtnHVSGsjeaO51rGc1S5hCYAk2SCaK6AfVfRAjyuR8/urJq2eYCnoQxTk2I2
         uPo0zf2ga+lFm4WVRQUj6CaSugqayN7tAWxL7e7OYiq7Ctoa2QhWQumhVsPPQvJpPIU5
         kpHtYH6D4dx23TNHblYhzdzWiLM53Zyqko+LJmJjoEfg0WwwtyEAqA6MD+7AWur3NUD5
         lHBVJl5O590NWnD+7hMfyaz0J4SWo6LIc9KHw/o1SGN86xEsF5dQXdf4vUASUCdPEZCA
         hz6HzaQlPhw8+vblgjhDXRgrqzH8tHqm9+WNih1stR4+fk0AcLjfd9/x0HTkNza7lC6K
         udAA==
X-Forwarded-Encrypted: i=1; AJvYcCXxbP7kJ5dTZ3bqHj85nrUV+y7AlxUrT825YHtHu9X2s3AxbS6x0cRmj5GEA8p/4FlNBLZ5X7EoZ04Ng7V0qTIx0OdeULQPF7stzc3G5WPe
X-Gm-Message-State: AOJu0YxxvtIaaKz0rWzYY/uLaEBp62kb86AibyaFImkZLhugsYv++lOB
	x5Va/RKGzbn3oCl9ltAg1R0YTBoSPrJ8NlBzDb7B6F1QHf1h1dsKJm6JVgYfaaA=
X-Google-Smtp-Source: AGHT+IFCzy27N8mqtHUrUbUr0RUPxfjDtDbiINOHTo2v+uHwsCX7URxkFsS+GECfOE3fQY7tSLC35A==
X-Received: by 2002:a05:6a00:3d0f:b0:6ea:b073:c10c with SMTP id lo15-20020a056a003d0f00b006eab073c10cmr1638560pfb.6.1712895109632;
        Thu, 11 Apr 2024 21:11:49 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ka13-20020a056a00938d00b006e57247f4e5sm1949712pfb.8.2024.04.11.21.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 21:11:48 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 11 Apr 2024 21:11:15 -0700
Subject: [PATCH 09/19] riscv: uaccess: Add alternative for xtheadvector
 uaccess
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-dev-charlie-support_thead_vector_6_9-v1-9-4af9815ec746@rivosinc.com>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712895091; l=855;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=AjSOqPvk8pDaNRWNo6bJjXE2EKHaQE5Z9yM7TIyqWv4=;
 b=rLdA0uDN/4SuDsKaNkE1B/5EQ3+8RUn38NFVGd7zgF1hdVuMZ9rnFvU8oAtWxXhpoFvN3XcS2
 AwLpS2uv0ZdD7oPmFrJym2AWAe7fYoEjhePpIuQeP49tGq9DoLHJSQU
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

At this time, use the fallback uaccess routines rather than customizing
the vectorized uaccess routines to be compatible with xtheadvector.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/lib/uaccess.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index bc22c078aba8..74bd75b673d7 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -15,6 +15,7 @@
 SYM_FUNC_START(__asm_copy_to_user)
 #ifdef CONFIG_RISCV_ISA_V
 	ALTERNATIVE("j fallback_scalar_usercopy", "nop", 0, RISCV_ISA_EXT_v, CONFIG_RISCV_ISA_V)
+	ALTERNATIVE("nop", "j fallback_scalar_usercopy", 0, RISCV_ISA_VENDOR_EXT_XTHEADVECTOR, CONFIG_RISCV_ISA_V)
 	REG_L	t0, riscv_v_usercopy_threshold
 	bltu	a2, t0, fallback_scalar_usercopy
 	tail enter_vector_usercopy

-- 
2.44.0


