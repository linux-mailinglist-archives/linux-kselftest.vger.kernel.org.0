Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5553763CE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 18:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjGZQqz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 12:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjGZQqm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 12:46:42 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DC02703
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jul 2023 09:46:35 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb775625e2so8481965ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jul 2023 09:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690389995; x=1690994795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcvGxWKs0ioHSwaNFVtuDJQ1B/8SpZlsoy8QXz36r7I=;
        b=ctlEmW7DMTMNY+Sp7acXqqDtGLdfH554pjXRJaq8fLvxFb/RtQTWgjya5aX8frZUG+
         kWLLX3V5bkPJ8D9sRUV/MwHTEJpB9RCwH6/ndhkksdQtRuU+HRr0zUfscDgxiFSHZA9+
         yIU0ZD4Tam8mQ2WS+5pLZ/c5X4RhjfmHJo3MwLkOOIWTzwMnMBP8Q0wn+W52egZzi2xU
         AAyOixs1odiPKZLEKGezwwzYUkbE2yPosL+ri5v70wHRzK4oQvk1fggscCcK6icuFnGe
         uL29fxGA2FdvaKyJUxHyjHp+jMTQA1xrvEzeIai5Rjkq71aK2LAAFsldGh/eFZfk8xRM
         s+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690389995; x=1690994795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcvGxWKs0ioHSwaNFVtuDJQ1B/8SpZlsoy8QXz36r7I=;
        b=mGm09s0SwS3e3i7hCn95QySBHEylAu8/SwJQihK07rz93L7CJPj5Or5woxzG9enmEy
         ldvK1RdfWxyEJmmVX4KmcCToJIlAGt5lEEgnD9/bYUD0MpV+sFxmtuvf1fgdxxHTZmVt
         HVSgBxCwiXrONVdFb6P28uqHvc07Tkq6F88hL/eiGHBed1MiDheSPVtxhPYG54rsgtn4
         feEVi+pWt+OkhoI4Sr8c7XC/n0bUHaUJzRN/PYOv0pFYpToB5H6HnILYM7OyacPZW37n
         4X2/TxboOUoRIS8MFa0aI0I5joc8OcoZjS352i+EpZ4cilmmrsnOXX8ChssTFsR8J0mY
         7/hQ==
X-Gm-Message-State: ABy/qLZ7SmL3LHAkgpCj45rGW2e4BvnZrMJaWCMSx/C9YR6Ejp967uwm
        wTuV8brFANBW7AeDgYI3V+W8Cg==
X-Google-Smtp-Source: APBJJlHYD5X46sfJHvjFJ8cY7MrqSJBPdDrgEnmRM7T9AiO1YpDySEyimp6MxA9+6dubMdyjQlpBgQ==
X-Received: by 2002:a17:902:c943:b0:1b2:676d:1143 with SMTP id i3-20020a170902c94300b001b2676d1143mr38193pla.15.1690389994874;
        Wed, 26 Jul 2023 09:46:34 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f54500b001bb6c5ff4edsm11628870plf.173.2023.07.26.09.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:46:34 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v7 4/4] RISC-V: mm: Document mmap changes
Date:   Wed, 26 Jul 2023 09:45:58 -0700
Message-ID: <20230726164620.717288-5-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726164620.717288-1-charlie@rivosinc.com>
References: <20230726164620.717288-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
2.41.0

