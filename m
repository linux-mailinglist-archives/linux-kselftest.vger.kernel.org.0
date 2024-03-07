Return-Path: <linux-kselftest+bounces-6040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B4087496D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 09:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98CA1F21481
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 08:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3201633EC;
	Thu,  7 Mar 2024 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7hYvPur"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2513851C54;
	Thu,  7 Mar 2024 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799596; cv=none; b=i8/xsjhWPlKwXLwc1TV9psAf0gD/NOMlI9wdgHt6dHQqb338+GtIuTRWeEcc2MgqUdZcVfuonFQRzsq/t3JoTpZNJaV0wpP0WmFV0eV95ZSHGpAeK+qI+PggjGi7bINHaXeT8ANOWiJrlpJjLzTrHftOBI1OtYEYDNVbpd7Jq/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799596; c=relaxed/simple;
	bh=8FP38S7OrZ+MpTjf4w+My1/hNKejVVNsZfh22HhsIUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DYOjrfq2chQnrFqexlbuFei0KrHgsRcIaQrFDD2iGMk8OBwiQjbM2qyBeENB4flhCnZqJ818Q0Z4gJZtD76gHrr0L/aycMF/Nl3cXskti+kpFxo6DS3F18tSaCAyN/xNjSi9VhWJ40NI7wwXTe18/ebO7PimkqywA9ckFj9TtdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7hYvPur; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412fe981ef1so3301645e9.1;
        Thu, 07 Mar 2024 00:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709799593; x=1710404393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3cfeh/qgTCzNyqJWZG5K1iEv2VogtsczNtBj4FEYbc=;
        b=c7hYvPurgYXZGHx8zWUSDfdQtxiAKaKw6r3bd69EIKDeliNnstLdYr70aU0xynM9/N
         DvyFY/khAEpJH4RLLbglYqzErnhnjRSCXtKmyGKVH9b0w+HOcXEOLk3SMKXevGAVn5KC
         i9wqPSaQiVO/JRDyD7M29frCmYo2jyJ5A2sY6sJgpl10HJQPCkHqq6/gIhzEvzvbzgSc
         a3oh3GQGownVWjnCM6nUNhQe6/luU/lDRIMXnWBmYE8oPemxw5DBKfRMPZPENF501pli
         zMbKcE8bX8FRAFvgVjHZ+Qyv7siJcVZFnGsAujoP1cSlXwaROX/7+Ev2xzK0HSq1hJgq
         h5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709799593; x=1710404393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3cfeh/qgTCzNyqJWZG5K1iEv2VogtsczNtBj4FEYbc=;
        b=PQq9m0BpU3LZkE/mTi7LObQpJBlccaqRY25aJMwvtwoK+Y8kDceaTacL1hv+Ykz9ql
         DZM6ErBqrEXsIe9WaBIqahjE6Z/s7mnuvdl5MwNGjQdLWOvo3D7QpkGM2QFBzGWJS4mO
         J23oTHmqRt7LYXGuq/EyoOZWhwvQd2TI8jq/gDNYdvcjQqFNBRV6Tlkef2L555vm9ahQ
         V6+EOZfKUspdQ2egClIg3QwWcqGocJ7w65ZUaKkRXvqaDd8TJOSLebwLIc1w70tdXzT0
         DZJYyKW+F/MBGrT9rDfxhXHhRCRZjMNSofUJg6emtKntF07s0Vjl3utxLfpglNwG2dO2
         x3Ig==
X-Forwarded-Encrypted: i=1; AJvYcCW/bgG3OSYgQ+GE5XZKqrbQhfV1/yTAkia8akWV8fySBmkbqOYUl6rYjkkcCDfNpQOZYIFdhAHUOkC8PQL0bRqTiXkZuzjG3XXPpLBFURLb48J/s9Ft9Kr2osQtp7su4U1XtF21rirhDfFgyUAAjyXKq+0OKzp8X/3r/4Bf0zQdHtit
X-Gm-Message-State: AOJu0YxAMkmopqviI9j/rIQhoY6UB6YlZVir/CLX3OTYGUobUPWdZC5Y
	clqm6a5YdCAH2L3gme2nJ+Cr3ZFtPpk8pAUnoOU/8mGXiLWBJuKz
X-Google-Smtp-Source: AGHT+IHxp22ZICjNl26x1Qf0pwp3S9ZJz469LBsA59Wew3XXWy7W/Otp9bwAH8nrbisN+qEZRG5Xig==
X-Received: by 2002:a05:600c:4f91:b0:413:119:33e2 with SMTP id n17-20020a05600c4f9100b00413011933e2mr701067wmq.14.1709799593095;
        Thu, 07 Mar 2024 00:19:53 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id fb12-20020a05600c520c00b00412f81ba413sm1788954wmb.11.2024.03.07.00.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 00:19:52 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org
Subject: [PATCH][next] KVM: selftests: Fix spelling mistake "trigged" -> "triggered"
Date: Thu,  7 Mar 2024 08:19:51 +0000
Message-Id: <20240307081951.1954830-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are spelling mistakes in __GUEST_ASSERT messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/kvm/aarch64/arch_timer.c | 2 +-
 tools/testing/selftests/kvm/riscv/arch_timer.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index ddba2c2fb5de..16ac74d07d68 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -136,7 +136,7 @@ static void guest_run_stage(struct test_vcpu_shared_data *shared_data,
 		irq_iter = READ_ONCE(shared_data->nr_iter);
 		__GUEST_ASSERT(config_iter + 1 == irq_iter,
 				"config_iter + 1 = 0x%lx, irq_iter = 0x%lx.\n"
-				"  Guest timer interrupt was not trigged within the specified\n"
+				"  Guest timer interrupt was not triggered within the specified\n"
 				"  interval, try to increase the error margin by [-e] option.\n",
 				config_iter + 1, irq_iter);
 	}
diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
index e22848f747c0..0f9cabd99fd4 100644
--- a/tools/testing/selftests/kvm/riscv/arch_timer.c
+++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
@@ -60,7 +60,7 @@ static void guest_run(struct test_vcpu_shared_data *shared_data)
 		irq_iter = READ_ONCE(shared_data->nr_iter);
 		__GUEST_ASSERT(config_iter + 1 == irq_iter,
 				"config_iter + 1 = 0x%x, irq_iter = 0x%x.\n"
-				"  Guest timer interrupt was not trigged within the specified\n"
+				"  Guest timer interrupt was not triggered within the specified\n"
 				"  interval, try to increase the error margin by [-e] option.\n",
 				config_iter + 1, irq_iter);
 	}
-- 
2.39.2


