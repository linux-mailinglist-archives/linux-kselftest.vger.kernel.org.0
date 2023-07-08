Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418EB74BAF2
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 03:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjGHBM3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 21:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjGHBMY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 21:12:24 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181962128
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jul 2023 18:12:23 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-56661fe27cbso1820752eaf.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jul 2023 18:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688778742; x=1691370742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbN8vPNRnpC2rsql2yMQGj4/q3r+GbD6Fgm8kHqgv+g=;
        b=YFsN5teo2Xz7zOmpo4/u8q+vpC9gfozaUxki8nVKZv9U3t07rRrfE2F4D/Mpc5IR6Y
         g2mhkupBGRVRoam4tBIlKDHh9QI3CglQEfd+e5rWKmh2SSW1KWTgyeQZWx33sFhEiL/R
         zgEzQmy2w6g0b6bkpsyL0pXxNONEUqIbqM5EyF7yTZ4nd+QmM5x5KgzeZtipCgrkcwup
         nNVAWTBHg56PkxtsUwaVwvwNubSbZIkurOLzlb3ihhEr/nv+HyjB0A54Sr6SdIfOKJ3r
         u1doM0X8jjfji3no8jcXuswWv7vTaFA/xQIWTftyN61BawJxTM4bORzaV5IG40o6TLK3
         Hpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688778742; x=1691370742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbN8vPNRnpC2rsql2yMQGj4/q3r+GbD6Fgm8kHqgv+g=;
        b=SxgmIYc0+B+lcZ89yY7EYQGpN9Lwyk12/mZOLzcLFwWZmSZoVod2V1gjIck4wxyMg/
         5ybqm/NSDlmeOgCWE4cMDsCPrWibecfVkVVBaAq9H53X6LG9qw7CyDSmAP07ZJlt97Qo
         veMEVs24jJCD2XvWLBkOLyNuHQm5sonAr21hok9d2XzBKPYUyXoZzVeiktfEQPBZOx7G
         E1t/NMv05fxEPnfaZhUyUQrqI9pzFW4XAfrEWyL6V6BfPrTLIEUEf5m1ZZLWtPXkaGM+
         8lTju4dARr8MolQpzL68xVzoNhVSkZpWR8vUkLSkwJ42D50i7MtI/F1lCahHq9R4mD9p
         P2jg==
X-Gm-Message-State: ABy/qLYqbCpYFqyBz4m8jTQze/Kt/zE1I21Dink9ulnx30700ft6Te0E
        YU99WNFnc/iO+NZkws3Kewa2Ww==
X-Google-Smtp-Source: APBJJlGdindojK5i23bHPXGUqY/0vPqfcqx7SQxTQvxyGmC/pEljPyl1GkowwHsZX51mLjvN1LEySQ==
X-Received: by 2002:a05:6358:2925:b0:125:a552:4389 with SMTP id y37-20020a056358292500b00125a5524389mr7496248rwb.22.1688778742292;
        Fri, 07 Jul 2023 18:12:22 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id x24-20020a170902b41800b001b87d3e845bsm3830654plr.149.2023.07.07.18.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 18:12:21 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org
Subject: [PATCH v4 4/4] RISC-V: mm: Document mmap changes
Date:   Fri,  7 Jul 2023 18:11:35 -0700
Message-ID: <20230708011156.2697409-5-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230708011156.2697409-1-charlie@rivosinc.com>
References: <20230708011156.2697409-1-charlie@rivosinc.com>
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

The behavior of mmap is modified with this patch series, so explain the
changes to the mmap hint address behavior.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/riscv/vm-layout.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
index 5462c84f4723..8141addbf888 100644
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
+Software can "opt-in" to receiving VAs from other VA space by providing
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

