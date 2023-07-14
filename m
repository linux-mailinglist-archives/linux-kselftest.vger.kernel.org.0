Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BA2752E38
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 02:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjGNAPX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 20:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbjGNAPU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 20:15:20 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A42D30D7
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 17:15:09 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6687096c6ddso946708b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 17:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689293709; x=1689898509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iY0BqE22+vH8ihdQ5F+U3lQTo4OY0Ve5Zo6wbRWfHfc=;
        b=xExIMHzLTtkjN2LFQngS3OX4jDs1xLdIX7r/tiDx0kppQfQRkPMYGwyfuGwrBTa86a
         XoaNrcUcmG5pmtq3t+bqbkNwiHPqfObctew9lUGCvXVSRZ5ZMzwxuDl5bh0kXZqCOeN/
         2KOkMuhJYkV6QfPobPU9mX56qewrBddlJ17DJjsRmikAwwn6WVy6MHjfUpM665kqgqnx
         8Vd77tSJfClsrB+dbBunC3han9WPucnmhgEbe2AxB1x5RWqedcL/TQmo7JAbJuXl1Q+J
         +JuGlcjr4IzBotD3ZK9zOhKx+93UelIHVMWCiiWjS83cS6p52MDULRTAs1+X2jnehbH9
         5cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689293709; x=1689898509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iY0BqE22+vH8ihdQ5F+U3lQTo4OY0Ve5Zo6wbRWfHfc=;
        b=QA/Fa35s5SuXFafS+S84bmcLN8gee+Qcq/IgR4WhpOc79vPDsumGQPPU+K5w4Yv9Ah
         x8N3zQ22Nrdo4IOkV2DBagHMQX6fVnM3hqianWZOlP1b3/mzl+vuRj0TSVTYaGX6VjwH
         oUYWpwFZ20k0/g0EsgeHFoHv1l4Y77k9rdFjrPpkXSxbAt0ljTDlfdLswOZckrTVND6Q
         mpaAvHnQgQnZqIyI/wfskW44jCAiUrkka/DGqijYVcqv7GLz80t8TR+aZVsLBkFmHHSm
         F6UtkW4vYe5XXHKE/MrXU3AosMG5txuKj22r/HOVbM0sb5FQ7VuxqVkn8JlyPSVZJ6JD
         LJTg==
X-Gm-Message-State: ABy/qLaGB2ivPr7WWRp57syGXwp/nYAPc12Ve/mTlFaOGmMByappx7vQ
        lKA1HuI2uYQzkNf/hxC1VfHldw==
X-Google-Smtp-Source: APBJJlE/NehJK/yZ31QQ51ruFcoOUZ8Dr5gN8omHKM50vUTZXpJ3oVnR2nhUcvBJtDwEUljTcHiqAg==
X-Received: by 2002:a05:6a00:2d84:b0:666:8cbb:6e0f with SMTP id fb4-20020a056a002d8400b006668cbb6e0fmr3042793pfb.3.1689293708687;
        Thu, 13 Jul 2023 17:15:08 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id x25-20020aa793b9000000b00673e652985esm5938107pff.44.2023.07.13.17.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 17:15:08 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v5 4/4] RISC-V: mm: Document mmap changes
Date:   Thu, 13 Jul 2023 17:14:03 -0700
Message-ID: <20230714001430.75798-5-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714001430.75798-1-charlie@rivosinc.com>
References: <20230714001430.75798-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

