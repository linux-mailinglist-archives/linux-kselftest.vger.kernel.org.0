Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2AF74066A
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 00:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjF0WXP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 18:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjF0WXP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 18:23:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071551FF0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 15:23:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b51488ad67so27963265ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 15:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687904593; x=1690496593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc8gTI3W4RW6dHKji0wpJv9Z8xook1q3V9GncqmxBNs=;
        b=LAT8nPi6+wPrYAAarEcLR//bannYKxM8K2dl8ard+Y2T6mC9jXOCXNcLymbItILWIH
         /+H7q2vAEnLRtuwthXmhTqhSVBpIHecv+WxeBEQVTiJ2w7paLH2FctuZjJ5duvgdkbcj
         AIqTdsBNVUzyOEnJREJTHReyK2k34ws/RMgINpSix9QKQDuWwZroz0aVAGIQWhtjZTRh
         fp6hWKMyp1zNuJEbEwFRzTbaAjWOAKUX6oavJwTLtXzpB1jrw+5jdM/GHgFGmHvzLA/B
         BS16AMVlhBO4yMR5F3Q73dbS991hIP9AK3JozP+KoWMnN9yakmMjccjrKTeo7hZPEwUM
         Yu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687904593; x=1690496593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mc8gTI3W4RW6dHKji0wpJv9Z8xook1q3V9GncqmxBNs=;
        b=CdW0qQv6qHOiggIkbmagp4LNZaIorZ1hu8yoA7/ezQrcUGDYWjCrrWFebuXgj026Di
         yLN6+vmq88bVDmf5SVIB/gzLQVzlvDwCW0zWnFdQHkj4AyQbJ7ozNsZs/D729yaUOv3X
         L3vfoL1t79c1CxAh0I2yUdt/IEuhTKspgbaFTR/1u+1853koqNYBCLvyWnArzUOpq/7u
         WxEYDwsJLYOkW7wjs/+tUmysn5aO+081HsKgwymEE2jKBuhg8PSTRnw0a7Bx+zCSV5EY
         +Ao9kb0CtX63tpKu/KDVeg2iiRWdU9LcdaurzmzSmxHh78vxZxFLNGmRFiRNyIrtfpET
         8NjQ==
X-Gm-Message-State: AC+VfDy2jbgUXOvvRt6tSkQsEjiMMDlX/G32YN9j+3gV5t3DP+6k1TLh
        2AzashMpqLDSRde7i+tV2A8dIg==
X-Google-Smtp-Source: ACHHUZ5dzHKMQEs5WRpPvm7HuTITuvtAXHdpkIka0TGrn0KnIqw30wJDTznkQRgHRkjUNqcdLIe4ag==
X-Received: by 2002:a17:902:c403:b0:1b3:fafd:11c5 with SMTP id k3-20020a170902c40300b001b3fafd11c5mr10089706plk.44.1687904593551;
        Tue, 27 Jun 2023 15:23:13 -0700 (PDT)
Received: from ghost.hq.rivosinc.com ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c24400b001ac94b33ab1sm5108271plg.304.2023.06.27.15.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 15:23:12 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     alexghiti@rivosinc.com
Cc:     charlie@rivosinc.com, atishp@rivosinc.com, conor@kernel.org,
        paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, bjorn@rivosinc.com, anup@brainfault.org,
        evan@rivosinc.com, linux-riscv@lists.infradead.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/2] Make SV39 the default address space
Date:   Tue, 27 Jun 2023 15:21:50 -0700
Message-Id: <20230627222152.177716-1-charlie@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make sv39 the default address space for mmap as some applications
currently depend on this assumption. The RISC-V specification enforces
that bits outside of the virtual address range are not used, so
restricting the size of the default address space as such should be
temporary. A hint address passed to mmap will cause the largest address
space that fits entirely into the hint to be used. If the hint is less
than or equal to 1<<38, a 39-bit address will be used. After an address
space is completely full, the next smallest address space will be used.

Documentation is also added to the RISC-V virtual memory section to explain
these changes.

Charlie Jenkins (2):
  RISC-V: mm: Restrict address space for sv39,sv48,sv57
  RISC-V: mm: Update documentation and include test

 Documentation/riscv/vm-layout.rst             | 20 ++++++++
 arch/riscv/include/asm/elf.h                  |  2 +-
 arch/riscv/include/asm/pgtable.h              | 21 ++++++--
 arch/riscv/include/asm/processor.h            | 41 +++++++++++++---
 tools/testing/selftests/riscv/Makefile        |  2 +-
 tools/testing/selftests/riscv/mm/Makefile     | 22 +++++++++
 .../selftests/riscv/mm/testcases/mmap.c       | 49 +++++++++++++++++++
 7 files changed, 144 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/mm/Makefile
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap.c


base-commit: eef509789cecdce895020682192d32e8bac790e8
-- 
2.34.1

