Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76715192AEF
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Mar 2020 15:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgCYOTR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 10:19:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:42324 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbgCYOTQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 10:19:16 -0400
IronPort-SDR: d7l3aC7Um9OM+yxINAWhTHFEUhEjP0KPKsn9TcKEJZDVkRFyti/Af/SM/lDA8eodrGLDMm4rpo
 aYdS/4Zqmpxw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 07:19:16 -0700
IronPort-SDR: CEX/lDNwY/UVmG+SfZNiGN6lBwlOu/j8P3BXx3W0dbMmr1Q2hn2HrqpQpXaMbBwmVen1LIxVuq
 xsPqN+YtrvXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="270811108"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.39])
  by fmsmga004.fm.intel.com with ESMTP; 25 Mar 2020 07:19:15 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 4/6] selftests: Create variable INSTALL_HDR_PATH if need to install linux headers to $(OUTPUT)/usr
Date:   Wed, 25 Mar 2020 22:01:31 +0800
Message-Id: <20200325140133.103236-5-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325140133.103236-1-xiaoyao.li@intel.com>
References: <20200325140133.103236-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

So sub TARGETs of selftest can know where the linux headers installed by
checking INSTALL_HDR_PATH.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/lib.mk | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 78fb00bdf5c4..b51ff93da4de 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -35,6 +35,12 @@ top_srcdir ?= ../../../..
 include $(top_srcdir)/scripts/subarch.include
 ARCH		?= $(SUBARCH)
 
+ifndef KSFT_KHDR_INSTALL_DONE
+ifneq (1,$(DEFAULT_INSTALL_HDR_PATH))
+INSTALL_HDR_PATH := $(OUTPUT)/usr
+endif
+endif
+
 # set default goal to all, so make without a target runs all, even when
 # all isn't the first target in the file.
 .DEFAULT_GOAL := all
@@ -59,7 +65,7 @@ ifndef KSFT_KHDR_INSTALL_DONE
 ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
 	make --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
 else
-	make --no-builtin-rules INSTALL_HDR_PATH=$$OUTPUT/usr \
+	make --no-builtin-rules INSTALL_HDR_PATH=$(INSTALL_HDR_PATH) \
 		ARCH=$(ARCH) -C $(top_srcdir) headers_install
 endif
 endif
-- 
2.20.1

