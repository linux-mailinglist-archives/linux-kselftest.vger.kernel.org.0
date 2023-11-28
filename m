Return-Path: <linux-kselftest+bounces-722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5BF7FBD79
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 15:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D7F283187
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 14:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711C65CD07;
	Tue, 28 Nov 2023 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FCKkVKyv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1272112
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 06:55:28 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cfc35090b0so21567925ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 06:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183327; x=1701788127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VVLFlRU9wYvo88+4OGIocSm8Yau0IVgd5ynlDYwNo0=;
        b=FCKkVKyvcgg2+FuLc7kglFATD0ozGf/gJK2xQP7zxLCp9d/x3u32YbiaqQomA6VieS
         CDfqC3ufh5zsv3SuyE0WdkNCp+Y4haDkLmAQq4xWn/fumm9S2iIF7sjXo63OLgoNxn3C
         kLPU8SKAF6XLDMErpBz0OS3kds0tUaJ6Jskrl3+1havDFGoUsE0KlXmgZ7z8ivFbUuIE
         7GwgEAt8tM/1Ta0i8b6PJojNPX8ptjNGzGydXqyVeTl0M9f+ApU3KbvQQt8+RZVGLXIk
         ONEahHSYkK6WvwZ8i1iLo15iE55JHOJXgqesTtYQxd5SnJ85FDR8oJE4GQQ06ZyQHR20
         kFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183327; x=1701788127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VVLFlRU9wYvo88+4OGIocSm8Yau0IVgd5ynlDYwNo0=;
        b=VhgPGaGs1if27MZhsNxE0E9vQwP2CvX4LUVai4j2Av78WtLPtGjpTu+IUDykCDt6U8
         VAkvuh/msQv54XrTwzNqAUOmw3k7FdcO8RpHwNYWV9PJseIZOBQylpfoDybsDQLZPqKI
         jKuULZj+8a9oAsfooTNJAQkxkHDwFi4AV6NcVQtHrC/z96SLlNqccu6mQIVEHQw7099K
         OLmAJK93tWT3WR68zAjG7SYee6WegTa8bpmYyQ5V3RP7/zi/9OkJTAoOADX5Q8Kn6B2P
         ZYz2nwZDsleYteQuMfE8U2gJfFso+RhBmOm1n33POka5NOTioGRr08rQfawee4TgVuKs
         foNA==
X-Gm-Message-State: AOJu0Yy3U2ALgjzKjK+vcYrSJ1CkJMUhaJM5gb8iPSczRjWz3l2v9NN4
	ev3S//R+hl3oGG8A3R1Hox8LK3ADoj+D1ty+Yok=
X-Google-Smtp-Source: AGHT+IHZ95VAy9/7S8RkRKOXL8kFHrGKjfJWJoXp0yuxzlNt0eSXamoYyifB6bHsdqesqmrNE+3K7g==
X-Received: by 2002:a17:90a:1a5d:b0:280:24c7:509 with SMTP id 29-20020a17090a1a5d00b0028024c70509mr13617016pjl.46.1701183327478;
        Tue, 28 Nov 2023 06:55:27 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:55:27 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 15/15] KVM: riscv: selftests: Add Zfa extension to get-reg-list test
Date: Tue, 28 Nov 2023 20:23:57 +0530
Message-Id: <20231128145357.413321-16-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128145357.413321-1-apatel@ventanamicro.com>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KVM RISC-V allows Zfa extension for Guest/VM so let us
add this extension to get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index df03bc511fbf..3ae919469c38 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -49,6 +49,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBKC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBKX:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBS:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZFA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZFH:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZFHMIN:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOM:
@@ -392,6 +393,7 @@ static const char *isa_ext_id_to_str(const char *prefix, __u64 id)
 		KVM_ISA_EXT_ARR(ZBKC),
 		KVM_ISA_EXT_ARR(ZBKX),
 		KVM_ISA_EXT_ARR(ZBS),
+		KVM_ISA_EXT_ARR(ZFA),
 		KVM_ISA_EXT_ARR(ZFH),
 		KVM_ISA_EXT_ARR(ZFHMIN),
 		KVM_ISA_EXT_ARR(ZICBOM),
@@ -796,6 +798,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zbkb, ZBKB);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbkc, ZBKC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbkx, ZBKX);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbs, ZBS);
+KVM_ISA_EXT_SIMPLE_CONFIG(zfa, ZFA);
 KVM_ISA_EXT_SIMPLE_CONFIG(zfh, ZFH);
 KVM_ISA_EXT_SIMPLE_CONFIG(zfhmin, ZFHMIN);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicbom, ZICBOM);
@@ -844,6 +847,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zbkc,
 	&config_zbkx,
 	&config_zbs,
+	&config_zfa,
 	&config_zfh,
 	&config_zfhmin,
 	&config_zicbom,
-- 
2.34.1


