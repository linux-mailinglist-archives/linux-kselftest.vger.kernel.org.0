Return-Path: <linux-kselftest+bounces-7753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C12B8A24DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 06:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64448283AFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 04:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1209F4AED7;
	Fri, 12 Apr 2024 04:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NSzTDDZN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1EE18E3F
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 04:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895115; cv=none; b=aksoR1yFpiAuCYPP1JxSPJdlgqQaSbQqRIIiX7e+fqkKVUC7mowfFq0YttfhNZULtHDQf4dDfMuABcpuUdBwjg55iwLfqQeJJnsw5huiarh1aiiaT2lsfXjzdzRLK5fatdJKBC/gBiDYi4hKRKVAY6L0s4d4gvNJ0H8vV0Gqfqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895115; c=relaxed/simple;
	bh=Za48erR/9zmvplWXXS8ODcV1Z9QaGewR60ryl+Ilosg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ps2e6rNy7tslqC8CbglaaEBmmufUAq20VJG+ZXDLfHp4plEnSh4EOIX06kgXsqqBz3XrK+l5zcwlQWiW6F/OEDkTMOY/NeQZlKa2qzTirlPm0FVrw0/AXjbtLHLCY03lhesnUZqUrOMpcLGbCjQM6kBOvv4hntG4VADuE5Gf0Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NSzTDDZN; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6eb5887f225so380051a34.2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 21:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712895111; x=1713499911; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/cX7KqBpjbvwnfweF/+d0sA0CANzzmggwTxwJIRs2g=;
        b=NSzTDDZNYgvWB0oKg2RM5n3bdam1IrZhwB7KMX1YWjJZM5lFAaAmH1ExQMxr1fUI8t
         gU+X/jGwI0mUBE5VzXbWTtXD0bw0+VVlszvQ3jDmAnhlxUNQGj3gkHojKY4BiJpatdAR
         /O0X8fr86eaYpASSmg5QzTsXFvBvyUYe4VBk65SCV+6Ad35WK1eA3gyMJsP1iRvnGa0g
         snNh2SbCezmZLi/mrrweMPE9agH6pIVKHnMXkxW2YIZUIk/tNZ0KM53opWqf4W5LhtV/
         abKvW5/nSS2K8yhKRbI/6aD1QTIxWk1dJQOT/eXUYdhkLpXY8zgFBgQ0BhH9gpoF3KAq
         96QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712895111; x=1713499911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/cX7KqBpjbvwnfweF/+d0sA0CANzzmggwTxwJIRs2g=;
        b=StYJ58JaLhNhSuaLm8jhQ3/CZmDSQEvhjRoHui6iT8BjfYiRTDJGgLKRoc4czp4qtj
         3nseDVE7HoIjGgoO4euN7i4cjsJ0rKe5HRWuHVMrNfhW5XxlMxMkldy+0ACRG5wD273h
         EP28gjs9FPFOtWTwge+zf2a9lxqsH3Kvi4zuLaTtf0hALoZz9xy3IR699dOm23aImtrp
         trYlBmHZdwX44sjDiAIJJiDmA6oXxEM2wxkF6v+n/UarMeZ1UeqbCLjwjje81H0ShLBz
         Ufa1XM9Xv4HKPrfcTvFjXjicpaHrlheSBCOCtL9b9v9rdCUigAAgFX10szCheIEkfUz8
         tCPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHLpUCPQgwP/0UdUg7oiPy8WRacrjjX7DXluwRn1GKgfGerJcehRXpnUxVuhKVuYOc3p9Bsk2fAg7Ikl+2Ps7P7hN8popSBro/BX5NLNuC
X-Gm-Message-State: AOJu0Yzu857Me79Gy9Dl8RdvKlP8Rm4lxIvEAJoaPp3jm25vKoMqetMI
	/f+xoo8ms6pXftwcKVrwXjDJOd3gfawzXplNJ683YnBWUuzU0UkUKqTaDwWrrT5Fxj1RxfCwCMO
	k
X-Google-Smtp-Source: AGHT+IG7xfdr9GM09kld+gpoTRj53E+tx3TX3WdgGh40cliYEBj/2eByASG+/EjGzkDhX2ZzYVRIWg==
X-Received: by 2002:a54:4781:0:b0:3c4:e208:b784 with SMTP id o1-20020a544781000000b003c4e208b784mr1726036oic.27.1712895111330;
        Thu, 11 Apr 2024 21:11:51 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ka13-20020a056a00938d00b006e57247f4e5sm1949712pfb.8.2024.04.11.21.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 21:11:50 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 11 Apr 2024 21:11:16 -0700
Subject: [PATCH 10/19] RISC-V: define the elements of the VCSR vector CSR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-dev-charlie-support_thead_vector_6_9-v1-10-4af9815ec746@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712895091; l=899;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=TuSThplyvDtTVWqwUFhV/gX6CqguLjbnzElxxGAX5lI=;
 b=IoxQnX7xJtd3/O6TEZTN81ZKioZw5d0r4tz8jwxoksLzmt6rX3y60kHb1haJbdArKfd+lqIbO
 ic08kmN1+92DSy5wQJq3UBtk09zK5SOAjN41rNduYXhvK29guCQEHVa
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Heiko Stuebner <heiko@sntech.de>

The VCSR CSR contains two elements VXRM[2:1] and VXSAT[0].

Define constants for those to access the elements in a readable way.

Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/include/asm/csr.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 2468c55933cd..13bc99c995d1 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -215,6 +215,11 @@
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
 
+/* VCSR flags */
+#define VCSR_VXRM_MASK			3
+#define VCSR_VXRM_SHIFT			1
+#define VCSR_VXSAT_MASK			1
+
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00
 #define CSR_TIME		0xc01

-- 
2.44.0


