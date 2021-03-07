Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BC233024F
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 15:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhCGOze (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 09:55:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:5870 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231604AbhCGOzK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 09:55:10 -0500
IronPort-SDR: o3clmvPJVTzDBGURaLbJyiffBH0AAgqq6UoQDNY+zza+e8JGBUcTuXqBA5g6dOSGvYHjEj1e43
 /Ru9XPWHa3TQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="167813497"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="167813497"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 06:55:10 -0800
IronPort-SDR: PWIQZ0yPxf3HDC6vxlVZ3nvwq8mz/0/FtSoPO3aZx4uMokun1LjB+I456O5F6nchEjEcGua/VZ
 cmHsdMw4k4Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="437189118"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2021 06:55:10 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 11/21] selftests/resctrl: Add config dependencies
Date:   Sun,  7 Mar 2021 14:54:52 +0000
Message-Id: <20210307145502.2916364-12-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210307145502.2916364-1-fenghua.yu@intel.com>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the config file for test dependencies.

Suggested-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
Change Log:
v5:
- Add this patch (Shuah)

 tools/testing/selftests/resctrl/config | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/config

diff --git a/tools/testing/selftests/resctrl/config b/tools/testing/selftests/resctrl/config
new file mode 100644
index 000000000000..8d9f2deb56ed
--- /dev/null
+++ b/tools/testing/selftests/resctrl/config
@@ -0,0 +1,2 @@
+CONFIG_X86_CPU_RESCTRL=y
+CONFIG_PROC_CPU_RESCTRL=y
-- 
2.30.1

