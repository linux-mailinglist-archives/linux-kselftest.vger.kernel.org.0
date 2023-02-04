Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D5768AA3A
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Feb 2023 14:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjBDNg0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Feb 2023 08:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBDNgZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Feb 2023 08:36:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1333769D;
        Sat,  4 Feb 2023 05:36:12 -0800 (PST)
Received: from tincan.fosdem.net (unknown [151.216.142.144])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E86C166029A5;
        Sat,  4 Feb 2023 13:36:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675517771;
        bh=FVDft7SSZZEp5VDB0W0zJGD6iA/FVHvD+bbKj9XTAnU=;
        h=From:To:Cc:Subject:Date:From;
        b=c5Bw7M7gID98YlGOv2vScUbP9iVYqnhHu7W8H+u2ehQmKszgvywyzu9cuB+EuNPRH
         rfjpc3l0/KZjgSMWGv/a8b1qbZAs3F5CD0YgwXEgTOYAXIUnjiPDGwwrVoHblpYbLg
         11Qsx4LUeME6T47KgvI5+A1MQpdyk0fhunUJC7AFctP2BzXqAMRMc7ODLczUBHgLVJ
         PZS1wOBByf5tTTT9pTkchlmGATvWIBf1GPuBWyrxCEv2C33IHPbRTgxfmfeZbztRd3
         stboAjjRtF1T2WBTPES4/aO83nHdvIH+OfqcZNEoIjsJ1d6vGISVZQsrKY9wY2moIA
         73nHd6PJSXHCw==
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Shuah Khan <shuah@kernel.org>, Huang Rui <ray.huang@amd.com>,
        Meng Li <li.meng@amd.com>, Doug Smythies <dsmythies@telus.net>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernelci@lists.linux.dev
Subject: [PATCH] selftests: amd-pstate: fix TEST_FILES
Date:   Sat,  4 Feb 2023 14:34:54 +0100
Message-Id: <20230204133454.260066-1-guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Bring back the Python scripts that were initially added with
TEST_GEN_FILES but now with TEST_FILES to avoid having them deleted
when doing a clean.  Also fix the way the architecture is being
determined as they should also be installed when ARCH=x86_64 is
provided explicitly.  Then also append extra files to TEST_FILES and
TEST_PROGS with += so they don't get discarded.

Fixes: ba2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
Fixes: ac527cee87c9 ("selftests: amd-pstate: Don't delete source files via Makefile")
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 tools/testing/selftests/amd-pstate/Makefile | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
index 5fd1424db37d..c382f579fe94 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -4,10 +4,15 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-uname_M := $(shell uname -m 2>/dev/null || echo not)
-ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+ARCH := $(shell echo $(ARCH) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
-TEST_PROGS := run.sh
-TEST_FILES := basic.sh tbench.sh gitsource.sh
+ifeq (x86,$(ARCH))
+TEST_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
+TEST_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+endif
+
+TEST_PROGS += run.sh
+TEST_FILES += basic.sh tbench.sh gitsource.sh
 
 include ../lib.mk
-- 
2.30.2

