Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCFC6EAC9F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 16:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjDUOSC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 10:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjDUOR6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 10:17:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12FA19B2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:17:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f855ecb9cso23421547b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682086676; x=1684678676;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+n+j8heP4pCjXZYyBacJTBZB3NL6fBggzFdjHd9oRv0=;
        b=1J+xPZGWBNzha1s2A0zh1bYQja2oWHpvpOCxFHuTZtFUWKMmSQnBfxHBH0Zcm44kZA
         mPOZ/Fht1Aftwl9AJ1rKtC59A4jvXdb1ZYW8T2qD/3ZYsP8HOjEF5aK/sPWCyvfddAGs
         YZVHhrnd9w2mxWucAZPFAtJnP9MSj3lmKy/TSOAxNQS4f3hIn2T2k8w1STVe4BtZELVX
         pJkgxjkF5hE3w133duRa8aLyLmZJq1iOL967XYQ/GUbKLPXFkKw4b9ahEO8C0ZO6zECt
         izmMTaC7MHs6J71osGTiOvAsndQZ1oFYtSarJD7aSOdBEp0EuGUc3FUDwpkI1pL1x4Bm
         A4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086676; x=1684678676;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+n+j8heP4pCjXZYyBacJTBZB3NL6fBggzFdjHd9oRv0=;
        b=PHI9Bm0l4pLTxg02Kzp8GUA3oTwGCAJ2e8A4LmzJxu4V7xSVc4uo4ixnrTudeIt0It
         1OeuV+VkCVzTso3va6Z286EElKaZ4ntMxOrJoXQFKtNZLvFwSj2K3s2jO0iieZ/sX50c
         cqad20ghmevJoseCR6lPIynz7lhMkTt+pIIrR2awZnbt+PNSuDbRuS8xstJV/hb/S826
         CkHcS9vgBpBqHYWoYieEFhmPz2gmNZFbw6vkjNr7+7MkfqUmzCyrDPr0J6Wll+JPyl6i
         rezulOZCSVtFVgauc68CbjnAO/RbzJjJGw/VMRitXQY/5BoMldXf06j11aDnxgRgm5i/
         7i1Q==
X-Gm-Message-State: AAQBX9cmMmVJDtoVTQmz14YorCcXxSF7510cfkE2kOmDi3D0eoqyiiZh
        Ui+G7CzV20D0kaqiMr+wD6f4PLDRBGQwFwXd0w==
X-Google-Smtp-Source: AKy350arYGzYEIPhtnp3xySUlV+rNDfVObOqcPYOAss6sIzU6gdyo3tnVcUWjCj9A0vbWC7usI/Jxf0ocUwJeeSCCw==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:c801:daa2:428c:d3fc])
 (user=peternewman job=sendgmr) by 2002:a0d:ec48:0:b0:54f:ae82:3f92 with SMTP
 id r8-20020a0dec48000000b0054fae823f92mr1328767ywn.2.1682086675839; Fri, 21
 Apr 2023 07:17:55 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:17:18 +0200
In-Reply-To: <20230421141723.2405942-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421141723.2405942-5-peternewman@google.com>
Subject: [PATCH v1 4/9] x86/resctrl: Flush MBM event counts on soft RMID change
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

To implement soft RMIDs, context switch must detect when the current
soft RMID is changing and if so, flush the CPU's MBM event counts to the
outgoing soft RMID.

To avoid impacting context switch performance in the non-soft RMID case,
protect the new logic with a static branch.

Co-developed-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/include/asm/resctrl.h         | 27 +++++++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  1 +
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index e7acf118d770..50d05e883dbb 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -36,6 +36,9 @@ DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
+DECLARE_STATIC_KEY_FALSE(rdt_soft_rmid_enable_key);
+
+void resctrl_mbm_flush_cpu(void);
 
 /*
  * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
@@ -75,9 +78,31 @@ static inline void __resctrl_sched_in(struct task_struct *tsk)
 	}
 
 	if (closid != state->cur_closid || rmid != state->cur_rmid) {
+		if (static_branch_likely(&rdt_soft_rmid_enable_key)) {
+			/*
+			 * Flush current event counts to outgoing soft rmid
+			 * when it changes.
+			 */
+			if (rmid != state->cur_rmid)
+				resctrl_mbm_flush_cpu();
+
+			/*
+			 * rmid never changes in this mode, so skip wrmsr if the
+			 * closid is not changing.
+			 */
+			if (closid != state->cur_closid)
+				wrmsr(MSR_IA32_PQR_ASSOC, state->hw_rmid,
+				      closid);
+		} else {
+			wrmsr(MSR_IA32_PQR_ASSOC, rmid, closid);
+		}
+
+		/*
+		 * Record new closid/rmid last so soft rmid case can detect
+		 * changes.
+		 */
 		state->cur_closid = closid;
 		state->cur_rmid = rmid;
-		wrmsr(MSR_IA32_PQR_ASSOC, rmid, closid);
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6ad33f355861..c10f4798156a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -35,6 +35,7 @@
 DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
 DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
+DEFINE_STATIC_KEY_FALSE(rdt_soft_rmid_enable_key);
 static struct kernfs_root *rdt_root;
 struct rdtgroup rdtgroup_default;
 LIST_HEAD(rdt_all_groups);
-- 
2.40.0.634.g4ca3ef3211-goog

