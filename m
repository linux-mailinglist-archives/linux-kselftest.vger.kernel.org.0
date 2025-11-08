Return-Path: <linux-kselftest+bounces-45189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E891C43405
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 20:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1203B310F
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 19:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FE82C08BA;
	Sat,  8 Nov 2025 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7N+cVwj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C328980A
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762630973; cv=none; b=MHtsYRUYwWF8Air1PIhniod13HAuuJJE/9dufVYm94k4aRI7MaZbEPadYF6kFzD6eaOhEmj75qMFPAqevtosefY8PF285R8bONCSGSaipdykDzbGT6cVx2aiMAY2NZz4hMCGoZGQkO/3+Jdk06JaICj3GllTY/T/X1C7drWzgjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762630973; c=relaxed/simple;
	bh=64Du9MW22FfTvN63C5fwZkWDNPLpH2Ur7/TuPEg0FcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNo4C3jrQ3/fqrYVygZ709fiTV+bgTcedTegO0RNE05pQeHP3TY69Ovg8FxxgB9npnao0t6UCmoe5M88uNKrEGkwGZAqSK5kj/ffIpImzbbDcNf1mVsTsf1ZMURHX1j0MGOxfS2ihpzMAx5jURRdO7m/3XRKzFZ+7Xy5fRyiyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7N+cVwj; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3737d09d123so22089561fa.2
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 11:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762630970; x=1763235770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRJxeXvOiEogIO9xMq6Bi1gey4v1YC+eoeXUVhZk5pE=;
        b=i7N+cVwjFi5MEx7AHD8yGShaTnrVoMyKPWgZ2l8KZzNg2lnJuRUPP+o/Mg0JdFwQ70
         Scho5JTcv6mQb6G1UFvxFC5FO9P0uV5zamiiwLQTSFZVriMnmryrvUCpowPKZfA6JKBa
         ADnEUnLFONNPVDwzGe83qU3+FLryP4/ns5ZPDr/pH69gJ2vKzE3com2X0bMQu8mQ33n+
         V14ZieUf/CoFXdXeNH2t3sO1ALXPeHrbRY9DHvO+IddmK8BC0ZLWN6Et9c+PFcRin5gQ
         0SX478PUX7gexJvWojZwDRpJKh0uqqNUWkXS6mAqK/hrF2e6Sesx98UXn8ih+qE8sKmw
         ZPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762630970; x=1763235770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YRJxeXvOiEogIO9xMq6Bi1gey4v1YC+eoeXUVhZk5pE=;
        b=YBqCpP2NvwZDmko7t67D2jhDFInSYex/qbyjFpIhAO1H+qL05+PpOEEeL/pv3jii6A
         +tNlS0/Qb3f26Twc/RBFFTzryurHd+GDgc40bUJQZ6LoEZfeyq8X6Ce1cavRnJVGFfLN
         8C3ebISgUsRf8gyx4hM2MWTobcoiHyqmSMI9HX0Nni8zEBkF3rd4w8Zy6+G9h3zuwUsN
         noPChSkfAgJN4NA0CEPUW/xYZ4btrY5qd3fwNJugtNhTWpnzwr50UUe1+w6hKITSU88Q
         VGc2eS246aiwCmsJDbuNZUuU74jwaVE5Zl2JTC+5YG1kuXu3kgyvMu6F0rhye8Ex2JLD
         Dcvg==
X-Forwarded-Encrypted: i=1; AJvYcCUOcdisUim50fFPPrEBBBs256UEkAuktTA53C8t+Gm7C2KUGcNeAN0Hk2cpEHt2d/G21YS/7b4S+Wqtjj8EOtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe8czE4w5SD/GRrnPUvJhdA1l+1x2JZW8CCS/0VCPcGQYtRALY
	MVEBKtu1OtyEnFzpZWAzt2N1IcemTf5ppDKhpuPWEM3fDAStV+gVJSs6
X-Gm-Gg: ASbGncvRVfndn0Q0QMmMXZ8U2g366s0ykA7kXR0xWJbVSjt3z+j8KP10KusNgdeM+dR
	JQQtS+W0oOIVUcgdqpi4t9rVeGGl2KWJxzwygU2Wsv6XywBfLn81a3pMpfH1WpoFoN99K2g6xPa
	61EpVYJfglTnDQxlUZxnAxzLd7RZ3/V49m259CEbt64UYsphAfI7HRo85PcJMey+L04bOeV60TK
	YrgBRbJms5OvMqNbJd1f0XCsc2DCR6v8XDbFWV125xGxRRcUsbK8ClNua9w1D2EeuSsds7Jslwh
	IQUW/myg9LHGMS2ycKw8ClqnaI011RdfoQkpslQxlqC6oW2L1RM0Tuo8mQq8Y8oYlqxNfbw5Bdb
	MGYj2LRJ7o66DlljNn3r+tWXtfcU4gJl/ZdV1C8gXJqKCJs0afGCOuBQAK7COWHIXZUo=
X-Google-Smtp-Source: AGHT+IHlXDkvQRgzPuEt7DV3+vhlIfC3x/SoxFZdZvSyimgEP+WQTvBDKtkfBp3OnBFK8ucxkWoPdg==
X-Received: by 2002:a2e:86d0:0:b0:378:cdf0:ad51 with SMTP id 38308e7fff4ca-37a7b233aa5mr7561051fa.24.1762630969620;
        Sat, 08 Nov 2025 11:42:49 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-37a5f0edac3sm22115421fa.38.2025.11.08.11.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:42:47 -0800 (PST)
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
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v4 9/9] selftests: riscv: verify syscalls discard vector context
Date: Sat,  8 Nov 2025 22:41:48 +0300
Message-ID: <20251108194207.1257866-10-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251108194207.1257866-1-geomatsi@gmail.com>
References: <20251108194207.1257866-1-geomatsi@gmail.com>
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
 .../testing/selftests/riscv/vector/v_ptrace.c | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/v_ptrace.c b/tools/testing/selftests/riscv/vector/v_ptrace.c
index fb371a42de15..d4e947c33f75 100644
--- a/tools/testing/selftests/riscv/vector/v_ptrace.c
+++ b/tools/testing/selftests/riscv/vector/v_ptrace.c
@@ -183,6 +183,113 @@ TEST(ptrace_v_early_debug)
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
+		unsigned long vl;
+
+		while (chld_lock == 1)
+			asm volatile("" : : "g"(chld_lock) : "memory");
+
+		asm(".option arch, +zve32x\n");
+		asm(".option arch, +c\n");
+		asm volatile("vsetvli %[new_vl], x0, e16, m2, tu, mu\n"
+			     : [new_vl] "=r"(vl)
+			     :
+			     :);
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
+		/* verify initial vsetvli settings */
+
+		EXPECT_EQ(regset_data->vlenb, regset_data->vl);
+		EXPECT_EQ(9UL, regset_data->vtype);
+		EXPECT_EQ(vlenb, regset_data->vlenb);
+		EXPECT_EQ(0UL, regset_data->vstart);
+		EXPECT_EQ(0UL, regset_data->vcsr);
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


