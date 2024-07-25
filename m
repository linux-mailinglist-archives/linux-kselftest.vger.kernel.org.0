Return-Path: <linux-kselftest+bounces-14208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F067693BB9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 06:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D641F225FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 04:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDB013CF8E;
	Thu, 25 Jul 2024 04:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ldSaV98Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799C76410
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 04:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721881020; cv=none; b=BLMpSbYepgAe35Jn2WV/f73X19kbn1Qxlnl1VzJNNLuyfrO911Q9GTM6nhRaO4m8qMGFL65c45HeHIzwzlzbOq8d20m1snOP3Fl8aAEMobH2xQ8zUEY1m0imQUqIDUhJBpU63fm/zEIgzXVdcuCA2cvi7mDlCMwPrEY0NO/twSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721881020; c=relaxed/simple;
	bh=Wa14YWZIk9RhYyAbwAtIiX/m5fmL0frMClERaLHL5Mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVwOpsvs+OPupGtyg0a/17Pbr5uJcZ7WHu3n1HT2FB+0j31Fa645BrW/bqgjhO7UZj4l0jEVXM/qU3IIOPHna8BsiOX8iQvgLeQoJ5qrABNkmGyhDgWIxYUxdtplwN96B7PVs3iQWrGT4AeC/9ZmWZVi93sK5q9BirQ2Q3cQyU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ldSaV98Z; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc569440e1so4385305ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 21:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721881018; x=1722485818; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bl7FL30OkVSR9KKfP1MOd63cO3FMcJiJeLcU+QuQ6oo=;
        b=ldSaV98ZqNB3KZCTXqGBGCGn8d4oF9cN49Jg4LzYCWhZZiYWZXHZVXKP5NBep8gGcT
         R7eBPtjXAcpMxdSKbP3p7Yp+4dOyswh9Ht15DAwr8XngbBHZEp4fDCFPCPshHJn7J9TE
         JyS1GsTaeddikvSgDEw+XgqVkacOaXOFBZeoWGJ04DoFsiny54JzVm7vTkaCho51WCMI
         iuGBZRIwZV7bCl2Th7EmjYY2EwbW3ROFOoCz1CBdgd9BQrGUV//z1CXo5vSL1WRbJsRC
         X8d/BjdOe10lQ1zXkhygVmoe8SR+hFVU5dL6DR3cmwxZn7FN0DUWY/q7gVEYrE9dNUB1
         8Veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721881018; x=1722485818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bl7FL30OkVSR9KKfP1MOd63cO3FMcJiJeLcU+QuQ6oo=;
        b=eGzfkmqXrbobFJFBXx7ufpfJBE8Von3SjGeKs7XR8mUTblpkiZD7YPqq2lN92NzSlA
         qo+34Zrj9f7HWMuDbN9XOzjeGlY2OT7aFRfbeZmFUtkpuqPCqIFUqDmz40Hm1GsDFb4R
         ulSbklSineJotIdZVS4D6wyeMwaDu5aN3RkCVqueSxwfpiRwcHGx3WlG12O8sKOLCn8K
         yM/7caGaco64cSlKrAp6zLW0MbqleOxMh23FiQaGo0Iif/6pXldkiBRijNdlun/hi8wi
         pFqzWRq1ASPTsXkLHH7QVvvjl8q/kFxnBYlB99BShbLnZf3I3DatDBw1POiUnS6D2Efs
         CA9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/MxyyKQnwSeFpvQDDwfP9+m2K1Do0ZG0crrUpvIeChCFEeFwQKqnuwkXHjDcUjlCONNoE3qK+d2iYGV3uHua5k0I+bhW3vB++aACJInCK
X-Gm-Message-State: AOJu0YzZA3fP0jjc1q0IivQo1mCIzdXmm5cHdZmanIvq6WP3jF+N5tjk
	OJXCSHA0JpfB2q2a3w9sgEDMJUjqds7za7/3HolYYeKBkCBFiGveV0emEyDl1xs=
X-Google-Smtp-Source: AGHT+IGGnhgHDodsPCgQ6UyXFR+prkSvsgzOdtXT7tu1lWgXPK4jw88wpfPl+wuDLx5rpq/31UNUdA==
X-Received: by 2002:a17:902:e805:b0:1fd:a360:4469 with SMTP id d9443c01a7336-1fed3aed2e1mr21298935ad.42.1721881018228;
        Wed, 24 Jul 2024 21:16:58 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f2b80bsm3781825ad.205.2024.07.24.21.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:16:57 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jul 2024 21:16:28 -0700
Subject: [PATCH v8 11/13] riscv: hwprobe: Document thead vendor extensions
 and xtheadvector extension
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-xtheadvector-v8-11-cf043168e137@rivosinc.com>
References: <20240724-xtheadvector-v8-0-cf043168e137@rivosinc.com>
In-Reply-To: <20240724-xtheadvector-v8-0-cf043168e137@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721880993; l=1263;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=Wa14YWZIk9RhYyAbwAtIiX/m5fmL0frMClERaLHL5Mk=;
 b=xmbIZ1B4cKSUyD6sGNqgHqYRqihFCSgHjuco29gSzAmFOdqSolVqvaBL7jhiMzh4SdnMM0w+Y
 VMvahORP1Z1BInVyihNSSOAAqXvaXNpQANQN+QKsO1VjB47OhXOYLy5
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
index 3db60a0911df..400753d166ee 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -266,3 +266,13 @@ The following keys are defined:
   represent the highest userspace virtual address usable.
 
 * :c:macro:`RISCV_HWPROBE_KEY_TIME_CSR_FREQ`: Frequency (in Hz) of `time CSR`.
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


