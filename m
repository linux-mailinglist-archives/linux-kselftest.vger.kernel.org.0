Return-Path: <linux-kselftest+bounces-39162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97C0B291A7
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 07:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF08816C365
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 05:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E70E19B5B1;
	Sun, 17 Aug 2025 05:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJeLQ77z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B66078F20;
	Sun, 17 Aug 2025 05:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755408370; cv=none; b=WXwRdjcsdcyHfJ6qeSwHw+rlpYTK0kGC7EBRyygdCO4oJ7loxnAX300SbaXd2H06ukoOlAiJkau+5F4g9ra++U1Jvuk/8V80kCLGl/zq6RAlupIeKZsRyBG91mmlFC21a7Pcdm1INcZNGE/ZXNhVvYTHCNMGNDNUXv6b8SbiysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755408370; c=relaxed/simple;
	bh=mA13B3Ao60GIm73vIFzbEUkWO3GTHwpdVETD4PRXrZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BVEVZpTZOBvwuL8X41iEFdUMCWqjz2O0Ib9vvVRaWyws6lY5Rt7gJKuMjqlyi5hPzHRFNBKYhghrybgcqJsqBq/4JETdOTRjppv2kQtUJlSdpxgqxtFrY4QStT4LWMvMBswDQvi/DciZjfcBiFl3BGHVe1N6t3G95tQinWDir1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJeLQ77z; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24458298aedso26723475ad.3;
        Sat, 16 Aug 2025 22:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755408369; x=1756013169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sa13zN0S1ZZT60WrBhxIALrAJrIW54PMQ9SbvE2ncM=;
        b=cJeLQ77zqnslPCNmfU0AqMI88DQpML1k63Q3KwUQFAQZCYgHsMm0fsOVoTyTbykypo
         S2fsKB3Z+oBRBwWVgFBhtxVnTi5aRoSPEJtR498zXUfySt45TIUVVJZ1oBg6uRg4HyDt
         LGUhW3RLOGIgEq7Fye1g7adS9p7qEbq5Fb2BVKF6w8loki7kMIEmBByNse0d4IHx6blG
         fIALB/ABqVQj1tylHgpipQAk98tf5FwNte08lbxmZUeQNHlugoqs1vqJWs2tpj3Wnzgs
         ERpk/31ioZdEP6ybkbt5izgOQVXp+6EAKGF9nVlByh4AOepss4mRytHWPZy4BkNPS9HB
         fmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755408369; x=1756013169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sa13zN0S1ZZT60WrBhxIALrAJrIW54PMQ9SbvE2ncM=;
        b=dI+8YcKrlIPtY7tFAhA++mJ/jIBU97Vqm7rjrLoWfsfBiyX5NZ2NhEKjeSRZPyhqog
         GaaJh9v++1KN1wsfT5OQCF1gbo3IWuZ5axZzPWblNmyAmbXqwG/WGQJd8E0XY54+1WI+
         MbeXOagaaeP/W2q/V+lW/DN6r51nhAOgOoi3+g9qmCfb3JJOVmsiESRdfYgprRy4Muek
         32sATwM/fuFIMHDpppoxC2rsnrZpwoT5tZedgadGhOIXa+YbXeDt2xI1ZctNXIr+gofc
         N0AjRrI8LkOumQO5+IXvJWT6yzUoxBHxdwW4YF1ZQ1i9TzyeG6L/8gPR5TCpNoQc7Rfe
         cBRw==
X-Forwarded-Encrypted: i=1; AJvYcCUc5vDyCXIWGbAn7rZ1+fYf7J/xN4TAv9bdHyBkzZiirb/YRPs7HFEtcmb1mjXguSy/u+yOMRKwudMrnfFOd+vR@vger.kernel.org, AJvYcCV6m263zdcMSIpJnJl72zXSi5JEZihUBNui4EwTs9vcz/GGUDln76B8FEnCG7dMkdyaomoM65+pliy250w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQvbJciZ4UX7GDzV5ewS0FBvV5hawV1NM84VHRzhGL1b20q+sE
	httve82FD2jq6K2uqUknOMmi5pJHpe+sq3/asQBhaeeTjPLQIhIjfZNR
X-Gm-Gg: ASbGncuR50tZ7t05HcWXMHkNDnVWjuVJLVpcMgaTAa7KpUwAmlVCOxqBmz/oXvEwyPj
	w6+M89rBfGtbI4upuNnnVNVsquFEhI+SIRZgPXFySchnZcWKu18gygi2d2MYX4OUniiooplfCF8
	9b2wVMWZ8PFGAmIY0vecEgRFJTFxJN05DkNJkgQUNG4IDZ6d/NAyofSU6v71HtgGdRQccwQfjVs
	IbitNTs3AHAYzC3P1Zd7V4LAwWDChLd5i0+jJsDPfH4uPaqlMGrB+6c6IXLj0sHC90oLjyQnjW7
	J5fAOUENn6BJW/O4gVJkj5n6+j/nTmlTmM8aSzB9Lz40F+ZNuyZH9HdnByCzqjRqhV8iqlVdIKL
	Rqs8GpaRn7Rz9TFWmsGA1wFEhmYq2XaUbSmUQm/j7RLkIgd/QRGiX
X-Google-Smtp-Source: AGHT+IHtIqiE8tKlhMXE2qxS2ZYVqePYlVExN8CDQA3pcKM3jIJ9iKgzjQ3BjPsu7v0SQMmcXr8yGg==
X-Received: by 2002:a17:903:fae:b0:243:8f:6db5 with SMTP id d9443c01a7336-24478edad87mr56831225ad.6.1755408368594;
        Sat, 16 Aug 2025 22:26:08 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d003:7033:ad1b:5a79:43f0:e247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d592448sm47417625ad.161.2025.08.16.22.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 22:26:08 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH 1/3] kselftest/arm64: Remove extra blank line
Date: Sat, 16 Aug 2025 22:25:50 -0700
Message-Id: <20250817052552.8953-2-vivekyadav1207731111@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250817052552.8953-1-vivekyadav1207731111@gmail.com>
References: <20250817052552.8953-1-vivekyadav1207731111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek Yadav <vivekyadav1207731111@gmail.com>

Remove an unnecessary blank line to improve code style consistency.

```
[command]
        ./scripts/checkpatch.pl --strict -f <path/to/file>

[output]
        CHECK: Please don't use multiple blank lines
	CHECK: Blank lines aren't necessary before a close brace '}'
```

Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail.com>
---
 tools/testing/selftests/arm64/abi/hwcap.c       | 1 -
 tools/testing/selftests/arm64/bti/assembler.h   | 1 -
 tools/testing/selftests/arm64/fp/fp-ptrace.c    | 1 -
 tools/testing/selftests/arm64/fp/vec-syscfg.c   | 1 -
 tools/testing/selftests/arm64/fp/zt-ptrace.c    | 1 -
 tools/testing/selftests/arm64/gcs/gcs-locking.c | 1 -
 6 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 002ec38a8bbb..27d4790c2f0c 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -55,7 +55,6 @@ static void cmpbr_sigill(void)
 	/* Not implemented, too complicated and unreliable anyway */
 }
 
-
 static void crc32_sigill(void)
 {
 	/* CRC32W W0, W0, W1 */
diff --git a/tools/testing/selftests/arm64/bti/assembler.h b/tools/testing/selftests/arm64/bti/assembler.h
index 04e7b72880ef..141cdcbf0b8f 100644
--- a/tools/testing/selftests/arm64/bti/assembler.h
+++ b/tools/testing/selftests/arm64/bti/assembler.h
@@ -14,7 +14,6 @@
 #define GNU_PROPERTY_AARCH64_FEATURE_1_BTI	(1U << 0)
 #define GNU_PROPERTY_AARCH64_FEATURE_1_PAC	(1U << 1)
 
-
 .macro startfn name:req
 	.globl \name
 \name:
diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace.c b/tools/testing/selftests/arm64/fp/fp-ptrace.c
index 124bc883365e..3dc195f977ba 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.c
@@ -1569,7 +1569,6 @@ static void run_sve_tests(void)
 					  &test_config);
 		}
 	}
-
 }
 
 static void run_sme_tests(void)
diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
index ea9c7d47790f..2d75d342eeb9 100644
--- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
+++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
@@ -690,7 +690,6 @@ static inline void smstop(void)
 	asm volatile("msr S0_3_C4_C6_3, xzr");
 }
 
-
 /*
  * Verify we can change the SVE vector length while SME is active and
  * continue to use SME afterwards.
diff --git a/tools/testing/selftests/arm64/fp/zt-ptrace.c b/tools/testing/selftests/arm64/fp/zt-ptrace.c
index 584b8d59b7ea..a7f34040fbf1 100644
--- a/tools/testing/selftests/arm64/fp/zt-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/zt-ptrace.c
@@ -108,7 +108,6 @@ static int get_zt(pid_t pid, char zt[ZT_SIG_REG_BYTES])
 	return ptrace(PTRACE_GETREGSET, pid, NT_ARM_ZT, &iov);
 }
 
-
 static int set_zt(pid_t pid, const char zt[ZT_SIG_REG_BYTES])
 {
 	struct iovec iov;
diff --git a/tools/testing/selftests/arm64/gcs/gcs-locking.c b/tools/testing/selftests/arm64/gcs/gcs-locking.c
index 989f75a491b7..1e6abb136ffd 100644
--- a/tools/testing/selftests/arm64/gcs/gcs-locking.c
+++ b/tools/testing/selftests/arm64/gcs/gcs-locking.c
@@ -165,7 +165,6 @@ TEST_F(valid_modes, lock_enable_disable_others)
 	ASSERT_EQ(ret, 0);
 	ASSERT_EQ(mode, PR_SHADOW_STACK_ALL_MODES);
 
-
 	ret = my_syscall2(__NR_prctl, PR_SET_SHADOW_STACK_STATUS,
 			  variant->mode);
 	ASSERT_EQ(ret, 0);
-- 
2.25.1


