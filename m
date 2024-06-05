Return-Path: <linux-kselftest+bounces-11248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06468FCE20
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 15:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72F31C2416F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 13:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225FF1B29D3;
	Wed,  5 Jun 2024 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CBitWUsR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A41B29B7
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Jun 2024 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589757; cv=none; b=ou3kUNegD583mX3rEZhSqpHztufe5rs+NDRe3gcT+IAkZr4fEvuGh1aMDHmnr8/92SxiK+fCzz60KKaS970ImUFeZrPL71eNMUSRUq7Les55OZA9Lmy2wcvGeg1bR2mS3+SN8Xr/GZj3KHfY2cBBtxSBLri55igb/Y2jTUiLTSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589757; c=relaxed/simple;
	bh=jTQnCjAYiOnyg83RQMSJJfcBlJdwMJJeulbs10TuFN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kB37lgirXrfC87J7nyspUe55yDzM5Xpzg6FTS8iUaD3cbmRSTydlRQC1LJfhlV6qkCaU2bvSiSTSw0AtWhqjv5VtCszdJO54+gUbzLfci4zLSEnDMzQkJlfAtFiJMO61UnjfXcpAOY/MHp3EBILgSdxDRX8ZILI46b7CPh4DhdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CBitWUsR; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70260814b2dso757132b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Jun 2024 05:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717589755; x=1718194555; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s1s067gNcLroY85Io7X9j2HhTsy4/JNlR/TnSjjDyVA=;
        b=CBitWUsR33hB9HOopjBrDaBMynnxWxj9jsJptpQQEiMRYqcDTNOrzWqgU12T6nM/if
         Js42uzlCtjQ54l343H/Qt6ze3cksIGBBpN3P85Eu9VQg8F3J8rkPF7wr3jdciHklWuN7
         LpqsnFHlIKWARFzMcHv95e3qd5iT1U88MdTD19Noi6zqiitE6BJY+DzB8FVAQL17neoe
         FHIV14Orizcq46ErCe3sEfnfdJwVLMbYHHHvcF/ZI684TX7hIvmosQNFCuTq0JQCKSPl
         gu6lrE2kQfKaf0IHv1QfA94jGI9yeJQQSKzFsOj87i1oolHhpvndPscP647SKDNs4ol1
         qcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717589755; x=1718194555;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1s067gNcLroY85Io7X9j2HhTsy4/JNlR/TnSjjDyVA=;
        b=I4bOPzGNw8NHLhZ34cMp1UPegwzP6Bj4vG8SnKjqZmf7ymKHuLsjY/6OiO70SAVzFM
         6O9Tvkj7LPZ8ujm8V+fUYDfBCpWuu9cp8iDCxihac5ca6iQ8hl1u1fe94viP2XpmJZDr
         4BcLqhFMFNAaJwN83pp1r+3djFlOwFdDgf7C9Bd5q7BWUkuCOTM1KWwcpymDRJmKOCG2
         Z0GrMUxRcDQwdyCvH+8l2W/U5LfgkwlgS+cBPV/+Yzzkt5jB0Bbg6wm/yDysNsfNvuP2
         fezhQNyTdJNqST6KWbR0rNSCLnNMQmf+U/AjyM+Kzwaqyu5rqoaFLTTo/6xW/X5VyIKg
         FoxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQf5WbNhqh0cqEA3btGnFkRZ6bPoBUuYuzAnLzzYvfEN4IYGnotU/nIOO/wdkf4v1q5Thewk9X0JHaCd93iI1egRw+wTqpyytFA35viNDA
X-Gm-Message-State: AOJu0YyyeVWOBN6Q8h4kj206CMdBT7bjqbltuh6ywZVfLPf+CUGyCHDW
	nr6uxdb9MuikX/eH5hAzL2Bwp2x0nfuB0YOhSgUHlJXL6pAAYb5RRbvjPIiwrDM=
X-Google-Smtp-Source: AGHT+IE2uyoTxe3pUNkQoaQt0ajX+GBn9F8zoOHdbUYCJhav/6GYlnkgU9F3LAFV0i5BxmNjeJ1V1Q==
X-Received: by 2002:a05:6a00:6082:b0:702:5514:4cb8 with SMTP id d2e1a72fcca58-7027fba0d23mr6188351b3a.4.1717589754693;
        Wed, 05 Jun 2024 05:15:54 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703ee672fb3sm885379b3a.216.2024.06.05.05.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 05:15:54 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org
Cc: apatel@ventanamicro.com,
	alex@ghiti.fr,
	ajones@ventanamicro.com,
	greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 4/4] KVM: riscv: selftests: Add Svade and Svadu Extension to get-reg-list test
Date: Wed,  5 Jun 2024 20:15:10 +0800
Message-Id: <20240605121512.32083-5-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240605121512.32083-1-yongxuan.wang@sifive.com>
References: <20240605121512.32083-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Update the get-reg-list test to test the Svade and Svadu Extensions are
available for guest OS.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 222198dd6d04..1d32351ad55e 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -45,6 +45,8 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSAIA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSCOFPMF:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSTC:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVADE:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVADU:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVNAPOT:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVPBMT:
@@ -411,6 +413,8 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(SSAIA),
 		KVM_ISA_EXT_ARR(SSCOFPMF),
 		KVM_ISA_EXT_ARR(SSTC),
+		KVM_ISA_EXT_ARR(SVADE),
+		KVM_ISA_EXT_ARR(SVADU),
 		KVM_ISA_EXT_ARR(SVINVAL),
 		KVM_ISA_EXT_ARR(SVNAPOT),
 		KVM_ISA_EXT_ARR(SVPBMT),
@@ -935,6 +939,8 @@ KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
 KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
 KVM_ISA_EXT_SIMPLE_CONFIG(sscofpmf, SSCOFPMF);
 KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
+KVM_ISA_EXT_SIMPLE_CONFIG(svade, SVADE);
+KVM_ISA_EXT_SIMPLE_CONFIG(svadu, SVADU);
 KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
 KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
 KVM_ISA_EXT_SIMPLE_CONFIG(svpbmt, SVPBMT);
@@ -991,6 +997,8 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_smstateen,
 	&config_sscofpmf,
 	&config_sstc,
+	&config_svade,
+	&config_svadu,
 	&config_svinval,
 	&config_svnapot,
 	&config_svpbmt,
-- 
2.17.1


