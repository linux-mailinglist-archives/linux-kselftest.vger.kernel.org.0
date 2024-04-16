Return-Path: <linux-kselftest+bounces-8208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8B78A73B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 20:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838241F21A7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 18:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E63213FD69;
	Tue, 16 Apr 2024 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aEEo+vGd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F213D8AE
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293110; cv=none; b=Llh22iNZO2lM/k8OFcWYsv7/cRQngHgHknxf/6E9+0FHZqyuWQKypIJyvIkn1JaHUNqdJWQXznxiH2L0D1vwq4fUtWSEHrx6N1RJ49FFxkNrckyg9SiDxSTI07GgWDzqCAwmxidtj2Gtc6SLSNpt5C07r2sMucARSXNx1NmxWu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293110; c=relaxed/simple;
	bh=kGDqdfAz5O6jd2BlwqWEgDKuhCYmFyrLfaexp9eWGuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V2d9LDmTAqpe4adfcjMe+MlcwSHfOJ7H/fzTDX/kjbZEWI3gH3XHvYYi0TXFjXPu7YthiZpt3XZYUZ/rCSmysX3fh6ux1tRvFMb6+Vt56KuCQpuNcuFVRE4QQyqAiuzn+ySDmusF4A1j0sKV3Zb0HHO8uVVtaJeQRgr7KRQX5ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aEEo+vGd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed627829e6so5181370b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 11:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293108; x=1713897908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZMdAGbGUb3Pn/mM6S9aCTNbs+MKWuMa25SVPrHMqxo=;
        b=aEEo+vGdgR6NcF+0+HebnJ0ZatfUYfidhByY9xCAgjwhItfkpuBAclxYm3JLOyN5sW
         xZRlOShsclLGZdHP1tPhi9MZeHL1oc+NstVyPNIzizUG+Q1PReJTo3Ueai0QOJXx35Ds
         BiF3DUxOaBMFdYbsgUYsoSer7TiGa18lWeF8o/Ss0JwFwBZE5fiKgLWcUliby+37nIiX
         +KnQFRCrDYaKABzZK7ET3AgQ+V6ZCtOhBhqf/Teh52IK7w7ByVB3UVcLsbQaumC0hsrY
         8vHx2Ru04oYzf3BZKJP0oFS8rAaLJEA569+fFiTe9FFcqDY0hM7+SLJfuRJLpeaxQYCX
         AB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293108; x=1713897908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZMdAGbGUb3Pn/mM6S9aCTNbs+MKWuMa25SVPrHMqxo=;
        b=XqOVbjb3osENv5On6ib4ZDHZRWruFKSsns4e8fct1cI5Pa2TUSsqYJ+EC7WXGEkQ95
         gE1tPH7hZZ+51ghxq1Ps8idNYqBeK+2N0nCxpgTzNIWrDLnBrNZjFZUhzN2epbUZk0PX
         /xtud/jlbWE+UhF+j5/PR+adQ0tcWk6P8JjMmF6lmJ0xKy6iJu853QUL3i8PCIYFidwC
         pqUUmlyQO28Rma4yN5Pl1mAx0yQ27kMpMDIsk1Zp9jrIqSwopazMPNHCHOjzt3wh0WPz
         jQ5lmzU2biU+iNVs5HSZ6e2Ibn9575Jwp2hGn41OFRaEAztz7zbPSY7splhhcaIYQGFe
         vEyA==
X-Forwarded-Encrypted: i=1; AJvYcCXze60+9H9eW9V9od05ro7yAzDvritPaZh6/t/6bcPxw/YQs8hcdLnArcJKcIhay4Fp5olRMJZ9MQj760dt87SZTpOk7q4O1/6qi6F9Zqdy
X-Gm-Message-State: AOJu0YzwbxHkYMFiw0VJ/7wtWm6aYm67V/bnKYM8umlfeTrKs3vs51ol
	lEGc5aoWk7ZB0jrc4MOil7mS/9stPL//yQ3Q16Zic1/aPXCGkm/Pyx3SwfTc0dY=
X-Google-Smtp-Source: AGHT+IHgRG4T/+azse3yQ3uEFH4UwWDhG7EwA6pm2R37KVOzESHt+dYSJ3kmp52wvG9g6bY/TLOb7g==
X-Received: by 2002:a17:90a:fa08:b0:2a4:7df8:bd71 with SMTP id cm8-20020a17090afa0800b002a47df8bd71mr12249412pjb.13.1713293108318;
        Tue, 16 Apr 2024 11:45:08 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:45:07 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v7 19/24] KVM: riscv: selftests: Add Sscofpmf to get-reg-list test
Date: Tue, 16 Apr 2024 11:44:16 -0700
Message-Id: <20240416184421.3693802-20-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416184421.3693802-1-atishp@rivosinc.com>
References: <20240416184421.3693802-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KVM RISC-V allows Sscofpmf extension for Guest/VM so let us
add this extension to get-reg-list test.

Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index b882b7b9b785..222198dd6d04 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -43,6 +43,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_V:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SMSTATEEN:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSAIA:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSCOFPMF:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSTC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVNAPOT:
@@ -408,6 +409,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(V),
 		KVM_ISA_EXT_ARR(SMSTATEEN),
 		KVM_ISA_EXT_ARR(SSAIA),
+		KVM_ISA_EXT_ARR(SSCOFPMF),
 		KVM_ISA_EXT_ARR(SSTC),
 		KVM_ISA_EXT_ARR(SVINVAL),
 		KVM_ISA_EXT_ARR(SVNAPOT),
@@ -931,6 +933,7 @@ KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
 KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
 KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
 KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
+KVM_ISA_EXT_SIMPLE_CONFIG(sscofpmf, SSCOFPMF);
 KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
 KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
 KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
@@ -986,6 +989,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_fp_d,
 	&config_h,
 	&config_smstateen,
+	&config_sscofpmf,
 	&config_sstc,
 	&config_svinval,
 	&config_svnapot,
-- 
2.34.1


