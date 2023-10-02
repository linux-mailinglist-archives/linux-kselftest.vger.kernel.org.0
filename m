Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9037B51AA
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 13:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjJBLrD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 07:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJBLrC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 07:47:02 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B2BC6;
        Mon,  2 Oct 2023 04:46:59 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57b68555467so1098316eaf.0;
        Mon, 02 Oct 2023 04:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696247219; x=1696852019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVk5KR1wNzlzQ39q1hN4Y07KLXpNDHXN5VrDHX49DM8=;
        b=FkYu0tWPwKRwdK9ekVn2JAnV0Tg++0vDL4WO8vVNlT2UhT+XbwTe07T6xhF2BOmc1i
         ioBHHzI0RS8E0CGh0yx8gEe/V2V9VKqZDoHKpSrHpGtsqFFMZbJg60yLwiF7LHqnDxhN
         ALFDcGMMwbU6hEpHogF+0xAydCBRvz7sQ0gOloABU2kbEZqKbEMFxwwHTldPmTNnlvWs
         pYz3cnKfLUNpXMwyZWAqvIbr7DThFrGeeQ4KUHuX5vr5f+2CCzbZsdLl2JoVovPnLMrh
         DZTvEg/ytnVuLYh0IEyosIX2rmeAJWjzyd4YFn9pbi0c7IBZaPl0gRNWKxRKX6gpQBTE
         MX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696247219; x=1696852019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVk5KR1wNzlzQ39q1hN4Y07KLXpNDHXN5VrDHX49DM8=;
        b=GL30be5RWl0ejqn3CP6YwPNb9aMK1jPkIytLjvy2Y2INeYLcOUZItEVaXJEdFAE+Tv
         RwJu51dorYIXvJAmZF/WmcLhMTsugtqIaBbEE5r1D38BBW+0L9SHfsif1bf07vGxpTZd
         NuquO41goHmpwwSjWqu0a9W1H9f0ZV7YjkFOw+dTb2aT3kIF9r6RvMVVdXFAUPzsZPE0
         +vNny2d59aZF1w24AUdViJt3x6Eu/ujOXVrXalbeN576p3ekfPlJkmXDi1Y7n+J72Sch
         NIiTvdGBLWD2Y3WtnpYGltF18CyUyTmnTCnHIzxIsIoNhzIrRpJ1HtUP8OUsILvm3WRT
         aAOA==
X-Gm-Message-State: AOJu0Yy1ahAZo4zd+Dslhl7lCP3PSKzyrMuYTbIMwJWOMN7fpXS02Alx
        0jW1BaqyJMYF9KS3r91myVc=
X-Google-Smtp-Source: AGHT+IEwUStqiKFWDnWMW5V5pmfpPcUGnYrlpxP9GZBVOUfS+hpnSkU74TkvIR7AkSVJzvljJSmRxA==
X-Received: by 2002:a4a:2542:0:b0:57b:3b64:7ea5 with SMTP id v2-20020a4a2542000000b0057b3b647ea5mr9139908ooe.1.1696247218648;
        Mon, 02 Oct 2023 04:46:58 -0700 (PDT)
Received: from abhinav-IdeaPad-Slim-5-14ABR8.. ([103.75.161.210])
        by smtp.googlemail.com with ESMTPSA id i187-20020a639dc4000000b0050f85ef50d1sm18876426pgd.26.2023.10.02.04.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 04:46:58 -0700 (PDT)
From:   Abhinav <singhabhinav9051571833@gmail.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav <singhabhinav9051571833@gmail.com>
Subject: [PATCH v2] Added missing TARGETS in kselftest top level Makefile
Date:   Mon,  2 Oct 2023 17:16:35 +0530
Message-Id: <20231002114635.1567809-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023100251-recycled-purist-1ea5@gregkh>
References: <2023100251-recycled-purist-1ea5@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

I removed sched, safesetid and filelock from the Makefile, because these
tests were actually triggered when we run 'make run_tests' even though it
has not been mentioned explicitly inside top level Makefile of selftest.

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

