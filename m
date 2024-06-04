Return-Path: <linux-kselftest+bounces-11199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C758FB2E5
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 14:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F9F1C21137
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8AC1487C8;
	Tue,  4 Jun 2024 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vCq1yQam"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040A81474A2
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Jun 2024 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505350; cv=none; b=XD3s7k/mKgzZ/Q3pFo9PSzubDiHlnX3Wg9rZFLKJalDskN2sNR6Akz5GHNjHVAMgwRqGSCEqViiWIfLNhoTBuy57PrZ/UL01zm3ieBqV7Q7ljJELV5F+lVtFHOh7BA+WpMJQtvbXw6GVKS3aovryJpmeEpzJDhA3FkYs23s9cjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505350; c=relaxed/simple;
	bh=357m/ySm8YmI/mHReOWO3avBpEV/vbn5oLJERS2x5MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSqlk175bRJ2JtstHgdQcRK+AfleHNYuQ1+tZACPfbGchZwUOBM/qP3JTFeYDLTgj58yyWmVg4E3+RQRhdQUQmiL1E49/h/fsVvTQAtm6q9pyGP6NMyPsApa5+I2alrdPUcR0PVTR4BZzG+I/Riv72c4dPr2LISAHGa+8bWcWvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vCq1yQam; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6c9cd96e485so313963a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jun 2024 05:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717505348; x=1718110148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6H32tM/kIq9tLTuMJ+qVcoNAPrEuAu35f6jcL7aj1B8=;
        b=vCq1yQamad92EBhi7A27wk05dWT15WKeW3I2wtpl7qnmT1bbdR/K4c05oNSknx3qzm
         zYtCvMs+QlRZi7HrzukoWCgxqMuNG0CFVE/pnS6m0To1Red17FUivF4EJjYhk/qIqEaE
         Pvn/HY6ZiXCaMAwADrjh5l9LDtMjL5NfsxV4MJBt47jV/oS4XOPwVexe63cR9yq++OB0
         I1ibqRCmOAzYgYWqSJF/ico/UTz4G2D9WgPCj8EvvDriL+R+JKK/+m9iBHUHN2lStGqY
         yxFDpX3sBfEOdl9B3/J1igaSCYEiZmMUQGCy8KTKw1vWRfd+4JYlxn/ezPbixGqHWvhc
         qUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717505348; x=1718110148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6H32tM/kIq9tLTuMJ+qVcoNAPrEuAu35f6jcL7aj1B8=;
        b=Rw8eD1S3MG20XIPtst4BLt9UVF/k/7QOTGM68ElRldagLs3bhk2ham15MfMBWN67A+
         gfPVWIBteXy7LY3wc0YnC6IT/bkGP9kJ5hCAB6PsR3L8djXQ7DGJJA+wOhA5TNueSXM7
         m6AElrXKybaX/aK/r1gG2+doxMW3vcIPriwP6ZoNimGf+um9db2Ch2kAQ7a+xctgoAoD
         UAEH+TXm3YBy15dSq+wewK97/6D6ocg9j5F/ePFjwOSR6qSBsxMyTwVXNPUx9e8QyaBe
         LbJXlEL9tJapbNO5Dt7oo3WVrPOiutfTSMcJWwp8uW7KjxYWkUQivNcwO+DBW5NNi2rq
         X0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVGI8uG0wMPcn6Kkzrl7epvT1okQG0gY1Ek4ODTWaiZCoHT8omSHMpd8m/IsiaGz3vPKFsXsn7jl4XYAMTLYOHIV5yMVu9nVlARadAXe5cQ
X-Gm-Message-State: AOJu0Yy1+b686ARWBAJK/1ErdM++GuwTe1Kh8SQ8TgzMTn0vANP5+hCb
	SHXBEsGa07FLWr2cYEV4z//Y3i354wbZG0rj3/bGOGgCOxzHoBvIjmpyZy1dzi4=
X-Google-Smtp-Source: AGHT+IEOlFKJRCl1OGX3feCz8BceiHmgf7WyvD3dckWQnAhBGa2tvUo1bIZmX+1nEEZL2bIqoKxgpw==
X-Received: by 2002:a17:902:dac2:b0:1f6:2389:221 with SMTP id d9443c01a7336-1f69424e9c7mr22945345ad.5.1717505348316;
        Tue, 04 Jun 2024 05:49:08 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:327b:5ba3:8154:37ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ebc69sm83042885ad.211.2024.06.04.05.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:49:07 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 15/16] RISC-V: KVM: Allow Zcmop extension for Guest/VM
Date: Tue,  4 Jun 2024 14:45:47 +0200
Message-ID: <20240604124550.3214710-16-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604124550.3214710-1-cleger@rivosinc.com>
References: <20240604124550.3214710-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend the KVM ISA extension ONE_REG interface to allow KVM user space
to detect and enable Zcmop extension for Guest/VM.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 71b17a6799e6..a6215634df7c 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -173,6 +173,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZCB,
 	KVM_RISCV_ISA_EXT_ZCD,
 	KVM_RISCV_ISA_EXT_ZCF,
+	KVM_RISCV_ISA_EXT_ZCMOP,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index f68b15b15f0e..fa5ee544bc69 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -53,6 +53,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZCB),
 	KVM_ISA_EXT_ARR(ZCD),
 	KVM_ISA_EXT_ARR(ZCF),
+	KVM_ISA_EXT_ARR(ZCMOP),
 	KVM_ISA_EXT_ARR(ZFA),
 	KVM_ISA_EXT_ARR(ZFH),
 	KVM_ISA_EXT_ARR(ZFHMIN),
@@ -142,6 +143,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZCB:
 	case KVM_RISCV_ISA_EXT_ZCD:
 	case KVM_RISCV_ISA_EXT_ZCF:
+	case KVM_RISCV_ISA_EXT_ZCMOP:
 	case KVM_RISCV_ISA_EXT_ZFA:
 	case KVM_RISCV_ISA_EXT_ZFH:
 	case KVM_RISCV_ISA_EXT_ZFHMIN:
-- 
2.45.1


