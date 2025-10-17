Return-Path: <linux-kselftest+bounces-43388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEF3BEADD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCBB9629A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CF3336EE3;
	Fri, 17 Oct 2025 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Of2NuEBY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73825336ED1
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716791; cv=none; b=jqcchO8JpOj6S4r/84wsZ76nFP3qkzRmo7aLMouB5w2AJuy3GGoyxYBCN7gPdLfftnu3z6dOIfNJTQQjq5Ht5cnAErW0jkghraBBIjjWDDv03AsblUFXedJvd7OAnE6xLM1ludV6LReJX0HDgCit9rCaFk7Br7ZzlOA/MSyp084=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716791; c=relaxed/simple;
	bh=TZPcRasNMeLsIZK1JLiv9Hygp+bbQA2e5mO/bhGFgio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsojcsUah6ozklwgJbbfcn1fmmho7a6JA4qkwpqFY1wCZLh6gEuErftlo5EAnzFhFcC9XrRDk56s/j9dnPljybn60p0WFZzrolTv/4FbQzlmfq9R9V/iyW4pTWzTAVLp4Ep/uWmnTxcho9rSBfWWEKWp62k59/optHN9BykKaDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Of2NuEBY; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b62e7221351so1716353a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760716790; x=1761321590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGrq7dE9mGPhrWe1XWbI1ElRSHZxTOfH8a4rxkkGojA=;
        b=Of2NuEBYUj2qVwwb/HbRPJwXN3sAUM3RD4HMAWD1O3c5ZT9JMlo6TYbnF/rbwiWzkS
         6EKMOq76nbbRTMdYbH7WOWc9gJncUB6zyUyT02ltzSnSKYDvKTjyQaeEPqAQRxObTQJY
         IZhZBKcyehIXUtOTKqWbdjnwrPHwhxLRxXiIfOT5VmVSj58S3M4oGufbHQa291QVZQsU
         Q36bXNc48kPe6Fm/IEbg/571WAAH6xzueNgDdH5qOZ1PFHEiX8/EEd14yduKZX3M8wRB
         VJ+hTmVmkazZH3w+bxakpF4tNWr/3GiUIcaYoC7noBGOZFPj+EXcrVQdc/7TGWoprYfm
         VUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760716790; x=1761321590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGrq7dE9mGPhrWe1XWbI1ElRSHZxTOfH8a4rxkkGojA=;
        b=lvR66tDAsMKeZzCODQCSA+wE8H9xsfkrM/fgVhPE1xED2+S+2RZg5k9HN/sfpXYJG3
         bDw5WdEez8NxPe3HtVzIxOxN7HDPKDP9e98JTHgr1smq9cE9IumXyCINkyySuyzJYJjn
         +DWqTzbQaUXotqyk20QjfZn8L6h5w/anTxsFSbyigvvGmSAjk5/wmahibV0a/AGx1+3F
         3PnesWBZSb29lT90itwr8GkEKop06mFDCOYrcfYiOCdsKfDJwfpnK8uiKp58Sz/xkhNH
         N8zdqrBuhvyd8vPoCVxiOe1V5bqdTfweMU7SfR4EBJdaMYoASfoAjPV1zMtVihX6TxPW
         f21A==
X-Forwarded-Encrypted: i=1; AJvYcCWo8Ru2TFio6mhAlFRJw4albcq/pXfGRXRXgJfu+sM/TufN6dKZnAjji6n1rxSc6lCX4Or1sPfNQWfObOmIqYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGUYzFjVz9gthNbElk2VXj1bt6vf8mw7fzg59nqaTaCASxDLJ7
	MITBrFox2DVI9CH83+GHaOxVsDBPB6XNvxJZUx6TAL2baa9FzpUiAXuSpnBUM7YruUk=
X-Gm-Gg: ASbGncvHXatxg3hNezJOdbFSj8kZgeoZv2iwHytr161rcftFqG7BeRDUCfh+OTpbJ+r
	e/rhm1WCHY8AILW7VAxuKZEdyk6+04VMYu2LFDKPaGvYZ2ZKFVYwOq/gnnhwZNQNcCQyg4BeZ8J
	VrEwvRiMXyy6GjmspckHPxTKWQAQeN10vWacPspb+w11AQ7vW0d2HbZsLRvqx96mVvW3i8s+Ulv
	PRlgJ2GDJyjpY6hEIj1BYPgqLvJx9wJk35D4zOtyErtyuvTjToAZBSF5NlDk2v5fGSJQZR3RI0W
	V+J5MMr+gyCJxUDnJPffFSNiwQHBaPXqblpSpbEelK7c3ST3A7Lrn1KJm0x4L5S2EogI3akBdSZ
	Jjg85nb5u5IG+/NsyZr7O1v1JE3wKHT5hIF4vdoqZ7duso+n/37BpvsfmynMTo8FZB8lUVo06+R
	jqWDzoBTgdLgRqZdQ6nAtZne6AM2x4cbv5ZDH389tcEH4=
X-Google-Smtp-Source: AGHT+IEjhb0cA2r/R2/eGguQc8wJ0VGA660zoYKsRyUrDokrj4BSrZrFe4SkzJzL8cy+UNwStJFbqg==
X-Received: by 2002:a05:6a20:958f:b0:334:8335:9d87 with SMTP id adf61e73a8af0-334a856e41amr6075209637.19.1760716789785;
        Fri, 17 Oct 2025 08:59:49 -0700 (PDT)
Received: from localhost.localdomain ([122.171.18.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7669392csm151067a12.18.2025.10.17.08.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:59:49 -0700 (PDT)
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
Subject: [PATCH 3/4] RISC-V: KVM: Add SBI MPXY extension support for Guest
Date: Fri, 17 Oct 2025 21:29:24 +0530
Message-ID: <20251017155925.361560-4-apatel@ventanamicro.com>
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

The SBI MPXY extension is a platform-level functionality so KVM only
needs to forward SBI MPXY calls to KVM user-space.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h | 1 +
 arch/riscv/include/uapi/asm/kvm.h     | 1 +
 arch/riscv/kvm/vcpu_sbi.c             | 4 ++++
 arch/riscv/kvm/vcpu_sbi_forward.c     | 7 +++++++
 4 files changed, 13 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index 446f4a8eb3cd..c1a7e3b40d9c 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -107,6 +107,7 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_susp;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft;
+extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_mpxy;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
 
diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 759a4852c09a..37213d86c0d1 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -211,6 +211,7 @@ enum KVM_RISCV_SBI_EXT_ID {
 	KVM_RISCV_SBI_EXT_STA,
 	KVM_RISCV_SBI_EXT_SUSP,
 	KVM_RISCV_SBI_EXT_FWFT,
+	KVM_RISCV_SBI_EXT_MPXY,
 	KVM_RISCV_SBI_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index fd4106c276d8..46ab7b989432 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -82,6 +82,10 @@ static const struct kvm_riscv_sbi_extension_entry sbi_ext[] = {
 		.ext_idx = KVM_RISCV_SBI_EXT_FWFT,
 		.ext_ptr = &vcpu_sbi_ext_fwft,
 	},
+	{
+		.ext_idx = KVM_RISCV_SBI_EXT_MPXY,
+		.ext_ptr = &vcpu_sbi_ext_mpxy,
+	},
 	{
 		.ext_idx = KVM_RISCV_SBI_EXT_EXPERIMENTAL,
 		.ext_ptr = &vcpu_sbi_ext_experimental,
diff --git a/arch/riscv/kvm/vcpu_sbi_forward.c b/arch/riscv/kvm/vcpu_sbi_forward.c
index dbfa70c2c775..5a3c75eb23c5 100644
--- a/arch/riscv/kvm/vcpu_sbi_forward.c
+++ b/arch/riscv/kvm/vcpu_sbi_forward.c
@@ -25,3 +25,10 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn = {
 	.default_disabled = true,
 	.handler = kvm_riscv_vcpu_sbi_forward_handler,
 };
+
+const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_mpxy = {
+	.extid_start = SBI_EXT_MPXY,
+	.extid_end = SBI_EXT_MPXY,
+	.default_disabled = true,
+	.handler = kvm_riscv_vcpu_sbi_forward_handler,
+};
-- 
2.43.0


