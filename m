Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC87192AF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Mar 2020 15:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgCYOTW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 10:19:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:42324 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbgCYOTU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 10:19:20 -0400
IronPort-SDR: vjyoTQg0jyvM4M5OV46TTG/DxYuafbapKcVl0TSyug8xLRNpOnTdzFsMgxahoZva4EkI2hXyyx
 Sx8PLXRMarkg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 07:19:19 -0700
IronPort-SDR: ux9/FqZYumwPtHqSRHQhRwW6ySALvzV344N9CP/GbSZ+/Lp51W8/VhzNb5xos62WI+MLi4fa9O
 c8smGgnGbOxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="270811117"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.39])
  by fmsmga004.fm.intel.com with ESMTP; 25 Mar 2020 07:19:18 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 6/6] selftests: export INSTALL_HDR_PATH if using "O" to specify output dir
Date:   Wed, 25 Mar 2020 22:01:33 +0800
Message-Id: <20200325140133.103236-7-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325140133.103236-1-xiaoyao.li@intel.com>
References: <20200325140133.103236-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When build kvm selftests in tools/testing/selftests directory with

	make O=/path/to/kselftests TARGETS=kvm

it fails building some kvm test binaries due to lack of header files.

Export INSTALL_HDR_PATH when "O" is specified, so that sub TARGET can get
the right kernel headers with INSTALL_HDR_PATH.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index be22dbe94a4c..f36bc6fd8086 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -110,6 +110,10 @@ ARCH           ?= $(SUBARCH)
 export KSFT_KHDR_INSTALL_DONE := 1
 export BUILD
 
+ifneq (1,$(DEFAULT_INSTALL_HDR_PATH))
+export	INSTALL_HDR_PATH := $(BUILD)/usr
+endif
+
 # build and run gpio when output directory is the src dir.
 # gpio has dependency on tools/gpio and builds tools/gpio
 # objects in the src directory in all cases making the src
@@ -142,7 +146,7 @@ khdr:
 ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
 	$(MAKE) --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
 else
-	$(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$$BUILD/usr \
+	$(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$(INSTALL_HDR_PATH) \
 		ARCH=$(ARCH) -C $(top_srcdir) headers_install
 endif
 
-- 
2.20.1

