Return-Path: <linux-kselftest+bounces-12252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85AD90F292
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 17:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7647028353F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB91159565;
	Wed, 19 Jun 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kUX3t+q6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD4158DCC
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811679; cv=none; b=eY0EqMakbkNbhgk1/rFD0HAHVUj2eLgVVd9x5QLhZV38xeZsJd8ogBUATTB8WPn5ONc1be/BXD/bRyNpSl0s2ksKeLDrWU/j2z4CEI47pMjU9gzDUFnpqnDjsqTN7PS0Duo+Ffxz3CDpLPh3TfWJgyIhK7pkeCipWNSXxrw3yPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811679; c=relaxed/simple;
	bh=qQty25/2IPJCkenVM9tQdvdenEgFf8HeohkJI9e0LVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uM524omPJgAEHrJ+gCtz1d7X48Ejmtkdko6LposoDlSR0iC0e80C2jt9RLnr7n+veRJWbT764I+iw57GdVkraCHU8g2h9Zd50RhgMF6IX0fnVFOhxqyHh22z78CR6Dv3cNKTNCWhSWmZzUjqloHG0DHI3t1KP/M7bOSLQnvGJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kUX3t+q6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42479dece93so336265e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718811676; x=1719416476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhmrjq4H2Oq8xJPevOPzXZFQ+Nl3u1sJLUiSeD49DFE=;
        b=kUX3t+q64FPwaPYM8on0dgo8kRCTnk5mx2OHX18w1EEJxk//PT9R0GXQI7sP+UW6B7
         RKmrd232eHLzOApxzDlxKlXUafQXaBAKWKVOKk/lltVZseGXtFqLU+/Nvyg1SG2kQ1D4
         lTQ01GC1r6n6Cx9Q6unb17cKFyeW2n33xuG+LWwDQ67bCQ86MzXRIY9h+CHoyJ6ai+o3
         BE4qEcwVi3iYWSR4BOSdtAploNF+4CgRXvOVFAyCNPdRwI5e3JED/P+KOUjpnY9BWUUK
         AtL/GC+hZ1dsshyXP5nZIQ+QRouScvH6hfdSiPh1gb9tmTzLyg8bkQ5rXxETXiDwiTct
         RdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811676; x=1719416476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhmrjq4H2Oq8xJPevOPzXZFQ+Nl3u1sJLUiSeD49DFE=;
        b=KJwXiCfn3/bsslf59gTzygw1SVxnDPBpUHE8m6sOa8OfEvIG14n5hoZcE/WmiYKWTr
         HohwvfaJQuJsC1QGoYCamZ01hn66LgNi0pjyJR++jjXiEVQ8c09dD+hs49zkcbbsW2hD
         h4KWa65V8GG6J9M9o54d8Ss7r6G/cMyQmYTkg6X3UIPiT2qFeB3sTpgFxyMEZs0tEpQJ
         +bASr/9ztYIfoSj7TjRZbwZRWk+6J4EAOQ3IvLJSGd2NAEUqhDzgwmqkk8JI5exdoLKY
         jvTdqiglLT7/fJ1duNNnwz8SZTtMsLeU/iwl86dmvB8bjyeUjrSvT/e/6PvLULSpa7l0
         7ONQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTJ9u9Re6ezOMIvVwEmzPqYGmM3amrpXXafzU+1L/MsaXRgNI4vokanSwKqdeLaKWSKq4C+L9umAEhKd+ugZgPIFujBTCEhd0Kk2Ah6BKi
X-Gm-Message-State: AOJu0YwDtzLlW2o6FNcLfv2ukrP2k8u0cD/isEXbcFYQdUI1uZt7zv8B
	80F+nX1q11iTDoD0F4rKn4snuZHylgu0FI2pU3BNbDLpCHB82RVfIu8I2C4oKDE=
X-Google-Smtp-Source: AGHT+IGjwtUZf3kMWB9g1O1qJeQzBRQZ0qEbWnfWNveuCVuurscQ/RMRjo/RFMkwbrEud2Tb1Hd71w==
X-Received: by 2002:a05:600c:1d09:b0:422:2f06:92d1 with SMTP id 5b1f17b1804b1-42475296800mr18928745e9.2.1718811675796;
        Wed, 19 Jun 2024 08:41:15 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:819d:b9d2:9c2:3b7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c785sm17392292f8f.34.2024.06.19.08.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:41:15 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 5/5] KVM: riscv: selftests: Add Zaamo/Zalrsc extensions to get-reg-list test
Date: Wed, 19 Jun 2024 17:39:12 +0200
Message-ID: <20240619153913.867263-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619153913.867263-1-cleger@rivosinc.com>
References: <20240619153913.867263-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The KVM RISC-V allows Zaamo/Zalrsc extensions for Guest/VM so add these
extensions to get-reg-list test.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 1a5637a6ea1e..70216a1760c3 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -48,7 +48,9 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVNAPOT:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVPBMT:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZAAMO:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZACAS:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZALRSC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBB:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBC:
@@ -420,7 +422,9 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(SVINVAL),
 		KVM_ISA_EXT_ARR(SVNAPOT),
 		KVM_ISA_EXT_ARR(SVPBMT),
+		KVM_ISA_EXT_ARR(ZAAMO),
 		KVM_ISA_EXT_ARR(ZACAS),
+		KVM_ISA_EXT_ARR(ZALRSC),
 		KVM_ISA_EXT_ARR(ZBA),
 		KVM_ISA_EXT_ARR(ZBB),
 		KVM_ISA_EXT_ARR(ZBC),
@@ -950,7 +954,9 @@ KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
 KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
 KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
 KVM_ISA_EXT_SIMPLE_CONFIG(svpbmt, SVPBMT);
+KVM_ISA_EXT_SIMPLE_CONFIG(zaamo, ZAAMO);
 KVM_ISA_EXT_SIMPLE_CONFIG(zacas, ZACAS);
+KVM_ISA_EXT_SIMPLE_CONFIG(zalrsc, ZALRSC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zba, ZBA);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbb, ZBB);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbc, ZBC);
@@ -1012,7 +1018,9 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_svinval,
 	&config_svnapot,
 	&config_svpbmt,
+	&config_zaamo,
 	&config_zacas,
+	&config_zalrsc,
 	&config_zba,
 	&config_zbb,
 	&config_zbc,
-- 
2.45.2


