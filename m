Return-Path: <linux-kselftest+bounces-707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EF97FBD48
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 15:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4D61C20E08
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 14:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D96C5C07A;
	Tue, 28 Nov 2023 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="eKvUmA/t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF9E19B5
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 06:54:07 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ce3084c2d1so46190625ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 06:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183247; x=1701788047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5oGoP2GtxpZiKciaDqaxx+4G6dOpwmCS0pkpDHBsR78=;
        b=eKvUmA/tZfVGUUtsS1mCGBo/vNlQGQd1FrNz1E7SLPArwfsQbyuWL6Qtz4400DYPPi
         U44PQtoPiY9zFOHVhrrkdOVAlgcYlOMhyHi5sek/KBloT7MSN5kK9N/aTJthMxvb5Waw
         7wDeT+N/ztpSHg4WmHIuEWN47OhCnf3m74zathhqhQemMexJozVMWfnryXRoJmec5rdb
         VqBWVdQV+jxhuOhF5zd/tlqw8ZtjyvHXIGaPeUrIVYig2BBSFy+WmuhiEj69e1ee7Gag
         +uJqrr5uAmGDz42hQW+ZU+YU2O/N1VOfSNx21UZdHbrlFpUdTDyUVXZWT9rJEqTQR9qg
         sB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183247; x=1701788047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oGoP2GtxpZiKciaDqaxx+4G6dOpwmCS0pkpDHBsR78=;
        b=VqZ0wgZE+3As+OdfGjnHQHocrNtogy3Ti3T3nV86OtH9xRM11gvD/X5OMmzXmdK5Zy
         L/im25dt1aVs7bN97l4AV4s+2JIfmuhbfcnD3/0tH/VBnECvF5r2yWH71P365CJLooAV
         9KA5z5tpOBbvQ2ixscNO2D8KF5TztCzoy2xpYLaIiXJd6TRseXTh8LXw335M4hQ4fAXw
         kioR0GgDZKrSaMxRPZjNMuxWN3SIlRzMSyf+slqkwEmrQuYJBvdlRujFH/xDHVNgPNn+
         RWtPfZ3AhQqKLxVRR9rbbUJGBJwrE7G9aWBFZ/kY9MMh9c2Ea2hEwDb/7vXEcqbLXky7
         nanw==
X-Gm-Message-State: AOJu0Yxaef88C0M/NL9OZhGt4E9e7HIF7JXCcPMVRRWDpIysE0IIyJJa
	L4DWQn1J+dlTti3xbuHJREBoGQ==
X-Google-Smtp-Source: AGHT+IGsBlwznYL+eO1YLtU9utrEhljJYsPZTHdTwczY6ki0/qgSD6wR3fyYBpktQqzZ0f4ggbB5sQ==
X-Received: by 2002:a17:902:e88a:b0:1cf:cf34:d504 with SMTP id w10-20020a170902e88a00b001cfcf34d504mr8424957plg.36.1701183247023;
        Tue, 28 Nov 2023 06:54:07 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:54:06 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 00/15] KVM RISC-V report more ISA extensions through ONE_REG
Date: Tue, 28 Nov 2023 20:23:42 +0530
Message-Id: <20231128145357.413321-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This extends the KVM RISC-V ONE_REG interface to report more ISA extensions
namely: Zbz, scalar crypto, vector crypto, Zfh[min], Zihintntl, Zvfh[min],
and Zfa.

This series depends upon the "riscv: report more ISA extensions through
hwprobe" series.from Clement.
(Link: https://lore.kernel.org/lkml/20231114141256.126749-1-cleger@rivosinc.com/)

To test these patches, use KVMTOOL from the riscv_more_exts_v1 branch at:
https://github.com/avpatel/kvmtool.git

These patches can also be found in the riscv_kvm_more_exts_v1 branch at:
https://github.com/avpatel/linux.git

Anup Patel (15):
  KVM: riscv: selftests: Generate ISA extension reg_list using macros
  RISC-V: KVM: Allow Zbc extension for Guest/VM
  KVM: riscv: selftests: Add Zbc extension to get-reg-list test
  RISC-V: KVM: Allow scalar crypto extensions for Guest/VM
  KVM: riscv: selftests: Add scaler crypto extensions to get-reg-list
    test
  RISC-V: KVM: Allow vector crypto extensions for Guest/VM
  KVM: riscv: selftests: Add vector crypto extensions to get-reg-list
    test
  RISC-V: KVM: Allow Zfh[min] extensions for Guest/VM
  KVM: riscv: selftests: Add Zfh[min] extensions to get-reg-list test
  RISC-V: KVM: Allow Zihintntl extension for Guest/VM
  KVM: riscv: selftests: Add Zihintntl extension to get-reg-list test
  RISC-V: KVM: Allow Zvfh[min] extensions for Guest/VM
  KVM: riscv: selftests: Add Zvfh[min] extensions to get-reg-list test
  RISC-V: KVM: Allow Zfa extension for Guest/VM
  KVM: riscv: selftests: Add Zfa extension to get-reg-list test

 arch/riscv/include/uapi/asm/kvm.h             |  27 ++
 arch/riscv/kvm/vcpu_onereg.c                  |  54 +++
 .../selftests/kvm/riscv/get-reg-list.c        | 439 ++++++++----------
 3 files changed, 265 insertions(+), 255 deletions(-)

-- 
2.34.1


