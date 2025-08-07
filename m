Return-Path: <linux-kselftest+bounces-38479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBF5B1DA84
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 17:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF771AA4D07
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 15:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F2226656F;
	Thu,  7 Aug 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAz1o/4w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F0265CC2;
	Thu,  7 Aug 2025 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754578798; cv=none; b=KY2p3LJx9qoQTzbNcErxhNcaPKjQAuVqqvWbvG82obwRlBub373abYUnIQRx3M1XCSoTLJuAGs0kj6d+57seK7kOVWhtoMXErrkA6r9oiXxxEjs8ox24ClfiBSndZ99kCn8Kb05tJXjxUm3IuvIQJAZ1Cx9F7Tr7VnEfaJQ9f1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754578798; c=relaxed/simple;
	bh=EdvPBByj2u5j5pDV5K3Qt0HlTqdCfMU9x78tj+wVu6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JJirZwo+8sQTearqyjV1/NvOVrzitPjBe+FtXKB9mYdBT0E3zvuvv8CCLJgBYifGsN/+XEWlbZGXZZoKuf/ChdfMtNbYkgCDUTZk8wWwHAA3s4bHsi8weDDmGMjlx6ySHq5tbvNwfOSqvkeERk+gQwN06Kn6OyviwBdwapAGq20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAz1o/4w; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b4209a0d426so1110124a12.1;
        Thu, 07 Aug 2025 07:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754578796; x=1755183596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22KKAv75ruk3Ey3Mnp1dAEnaFgvvgO6+9uK7rLi7Vnw=;
        b=QAz1o/4wlrGz3JAIxlu4ZgOWQk5LXMkeuHmYTF+Uc+0++FFf3U4u8CGlDwI7O45Y8X
         5I31S5o6lAZsldlnAU9tI5ZneGA/8UzN6lkP0E+ITNpH7Vea+qClGQT06k7DIicVrwd9
         7yWsMSX+WLpNeHFXFO3dH7rElpIkhm1qtmaH7ixy4HS53txqe1SUBusuFESWOOz1h+wt
         jG0y38NRDxa9o5n+MxM8pS5ARLEXunWmW6OirqnWlQti/e/jdvFU2s/xlC9unV/ix9va
         LdKTupZUo5iU2HzMx9MSyXmpL5FHKiRPdBsgimKvR1+r/SZuaqnG8E39lVtfqdjdfQgT
         +XCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754578796; x=1755183596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22KKAv75ruk3Ey3Mnp1dAEnaFgvvgO6+9uK7rLi7Vnw=;
        b=e10MZm6et0LTMi+XxabyEZNc1gAE2Za9JkEEgdPt2Hmx79PsBdMe/NP2z3Gv/Rhk4S
         e8v2PLjiHLLzQYc3CmzGP0JqvkJ3301dVAdyl+AhS3wCy86t6sO5Uav3cIoyq+mUmL8/
         gEYGF0PEmv6oMFO7kiZw4H71UWN6Pcx6aKLXxABW4H4XPlr1mo3xDB/rjLXidvfJ/HBV
         ijuZhwyrx+PWbJSXoKReYkEItulTSZESKT95gdG7QO3F1xFyeprMLlDlUA4ktuO0Pde7
         E0ihfV3go6XiWuGEV5hkbpmBSyQrtMAgVDK14Z9Th+P0P59NKnMiAWYrUOfFACXmh3CA
         8aNA==
X-Forwarded-Encrypted: i=1; AJvYcCUEHsOS/ra2MSvvE52j1Lr64OW3MUgxGKkxhNpRlx6Ml+/Vz5Bi4I3GfA0Wll5tif+4Q9KVouNnKx5w8nw=@vger.kernel.org, AJvYcCW3qlDLaCMckczopGNWXfJzpWS7fA+WldQI3rstxzoZOlIo21Q3lW7py/ki4e1K4CbV5ggD2Ui39id76BSHiatd@vger.kernel.org
X-Gm-Message-State: AOJu0YywAGPUNfY9k78HUeG4q5ZrVvNYx8kWSCIL+yAzk1q+jP1d1uOH
	s9jboGCkqaWi+Nc/b4m1rKC3cxDUqLVmSAsktOsMWueQONgndioHhOAGh38Ayhb4+D0LL11R
X-Gm-Gg: ASbGncuE11fPfSoWy62/a7EJqLvaAjuGM870xEjl6MYk8tF9ZUs2g7Lc7r+kxLb6zMc
	w8nE2X6vjIN4PIODDpY6Cvdik7p/MECLPr1eg7r1GvvsVW6NmFH1ow5BiFj8mgZXkvIxFkqzvTr
	kZA2KDAXIj9TfhkxDOanWlBkglPVdBPwZopYCLc2zEESN/AVrAcKMJegJCOqPQZbyAYdHJzT2ty
	h7t4c7g7iI3YqzXehfUixOgH7KUoQBsdDUqnE4TDek16mKa3jOMCu7ia7Y70whnvVon28DxFQfd
	YnrwBqjtwFBHxWBIO3cNYDZdelaHrD7dTkwtzPQAnuPsuvn0zbOZv0hoNtAQZNvKgUm9FdWd3zK
	zEUVzya89rvB48KhtF4cN94dDKiu9brZmEw==
X-Google-Smtp-Source: AGHT+IHSOqYAlYjD5Ef/rlBHjxgWHAS+CS7TtAabCjgcNjOUQ2cMe6E5st467+N1r/2t8+OVaRydqA==
X-Received: by 2002:a17:903:3d0e:b0:242:1ccf:65df with SMTP id d9443c01a7336-2429f326a64mr84374645ad.13.1754578795747;
        Thu, 07 Aug 2025 07:59:55 -0700 (PDT)
Received: from days-ASUSLaptop.lan ([213.130.142.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8977896sm188254875ad.79.2025.08.07.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 07:59:55 -0700 (PDT)
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
Subject: [PATCH v2 2/3] KVM: riscv: selftests: Use the existing RISCV_FENCE macro in `rseq-riscv.h`
Date: Thu,  7 Aug 2025 22:59:29 +0800
Message-Id: <7de4aedb44be3166a6568c28da70c0d2d4850571.1754308799.git.dayss1224@gmail.com>
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

To avoid redefinition issues with RISCV_FENCE,
 directly reference the existing macro in `rseq-riscv.h`.

Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dong Yang <dayss1224@gmail.com>
---
 tools/testing/selftests/rseq/rseq-riscv.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
index 67d544aaa..06c840e81 100644
--- a/tools/testing/selftests/rseq/rseq-riscv.h
+++ b/tools/testing/selftests/rseq/rseq-riscv.h
@@ -8,6 +8,7 @@
  * exception when executed in all modes.
  */
 #include <endian.h>
+#include <asm/fence.h>
 
 #if defined(__BYTE_ORDER) ? (__BYTE_ORDER == __LITTLE_ENDIAN) : defined(__LITTLE_ENDIAN)
 #define RSEQ_SIG   0xf1401073  /* csrr mhartid, x0 */
@@ -24,8 +25,6 @@
 #define REG_L	__REG_SEL("ld ", "lw ")
 #define REG_S	__REG_SEL("sd ", "sw ")
 
-#define RISCV_FENCE(p, s) \
-	__asm__ __volatile__ ("fence " #p "," #s : : : "memory")
 #define rseq_smp_mb()	RISCV_FENCE(rw, rw)
 #define rseq_smp_rmb()	RISCV_FENCE(r, r)
 #define rseq_smp_wmb()	RISCV_FENCE(w, w)
-- 
2.34.1


