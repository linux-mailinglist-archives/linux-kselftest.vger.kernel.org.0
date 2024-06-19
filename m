Return-Path: <linux-kselftest+bounces-12282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F72790FA01
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 01:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEEAAB228E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 23:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1801662FC;
	Wed, 19 Jun 2024 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GMmr4Jjg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E0A1607A0
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718841461; cv=none; b=W7Ptzyx2agTo1KwgzYe43Zqd6X9t3N+4VDJ+f8PobNn+Lr70OSHHh6xmuVUmeMtxOGaEjB+9exH+XuGzMyYxXuJ19BFFsBwnU8BxlBC5oaliLMxE5lTjpDV3WNN8yxhlYrl63Yvv3POoaABjIxawkh6N/Ee0eOeeYxFJxbSoqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718841461; c=relaxed/simple;
	bh=AO/P99EqLjRLr+XZCKwsGlMw4bGAY6x2AzplV863nPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CNR9kXXWhiWhNmPVLjF1aN9zhgj+zKqtgH16ZY5/xLh7J+6cj5qHuFVxXU21PzjX7U3jfiHDOnJW4Ctv7393RfNuQh+zamjFdX7uWxVAc0tsRlJRL+OQvPEdzkjf80cN8iPb1hF3HwPaGesLTcSma1x1Y7bG437cUmsAB23jSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GMmr4Jjg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f480624d0dso2544655ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718841460; x=1719446260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGm9bR48fQZKrjgDMB8aJbhbPwJ34IXCq2RfsHXoLZI=;
        b=GMmr4JjgmxbRz+C3o/BgluGIDR1Vv9OT8tBoQJOVG1ILbmD+8pClHyS1g3BWjyNf4L
         goYDWl/eZr/udyTptsK0tmTETJn+HPwcDDp47XNC67VEcYH4KUoJbqsy5y4DNVDE1X+G
         FBcvEK8ajP+3XkOMBLTgIC+pVQ/mFCW4BQItT3XO20bpT9rMaHCq5C5wD4HVNB0wV2Bm
         gJGH6R14G3Y5TtsYjqBaOPNLUcok7iRA5fOydvVGIZw5c7AiBqj8YjFCCTnTWh1pyblb
         StZ0wtVseGVTA8uOAeRucTRxnvIq+b01b749OJoTdsfODJ6koNVxX0UAFd6HT4v6pMPp
         565g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718841460; x=1719446260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGm9bR48fQZKrjgDMB8aJbhbPwJ34IXCq2RfsHXoLZI=;
        b=SOkbwJgeJ7nsVoy1RzhcYzmvhx5l0BDx4aD0M0pB/gdIIa2L4KPQNAFaq1Foyk1/sP
         5+IGQz9wrByvPUOFtmhKNDfoRDFBdZ7gym7VZ3FYKFsYaKYfzh6hLxV3pU1nhtAMSTwF
         OFaeJM6d7WyK9hOtA9F5w0UZOnuaZnRNGAv8AXY11329XxA9Eqr8NReqI5SGzgCvAUlK
         vXvqehv3ZYxbmpYSYn8IcdJd2XYiKatT59zuDYwt4ZiV6mijj7JSCwpkIKT1mApHpOgR
         6sdP2tIs/AS9v3mIQ5Fqmff5P/AHrCgnUbC11xAV4Z6uEAgbgGZjZbtr2dNIDO/zZgnv
         L6dw==
X-Forwarded-Encrypted: i=1; AJvYcCVE13P5kWUEdWaomGOL9IteZ6YCeqGOZ8sD45lWhfmeOsNBF171HuiWF4txlZsfs+wOqHfzllZ9uVtJ9yM7+IkDuvkzMHz7IX/0cfEeNSAB
X-Gm-Message-State: AOJu0YwoSHT0eq0wPhJnRnS8xT/rntazcTUPi7nbKY7nkR49rtIEFDwz
	tWPr710w8iTzwIg9XNaivutLWla0sE8b4cesnTcRjBzelwqARV13hQi/+a65fOU=
X-Google-Smtp-Source: AGHT+IGZe6+GX7Bjo6+EdbnkSSMv0ycmgYSf0lOtQV9jqcllSY9oN2x7oysal0+JtdKkvzepk85+Ag==
X-Received: by 2002:a17:902:a503:b0:1f8:393e:8b9a with SMTP id d9443c01a7336-1f9aa3faf67mr36989385ad.33.1718841459802;
        Wed, 19 Jun 2024 16:57:39 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e70ae6sm123620745ad.71.2024.06.19.16.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 16:57:39 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 19 Jun 2024 16:57:20 -0700
Subject: [PATCH v3 07/13] riscv: csr: Add CSR encodings for
 VCSR_VXRM/VCSR_VXSAT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-xtheadvector-v3-7-bff39eb9668e@rivosinc.com>
References: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com>
In-Reply-To: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718841444; l=755;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=AO/P99EqLjRLr+XZCKwsGlMw4bGAY6x2AzplV863nPM=;
 b=zhlgALb4EtAKwwNl6/SMtNUUGYnH1C52UqTG3+qHZUZP33vF3PwPV5WduUrw+JoeyKIcO9QR+
 RACEkaXfrmZBz9gFsj9GClo/uIZ0WJqc4L96CkCti6fvsaufYtXGxmS
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The VXRM vector csr for xtheadvector has an encoding of 0xa and VXSAT
has an encoding of 0x9.

Co-developed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 18e178d83401..9086639a3dde 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -220,6 +220,8 @@
 #define VCSR_VXRM_MASK			3
 #define VCSR_VXRM_SHIFT			1
 #define VCSR_VXSAT_MASK			1
+#define VCSR_VXSAT			0x9
+#define VCSR_VXRM			0xa
 
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00

-- 
2.34.1


