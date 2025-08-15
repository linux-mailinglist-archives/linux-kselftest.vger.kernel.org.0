Return-Path: <linux-kselftest+bounces-39021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3B7B273B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 02:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7881CE1F99
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 00:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70C11DA23;
	Fri, 15 Aug 2025 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5yYhzfp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D26A926;
	Fri, 15 Aug 2025 00:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217223; cv=none; b=HpzLyscnZgZpjdAsT5le6rVfoV9HJi+lzG7dQHujy/OAf2N7lf1GqVF01w1Coedf+z/vsTeAfN+8NCI+y4eMP9iy4V4nnQX8nXPo4+t46Jr5IDpiHfm5qdiV0OLt1eeprQrajfkkBVdrfUeEUgGr/sapow0+sepzlqf5n1OrWCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217223; c=relaxed/simple;
	bh=Hlpf2kTVXQNQmFdUgxQvYfOl1mZBxeqXkGFm+CUVm/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+DFZo7eqSRKHeK70mdOZ02+Mqx0Nu3ROmNCyHXQFIBE98ESEfZDoaazYuvaclBAREd7NbrvTRoj3Uj7mBz6ppShBl6TOt5ow4sc27K8Jle8jhdwy2vC/O319aLJ3tE3InyPxvTxUez9DwssKAzV7wI21Hu3fV/Y6XwUP/lcjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5yYhzfp; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4716f46a2eso1021607a12.0;
        Thu, 14 Aug 2025 17:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755217221; x=1755822021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnAqP/Eao4gbLB1mbZYWMwk5AegHaMBnl9yzD4tj3Pc=;
        b=Y5yYhzfpBxjgkA2+uPTWI7l99s5kVxQaHJUc0mjjXRn01JClTeXI26muzGByTj+DrJ
         HPfH/nWIoQuk/+fM0/NtBDsxNcir8WWzG3Wwn9Bsi3bUg9Eyr9gMP+lYVlaVsC0OIMtx
         i57ohFJC1FEIjURSukNaqsaSkf10s4C/5gYNl29aq9k3ySA+LLTbIzJ6hyveb6tSjS4U
         E3r+53nkjwjJtOjv+v1uRyv5yYZ1Dz6LeG/TSzeiNq/Ub1BQLaE3cNYL2V7ShsIBlvFY
         gegmRt3Q7oa5q2qNX4Zp2/hesZTnKd3ON9kQZyBx5aFVkT/BRSybAZCs14IS58+hEUZ0
         FowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217221; x=1755822021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnAqP/Eao4gbLB1mbZYWMwk5AegHaMBnl9yzD4tj3Pc=;
        b=nrPfLg8lsfNEsC4mDrBQeRDJCKt9hDZxsypvNcVx0Pxw3cKtspztXQ1sOhGgk0BcbJ
         reT4AvEhTmVRymtTP4RaGqytf/pOeHc8PhZvRtXWsvD+grxDUhaDktw8y4r5CEA16q19
         CG1h4rJ7PrIcckAke91ooxG3NcXsgSKaFFXlaaO6t0JgaWS5C9se+IHSRb+dbgxduyf/
         WKQkHz6R/31C2N9qgS9yCNBujeievxhjJwjSu/K8EZIr9j2Viizuap74uWJA9oppfdCR
         4r7a3v2EtvCE32igqxJYbGhgrSGckqvWd5o9bayVZLP1agFu0x8N7yrwVJQ/GoPtmMNs
         Ur9g==
X-Forwarded-Encrypted: i=1; AJvYcCVPYwUftehSwuQE+QQ6WfQqhGbq4T51bTfK0du3lglczSXA3lzUfkY4SAgMRNtS1BUD15XDUHXPrLAubMFp@vger.kernel.org, AJvYcCXxLTWaaEnrs0s1W/skJ/P9EujHzJO2ke4Sm6v14mlEt+L4If9HIGw/A2ApE8rDCtY7msg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5FoWCHo5lAkI/J2HeT1y5okojj6k7gJtiilfWiWsR9/glRBy7
	fTWP/hRfLhN4zBR8rCLe8BNTfktcHUiIftRfNJybId3Krts9KcSJHpUrUHefLaLCA7A=
X-Gm-Gg: ASbGncuUGI1xNi+ba6BgxYKTjh/nMvgHPh47d8vW/3AM+Ba2+1h3FBcmcjsZGdFqc4y
	4h3ag9dhcH0KLEvtY+tOB+9rpbl6pca7h74R0454E2BswY9upuTz72KaJ+n8fyn/0p/pRDloBAa
	8D/ZfVFxKkTLyFYQqWB/LL4/YxiCDc7kdKhDIYesTTIIENKbe1aK8YVz7Y8KSotUybVHpbRz9wb
	mj2/VTu46jlg5uZXZwy1DqhA1Yvjbo53Zfv59H8yBmE/TOjO5dfuHjJN9rxo0Z/JOF6njIwLLC6
	aSyUCj2yJVVq8tf5OBNp+FQB2A9l/6EC8549YFMBOvi5QtSdAJ4736vfz+aYswFBo3Rks52ay1z
	4sdqj/+t2hfA54AQebAVsM4DNun3ka/3W3rL3G/CQ3A==
X-Google-Smtp-Source: AGHT+IFCAtu5B5yxPJm9Jf0dqxrJjQRchll+v2TqA1NF0cIniaNtFVRw/nJJfo96v0jQVWxXrvFqKw==
X-Received: by 2002:a17:903:46c4:b0:243:6d9:aa2e with SMTP id d9443c01a7336-2446d9b0973mr1513905ad.53.1755217221031;
        Thu, 14 Aug 2025 17:20:21 -0700 (PDT)
Received: from soham-laptop.. ([103.182.158.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5a451esm700745ad.165.2025.08.14.17.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 17:20:20 -0700 (PDT)
From: Soham Metha <sohammetha01@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Soham Metha <sohammetha01@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 4/6] selftests: kvm: riscv: fix spelling mistakes in comments
Date: Fri, 15 Aug 2025 05:48:01 +0530
Message-Id: <20250815001803.112924-3-sohammetha01@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815001803.112924-1-sohammetha01@gmail.com>
References: <20250815000859.112169-1-sohammetha01@gmail.com>
 <20250815001803.112924-1-sohammetha01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

found/fixed the following typos

- indicies -> indices
- requrired -> required
- guranteed -> guaranteed

in `tools/testing/selftests/kvm/riscv/sbi_pmu_test.c`

Signed-off-by: Soham Metha <sohammetha01@gmail.com>
---
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index 924a335d2262..6a8818ac036c 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -212,7 +212,7 @@ static void update_counter_info(int num_counters)
 	for (i = 0; i < num_counters; i++) {
 		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i, 0, 0, 0, 0, 0);
 
-		/* There can be gaps in logical counter indicies*/
+		/* There can be gaps in logical counter indices*/
 		if (ret.error)
 			continue;
 		GUEST_ASSERT_NE(ret.value, 0);
@@ -446,7 +446,7 @@ static void test_pmu_basic_sanity(void)
 		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i,
 				0, 0, 0, 0, 0);
 
-		/* There can be gaps in logical counter indicies*/
+		/* There can be gaps in logical counter indices*/
 		if (ret.error)
 			continue;
 		GUEST_ASSERT_NE(ret.value, 0);
@@ -474,7 +474,7 @@ static void test_pmu_events_snaphost(void)
 	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
 	int i;
 
-	/* Verify presence of SBI PMU and minimum requrired SBI version */
+	/* Verify presence of SBI PMU and minimum required SBI version */
 	verify_sbi_requirement_assert();
 
 	snapshot_set_shmem(snapshot_gpa, 0);
@@ -489,7 +489,7 @@ static void test_pmu_events_snaphost(void)
 		if (counter_mask_available & (BIT(i)))
 			GUEST_ASSERT_EQ(READ_ONCE(snapshot_data->ctr_values[i]), 0);
 	}
-	/* Only these two events are guranteed to be present */
+	/* Only these two events are guaranteed to be present */
 	test_pmu_event_snapshot(SBI_PMU_HW_CPU_CYCLES);
 	test_pmu_event_snapshot(SBI_PMU_HW_INSTRUCTIONS);
 
@@ -500,7 +500,7 @@ static void test_pmu_events_overflow(void)
 {
 	int num_counters = 0, i = 0;
 
-	/* Verify presence of SBI PMU and minimum requrired SBI version */
+	/* Verify presence of SBI PMU and minimum required SBI version */
 	verify_sbi_requirement_assert();
 
 	snapshot_set_shmem(snapshot_gpa, 0);
-- 
2.34.1


