Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1DB33AF42
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Mar 2021 10:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhCOJtp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Mar 2021 05:49:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:53018 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhCOJtm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Mar 2021 05:49:42 -0400
IronPort-SDR: vlyfWj7s5VqZT2DHOROlMd+D0X3yvfWmqKk/XD3/rY7ZYURQujG6TweKgeKjoRBlr9rHGaETeb
 KQ1EvAQkeCEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="186683205"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="186683205"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 02:49:42 -0700
IronPort-SDR: ju2PdNjCk2vkHJj2p/UeomQy3cAGMMXMMz5NIaXdre6EMJKBqsfwMgnUVG8kP1AqbWm11r1zZe
 3NTQrvJaH4JQ==
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="411782993"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 02:49:40 -0700
From:   Rong Chen <rong.a.chen@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/vm: fix out-of-tree build
Date:   Mon, 15 Mar 2021 17:47:00 +0800
Message-Id: <20210315094700.522753-1-rong.a.chen@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When building out-of-tree, attempting to make target from $(OUTPUT) directory:

  make[1]: *** No rule to make target '$(OUTPUT)/protection_keys.c', needed by '$(OUTPUT)/protection_keys_32'.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Rong Chen <rong.a.chen@intel.com>
---
 tools/testing/selftests/vm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 4cbc91d6869f..73e1cc96d7c2 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -102,7 +102,7 @@ endef
 ifeq ($(CAN_BUILD_I386),1)
 $(BINARIES_32): CFLAGS += -m32
 $(BINARIES_32): LDLIBS += -lrt -ldl -lm
-$(BINARIES_32): %_32: %.c
+$(BINARIES_32): $(OUTPUT)/%_32: %.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(notdir $^) $(LDLIBS) -o $@
 $(foreach t,$(TARGETS),$(eval $(call gen-target-rule-32,$(t))))
 endif
@@ -110,7 +110,7 @@ endif
 ifeq ($(CAN_BUILD_X86_64),1)
 $(BINARIES_64): CFLAGS += -m64
 $(BINARIES_64): LDLIBS += -lrt -ldl
-$(BINARIES_64): %_64: %.c
+$(BINARIES_64): $(OUTPUT)/%_64: %.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(notdir $^) $(LDLIBS) -o $@
 $(foreach t,$(TARGETS),$(eval $(call gen-target-rule-64,$(t))))
 endif
-- 
2.20.1

