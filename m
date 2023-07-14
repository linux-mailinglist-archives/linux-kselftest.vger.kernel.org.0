Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B822475400C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 18:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbjGNQ4F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 12:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjGNQ4D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 12:56:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADB935AC
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 09:56:01 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8a462e0b0so13039695ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689353761; x=1689958561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iY0BqE22+vH8ihdQ5F+U3lQTo4OY0Ve5Zo6wbRWfHfc=;
        b=ECP+dufnQHsYRxuqgPOTnUSVvIo4ePBLAYzcr/uPu+86xHXRbq559fnQxM4loYgYii
         9q/1Ih5sS/4Nz4IV5XKxNs5M7eNK2wNCyxQPv1SoVXWcMmwbEpzI74Jdn1u5Cczfadul
         jSHTTTzLM34mcqiVS7oXLHnW//LVLHHdygX3s6M81zVFp+Lmjk+KCS/Jt+2NFtsSEwsS
         hM2QAfrxJ4G7EMIqqaMGTDm7wAokuRc+ct0d85q54+SDh5Xc1EJl+Md33rZrNOHTixiq
         BSKIqdZJu/lQ2SebCzY5jdSZwDdpY3w9ELYszKlZ96Lgs1OHBPPpkiA+q8wz6OTq9PHQ
         LbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689353761; x=1689958561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iY0BqE22+vH8ihdQ5F+U3lQTo4OY0Ve5Zo6wbRWfHfc=;
        b=daULb7ZleH3HoPDsBjuCn9sXk5bWiMy3OZsnfwOInKA6Cp4OmiEH42cP9pVGFgYCQE
         sxyh33wXbGsffv+ae61Or2Amxk53kHtTU9vd9S+USyzcSAF3AnPnncfiPYdmgS2r89Fb
         lHD6nyUeNYLrRcxx/uHKEy1lj5gMUVMYMzXacYKGUhgO1YOBHwjFbtHi+PhJQnoS1vAq
         4uKl6IFicwm3lHAw7ZfRE61Tk3wm+Qt0jdsntDznSamPFE0zJvUpA8Z/EGVf0Iab/r5H
         eFCevOjBknr5YaX0mXgfAYsFvCN5fNAJInpSFv9FlmcOrYDT0aWStJQScvBE9UtzBKqC
         nXoA==
X-Gm-Message-State: ABy/qLZvs6D4cGvowNlNawlKSG/qK6ZpyESdyGlgR9ls40VslnqcfYEd
        5mdDAs0QvfHWeALjFP5pfQDJcA==
X-Google-Smtp-Source: APBJJlFsvoNdVZTC5wGAHNOb7OEsPFjJFgSI3IvikXJ3ahp3VMzgfUgYU2kfHESUML2FBAHGPHaiUA==
X-Received: by 2002:a17:903:1248:b0:1b3:d11c:23ca with SMTP id u8-20020a170903124800b001b3d11c23camr4729934plh.8.1689353761143;
        Fri, 14 Jul 2023 09:56:01 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902b18800b001b694140d96sm8008081plr.170.2023.07.14.09.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 09:56:00 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v6 4/4] RISC-V: mm: Document mmap changes
Date:   Fri, 14 Jul 2023 09:54:52 -0700
Message-ID: <20230714165508.94561-5-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714165508.94561-1-charlie@rivosinc.com>
References: <20230714165508.94561-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The behavior of mmap is modified with this patch series, so explain the
changes to the mmap hint address behavior.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/riscv/vm-layout.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
index 5462c84f4723..892412b91300 100644
--- a/Documentation/riscv/vm-layout.rst
+++ b/Documentation/riscv/vm-layout.rst
@@ -133,3 +133,25 @@ RISC-V Linux Kernel SV57
    ffffffff00000000 |  -4     GB | ffffffff7fffffff |    2 GB | modules, BPF
    ffffffff80000000 |  -2     GB | ffffffffffffffff |    2 GB | kernel
   __________________|____________|__________________|_________|____________________________________________________________
+
+
+Userspace VAs
+--------------------
+To maintain compatibility with software that relies on the VA space with a
+maximum of 48 bits the kernel will, by default, return virtual addresses to
+userspace from a 48-bit range (sv48). This default behavior is achieved by
+passing 0 into the hint address parameter of mmap. On CPUs with an address space
+smaller than sv48, the CPU maximum supported address space will be the default.
+
+Software can "opt-in" to receiving VAs from another VA space by providing
+a hint address to mmap. A call to mmap is guaranteed to return an address
+that will not override the unset left-aligned bits in the hint address,
+unless there is no space left in the address space. If there is no space
+available in the requested address space, an address in the next smallest
+available address space will be returned.
+
+For example, in order to obtain 48-bit VA space, a hint address greater than
+:code:`1 << 38` must be provided. Note that this is 38 due to sv39 userspace
+ending at :code:`1 << 38` and the addresses beyond this are reserved for the
+kernel. Similarly, to obtain 57-bit VA space addresses, a hint address greater
+than or equal to :code:`1 << 47` must be provided.
-- 
2.41.0

