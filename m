Return-Path: <linux-kselftest+bounces-12925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7ED91BBA4
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 11:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FFC281534
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 09:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E4215575D;
	Fri, 28 Jun 2024 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YR9Mhgsk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A4A155CBF
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567497; cv=none; b=hrU4R5TzmfMciHeMLVYLo+YZkVGUWK4cYVbW+8019tIIczxRWcAQTkpgi0vr4uAZqh+M6p8EkLLY1qa3WQIoIi9fwv1R54i4K9D9hmyrCHYpaCSv32cilMharLUfv5Cg+LKb4upwSv8RYRoZn378fRRtVtho7Ml6VQSC1H3Rq4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567497; c=relaxed/simple;
	bh=rAYKbcFrJvZXsWHsMuE+Qgzs7qeLTNluD8iqVeBQttI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Kp+bO1GVU4IQW0Jp2xQOIgrzXmRGnJ/IB6+wsMs3jld9st7/areA35r+k0DhyI2RjYXkcQfa2jKn6gmFtjvlAhnTxIMFZLh0xMwK4H5Ej14ONEIn4vlccu30rHejn5RyUGynt+IFu5qT2hkW0XQvOXD6B7umwBGZZQUyjvrW+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YR9Mhgsk; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7180308e90bso269885a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719567496; x=1720172296; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PpDCA7CnSWtIO6seFJ4J0hDKtH06inwXMPU5CaySLhw=;
        b=YR9MhgskAfBll9YVySYF9m74I5u4YR5ecQ5lDKH4PtLhrsPXyL/IglGduE9YLGpMpU
         0HV/HvK6tF97pojzwnjS8LNQf5Fb+69hu+tCuTtAxLmJmU5wHuh11g0X6JExpsDsYdUR
         67qYsQL69NXvPY5wBMXLNGwvlC3s81rlUw5FOqMlwKE69nDSXeGt+oT69mDYXDsKrjRP
         JZbagdpzsNGC0Fkr4orlVwPdtv2w43KHh3CZIRZVN4TUQaM6VLj+oKgguDSnsdLjtYEW
         zWX08+m8N/ysbYSI3iSekZuYzDHbbUfsd5TXhGbl38fLV1dhTnUcrkzP6tGBwaX0U8WI
         2/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719567496; x=1720172296;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpDCA7CnSWtIO6seFJ4J0hDKtH06inwXMPU5CaySLhw=;
        b=DY5vCzZc6aDzmvdE6Z8B1PEbY0Jt//NXDZVaFpMc62af3bpglH74wzsIN0RHp6FSzR
         Fhiuq/PcTIVq5vHS9nWrkmJlAiECPfPyAdxJlFBeNaB0knsNKQirpUMrWfE8ooizyeaE
         l3tWII8MzTdHzX07tpRZCvdAtbMUYngwjnmAQscDbG/wCr/thm8Q+CQ6voB14Eoswi7c
         qY52jEbyGHAQP1WuooBMtJQjIxd1RZrKJCgBlYDIcJxf9e8G8VHa/1LVpaI1ngb/CpND
         sqxNOC7x5dmAf9/ak9SY8RgqMA66mPjWYXuKZhnqa9ntIJK8z9KzD6xKt9Wqs4vQ+VRA
         Hnaw==
X-Forwarded-Encrypted: i=1; AJvYcCU5u2FdGccrdP9xNRCY5YAuGTitq2iyZbwv53TCFHgEtUlmnAk8n2LcejDEU73k4Wx5YsiR0aNnSZ3bUlGkS+BMpFJyv0/Fz5GObVZGCZBB
X-Gm-Message-State: AOJu0YxH1/VoB6VdMlvGqiA5X16P5s6RxOYx+A1u/2Vq0iUy3DRjNMlx
	pixMrBd/T25PjdyAtcuZk4uKKBumZk9MuBPupisvLxAUOIvpK5Ax1UJrna4PvGY=
X-Google-Smtp-Source: AGHT+IG3L14BlCwHPiIKSplLpOkLLGSwZSlMj6M+WV18XsZAbw/WIXgi64YPVTn0Axv2MFnAlS9dBg==
X-Received: by 2002:a05:6a20:45b:b0:1bd:2703:840 with SMTP id adf61e73a8af0-1bd270308damr8420473637.33.1719567495751;
        Fri, 28 Jun 2024 02:38:15 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c6c8dsm11087155ad.26.2024.06.28.02.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:38:15 -0700 (PDT)
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
Subject: [PATCH v6 4/4] KVM: riscv: selftests: Add Svade and Svadu Extension to get-reg-list test
Date: Fri, 28 Jun 2024 17:37:08 +0800
Message-Id: <20240628093711.11716-5-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240628093711.11716-1-yongxuan.wang@sifive.com>
References: <20240628093711.11716-1-yongxuan.wang@sifive.com>
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


