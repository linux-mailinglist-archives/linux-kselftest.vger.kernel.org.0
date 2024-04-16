Return-Path: <linux-kselftest+bounces-8196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 051A38A7380
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 20:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FCB281696
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 18:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5F513A88A;
	Tue, 16 Apr 2024 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sih91rTS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8513775C
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293093; cv=none; b=HgnlGyGgPNE9PnFofyYNNPN4ajyCYE0ag0KownP3Fn4XUr0IQmnhhbczrOS2AdD3uD+xcK5C6bVuguXngN0F7qsNa0OkTNad2sCOrxcjaeIFgke/DVBZPsUc0ZUUYrbueo6s2C9tzfgsTIhS3MnotwpYdx012XclHt8Z8CYxM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293093; c=relaxed/simple;
	bh=H8usdALoznAt2isX7oNnrfLpFcaNKxvOOWa8DDbamCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Os4Q6KAW6553KDzY8sEpL69stkWkS4okurt06iwGkcxsbQZi4cIDdYdDnsYChG9g+C5UX2PMMPhKeeaIf09w+AdqcCXTLOb2JzJwOb8uinYXp43ELAJ80pD6GcXHxNy3WKKhd6MmVT4tdNBpuQNI0HZ8Dd9R+uKNNsgOaPor5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sih91rTS; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a526803fccso2773863a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293091; x=1713897891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rU9bTQzimBlb4bBeVGV64JD8vBjMh3ZSXWmumJprSMc=;
        b=sih91rTShDqoyV9/xzv6ODbOQ9WzXUI0NA2N1u5hPo4SN8KN0LHQo1ZKOgYVCGwTup
         ooHHf3cdnJAc8xN7jJgrHvCGIXVIZ64R18tYAbskUBMrZBHusxX4d5LgQmPbWDAJAzF0
         Fae4+KQcuB9wmkjoliYD5KUG9qO3YBVeZrBEfAlO7lGQ43bbJCvCyNer94VMG1OpDuiT
         N+TEOuIfBx/WJqG/ajyuJimeA8ZpQGEmEpYu3eyAItpFJWMbcP+6Rt0oCw9D+w9+0+bK
         HThFiybcQVw+QrT04+tgmTVeQyP4IzdlRbwj62zlatrQP0ZVf/tXoXPzmHM8xZBHL8So
         KxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293091; x=1713897891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rU9bTQzimBlb4bBeVGV64JD8vBjMh3ZSXWmumJprSMc=;
        b=hMU36m4wHCxkELwKcKLItnfRov28WHAyHaj/WrIWj5Rz+SO7qSgkiAf8kXowVzTJeN
         zF80bOhXE6FatRcRGgsjvy7bCIctTNhKn1Pop33kRUpoBdA+4B9jW0lhjsuGtrXZ8Ytk
         LBauB8cEa9OPuQHAiaad+qEHWzcBJM7pe6QZIgMs4NhJPwll8eQZ1L7oDSROqwLUl5Tw
         Vi1S+nQMcZsyNJjSw9w3GDDema1qz1Dcll6C7NoaUruixZOD8zf1B5OjD53ONhJrqVEY
         3o/AvWqkRSqS0ZOvlJy2Gfv0r9e9nN6oMiORunDu6me94aEsTuIOZbnIDCEgcOFRIm8y
         GDYw==
X-Forwarded-Encrypted: i=1; AJvYcCXDzGfTau0S7ilLT4OHvlSVGeTPm1e0ksFWdXJH0aTXoxdsYgTCO59TwcRwgmxe7oz6DuRb8xZHBBqcYfluZ+NhjAUvod8M6qVy+Hah2q4h
X-Gm-Message-State: AOJu0YzmJ5nGwSeAo2zcudMSfFSh442T77D10I8YziRKBZYdcxGTlTWA
	cwxkK1swkrDB5wpo0F4XI1w9IdqHiiLiy8sNP2rhA4/S3U9LSb8WRQyuAs+xHdo=
X-Google-Smtp-Source: AGHT+IFO7gBokex9KDHR7FMDDghsIz2thvCcgFt0g1hVdtn3kLkpEMXY9Ea3s80HyJZdLNzoP7x/LQ==
X-Received: by 2002:a17:90b:46c8:b0:2a2:50ef:ece2 with SMTP id jx8-20020a17090b46c800b002a250efece2mr12099952pjb.17.1713293091321;
        Tue, 16 Apr 2024 11:44:51 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:50 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
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
Subject: [PATCH v7 07/24] RISC-V: Use the minor version mask while computing sbi version
Date: Tue, 16 Apr 2024 11:44:04 -0700
Message-Id: <20240416184421.3693802-8-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416184421.3693802-1-atishp@rivosinc.com>
References: <20240416184421.3693802-1-atishp@rivosinc.com>
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

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index f31650b10899..112a0a0d9f46 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -367,8 +367,8 @@ static inline unsigned long sbi_minor_version(void)
 static inline unsigned long sbi_mk_version(unsigned long major,
 					    unsigned long minor)
 {
-	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
-		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
+	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT)
+		| (minor & SBI_SPEC_VERSION_MINOR_MASK);
 }
 
 int sbi_err_map_linux_errno(int err);
-- 
2.34.1


