Return-Path: <linux-kselftest+bounces-44054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5FAC0A023
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 23:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E98E53479BC
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 21:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB83330B527;
	Sat, 25 Oct 2025 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do8VN5io"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134F30ACF4
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426453; cv=none; b=p7NEq2yAVM52vWCYw0nwJeC9G0w3dkug+j035Xau7z5L0Ngg05VZ5NS79rNk0m1amQs8kfdO2ISFixilRj3DkE0CJWwkoGKro1NG6MnKlXnp4zHhEIVMMBDCUwyprtVikh3JQKQP0a8GGiy3eWOzYnNbrOs0ozPGu8ZttDUiYy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426453; c=relaxed/simple;
	bh=2E3Fo1znPlzaabZKXzSWEg4Z8coek9HOIOj+q4wvYWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOJ5PsvPZj6UqJpuoBXk0h2yFVPB/rZL/avbnhmJNs6u9uBerf2+WmgEMRKrjlC4kGSfyKRKG1vY4HGSmwClcdpywIOBFe1qTtlHk9zvTuDXQAYs7NWAkVAFqAUiOmUHCi+4d16MkbOGg+WoyddKWyHYAz09Xnee2nPX4lganAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do8VN5io; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57bd04f2e84so4002704e87.1
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 14:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761426450; x=1762031250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFxB+FMNooBfOd2zLjcq46e2Dj/CD31Cyo7lUKy84vI=;
        b=Do8VN5ioaNOWS4a0lJKbTZXM4HBIM57HRFoUvovOoH/Kr9MdFeHLwjpzy1jnHzeq4m
         CyuRXe0oBJeitLMSSnUpu+SrhdYy85Qw0ld1gId3Qkd98xEd6GdiQ9Qy+xMZmaFIlyx2
         Zer8QLG+lIhqX9wl+5YxnZcreHzTY8Qc1PaFUbdpk8cUpTEQphKEexumrfh8+ytujYnd
         rgFlIa+L9MxHzE7rQjp9w2aJV5u24DX+l8FIN+JlPhmCh9LiSTfj+oC5fARBCwDRUS7R
         9XJrfTPVWKc/VzoB1tKn0HyfNcxy7iQNpoYA5/4wWn8/bp6HTd+6zaypV64ykXl01Zgw
         DWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761426450; x=1762031250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFxB+FMNooBfOd2zLjcq46e2Dj/CD31Cyo7lUKy84vI=;
        b=VtorLOJ+VkxmssGMr/ZeENrT8dsuUucVrgHV0aZVDrkAJ0yclAZ8JcPFe5Kc5FkS6U
         xjHMxcGiDQuhLGrfTdwTlcQVF3fi461ce1U79UV/ao6ajs5Ae04uWIvX1ynj8EKtHKRR
         wHJE9V2inK8+5GQjAB0nn+E4p0sWZ9uhRG1q6Tpp93WmmFoUoA7Jx6VBE2xmmXVEYDej
         LLdXYWt0woYHw8Pt6WQCy+KDtOH+tNFe2EdIEnUn6yXoKeoODxYGpyA0va/Tuh99UwVo
         AIFTWI/aZqBreEEWegrXELodLrPOVqYBV5abccNEnc8wSz5INUgwoVnOq65wDAAFWgVX
         pJNg==
X-Forwarded-Encrypted: i=1; AJvYcCVLReCbrCO7WDiTvywzR8RXJROrnE1hKv+jIiRAI6V2E8mz6Pqku11bFrpWFK/el7wlPv/J5GqbZVxIRqeWZmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuj2+r/avTS1dXBG6PEqrhHaV9UD/rswL50nPxQ9ALj0LdXas8
	NZNw5L9MlVPjkCSDrmvbO7xNWOVacSjO/TVnDNIxwsFFRYPL7ytxmBpv
X-Gm-Gg: ASbGncvBykbU8GSWQ5p6NRlZgyOrvgpGIgY3MFpg6QExcMV+jAu8ZOyoEv+CMqmmaS1
	NZbQCVXWgwNzFZOa60NUru62vZihcgvYb32w5/nnS/VneuJSWKQoOwRJL83V5xOhrqf1Qgx8Ek3
	dxGpZCHDeiVIIwS1Q0EVZ5Z2siMGHRlcB7Iwx2YIw2o2mZ/f7mTuk1cbKq/cZCi7lH3Bmq7xnYL
	CEjivFXJZYAoLkuq5pEO2h5g4yWzcW8dtb3oUnv3eaqwB7/FyDcVDugxfpb8/9p4eVVCY0QR9kj
	Lrnp2wee4MEBNDbsaord4BUsIAAIKhvEhJ5PBZ+PgzXDjh5YRLnaxbEoFL/5voQ9yXueRvvHe3X
	AIiBWImoy8uqMc5G/tWrcGH1eVXl8/jFG4WFRcv9tyTTw/THvQxNrpfQ+MfmMXpwLP0w7CbsH/l
	8ULQ==
X-Google-Smtp-Source: AGHT+IGWWrc4WdF7FX7lRQrDMuhwqAOXh5C+jquwBNySEwQCE3G1DQMT0DRSQnyd9anBGi35RkN5AQ==
X-Received: by 2002:a05:6512:308d:b0:571:8fad:ecee with SMTP id 2adb3069b0e04-591d850c0efmr10901687e87.21.1761426449935;
        Sat, 25 Oct 2025 14:07:29 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-59301f840dfsm953644e87.104.2025.10.25.14.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:07:29 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Joel Granados <joel.granados@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v3 9/9] selftests: riscv: verify syscalls discard vector context
Date: Sun, 26 Oct 2025 00:06:42 +0300
Message-ID: <20251025210655.43099-10-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025210655.43099-1-geomatsi@gmail.com>
References: <20251025210655.43099-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to v_ptrace test suite to verify that vector csr registers
are clobbered on syscalls.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 .../testing/selftests/riscv/vector/v_ptrace.c | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/v_ptrace.c b/tools/testing/selftests/riscv/vector/v_ptrace.c
index 7e8fdebded07..51a7cc71b2be 100644
--- a/tools/testing/selftests/riscv/vector/v_ptrace.c
+++ b/tools/testing/selftests/riscv/vector/v_ptrace.c
@@ -183,6 +183,108 @@ TEST(ptrace_v_early_debug)
 	}
 }
 
+TEST(ptrace_v_syscall_clobbering)
+{
+	unsigned long vlenb;
+	pid_t pid;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
+
+	asm volatile("csrr %[vlenb], vlenb" : [vlenb] "=r"(vlenb));
+
+	chld_lock = 1;
+	pid = fork();
+	ASSERT_LE(0, pid)
+		TH_LOG("fork: %m");
+
+	if (pid == 0) {
+		while (chld_lock == 1)
+			asm volatile("" : : "g"(chld_lock) : "memory");
+
+		asm(".option arch, +zve32x\n");
+		asm(".option arch, +c\n");
+		asm volatile("vsetvli x0, x0, e8, m8, tu, mu\n");
+
+		while (1) {
+			asm volatile ("c.ebreak");
+			sleep(0);
+		}
+	} else {
+		struct __riscv_v_regset_state *regset_data;
+		struct user_regs_struct regs;
+		size_t regset_size;
+		struct iovec iov;
+		int status;
+
+		/* attach */
+
+		ASSERT_EQ(0, ptrace(PTRACE_ATTACH, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* unlock */
+
+		ASSERT_EQ(0, ptrace(PTRACE_POKEDATA, pid, &chld_lock, 0));
+
+		/* resume and wait for the 1st c.ebreak */
+
+		ASSERT_EQ(0, ptrace(PTRACE_CONT, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* read tracee vector csr regs using ptrace GETREGSET */
+
+		regset_size = sizeof(*regset_data) + vlenb * 32;
+		regset_data = calloc(1, regset_size);
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* verify initial vsetvli x0, x0, e8, m8, tu, mu settings */
+
+		EXPECT_EQ(3UL, regset_data->vtype);
+		EXPECT_EQ(0UL, regset_data->vstart);
+		EXPECT_EQ(16UL, regset_data->vlenb);
+		EXPECT_EQ(0UL, regset_data->vcsr);
+		EXPECT_EQ(0UL, regset_data->vl);
+
+		/* skip 1st c.ebreak, then resume and wait for the 2nd c.ebreak */
+
+		iov.iov_base = &regs;
+		iov.iov_len = sizeof(regs);
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov));
+		regs.pc += 2;
+		ASSERT_EQ(0, ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov));
+
+		ASSERT_EQ(0, ptrace(PTRACE_CONT, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* read tracee vtype using ptrace GETREGSET */
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* verify that V state is illegal after syscall */
+
+		EXPECT_EQ((1UL << (__riscv_xlen - 1)), regset_data->vtype);
+		EXPECT_EQ(vlenb, regset_data->vlenb);
+		EXPECT_EQ(0UL, regset_data->vstart);
+		EXPECT_EQ(0UL, regset_data->vcsr);
+		EXPECT_EQ(0UL, regset_data->vl);
+
+		/* cleanup */
+
+		ASSERT_EQ(0, kill(pid, SIGKILL));
+	}
+}
+
 FIXTURE(v_csr_invalid)
 {
 };
-- 
2.51.0


