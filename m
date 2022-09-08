Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D445B1DC3
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Sep 2022 14:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiIHM6O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 08:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiIHM6J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 08:58:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE8C9CCDF
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Sep 2022 05:58:08 -0700 (PDT)
Received: from localhost.localdomain (unknown [213.194.152.135])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6FE466601F8F;
        Thu,  8 Sep 2022 13:58:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662641886;
        bh=1Ut9IDHGTYcghgsoMMqfibgr8juaexcW2Xr+KgU03q4=;
        h=From:To:Cc:Subject:Date:From;
        b=mqY0vKnwg51PzBWy22L9fiT3R3/cs5BxJTJqfufdZZ2vWH+tM+chgg0Ouzyf76pxh
         NsJartAvv7djtqwAHqrTNFtsyYUH9h4ViKXxCm9l0Kn4IjkNZJdj9bLjVScGFMpF2I
         LEFbTYzVEGO+HkCInB2rWeSNc/AWz26w90tRQco2wZ+FZ6R4p+4xKgSXofi5J3BCRp
         xBWboI1zvpEzgUnf0+h5iLHQSRzVoeSyBquR1BCHyvf+xoPphZTguVBWlLUEn5PV0W
         yGwORAQ8YvC8OEiiFp8YT7ZZgS7phS2/o0oi2HwAUNHyusEY/XauKCUxOYh1gdKrP+
         4EewAKYN4Rkig==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, kernel@collabora.com
Subject: [PATCH] selftests/kexec: fix build for ARCH=x86_64
Date:   Thu,  8 Sep 2022 14:57:49 +0200
Message-Id: <20220908125749.1711044-1-ricardo.canuelo@collabora.com>
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
 tools/testing/selftests/kexec/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
index 806a150648c3..67fe7a46cb62 100644
--- a/tools/testing/selftests/kexec/Makefile
+++ b/tools/testing/selftests/kexec/Makefile
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Makefile for kexec tests
 
-uname_M := $(shell uname -m 2>/dev/null || echo not)
-ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+ARCH_PROCESSED := $(shell echo $(ARCH) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
-ifeq ($(ARCH),$(filter $(ARCH),x86 ppc64le))
+ifeq ($(ARCH_PROCESSED),$(filter $(ARCH_PROCESSED),x86 ppc64le))
 TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh
 TEST_FILES := kexec_common_lib.sh
 
-- 
2.25.1

