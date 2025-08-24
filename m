Return-Path: <linux-kselftest+bounces-39799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 224EFB32DB5
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 08:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFCF205290
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 06:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14EC23909C;
	Sun, 24 Aug 2025 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MERYW8S2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F7423815F;
	Sun, 24 Aug 2025 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756016078; cv=none; b=ClJ2IpGTdHnrebxru/eqO4L2uUYK3bBgdGxfgQTCshxqVWudgACaeSp2N2JBrSZOnHnWQn4aH11yS+eobtM4V6FE2UeCLf9xwc+i32LlCqa3ttr1vcvY9ArlDG7S35gboN10BL/eDOj33L4lqvNyCnk6zpqUQsS9KKIHeJB1RqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756016078; c=relaxed/simple;
	bh=mA13B3Ao60GIm73vIFzbEUkWO3GTHwpdVETD4PRXrZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jBvauO6FJzA0Nad2ui5Yy6Joe8Wf5/orh4QB+zA4UBI/EoLXz0ut1CeSMJ9BeKOxe0tdTggv2Zya8xbwtt7CuQv+RmZZaav3zMKn7dj3D4X+L8aqw+w6bFoN/N3h+dczDd7i15gGaeZMH+FoAkcXgrQDfmoJ0Nt3+pGqrmqnwO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MERYW8S2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2ebe86ecso4161392b3a.3;
        Sat, 23 Aug 2025 23:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756016076; x=1756620876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sa13zN0S1ZZT60WrBhxIALrAJrIW54PMQ9SbvE2ncM=;
        b=MERYW8S2xYqyL00JrNcWEZPrhbgiE0r37m5cVSq9IYKJxvSWH74qRjulwnqcmK0hWi
         BKyFf4qLmCEkOjAc9sKsl/2DJ7h9WLYq7SkbEknj9OP4wXqxqn4ZS/M1FHI3Hc4cUImw
         FKt+3zZVeVrJtKuszVv7fR/1IDlEiOfD9jc7NbaunXvPus2VZKB+kN9YnOkShDrs5aMV
         QxEMflOjXB9l0AnsYiqCwLUNpf7hOlbA7qoedtFFvuP3S1V8g/kgdYV1DQ1rMD5bfcN9
         o+rhKNgLJOsw/lkOZ5Lv+n1lfjeJL7IuVp+nGAaWaISYXUVp8SbPsXeOEkTJLgHwJDGh
         UFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756016076; x=1756620876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sa13zN0S1ZZT60WrBhxIALrAJrIW54PMQ9SbvE2ncM=;
        b=LofTv0ieauEaHIpJSRjwAJpdV5vIBuzw0g9k1Cp9h5/7IXmJwyKfQxazCs+n0MXA7Q
         4Mr5HBuQBR6A1VrZCrfeVw8aIhiEjgi1PjuKzQlEJplfte/lO3XZdkH4X9Ci3GOcS+zB
         FuZYVBhasoqAjKDRUb+oY4xLm+8TL3MkqC5RNlCOh6M4T5xM5Zh86PwWPx6SdjHcM4jL
         NdKJWj0FdNrkDPXmJ980t80nVWVTXT0FkUwD+jkn5xrTo5MxFQChXIAwnumDxGwaCdmU
         O8zg+Ze8ALH9yNksj5PMj0+g5bvBvXUaQAd+J/9+QF71CXKC1OUuaKWc5SVTT1BcsCuK
         5HOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL96YRcBhVstawqra1zp7C0o2VpbfyeHzYCsbmxqmrgU5+aIi4SFgBqh9GTdxnmUrf/xbs7hMjN9g=@vger.kernel.org, AJvYcCWqSTneZtr0CSc8O0KsGZQ4fdfoJoszRRXZXfbfwlR1K9ndpNEdvYAAbJdLVgqc9WvvkXKA2uZT7UghBDPh@vger.kernel.org, AJvYcCXKKiM9KZcJHcF1e7lMo/A43Ttlgm73Egfa8XCNe9XyafbUhUcNAnwQUAS9DrRuLUk9w4b+sEENO7ZPlZZRneRq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/bZ8Cxd29LJlv2QF05gFMuPpCawFb1L/N288bGO0aXTQtFosj
	1N0kB4FnbQG97yPxRBKrYc3bJugpgURMmF8keWbYO45RLlZWyEf/dqdB
X-Gm-Gg: ASbGncvd6bcAwvd+KzX6Al+MlRnrcgAtr46VafTl32l5LaGb+cpCttLMmEAvUihBF9c
	2u9pPNFyXbLBTZOXs9/oPjo7Df17xZZ5tGlfp66GVGIIZj1Obc7brCD+07a1xYoYOuTAi7wGu3w
	tHZry0hX30Gf4N/mPOb9euzDt4yU/1r8f5iU6TW8tRg6HOTR3P3AnZqqdexFIEgxOryAgk+wF9N
	FDAIdz2nHjoawjfeIQo/+TGuXOnvPUqN8hO8qHV6/14+y7sHenlmb4vW/c+Mcm3aTfVm9aaSQlx
	gbkvumW/hgIkG10csBwGTCSql/vTF265IFo8XoRZLh1F8WobH+ZTOBOWXDWjvJ56wKp8/CLiY7x
	qM09IgkKs8kX9t7DYh+aLJeBV/0b28KgJdFr/YYqEcRzNHyzc7aIE
X-Google-Smtp-Source: AGHT+IGf7w3aejcMRspW0BPyWAdmCLwYhnOhUhtrCW6ul7LU9ibd0rIlZWCizAKLWAF8pA93qJtU7Q==
X-Received: by 2002:a05:6a00:138c:b0:770:2c2f:6435 with SMTP id d2e1a72fcca58-7702faafbcemr9453653b3a.20.1756016076256;
        Sat, 23 Aug 2025 23:14:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d003:7033:ad1b:5a79:43f0:e247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770529149bdsm1654943b3a.98.2025.08.23.23.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 23:14:35 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	corbet@lwn.net
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-doc@vger.kernel.org,
	Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH 1/3] kselftest/arm64: Remove extra blank line
Date: Sat, 23 Aug 2025 23:14:00 -0700
Message-Id: <20250824061402.13432-2-vivekyadav1207731111@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250824061402.13432-1-vivekyadav1207731111@gmail.com>
References: <20250824061402.13432-1-vivekyadav1207731111@gmail.com>
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


