Return-Path: <linux-kselftest+bounces-43389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE17BEA8C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7C795A87D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7963370F8;
	Fri, 17 Oct 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="AfXnsY+y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D103370E3
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716796; cv=none; b=Gk3oUQkYtESNCwYz4hSkHfPHExZ6x+O1gyBF/tziEIFruRodBMFaomnqRULGEVS2B6NREs8Sr9aqfwBEc2z5/aeuzOk37xjljf4lODvZRzOji9hh9GZSNK+/tZ5n0xbeX+PQdLjz5K+eOHRnoY4pHwAhv9jC7bvQsV+Bfatx88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716796; c=relaxed/simple;
	bh=mljYXy3IxITmRqF+iKLm3Yh6cbzzCUWnVlBHoIsPH6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKz0UE7l592er1ATJkMkg74qtbF3L8LGVdBLthIT90pU783W+fPCpHk/I2Bl8cmNM1U9swpp0eWmDbPyx0NciCRdVNiYMIZwwNjdckk8ZIX5cK9mWrv3+7qttudgtmYCPZJXdhHJG1xIDoYi0cLe0oqbCsJv44kDkrpy7R8BxdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=AfXnsY+y; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33be037cf73so815960a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760716794; x=1761321594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOxr4kUrx3o2qKQ3zJr2xwhR1Y/B5zgWnTBkv0V7+0s=;
        b=AfXnsY+yJIHoIpXkMV9L3FrJE3DZiAZcjorvfPvtTweIvH0z6Fevs8BE08qTIY7xaA
         rsUBpZNI/4OnFBbhW/1LoM2jZbTbbtxeYpzUxHzvpS9astL1S1fvBsN6M2HBgmLaIzn+
         lSokbQVvN99pghh0Udt3AIluKAYiIBeduQ7FZVpqN3Q0PkEG9hwhPfD1SXdcXOGAkNwo
         0Pufjp97h5SEedsqZR6OEHa+JZFME1iq3VC3y62chg60qCntZHKLjd/5WSlr2aAVSVxC
         QU8sYRMny4hj9FDBPE2T3f7UAj8vbXFiM6auzIX60+rLK5kltJNpQrrgMIBnHf+stLLN
         dXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760716794; x=1761321594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOxr4kUrx3o2qKQ3zJr2xwhR1Y/B5zgWnTBkv0V7+0s=;
        b=GdrwFJ5A/Coc5ky8YNkimtLBiHVqJSfB4q367kAIRvIkc3H7GLTePjuYxY+yVeNSIE
         CQNEVe8LvPU7/UG1okDsxrXSZNIqeRL6uWwN8ouFRXTihjLOtG/W7DsqwXYEWkjWuT8j
         ae/VAoyvEwjwhL2EiqAkZO+8asJRFXVC2BQ3cFpShKCubNJOfRGNNFIvl24E9D1FTQvk
         MAsjFxqy9g5qk4StKugwN9efEWhPXvSa0PTMxYOylP4MRLTxYjTq02PbUS9F8+x1661X
         3+f1P3WvuM8UhzKIPAK9gcgNpJA2X1GXNpoDaeKLIpn/T9eiGdo11wPo1z0N1XoAAhse
         VsKw==
X-Forwarded-Encrypted: i=1; AJvYcCXkcLHLdbuZAPQH0uQnP1oxwakuJCpO7oC6arrR7NWVAsnySrm7C9R+GrihOt2tBASP8Lqws0ny/wvxL2zRbF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt2t07lUzFHr+wuwIO0fbfZEE+jdW1KJoDHYNZ3kXZL1Iet1mw
	ZFMcihbG4uDajLW9kbbx4+7TIBAu39+enLgQtRi5GTbigxHHGdZLOsnwUlEcGXSPfv4=
X-Gm-Gg: ASbGncsKRj+wParOKx3pLvZEWXJz1IHEaNbYd1apktiDO/uOFwN3Ll2GMl3xEWY/9pg
	ZbjAp+nX3Oeticcg2P9vly9XEi8yaS2gCF/ehv68by7AKsbEyqXmrpWwWuf5zWU3X6i01D1bjvN
	qmNi4u1edQeHHi11hzRp1NbfKDmGko6w/J3jE3NGGYcRbxlnMLfQ9x2mumha90In0Aru/apMQMC
	seSxVwH6zj2Eg6HMoAeNf4GOJyZKpmT2HwD7hu3VVHAuSDg6Ti+s53o++Xx+q5myH++EzFgtqz+
	BpZTYKMEqtqpyagm2uhgvmdIow7e83LlDJca1E9zpA+0eZRbKs58uj55sFEyv2CNOLcLsqxjHz5
	7VYpqw+8d8IRjyU5ZJEMxNknZVgqmSEE96/3+zyVGS++vBbfoABx6DDz6viv8B/AKGYq5HXt24w
	0TBHLVeN19xfJf4EbsReCI9+dPVocBeHa6
X-Google-Smtp-Source: AGHT+IFoCPBiPeGQQLQ+fG7ai4z/yEAOOUIjHcz+WvJaH5Mkp92XTCRypBxB5qA/CcWwuixBEctClg==
X-Received: by 2002:a17:90b:2690:b0:33b:a5d8:f1b8 with SMTP id 98e67ed59e1d1-33bcf86ce26mr4729546a91.15.1760716794026;
        Fri, 17 Oct 2025 08:59:54 -0700 (PDT)
Received: from localhost.localdomain ([122.171.18.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7669392csm151067a12.18.2025.10.17.08.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:59:53 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 4/4] KVM: riscv: selftests: Add SBI MPXY extension to get-reg-list
Date: Fri, 17 Oct 2025 21:29:25 +0530
Message-ID: <20251017155925.361560-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017155925.361560-1-apatel@ventanamicro.com>
References: <20251017155925.361560-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KVM RISC-V allows SBI MPXY extensions for Guest/VM so add
it to the get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 705ab3d7778b..cb54a56990a0 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -133,6 +133,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_SUSP:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_STA:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT:
+	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_MPXY:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_EXPERIMENTAL:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_VENDOR:
 		return true;
@@ -639,6 +640,7 @@ static const char *sbi_ext_single_id_to_str(__u64 reg_off)
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_SUSP),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_STA),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_FWFT),
+		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_MPXY),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_EXPERIMENTAL),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_VENDOR),
 	};
@@ -1142,6 +1144,7 @@ KVM_SBI_EXT_SUBLIST_CONFIG(sta, STA);
 KVM_SBI_EXT_SIMPLE_CONFIG(pmu, PMU);
 KVM_SBI_EXT_SIMPLE_CONFIG(dbcn, DBCN);
 KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
+KVM_SBI_EXT_SIMPLE_CONFIG(mpxy, MPXY);
 KVM_SBI_EXT_SUBLIST_CONFIG(fwft, FWFT);
 
 KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
@@ -1222,6 +1225,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_sbi_pmu,
 	&config_sbi_dbcn,
 	&config_sbi_susp,
+	&config_sbi_mpxy,
 	&config_sbi_fwft,
 	&config_aia,
 	&config_fp_f,
-- 
2.43.0


