Return-Path: <linux-kselftest+bounces-3521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF5C83B9AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 07:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E372A288AC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 06:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A2710A2D;
	Thu, 25 Jan 2024 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="m0zBulhY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A2012B9C
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164140; cv=none; b=m3K14pOzXI9W8uBOx1p1RJmtrT+3dxmarLZ69MenbUESsaptz8WIfffWF/QZBgA9I2qnvdGF/kUk6Pt82PKHN3hVx+OitQx81nDFC5JfggE2cBM95qZwFi59tbXp6Bt+B6B9hJlNapYxG/Cb0+Af7LXwcf0jyuTXp1RQgV2zu08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164140; c=relaxed/simple;
	bh=kgVxcxj80ZdZVYCmHIVIDqdhCzctMsUdnc9S7i8xPEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDggfjCHciMwUwOnW5B/clheCS0A1ccWeZLJK9LnieFezK6oVp8FRan4Frs6iYGUPQVOroclm7tXMXi3ZvtHTKLACrJanJjVijiXfDETy6j0Sj6aJ4waN8k4LLT43LyXX4mQh6ZzE+bqr475o1iqIRwQoFqDR4jWlg1qDWeb6Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=m0zBulhY; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ddcfbc5a5fso192525b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 22:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164137; x=1706768937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvIQkZQQe0K7W+Tn30d/DsUxvdwzfahlImuX+CJcznc=;
        b=m0zBulhYvViVijVbC32ku7epwmENvbhKNlqsaMUEwLUtbP/gH4OmG5ahN6QceLzES8
         6xjg8TeBquhgloyd5IonCDqjV8vwzbY9KL+TbV9t8Ko/xnlrutifbwOVeN0D9VdEuB1U
         QJZUyCmm3gjmwl2X4zCUenW8Ty453T1wH7WKIor/yH/9Cx4dArEf8rokxc7qEg/Ib9/+
         cva0wHqXsz3sUYhPWbD3WQytQQGye2XpirciRpeOZuOaoX05uU0+aEV2WB4iWVEztC6E
         Z3oQsusTNimQ3e4ax7n0bd9oWRYe8eLeBqUPANTN0Me07PFToQmtyUTQLY15LsHqyuwF
         j+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164137; x=1706768937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvIQkZQQe0K7W+Tn30d/DsUxvdwzfahlImuX+CJcznc=;
        b=hCzpRj8f9oRJUiFRprodXiZqaZsv/IyFH/mHs+UF1q1tvC4klQ28txV3QGpvgmwdJ4
         UFumcUoVgW/fhOBTTDnc9SvdOQ7Ka82VkPY2n72+SFkweBrZ5oxPwgNiyXH2CDrKzTbz
         nvCt/C9HsH3dzfgBrou9zftz/0ZmtsLoed6e6Bd1pFeRhm9wkKob8fyzEgBg49HNasTy
         uw5Xe+LLrMe2wPB5c0ba3pxb0178ktVXV4Itwrat5fPHjzIRlVIyR+8muLGYy6f2xP35
         5xQvg7HsG0fu8Gxbthk7FotW51f6PSJHJ5+4xEkkLBbXWFJHOBsbPWf5uKmLV07aYOQj
         i9Hw==
X-Gm-Message-State: AOJu0YyrWJNnX+T/cmdz9vF8yVVN3MdsZMPZBQgONZbRSvY9iww3RzmF
	DZjmWRHgchSA2N12YdZ9teXgH+Py1EuNhZvE8L7C3kqmQqLMp3xcNaK0nAzjeLE=
X-Google-Smtp-Source: AGHT+IG62+/0zfbVEYbfQN+QJI5rZ4lnUWc92boKfqE+8XigV4+ljqSZM4hwNuU+ih2eIoSJ6cAqUg==
X-Received: by 2002:a05:6a00:2d12:b0:6dd:a004:c193 with SMTP id fa18-20020a056a002d1200b006dda004c193mr601959pfb.12.1706164137214;
        Wed, 24 Jan 2024 22:28:57 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:28:56 -0800 (PST)
From: debug@rivosinc.com
To: rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com
Cc: corbet@lwn.net,
	aou@eecs.berkeley.edu,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	waylingii@gmail.com,
	greentime.hu@sifive.com,
	heiko@sntech.de,
	jszhang@kernel.org,
	shikemeng@huaweicloud.com,
	david@redhat.com,
	charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn,
	willy@infradead.org,
	vincent.chen@sifive.com,
	andy.chiu@sifive.com,
	gerg@kernel.org,
	jeeheng.sia@starfivetech.com,
	mason.huo@starfivetech.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	ruscur@russell.cc,
	bgray@linux.ibm.com,
	alx@kernel.org,
	baruch@tkos.co.il,
	zhangqing@loongson.cn,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	joey.gouly@arm.com,
	shr@devkernel.io,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 06/28] riscv: zicfiss/zicfilp extension csr and bit definitions
Date: Wed, 24 Jan 2024 22:21:31 -0800
Message-ID: <20240125062739.1339782-7-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125062739.1339782-1-debug@rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Deepak Gupta <debug@rivosinc.com>

zicfiss and zicfilp extension gets enabled via b3 and b2 in xenvcfg CSR.
menvcfg controls enabling for S/HS mode. henvcfg control enabling for VS while
senvcfg controls enabling for U/VU mode.

zicfilp extension extends xstatus CSR to hold `expected landing pad` bit.
A trap or interrupt can occur between an indirect jmp/call and target instr.
`expected landing pad` bit from CPU is recorded into xstatus CSR so that when
supervisor performs xret, `expected landing pad` state of CPU can be restored.

zicfiss adds one new CSR
- CSR_SSP: CSR_SSP contains current shadow stack pointer.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 01ba87954da2..80fe38d5de4a 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -18,6 +18,15 @@
 #define SR_MPP		_AC(0x00001800, UL) /* Previously Machine */
 #define SR_SUM		_AC(0x00040000, UL) /* Supervisor User Memory Access */
 
+/* zicfilp landing pad status bit */
+#define SR_SPELP	_AC(0x00800000, UL)
+#define SR_MPELP	_AC(0x020000000000, UL)
+#ifdef CONFIG_RISCV_M_MODE
+#define SR_ELP		SR_MPELP
+#else
+#define SR_ELP		SR_SPELP
+#endif
+
 #define SR_FS		_AC(0x00006000, UL) /* Floating-point Status */
 #define SR_FS_OFF	_AC(0x00000000, UL)
 #define SR_FS_INITIAL	_AC(0x00002000, UL)
@@ -196,6 +205,8 @@
 #define ENVCFG_PBMTE			(_AC(1, ULL) << 62)
 #define ENVCFG_CBZE			(_AC(1, UL) << 7)
 #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
+#define ENVCFG_LPE			(_AC(1, UL) << 2)
+#define ENVCFG_SSE			(_AC(1, UL) << 3)
 #define ENVCFG_CBIE_SHIFT		4
 #define ENVCFG_CBIE			(_AC(0x3, UL) << ENVCFG_CBIE_SHIFT)
 #define ENVCFG_CBIE_ILL			_AC(0x0, UL)
@@ -216,6 +227,11 @@
 #define SMSTATEEN0_HSENVCFG		(_ULL(1) << SMSTATEEN0_HSENVCFG_SHIFT)
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
+/*
+ * zicfiss user mode csr
+ * CSR_SSP holds current shadow stack pointer.
+ */
+#define CSR_SSP                 0x011
 
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00
-- 
2.43.0


