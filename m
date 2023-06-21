Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63343738981
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 17:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjFUPge (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 11:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjFUPgX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 11:36:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B541706;
        Wed, 21 Jun 2023 08:35:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-988a5383fd4so662539466b.0;
        Wed, 21 Jun 2023 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687361753; x=1689953753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yLC3Qvm8n/w4CH5ToSb5DN8Odh2TdBdFkjR985bJsFU=;
        b=XNNg4geRz6v9Rne19hZvE7dAvG7m5JVqo482JTQxpuo2aiaamcJHYjpGzn/hDYhn4R
         34MbwzgM88Y7NgENR6uA17UWiK/FzRBMbt1DFnUdf/mnGNQNinfxbqTCgaBInMhCjq/6
         iDIClLNEKaInpZedkWU6pP+zF1LqhgBnl4dg2ZXMBVZ/R6gsIStjaGRbimg/YBE0791l
         65L7T1AnG/c1WBy3tN6kQkfY+SaHhzvlga+WLowV4xjOg8hXtcaUv89A8tFbU3d0h1Ny
         BdRGtaLRnrf+kWj5Lxx6BX30XOo9xbnOVazlq7DRD/evPGoK0K+t6rOCUa7/slGjr6Z2
         w+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361753; x=1689953753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLC3Qvm8n/w4CH5ToSb5DN8Odh2TdBdFkjR985bJsFU=;
        b=C5cVaBSDOiMMYM4YrCJtPubyt8eJaZ4qnYTP2HRSdi8tCRCrEWq67uzvxF3ySsr4i0
         jN5bJbZm+RmR3FCQw483ATfoT2CV5FtMUA3wywnZXsM6NN2PvPGTqMAqemkje38beQ0z
         mJjMVswBxExYCZ0Axxc5OUGZ5dbgxLJ4ComNA1mm+6AfatFGmUxsbHTrqfFHWFLYTTzS
         yCu6NJWhbiJoCT4cqGmMl82MUJun2BpIsHwQndF0e5AYhoyloL6Yru17dUWP/rvvK7ja
         CWyymBp67dHqgume0pEtMls2c6/VRpnNTD5p4WbvwrWHsofejqtI7KEiV5QJ1g9pSHmc
         Y/Ng==
X-Gm-Message-State: AC+VfDyNhTBAHctK7grMBuE7RXUUR9vojoPSxCl8z3S3Ipag1dq6bN0z
        ZohV/zsnbu/kccB5cyeLeII=
X-Google-Smtp-Source: ACHHUZ7xMfjgNRfxub1WKJ+EPmb+d8kHugGo/ZZVh5n6Kd95fkq5o9VnmXX478QuZDnsXNW4XE425g==
X-Received: by 2002:a17:906:58cd:b0:989:d9d:d90a with SMTP id e13-20020a17090658cd00b009890d9dd90amr6598582ejs.34.1687361753358;
        Wed, 21 Jun 2023 08:35:53 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-87-21-158-222.retail.telecomitalia.it. [87.21.158.222])
        by smtp.gmail.com with ESMTPSA id r3-20020a170906c28300b00988acf24f9csm3266123ejz.97.2023.06.21.08.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:35:52 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        shuah@kernel.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, riel@surriel.com,
        nphamcs@gmail.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH 0/3] selftests: cgroup: add zswap test program
Date:   Wed, 21 Jun 2023 17:35:45 +0200
Message-Id: <20230621153548.428093-1-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series adds 2 zswap related selftests that verify known and fixed
issues. A new dedicated test program (test_zswap) is proposed since
the test cases are specific to zswap and hosts specific helpers.

The first patch adds the (empty) test program, while the other 2 add an
actual test function each.

Domenico Cerasuolo (3):
  selftests: cgroup: add test_zswap program
  selftests: cgroup: add test_zswap with no kmem bypass test
  selftests: cgroup: add zswap-memcg unwanted writeback test

 tools/testing/selftests/cgroup/.gitignore   |   1 +
 tools/testing/selftests/cgroup/Makefile     |   2 +
 tools/testing/selftests/cgroup/test_zswap.c | 286 ++++++++++++++++++++
 3 files changed, 289 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_zswap.c

-- 
2.34.1

