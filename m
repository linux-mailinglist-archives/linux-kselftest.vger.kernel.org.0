Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB9A6EACA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 16:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjDUOTA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 10:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjDUOSu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 10:18:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F8013C34
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:18:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b98f3ca02b5so1686287276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682086688; x=1684678688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4R40htVFkZdRKo0vr5qbbFiTdJ0ln75dPc18Ex1B+xs=;
        b=C5BMyCvlSu+eRzBuquykI60dxIq34oqxyOw42+ATs4ZC1qIFL9f0A1m6cTj1Jn86Bc
         44vRd37/KN9LFP3+Vgd6I3Tk6cDxaeV8xTNfWw+0kITVFdf4LaajI4M8GClIsJGdlrVo
         ZXBYbKbAqjawn9c6qHTuBylMX2eEVIDSk0Hh2f96PyUpJcGQfEmbP1iNKvAkagqwNwAZ
         fBeCOT5hlALd9f2omWh3ORkodnLziGqV4RS8XBrfYg7P9BwfF/wp99EnLYDYtUg6u7Q2
         xLGNagHO1uKYyrOjiHAOyGA9bxx8PXRaYcRCp6RHq+hedzzLAVlekMwLMyDxa8FSee+d
         Xn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086688; x=1684678688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4R40htVFkZdRKo0vr5qbbFiTdJ0ln75dPc18Ex1B+xs=;
        b=LloSnBdq+3wwMsq5TmQ97+gDdP8i8u+2UV+r/g0TagywfbG+UimeEwzUctK0XtvXY6
         aencq15gZSIRJICALxhqAp6jdDCcPNtSnylrcquvRUi2ksmCqvU32C3eETlaS3qlzSlY
         yziwP31wY1Pd1jdfKnUrUjnZrV3lxXC++JLMr56sUnwI6iFC8aq10F2FAcBlKfEOE+TM
         UfbOU+PZIrzOSv5/C+8vDryBtFSyZbQSiO2zTyBbu14MRIWaW+bvD+f6tSBPQ0hvewBr
         O0qLZynD/wmeoPmjiqWvO1Uj+aJKjqt+yAozCn0G+IDs8omn4iUENLtZeLfI0sgJ/AJB
         9cPw==
X-Gm-Message-State: AAQBX9cD/zB5D2lseXfDAOQiJj9dLwNKdHeDxhgVTY3PJUTaxpf8uxVs
        BeeyDtBRcLscXFFh0LKA/JAKZm2f+GeoWet/Pw==
X-Google-Smtp-Source: AKy350bMJkGMk536H1XiJn0O8T/FQl3R76sq1Khx/MzdZxPj4mYPweyZpf3i2nlBd/q2SesN161ZSeUiH7ipq5W7HA==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:c801:daa2:428c:d3fc])
 (user=peternewman job=sendgmr) by 2002:a25:d1d0:0:b0:b98:6352:be19 with SMTP
 id i199-20020a25d1d0000000b00b986352be19mr1290128ybg.9.1682086687990; Fri, 21
 Apr 2023 07:18:07 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:17:22 +0200
In-Reply-To: <20230421141723.2405942-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421141723.2405942-9-peternewman@google.com>
Subject: [PATCH v1 8/9] x86/resctrl: Use mbm_update() to push soft RMID counts
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

__mon_event_count() only reads the current software count and does not
cause CPUs in the domain to flush. For mbm_update() to be effective in
preventing overflow in hardware counters with soft RMIDs, it needs to
flush the domain CPUs so that all of the HW RMIDs are read.

When RMIDs are soft, mbm_update() is intended to push bandwidth counts
to the software counters rather than pulling the counts from hardware
when userspace reads event counts, as this is a lot more efficient when
the number of HW RMIDs is fixed.

When RMIDs are soft, mbm_update() only calls mbm_flush_cpu_handler() on
each CPU in the domain rather than reading all RMIDs.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 28 +++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 3d54a634471a..9575cb79b8ee 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -487,6 +487,11 @@ void resctrl_mbm_flush_cpu(void)
 		__mbm_flush(QOS_L3_MBM_TOTAL_EVENT_ID, r, d);
 }
 
+static void mbm_flush_cpu_handler(void *p)
+{
+	resctrl_mbm_flush_cpu();
+}
+
 static int __mon_event_count_soft_rmid(u32 rmid, struct rmid_read *rr)
 {
 	struct mbm_state *m;
@@ -806,12 +811,27 @@ void mbm_handle_overflow(struct work_struct *work)
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	d = container_of(work, struct rdt_domain, mbm_over.work);
 
+	if (rdt_mon_soft_rmid) {
+		/*
+		 * HW RMIDs are permanently assigned to CPUs, so only a per-CPU
+		 * flush is needed.
+		 */
+		on_each_cpu_mask(&d->cpu_mask, mbm_flush_cpu_handler, NULL,
+				 false);
+	}
+
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		mbm_update(r, d, prgrp->mon.rmid);
+		/*
+		 * mbm_update() on every RMID would result in excessive IPIs
+		 * when RMIDs are soft.
+		 */
+		if (!rdt_mon_soft_rmid) {
+			mbm_update(r, d, prgrp->mon.rmid);
 
-		head = &prgrp->mon.crdtgrp_list;
-		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
-			mbm_update(r, d, crgrp->mon.rmid);
+			head = &prgrp->mon.crdtgrp_list;
+			list_for_each_entry(crgrp, head, mon.crdtgrp_list)
+				mbm_update(r, d, crgrp->mon.rmid);
+		}
 
 		if (is_mba_sc(NULL))
 			update_mba_bw(prgrp, d);
-- 
2.40.0.634.g4ca3ef3211-goog

