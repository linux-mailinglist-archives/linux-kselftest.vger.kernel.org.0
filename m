Return-Path: <linux-kselftest+bounces-45187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25134C433F6
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 20:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7CD84E33A4
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 19:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0AD287242;
	Sat,  8 Nov 2025 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fng0M7al"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E728C2BE057
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762630966; cv=none; b=MsVO8avqhmgk76ntVQKb2G4Z8gstFuWoTtG3lWoziyRsxXBpOqaRW9dmWK7sxEgMWbmFltAtL1rGFA8vr+FSp9QaGOzEZkgfMXFW94sxJobjHxnYyN+LEG+uPKO2EBdXiLsik1NwjhP3dtAxJ1mfwF116Yb0Pv+q8/52++qefRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762630966; c=relaxed/simple;
	bh=/5P54JZsVoEIjyCnuoFOoFiiaakzGZYJndoJ6oDwTIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEyPxzVOF/amcLLkU/PW8aSH8Xpki1v+Qmri9xN22D45o/eoU+sK4RAEUaxmq7FyRWSTXRiPKSbDEL94knO4uElm0TCnlUSIsm/X1XuF3GmxltmvXv82KrfAwLltqEHKxRJ9YP6v3BbMezlQ7U3iJmJxTXoJUH3EpXoiOg1Nm3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fng0M7al; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-376466f1280so23607681fa.0
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 11:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762630962; x=1763235762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bbYFW276/qh6UIEkMA7XQhtcFTp5iMt1YWKBt+vv1Y=;
        b=Fng0M7aleQDoiA0LNJU6sIAzkEmZy1qSiWJVp6QBssy2Nj8ecsdBvrW3w39MLrsTBX
         Iu9j449WhLlc+6eVlyliX11EtO1IZxKHjpb2g6onmut6Gyg3L/Nsk7f6ZQiLRU6Sq9+v
         u+52lsGCzllOWJHoXRnapULNQLE/Xz220h65D+EgPNzp6zSAbAbyeYZWpgcii9dY/cVJ
         Ugt4RnaCFE/lTig+DZyjQLpzMRv7PzGaq/Z8i9wZeEUwab+2au8XoJDN8POTaGJ8tEvc
         fhaU2LSAc6e34lA8A0ihI0D5ITIG1YBpC3BZCntkgqUnX7Fz1vlUiX4iTGEQWHILh0rh
         Wj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762630962; x=1763235762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+bbYFW276/qh6UIEkMA7XQhtcFTp5iMt1YWKBt+vv1Y=;
        b=CS8SIPd2wM/Kw6QnHW7hg47en1fZz9LFYqqoDiaGIkAlJ50uYZEauESyjs9qrz+V/2
         279EwriFSvZZ9kNrRj2/sYSY2ZjMYDa7NftgbCduRA4k8TNMWBLdg+gNauV2LNHkkzIG
         hPjvloSzN/AlUxnDBTRWnr4Zt6w1qk/CSA9NOvOqHjNH2y4sbCVBYGdDPs7mNjF2U0Uu
         Sg2aJZBukWaDheK0Ty73MfouzeBxEsF/rc/FXhHkgN5KI5uMeI59P3ppRNbtK82ZRXYi
         MmT/g687wj57MvXZfTcDNuC5D/oUreQD7hpO5gdUKKz9o0D7Of9zdjKo5TqQ/zETptFd
         WEXw==
X-Forwarded-Encrypted: i=1; AJvYcCVHLWtw7KJBqQfqwArjLQxN8y9X2P/etxn+OyKCqDljy0S6PbgNZr2i763n0jF3PY0VJruuTJNkp7XGn0mo3WE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1i5U4MIACtP85J1nMjnBJpOLILE7+fUqmv02WT9CXkk5krWsO
	WIohiP5zDkK2bgx+ytb4ipnaqp0gAxnRdjjOLwwUi6Po95TJzcZDW4zA
X-Gm-Gg: ASbGncvwMLZspCxpHSXAdGMckBN8vpqjr9M0YkMYyOufpdK6CBHlqbCss8Tns56KMwd
	z+PoWhzg8U1UW3IgfJBrBydqu7XJdfohVDdToEO68IjwnpTSFyxpHYoFtj55CmXWKRYOQdC78hz
	yBVCd3f5gXIiMNo+ZCErv5Pu56GXIn8U7HUCWOgFy3PLFR9o5wGGe3VdxDSTUCwhAXa1Yhnwg6G
	3Se9NGrJBl531RG2usL6wkzFuN03WaWQOiNzXl4uibGGYaPZ9k+lapJqKp1Ih9A3tMIvB1ABsD7
	hDsHsq+nW9ApngkK3MEtHAleQlqFuB11paTOy83Sz4tlc50McEJhDYE2UmVbqUQJUdxzMNO4Tou
	BLrI/pTVWS5gLMqWEjCCXS8rxNY4mqup3ntHk5Jh8kvy3jHdfAvnNaHPFBuyR6vRqwUhBW2Apr5
	ELaQ==
X-Google-Smtp-Source: AGHT+IGbqfLpIHEmSZirHycm/m3Wf8olNlfmXdlwHAR/tE60r7C92aNsJU96025k0i2AD9bl/9coAw==
X-Received: by 2002:a05:651c:e19:b0:37a:4d6a:313b with SMTP id 38308e7fff4ca-37a7b1d8abdmr5874861fa.17.1762630961836;
        Sat, 08 Nov 2025 11:42:41 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-37a5f0edac3sm22115421fa.38.2025.11.08.11.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:42:40 -0800 (PST)
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
Subject: [PATCH v4 7/9] selftests: riscv: verify ptrace rejects invalid vector csr inputs
Date: Sat,  8 Nov 2025 22:41:46 +0300
Message-ID: <20251108194207.1257866-8-geomatsi@gmail.com>
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

Add a test to v_ptrace test suite to verify that ptrace rejects the
invalid input combinations of vector csr registers. Use kselftest
fixture variants to create multiple invalid inputs for the test.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 .../testing/selftests/riscv/vector/v_ptrace.c | 238 ++++++++++++++++++
 1 file changed, 238 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/v_ptrace.c b/tools/testing/selftests/riscv/vector/v_ptrace.c
index 9fea29f7b686..023e1faa84bf 100644
--- a/tools/testing/selftests/riscv/vector/v_ptrace.c
+++ b/tools/testing/selftests/riscv/vector/v_ptrace.c
@@ -183,4 +183,242 @@ TEST(ptrace_v_early_debug)
 	}
 }
 
+FIXTURE(v_csr_invalid)
+{
+};
+
+FIXTURE_SETUP(v_csr_invalid)
+{
+}
+
+FIXTURE_TEARDOWN(v_csr_invalid)
+{
+}
+
+/* modifications of the initial vsetvli settings */
+FIXTURE_VARIANT(v_csr_invalid)
+{
+	unsigned long vstart;
+	unsigned long vl;
+	unsigned long vtype;
+	unsigned long vcsr;
+	unsigned long vlenb_mul;
+	unsigned long vlenb_min;
+	unsigned long vlenb_max;
+};
+
+/* unexpected vlenb value */
+FIXTURE_VARIANT_ADD(v_csr_invalid, new_vlenb)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x3,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x2,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x0,
+};
+
+/* invalid reserved bits in vcsr */
+FIXTURE_VARIANT_ADD(v_csr_invalid, vcsr_invalid_reserved_bits)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x3,
+	.vcsr = 0x1UL << 8,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x0,
+};
+
+/* invalid reserved bits in vtype */
+FIXTURE_VARIANT_ADD(v_csr_invalid, vtype_invalid_reserved_bits)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = (0x1UL << 8) | 0x3,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x0,
+};
+
+/* set vill bit */
+FIXTURE_VARIANT_ADD(v_csr_invalid, invalid_vill_bit)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = (0x1UL << (__riscv_xlen - 1)) | 0x3,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x0,
+};
+
+/* reserved vsew value: vsew > 3 */
+FIXTURE_VARIANT_ADD(v_csr_invalid, reserved_vsew)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x4UL << 3,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x0,
+};
+
+/* reserved vlmul value: vlmul == 4 */
+FIXTURE_VARIANT_ADD(v_csr_invalid, reserved_vlmul)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x4,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x0,
+};
+
+/* invalid fractional LMUL for VLEN <= 256: LMUL= 1/8, SEW = 64 */
+FIXTURE_VARIANT_ADD(v_csr_invalid, frac_lmul1)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x1d,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x20,
+};
+
+/* invalid integral LMUL for VLEN <= 16: LMUL= 2, SEW = 64 */
+FIXTURE_VARIANT_ADD(v_csr_invalid, int_lmul1)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x19,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x2,
+};
+
+/* invalid VL for VLEN <= 128: LMUL= 2, SEW = 64, VL = 8 */
+FIXTURE_VARIANT_ADD(v_csr_invalid, vl1)
+{
+	.vstart = 0x0,
+	.vl = 0x8,
+	.vtype = 0x19,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x0,
+	.vlenb_max = 0x10,
+};
+
+TEST_F(v_csr_invalid, ptrace_v_invalid_values)
+{
+	unsigned long vlenb;
+	pid_t pid;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
+
+	asm volatile("csrr %[vlenb], vlenb" : [vlenb] "=r"(vlenb));
+	if (variant->vlenb_min) {
+		if (vlenb < variant->vlenb_min)
+			SKIP(return, "This test does not support VLEN < %lu\n",
+			     variant->vlenb_min * 8);
+	}
+	if (variant->vlenb_max) {
+		if (vlenb > variant->vlenb_max)
+			SKIP(return, "This test does not support VLEN > %lu\n",
+			     variant->vlenb_max * 8);
+	}
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
+
+		asm volatile("vsetvli %[new_vl], x0, e16, m2, tu, mu\n"
+			     : [new_vl] "=r"(vl)
+			     :
+			     :);
+
+		while (1) {
+			asm volatile("c.ebreak");
+			asm volatile("c.nop");
+		}
+	} else {
+		struct __riscv_v_regset_state *regset_data;
+		size_t regset_size;
+		struct iovec iov;
+		int status;
+		int ret;
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
+		/* apply invalid settings from fixture variants */
+
+		regset_data->vlenb *= variant->vlenb_mul;
+		regset_data->vstart = variant->vstart;
+		regset_data->vtype = variant->vtype;
+		regset_data->vcsr = variant->vcsr;
+		regset_data->vl = variant->vl;
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+
+		errno = 0;
+		ret = ptrace(PTRACE_SETREGSET, pid, NT_RISCV_VECTOR, &iov);
+		ASSERT_EQ(errno, EINVAL);
+		ASSERT_EQ(ret, -1);
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


