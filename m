Return-Path: <linux-kselftest+bounces-13653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D6992F719
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 10:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56DB1C22A1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 08:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DFE14E2C1;
	Fri, 12 Jul 2024 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="f2URke/+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B7814D70B
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2024 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720773562; cv=none; b=tSPyBF4V7Nol/trnXBUIkNIrzpSb76aVIaeN5jkgjaDQw+f4zjciUDJLTHa78kx+a+OHIKzBrAkOxdyb+1ZFOswfez8C5+lVaU7rmKlmVYR8pVPAgHKtLeaTjhRjJ+WDCeE4HpkEOAXMdVVapJYCxpHF1w8l0xP/NjdZr2pJ8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720773562; c=relaxed/simple;
	bh=rAYKbcFrJvZXsWHsMuE+Qgzs7qeLTNluD8iqVeBQttI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CYwGbQeycLFqqBP9O1hDX8bRP+2ZXL8IE8VekBcQajbZRBB7O3lwwxObaSXRORFPJPeqFjx3VJOshRgZeuqfi1c8VCrwdkJnqEd0tiW0hK+Rw4Jh2d/1aldqE8dOX3iLHcou9OabrbpUNziCh652Cnh9GXiC+sApT2l1dfnmDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=f2URke/+; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d96365dc34so1331226b6e.2
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2024 01:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1720773560; x=1721378360; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PpDCA7CnSWtIO6seFJ4J0hDKtH06inwXMPU5CaySLhw=;
        b=f2URke/+ts/fgwVmW9dtm6CzYNesfhTBx6FwJbxGNxc+u8sZOT5eycV3B4/C5Yof8j
         2oVsI8/o23/nyda5EheN/KAeqmlb7P31UpbLNllvWIWlwEki3ID+QbLSCnZChssPV7Be
         wglntLrfUUsM1+/DHGVnceBtA6rTL62iBXZEdJ53nlT+q2utrj0yHzp1jZfEzfMnstwn
         4+8PfprMQO9irs0QaU4XV9S6/e6BKOIqKsYY6srjM5yV6Wl+o0Esp6vrXyJCgMJthBKW
         nDpGPARXfwhP8Zy6TbGSQkgrSf1hZCZBrBfGU95eIh69yvliAB+3eMgVxzL/2OyTN6LD
         jzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720773560; x=1721378360;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpDCA7CnSWtIO6seFJ4J0hDKtH06inwXMPU5CaySLhw=;
        b=F52pULFD4YhtnJ4orgHLkp+amssAyAmzgbjZMWEx8TgHlK1+cTjku+VElPSd1K3Lup
         9RuZWSVmARILHtywocLH+AoTChD18RX4LTdXVqFIfyxd/AfNOi8H3LFZE1Z7yARC8R0/
         ikMO0ABJcXbF82c+jsTUCQ8OjQ6VO30ZOIqV2vRb74Q/U0WVreLF9tRl1VJ4bhgu0HeL
         FUiVkea9/EyVtyn1oHIkL9fyvCkGH3iVlKx45/P4ampNv/PLy5etV1oS0t50p2hm9QSf
         4Xv85WNzjSqHMKSbgFuRWLR3gwE/J7pQmpM7rnJ9UgoeOFuFEhm/O+7aiFYjy/tkocx0
         x6VA==
X-Forwarded-Encrypted: i=1; AJvYcCXsmvxQpQCOULE/ujiQQakmD2HQypuop1jsw9zIR8S2tgPH3daYfHkNY0XQ5HOw0prsEC6mNJjy28GShqPI/9eVJbffPrkNRTSTpNsBKuZ7
X-Gm-Message-State: AOJu0Yx/kC9zGRn9N+tb6oFhGlofpDmasUG07F/xdwV4MdQBpZPTj3Ov
	YTm7cuNFZUHuomhlj+Fwia9Fp7aWhPSCW0fIuhXyXERQINMnuUz2Qqg/f/LRK2E=
X-Google-Smtp-Source: AGHT+IHmBxrEAG3WPd6oj+/586lglgYzxY+9BouYb6jIFT5EHBZDlB4+cb5Y4B3ynyNiUyxupNCiwQ==
X-Received: by 2002:a05:6808:1982:b0:3da:a6ce:f017 with SMTP id 5614622812f47-3daa6cef5a9mr3909532b6e.46.1720773560484;
        Fri, 12 Jul 2024 01:39:20 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c7099sm6894194b3a.84.2024.07.12.01.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 01:39:20 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org
Cc: greentime.hu@sifive.com,
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
Subject: [PATCH v7 4/4] KVM: riscv: selftests: Add Svade and Svadu Extension to get-reg-list test
Date: Fri, 12 Jul 2024 16:38:48 +0800
Message-Id: <20240712083850.4242-5-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240712083850.4242-1-yongxuan.wang@sifive.com>
References: <20240712083850.4242-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Update the get-reg-list test to test the Svade and Svadu Extensions are
available for guest OS.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
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


