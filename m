Return-Path: <linux-kselftest+bounces-11617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EDC902C07
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 00:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13BBFB20F07
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 22:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E31154C16;
	Mon, 10 Jun 2024 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dsnMXQC2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C31153835
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060220; cv=none; b=qIwatjXxrS+/cX3uLBFxJN6BHOrbhkysBfjMtSGDaHfdkgVGTlMn0sX+MRqGIn1vYQWFQO41KmqSRCmbkIRdee6nOnom9ltdfEgaJWxF3SAIMxgiY1oLN7ezQjFsBRGYY1Qi0ZK0978d6zsLGAOPzYmGBk/vPFakJnet6sm5oig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060220; c=relaxed/simple;
	bh=SMA++MELxtndsmlf2ltstvee/EM+yG8MF8KTMj9Ilaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ma/sfEkeEDYi4qfa7h2uGtizN+Rp58+hUPqlgFxVRt8RfGgTegH9aw4Vlp3SR3kaDMcjZ8eP73JrMCcl2EFROWjlwvoNHqxvm+IcJnSFz/BPcW4jP3GPt1/v2Jbbl1KylRETceWi6TEruUdZ464UpeFN6lE+vEchTvbR+ZcvuKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dsnMXQC2; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6ce533b643dso3807302a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 15:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718060218; x=1718665018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P240Gh/m4dWtpIWWlN8DjDnG2wL4gQcnQEBhQHOtafc=;
        b=dsnMXQC2A8ql35dyko7yj+c6ivPscOXAUUtKOYLyrCzBxZS+b+q3kNF5Zlnjeh9sBc
         TT6wLtg+BmuYVfMRi7U35UzSQS9ZMp6ja/K5IImWwkg8I3Tzj4nYKz1I6ZS0bncrF+sf
         YTfQ50ulNGCLFhTTDDh5Oe9sRR2o0dCJv/elUJ0/QUkeP2t5zbOVeRVlezBWsUdY4hDw
         r8GB/Tg+mj6JcMWIpQBu4Sl2D4DPzHKaa7oOsV/JYEsdhQ6SvqQPm2HtXi4tSYI9quFB
         7ukHAWQ6FY110k1otIIhIvQhHD5TR+dP6lqHFesiPboI/Ru/orlrz3BzGRuNRsFliAOM
         STcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060218; x=1718665018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P240Gh/m4dWtpIWWlN8DjDnG2wL4gQcnQEBhQHOtafc=;
        b=D8lCwy/jQnjAfDUvKQeiPKTcrqdm2Jq0b9bCS2wSu6DPqsUQeVenTU/hWYnOaM3tWo
         lBRGIVGLmW3+zcA9sJTk2F5Tqd7lHq/GBklO75uRpADpP8Vja8Hy8HH88QhpqecLj+h1
         5oj/J/y3dHtv9ah4q3vx9MnfiLkkz2KLGKaPLE7IVtNYyqKQ/jCwWjDpMD7QlvJ6NlwE
         TZhkci5hwGprBYv07J3uFynXm95p0/H9tCc/mcKlRVwTYEoDNo8hCv1UR3Qw5ACS/xC+
         tay5/it0NobhYfhwipmfSqoEGUYJTqNJ/463SGqb+LTPDeocVxNJ9c10vP8VusotDcco
         Z71Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGQKPWcPsTt6WkiMFyeQOxxbSzQGGF9cJEah9Cc4WjANKVQ25Cdijo4uGu5GqAjQqV7IGcC6d14C2ReLywvBqlLTM1Wz+pyS4Havttgr+9
X-Gm-Message-State: AOJu0YwytiAacIJY1SaDtJ8g2MOenmMDlXnsFDuB49KTWwPAgMx6pnr9
	PkiKddHZHEqkIJJXTUYsyCrIMtHuFWkidH5hfmBas+Cc16alrpfTZH+4/alTmsU=
X-Google-Smtp-Source: AGHT+IFseKGLwmj2osLDgxyS4P9gQTqGeoZhbSAjbr4fblHxFDjXaFSWzLh8Eh75n43SvPorzoMJnA==
X-Received: by 2002:a05:6a20:2d0e:b0:1b6:482e:b71a with SMTP id adf61e73a8af0-1b6482ff7bfmr6284268637.62.1718060218334;
        Mon, 10 Jun 2024 15:56:58 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71b597072sm18355865ad.99.2024.06.10.15.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:56:57 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 10 Jun 2024 15:56:43 -0700
Subject: [PATCH v2 06/13] RISC-V: define the elements of the VCSR vector
 CSR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-xtheadvector-v2-6-97a48613ad64@rivosinc.com>
References: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
In-Reply-To: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718060203; l=954;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=rl/YEju2Da4Y30TCSeGgcBJQ4jtog67tmUBEGN9KrFw=;
 b=IRhCPk4XbmkpRzK84lEWmQUutCnAIEIrCrTYoyF07vjrds3h/wdbdAbFu3f7IKtjrQbzVrH3b
 BQdDwVsjJq7D1QtIM9g/0505gvg5bTytwfowlYZHjPzLPpzNFKDydTs
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
 arch/riscv/include/asm/csr.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 25966995da04..18e178d83401 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -216,6 +216,11 @@
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


