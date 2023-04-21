Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A096EAC9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 16:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDUOR6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 10:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjDUORs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 10:17:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8363CE50
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:17:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54c2999fdc7so27601737b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682086666; x=1684678666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9ehmzwOW4Qc9gQvpwM/ZZofEU4OqXe1UUgzo44mFis=;
        b=jQ/EfbElWOoD7Q5RcZ9PEMa2xeB33n91soMxfAboXtG9IdbuenydvfqGJRJs173o0i
         vupY0UegJS39vUDZPWg//Oym1AxFL0seSvyqJuJ2iCaBeWL8/gw7JMqp4PQ7JqaqcVXN
         iNIK16Y8y4rXoL54RmLqFH1ccS7vUP4c6UAmjsYbFOzVDuRQ9s7pTGXMPN+J00WMZlh/
         dkBxnZoW2ygD8DRNK6Rn+6P0ltnrb6sIgfoNbyE0Ov4dTaBIn6WtKU0bQDqeRL8gbvhA
         /vwQxur+PunJsSaBWZDh+8oiYEaDyLaOgE7fzoSNYbg7eGhEH2OnC/ShEbI1U1+eZhx8
         QppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086666; x=1684678666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9ehmzwOW4Qc9gQvpwM/ZZofEU4OqXe1UUgzo44mFis=;
        b=IOd+xSdat9DTyWW5c1gHDhTen9rJoqqAjC81gDzxLFAsnYQO+OI8Bk4CqwmV5dfYj5
         3vEp7yHTvp7dTauZYZ2Qwp4hYjIVyEvcC+Li+U2VzgcHW4Va+s0CAGKDibGcHaF3YOD0
         KmmmVgIjobEGXLGoeMdPuSeeSyyrv2etB0vLhY2r9t2EcAw/OF1V1ezJpI8U6EuJvpHN
         QGpHwIhXu+82DEl252uQV98iXvYSIV6Ty+OvSWSQQ1xAu/l6vbL2aUXAbvdwUX5o4fkj
         GdRNTq5JHEw4g5Djef4X5pASIIImMkVdblt5uKg49w4pox/dt6/IEGC4MyK7kqcEU87/
         XOyA==
X-Gm-Message-State: AAQBX9fa85tHpSqBRcavvdkcB4xJWcLTRvh1bVwJ5b56l/D9nDwT0NPR
        41F4j2FWtSNMGsUzsZT1XGBroEDHWERuOyJoZw==
X-Google-Smtp-Source: AKy350bGSojqd0RF8hFVJ3f1aMQaH6BbLkjOI4vRi/ZfKEmx8aOtAggSlmMc650/M/hrY1VHYKP2C4yWp1Cj3Omwyg==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:c801:daa2:428c:d3fc])
 (user=peternewman job=sendgmr) by 2002:a81:b725:0:b0:555:f33e:e346 with SMTP
 id v37-20020a81b725000000b00555f33ee346mr1484199ywh.6.1682086666823; Fri, 21
 Apr 2023 07:17:46 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:17:15 +0200
In-Reply-To: <20230421141723.2405942-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421141723.2405942-2-peternewman@google.com>
Subject: [PATCH v1 1/9] selftests/resctrl: Verify all RMIDs count together
From:   Peter Newman <peternewman@google.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

AMD CPUs in particular implement fewer monitors than RMIDs, so add a
test case to see if a large number of monitoring groups can be measured
together.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 tools/testing/selftests/resctrl/test_rmids.sh | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100755 tools/testing/selftests/resctrl/test_rmids.sh

diff --git a/tools/testing/selftests/resctrl/test_rmids.sh b/tools/testing/selftests/resctrl/test_rmids.sh
new file mode 100755
index 000000000000..475e69c0217e
--- /dev/null
+++ b/tools/testing/selftests/resctrl/test_rmids.sh
@@ -0,0 +1,93 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+cd /sys/fs/resctrl
+
+grep -q mbm_total_bytes info/L3_MON/mon_features || {
+	echo "MBM required"
+	exit 4
+}
+
+which perf > /dev/null || {
+	echo "perf tool required"
+	exit 4
+}
+
+num_rmids=$(cat info/L3_MON/num_rmids)
+
+count=0
+
+result=0
+
+# use as many RMIDs as possible, up to the number of RMIDs
+for i in `seq $num_rmids`; do
+	mkdir mon_groups/_test_m$((count+1)) 2> /dev/null || break
+	if [[ -d mon_groups/_test_m$((count+1))/mon_data ]]; then
+		count=$((count+1))
+	else
+		break;
+	fi
+done
+
+echo "Created $count monitoring groups."
+
+if [[ $count -eq 0 ]]; then
+	echo "need monitoring groups to continue."
+	exit 4
+fi
+
+declare -a bytes_array
+
+unavailable=0
+unavailable0=0
+
+for i in `seq $count`; do
+	bytes_array[$i]=$(cat mon_groups/_test_m${i}/mon_data/mon_L3_00/mbm_total_bytes)
+
+	if [[ "${bytes_array[$i]}" = "Unavailable" ]]; then
+		unavailable0=$((unavailable0 + 1))
+	fi
+done
+
+for i in `seq $count`; do
+	echo $$ > mon_groups/_test_m${i}/tasks
+	taskset 0x1 perf bench mem memcpy -s 100MB -f default > /dev/null
+done
+echo $$ > tasks
+
+# zero non-integer values
+declare -i bytes bytes0
+
+success_count=0
+
+for i in `seq $count`; do
+	raw_bytes=$(cat mon_groups/_test_m${i}/mon_data/mon_L3_00/mbm_total_bytes)
+	raw_bytes0=${bytes_array[$i]}
+
+	# coerce the value to an integer for math
+	bytes=$raw_bytes
+	bytes0=$raw_bytes0
+
+	echo -n "g${i}: mbm_total_bytes: $raw_bytes0 -> $raw_bytes"
+
+	if [[ "$raw_bytes" = "Unavailable" ]]; then
+		unavailable=$((unavailable + 1))
+	fi
+
+	if [[ $bytes -gt $bytes0 ]]; then
+		success_count=$((success_count+1))
+		echo ""
+	else
+		echo " (FAIL)"
+		result=1
+	fi
+done
+
+first=$((count-unavailable0))
+second=$((count-unavailable))
+echo "$count groups, $first returned counts in first pass, $second in second"
+echo "successfully measured bandwidth from ${success_count}/${count} groups"
+
+rmdir mon_groups/_test_m*
+
+exit $result
-- 
2.40.0.634.g4ca3ef3211-goog

