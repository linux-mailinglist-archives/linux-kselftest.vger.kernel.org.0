Return-Path: <linux-kselftest+bounces-41915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 310D9B883B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 09:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A43A1691AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 07:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACFF2F616A;
	Fri, 19 Sep 2025 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PjIU41OU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30E2D2485
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267534; cv=none; b=dwIthcKxQ5biYmEOyLe2nQDxtovRDqyfSGgrxv7z0zi9xnftN5benrPmGJaY0NyC1Nak5tVfTjKhKpyZrlrI0GsAuR0S9EcyOFFtIYi84S+j8mDZ2wiY+E9QX0vx07CU19FkcjipOkgQR5kG2VJXyf98Amy/LAPSziIdb02eUX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267534; c=relaxed/simple;
	bh=c191XMGekjwyT0k1fIaZ95ZvPfNZBLAH+N5NWD52kwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4qr4I/5xrnHeCJOoge3FThyM69Iru3yHz6l7f6lxskKtO2rvPenvDTQbt/9huLdAkOzAL5EzYA+uiI5RsrVmIxp9QUhF408Xu4mdnmmIVsSjdhbVcLL+by5E0/H8/GR6LRTZbjAuFdaGKc0Y3t7dfpdrurbKURJ5KF1O5XkbHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PjIU41OU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77db1bcf4d3so1172911b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 00:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758267532; x=1758872332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/wZtJxRjsPgsFT1TZQP06vJqUDEl57iCFv88CuZkP4=;
        b=PjIU41OUYpa5GM79iBUbErnojyglssB59mxt+pnqxe5xNSugTp3XzUbZtTRDhYY+mj
         AFI4vSoldVpgCaoKhmnNBmrfsSWD9hi6PyJoWW3iPsCWpqA8u+0yN7coz4mTvEw9XJoF
         S9Cz5vQoYeanUxpS89cLVdS4OLWRDtmQrrFBHhZlWY6Z6anmELda6AMSniGIBt38AhA/
         WSDWti9dtcR5Lx1U+UWp2MsPJ4rWRC1A/7Me5ySF1XNqOdHPUYri6ZAsMwxjHJQENOV1
         BzYDpD95J4TUq9jA1Jg8DbEYdeENlJSgIGNO4xtE0TqTE+zAoBk0vu73X/uMlOGdbO/v
         UlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758267532; x=1758872332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/wZtJxRjsPgsFT1TZQP06vJqUDEl57iCFv88CuZkP4=;
        b=PF+xoskR080OZHutlNeGW5bLC/kh5koxLej+JOGOnvo6Q0qPon4VEIv2VmrztRhwG9
         PzO/r3UzTvAzt4Leoytbu+XhRun6rnPN9iL0gY2QbGoVLNFN97KplPru15Px+DqKmu3Z
         PGUk4hFZkTR/qmbAOINWNskiQQrktlUW/RPlYYp17tB7dcey9gkHsAHooz7aJoJWhRB/
         /ITzubt1RCEvhdw8aB3OXJ1dHq8B/1rgmx1fyQLsQZYemx9Ut3L6GNEccg7d/+M+7rU1
         NlPV+nUsBd///9XtDrX3a9cdQiuM4SdCf3HGp3ec5uYRWec6s8dIotkB7XhIFJ53moiH
         5cVA==
X-Forwarded-Encrypted: i=1; AJvYcCVXFlmIUuIpARcXIU0rdEc1CE6nyrMwkW6768Qh3i+2WsWInEp+KS4upSE4QUCGtyku0pVTdvmEJYEMY1gTvPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDud3eFBKrZc8d/XUO5KMyoUE0jgin6aBgvG15sy+QzK8eL27m
	MyjKz0B9DWDkhte496OqiuGKKKVdfp9/BTLoTz8YWnmIqdPtAfZrFgUnxEDf4X8ERRU=
X-Gm-Gg: ASbGnctc+IbvIVbUvlZ3jGyVO6qGSWath8e3MfStSavcAA9eOWH9Y+xTAR7zFamnEBE
	DTFHNVcoWCSpYA2HojBEMMCuSbER3rDBIQysRvsnJzrJnxgsgwhzMt/1awhTZInKKR//3NWyc7/
	qHjvfKXzTaTs3M0X/rkKNs2W6n0aArPUuBw5HP2ccFZTx+gw/ZexzqUJNYOkqrWPAjC0YFGxx5d
	17wkTtmTVDwMIiRFrxAHVoeggdnSmlJk5suYwfKfwMt2yIF2eSMZg4Kwwn/yaATMMBd1W4pUvJd
	HABFS1DV79apGyX03KmHcUyIgYkzgwIIDEyJMJoUnk5H7asDlDX7o4KvJ3+wUowMjf70I+HgkDm
	q5zUQhdJBxBXel0txaEJZ7BfSw+aZ5+IWJM6EiMeck0qRLGy9D3r3zF4BjxR/sXzwO52/bPmvi1
	d0EwLDYjNey4XygK+qKWugmnucvT2t3lhqK7lqFny9/g==
X-Google-Smtp-Source: AGHT+IH+4QZdIMI6dt1vIbAhIv1otTpdn3Cuf58RfGKyqc29IOHSadIrxg84hnYxuSAKEAjnTACHLA==
X-Received: by 2002:a05:6a20:244e:b0:24d:d206:6992 with SMTP id adf61e73a8af0-29260d81077mr3369360637.22.1758267532201;
        Fri, 19 Sep 2025 00:38:52 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b550fd7ebc7sm2679096a12.19.2025.09.19.00.38.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 00:38:52 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: corbet@lwn.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	parri.andrea@gmail.com,
	ajones@ventanamicro.com,
	brs@rivosinc.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v3 8/8] KVM: riscv: selftests: Add Zalasr extensions to get-reg-list test
Date: Fri, 19 Sep 2025 15:37:14 +0800
Message-ID: <20250919073714.83063-9-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250919073714.83063-1-luxu.kernel@bytedance.com>
References: <20250919073714.83063-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KVM RISC-V allows Zalasr extensions for Guest/VM so add these
extensions to get-reg-list test.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index a0b7dabb50406..3020e37f621ba 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -65,6 +65,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZAAMO:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZABHA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZACAS:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZALASR:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZALRSC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZAWRS:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBA:
@@ -517,6 +518,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(ZAAMO),
 		KVM_ISA_EXT_ARR(ZABHA),
 		KVM_ISA_EXT_ARR(ZACAS),
+		KVM_ISA_EXT_ARR(ZALASR),
 		KVM_ISA_EXT_ARR(ZALRSC),
 		KVM_ISA_EXT_ARR(ZAWRS),
 		KVM_ISA_EXT_ARR(ZBA),
@@ -1112,6 +1114,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(svvptc, SVVPTC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zaamo, ZAAMO);
 KVM_ISA_EXT_SIMPLE_CONFIG(zabha, ZABHA);
 KVM_ISA_EXT_SIMPLE_CONFIG(zacas, ZACAS);
+KVM_ISA_EXT_SIMPLE_CONFIG(zalasr, ZALASR);
 KVM_ISA_EXT_SIMPLE_CONFIG(zalrsc, ZALRSC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zawrs, ZAWRS);
 KVM_ISA_EXT_SIMPLE_CONFIG(zba, ZBA);
@@ -1187,6 +1190,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zabha,
 	&config_zacas,
 	&config_zalrsc,
+	&config_zalasr,
 	&config_zawrs,
 	&config_zba,
 	&config_zbb,
-- 
2.20.1


