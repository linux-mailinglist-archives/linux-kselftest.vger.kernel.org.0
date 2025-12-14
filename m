Return-Path: <linux-kselftest+bounces-47571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2FBCBBD9F
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 17:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B0EE30255B6
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B072DF136;
	Sun, 14 Dec 2025 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iotPhTzD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A137A2DAFA2
	for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765730162; cv=none; b=N4dHNGQF/Dqe5MjMqZ42omz9VIDElWeqpQoSOMC8pkaLsj+thyYd0mD7NL1tT1NmzDMs7W3Xi15+5RjGcD7cKMhO+RbYRVenLkyzomYgkHTB+tOA643mq8iZaYsRNPnVZ/2BPbfLuiP5ORjwuf64ou8KergWvRP0ZJJUGroL1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765730162; c=relaxed/simple;
	bh=2eEQZz/X3mmmeyYnUcAby+qiIw75bPh119bXdDlu4Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DilC54OmkVkjP9D3Iefkwjud2Mw7Vo7gc7IkxBcWr5KV6bw+8P82JVE4fjLV7JjL35yc3/VpEG03mAHvDVw3AnWWctgLMyny1prqskTscIDher2IvdGlAvgqcIhMo1TziX4GfaGgoz7NDxDzXocmGXVOw6PiiYuPpd86TQoLU6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iotPhTzD; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5958931c9c7so3330301e87.2
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 08:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765730159; x=1766334959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLvTGAt1jf9FADXLFeMcoHBdGn1FeJvj5K58j/U4zDM=;
        b=iotPhTzDf6MQuvwre0i6+IZP3EbswUC92I3I4P5hwxugQMw1wECKpRqrC9zBO4cMtR
         IGjWuS8de3PUp3LZykeA/+/ygs4qCwtrc4oKDoyu1UgktOzo2fpnPB04+wGqMmb780rU
         IwWaaNDAiJFDlAo9FHWB1abSPxxrl8d9BCIqSaDJG7KKo+ax/SI+Z9JNDFVkK1krvbLT
         TqMisstm1ZU2zi0h3JZE/E3ix6x4u+E3YK4DVgFWyHK0n0kNpCErBD3ymDi6thRu9iLa
         fNJ839guX3MVVJ8amHAfAWR1XwLnXnWhZar4ZqEPtcy+4+tX0Tzmw5FBscR8lIzBj/CU
         fRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765730159; x=1766334959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLvTGAt1jf9FADXLFeMcoHBdGn1FeJvj5K58j/U4zDM=;
        b=V1WGBzu7VsS+AJshqVrrR24VRnMdpnU/tXO1XYiAReBZpbk3+b8pQzvLOQlvYUI60w
         psICQMu8UEJcEmsnsuTlcIIKRJNpJV/Z4ItqRhKoVzyeJCTWVlkK0tww6vHLu/pU14y6
         2o5IOh0RfwgfPBoo5BAjvQmPE1MlQKQiqvGTMr843s4OSsvoKyspweiIaCvFGE+pUwZF
         sn+sjSeSyQBxtOIeb71s4v2hWN/DyDId1k92BqNAqIdSMYCeSE5RnEsf0rwUEPWLFou5
         iD7gzKwFvtsAmWWCMhEYMv+7Zh1n7//LISXGX5jlx/chdWNfHAzesBG6/F9ntIi4sbPZ
         jaUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW68zqXH/jwz9FHTS9R5rQPyDepNQcUSqnCmqG8E2rPPsoqgZp+8vSKmIXhBQq+yg374HELOeM7k3PGkBgHx0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYqhbeb6fawWtEqvP/tfDYf/AkhJwe39zQ2pfwiHfBy6pvamP
	HFzA7s8P+yQ7Mj/fjLDutb+K5Mx97w7GOzmKKY5pBEesV9YI+UPu4N6K
X-Gm-Gg: AY/fxX7B/EqeZdE927OoQf94AWhiq8iBgeFewkDnreymkwNinRbRCrusqaCX30Z6M0/
	RMjKFJ8W5/uD6jLncM0gpytrGRq82PzFU635U9nEppUuIkqyy9l8ZFBDkKgRThvHDoBOBh1gE3R
	nLoGhT3pdigfcX1MUB85baPBT/Hxk57EBqxAm3EmfNuwLOJE7dviN6enKwyWrXlwRlRUyCsZ0H+
	cesY4PWcCWB9nogJqSua0INAcXjBI1GgaztBSDXWb6IfoCu6x3lmFyzgjzCJcG9Y6mExNndpO7K
	7vK3iotvgaDO1Ekl1cpS2qvxFiZZLEg90lKjtorlC61r85f8tyNH0nGAvwkUr6CtwGS6vZrpHCT
	TqknAtXNIgjyNPy5xacRCCURbI/Wj7i+ro0mQGH2GhiObIVPpcttROhN0VJCOJMAf0hx7Rtx8lt
	eLnw==
X-Google-Smtp-Source: AGHT+IEMgxSe+xOjvGBPNy2ALsapXgkNGgurTBHru15sXVWXKkYyH3kcS5UntnGJK/O/jOAOqloXjQ==
X-Received: by 2002:a05:6512:1329:b0:594:522d:68f4 with SMTP id 2adb3069b0e04-598faa80f60mr2571650e87.28.1765730158483;
        Sun, 14 Dec 2025 08:35:58 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-598f7717b79sm3789618e87.60.2025.12.14.08.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 08:35:57 -0800 (PST)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
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
	Guo Ren <guoren@kernel.org>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v5 7/9] selftests: riscv: verify syscalls discard vector context
Date: Sun, 14 Dec 2025 19:35:11 +0300
Message-ID: <20251214163537.1054292-8-geomatsi@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251214163537.1054292-1-geomatsi@gmail.com>
References: <20251214163537.1054292-1-geomatsi@gmail.com>
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
 .../riscv/vector/validate_v_ptrace.c          | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/validate_v_ptrace.c b/tools/testing/selftests/riscv/vector/validate_v_ptrace.c
index a8d64d351edd..2dd0c727e520 100644
--- a/tools/testing/selftests/riscv/vector/validate_v_ptrace.c
+++ b/tools/testing/selftests/riscv/vector/validate_v_ptrace.c
@@ -212,4 +212,128 @@ TEST(ptrace_v_early_debug)
 	}
 }
 
+TEST(ptrace_v_syscall_clobbering)
+{
+	pid_t pid;
+
+	if (!is_vector_supported() && !is_xtheadvector_supported())
+		SKIP(return, "Vector not supported");
+
+	chld_lock = 1;
+	pid = fork();
+	ASSERT_LE(0, pid)
+		TH_LOG("fork: %m");
+
+	if (pid == 0) {
+		unsigned long vl;
+
+		while (chld_lock == 1)
+			asm volatile("" : : "g"(chld_lock) : "memory");
+
+		if (is_xtheadvector_supported()) {
+			asm volatile (
+				// 0 | zimm[10:0] | rs1 | 1 1 1 | rd |1010111| vsetvli
+				// vsetvli	t4, x0, e16, m2, d1
+				".4byte		0b00000000010100000111111011010111\n"
+				"mv		%[new_vl], t4\n"
+				: [new_vl] "=r" (vl) : : "t4");
+		} else {
+			asm volatile (
+				".option push\n"
+				".option arch, +zve32x\n"
+				"vsetvli %[new_vl], x0, e16, m2, tu, mu\n"
+				".option pop\n"
+				: [new_vl] "=r"(vl) : : );
+		}
+
+		while (1) {
+			asm volatile (
+				".option push\n"
+				".option norvc\n"
+				"ebreak\n"
+				".option pop\n");
+
+			sleep(0);
+		}
+	} else {
+		struct __riscv_v_regset_state *regset_data;
+		unsigned long vlenb = get_vr_len();
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
+		/* resume and wait for the 1st ebreak */
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
+		/* verify initial vsetvli settings */
+
+		if (is_xtheadvector_supported()) {
+			EXPECT_EQ(5UL, regset_data->vtype);
+		} else {
+			EXPECT_EQ(9UL, regset_data->vtype);
+		}
+
+		EXPECT_EQ(regset_data->vlenb, regset_data->vl);
+		EXPECT_EQ(vlenb, regset_data->vlenb);
+		EXPECT_EQ(0UL, regset_data->vstart);
+		EXPECT_EQ(0UL, regset_data->vcsr);
+
+		/* skip 1st ebreak, then resume and wait for the 2nd ebreak */
+
+		iov.iov_base = &regs;
+		iov.iov_len = sizeof(regs);
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov));
+		regs.pc += 4;
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
 TEST_HARNESS_MAIN
-- 
2.52.0


