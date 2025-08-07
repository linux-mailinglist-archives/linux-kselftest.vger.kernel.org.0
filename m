Return-Path: <linux-kselftest+bounces-38478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E20B1DA7F
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 17:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76531AA3A0B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 15:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B17626528B;
	Thu,  7 Aug 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUm8/EdA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9234222C339;
	Thu,  7 Aug 2025 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754578791; cv=none; b=OfoaooOaCwfS/SqO8gUhmnFw6HftYU29gzQ03bSvwlcv6KnniZBtHamiuQ617LnThVLCpZfxtg5xGPhIpedTl89NTKL86rXVwQx7w75R8Olp7A2OE1UDudIVpUxrL5M6VIlqTVldkKdCa3OgW4bGhPFWqp5/MZ5GCz9bouLYB+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754578791; c=relaxed/simple;
	bh=aGdIIltb3/FuGFeqZwkoBzSyX+2R9Muuh4XWzgANQww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kAXANoFMMqFYGV4XyDFOvmHXLtJ2ktm5EZZaDaclOzlbQMZxVyXNO2UfRSuU4GqVh6f26X3Iv5CXUVt4x9m6FumWhX7MEZlbcEUfykeFQO0mxLmm3CRdETSfB7YEwgWZuv1wbguzOR9b8i2UMDzOOFQNzPguVxMj+fwEiDuZsO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUm8/EdA; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2402bbb4bf3so13303755ad.2;
        Thu, 07 Aug 2025 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754578789; x=1755183589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEKBOFcXEZzeUzMFUmEzc0IXYr/dBeW4zd4vFjmsRos=;
        b=HUm8/EdA1teJ4tCrO0HiDzkTaaH8VQYYzP4Wev00K3XvwjCnTOwFl6PVzUFwMyN8h9
         8+WDl8VThXYPlqVadX6DnTYGZSRnx2doNUPXnLanmMUA2OFPkzcP/WYsEexDgMbwYm7x
         Xi9iTpJtpQHXwTiEpB6bpSIvhgMAOmd5SQnd6ym6LdGQ5+xNAwRsHPgstw9rrDJAwjFg
         fwKES7lsjL3kI1AOX/INeL/ghMbQQwrqpcdGUNoShz2oF+7iqXKv97Ws6Mfdfsifsz2V
         evVbTmm82Op1MOWCCYiRNIdrG3e3qRHzQy8TPuHTHcE6CyWHp0Xu6KAe87xAOKLc0OHH
         vR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754578789; x=1755183589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEKBOFcXEZzeUzMFUmEzc0IXYr/dBeW4zd4vFjmsRos=;
        b=M6oUoQHf7diUyYa4PqQn35uGFM5T+MTXxmKSaORw9MizPa4skQ46UFZqqbCu5WIZqu
         EpofGwDprla2BIc7c4FeARAbJsTanilexnrus9QqdV/nANuTq9EQMQUIUMnaQCRqV0Qz
         Rj8t9FxnTKVlirBR/iFNAiIx/wO1Bqo9MfCmbaUSLuMXYbLMpJ5VCYE9TTgUD8It4YWh
         ZDXP7bEJlNymZIFmTA0GxS/zFSB4sXOHpmAYgLvg1wAymYC+bm9wbVkunCfzyXPIrBkV
         lzoB1KFhvzQmOvAplGQuUQuUY6ANt9kV4YFx0YS8Z91T7I62x40st3d4VIf2rgp7aqOx
         HBUg==
X-Forwarded-Encrypted: i=1; AJvYcCUUrR7WiJm6kMEoDT0yCgw6XJ+R15+/JAhOBBkpqPVwyZMGo+IVtroEJqt6sRAFOfICY7wGRpRuNEW2JTMVaybP@vger.kernel.org, AJvYcCVNYAWoP74UUzQS/AVFOEhEemCFv034GaLEdZ/NQzNZWbNsjnp8CPZqqTh9SYrJTZigZ119nhf3GTXWk3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvkGSLyvCDPkar5wKXCHnayrMqCCGWw24A/m4gSwA4+w/r2YY8
	jTUZUYZOmqdH5eAENXoJiQCQhh0Cp2NNdnNKQUUz3w50kcbzzBBN0orld4JjgWxuQZMGLSA6
X-Gm-Gg: ASbGncshDQoedL/bSdGSd+PNszUXN/awSoGrTcOSelEeROpchj3UnFP4k2jhaVN4SqW
	nuPAKbxmzY4VN3WRPOzrmaI84HeyTtbwl0rgIAzj+ZIjxJRA+Qz/EFfBxsps+6xlL1rut+pDJwL
	l3/qe2zRUaaqykEenvCeC3Vzi/E5jZMEYpW3HIv0n8UYZEzDL1TF27GAlynGk9GijshZ6SuRxV9
	O1WVrtA2Hd4IMSZ97P2jXGsQ5BWbruNGFrdszxIyNa2VVqjPoeO3dH+DxNWHyH7swAtpRsdxqY2
	aXL/LT45waD9BjHnO0lp1KNGGmvWatgIMqQbR/dFal38FRENrtwEI0FxYruwpymIsdIYNPD1Vx7
	PVvnvYt+uH+YmFRhPVSrVnH2L7K9RMHN+7g==
X-Google-Smtp-Source: AGHT+IEKQGRwDJq1V8V4pFVhYsK4f9Gbh8SYKbU4QZlJjvPkkv9DEDqw9cocLhhr2stwvSgsFgK9Hg==
X-Received: by 2002:a17:903:3c6b:b0:240:3bb7:fdc3 with SMTP id d9443c01a7336-242a0b6eac4mr81244295ad.28.1754578789452;
        Thu, 07 Aug 2025 07:59:49 -0700 (PDT)
Received: from days-ASUSLaptop.lan ([213.130.142.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8977896sm188254875ad.79.2025.08.07.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 07:59:49 -0700 (PDT)
From: dayss1224@gmail.com
To: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Dong Yang <dayss1224@gmail.com>
Subject: [PATCH v2 1/3] KVM: riscv: selftests: Add common supported test cases
Date: Thu,  7 Aug 2025 22:59:28 +0800
Message-Id: <09544c24d724a0e9d01c34b3d7599d860919ccb6.1754308799.git.dayss1224@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1754308799.git.dayss1224@gmail.com>
References: <cover.1754308799.git.dayss1224@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quan Zhou <zhouquan@iscas.ac.cn>

Some common KVM test cases are supported on riscv now as following:

    access_tracking_perf_test
    dirty_log_perf_test
    memslot_modification_stress_test
    memslot_perf_test
    mmu_stress_test
    rseq_test

Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dong Yang <dayss1224@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 38b95998e..3a7186551 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -197,6 +197,12 @@ TEST_GEN_PROGS_riscv += arch_timer
 TEST_GEN_PROGS_riscv += coalesced_io_test
 TEST_GEN_PROGS_riscv += get-reg-list
 TEST_GEN_PROGS_riscv += steal_time
+TEST_GEN_PROGS_riscv += access_tracking_perf_test
+TEST_GEN_PROGS_riscv += dirty_log_perf_test
+TEST_GEN_PROGS_riscv += memslot_modification_stress_test
+TEST_GEN_PROGS_riscv += memslot_perf_test
+TEST_GEN_PROGS_riscv += mmu_stress_test
+TEST_GEN_PROGS_riscv += rseq_test
 
 TEST_GEN_PROGS_loongarch += coalesced_io_test
 TEST_GEN_PROGS_loongarch += demand_paging_test
-- 
2.34.1


