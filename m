Return-Path: <linux-kselftest+bounces-11531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 996199019FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 06:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D4A1C20DFD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 04:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842EF495E5;
	Mon, 10 Jun 2024 04:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GbOhPy11"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81A33D57E
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 04:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717994755; cv=none; b=VAV51nVi9CeZp9aTrZwfEfz1rSeSHgYUfBOimzA02U+8j9ObK/BJPqQk0mfPGqMJfYrpwfYtV5TzkRHjbL+S9KDRo6ltoNNTUkXEAPIhS3uYWUy/P7usHl3OSBNXT/yTnMHnyB41u9cWJnm3fHVkcux8Rn9eZ4PJJQxK3MiXfpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717994755; c=relaxed/simple;
	bh=fwxPC9e5acCJKXfvxD0QuLfngnuG8uQUjT/zUUS4iJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BUr1jfXUiPCSQniUMd2BdR48BfLrlQur5meJAvQo5JY8Y8iEn34KQyaaNvlpmc/S8LHLwkmqm6jJLayd1/3YBhpfn9y8fWcXnF3Ua1rN4RvKseFiYCiDGte3vvIMvpykPbaAcfeVrCcZ8YB26a2t2PfdVT8EknE7z/mEerR2I+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GbOhPy11; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6f031549bso13326965ad.3
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Jun 2024 21:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717994752; x=1718599552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLBLJWgoI5ONq0p19OcZNiSMS9NNG1Jn9M7ZhOPyPpg=;
        b=GbOhPy11pStnMkVHjlgMummwUIfAQCvtYyeOOO58Jujx6+fh/xbpjWAYEw3fOnfUCl
         FtHYHNmU5OMDc7+L67OfL0P51mUylm2x4zJ0hHrtsg/9P39RzJhZ6ZOphXgGCiFbUaua
         IccJDhpZNi7E7LonJ4GDIEWLVizgDUE/HG/etsH4M5L0YW/uuxgirHMNlOmc9wKZs2YF
         yz/cZXgvvPs981uDCacbnxMSgGMEwiC2+6QtE1Wj3/OZOufTt/WBLwqlcsuKws/o2riO
         B5cHcTsaEM3vjPG5DU33mKwmFdGoHlu57li5JROHlCUDjbAuaNgsExP8SwPSNaqm1vfv
         9vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717994752; x=1718599552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLBLJWgoI5ONq0p19OcZNiSMS9NNG1Jn9M7ZhOPyPpg=;
        b=gMxIS61lcQ3NLABabqGF5Un9iGgKp7CW3NxAUgF6G4l4gF9GjAqqPxy3eyLBYsh0UB
         c6h1+X3lT/r8GryB0k9GYG0BsH9X2tbNf9XGRlsn06XS2wOpKiOYunKd6A1lbkYz4ic+
         +djFfF/wACGQDOUnMROGgh8YwgZDNj9mbxpES1TNCO3f/bnpIyk1RMjDs4MtGtld7mni
         AapTRaiurqqWVubQijycm0qWCvq1AKpGArIsdoz4FLguRArjd5JWRlxLaZxUU65RbHfo
         0KuQrYaYhWKk57xqwz6ucOS7LcMkETwgnqkIagUYHZkFzmXNnDh1sXYCLEDLmDJKXRuN
         azsg==
X-Forwarded-Encrypted: i=1; AJvYcCVAufgDSkE3OHJF+g/FhRo53/t0HTJPtGFv6FgCIb0YBC3hjpFKrfiu59+/a6CRcLwziLbyWiPGaYZ6UQkJfwwfpZFm6a4HTv9J1LrsjB9A
X-Gm-Message-State: AOJu0Yy1z6Ctmzzajv5dmc5xtl39VfQHmLsrM8Z8i5jB9iZHIjMVhzE2
	aIK83UWcybNhJ/Qj6Wl9+iGOiD2uE66f1QPXDU5Ggwmlp6DQi1BZKUUnScPBRKE=
X-Google-Smtp-Source: AGHT+IGhzNw67XowR+pxZXHezAitcTACLUYAiHb9cEpJzp2JsugT0jDK2XmWOKiIDx7qVYVsfrIJPA==
X-Received: by 2002:a17:902:ccce:b0:1f4:9ce1:6e78 with SMTP id d9443c01a7336-1f6d02dda70mr108577415ad.19.1717994752097;
        Sun, 09 Jun 2024 21:45:52 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76ce8asm73124095ad.77.2024.06.09.21.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 21:45:51 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Sun, 09 Jun 2024 21:45:13 -0700
Subject: [PATCH 08/13] riscv: Add xtheadvector instruction definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240609-xtheadvector-v1-8-3fe591d7f109@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717994732; l=1908;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=fwxPC9e5acCJKXfvxD0QuLfngnuG8uQUjT/zUUS4iJ0=;
 b=M+PUFY/NkfsExTsLVk8k8J14gBVKv6BFH2DHRNNQUnGVcMQ3tAUdofnki8To6aiLBdBSyd3l8
 CwcONHmOkfXAJxo09mBCTw8CQBL707I5DEdUsNXqUeM68eA2H8/JeMP
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

xtheadvector uses different encodings than standard vector for
vsetvli and vector loads/stores. Write the instruction formats to be
used in assembly code.

Co-developed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/vendor_extensions/thead.h | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/include/asm/vendor_extensions/thead.h b/arch/riscv/include/asm/vendor_extensions/thead.h
index 48421d1553ad..27a253a20ab8 100644
--- a/arch/riscv/include/asm/vendor_extensions/thead.h
+++ b/arch/riscv/include/asm/vendor_extensions/thead.h
@@ -13,4 +13,30 @@
 
 extern struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead;
 
+/* Extension specific helpers */
+
+/*
+ * Vector 0.7.1 as used for example on T-Head Xuantie cores, uses an older
+ * encoding for vsetvli (ta, ma vs. d1), so provide an instruction for
+ * vsetvli	t4, x0, e8, m8, d1
+ */
+#define THEAD_VSETVLI_T4X0E8M8D1	".long	0x00307ed7\n\t"
+#define THEAD_VSETVLI_X0X0E8M8D1	".long	0x00307057\n\t"
+
+/*
+ * While in theory, the vector-0.7.1 vsb.v and vlb.v result in the same
+ * encoding as the standard vse8.v and vle8.v, compilers seem to optimize
+ * the call resulting in a different encoding and then using a value for
+ * the "mop" field that is not part of vector-0.7.1
+ * So encode specific variants for vstate_save and _restore.
+ */
+#define THEAD_VSB_V_V0T0		".long	0x02028027\n\t"
+#define THEAD_VSB_V_V8T0		".long	0x02028427\n\t"
+#define THEAD_VSB_V_V16T0		".long	0x02028827\n\t"
+#define THEAD_VSB_V_V24T0		".long	0x02028c27\n\t"
+#define THEAD_VLB_V_V0T0		".long	0x012028007\n\t"
+#define THEAD_VLB_V_V8T0		".long	0x012028407\n\t"
+#define THEAD_VLB_V_V16T0		".long	0x012028807\n\t"
+#define THEAD_VLB_V_V24T0		".long	0x012028c07\n\t"
+
 #endif

-- 
2.44.0


