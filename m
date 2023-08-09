Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C5A775093
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 03:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjHIBxR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 21:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjHIBxP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 21:53:15 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBCA1BF0
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 18:53:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc73a2b0easo16668045ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Aug 2023 18:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691545992; x=1692150792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tar+fwRF9EwexnZBlGXBQ+bino7OPSUOa9FVKEDgW8=;
        b=FPpY5cIUXnip2ZGbpSphNOYtcmoz+9UqNCzoKTIuGrXSltzFcKRrlt8IZVpkHLRqCx
         OnkTugPfEWDKKQRJ75G2J1aJXt6PH8fts5QVkJJs8njOPLx6pNBBDKHzo/kPhqxS0sx3
         1HU8/tEpAVmLFR+F4zwPNJwDwa/GS5jdzeVtMhkd3NlduxYlQA9dfzjF/ys4sjj6OEtk
         sjDMhjLy6jjBKzFs07exQfX4lKo012NsKC4Zu68gj0Uv/D7Nb/c/EwcN8oQMkTg6va+w
         mYmQCyjU8OGyh+PyGz8lSNWVUIf8yU596h/YkYk7J+SNhMSNxobFIMZoGtxQE5T5cv3X
         /BDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691545992; x=1692150792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tar+fwRF9EwexnZBlGXBQ+bino7OPSUOa9FVKEDgW8=;
        b=LADtlYBSG0TEVlpxK7vcOlcCopwVymWEJnlq6xhtHP/Epn8QzqpkD41Uz8UUgsmCZr
         jxVSL5KA/yg5WZeQkzlm+CQgWQZWYqr0zcN5Fbn4AsQvsK9XfHqSkRKsd+z37Prj/Nn/
         ThyL7Q+dYWmphxiAe14fxF4ZuhyNMjd/kHCgNdEFioYk1Ej4Cf5YV0dQMpl9//msuICp
         bnRIPZo2S+qVOHCRvIsmJvIwKF6UN1RRHRzgaDFcmCXlBiQAEbCzgg1cgoh81w3c2CWF
         yH8q6TeSRJK6G5L31NRxCF5ajrxS0SribyExRknn3xgIkNDTRZaQl6M2K5/lz88h+VGl
         mVpQ==
X-Gm-Message-State: AOJu0YyQB0MD3AgY2yLk8zYwUHlTrvOGWnijNYoxPAFGNgKjkxWDU3HL
        O1qKiVzaRSRkRlwMa4YiBxAKUA==
X-Google-Smtp-Source: AGHT+IGZcbmVCa5ZDQZDqMBC5RXy8ZlAEnBSQVfL2GCWuQwF+OUfXTklfpU8ydkeXzNNensTQj2vcA==
X-Received: by 2002:a17:903:1207:b0:1b8:6850:c3c4 with SMTP id l7-20020a170903120700b001b86850c3c4mr1594061plh.22.1691545992539;
        Tue, 08 Aug 2023 18:53:12 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id bj7-20020a170902850700b001b87bedcc6fsm9657591plb.93.2023.08.08.18.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 18:53:12 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v9 4/4] RISC-V: mm: Document mmap changes
Date:   Tue,  8 Aug 2023 18:51:10 -0700
Message-Id: <20230809015110.3290774-5-charlie@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809015110.3290774-1-charlie@rivosinc.com>
References: <20230809015110.3290774-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
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

