Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372A55B5C18
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Sep 2022 16:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiILOTb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Sep 2022 10:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiILOT3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Sep 2022 10:19:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D2725C6B
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Sep 2022 07:19:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [213.194.152.135])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6E6586601FE0;
        Mon, 12 Sep 2022 15:19:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662992363;
        bh=t0hmwBQB0U4PXzk9nVZiIzTnxb5vJt9usgBc/sG3RQM=;
        h=From:To:Cc:Subject:Date:From;
        b=KKcisA2ahm8v2yZWEsTpKzoBDgHgJQhGHv51qh9q/wwKOgIyqNOVU3c0lnAd75AEW
         OX5HPktQjzb+LpjKC6mPcDQN1LC6jcw1fCrD8Si/4BB59UYXUerbD05IltXSFtT1Ov
         Zp3mr77h5mQnrSWI+ckr9zkbL47oSVJkrrRbKBHRmFxgidI/37wfJGQKfgj29teBDZ
         Gy/mIeRNtUq7/03wja5Tfl7u9UDAG2/cIMxQ/Q5MbkLP4Cn/eWRZOUyhe5tfW9NGPM
         47t+ojrqEg4JMQ2G9aATUqXP+zMB3y4SZFunvt/figytyWmXhOBjhQC5bH8PR8dCNd
         GQLAWiiXldMXg==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, kernel@collabora.com
Subject: [PATCH] selftests/intel_pstate: fix build for ARCH=x86_64
Date:   Mon, 12 Sep 2022 16:19:08 +0200
Message-Id: <20220912141908.2018562-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Handle the scenario where the build is launched with the ARCH envvar
defined as x86_64.

Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
---
 tools/testing/selftests/intel_pstate/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/intel_pstate/Makefile b/tools/testing/selftests/intel_pstate/Makefile
index 39f0fa2a8fd6..05d66ef50c97 100644
--- a/tools/testing/selftests/intel_pstate/Makefile
+++ b/tools/testing/selftests/intel_pstate/Makefile
@@ -2,10 +2,10 @@
 CFLAGS := $(CFLAGS) -Wall -D_GNU_SOURCE
 LDLIBS += -lm
 
-uname_M := $(shell uname -m 2>/dev/null || echo not)
-ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+ARCH_PROCESSED := $(shell echo $(ARCH) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
-ifeq (x86,$(ARCH))
+ifeq (x86,$(ARCH_PROCESSED))
 TEST_GEN_FILES := msr aperf
 endif
 
-- 
2.25.1

