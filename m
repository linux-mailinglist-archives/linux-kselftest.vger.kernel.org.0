Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616845F9873
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Oct 2022 08:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiJJGjx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Oct 2022 02:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiJJGjw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Oct 2022 02:39:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552AD1263A
        for <linux-kselftest@vger.kernel.org>; Sun,  9 Oct 2022 23:39:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [213.194.152.135])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 249846602298;
        Mon, 10 Oct 2022 07:39:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665383985;
        bh=1Ut9IDHGTYcghgsoMMqfibgr8juaexcW2Xr+KgU03q4=;
        h=From:To:Cc:Subject:Date:From;
        b=V92TpgjJSuyBgtWfd8WC3aUfHJCjkfRfsMN0i1ODmI8jmcrL6EdtadlzrudkMElcF
         KdnsLaZa5WAiqmiT+SevVSp0zSdVeU1b4MHv4ZDn4tmyQiT9dfWWUidByRvwUVDLNw
         SrVsQKXzHeeFWByc9mONX66I/DXocf9Qv5w5kg43ZTEROGd2D6dPquNWa4map2pIZy
         RDapR+z4Zdym9jlcgotydkg/RdIflesbmlxZLVQ3LyFw92Nuq+k8PaRwRBc3SAKHaA
         zdFCW1GRcRskKHbJGLfd6wmq35hhIdCqHvhkB55iiPWjartuKspJqT4q7ZSpcnio/E
         isRIez3ekbq1w==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, kernel@collabora.com
Subject: [RESEND PATCH] selftests/kexec: fix build for ARCH=x86_64
Date:   Mon, 10 Oct 2022 08:39:27 +0200
Message-Id: <20221010063927.1323622-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

