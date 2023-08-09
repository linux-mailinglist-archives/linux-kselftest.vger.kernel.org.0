Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A615C776CCB
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 01:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjHIXYc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 19:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjHIXYa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 19:24:30 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876F71FC2
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Aug 2023 16:24:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686daaa5f1fso243006b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Aug 2023 16:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691623467; x=1692228267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tar+fwRF9EwexnZBlGXBQ+bino7OPSUOa9FVKEDgW8=;
        b=qdQX3WNwo4sWt4WkjKnJ08HLG31URbRoXVf7H5AnZ3n4OTaa437cOko2jjYggYBNx3
         Uqtl8hjdOaQ5sFdI1pNdsg5WlvudRipmfEHH3jC3kSBPVvsl7sDCBIi9hJH3htjd+Scj
         +x4lyW8BfGjDQRdW6mPcEQh967lWkyY2MfrU8iYYuoqSur4+c4vzP8UjeTWZVpmWsXTi
         GrPLP1dKdTJl7/hWM1px5eML9DIPSblOF40Phwg5YuT2IX5LPipDqccZemKALDv8ntos
         VpDwK38TgYbp1DMAPUyfGhk2yDGhNkoAIbI8xAeXULhQkWloI08NyYlwSj+DJ7tiDJ+v
         bzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691623467; x=1692228267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tar+fwRF9EwexnZBlGXBQ+bino7OPSUOa9FVKEDgW8=;
        b=C4lNToGBdVfrUQH4anUy3yzDqCjXu6646W5zsReYo8aeLh7iJLDFMN8F5waL1auSqV
         wGZ9wU6cycNRJGdfQBvXI+GFubz1kNWCbimvKCJN4pfpG2ON8sys2/NvCBQ+k7zqP0IN
         LKn+Oaopi1/F1nWk1DsqjZTKFGfHElDU19sxGDfhl5Y62Ezpt5eyPhNWW/nxd6a2EUjZ
         3W8wZVxLQCS6mi4sGT/pv7zS6YKSj/p/vXy4plVl/cC9SFmwIqU/P/VdjK9WeSP51wuS
         i+jo2016nrCNr2Xw2E2gH6cKXdnU/nksIrmWzzYdqoz25gG8NiUm7IVi1N4K7nn2SKuf
         5PzQ==
X-Gm-Message-State: AOJu0YwEp545VkM4b7skFztXlM1GoNzc0OLQw5ih8GiC0KgG8MqFnS/M
        FqSa6hqRwnVE4qaLCS5E3lYHJw==
X-Google-Smtp-Source: AGHT+IHPggFTtnxabsF/jkLvnF3G7KP5USE4CizFGjoAWFxir/OOf3x64PmOQQ970Z2IhxBU3MEknw==
X-Received: by 2002:a05:6a20:12c2:b0:131:4808:d5a1 with SMTP id v2-20020a056a2012c200b001314808d5a1mr781717pzg.28.1691623467045;
        Wed, 09 Aug 2023 16:24:27 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001b54d064a4bsm82765plk.259.2023.08.09.16.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:24:26 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v10 4/4] RISC-V: mm: Document mmap changes
Date:   Wed,  9 Aug 2023 16:22:04 -0700
Message-ID: <20230809232218.849726-5-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809232218.849726-1-charlie@rivosinc.com>
References: <20230809232218.849726-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The behavior of mmap is modified with this patch series, so explain the
changes to the mmap hint address behavior.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 Documentation/riscv/vm-layout.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
index 5462c84f4723..69ff6da1dbf8 100644
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
+a hint address to mmap. A hint address passed to mmap will cause the largest
+address space that fits entirely into the hint to be used, unless there is no
+space left in the address space. If there is no space available in the requested
+address space, an address in the next smallest available address space will be
+returned.
+
+For example, in order to obtain 48-bit VA space, a hint address greater than
+:code:`1 << 47` must be provided. Note that this is 47 due to sv48 userspace
+ending at :code:`1 << 47` and the addresses beyond this are reserved for the
+kernel. Similarly, to obtain 57-bit VA space addresses, a hint address greater
+than or equal to :code:`1 << 56` must be provided.
-- 
2.34.1

