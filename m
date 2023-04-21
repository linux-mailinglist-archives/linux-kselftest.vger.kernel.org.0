Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BCA6EACA0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 16:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjDUOSE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 10:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjDUOSB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 10:18:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67CF12CA3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:17:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-555f6759323so22692867b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682086679; x=1684678679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pHZMVL6RAnw5G7UfUNTFa5CzwFEHRn1u+l8+oLzhKx4=;
        b=MfKd7cn5Uub1nNM2RiV3ISktGqpLP5EyFHMUPTILCfI1qopVg8PNxzIa5VZ+WVXZcx
         YZQQ69rym1OqIQnu263AjZ26mfrN9dRc/O+yt9qJlZr0OQWY7+sFU45p712eZ73X/pq+
         4Nuhsixxps7DcDhS8ICV53xkgX4iMhzzYLMYV6mG4O4qavIN7UXl1yLnU6UYwzdbAfEJ
         XNoVRfO8lEMNDiQ7idtMdbVoXBEUHQvqduc/A77nuADM4Lw/KkA2p6bc2WIgZsi3U3N/
         trNTBvt2RGd59HStffaZOaFrM5q5/qYO3yTC7XGOJfGCsPSLoeWY96CWcfKm4Xj9mPLG
         QXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086679; x=1684678679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHZMVL6RAnw5G7UfUNTFa5CzwFEHRn1u+l8+oLzhKx4=;
        b=a0Xn+RUXf7LR69ADpUPPcDQjX5kfCCGzK8qGiKw1rbGvKBJ51goafU08BVQVl8gIxN
         ZzvqsKIRPlzUSnIpyVxoqzeFGb1aOvLZB2WLTA8iM6FpIfPzsWiW0mEha7nv1bDVGBZY
         cPM8xCbgZeHyiPhD+h+L0KNF4IktdkknKEmV+csP5BGw0gM4tLQQoTfGkhgnj+3FZ0cr
         qAikgHbZgD18OGyLrOzkEjGRLSPiDjpjDcl8Wj/2xoIA6GmCh89m6exyT2sliApoIoUv
         A7MBCzeJ86MXlY/YMjI3uXj38/kLmt2G/HPLEMz6UllHRi0y/U+BILZZZ1kUAYTC5UWD
         4LhA==
X-Gm-Message-State: AAQBX9eSlPOQu5sliNlmaDWkgKrVhsfCBRWoC5xQ3yDiuIfKpXUQUSer
        Jr9kjshaDHinO6waloZHEg+TZDl6oA+B8tAiuQ==
X-Google-Smtp-Source: AKy350YvnC4D+q7r4n05l+Chcu0lsHZ9od5ZFR9ulTDdbShO1MkzfnoQXP97E9KcRU77diwK2ta/zXGnRQ/DKTb2qw==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:c801:daa2:428c:d3fc])
 (user=peternewman job=sendgmr) by 2002:a81:ae68:0:b0:533:8f19:4576 with SMTP
 id g40-20020a81ae68000000b005338f194576mr1440134ywk.0.1682086679114; Fri, 21
 Apr 2023 07:17:59 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:17:19 +0200
In-Reply-To: <20230421141723.2405942-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421141723.2405942-6-peternewman@google.com>
Subject: [PATCH v1 5/9] x86/resctrl: Call mon_event_count() directly for soft RMIDs
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is no point in using IPIs to call mon_event_count() when it is
only reading software counters from memory.

When RMIDs are soft, mon_event_read() just calls mon_event_count()
directly.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 9 ++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h    | 1 +
 arch/x86/kernel/cpu/resctrl/monitor.c     | 5 +++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index b44c487727d4..b2ed25a08f6f 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -534,7 +534,14 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	rr->val = 0;
 	rr->first = first;
 
-	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
+	if (rdt_mon_soft_rmid)
+		/*
+		 * Soft RMID counters reside in memory, so they can be read from
+		 * anywhere.
+		 */
+		mon_event_count(rr);
+	else
+		smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
 }
 
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 256eee05d447..e6ff31a4dbc4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -115,6 +115,7 @@ struct rmid_read {
 
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
+extern bool rdt_mon_soft_rmid;
 extern unsigned int rdt_mon_features;
 extern struct list_head resctrl_schema_all;
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 3671100d3cc7..bb857eefa3b0 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -57,6 +57,11 @@ static struct rmid_entry	*rmid_ptrs;
  */
 bool rdt_mon_capable;
 
+/*
+ * Global boolean to indicate when RMIDs are implemented in software.
+ */
+bool rdt_mon_soft_rmid;
+
 /*
  * Global to indicate which monitoring events are enabled.
  */
-- 
2.40.0.634.g4ca3ef3211-goog

