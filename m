Return-Path: <linux-kselftest+bounces-7759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CF88A24F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 06:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EEA2B21CC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 04:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A887F1BF24;
	Fri, 12 Apr 2024 04:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZISooI+9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C850A9D
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 04:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895125; cv=none; b=DE4de9O0usV0zVAG1xwoEp2gYcOLBBV8iG3PXmfIo1w3o4CwfcSfMwCMU3qsTv4hyFdBW03LKxVXUHYn+pI/PsRpPOPJUipZzZhB2yV8Nl895EGwNeK1wqnjh2sQ5sw5cMb9Olmrh/rgBBBhhURvkHp4bXwWQVHtJ80AsHEAd6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895125; c=relaxed/simple;
	bh=t4tv2YhM1MolJnYPmx3+B/R7xn5gYh3VtunEyUIwVAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jmp1Qx6QkGHgBtHEGiXZokesrX/Md0+oNNwpquE8b+dwkMdDInp63ZFivME4sEo8miuOpRAgfh02aROKVtQ+mChcXMXx1dJdBVobEKAJGK7xh/c7J0FcmDYAwy+O/RL7LUOcHhGNJ5BEzKyXBENIuOnqxK7OY5ocl1pit+DwwcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZISooI+9; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-229661f57cbso305416fac.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 21:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712895123; x=1713499923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCqKMMvpjdMx8mqL5GwN/rt+g7kii5wG+xB+75rraRY=;
        b=ZISooI+9H3XrQMnSFsNGyYxCYwkyHqWLSlKk0inJw5dg4gmgFGeFLalMiuN4kFtzuW
         0zpnEjBp+rXABbPI68S8b+ZMRFWP17wUKkSFBTTy4Dcdr1mW6j8kNu/jn/t7hHmsuThI
         Vnf2lBd+zG8iT7ad1limGzBu1TF3UJGX7miH7aB5uyoQsFxf28uYWa5t6MGMz3Mo8wOm
         OEfACBtjuw6H+Y4TQYpjPt+FnGye99NY460M+yowa/HbIGnHq6KKdyrJhXYwKEqzB9Sq
         9X+mV+YgLPAjeKVir9foBsUskr/Oow3fzgFbosjkiCF5zWVAMUDulB5Ub7g5c4V3Yb0R
         nEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712895123; x=1713499923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCqKMMvpjdMx8mqL5GwN/rt+g7kii5wG+xB+75rraRY=;
        b=JlqMewiiOwdE/LPa8E8pjjzqhTuqBCnbqE1tbF0MpNvv4+JP2YBCLX9Up3bNMbHQio
         lh1LF2zMDoNpytkhqiBub/2foZ+jQgGSmtYc9WhfdWwCSUYK9ae0r2dkaExAihKKYYoO
         fIlOb+jay/gt+SAi3tf8EiLc3fbiKzDZSxQDUelCuC/Zi/VZOM5+noVoHoN/DnCSY6W4
         v5oNK3SWVEJftFEJweJqZFZHYZ19SWZSEQUTNvex3RZWztzarRAaZ/ddr2z6nertygTx
         4G1L0JEZgcXCUMF+RoXz3QT3MmNHd5wX1/3//eYp/MXiEjlVWtPCUopHkRINqtdnujea
         gthA==
X-Forwarded-Encrypted: i=1; AJvYcCUzkwzeL0VVngCqt0TzYdyzi+qqANsjandyunkEvPRpP99VDA9p4CCe200zmYF5ooq02L6S9guJHPz1Okx2IiRRX+wYdlQMIC+67+6yOI4N
X-Gm-Message-State: AOJu0YyOoWbUo4wVEOFpeBXi6OjOiud+hRtTAneocwhv1yPjPRsq0ziy
	iccype2an9ePAvSmuMcqKAyAX7Sq7Lry/4ZPO96WtxWmqbngJZtT60fNydE8rTU=
X-Google-Smtp-Source: AGHT+IHY3yirk4jX9cMXtaF98jtTfUbpKOv+CODCxv0iWIStL6fUZfoLpzSjdgQJtBdDqv3RCGYZ3Q==
X-Received: by 2002:a05:6871:5314:b0:221:8a03:6de7 with SMTP id hx20-20020a056871531400b002218a036de7mr1825489oac.32.1712895123342;
        Thu, 11 Apr 2024 21:12:03 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ka13-20020a056a00938d00b006e57247f4e5sm1949712pfb.8.2024.04.11.21.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 21:12:02 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 11 Apr 2024 21:11:23 -0700
Subject: [PATCH 17/19] riscv: hwprobe: Document vendor extensions and
 xtheadvector extension
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-dev-charlie-support_thead_vector_6_9-v1-17-4af9815ec746@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712895091; l=1314;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=t4tv2YhM1MolJnYPmx3+B/R7xn5gYh3VtunEyUIwVAA=;
 b=Z4LgpsK6Y6OJvIVl61GAR3j9FIxHWvGkBhRPZ4DETyx4FdNnrNJAGGqYj86rnsakgjClK/luR
 oXhBD/8IaVzDn2iAyaUVP0kpGgWHWoI+hy4jtykxh3ZbjrZ13vpa8kd
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Document support for vendor extensions using the key
RISCV_HWPROBE_KEY_VENDOR_EXT_0 and xtheadvector extension using the key
RISCV_ISA_VENDOR_EXT_XTHEADVECTOR.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index b2bcc9eed9aa..38e1b0c7c38c 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -210,3 +210,15 @@ The following keys are defined:
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
+
+* :c:macro:`RISCV_HWPROBE_KEY_VENDOR_EXT_0`: A bitmask containing the vendor
+  extensions that are compatible with the
+  :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: base system behavior. A set of
+  CPUs is only compatible with a vendor extension if all CPUs in the set have
+  the same mvendorid and support the extension.
+
+  * T-HEAD
+
+    * :c:macro:`RISCV_ISA_VENDOR_EXT_XTHEADVECTOR`: The xtheadvector vendor
+        extension is supported in the T-Head ISA extensions spec starting from
+	commit a18c801634 ("Add T-Head VECTOR vendor extension. ").

-- 
2.44.0


