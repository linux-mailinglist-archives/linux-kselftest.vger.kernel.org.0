Return-Path: <linux-kselftest+bounces-45183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE4AC433DE
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 20:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E59D188CFFC
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 19:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8B728C5AA;
	Sat,  8 Nov 2025 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2vKKFne"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADC128935A
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762630950; cv=none; b=D15/YpM2ZHZ1erZarEPaMO7hLQPJp6ouS73LQexGZ51wCLInFruDuokIv2I21zQbvocL5KbkkwXxC1OqWpMzsAteOSvM8qhyWLjMcf+7xFMA5YRmnTNYRZJlFOo8NRtCGd7zzTWHP6seYKhicsesHMG+BjJZKz5aT3uW4ChBFek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762630950; c=relaxed/simple;
	bh=I+Jx6xBgH2zAab9TpH14gkeCgnP49zZ44qWiAaJu1NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YauQddvWSoRMJ74K4MN3ASSkOEXyqOX6h8SYmpPKUBRYb1RkwmIBD+CP+7NCRJsc8qzcDs/Uy9E5ulj4LetkSw/+omsp34k/LWuXriDlixNvv1aSD+OZDtF8aDzCXIlCTqNQ2zmetFtimEvimV4RTAXrbAzgHgIxoFmDHo2QYB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2vKKFne; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-362acd22c78so13700561fa.2
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 11:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762630946; x=1763235746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1z9oJMGhMkRuSJL42xb+stRjYj/XQC2rSAWX+erznoA=;
        b=b2vKKFneSGDs+7qrbALd1DAUlRC+Owueuzvpzk/ueipWEdCTs71yESThyImYtx4vHQ
         ol4MbnVoNVBKeN34rSQ8CBCgOB00thACryQ/+/EUsfU2ZiI7Zag/6jhbn5dPjbuwwKtF
         PiooNSBj/YEGEkDBpZQKeP3lwgUaNT/rUf+GYMOEYO5KmhdPLCLxDFswR1ni0j7Cx3p3
         GT/eJ2HF3Sa3h2sakm9ORen3KsdiyrOEi/k66Dx/CSms9ZjCDclMZxydSlSY2eA41TYI
         P+VnvAa7mp8Mbk0m8VPjA7nB7mHwfBg+xAtLgbPC3e55lkbKseRcGcDsbzwhCjMswUVC
         fpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762630946; x=1763235746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1z9oJMGhMkRuSJL42xb+stRjYj/XQC2rSAWX+erznoA=;
        b=ZEp3I+8sQOvrwcfjn2vJWC7zCPlP778ne2P7fCIYhvsJfmMYzM3yjDNZFQyt7gzXaf
         p3h3jNU6LVjAr3qQV+6F6RpO4p+9RIjf1ryvtV8rVr6I5cGSEi/xaLZtpVbsCyCEowb9
         rD9TsrdpXL+sU7ADDYbrpfRGZI15cyNHO7IFch1zY7rE1RuEIix8NoVl7Rw8OVzLEfDw
         PkmZelpl2VIUH+DfwGNx9LHAEbCLFwDXhgwZNuFZWtKAG1qWGrISoksN/wvXagTKAV/g
         2bx2z7niwDzsK9/9QfF9ugfdLu2IKrhC3+JL/X4S12x+h5xy0NWH+GWbj+a9FwxRszvs
         RT7g==
X-Forwarded-Encrypted: i=1; AJvYcCWQHX6x0a+3jLekqjDAUEmr40TW1xoE6/Yh4DaecgzlEiHeQBlE/7tnz6/2AJRwCOZAxcJsTIuvVp7CiovGnHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcOeR4oujtQxOZ4o/b6Sn1w8ly6JYMTewsf//gd3e4qZOpPO1I
	NSHglvK0EfCMOH3jRgYPN5ftTkEUh54yHrBFW1x2bnhXlMfiwYgEQ/aM
X-Gm-Gg: ASbGncsg1uAH9+1F/kDnSXU7aGbKgwa8GRCjCrqIyxbrhfpurV2z7zQGwpdjUgTedXw
	gMoKTIXsDr7XTN3d8ENiVwKete79vwgL2EKr6JhaCiW34Dc3hlpLSD4qR6QZNwTq+saHidk+5+O
	hvKwmaBgl7PdpbAfTZ8pgEF57OInO03fFSEncx4H+nIePjUUgP/hMY7S8AitElfQ53PQNuDzagv
	0Tv/xIJP7gmo6OrfRFuP8Q+ZqnvGXEB+cFIrnQAeCIDKPrnM/3/n2SIzpr4Q+vlTU7AFxRKlkiH
	/iPX/WCuvWQi3jumYggoABJwo/JhIkjMN2Zk4OjP8ea36Y0Syazpcb5XwpdkcBT2hWbHCRWrze8
	mkd3/4eKEiest6tLnHXVA85QDU10oYK7f0Z2n9R1K5biX93b7hCfDaRr4HgM8uqR9sVvpqnBV9b
	ocrA==
X-Google-Smtp-Source: AGHT+IFqruWPxQcVE5BSlkkAYUO3qtnystNc9jQjX4jqelXJHwKhoZh5DbK28uyPKpvnw5kWkw7ZbQ==
X-Received: by 2002:a2e:8653:0:b0:37a:36be:7282 with SMTP id 38308e7fff4ca-37a7b23fac5mr7888391fa.41.1762630946307;
        Sat, 08 Nov 2025 11:42:26 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-37a5f0edac3sm22115421fa.38.2025.11.08.11.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:42:24 -0800 (PST)
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
Subject: [PATCH v4 3/9] selftests: riscv: verify initial vector state with ptrace
Date: Sat,  8 Nov 2025 22:41:42 +0300
Message-ID: <20251108194207.1257866-4-geomatsi@gmail.com>
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

Add a test case that attaches to a traced process immediately after its
first executed vector instructions to verify the initial vector context.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 .../testing/selftests/riscv/vector/v_ptrace.c | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/v_ptrace.c b/tools/testing/selftests/riscv/vector/v_ptrace.c
index 6a4b5a2ab4a2..9fea29f7b686 100644
--- a/tools/testing/selftests/riscv/vector/v_ptrace.c
+++ b/tools/testing/selftests/riscv/vector/v_ptrace.c
@@ -82,4 +82,105 @@ TEST(ptrace_v_not_enabled)
 	}
 }
 
+TEST(ptrace_v_early_debug)
+{
+	static volatile unsigned long vstart;
+	static volatile unsigned long vtype;
+	static volatile unsigned long vlenb;
+	static volatile unsigned long vcsr;
+	static volatile unsigned long vl;
+	pid_t pid;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
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
+		asm volatile("csrr %[vstart], vstart" : [vstart] "=r"(vstart));
+		asm volatile("csrr %[vl], vl" : [vl] "=r"(vl));
+		asm volatile("csrr %[vtype], vtype" : [vtype] "=r"(vtype));
+		asm volatile("csrr %[vcsr], vcsr" : [vcsr] "=r"(vcsr));
+		asm volatile("csrr %[vlenb], vlenb" : [vlenb] "=r"(vlenb));
+
+		asm volatile ("ebreak" : : : );
+	} else {
+		struct __riscv_v_regset_state *regset_data;
+		unsigned long vstart_csr;
+		unsigned long vlenb_csr;
+		unsigned long vtype_csr;
+		unsigned long vcsr_csr;
+		unsigned long vl_csr;
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
+		/* resume and wait for ebreak */
+
+		ASSERT_EQ(0, ptrace(PTRACE_CONT, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* read tracee vector csr regs using ptrace PEEKDATA */
+
+		errno = 0;
+		vstart_csr = ptrace(PTRACE_PEEKDATA, pid, &vstart, NULL);
+		ASSERT_FALSE((errno != 0) && (vstart_csr == -1));
+
+		errno = 0;
+		vl_csr = ptrace(PTRACE_PEEKDATA, pid, &vl, NULL);
+		ASSERT_FALSE((errno != 0) && (vl_csr == -1));
+
+		errno = 0;
+		vtype_csr = ptrace(PTRACE_PEEKDATA, pid, &vtype, NULL);
+		ASSERT_FALSE((errno != 0) && (vtype_csr == -1));
+
+		errno = 0;
+		vcsr_csr = ptrace(PTRACE_PEEKDATA, pid, &vcsr, NULL);
+		ASSERT_FALSE((errno != 0) && (vcsr_csr == -1));
+
+		errno = 0;
+		vlenb_csr = ptrace(PTRACE_PEEKDATA, pid, &vlenb, NULL);
+		ASSERT_FALSE((errno != 0) && (vlenb_csr == -1));
+
+		/* read tracee csr regs using ptrace GETREGSET */
+
+		regset_size = sizeof(*regset_data) + vlenb_csr * 32;
+		regset_data = calloc(1, regset_size);
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* compare */
+
+		EXPECT_EQ(vstart_csr, regset_data->vstart);
+		EXPECT_EQ(vtype_csr, regset_data->vtype);
+		EXPECT_EQ(vlenb_csr, regset_data->vlenb);
+		EXPECT_EQ(vcsr_csr, regset_data->vcsr);
+		EXPECT_EQ(vl_csr, regset_data->vl);
+
+		/* cleanup */
+
+		ASSERT_EQ(0, kill(pid, SIGKILL));
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.51.0


