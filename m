Return-Path: <linux-kselftest+bounces-4629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFF0854958
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 13:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7731F23973
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 12:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA64452F63;
	Wed, 14 Feb 2024 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DHowmyyD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDEC537F8
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914301; cv=none; b=hkwtR+HosMtuGZT3f1PW4yQbSNTcvG7fjQYdPsuO85Dt4s5EEgh/hFrW8BU8ZtQzL71iLh/wr+8PCcnMeepCpgnacioLFPSCOyXCONzDN55vhNqYZIXH/C4sC7FZtSA5ggrscqcDJckKIGT01whNdiINArwpnPfEB6oKR3fdKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914301; c=relaxed/simple;
	bh=c2+76faT1dINMScpmeF2F1CzQBtl7c0GReCrzYb31Pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oYKEZSZ1PZZglkgkdP4SwYh3g2srXN2dqTaqlIoZKqHouGqgkRIXgI2b35jpIRUdSHGVhphzuDLwua2LNT5vy3zVW3oqiY+VCnkNxKQ9aSgBASYVYn+Zcw7PKEW87rjkEQE+IfS2xp6oT/740yVtqIOveUmDjYK/OJqUKJei2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DHowmyyD; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e114708b67so138525b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 04:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707914299; x=1708519099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtRzUtn5YlgGEqGNmE5oViuKGD26HTcJD0Q89ujSctY=;
        b=DHowmyyDEHkxsIMMpPhLpPVnbetZ7o+DifFSlfGGSj5LKLlA/s2w8hxgCE7yxQMX9j
         MTUmlWgcQJcQOqwCRKuoTtHCTIc6GdVG4xPbHMrc8gFXOzhdKN3CWR05QMla0JKe2c/m
         dqe7rWOkBDx4rYGXcWJ6se2coi5DxLRlq1ES8DVn9kcw+DKLfOqgs/1FWzJQaGcv0loQ
         OlDC55sC0vxuAFOKzo0EMd5yLlHmzcPNREewYpwzxGHO5YIXun2v4lEq1hc1qHT6zWHC
         LAGeHt9WKEm+B7kzOTVrraygsqNYQ4JAp4B3Jctk+Tyq7nWNJadLhWBHKP87LeOggVYN
         E0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707914299; x=1708519099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtRzUtn5YlgGEqGNmE5oViuKGD26HTcJD0Q89ujSctY=;
        b=jsqmxvvUt0VR4rqfQwmlWapaovTmJVZXG47QLMa4Yk6/6yBUT9O0rJFTJuKbrTTWrc
         IGSofBIVyI0o5Y2kUjcJ7Ke618iKiSfjEA9Sje/hTf+bkKexmzhb/fU4HhSmDHr/595G
         0B3cYy2lCmsZwTqF6ZTGTY4QkHaVqgaDl07y2n52A6RwJAQfuLgxQsoKLpaDAT2/hqhv
         Db9AmUnWMQ7o3FbSewuYWwfJXNXIa1FmY3suh7H4f7SERg0KXO38g5rWvRQ0PQ7DRl61
         KKPaJjxXBj36zV2ZDn4E/0L4VP9vskW64WB7L7aeq/iu+aEM0q+l8V7uG6lThoL+zX/j
         RWig==
X-Forwarded-Encrypted: i=1; AJvYcCXb1CHWqC80Ue4JkI+sfWCU5PImFOfr0w/AC/4b8DJs6ma4nVbuMDss0L/86ME17ly11joMcm0TjDAk1fAcfcGZZlaxZVt8J24eNdM2WLWx
X-Gm-Message-State: AOJu0YynNGoSXmboy8MhuBJWA5s1CnSxLTpik7eEsX4pOdld9Kb7yJQV
	7f5o87eoGfgWq1BM2Qi7OJQCzloLRywK8xGvrROVjDdAtrDtUlLezV/6oWlzarc9R/eEfaWrcFs
	V
X-Google-Smtp-Source: AGHT+IGCWZ5G/G3vbyNMBfek5NVGYdPpcnCAN0KmPun1zKGXih4KLFfWufmz/OYQLaOucpICouOPBA==
X-Received: by 2002:a05:6a21:1644:b0:19e:cf31:6a04 with SMTP id no4-20020a056a21164400b0019ecf316a04mr2855300pzb.59.1707914299363;
        Wed, 14 Feb 2024 04:38:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrXT4KToL9IgoHVlEatzhhCjqaY+aDf2dj3WXtREaMV4mVz7xD/BsynLgPAcDs1YDjmE60t4dut/SjiWkhbTvOevleB2YNKNZYIS19SAmNlE2hgyLgJhuLzf4qm1iogqAQxnKViApc+lYzuksXCv1knBeeRikj8YvcIXPoBUqJwAQzDYBhZwDXGkF5pQvyOMUj5qPsY2GGzZ81gTzJ6hteOMyADmeptjvymrVt6NED+ZuDq9a1Ks+rj8snJcamLctx8azbCwuMgKAr3SrDpJAGu1O411FkkvGCSFbB3bsz6Q6CTd8Oxqd4gaX7coarmV/Ix2htiWKpjx3EXVWnO3m+jbPNad0iid8txVbAZu/3P31wCiAi8REn65ISTwSDmI6/XM7mgZ/a3fDMXFQc8buJ4+f0iw4Z+H0YQ3JZ1IWCooM3JsOmzkeOv1Ny6A==
Received: from anup-ubuntu-vm.localdomain ([171.76.87.178])
        by smtp.gmail.com with ESMTPSA id o20-20020a170902e29400b001d9b749d281sm3041419plc.53.2024.02.14.04.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 04:38:18 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 3/5] KVM: riscv: selftests: Add Ztso extension to get-reg-list test
Date: Wed, 14 Feb 2024 18:07:55 +0530
Message-Id: <20240214123757.305347-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214123757.305347-1-apatel@ventanamicro.com>
References: <20240214123757.305347-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KVM RISC-V allows Ztso extension for Guest/VM so let us
add this extension to get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 9d9c50b68207..5429453561d7 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -73,6 +73,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZKSED:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZKSH:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZKT:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZTSO:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZVBB:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZVBC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZVFH:
@@ -436,6 +437,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(ZKSED),
 		KVM_ISA_EXT_ARR(ZKSH),
 		KVM_ISA_EXT_ARR(ZKT),
+		KVM_ISA_EXT_ARR(ZTSO),
 		KVM_ISA_EXT_ARR(ZVBB),
 		KVM_ISA_EXT_ARR(ZVBC),
 		KVM_ISA_EXT_ARR(ZVFH),
@@ -957,6 +959,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zkr, ZKR);
 KVM_ISA_EXT_SIMPLE_CONFIG(zksed, ZKSED);
 KVM_ISA_EXT_SIMPLE_CONFIG(zksh, ZKSH);
 KVM_ISA_EXT_SIMPLE_CONFIG(zkt, ZKT);
+KVM_ISA_EXT_SIMPLE_CONFIG(ztso, ZTSO);
 KVM_ISA_EXT_SIMPLE_CONFIG(zvbb, ZVBB);
 KVM_ISA_EXT_SIMPLE_CONFIG(zvbc, ZVBC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zvfh, ZVFH);
@@ -1010,6 +1013,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zksed,
 	&config_zksh,
 	&config_zkt,
+	&config_ztso,
 	&config_zvbb,
 	&config_zvbc,
 	&config_zvfh,
-- 
2.34.1


