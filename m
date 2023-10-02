Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311D57B4C85
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 09:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbjJBH14 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 03:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbjJBH1z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 03:27:55 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C5DB3;
        Mon,  2 Oct 2023 00:27:52 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c746bc3bceso5191725ad.1;
        Mon, 02 Oct 2023 00:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696231672; x=1696836472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKdhwE6Nvv6dfMJ1charSbuyq7vd9RUBMHfjBdkzVPc=;
        b=hqZf9YuZz6l8x5zAFTQtzmiFa5g2NjkhmVne+dls297+DneybQDtqaliV24t0MKjjI
         2slGIgBWYnab05HSSrPX+CAKoIUKvU9hk6+wZatJMTjG+Cwv8KJ8rimRgyVU1M41LP39
         IkrVe9skTVg8VnG99PCbJHzrngFgQcthx4cjrnqctwFCbjb78tZfUuq4RJEa9HQb7jRK
         t2xJOKGg42+AcT8QY9k5IO8u5TsCI6KTZqLGgS2aeCROrz8kfjShLtGbpzoivrSku3px
         cnvpGtyN5p2tw9Zcla4VQAhTBKH7G080yOL7G/eGWDBW7yLDeghL7SO5L0Z1soqyjtfa
         os0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696231672; x=1696836472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKdhwE6Nvv6dfMJ1charSbuyq7vd9RUBMHfjBdkzVPc=;
        b=rRUKqF4o5rX7UcmVVJ9S6/Dky4jyQWyOv8ZV7VAJ3Gv20PBUakzzgtxTRlpg5yzPqQ
         pYx4cESvSPzi1bQ+wr+vEmpsV/MBMQ4OFScBQ4kMQOCt0zNmLc/CcforoSFrUUeVLB5Y
         EXut83VH0xxj4gj+Og3kZMeBeliM15K34b2n4TR6ZlbUYC9/GG/Lnl2A469JXFepubYa
         fmsyL6wOgPGr5nOOfrrlbwRwWafrLSVN21HZREbpHVPPlS9K3GdzBRNGRssTTZ03qdie
         eWvOj3d9pinV2iS5Bxl/oSCl2qfVQioLKK5CWUeKmL9Z1BjMsu6jJNm+V7wk5VXfU6Im
         1L6w==
X-Gm-Message-State: AOJu0YyZjsgIfXuIu0trU7apnSTR154h9ASEW6OyEWMAkT6kspJ5aU48
        +YNJTavhS4UJD1P3ThInycs0C2B3tNnqmQ==
X-Google-Smtp-Source: AGHT+IHYjn8vbhw0v2ocpkuF8SIWfiwgwx7fIsV29nwtCJY3zotMPH6p6MLpJsCcAJDaxG3ZUVPSFQ==
X-Received: by 2002:a17:903:41c1:b0:1bf:349f:b85c with SMTP id u1-20020a17090341c100b001bf349fb85cmr12573981ple.1.1696231671756;
        Mon, 02 Oct 2023 00:27:51 -0700 (PDT)
Received: from abhinav-IdeaPad-Slim-5-14ABR8.. ([103.75.161.210])
        by smtp.googlemail.com with ESMTPSA id 4-20020a170902c14400b001c755810f89sm4059895plj.181.2023.10.02.00.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 00:27:51 -0700 (PDT)
From:   Abhinav <singhabhinav9051571833@gmail.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav <singhabhinav9051571833@gmail.com>
Subject: [PATCH v2] Added missing TARGETS in kselftest top level Makefile
Date:   Mon,  2 Oct 2023 12:57:35 +0530
Message-Id: <20231002072735.1566009-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023100135-stiffen-depress-8121@gregkh>
References: <2023100135-stiffen-depress-8121@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some tests like dma, ia64, etc. were not present in top level of
selftest Makefile, so when someone ran 'make run_tests' they would miss
these tests. This patches adds those left out tests.

Signed-off-by: Abhinav <singhabhinav9051571833@gmail.com>
---
 tools/testing/selftests/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8d9b2341b79a..dc138c1dcb4b 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -13,6 +13,7 @@ TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += damon
+TARGETS += dma
 TARGETS += dmabuf-heaps
 TARGETS += drivers/dma-buf
 TARGETS += drivers/s390x/uvdevice
@@ -32,17 +33,21 @@ TARGETS += ftrace
 TARGETS += futex
 TARGETS += gpio
 TARGETS += hid
+TARGETS += ia64
 TARGETS += intel_pstate
 TARGETS += iommu
 TARGETS += ipc
 TARGETS += ir
 TARGETS += kcmp
 TARGETS += kexec
+TARGETS += kmod
 TARGETS += kvm
 TARGETS += landlock
 TARGETS += lib
 TARGETS += livepatch
 TARGETS += lkdtm
+TARGETS += locking
+TARGETS += media_tests
 TARGETS += membarrier
 TARGETS += memfd
 TARGETS += memory-hotplug
@@ -66,6 +71,7 @@ TARGETS += pid_namespace
 TARGETS += powerpc
 TARGETS += prctl
 TARGETS += proc
+TARGETS += ptp
 TARGETS += pstore
 TARGETS += ptrace
 TARGETS += openat2
@@ -99,6 +105,7 @@ TARGETS += user
 TARGETS += user_events
 TARGETS += vDSO
 TARGETS += mm
+TARGETS += watchdog
 TARGETS += x86
 TARGETS += zram
 #Please keep the TARGETS list alphabetically sorted
-- 
2.34.1

