Return-Path: <linux-kselftest+bounces-36824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9535AFEA9E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 15:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2732C17FE88
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0042E2E041F;
	Wed,  9 Jul 2025 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yzeZPODo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143D18F2FC
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Jul 2025 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068832; cv=none; b=o4m3Phur+xpkWpVwKNewwXs/fTp/M305ZQ154UHrIDoqjU7mK+5CWxS6vYQDkEQvZBwotbyXgPiodKKHtK1Jq/uoiimbQ25s4mODQXFV67anEmEtNSv/b+c0DbamiqjD1AKdwKV7VsNS0HZMGr/X1xsgPRRRhaJYGKp27LZhzDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068832; c=relaxed/simple;
	bh=hUx6IQ2FmJ3uo25F2LgfuwKeYhT/NpB72ybx3m4nraQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kY9o3yyfbiqohOK8v/2tK/bBF60DG5UNVl2xS+HHJbLxKjVo3kn/uw7gzkYKXWe0H083A8ckndUgT7V1Uoc63GuxN0eNYmioYQ05WvL2MLiduLU9jiMSoXjBriwQpXjLredtuwJDqMFT4HKjLaJGdK6Abv2A8Mdx0YxbGzHUhQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yzeZPODo; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d0a0bcd3f3so103453285a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Jul 2025 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752068829; x=1752673629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=as6bKKqAeltmDz2NBbzQMBxQaUhQ849TT+d9T/+6Oes=;
        b=yzeZPODo6cHbvpjSLN9mQ+8zjnzvmpvjUVpGLSe6SBguKHc0Unfrz6E4p+itYZwrFQ
         gwCGB/fPPI7nEJYuT6/UTRbngi95Iioxbav+7nfyC71q9mfEzBioybujAkwFCi5qjCfl
         h9WXiPzayG7uU4fyux7iDXmC5B8xlzUGJUJj8gx/chryFYOXe73tvx7v3W1QjgUlbb7h
         owy+WNHUyJ21b+vRjykb1w96Riv+YthSDxz6bux1NkbNL/zaYlT7ZulW8LuDYrFlRbkz
         +pZumVbV7aL+BO5u1J4j/71PmBQY3sw+1pSFK7TL0E2MDrYnIARubtcNsbP23U78MonH
         TnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752068829; x=1752673629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=as6bKKqAeltmDz2NBbzQMBxQaUhQ849TT+d9T/+6Oes=;
        b=ToRbzg2Ea81+ut7Q76nofYn1mHXBYlkM9tfolNpSm11rNG4EUN6LipSzEbNcQMmzAM
         wgJIIwWOnhysYnQE66kk0QskQ/RHNXkAyqOBwLruxM185lUAosl0L+KRQOC4RekmBssf
         7kNH6/3T5PPgkHjtBFN1JentWiNr/zDd+GdnTa/teGCuT9NsUk8U5jutgmJVfxleIKoX
         uYfI0+dN0ZjERj8AICd5xJfS9+GMEnSnTy2ZyU0lmbzRkhi2M448qabBEnUPpWEniTQy
         QOQwAKxwu+duB3xHLsGxbjOXRDPEscc2aKZG5kjxV9p5knMKdcN+cEtiVk1tRv6DevGK
         OCRg==
X-Forwarded-Encrypted: i=1; AJvYcCU746//9WZLLoCYDSdiuVYloyDN2yGjo47sh/+LmggWh4hJBUZL/vLZxKYW4EfYSykX7HU34D+oanr23dYtS5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+0nrvzFRYQjbOsiuGhsiu3KIHH9M905IXCEXoZi5jki2Kib1s
	BcejgvAgB5RpLzJvGW1OTtBSTQDlWBHxRuHvt5mbhPjGkZqpClagJyZDo0ApMOK5pso=
X-Gm-Gg: ASbGnctjVVoDxDncfz2PQLfBM6wIFzHP+7w0eU4A/tltQkzXJADT+yQy2kKtIoKP+xQ
	wQZXxwJ8aonFmSTpI9K+6M4sHbh6raCvKOaJYgkXSYrKBSeH/b0Uj8tojXlHq4pgWvntXJuADf0
	Mlxe23I0xOFyansMXLaBwf34fFBlZUmOZx1KzEy/hbNFdTG0ThCAJTZ6BseVtcz9N1evSyTMCqU
	G4X1lfSCuKmWhI7Q9Xom+Vz9xCtBH/GZKy8rmWmnDFIA6eLZJOA2rEfoceE0ilqnQmFVmmEX3yJ
	YVmZvTdLhyqOMFI5EgQlKewe9lyoNoemGoFEoI9SIpMX6ldrR5CmgVCFgfLHGtfF1fejAjcAB8z
	Z2on2KCo+jCSqRXmH/kj+9R4hg2tfGnXWc6rJVKK+GirED0dOldg=
X-Google-Smtp-Source: AGHT+IFFOoPOK9HHuurYgBtAvAo/xFEpWH1qHEPx2DaCo05dCGJJDXDCvW7ag9Ftcb/+qbtODa7JSA==
X-Received: by 2002:a05:620a:488f:b0:7d4:5c68:cf77 with SMTP id af79cd13be357-7da1fcc4946mr1014588485a.19.1752068828837;
        Wed, 09 Jul 2025 06:47:08 -0700 (PDT)
Received: from jesse-lt.ba.rivosinc.com (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbdb5088sm937846285a.25.2025.07.09.06.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 06:47:08 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	James Raphael Tiovalen <jamestiotio@gmail.com>,
	Sean Christopherson <seanjc@google.com>,
	Cade Richard <cade.richard@gmail.com>
Subject: [kvm-unit-tests PATCH v3 1/2] lib: Add STR_IS_Y and STR_IS_N for checking env vars
Date: Wed,  9 Jul 2025 06:47:06 -0700
Message-ID: <20250709134707.1931882-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

the line:
(s && (*s == '1' || *s == 'y' || *s == 'Y'))
is used in a few places add a macro for it and its 'n' counterpart.

Add a copy of Linux's IS_ENABLED macro to be used in GET_ENV_OR_CONFIG.
Add GET_ENV_OR_CONFIG for CONFIG values which can be overridden by
the environment.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
V1 -> V2:
 - New commit
V2 -> V3:
 - Add IS_ENABLED so CONFIG_##name can be undefined
 - Change GET_ENV_OR_CONFIG to GET_CONFIG_OR_ENV
 - Fix it's to its
---
 lib/argv.h        | 38 ++++++++++++++++++++++++++++++++++++++
 lib/errata.h      |  7 ++++---
 riscv/sbi-tests.h |  3 ++-
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/lib/argv.h b/lib/argv.h
index 0fa77725..111af078 100644
--- a/lib/argv.h
+++ b/lib/argv.h
@@ -14,4 +14,42 @@ extern void setup_args_progname(const char *args);
 extern void setup_env(char *env, int size);
 extern void add_setup_arg(const char *arg);
 
+/*
+ * Helper macros to use CONFIG_ options in C/CPP expressions. Note that
+ * these only work with boolean and tristate options.
+ */
+
+/*
+ * Getting something that works in C and CPP for an arg that may or may
+ * not be defined is tricky.  Here, if we have "#define CONFIG_BOOGER 1"
+ * we match on the placeholder define, insert the "0," for arg1 and generate
+ * the triplet (0, 1, 0).  Then the last step cherry picks the 2nd arg (a one).
+ * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
+ * the last step cherry picks the 2nd arg, we get a zero.
+ */
+#define __ARG_PLACEHOLDER_1 0,
+#define __take_second_arg(__ignored, val, ...) val
+#define __is_defined(x)			___is_defined(x)
+#define ___is_defined(val)		____is_defined(__ARG_PLACEHOLDER_##val)
+#define ____is_defined(arg1_or_junk)	__take_second_arg(arg1_or_junk 1, 0)
+
+/*
+ * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to '1', 0
+ * otherwise.
+ */
+#define IS_ENABLED(option) __is_defined(option)
+
+#define STR_IS_Y(s) (s && (*s == '1' || *s == 'y' || *s == 'Y'))
+#define STR_IS_N(s) (s && (*s == '0' || *s == 'n' || *s == 'N'))
+
+/*
+ * Get the boolean value of CONFIG_{name}
+ * which can be overridden by the {name}
+ * variable in the environment if present.
+ */
+#define GET_ENV_OR_CONFIG(name) ({				\
+	const char *genv_s = getenv(#name);			\
+	genv_s ? STR_IS_Y(genv_s) : IS_ENABLED(CONFIG_##name);	\
+})
+
 #endif
diff --git a/lib/errata.h b/lib/errata.h
index de8205d8..78007243 100644
--- a/lib/errata.h
+++ b/lib/errata.h
@@ -7,6 +7,7 @@
 #ifndef _ERRATA_H_
 #define _ERRATA_H_
 #include <libcflat.h>
+#include <argv.h>
 
 #include "config.h"
 
@@ -28,7 +29,7 @@ static inline bool errata_force(void)
 		return true;
 
 	s = getenv("ERRATA_FORCE");
-	return s && (*s == '1' || *s == 'y' || *s == 'Y');
+	return STR_IS_Y(s);
 }
 
 static inline bool errata(const char *erratum)
@@ -40,7 +41,7 @@ static inline bool errata(const char *erratum)
 
 	s = getenv(erratum);
 
-	return s && (*s == '1' || *s == 'y' || *s == 'Y');
+	return STR_IS_Y(s);
 }
 
 static inline bool errata_relaxed(const char *erratum)
@@ -52,7 +53,7 @@ static inline bool errata_relaxed(const char *erratum)
 
 	s = getenv(erratum);
 
-	return !(s && (*s == '0' || *s == 'n' || *s == 'N'));
+	return !STR_IS_N(s);
 }
 
 #endif
diff --git a/riscv/sbi-tests.h b/riscv/sbi-tests.h
index c1ebf016..4e051dca 100644
--- a/riscv/sbi-tests.h
+++ b/riscv/sbi-tests.h
@@ -37,6 +37,7 @@
 
 #ifndef __ASSEMBLER__
 #include <libcflat.h>
+#include <argv.h>
 #include <asm/sbi.h>
 
 #define __sbiret_report(kfail, ret, expected_error, expected_value,						\
@@ -94,7 +95,7 @@ static inline bool env_enabled(const char *env)
 {
 	char *s = getenv(env);
 
-	return s && (*s == '1' || *s == 'y' || *s == 'Y');
+	return STR_IS_Y(s);
 }
 
 void split_phys_addr(phys_addr_t paddr, unsigned long *hi, unsigned long *lo);
-- 
2.43.0


