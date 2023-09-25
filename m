Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3743F7AD940
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 15:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjIYNjW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 09:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjIYNjV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 09:39:21 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5860FFF
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 06:39:15 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c61bde0b4bso14696765ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695649155; x=1696253955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eKlzTcjLE8dmyYbSp67mSfFAcCqOvfM8wch2jpInsyI=;
        b=IwlgH3JaVqRgAfe5QvA4D82+ZQ+nIPNE0MP8Q/Rirgaup/3e0cwODR80PQem3A57/u
         R4m5kbxmkB3js5vwIpuPPMbhVKc6ZZIYCDcz+VfYwNLnUaMYekV1e9mQ4qWuabHTB4JA
         Dpv6vsWCPffnq6BhhtFTf7DUy3uX6eqO9I6j8qpS7aRkfrOaZ5TNWH9AOcIobTyzCxxG
         PuqFXhO5tf/8X9Ncbxe4xgf2/ZPsV68W84ZgR9m6nJFibdaQKrDb6zv9G+Izm++Yl1XL
         t3XN4UAY6nDajWDVZNacq6XtmZg6VlX2uR7QEE0wR97+r1FwNpPLcQr6u/1GMsTwEK9S
         lRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695649155; x=1696253955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eKlzTcjLE8dmyYbSp67mSfFAcCqOvfM8wch2jpInsyI=;
        b=sg7tHLO7gsdSvZoQkpXBVWeAK1SY74F/18JaGBQ3ZWfaaAD5JinIJNLWsG/+tb2SlU
         xSrxfYEI/kyu14PNzhLelhiEkt3h/iWrx2B+rki9gmtI/KpB3XNOvg5MMhW1Gihf8LVe
         8pTA19acZyIa+XYl83nao6cFdFDHYkCNPQJUz5Qc6CJ4vyICROVAkwUs6ft2cGe9CJig
         +beFNIF2gTzQ/fDfIybKKdzfM2HOGh1RrV5qu+SmeZn6igALHceZt76iwg+qc4wj7Qol
         TodoEGsahN/ptHjkqNxO2LxfjqznAhKr4usfN3BvlFSjBBllWIZFjHEs3vPwHvglaj89
         ytmw==
X-Gm-Message-State: AOJu0YwM3NuK33R9yPT80Ezh79yBsgGfXyyvWcu5px19y8Qao0YUkVdP
        z4fxApNkD296SoQdV/KG/J+5sg==
X-Google-Smtp-Source: AGHT+IHS8Wv/g/qamJVplasJy8yBOlFgPURiUvskvgySyTGlNOySwwqAtel1reKcngtN7Jgwh6mD8A==
X-Received: by 2002:a17:902:c950:b0:1c5:db4e:bb2c with SMTP id i16-20020a170902c95000b001c5db4ebb2cmr9270815pla.64.1695649154596;
        Mon, 25 Sep 2023 06:39:14 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902eacb00b001c625d6ffccsm969433pld.129.2023.09.25.06.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:39:14 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 0/9] KVM RISC-V Conditional Operations
Date:   Mon, 25 Sep 2023 19:08:50 +0530
Message-Id: <20230925133859.1735879-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series extends KVM RISC-V to allow Guest/VM discover and use
conditional operations related ISA extensions (namely XVentanaCondOps
and Zicond).

To try these patches, use KVMTOOL from riscv_zbx_zicntr_smstateen_condops_v1
branch at: https://github.com/avpatel/kvmtool.git

These patches are based upon the latest riscv_kvm_queue and can also be
found in the riscv_kvm_condops_v2 branch at:
https://github.com/avpatel/linux.git

Changes since v1:
 - Rebased the series on riscv_kvm_queue
 - Split PATCH1 and PATCH2 of v1 series into two patches
 - Added separate test configs for XVentanaCondOps and Zicond in PATCH7
   of v1 series.

Anup Patel (9):
  dt-bindings: riscv: Add XVentanaCondOps extension entry
  RISC-V: Detect XVentanaCondOps from ISA string
  dt-bindings: riscv: Add Zicond extension entry
  RISC-V: Detect Zicond from ISA string
  RISC-V: KVM: Allow XVentanaCondOps extension for Guest/VM
  RISC-V: KVM: Allow Zicond extension for Guest/VM
  KVM: riscv: selftests: Add senvcfg register to get-reg-list test
  KVM: riscv: selftests: Add smstateen registers to get-reg-list test
  KVM: riscv: selftests: Add condops extensions to get-reg-list test

 .../devicetree/bindings/riscv/extensions.yaml | 13 ++++
 arch/riscv/include/asm/hwcap.h                |  2 +
 arch/riscv/include/uapi/asm/kvm.h             |  2 +
 arch/riscv/kernel/cpufeature.c                |  2 +
 arch/riscv/kvm/vcpu_onereg.c                  |  4 ++
 .../selftests/kvm/riscv/get-reg-list.c        | 71 +++++++++++++++++++
 6 files changed, 94 insertions(+)

-- 
2.34.1

