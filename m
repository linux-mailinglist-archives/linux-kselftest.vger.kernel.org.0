Return-Path: <linux-kselftest+bounces-4631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D810685495F
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 13:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB74B26A86
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 12:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DD254BDA;
	Wed, 14 Feb 2024 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RTcdItvK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF0F54BC4
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914309; cv=none; b=eS7rF237pUbyx/JxKiVu0j0OQNVqSg+3rrITu/dy0bHkJCPmMyYVhXYrP0MICvIApJPUCM7x8aIxQEL1b+0jAhqDFlyPvMOh5HWq/chd6/v53fDRIb7mHcza920nu1IN14anFbYMhtUIZ/C5RgOXi5fMrpn/nzSJ36v7lhxYBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914309; c=relaxed/simple;
	bh=2Q4nmJxL8PyzVuzCrgLSok65VnBv52aekZnQ81VzKko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QtUfHNbRO00tu6TuAkfStdIxKig399VClafZkXeU4mHwhMecd40THP6MAXwQ2+eBzfuIlgD/dhaHe5ZXzF+O2jf1UY3IRYl+xEMX1G2MSszVy7QjgNEATarfEVZZtmZ+ZWUap34tgWNPmjvHFh46xRI/NEAWaBM07HzTRrGNJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RTcdItvK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1db51e55023so5969235ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 04:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707914307; x=1708519107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHKjtl+TiQN3xkVjk4Gl68ZjMVAysMTJP3yyqxhX3IM=;
        b=RTcdItvKtzRGfWBTIhMRyrYHPEk/0/b1NM/KPNPc6oSFOqui452MWjkHTE8YVWKPx5
         bIyr3N7kKGaXtNB9YX1HVQwTh9qHS5hnYdh0tDRQIXwTfd1KrJ3gWoUD2abCt5pj+/4e
         gUEghV303Vki9FY61b5fC8r1KuwMwSCjafb9fiFMyktImjvvhPX56dymmcrhPR5qmU+U
         TOPE62FKb188XcJ/kEAPj5jsxPiGdi93dLacINavt/JDqxo2mQGevCHH2w4JfNBKPEUS
         yWXW34+VPiTXKH7pziaUYNn4MK8/1IVHSbYgt2M8g9peASd9A3vEAEn/SQPaMgJx+1kI
         xZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707914307; x=1708519107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHKjtl+TiQN3xkVjk4Gl68ZjMVAysMTJP3yyqxhX3IM=;
        b=CGiE9cJNo3km+9yZinkJmutJt2KwoieH/Lov+Wj9XojEaiFpvz533YQZg2LKddegwd
         kJr/TMUlkvevRQkLIq8CRmqiI7v4o9MHUnMrslqZVoxq4EgxJ2olETQK1hDE3/HPZHlX
         OLkQ6InCfT7mO7UtROgeuQAJzCIkbyZ1ocWJrFt9iU98DN5cVcYJurvir1kUA9NwhVs9
         nrGJYjNRRC1i1AWwJi+W/T9WIKF7hk4aeCbosFjkx9CaXHqyyLwr/5g5iEIyV0eTAoLs
         aR1KzzAujSeMwtRTL6Wfx4a1EgrA2FOQwFG1Uue4L6mqFHP01BRpy2FPzNrsGq8uTF8K
         3pbA==
X-Forwarded-Encrypted: i=1; AJvYcCUiJkJ6F8I4u/X2Bc74Hs+O+fGJSdFTM5W9cFSfF2Txa6OKB8wcaV7YpjlGWq5Lj8rKIwnykWuCWM/W3ZhzByWwloMMr+SCmZ0hZ+fQjE4Z
X-Gm-Message-State: AOJu0Yx5BlgISWofjGIF9kiH/kjQCJYc9AAI52YrWiq0q6qPRImWquJv
	iwiy5NbXD93f44WA1eXyYaFP6aFook5226yRYqYDuAC0/Lv5lz76Eq7uWCE4xhs=
X-Google-Smtp-Source: AGHT+IE4eB6K18FO+NV+30jFVOFBt5sQrSmihTsDMjky3cQtyum08b1pUVZK7T/7CIdCYEPbGH9Wqw==
X-Received: by 2002:a17:902:eb89:b0:1db:68d5:6281 with SMTP id q9-20020a170902eb8900b001db68d56281mr717883plg.35.1707914307513;
        Wed, 14 Feb 2024 04:38:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6JYSlk0nXCb0cCSJmJVtMcA3/mi/wxVgTU49YydRY51DqTvVP0HOsuMu+uEiHFW5vdTQBkqUZY9o5tBwRP6TqnEv+nZnUhap2OH+nfGTbEt3lY/Ae/q4i9vdc/StMRf+9juoiTb/5jO4vlL/PqQK3OjSqQ5dh7uzMrrlFalyKWpy+t+tn0Fo0/V2Tp2w0HKwrTY7LYbYAtv4VlJgxcpzDN8v0xk6gU0lKQbcRYPrLUTNWXKMg7VyqN9gdLEg1/FaCxccjnyp/qaIA0HjWXBKEUDaA1hBUn+wc2bETB9VvFzfzckufJ8BKYSQzn3cTVYx9swbNbLAACI5d2s7kS1aF8ZwYTw3o9N7OZFInjwG0TMXNnyBL31t5GwmjElQXq09vk4owgaVGpVZDJGgc292s+M5meW0j8nnGCPfgm/rfrIQxUno++Ly0eMQ/Ng==
Received: from anup-ubuntu-vm.localdomain ([171.76.87.178])
        by smtp.gmail.com with ESMTPSA id o20-20020a170902e29400b001d9b749d281sm3041419plc.53.2024.02.14.04.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 04:38:27 -0800 (PST)
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
Subject: [PATCH 5/5] KVM: riscv: selftests: Add Zacas extension to get-reg-list test
Date: Wed, 14 Feb 2024 18:07:57 +0530
Message-Id: <20240214123757.305347-6-apatel@ventanamicro.com>
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

The KVM RISC-V allows Zacas extension for Guest/VM so let us
add this extension to get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 5429453561d7..d334c4c9765f 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -47,6 +47,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVNAPOT:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVPBMT:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZACAS:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBB:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBC:
@@ -411,6 +412,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(SVINVAL),
 		KVM_ISA_EXT_ARR(SVNAPOT),
 		KVM_ISA_EXT_ARR(SVPBMT),
+		KVM_ISA_EXT_ARR(ZACAS),
 		KVM_ISA_EXT_ARR(ZBA),
 		KVM_ISA_EXT_ARR(ZBB),
 		KVM_ISA_EXT_ARR(ZBC),
@@ -933,6 +935,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
 KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
 KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
 KVM_ISA_EXT_SIMPLE_CONFIG(svpbmt, SVPBMT);
+KVM_ISA_EXT_SIMPLE_CONFIG(zacas, ZACAS);
 KVM_ISA_EXT_SIMPLE_CONFIG(zba, ZBA);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbb, ZBB);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbc, ZBC);
@@ -987,6 +990,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_svinval,
 	&config_svnapot,
 	&config_svpbmt,
+	&config_zacas,
 	&config_zba,
 	&config_zbb,
 	&config_zbc,
-- 
2.34.1


