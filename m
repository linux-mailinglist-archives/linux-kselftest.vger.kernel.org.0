Return-Path: <linux-kselftest+bounces-40399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29833B3DB30
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E1A17BC37
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 07:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2495926F293;
	Mon,  1 Sep 2025 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWPgsldL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9833526B75C;
	Mon,  1 Sep 2025 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712177; cv=none; b=epRIkrtnSnz+iqw6HhLyzp8v7K3YcFRr5mQFAvXn/FqQi8uMVJjS3JsavJqk4S7md9hrfKioTet4jD68hP8o8CXZWjsK0Wj93XR7Czgvsedfl574tuWgv0plGcEiYGxT/ilAmnfzJBGlZOnPJdTz6H0xa+p1HtAbb5JL5nFIdOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712177; c=relaxed/simple;
	bh=Jqcn0yG4SJ8XL8CUrnZ90nHHd5zVocksS0ZzfnOZPdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f2MfonuyhOAJJmxQYbuXZaEBby0nw5n2mnJaV5Pyr1YTvaKjKkWOYSWFrq+PHV3eY5SNLbqNIeZczR38mu4Knp2n0T3LS2qycx6wQ6GHny4wTZM/j4RecY+QrzEjS7BrEAOf3Jk4lXARdfCkHZBRbsrOkeb5kFhhxbOOuuGAgCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWPgsldL; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-24aafd1c2a1so10343075ad.3;
        Mon, 01 Sep 2025 00:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756712175; x=1757316975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oeHOkgW1SXEWkLO09M8aNICfxiWEQZMbiFzd9nXhNI=;
        b=UWPgsldLhpdiy2FGInlF9IHqRVuwNmCLoEkaDcPE4D9tmjBi6PILsfCjuwcS4hESWV
         AudJwGXYk4+2ZO+V+DRaV6ZbrsPHZ5pbpFmAnCwpoRzH1R2ga5wCh72cnBTK3ZkiMJnD
         k+CCWOm4VZwrsjRluB4RRcWUN2rlXikIUQgRLJ/9xU49t7NZVxHgO3GtagRjBhx7/BN9
         hFa6O+7UDS+n81/pC9AmvzyLCzz6wV64gaDudfnueQ08AYR7dgTxSjZk0Kg6iKM11d5L
         mok6+FmRBl5SImxw6x1Mn3R8PuLtPv4DcgiyD9LVU4WmXrKqd4KlbyBJrwSSTMtb6K01
         QqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756712175; x=1757316975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oeHOkgW1SXEWkLO09M8aNICfxiWEQZMbiFzd9nXhNI=;
        b=EEZu9+Sg6VZyL8oNyHNK3E/gTh8byh7fqdvqnwfkwWmAs0y1F3bDrj7sXKyB18IMRK
         HjiEnb707YqJwPOqbjJrToR9dbdUDeE130Gbh1WpbMaC51PD90sDV21ElqF5PEQQQAIY
         KFNFJ+10aSy0vfxRuOLKYnYLYggcyZmOPh+iCbPuqlpR1JA/CaehrOybRFZebTFeFiAG
         GFkZSc9904PtyIgmHsb49uOpitSK2324dgfHFPABbQixInyp6g4aFtYZFj+SWoZWz/oE
         tvaOyckP9Ca2t0wLpsqrfZ1nN/lJdFVHNDVs9ag/O9C0+1U0M966gZTwDohQJpMVcvF8
         qJHg==
X-Forwarded-Encrypted: i=1; AJvYcCUpP6KNLP3n8hyRTbLSI5bxAoNvFH7tSu3rH35hhNDegwtGUsPAKobUKU9vcmrxqc1z58I=@vger.kernel.org, AJvYcCWioPzAqC1sK8JWv+tOYobe1rQqIaXxHtQF/yT5kbExEBB/iJ9/znGXUtqRY5Yrh2XzHtoC5SpaZ2FfN2E7@vger.kernel.org, AJvYcCXChjAfTcL7UHGEUkLSXUl/YIcG6af7eiWc5QzmmincQDC3uF0kULGv2QloqksSu3c9swABQsVgIPVYYpekFy7b@vger.kernel.org
X-Gm-Message-State: AOJu0YzRPztVPrSWNj7XIpp10Ib33h6IiebTfYeLi8msf671+C8X5I8o
	ZeELrGxgIOwcVyW7T5Q4yK1S0d7WxeKf/0dcdRJXbyNTy5adtpsIsMMq
X-Gm-Gg: ASbGncsVd0/N1EjqPYbGOTzlxZ3Nn264vbGNQ88vM8OSg9TM9v6kctwIvKfKy+xSrHO
	kE8IXn/OtJ3uFZELomdeZlI8k3nLhdpxk9kZ6ldBgjAfCd3OR9qWTSzHF7c2WlGYYockc2MMq5C
	CTRjqqVg3vYInGMOo11qVii/TdoHhiwtMjtvmAxd5z/INkDKSTz4bn0Nox27uFjOU1hi/0G8OP3
	/MJyIvOM6grwwdO6IjYu6CslDfsNiJl0qaUGpvtP7gCHQvaq47n3Kh6rS1ds0KrsXfawHI6XP0A
	Kxrif182WEtx9y5NMxIEC81qQiqOqGQ1ZYoQ0dK1oI+m9tF+ns6kKqHJUfbjCzf/WkiUoCQz5LQ
	uX+J1ZpsU+m2FGu3s6kFa
X-Google-Smtp-Source: AGHT+IEmw91k51+a/u/6Yg/p/QfXcjorBAKjeKm8LC1Ywv4G99JsY2MawriOAwBq5epZ8HFlkc1KVw==
X-Received: by 2002:a17:902:ccd1:b0:246:de32:10d2 with SMTP id d9443c01a7336-24944a458c3mr90279695ad.15.1756712174848;
        Mon, 01 Sep 2025 00:36:14 -0700 (PDT)
Received: from days-ASUSLaptop.lan ([2406:8dc0:6008:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903737b05sm95867045ad.49.2025.09.01.00.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 00:36:14 -0700 (PDT)
From: dayss1224@gmail.com
To: pbonzini@redhat.com,
	shuah@kernel.org,
	anup@brainfault.org
Cc: atish.patra@linux.dev,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Dong Yang <dayss1224@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v3 2/3] KVM: riscv: selftests: Add missing headers for new testcases
Date: Mon,  1 Sep 2025 15:35:50 +0800
Message-Id: <bfb66541918de68cd89b83bc3430af94bdc75a85.1756710918.git.dayss1224@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756710918.git.dayss1224@gmail.com>
References: <cover.1756710918.git.dayss1224@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dong Yang <dayss1224@gmail.com>

Add missing headers to fix the build for new RISC-V KVM selftests.

Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dong Yang <dayss1224@gmail.com>
---
 tools/testing/selftests/kvm/access_tracking_perf_test.c        | 1 +
 tools/testing/selftests/kvm/include/riscv/processor.h          | 1 +
 tools/testing/selftests/kvm/memslot_modification_stress_test.c | 1 +
 tools/testing/selftests/kvm/memslot_perf_test.c                | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index c9de66537ec3..b058f27b2141 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -50,6 +50,7 @@
 #include "memstress.h"
 #include "guest_modes.h"
 #include "processor.h"
+#include "ucall_common.h"
 
 #include "cgroup_util.h"
 #include "lru_gen_util.h"
diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 162f303d9daa..e58282488beb 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -9,6 +9,7 @@
 
 #include <linux/stringify.h>
 #include <asm/csr.h>
+#include <asm/vdso/processor.h>
 #include "kvm_util.h"
 
 #define INSN_OPCODE_MASK	0x007c
diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
index c81a84990eab..3cdfa3b19b85 100644
--- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
+++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
@@ -22,6 +22,7 @@
 #include "processor.h"
 #include "test_util.h"
 #include "guest_modes.h"
+#include "ucall_common.h"
 
 #define DUMMY_MEMSLOT_INDEX 7
 
diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index e3711beff7f3..5087d082c4b0 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -25,6 +25,7 @@
 #include <test_util.h>
 #include <kvm_util.h>
 #include <processor.h>
+#include <ucall_common.h>
 
 #define MEM_EXTRA_SIZE		SZ_64K
 
-- 
2.34.1


