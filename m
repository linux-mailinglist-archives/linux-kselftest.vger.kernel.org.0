Return-Path: <linux-kselftest+bounces-7639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E774F8A04A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 02:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205721C21282
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 00:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ED5D529;
	Thu, 11 Apr 2024 00:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="N7izR4Vc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E27942AA5
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794142; cv=none; b=hV1S4BqrxFLycZYHp/pc0CNX25ieFRI3GTdCs2f6tej8K/JhsngEWjwr5aUAPuDD5K++MiAPGNHXuRUYrAhO2yCEnY1ULt6sk0xaFM0uMIJc5ppruNLYqmoJmByZlJ/TB2gOK6s/oMgCupp/mYrVK7BSj1eAuOwEwpD3rrUCb4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794142; c=relaxed/simple;
	bh=kGDqdfAz5O6jd2BlwqWEgDKuhCYmFyrLfaexp9eWGuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U5oajDDMHchD5YCi1BYYBPyKh2pyNF3g6F2GS8FDaLex3KSAH77CPXGN3hh8VGPgd+1+wB9x2qNGp0fSHYdVfB4KqskhH9O6r5rWpythR8VN/Q6QFtV8ZAb92cO8YMDAuGMMp8XrY/enJaKyBFw2YDZ/7abiSK0FqN1lx8Iqlhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=N7izR4Vc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e2c725e234so2638705ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 17:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794141; x=1713398941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZMdAGbGUb3Pn/mM6S9aCTNbs+MKWuMa25SVPrHMqxo=;
        b=N7izR4Vcxres3nY5iQCYxRXWkjvzCTswc6Jukhm2AKYOUjXJuZuEUvBeTvAEGVBaPi
         cP3zY7bCUAa+M0hTeIO61H3yCDPfQWpS5O5IYY55Ts3W6yMNEAqDstEKaFFAzI6Esbvw
         cXBfsgiIp1wa32ZvOSwwdLl2glErIrsjXeeEXZapToRJFtYplzSDXYtGd5+c3ba3egs7
         s9cV7buVU1ghALy6TN+TY9ryLIQ4tDa0IMSGSMR59jx3NzOy4OyZ3CjWg0PUZZ6pbKVo
         h0EMqwjAnaW0IXalNyx/EFDNHx2sT64YK5JRqfGdZjkG86ZX3fgT2pOZE3yUJp7+lW+A
         jy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794141; x=1713398941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZMdAGbGUb3Pn/mM6S9aCTNbs+MKWuMa25SVPrHMqxo=;
        b=vE/k8ZKhIlVJMF149dK6XbftOv4D22N7RXfbb6vrkmXvxDSdCfQNfX4+6PjdRqDUS3
         hAEbmym8hXHUfpMYu7UW9d2qfvvaywja44xqHbBansTkNpHuyUKAac+RMzUs8TBtBmpx
         H6EJmPX7WMEk2wcY4vKRXnG5lH31UjaiZv5GQVECDDBm5R1G1Ng1Q7wQ7qNEvtJL4F5B
         dDX89ZtpGqlOmwglSSbAL6e+TL85RE+OcPivaRvx4hlFuQIkwzFyimAxf1mOWgNs1uCt
         Om+iF5VXT1/jemqSpxNJ8xjCd8sAG6Hl1cGybjQ7az1+tej73ipvTGDZhAbn4eAFlUPc
         TASQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjvvKOs3bvpQUtcA7MOSxUjfy2KAt1dOLPXcbjkcn0PxgWZcK51ZsiLmxZpjJ97FjDzaQKZb7Xku3GDkZtgragyP61s7qkAfEr21kI8BAV
X-Gm-Message-State: AOJu0YxFqE+QfJWmscNS+TeLf6vo8YhDZLorUq9XbtH16j/yrjzK4irX
	TxOyc+CLLVF3QPd+hssBSCsScs0Nnm3DK0zRyRHD6yGWvze76pDV1wiAWVCRi0A=
X-Google-Smtp-Source: AGHT+IHrdco+Nn3vB823qWCjNowMIOzBoGtN1xF2JabKGjxDIXVa2NH6OeieucLnKkpVZpIdiowNLg==
X-Received: by 2002:a17:902:e743:b0:1e4:39e0:660c with SMTP id p3-20020a170902e74300b001e439e0660cmr1368224plf.23.1712794140724;
        Wed, 10 Apr 2024 17:09:00 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:59 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: [PATCH v6 19/24] KVM: riscv: selftests: Add Sscofpmf to get-reg-list test
Date: Wed, 10 Apr 2024 17:07:47 -0700
Message-Id: <20240411000752.955910-20-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411000752.955910-1-atishp@rivosinc.com>
References: <20240411000752.955910-1-atishp@rivosinc.com>
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


