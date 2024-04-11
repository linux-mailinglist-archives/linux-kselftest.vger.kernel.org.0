Return-Path: <linux-kselftest+bounces-7627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121898A0472
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 02:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACB71C22D37
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 00:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE952C80;
	Thu, 11 Apr 2024 00:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nUxgOLdj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9E17735
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 00:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794107; cv=none; b=lcjGNrHPIEqSgOzf2An8TvSHFb4FtzCNDXyM918NuVllCgmZ7vBtgHYp8uZv5UhB/VpPLEreeMq4sQiop8gaJfxo8PpHgB187XJHyg67qqJ3m20SWWr7iTAaKtZnECZilzZ3G934pIryqWqd7L4Du20CFQ1Joo3Ptw3ta4i/Bas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794107; c=relaxed/simple;
	bh=f7jwD7at3eRXjUvJMDfYkww4RoUkr2LuWcPC7rhOq1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iodp4lfYvwMHf3DdAPREPb7BSavjMX/AaMrI3WeoGpXVH1N4A6LivBoJukomYtgdPMW4jM4tsBV/0rFHUm5wIafPgaBZl8eWgDxCA7H8i8MUJYic5IvdAQAHuqhzV8p1LL6i+zHf8GvnZotWJQaUSJXCrnaZtHmnxv6O0UOmm5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nUxgOLdj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e424bd30fbso27641535ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 17:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794106; x=1713398906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ogf9r7p61Rc1oGw0oa8bhNwO/iV9jqlxUmzvsZGcz8=;
        b=nUxgOLdjHf+I2cpMr1wSKcvvthn+o7lI9qnZoKXpI+J5jWl8fKUPFQcSHYClmIA6RB
         FThnFI22F2JNf3k/atBr9ScKgZU0IBZaq4eiezVFXbdjTLOAkpYPt0w6/UVa6pyqW1Pf
         hKYNj+hVdHBqNPqej2UdiEckvU4Svbu+9znSonAsX4T+u7maEyizdDpHTjWQPHDNhjVO
         iBoa8vWQmNhODyoR4943RJzb52DxFxG4WToUotyVzULL5t+Zty8ELZSq5AxvaZ0xFMCx
         JPWT6lOB02boxaqtIoh24ql01ck2si/A0tcfXIalJTYRluNlbJA0qncCv4sYbC/NCSMo
         vGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794106; x=1713398906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ogf9r7p61Rc1oGw0oa8bhNwO/iV9jqlxUmzvsZGcz8=;
        b=JpjKBAsHENYiIThCobjJ4SWk2z5zy7KI4CDtfNoZ6Rh6v9LbLu03KxHe3Ac8AMmQP5
         ULs/WFgQM/mQ9pltyb5n3hFlYcOOwqub1P9Fu3dZk2FiSBkkqzvix1NQeAFLj2Ep/rNL
         h3IMYNsLjyKK/MhKiT85Ro/7ocnFyaPwSMLBNKGcyvwkE7JPP0GiI6GULtrWxCTMlhlz
         3VCkrpd//RJsddi5x31dXdPn3XFy0e67qBniIZbdrDsJ5B7a70dWcLfSIVlyd8uDkDlE
         QBW61stqym4AyczBLh+5BeBzrR9++LxSBA2UZLDQlUvU8iqREfqp8u8Iw9faRNvYvH24
         b1kA==
X-Forwarded-Encrypted: i=1; AJvYcCUIxr1fTcv7aigiQxUC2l/4SmFWJcRbbKb4/dlz706Mln+Jq10ez8fhRGz4a+7UhdVYcSGel1qGtE871JZvB9RBRdmFb2ycc1EnkycyaqN5
X-Gm-Message-State: AOJu0YxHv+UWfhylbIWTo0HK2ciVl4Z7mGeiJXYWByq1+D1Qq9pv5IOz
	9asvndB8HIkQwSV8uMhXoy8UdB5Y6xl3EQa428UfBB3Lkpjgo/gSNyxMbbWE0Q4=
X-Google-Smtp-Source: AGHT+IG/gd//TA1TkjWqM9vD82L3r8r0JszUDH21ZhI6QqZDs4OR9Y/ESBK0GgL0mQ8WNU4EjNB6Kg==
X-Received: by 2002:a17:902:c944:b0:1e4:911b:7a6b with SMTP id i4-20020a170902c94400b001e4911b7a6bmr5362603pla.61.1712794105838;
        Wed, 10 Apr 2024 17:08:25 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:25 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v6 07/24] RISC-V: Use the minor version mask while computing sbi version
Date: Wed, 10 Apr 2024 17:07:35 -0700
Message-Id: <20240411000752.955910-8-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411000752.955910-1-atishp@rivosinc.com>
References: <20240411000752.955910-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per the SBI specification, minor version is encoded in the
lower 24 bits only. Make sure that the SBI version is computed
with the appropriate mask.

Currently, there is no minor version in use. Thus, it doesn't
change anything functionality but it is good to be compliant with
the specification.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index f31650b10899..935b082d6a6c 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -367,8 +367,8 @@ static inline unsigned long sbi_minor_version(void)
 static inline unsigned long sbi_mk_version(unsigned long major,
 					    unsigned long minor)
 {
-	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
-		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
+	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT
+		| (minor & SBI_SPEC_VERSION_MINOR_MASK));
 }
 
 int sbi_err_map_linux_errno(int err);
-- 
2.34.1


