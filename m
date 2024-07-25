Return-Path: <linux-kselftest+bounces-14203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3C493BB8C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 06:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425741C236D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 04:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BCC57C8E;
	Thu, 25 Jul 2024 04:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="z+z1jpAw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7E4F881
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 04:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721881010; cv=none; b=FdodNi74851mQv6DG7PcJ2EfbK714aqUDsnud0fjssY/5wUGUR06mw0iZZ1o3Zdv+2Q2zqtOsSLMlM4FU1wuzjq1zOd2FO3JOSqUAgQBbLsuR5/QmWoQOnySFzoct1vywJ9Wz/cOyvVOSd6dE3F/F7rd7CjEY6p0tg5hRrx2SfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721881010; c=relaxed/simple;
	bh=wrX0uryyy89vYlAinvVr2O6QBZz257uuEBuSnzas59I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XnT9+bM6VahXsbac0N5QEvxAR6pz1azVTsBMRnAXKrbzxRPCs8cbtiIVS3hwl+Lo9z4r8kdiq55hBpIBJmaLOcPzih6mVJwC82Sk5XOrmXTylseNN785kpxDAW6OXptjSUmSUFzSOe0fAqCCtHVeyh/1onNmJyBD0ZSAhi7hfIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=z+z1jpAw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d357040dbso418523b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 21:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721881008; x=1722485808; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=425S2jEpk/4yk63j4Ow9jwZmOCFjeEcHZbKGmEqnWN8=;
        b=z+z1jpAwYzVgvceeMoKYmd5+PwwK4Ru2hHLPw+OnISOO0gU/0wLqzIqYZUFLjgou0k
         qUTRy13HI7sNJ9Sj15a3ac1A23sIEkNS2os82KPbtrbldxj0GaJO/AGeghE45WIKtAy3
         QiWOg1KFsYWPOvUQhVxSAKtqAfbrd6aEkH97q3cvjPMPC0bVBUVDFEmJ+UVzt+BtpxcA
         ep4mg4MpUUU5WgXe51rWFT9FDVSWOBmjrkyAD/7tmmSw7wjwgh9GCyvaMvQhSaF8mX6M
         s7J8YltxpEcj+M3xYFbi3go4V+JqQtIp+JFRDSFFMqrxS4JgW/St8Loz10jUQXTfmZym
         JxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721881008; x=1722485808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=425S2jEpk/4yk63j4Ow9jwZmOCFjeEcHZbKGmEqnWN8=;
        b=GaUjUI2H0LnmXvfndB/lxvHGrcBOKw24l+EdAYQQTzEuKgAf17Bc9Hg8DFHhXcbGYP
         Ks4EohTtb8b2/XB5YQtCUaWzNAiKuXFErQ7SxihyXtAnHZPI0ekNHHd4eUkWf5aYvJAl
         mlyjNJDaomWKm7wGRle5ttt9jxZbjbOV3+D7zlk41HGrnd+3/cvLfJW5mU1Hkafyt8lV
         vw4d6U9B9xIvFeJ+eq3SLUX5A0ShvSvAwvrz/+dh6hfzlbxWYU/2YRw7NlJ9CuTW3ZYP
         kcfGmulUb7pIJVpikUJIutQZ05Aa0ssuT65vJ2R5QbpGTBMDmX+z27HOabt6RJtXtaie
         +/5g==
X-Forwarded-Encrypted: i=1; AJvYcCUqeRTp55uZ/gKw9LMgl/517PvUalNrm10bggQ+a+nU+w0Ab3K0FjYdCGxm4kSkHX4h2rHhx+8XOnnKu7bQKPeG607KcFi3hvMFnJS1IRxH
X-Gm-Message-State: AOJu0YwLMbtkOyJc7MImLK4vOl5TKnM/XuYvX3ouVlhf4LDKkv+vuDkQ
	1twoK65gLehW/hW63D8gmOYnEnivjseCiQEgYQn8+nBaEirGxuHPUgI7iHWqDrI=
X-Google-Smtp-Source: AGHT+IELFiGNwGGv7BR7vYWVLsiKiV4ZaPKzv5DoyOE6vOqbQlIXSrJhQprJhQfqNRbBaTkdXj3ZOQ==
X-Received: by 2002:a05:6a20:432c:b0:1c3:b1b6:5066 with SMTP id adf61e73a8af0-1c472893397mr2419803637.13.1721881007915;
        Wed, 24 Jul 2024 21:16:47 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f2b80bsm3781825ad.205.2024.07.24.21.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:16:47 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jul 2024 21:16:23 -0700
Subject: [PATCH v8 06/13] RISC-V: define the elements of the VCSR vector
 CSR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-xtheadvector-v8-6-cf043168e137@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721880993; l=930;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=0jkC45FH0LUvSVfvCEJuCBZ027fqPbAipPAnc4zFoN4=;
 b=XoiS1Ep8clInqZ7ahG0jkemQdoRrDU7bl84W8H28OTMlrx89tCkebW1m05ZpUpyXPXMGRWIyU
 Fq/qygjnv8pA9unHDFBhSb8y5j5eJkXw3j05S6lI2uSroDPOkH6rML3
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Heiko Stuebner <heiko@sntech.de>

The VCSR CSR contains two elements VXRM[2:1] and VXSAT[0].

Define constants for those to access the elements in a readable way.

Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 25966995da04..3eeb07d73065 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -300,6 +300,10 @@
 #define CSR_STIMECMP		0x14D
 #define CSR_STIMECMPH		0x15D
 
+#define VCSR_VXRM_MASK			3
+#define VCSR_VXRM_SHIFT			1
+#define VCSR_VXSAT_MASK			1
+
 /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
 #define CSR_SISELECT		0x150
 #define CSR_SIREG		0x151

-- 
2.44.0


