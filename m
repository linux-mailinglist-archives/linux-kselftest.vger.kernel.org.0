Return-Path: <linux-kselftest+bounces-8486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD988AB794
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC109281E4F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F72E13DBBE;
	Fri, 19 Apr 2024 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3Zr3c5i7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87D13DDBC
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570470; cv=none; b=IRKu2rARTLnidGo/igOXZz9lrLE19ILrOBR7It7h+ENkZPRm/GH8DsGTJwLXegVY0tdZhafqxD2A3kHMpvH9fPGi+YjK0X7NhJGvTpwX3fmILHGKYSFw3XWnjPvlmylYK7/bhMtUJ5Tjww0Nesj9FkU9EN03dSeIqwpA69cxd0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570470; c=relaxed/simple;
	bh=tjU5YEqQieqMxVoH/UAjG6llZvkwIlIrjBWxORyGdm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isK/ZaiepE2Cw+lAvtJ8z2jR6USzqjHDGYYA9MjGSxy63L0DvxCShrBaaZYKQhT9K0HtCezBpZ1u3aRL7jbN5DBpZAU6hL+0g2ASCmRB0qkktpKRd2mPwZ7e/l5XVQ0Xnz2jIZeuLLvMfIlCLzQGDYuiPcH98Djo1z8BYgJMaNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3Zr3c5i7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso16912665ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570468; x=1714175268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nwzSC0mjOXawHhzlfTnID2LKW7HdSbdpZLlPlBet3o=;
        b=3Zr3c5i7nVZN0Ti7su9Ph+Li+ANuSySAVwmBUEFdEoWoFWbMtays2OkGU7a5a8/jqE
         gImPDbjMJolFBbxqCFzH23DPlugsv1V3kKGGNBU1/Zqxl+jtRvkz5b7FGbD8YGGC2XUH
         lI9Tu93BLPmNqGaOB07/YPWznkMlqPVK7OIA8Bw0Q1VnzLwde+X29DcGqQEJLQ3yeaUO
         F83SoqxjtzOx2Mufd/j5bpoIcP0brk3KGUdSGMBErgXvE3GOHbAxXq6YoSnQXK0PWFtJ
         try35npmFRunG/KyaMod+gcNxMRBUCVwwqTwO4CiR/XqGC84eBPZCk5SCLdQksrvBJuJ
         sGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570468; x=1714175268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nwzSC0mjOXawHhzlfTnID2LKW7HdSbdpZLlPlBet3o=;
        b=KfJijbF7WwKedy59LdV6jtlGjp1jH7eXNRu5s8r6UABgo5xS8gxW1tx7ArfzoY3JxE
         jyKovDWYbMyOWMF4V0+vv1Xc0yr+nt/0mgkRShgjNPxNS6JXuti8wOf2m1UjgKb+wh+x
         2maQI4tf32bDTj1H32EowB+XdW4IGDLCGNpSKi7kOTjck7sP5rRfRUfIlk01VW+vJWK3
         sq7FxUHVulRvCR0+0OXc2n034mCI23DqsFEgIYV4TV0P7218o3qty6R5x/FNhHMuUsrR
         GX15X6059gAXnjPGk4CHTm+lz6XqoXONKL0CGSa/koqtVfAphduIgXNm9MMyAIhgz64J
         2xNA==
X-Forwarded-Encrypted: i=1; AJvYcCVdbrPVvCInxkNLnlXo/f9IKUoemRhu4nAdtucEDo4id7O0cvb3M9b7kM0iQ4gPPn8iKe+lfaX6156yx2HbjPvpjBkXCRhFFxTDhGFQIy17
X-Gm-Message-State: AOJu0YxH03ET/mIBBt9wvGmhaKn8zRU7l1qs3iWjQhWeGqWnLKn49T7W
	3tHP3OUgPWCmwColNw7L5Dh7skKl9Z2W0ofovW2Zb8fZfB1ffcXpQliPQPTLdxc=
X-Google-Smtp-Source: AGHT+IFwhdbfgPKxR3sTRhCsXv+l7GhC3Zl7nIRj/PlojSe97ane9b3f42xNp6we4mG5zu9et1mKlg==
X-Received: by 2002:a17:903:120f:b0:1e4:200e:9c2b with SMTP id l15-20020a170903120f00b001e4200e9c2bmr4072621plh.21.1713570468267;
        Fri, 19 Apr 2024 16:47:48 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:47:47 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	samuel.holland@sifive.com,
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
Subject: [PATCH v8 02/24] RISC-V: Add FIRMWARE_READ_HI definition
Date: Sat, 20 Apr 2024 08:17:18 -0700
Message-Id: <20240420151741.962500-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

SBI v2.0 added another function to SBI PMU extension to read
the upper bits of a counter with width larger than XLEN.

Add the definition for that function.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 6e68f8dff76b..ef8311dafb91 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -131,6 +131,7 @@ enum sbi_ext_pmu_fid {
 	SBI_EXT_PMU_COUNTER_START,
 	SBI_EXT_PMU_COUNTER_STOP,
 	SBI_EXT_PMU_COUNTER_FW_READ,
+	SBI_EXT_PMU_COUNTER_FW_READ_HI,
 };
 
 union sbi_pmu_ctr_info {
-- 
2.34.1


