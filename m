Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A871936DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 04:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgCZDZf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 23:25:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:53303 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbgCZDZe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 23:25:34 -0400
IronPort-SDR: l6DxRvyZmYypsM5UXg0z+8FoC/FymFGj+N/iYD65bXOgNEmPckZj6A3BkcR/t10z/yd4jsP+vW
 A27dT4u8fDLQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 20:25:33 -0700
IronPort-SDR: LXjqAhcF6kDMzEy0by7c8b642y5+g9LGiqo6QedAJkauKrkA6dwIpeKt0KeAqWEHLG3W8rhJqF
 tz6vmJ2tAl3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,306,1580803200"; 
   d="scan'208";a="446842833"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.39])
  by fmsmga005.fm.intel.com with ESMTP; 25 Mar 2020 20:25:32 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [RFC v3 3/3] kvm: selftests: Fix header path when built from parent level with O specified
Date:   Thu, 26 Mar 2020 11:07:50 +0800
Message-Id: <20200326030750.173972-4-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326030750.173972-1-xiaoyao.li@intel.com>
References: <20200326030750.173972-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When build kvm selftests in tools/testing/selftests directory with

	make O=/home/lxy/kselftests TARGETS=kvm

it fails building some kvm test binaries due to lack of header files,
e.g.,

  x86_64/vmx_set_nested_state_test.c: In function ‘set_default_vmx_state’:
  x86_64/vmx_set_nested_state_test.c:85:7: error: ‘struct
  kvm_nested_state’ has no member named ‘hdr’
    state->hdr.vmx.vmxon_pa = 0x1000;
  ...

With "O" is specified, it also takes effect on "make headers_install",
which causes no header files generated in "kernel-src/usr".

Fix INSTALL_HDR_PATH with correct path for this case.

Opportunistically fix the case when KBUILD_OUTPUT specified as well,
even though it can work currently.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/kvm/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 6a95878b2ab7..bf8f56488914 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -50,7 +50,11 @@ ifeq (0,$(MAKELEVEL))
 	INSTALL_HDR_PATH := $(top_srcdir)/usr
     endif
 else
+    ifneq ($(O)$(KBUILD_OUTPUT),)
+	INSTALL_HDR_PATH := $(BUILD)/usr
+    else
 	INSTALL_HDR_PATH := $(top_srcdir)/usr
+    endif
 endif
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
-- 
2.20.1

