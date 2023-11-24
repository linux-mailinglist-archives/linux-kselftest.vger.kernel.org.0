Return-Path: <linux-kselftest+bounces-498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF91D7F6CD2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 08:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8678028179D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 07:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FFD4699;
	Fri, 24 Nov 2023 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="JaPG6M2A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9FFD73
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 23:22:12 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a00a9c6f1e9so224746266b.3
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 23:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700810530; x=1701415330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdW6KLqAappiJz7t43GP8yDkVw3RQUH/PCIQaxhT8io=;
        b=JaPG6M2A4IEO0kpsTn/OdpW3CBtu0kKymdbEzEUJ17k7UPsFaeNZ5vas5OzpzFEUaG
         Z9ZWJRGTX2sMXdJBTk7F97cyCdXgiB4g0ZNijBATG6qcxICsJko2DK0ge/n9ikm/DgPB
         pGKgufgdJjgtkqlGVsTVEHfKoR1Cxsqnrr7Q5mzyTc3LGVbTpFuoW7z/EjjXP2n6iSP0
         sdGGmPiXSxVkgOTsnVJ80krylqCfLad/1UQgBlb7l1jlyM2NHF/HJTriQepxlJbAEpvH
         DOWWOP6XSqHBYbSLeUyFr7N53w4/VojNknqswRVKiejbEj1OxlbYojhuHwn8+/p8Ynvs
         li8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700810530; x=1701415330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdW6KLqAappiJz7t43GP8yDkVw3RQUH/PCIQaxhT8io=;
        b=eALgLda1SWY73D5bCf4ZOfOEKUHDYFLmD9xty8vzRJPyx2xFFlxJXzAaRAI+XWAuso
         3rwPc/TVMLljnYfSEJkGgphOxOigQy/LgiqXFLemNW4HPlo4pBAMKP/PX0Wu/gEPP+62
         0GuIso4GS6rvHzuLSZ9J2V7qguPIIuH0HzD107FuH+JgkrqznLIgxbWhtvqMsyTOuzQ0
         OxJgIwv76GrLdGcCzX3WWJIMvDqy49bns6X90VNnQHxdiXaABRtk7ucFXSosFc6Hx9sm
         VESGeD+lXVMCF1e3657HPmkaSy52v6UaRPjigljCTBUrONIwKay2UWIAsmRxpkudy508
         B8GA==
X-Gm-Message-State: AOJu0YxkTyceilprxVn7pl6B20E+pfZgVy6M5ke01OQwXoblU0D60584
	OPACTLjjT4Ym0RfmonmcAgQPAQ==
X-Google-Smtp-Source: AGHT+IH6YJTwKcWKKY/43rAcT0UuuNs5BImrDdkrAupQGRjsaG9PttQVyjsPB2Eshk3SwrOXEogoeQ==
X-Received: by 2002:a17:906:220c:b0:a09:e716:5ea8 with SMTP id s12-20020a170906220c00b00a09e7165ea8mr121667ejs.18.1700810530557;
        Thu, 23 Nov 2023 23:22:10 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709060e5200b00992f2befcbcsm1709930eji.180.2023.11.23.23.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:22:10 -0800 (PST)
From: Christoph Muellner <christoph.muellner@vrull.eu>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Anup Patel <apatel@ventanamicro.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Guo Ren <guoren@kernel.org>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Daniel Lustig <dlustig@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [RFC PATCH 3/5] uapi: prctl: Add new prctl call to set/get the memory consistency model
Date: Fri, 24 Nov 2023 08:21:40 +0100
Message-ID: <20231124072142.2786653-4-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christoph Müllner <christoph.muellner@vrull.eu>

Some ISAs have a weak default memory consistency model and allow to switch
to a more strict model at runtime. This patch adds calls to the prctl
interface which allow to get and set the current memory consistency
model.

The implementation follows the way other prctl calls are implemented by
disabling them unless arch-specific code provides the relevant macros.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 .../mm/dynamic-memory-consistency-model.rst   | 58 +++++++++++++++++++
 include/uapi/linux/prctl.h                    |  3 +
 kernel/sys.c                                  | 12 ++++
 3 files changed, 73 insertions(+)
 create mode 100644 Documentation/mm/dynamic-memory-consistency-model.rst

diff --git a/Documentation/mm/dynamic-memory-consistency-model.rst b/Documentation/mm/dynamic-memory-consistency-model.rst
new file mode 100644
index 000000000000..21675b41ec84
--- /dev/null
+++ b/Documentation/mm/dynamic-memory-consistency-model.rst
@@ -0,0 +1,58 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================
+Dynamic memory consistency model
+================================
+
+This document gives an overview of the userspace interface to change memory
+consistency model at run-time.
+
+
+What is a memory consistency model?
+===================================
+
+The memory consistency model is a set of guarantees a CPU architecture
+provides about (re-)ordering memory accesses. Each architecture defines
+its own model and set of rules within that, which are carefully specified.
+The provided guarantees have consequences for the microarchitectures (e.g.,
+some memory consistency models allow reordering stores after loads) and
+the software executed within this model (memory consistency models that
+allow reordering memory accesses provide memory barrier instructions
+to enforce additional guarantees when needed explicitly).
+
+Details about the architecture-independent memory consistency model abstraction
+in the Linux kernel and the use of the different types of memory barriers
+can be found here:
+
+	Documentation/memory-barriers.txt
+
+Two models can be in a weaker/stronger relation. I.e., a consistency
+model A is weaker/stronger than another model B if A provides a subset/superset
+of the constraints that B provides.
+
+Some architectures define more than one memory consistency model.
+On such architectures, switching the memory consistency model at run-time
+to a stronger one is possible because software written for the weaker model is
+compatible with the constraints of the stronger model.
+
+If two models are not in a weaker/stronger relation, switching between
+them will violate the consistency assumptions that the software was
+written under (i.e., causing subtle bugs that are very hard to debug).
+
+User API via prctl
+==================
+
+Two prctl calls are defined to get/set the active memory consistency model:
+
+* prctl(PR_GET_MEMORY_CONSISTENCY_MODEL)
+
+    Returns the active memory consistency model for the calling process/thread.
+    If the architecture does not support dynamic memory consistency models,
+    then -1 is returned, and errno is set to EINVAL.
+
+* prctl(PR_SET_MEMORY_CONSISTENCY_MODEL, unsigned long new_model)
+
+    Switches the memory consistency model for the calling process/thread
+    to the given model. If the architecture does not support dynamic
+    memory consistency models or does not support the provided model, then
+    -1 is returned, and errno is set to EINVAL.
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 370ed14b1ae0..579662731eaa 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -306,4 +306,7 @@ struct prctl_mm_map {
 # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
 # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
 
+#define PR_SET_MEMORY_CONSISTENCY_MODEL		71
+#define PR_GET_MEMORY_CONSISTENCY_MODEL		72
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index e219fcfa112d..a8a217a10767 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -146,6 +146,12 @@
 #ifndef RISCV_V_GET_CONTROL
 # define RISCV_V_GET_CONTROL()		(-EINVAL)
 #endif
+#ifndef SET_MEMORY_CONSISTENCY_MODEL
+# define SET_MEMORY_CONSISTENCY_MODEL	(-EINVAL)
+#endif
+#ifndef GET_MEMORY_CONSISTENCY_MODEL
+# define GET_MEMORY_CONSISTENCY_MODEL	(-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2743,6 +2749,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_RISCV_V_GET_CONTROL:
 		error = RISCV_V_GET_CONTROL();
 		break;
+	case PR_SET_MEMORY_CONSISTENCY_MODEL:
+		error = SET_MEMORY_CONSISTENCY_MODEL(arg2);
+		break;
+	case PR_GET_MEMORY_CONSISTENCY_MODEL:
+		error = GET_MEMORY_CONSISTENCY_MODEL();
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.41.0


