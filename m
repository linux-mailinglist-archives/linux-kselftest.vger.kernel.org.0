Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC47769941
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 16:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjGaORx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 10:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjGaORu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 10:17:50 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B4512D;
        Mon, 31 Jul 2023 07:17:48 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686f19b6dd2so2905303b3a.2;
        Mon, 31 Jul 2023 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690813067; x=1691417867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+JwN4zjNlnKq9ahXjNAMvm1OlnYz1L5/k1djbBLAuVk=;
        b=D0OSdpadmt0AbkOxx3JJs8yb36P2j1IMhCr89XyQ9Mi77lui4O+uFJuzwwinjk9o58
         6A6dFBdMEFsDeBZu8S0zM9kW8XtYLvskSO3ZoYUpdVcRc79/IvhGRZ5RUOLxzKEAVolP
         NOZ9R8Z+geOhCWLHFbP++C0LXqjg9hkA5BN4D6pd+zeQJB9kOTmoKf8d4eWwBPS6cMV6
         xWR2aQ42vQb2xiKsHWjaZTTqC+O0adA2IAOH3BAYhP6qoRC1Y8QMJSNR05M1naXaqIef
         aMzSomt7z6olrRh1up/MOEVcd6XBu+Eqdv4hLXdxf+p5URjLlj2wQizvLsqiQTWFwthb
         dthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690813067; x=1691417867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JwN4zjNlnKq9ahXjNAMvm1OlnYz1L5/k1djbBLAuVk=;
        b=IlcfPtEJyzP/a8usvY2BjIOPGvT6BqZcBiAM2Z9MfF42ez7Um4E2Oi+FR97yb2uzLi
         shEu3sa3Us5d9zczvYooftjExD8JHPGGzawVXe56Koy/s9YMBnwRkkjM0BW9eIraK538
         1otOq2qXa8MZ+B7SMYW5669y5mCdKz5XEU1CXg+gXgqo0QHTUod7joIHSIDdsEqw6FCX
         ZtvUCsxpDUPb9RS8DtpjM3bpARiRjMiHO8LyvDD38TY7/4IOl8/UbLpbHllOvag3c0BZ
         nO2++8vvV+5VXi7O2dY+DRwQsHEGpbnZz3JcSoHRO2McRzGZrfFE2JDiKpwecXHVKc8r
         7ScQ==
X-Gm-Message-State: ABy/qLZBzQq2/gD5nhuQiMPgjme0S+bJndFI3Y96lGnWalvT9OMRYLOS
        Tfzlp44+HkbVZA4MeHhL6rA=
X-Google-Smtp-Source: APBJJlFWq0XGw17Y4+grA0UBN8iAez2xGZtZ6F7hEBM5c/Gx6WLmA4fHl6xFM5cpVTzHqPsvL0FM+A==
X-Received: by 2002:a05:6a20:3d02:b0:12c:e3c8:8c7 with SMTP id y2-20020a056a203d0200b0012ce3c808c7mr11206785pzi.41.1690813066805;
        Mon, 31 Jul 2023 07:17:46 -0700 (PDT)
Received: from fanta-System-Product-Name.. ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id f13-20020aa782cd000000b0064f76992905sm1965739pfn.202.2023.07.31.07.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 07:17:46 -0700 (PDT)
From:   Anh Tuan Phan <tuananhlfc@gmail.com>
To:     mathieu.desnoyers@efficios.com, peterz@infradead.org,
        paulmck@kernel.org, boqun.feng@gmail.com, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Anh Tuan Phan <tuananhlfc@gmail.com>
Subject: [PATCH] selftests/rseq: Fix unknown type name __weak for gcc 11.3.0
Date:   Mon, 31 Jul 2023 21:17:33 +0700
Message-Id: <20230731141733.25059-1-tuananhlfc@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the definition of the '__weak' attribute since it is not available in
GCC 11.3.0 and newer:

rseq.c:41:1: error: unknown type name ‘__weak’
   41 | __weak ptrdiff_t __rseq_offset;

Fixes: 3bcbc20942db ("selftests/rseq: Play nice with binaries statically linked against glibc 2.35+")
Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
---
 tools/testing/selftests/rseq/rseq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index a723da253244..584eec9b0930 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -34,6 +34,10 @@
 #include "../kselftest.h"
 #include "rseq.h"
 
+#ifndef __weak
+#define __weak __attribute__((weak))
+#endif
+
 /*
  * Define weak versions to play nice with binaries that are statically linked
  * against a libc that doesn't support registering its own rseq.
-- 
2.34.1

