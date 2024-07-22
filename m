Return-Path: <linux-kselftest+bounces-14009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 855C59395C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 23:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12BCC1F22087
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 21:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8DF4962C;
	Mon, 22 Jul 2024 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hfH7PIMZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA6D4776A
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685497; cv=none; b=pljsHrXjcPJFnsvuk/zdBLD0+vY7VabdWSxGpHJL57n02x0fBr63d4BpjzbIFPm5VAReZZgaEVpCH74h+uyNYJTJ3pJ0uAvkvPjygMz6eLV6pnRAgvP/ZtVsDQmBNoq/3R4mUJrPxiYPZ8LkbPHT8vnn2JuqnOppWlgRt0zWJEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685497; c=relaxed/simple;
	bh=lK25kSvuXBbjCsm1KOScKY69sa4rMHinL5Ye8aockR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gwTU0aFIp/1hOPIY3ivxMtG3joEnzllfTMbBFOLlE/LDE62TVnjhZhFuC+K83U7xXD58/DYtw6BahLdhATd+c8C426nCEQ3RAopXE3T8NysCqZ4GblIddPkCnDi4NXrPYSMu0oT3TI7r8UlzaWc3CtzZOEu7EJaeZZPIiR+Rrjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hfH7PIMZ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-793a3a79a83so71494a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 14:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721685495; x=1722290295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RiVgzby/fIL0Kxxx3Y50ysZFHbsEJYdDMqDhTheyzc=;
        b=hfH7PIMZEuSCXYPnzhwdtyJp4+TunM3HOJTj9TxPbkVySPTJwiMt3QH0rlincP6T5c
         5ZNdOdcrf+9YRIsFvCm3Ukj8UPd77nk8v969isBDZBWJufLJISpJyiIvAyfyuUcZKZNw
         SV7TQsdSMxUzB+E4afAMBCC+6XWyfcRZIBaNCh29S2p/1aOa1/lIgn2qiiJUI4ptBn9A
         EwiseDfYYQ+w9SzNt6X4Z29tyN9RxXhbTpvaOclP5AiiiIxLaWyYnMNFL56sKrc0tTuF
         a81oSsjdEtADfnnXAcnk7cMFotEfhP+8SWs5+WuBa6DVslEX33tVsR5I6DoXhJUFsqXi
         hyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685495; x=1722290295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RiVgzby/fIL0Kxxx3Y50ysZFHbsEJYdDMqDhTheyzc=;
        b=ty8tma7aj27KK98Vss/Ylxy0fWI9yqmvGzHrsSDZ/XZJKCfSmy5PHP/MggwYHj0uOq
         TPzf7aGs2P9NqKQm2vekPCH428zVHgKqcPAyqW7DDi3FwkVbaoM+Zd9bc4tFv7LcmX7c
         Qcrnt5VRNxwOSvVmNbL9BQq2Rh1S01cruHOICK6CbY47K18w28MK1NhwUsl+dikkwRg0
         eWmhHtZ1Z1R/0OIoRjICSAVV5z2ncEeXELLv21yLvbzvapSlGVlM8gS2b4gziZS4J7qb
         1npgXhyrxovCsIZZU+WQvdR4v/TUA2QF6pPcLe8rXR5a9jheVjaTI9BaZaLoj/M9elih
         rPgg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Ylm4guPI/jCNpXJRO+XvGQd47/ngClRvRKtEtf50Z9W0UzzKxPwVtg0FFCkDtjPu7be7D5w6NFtU8kl7a9MYS0gsRCvCsLScdmsuUtSJ
X-Gm-Message-State: AOJu0YzADhmschgbIa5yL6HnJfSXnhQjGaz1/cP3RqEUSKpQHlpISgcr
	rC4dBD9jFt/hI1Mgj/VoP8eYusbrJleEaq0EXccavnm8B1ZZJs/0oYZaphETQUA=
X-Google-Smtp-Source: AGHT+IGnAoJ5NYdojrpk5kNKJAL/+A9oPWkqoZylV5Y3F1ZmyUCdRxQIgDj1CJDkY811t3vfT0g/Uw==
X-Received: by 2002:a05:6a21:612:b0:1c3:b20f:de15 with SMTP id adf61e73a8af0-1c44f9696d1mr927612637.52.1721685495398;
        Mon, 22 Jul 2024 14:58:15 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f44f0d4sm59997775ad.219.2024.07.22.14.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:58:14 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 22 Jul 2024 14:58:06 -0700
Subject: [PATCH v6 02/13] dt-bindings: cpus: add a thead vlen register
 length property
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-xtheadvector-v6-2-c9af0130fa00@rivosinc.com>
References: <20240722-xtheadvector-v6-0-c9af0130fa00@rivosinc.com>
In-Reply-To: <20240722-xtheadvector-v6-0-c9af0130fa00@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721685488; l=1911;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=lK25kSvuXBbjCsm1KOScKY69sa4rMHinL5Ye8aockR0=;
 b=W8J1yxGjPC+Bnnprr/HHbu8w/Ykizyg24i4N6mFJiAW32HSh9qI/PyEGVc60fweu2c5CDTN1W
 AxCC+NW/3zQBWqBTUHCkqRhgYF2Rrr8gXrY1cDWPE5Er/t5Eit1QIdy
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Add a property analogous to the vlenb CSR so that software can detect
the vector length of each CPU prior to it being brought online.
Currently software has to assume that the vector length read from the
boot CPU applies to all possible CPUs. On T-Head CPUs implementing
pre-ratification vector, reading the th.vlenb CSR may produce an illegal
instruction trap, so this property is required on such systems.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 8edc8261241a..c0cf6cf56749 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -26,6 +26,18 @@ description: |
 allOf:
   - $ref: /schemas/cpu.yaml#
   - $ref: extensions.yaml
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - thead,c906
+                - thead,c910
+                - thead,c920
+    then:
+      properties:
+        thead,vlenb: false
 
 properties:
   compatible:
@@ -95,6 +107,13 @@ properties:
     description:
       The blocksize in bytes for the Zicboz cache operations.
 
+  thead,vlenb:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      VLEN/8, the vector register length in bytes. This property is required on
+      thead systems where the vector register length is not identical on all harts, or
+      the vlenb CSR is not available.
+
   # RISC-V has multiple properties for cache op block sizes as the sizes
   # differ between individual CBO extensions
   cache-op-block-size: false

-- 
2.44.0


