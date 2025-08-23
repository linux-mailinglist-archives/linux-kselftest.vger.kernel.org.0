Return-Path: <linux-kselftest+bounces-39790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBEDB32A1D
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 18:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF285833C1
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8072E62D0;
	Sat, 23 Aug 2025 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DAwdmn+Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEA52E7BC5
	for <linux-kselftest@vger.kernel.org>; Sat, 23 Aug 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964804; cv=none; b=sJUO1cq8ZK6zV7sUHedH7N2AxM3kPHif5Aumt8df+bulUHQn4VvMfMdTVVw5ivEHCDDDUIt76EwaPhSOLaO07056SpxhSHd2Ex8jHNUOZqK1HPFFJ2Lwq+Gu1S1prRVqk+fP2iS1nq2sZRfNB78oJGKCMCmmyThTvUdTO7we2/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964804; c=relaxed/simple;
	bh=dK+CR3Hpw7kGgKQtXxubea1aCAm20tR0xK1kEUaSbEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DAY9hiAwxgOHnc7k3R8TJwrwj/Tv/vN0k0iYkfvvb5ocDxqKObNvU5ZUiPvcofNKj59VUlERuIkTmyiO/jJKc7owwB4WgEfEQ6EWQuPGZsiY2OwaL7MH6HTI5MvA4ZfxitbVzOKyRgIL208kaxchzDCBGqmHIX5j16tv9imejDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DAwdmn+Q; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso2697396b3a.1
        for <linux-kselftest@vger.kernel.org>; Sat, 23 Aug 2025 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755964801; x=1756569601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H24QVG/T3cxixN5Hjl4PI98/BCvc+2mgYT4CjAn1N5o=;
        b=DAwdmn+QCIub+wf1aZmp/lmq0EDc+wYhJLul6JPZyMaV+fo5gzKKZHXq6UpLu7X2lk
         JDwMStIX87HbFPsASqH1M+k0s5uCa3NNbgKMLx/vu4cptnXAEYL6+v6y8sSOKdLSLTJc
         6jY3y4brA9v8TsLZeA0Xg/l4Yvce2yGtkVhhmOf47IY2S3WXkrHHAHP4OATI1Ik16rQE
         BVRtXDtviTvEjOVBEAHLMbH20EptaavlhhVbDr+kaaeMlYTP3nH9I5RptYHyx7iFxarx
         t933K4c7T7YYNhrUsyA1GSVJg+mlWDyuY2UshqHVds4/+T3jYEDpxfFggz7bzw6c9RLL
         8bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755964801; x=1756569601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H24QVG/T3cxixN5Hjl4PI98/BCvc+2mgYT4CjAn1N5o=;
        b=P+AQtck+Cug3+NnMCTAl4cR2RSVW03H6fNBJTHvP/DX/hq3XVB8aDSbwM7Eg5ejVvC
         Ro0OUZs/6hYREi2BWCShUQvVyjpiM2KAg6quH2qAyHsAjn6je+gGSTOtvHVf66ArLtdu
         vX8a8vAZ5q+bt5S9rDhvdWGxf8nyM0SbpTWsej2cADKh97cGnm8j6WQrItYiKBCESzGi
         mEU+/dg9lCj1xcu3vklLVeO5dwJyAA21775MoucMaJnTtqO4POSLdtoYk1WugIzcBUHg
         LRIA5AS5preoO4KnJwwMM3LQSzDJ3auqzVhbdbEOHb3dux7EQRfOsI1FSV17RiP6RzxT
         LGPA==
X-Forwarded-Encrypted: i=1; AJvYcCUHAGDT+ew3eQ1tNrLWwI7nKHN023ywq7cVmXYoEwkvI7tTrydguS+uMTxR8/4f6f9PchZRonlxMN9GLsLi39M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRZQ5P3fIAfWsJj+8W0YMND5dbVIUJME6gM6g/jpwRTZb4H6v6
	TFhMGGQZgmdqK4dV1NaW443nFxor+rARHKbLvCPwVuMjO8c//Km+fU5rjewjd4ruj6g=
X-Gm-Gg: ASbGncuJ0ASxjGWHCNI1gJAbpVjFOMOOVfrFxpizdP0EZY6fjXuAGDXIiHnZZn4qQ3c
	vwPbvARJISSgjCIUslyixJSI6M1k7hDcK0yLn+SzuO7JgdD90E0CNzrk91LtKNTeV98Wat4vZJx
	G4N3D5iF+w8IJyQt/igjttKBtLRYM2+QWevbsAYd9Fvl+WKHwQbD/opUjL9UocM1TUvtaVPjoB0
	ak79mdHxGWWH0065+U3iiEXm9mI7hbD52njbTE+0f0ms0T3U6t0nHLRWIoyKlzwajNf00dsImDi
	IlEFYVkF5FB3IXCK0tgkrbFpUhTq+2YCpzvGZmPGZ0kHvuOj5kdEVAQ7pnDnkRbHxBuOASmPjVQ
	7kQSMHDDC1uif5yoDfjAVuHjgSvYLg0XTzWaG6DvCJV0AumM+UJlEedAqtc0C5AXwIDmVNFSl
X-Google-Smtp-Source: AGHT+IHHBn4yz0Tv2mtxye/b3d+njwhsYjSP/E2IAAVTTBKNql/cK/uY7eFReM62Y2BttpdFYMcwWg==
X-Received: by 2002:a05:6a20:1592:b0:23f:fe66:5d2a with SMTP id adf61e73a8af0-24340bce2c1mr9575921637.27.1755964800673;
        Sat, 23 Aug 2025 09:00:00 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040214b81sm2804464b3a.93.2025.08.23.08.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 09:00:00 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 0/6] ONE_REG interface for SBI FWFT extension
Date: Sat, 23 Aug 2025 21:29:41 +0530
Message-ID: <20250823155947.1354229-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds ONE_REG interface for SBI FWFT extension implemented
by KVM RISC-V. This was missed out in accepted SBI FWFT patches for
KVM RISC-V.

These patches can also be found in the riscv_kvm_fwft_one_reg_v3 branch
at: https://github.com/avpatel/linux.git

Changes since v2:
 - Re-based on latest KVM RISC-V queue
 - Improved FWFT ONE_REG interface to allow enabling/disabling each
   FWFT feature from KVM userspace

Changes since v1:
 - Dropped have_state in PATCH4 as suggested by Drew
 - Added Drew's Reviewed-by in appropriate patches

Anup Patel (6):
  RISC-V: KVM: Set initial value of hedeleg in kvm_arch_vcpu_create()
  RISC-V: KVM: Introduce feature specific reset for SBI FWFT
  RISC-V: KVM: Introduce optional ONE_REG callbacks for SBI extensions
  RISC-V: KVM: Move copy_sbi_ext_reg_indices() to SBI implementation
  RISC-V: KVM: Implement ONE_REG interface for SBI FWFT state
  KVM: riscv: selftests: Add SBI FWFT to get-reg-list test

 arch/riscv/include/asm/kvm_vcpu_sbi.h         |  22 +-
 arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h    |   1 +
 arch/riscv/include/uapi/asm/kvm.h             |  15 ++
 arch/riscv/kvm/vcpu.c                         |   3 +-
 arch/riscv/kvm/vcpu_onereg.c                  |  60 +----
 arch/riscv/kvm/vcpu_sbi.c                     | 172 +++++++++++--
 arch/riscv/kvm/vcpu_sbi_fwft.c                | 227 ++++++++++++++++--
 arch/riscv/kvm/vcpu_sbi_sta.c                 |  63 +++--
 .../selftests/kvm/riscv/get-reg-list.c        |  32 +++
 9 files changed, 467 insertions(+), 128 deletions(-)

-- 
2.43.0


