Return-Path: <linux-kselftest+bounces-44048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C81C0A01D
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 23:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9011B4E8898
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 21:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C5C3054FB;
	Sat, 25 Oct 2025 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhAxPh9C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D53002DF
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 21:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426438; cv=none; b=Wy16YCAAjWaix99MaZTxl3AgkYhBLsJwX8xwr8QhPPcVFqr9/Cj4/uW6eJ0Tbhocyrq3rp+QPVe5qDVqORa3flAVB/tNQ02tWegtgiMiefaNFDcGVGAnVsEBYlVMxY3KusskiXlaVlZdKV8Il3+ovS8SIllqzC6npgeYAiyT/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426438; c=relaxed/simple;
	bh=I+Jx6xBgH2zAab9TpH14gkeCgnP49zZ44qWiAaJu1NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMMiqbIVF+I01i2uPtqHz6n4cyF7CZ/peNCPYo8rEc6/0b6/Y0IFvBamlIw2uPgYE2g1HFe/WTD9naXcwaKWibiROIqLa3sPJWPnI+glFZNGRl3x0L4AwKnV6hDAlRc/ArucdgoatDfikJE0X1k/xOi22kB10XdGblrIoL7qwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhAxPh9C; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso4310417e87.3
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 14:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761426434; x=1762031234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1z9oJMGhMkRuSJL42xb+stRjYj/XQC2rSAWX+erznoA=;
        b=OhAxPh9CeQiheGaYloZ6IRUb+catFwutGsmHdNHmoTgvVvS5AtYq8oPBuy5nctpWGD
         92BmI84RAXZT9wEdDUR+iQZfD2RWS8bwxW+x4sDN4bWgKjy6DCW1UJm3luGo+2pGWbft
         7alW7MqeOMrv7OVEOqM8gbHL0WMshkqlsGenvb/ouf9Mn1ya75zL7DlZJpLTAXiyjqOu
         Cxqe6AxmINwXTucB6+dVhMtNjnciD72+zOmrr+u78K4wjiFPEWrMXf/urQlhI4VI959a
         ATksxX4u4NnTKdI+S4aIxzkaUyTMZyDbOKroKZ+T7S53Z4woYlXIbkT9naKZyeVb40ww
         vUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761426434; x=1762031234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1z9oJMGhMkRuSJL42xb+stRjYj/XQC2rSAWX+erznoA=;
        b=JWyNs7Oj7UjtNwLFCi34jmVsxeMre+rbfmxdUPa80tx0sMZkvR/FARTxGTop8++lqS
         U+58x/tkKMQ334p6r0NoLT6pODNP4lbJTMxAnv/DiBxTd/C4G12BYuOyIt2KTHwVS6QO
         /A9R28DIgnjUhhpBJV3T7/GTpj8ZsVCM07RPu5e0QvM4YZg4wmOMEBrMVj4qCAxG6w+Y
         /IepIshhRiTczSuwtEuarktHmytCdVAQ5Do0GUqteUEriXb6/KcShfIx1N+KcopK7MZr
         ah9BJKGxU7qix2o236tNEErb5zBhuJ3IgXqkfl2OPW4GydWoJBBNorqTn4aWUAmdt+HI
         LPhw==
X-Forwarded-Encrypted: i=1; AJvYcCXiCSZMylRC0h1CsAus7Hmdm23aJtzx0QJqpaWRRcH8VXX2JJssOIpjm6/VqcZLlROJfpAYdWCHzBHGMaIP/wE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhKVq+JReau8fKJO+JtHTK4Ilx6upeVaU3RvOH35LPzItkFfL+
	PIeST/W/45kKW1bbrV6d8zmfRETtwsupyRHlwdx+pPHL/umsmdNr9QwX
X-Gm-Gg: ASbGncv7uQXvfrvwSqLqRFJT5lhHQLo0mXtD6YwEeO486jbMQ4wB5AdKrAUsnlVCi41
	RzIGTCmM0yk3+70pS7134OwPf8fCYjS8PN884Sr3OjoUGbYwT7MkTii2ZtiVzDnOgjaEMt79epw
	SDZ5/K2F4CYyr2f2j6iQX2MUdw/MfALgEF9aZkqythKT8GPt2Vb421g3+cM6PPQSsjWfd4lNqvu
	2ElHEjcxqHXTbUhIUzHSIFSWzkdgd2TibFqYvdS2XF/oEnCMVC6X1IorBpZ7b47R4rbI+KufbHa
	cXAcBN3euKpg9A/3Fc66Z6PYeg9324cZqD3Jh7bF1gw6oNRUGmH6UVOsqXp3RzHeHeDcZcHFSuG
	esKQqUe/vQ1ldmX62PFRZC0YPLH4PO/RKtT0IpuDgoGknjCsrI7scLnWnnDoZVTkLNbE=
X-Google-Smtp-Source: AGHT+IFUdDmSd26EpJsO+EiP5G0k+Ebq3VVdqt8KbLEbTXtWf6GeHir1tww1xGP4PmC4wQzC5b6wjw==
X-Received: by 2002:a05:6512:32c5:b0:57e:ad46:b0a0 with SMTP id 2adb3069b0e04-591d84cf5ecmr11675494e87.6.1761426433528;
        Sat, 25 Oct 2025 14:07:13 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-59301f840dfsm953644e87.104.2025.10.25.14.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:07:12 -0700 (PDT)
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
Subject: [PATCH v3 3/9] selftests: riscv: verify initial vector state with ptrace
Date: Sun, 26 Oct 2025 00:06:36 +0300
Message-ID: <20251025210655.43099-4-geomatsi@gmail.com>
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


