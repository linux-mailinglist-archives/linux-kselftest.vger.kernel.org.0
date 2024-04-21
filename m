Return-Path: <linux-kselftest+bounces-8576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF98B8ABE19
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 03:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33051B20E3F
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 01:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC161210EE;
	Sun, 21 Apr 2024 01:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oH/lYKXp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F01CFA7
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Apr 2024 01:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713661511; cv=none; b=u4689erN5eg4BnD2VO8qSKBi7wpi6pfuzv5modLlZn3DxPLuGRPpMFhSL/B+Wv7D1NIejjfDHTavcbsIl502T+WgurD5lIzuLmkuUY+R0fDxxKx2s2dhzESMTuJAoj0qBbhGpXRb2nvZGbKiYMuxrHPU5HxercX3VSdcTskZs8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713661511; c=relaxed/simple;
	bh=/S5mXvNckx5pf6RsnXH2juTR+JzZCbCosBXwMflqUFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XAj/GvVg9Q1bIHGXpJ7rRUg1iTMtb+snYATsqziUGL82fqadX7Q/V2QwIjdtF17wueItBxdc/Cxo8p8bFcCMbygbOcC98YQwro3DeBxF4mSyTRRUdz5gBOCh49fj7owaKMAO17eFb4BFISUJ9fKvyIgxr+Nk9GTejdAFgjssRM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oH/lYKXp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so3301522b3a.2
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Apr 2024 18:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713661510; x=1714266310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7WZZ9B05w7yOdiDdmOf8xUgYc+IvuHvU5nr8Ugv9mw=;
        b=oH/lYKXpgM6cv3VphP4XrY99Q8cFj5o+7jf6i54euI5SJRweqmGLCLHmzqZssc1bAt
         nOJKaGYGiUdh+lAZxYtnFCfjea16iht70Z20u/8lGWDB/utTR0IBNZ8Fy//XMIUJupSd
         9Bm3FR4uzqrwhMnVZsUOenZDiZUPnPdFQxiZU7p9yCnTJgTMBknskA15VFjFHah0cqIK
         s4emPjNa3Pvkqytft5vi0pbg10FzizOnF3QD2wq23Qn+BGCFDi0LP8A2bt1SvHip7kfb
         vDsH9JGmPqENDQTA93Epip2feiR4brRa/lZboYr/FiamGHYe75SyT9gZDN0Cbi7VLsLe
         7GpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713661510; x=1714266310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7WZZ9B05w7yOdiDdmOf8xUgYc+IvuHvU5nr8Ugv9mw=;
        b=QfsGgh1EOGF6goMmygxHQVrctKeuzmhN6K8Qwdpv22ArRHt+KIzmQoJ+y10S9mJPO1
         xGxhJ7gXpRSO3O+vrkrFklj/UbTITBSXY3ePPaU49+iMw/fMx9i6qWWTZBmECVu4NKGh
         m/fGF7BbA4zX6VzDKOfjo3xDfjrVOXk5t/feIVdaHM6kwt8a1axPayKTCtEzJuctp07y
         dKumNuu4+rvniteDvXN+7MMfxvN6VdHtl/N/z2w6MwSyWPthTiinmMukNMlhj73wNBAK
         IoBQKG/y7bAvhQNPq2t0HBFeGLNGqFiqdYtj27ObbXzbEGDG4DPOTt/6eUIW83DOHgMh
         CLPw==
X-Forwarded-Encrypted: i=1; AJvYcCXLPoNM5g62xW/oaJv3gd+NZ363LXheyTq0xIauBCgMUq+630Iv8R+YT7Lo777VhoKe8+B9f718gVDHRc9o0J49Ruiszo2sPF22JX1zaex7
X-Gm-Message-State: AOJu0Yw+SMEIf5S0/4AxlEZU2l2qdjsVV5Iy7oePJxE94HG1ta+oJa3P
	03PLeVx6yPwuVr8M4MqJW3qp0rjacGqs84ynJqKgsr3ag0clZN/A/e8RYfp1wPA=
X-Google-Smtp-Source: AGHT+IHKFFwWOUNX34yfbtkNAA2sLpa34va32+rUsK/EqAZ0SRgYOjV+4xyTToafrWWlIRTNeQE9eA==
X-Received: by 2002:a05:6a20:561b:b0:1a9:3e7a:b0fc with SMTP id ir27-20020a056a20561b00b001a93e7ab0fcmr6650092pzc.51.1713661509732;
        Sat, 20 Apr 2024 18:05:09 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d6-20020a63d646000000b005dc8702f0a9sm5249627pgj.1.2024.04.20.18.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 18:05:08 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Sat, 20 Apr 2024 18:04:44 -0700
Subject: [PATCH v3 12/17] riscv: Add xtheadvector instruction definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-dev-charlie-support_thead_vector_6_9-v3-12-67cff4271d1d@rivosinc.com>
References: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
In-Reply-To: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713661481; l=1914;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=/S5mXvNckx5pf6RsnXH2juTR+JzZCbCosBXwMflqUFg=;
 b=1kn8f9MgXWKJKmQlrV30BpZBvgJ52FS2fVV9itSClPiV/9gnAsAa8aFVH+g1I31umjB1dO4bk
 q2h7E0sCJbKDEMlRKHZpHo7aqc4t3bXxPYgHr6Zitugls9OvOjNuxGR
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
index 92eec729888d..6e3c85351f82 100644
--- a/arch/riscv/include/asm/vendor_extensions/thead.h
+++ b/arch/riscv/include/asm/vendor_extensions/thead.h
@@ -16,4 +16,30 @@
 
 extern const struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead;
 
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


