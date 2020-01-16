Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 967C413FB59
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 22:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388862AbgAPVWJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 16:22:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:38730 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731198AbgAPVWJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 16:22:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 13:22:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="226870932"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga006.jf.intel.com with ESMTP; 16 Jan 2020 13:22:08 -0800
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
Subject: [RESEND PATCH v9 03/13] selftests/resctrl: Read memory bandwidth from perf IMC counter and from resctrl file system
Date:   Thu, 16 Jan 2020 13:32:36 -0800
Message-Id: <1579210366-55429-4-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
References: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

Total memory bandwidth can be monitored from perf IMC counter and from
resctrl file system. Later the two will be compared to verify the total
memory bandwidth read from resctrl is correct.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Co-developed-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/resctrl_val.c

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
new file mode 100644
index 000000000000..0ca4c9252516
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory bandwidth monitoring and allocation library
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl.h"
+
+#define UNCORE_IMC		"uncore_imc"
+#define READ_FILE_NAME		"events/cas_count_read"
+#define WRITE_FILE_NAME		"events/cas_count_write"
+#define DYN_PMU_PATH		"/sys/bus/event_source/devices"
+#define SCALE			0.00006103515625
+#define MAX_IMCS		20
+#define MAX_TOKENS		5
+#define READ			0
+#define WRITE			1
+#define CON_MON_MBM_LOCAL_BYTES_PATH				\
+	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
+
+#define CON_MBM_LOCAL_BYTES_PATH		\
+	"%s/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
+
+#define MON_MBM_LOCAL_BYTES_PATH		\
+	"%s/mon_groups/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
+
+#define MBM_LOCAL_BYTES_PATH			\
+	"%s/mon_data/mon_L3_%02d/mbm_local_bytes"
+
+struct membw_read_format {
+	__u64 value;         /* The value of the event */
+	__u64 time_enabled;  /* if PERF_FORMAT_TOTAL_TIME_ENABLED */
+	__u64 time_running;  /* if PERF_FORMAT_TOTAL_TIME_RUNNING */
+	__u64 id;            /* if PERF_FORMAT_ID */
+};
+
+struct imc_counter_config {
+	__u32 type;
+	__u64 event;
+	__u64 umask;
+	struct perf_event_attr pe;
+	struct membw_read_format return_value;
+	int fd;
+};
+
+static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
+
+void membw_initialize_perf_event_attr(int i, int j)
+{
+	memset(&imc_counters_config[i][j].pe, 0,
+	       sizeof(struct perf_event_attr));
+	imc_counters_config[i][j].pe.type = imc_counters_config[i][j].type;
+	imc_counters_config[i][j].pe.size = sizeof(struct perf_event_attr);
+	imc_counters_config[i][j].pe.disabled = 1;
+	imc_counters_config[i][j].pe.inherit = 1;
+	imc_counters_config[i][j].pe.exclude_guest = 0;
+	imc_counters_config[i][j].pe.config =
+		imc_counters_config[i][j].umask << 8 |
+		imc_counters_config[i][j].event;
+	imc_counters_config[i][j].pe.sample_type = PERF_SAMPLE_IDENTIFIER;
+	imc_counters_config[i][j].pe.read_format =
+		PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING;
+}
+
+void membw_ioctl_perf_event_ioc_reset_enable(int i, int j)
+{
+	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_RESET, 0);
+	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_ENABLE, 0);
+}
+
+void membw_ioctl_perf_event_ioc_disable(int i, int j)
+{
+	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_DISABLE, 0);
+}
+
+/*
+ * get_event_and_umask:	Parse config into event and umask
+ * @cas_count_cfg:	Config
+ * @count:		iMC number
+ * @op:			Operation (read/write)
+ */
+void get_event_and_umask(char *cas_count_cfg, int count, bool op)
+{
+	char *token[MAX_TOKENS];
+	int i = 0;
+
+	strcat(cas_count_cfg, ",");
+	token[0] = strtok(cas_count_cfg, "=,");
+
+	for (i = 1; i < MAX_TOKENS; i++)
+		token[i] = strtok(NULL, "=,");
+
+	for (i = 0; i < MAX_TOKENS; i++) {
+		if (!token[i])
+			break;
+		if (strcmp(token[i], "event") == 0) {
+			if (op == READ)
+				imc_counters_config[count][READ].event =
+				strtol(token[i + 1], NULL, 16);
+			else
+				imc_counters_config[count][WRITE].event =
+				strtol(token[i + 1], NULL, 16);
+		}
+		if (strcmp(token[i], "umask") == 0) {
+			if (op == READ)
+				imc_counters_config[count][READ].umask =
+				strtol(token[i + 1], NULL, 16);
+			else
+				imc_counters_config[count][WRITE].umask =
+				strtol(token[i + 1], NULL, 16);
+		}
+	}
+}
-- 
2.19.1

