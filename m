Return-Path: <linux-kselftest+bounces-13929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEC2937AAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 18:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE2B2873AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 16:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81E0146A6D;
	Fri, 19 Jul 2024 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TrmuuvKr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF5A13EFEE
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Jul 2024 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405948; cv=none; b=DBIbiaU4W2LYJU1TXE0W1t0i8C+R9r4V/xEF6q5ohBXCJMOnMjYKj1Qac6ic1uq1z9T74puGa+2klfNvsDXw7tQH8YtojDQdl7gnSJj+MYUCtnabyu6vLC4onx4O5OKWOhks36bKBe6l575JLznClCWW1eDn7LTh2f47Xx7+BlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405948; c=relaxed/simple;
	bh=lK25kSvuXBbjCsm1KOScKY69sa4rMHinL5Ye8aockR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c2hOjFSGm33pju95Z5uF/vkt3a9tbDK25dntZ/o+0en5Zw15EAD7WcF7HfcgMjAbj3Mv10JWk9Brg9gGApj1uYP9svJ1EnjD09heCF6oTm6D4DgHxXyxYeukXutKtSMvzfa0HIsNpKAGvlBcNStTzgDJTdMYSRYuqa18n4D7Q70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TrmuuvKr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70b0e9ee7bcso850632b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jul 2024 09:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721405946; x=1722010746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RiVgzby/fIL0Kxxx3Y50ysZFHbsEJYdDMqDhTheyzc=;
        b=TrmuuvKr4n5ykzZylMCLlGemwoMKlQZBaj+NuCilRjqyt16aIBJ+NK93SeGgseO+W+
         ynhp1eexCdRTZyK8FwAsS6/cVBwvhvWqPD85PZYae5Aloi/M35T0jYZNqJI9tzJXano7
         ojgbjFG6r46x50n536Tsuj5baQxJ8WE/ubvMknRdvrOCAzybjLhyuu01ZDN6q+jVTzIl
         iskdRzZtLzPlpSmtopz6S48zWHHJk85a2ID0bINb8UutC5wkFbI9tr0VR9AR/ViUyuQx
         dEBxNxd8Di+xd2JYTfR0qnK5Gv9QUgzWodl1CvJlSpHVByWvMMA6POCYDBBZi0xeKgH6
         D24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721405946; x=1722010746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RiVgzby/fIL0Kxxx3Y50ysZFHbsEJYdDMqDhTheyzc=;
        b=M8kw8CjjaqMyQz98nH5qQ0D4Ahv+MNMGttc1f+04U8U6fKP4IIm4jUgl381TQvvQe6
         aOYq6LzE+bH47cQcGhKxfi84AH8PJ7JxIrQBrwk1+9Ose2DOFB/kOdhNi2NTtMqzeQlK
         Bjrx+g/96TQP+jE1E4GEIdLNfyub+zKOhuz6K41daQEZDNqrt4s+yMICiZcuW1Kj+66q
         knCtIncg4Swc/gxuJTJQwNedavLbceHkSFdPvPCKsFgjd9KC35wHMrwZ+8Z8AlRGXra7
         Gxr6vUak1NObvRCcMnOWe1R1LVH9NqA8elngtkekI0B3xtmazxJb2LWyCS8q0UKuROdf
         jWDw==
X-Forwarded-Encrypted: i=1; AJvYcCUPG+5BvCvFydk6AjtJIRoOD6evY99MccRZCkY5A8mHuqzNkJxIjU8vSSrsJRHRgANCwcjghL8JHCZr0qF8TXTLlkLwyn+WybbTPXgLNgRc
X-Gm-Message-State: AOJu0Yz6rOKLej+3iX7gsYDYVN/ggo15lUz03o/JyxTEv5vRguGmyJ3N
	NYJB1BjKllgVaGAuWBg8k1dXJoVuwXgoxA6ccqKPsI8a8q66M5sDeSXawnktmuk=
X-Google-Smtp-Source: AGHT+IGpQhUEwosdUI2ORV/BIO0qcpTdq9x4hIAJhJLSNNmuRVn7wMx1hzMhRlqkrC8mFLZV7jFOKA==
X-Received: by 2002:a05:6a20:841e:b0:1bd:2894:4015 with SMTP id adf61e73a8af0-1c422999ce3mr610323637.50.1721405946497;
        Fri, 19 Jul 2024 09:19:06 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f490dcbsm6461435ad.297.2024.07.19.09.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 09:19:05 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 19 Jul 2024 09:18:57 -0700
Subject: [PATCH v5 02/13] dt-bindings: cpus: add a thead vlen register
 length property
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-xtheadvector-v5-2-4b485fc7d55f@rivosinc.com>
References: <20240719-xtheadvector-v5-0-4b485fc7d55f@rivosinc.com>
In-Reply-To: <20240719-xtheadvector-v5-0-4b485fc7d55f@rivosinc.com>
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
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721405940; l=1911;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=lK25kSvuXBbjCsm1KOScKY69sa4rMHinL5Ye8aockR0=;
 b=vw3ii77Xw15MDoMhfXizqGACv7IxGNe+JbN5fE16N5Xx1rFH9BejYgL8yDj9OHaqBl1IRVuc9
 e+QVMtkstlhD4KgcoWg7ljr5hN0kd/hJvXchgNzP2IOQ3m7fneQUjL0
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


