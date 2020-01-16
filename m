Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E603013FB54
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 22:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388890AbgAPVWM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 16:22:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:38731 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388914AbgAPVWM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 16:22:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 13:22:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="226870974"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga006.jf.intel.com with ESMTP; 16 Jan 2020 13:22:11 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>,
        "linux-kselftest" <linux-kselftest@vger.kernel.org>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [RESEND PATCH v9 13/13] selftests/resctrl: Add the test in MAINTAINERS
Date:   Thu, 16 Jan 2020 13:32:46 -0800
Message-Id: <1579210366-55429-14-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
References: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The resctrl selftest will be maintained by RDT maintainers.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b16b72ae6cd6..4932ea7ced15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13833,6 +13833,7 @@ S:	Supported
 F:	arch/x86/kernel/cpu/resctrl/
 F:	arch/x86/include/asm/resctrl_sched.h
 F:	Documentation/x86/resctrl*
+F:	tools/testing/selftests/resctrl/
 
 READ-COPY UPDATE (RCU)
 M:	"Paul E. McKenney" <paulmck@kernel.org>
-- 
2.19.1

