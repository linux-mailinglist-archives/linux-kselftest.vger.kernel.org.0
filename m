Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFBB4B5587
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Feb 2022 17:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346938AbiBNQEW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Feb 2022 11:04:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345126AbiBNQEW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Feb 2022 11:04:22 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6FF4198D;
        Mon, 14 Feb 2022 08:04:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id EE7221F43E14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644854651;
        bh=hhGdfBGp3XEGTgPwWSi2w1YSBb6AMg6JC+TrhGkRd3U=;
        h=From:To:Cc:Subject:Date:From;
        b=VmZnjDBXlO0jFVw0dmKZ0d+fy8kPHcbiFaqywZrdEZNP1Rh1PznhsfXbaFFIiM5GR
         x2fsK3gFeOmLd87l2pgF5SKcsNkFzHWB68deRdWM0NcQo3+g1zONQgtTTC+YQabQzU
         OJUR5g6rnsH61DATvCTUS3CXgXdrqXJhws5p9AaXcnvIOh2DMG+R6nrerZ79etdvhp
         CgM3fkFNJ21gcMY8VRyseVpJ+KyfMiFUAh99516xx8SIoUu0Z4k3BhxNsV1kFncJHj
         jxGY5yIC1+WpjsL+k1asHDwaxUHrxze6UUp4i0oNnMG6zFdEs3HCm76y439/hqrXm/
         RoWaSs06LtSDA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, sherry.yang@oracle.com,
        keescook@chromium.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: Use -isystem instead of -I to include headers
Date:   Mon, 14 Feb 2022 21:03:39 +0500
Message-Id: <20220214160339.3537720-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Selftests need kernel headers and glibc for compilation. In compilation
of selftests, uapi headers from kernel source are used instead of
default ones while glibc has already been compiled with different header
files installed in the operating system. So there can be redefination
warnings from compiler. These warnings can be suppressed by using
-isystem to include the uapi headers.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 4eda7c7c15694..0178b5c801656 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -130,14 +130,16 @@ ifneq ($(KBUILD_OUTPUT),)
   # $(realpath ...) resolves symlinks
   abs_objtree := $(realpath $(abs_objtree))
   BUILD := $(abs_objtree)/kselftest
-  KHDR_INCLUDES := -I${abs_objtree}/usr/include
+  KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
 else
   BUILD := $(CURDIR)
   abs_srctree := $(shell cd $(top_srcdir) && pwd)
-  KHDR_INCLUDES := -I${abs_srctree}/usr/include
+  KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
   DEFAULT_INSTALL_HDR_PATH := 1
 endif
 
+$(info $$KHDR_INCLUDES iss [${KHDR_INCLUDES}])
+
 # Prepare for headers install
 include $(top_srcdir)/scripts/subarch.include
 ARCH           ?= $(SUBARCH)
-- 
2.30.2

