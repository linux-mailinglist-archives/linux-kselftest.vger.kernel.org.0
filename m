Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD8F6EACAA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 16:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjDUOTB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 10:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjDUOSw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 10:18:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABE91386F
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:18:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8ed0a07a6fso3066994276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682086690; x=1684678690;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y32/TdG8kcYzN5rBv7k3EHHxOjAgmuz/MTd8pNlAXEA=;
        b=hpKZdihTkw8uY98Jt7btWsnsgQm4pu7ZD+gTsJEer7e7Bhi4FdnOZnlQ0Q4Yx2PbWa
         7xSOTnqiOHSs/2r/I9Vlh3kHkIbqeHzKJ4pkH7SZw9v8N39RvB0BrXX6Efid57ldBfB8
         YSMkcHnlJcFGMD6gLc9OUxomMd4vi8/JIq+Bsa6b4ZFxql9q24eL2t76KnEtvIInVvyo
         0Yj2ocYfKjIC6LYE/0r9bZk91BJw2SK6Oza3APs+9XnCv84snwE2/sFQrhlqD3a1UUK/
         8HKf2zhrp6a+Ns1+EfDJm6Dl1cvSAoQ0zdjCb5PqEK+zL6tQfHOxqvglYP3q+F2hiop7
         hr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086690; x=1684678690;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y32/TdG8kcYzN5rBv7k3EHHxOjAgmuz/MTd8pNlAXEA=;
        b=IesFCjvJ59bAFOS9tAVc4ycl63Svtz9SSqUJ3Ib0rf4517942ptiXfFU0Rqo8HHujj
         DEAnG9FFmdVi6OzTa2V7KkHQBmMd1uhuc8VsPQNd7r1wxiLuh8bSQQ6KmDWC++geNYLq
         gQF3o2+wm58wbuHndthgbBwNKo1fGTzLWCyn2wRmQRX8SHI3GGEclnOZiR9Fyzx6UXdX
         VuRtCVowfEFM3U3ruwLqWb0t6+3cBjLZX77kf+IK4Ujqu/3YjVqC01w8lXVP1hVdMGYK
         QHgbcWgOVo72EGozh1NFY1I2IlkZJZeAPXWE2kKpr5o0dZqORTUY42i5X4AEDkLNZZ8G
         /Shw==
X-Gm-Message-State: AAQBX9edgYWJ1WsWX+WrELoLexVU7iOTM4OZe086QMlVXxu8itzbxKf7
        OUClSHqpw1OtdlWOo55qgtXkLbacsPCjv3pHXA==
X-Google-Smtp-Source: AKy350bfbYkOd/MrAlE1looMHPMg/8RG4Dbi6FUJN+YVIR/OvN3oIl90LzbbXcXa4uOFWx/vgJiTrhfQRXJFWCKGXA==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:c801:daa2:428c:d3fc])
 (user=peternewman job=sendgmr) by 2002:a25:d78c:0:b0:b8b:eea7:525e with SMTP
 id o134-20020a25d78c000000b00b8beea7525emr1763936ybg.5.1682086690780; Fri, 21
 Apr 2023 07:18:10 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:17:23 +0200
In-Reply-To: <20230421141723.2405942-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421141723.2405942-10-peternewman@google.com>
Subject: [PATCH v1 9/9] x86/resctrl: Add mount option to enable soft RMID
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

Add the 'mbm_soft_rmid' mount option to enable soft RMIDs.

This requires adding a mechanism for disabling a monitoring event at
mount time to prevent the llc_occupancy event from being presented to
the user.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  3 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 51 ++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e6ff31a4dbc4..604e3d550601 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -59,6 +59,7 @@ struct rdt_fs_context {
 	bool				enable_cdpl2;
 	bool				enable_cdpl3;
 	bool				enable_mba_mbps;
+	bool				enable_mbm_soft_rmid;
 };
 
 static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
@@ -76,12 +77,14 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
  * @evtid:		event id
  * @name:		name of the event
  * @configurable:	true if the event is configurable
+ * @enabled:		true if event is disabled
  * @list:		entry in &rdt_resource->evt_list
  */
 struct mon_evt {
 	enum resctrl_event_id	evtid;
 	char			*name;
 	bool			configurable;
+	bool			disabled;
 	struct list_head	list;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index c10f4798156a..c2abf69c2dcf 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1013,6 +1013,8 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 	struct mon_evt *mevt;
 
 	list_for_each_entry(mevt, &r->evt_list, list) {
+		if (mevt->disabled)
+			continue;
 		seq_printf(seq, "%s\n", mevt->name);
 		if (mevt->configurable)
 			seq_printf(seq, "%s_config\n", mevt->name);
@@ -2204,6 +2206,37 @@ static bool supports_mba_mbps(void)
 		r->alloc_capable && is_mba_linear());
 }
 
+static bool supports_mbm_soft_rmid(void)
+{
+	return is_mbm_enabled();
+}
+
+int set_mbm_soft_rmid(bool mbm_soft_rmid)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct mon_evt *mevt = NULL;
+
+	/*
+	 * is_llc_occupancy_enabled() will always return false when disabling,
+	 * so search for the llc_occupancy event unconditionally.
+	 */
+	list_for_each_entry(mevt, &r->evt_list, list) {
+		if (strcmp(mevt->name, "llc_occupancy") == 0) {
+			mevt->disabled = mbm_soft_rmid;
+			break;
+		}
+	}
+
+	rdt_mon_soft_rmid = mbm_soft_rmid;
+
+	if (mbm_soft_rmid)
+		static_branch_enable_cpuslocked(&rdt_soft_rmid_enable_key);
+	else
+		static_branch_disable_cpuslocked(&rdt_soft_rmid_enable_key);
+
+	return 0;
+}
+
 /*
  * Enable or disable the MBA software controller
  * which helps user specify bandwidth in MBps.
@@ -2359,6 +2392,9 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 	if (!ret && ctx->enable_mba_mbps)
 		ret = set_mba_sc(true);
 
+	if (!ret && ctx->enable_mbm_soft_rmid)
+		ret = set_mbm_soft_rmid(true);
+
 	return ret;
 }
 
@@ -2534,6 +2570,8 @@ static int rdt_get_tree(struct fs_context *fc)
 out_mba:
 	if (ctx->enable_mba_mbps)
 		set_mba_sc(false);
+	if (ctx->enable_mbm_soft_rmid)
+		set_mbm_soft_rmid(false);
 out_cdp:
 	cdp_disable_all();
 out:
@@ -2547,6 +2585,7 @@ enum rdt_param {
 	Opt_cdp,
 	Opt_cdpl2,
 	Opt_mba_mbps,
+	Opt_mbm_soft_rmid,
 	nr__rdt_params
 };
 
@@ -2554,6 +2593,7 @@ static const struct fs_parameter_spec rdt_fs_parameters[] = {
 	fsparam_flag("cdp",		Opt_cdp),
 	fsparam_flag("cdpl2",		Opt_cdpl2),
 	fsparam_flag("mba_MBps",	Opt_mba_mbps),
+	fsparam_flag("mbm_soft_rmid",	Opt_mbm_soft_rmid),
 	{}
 };
 
@@ -2579,6 +2619,11 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		ctx->enable_mba_mbps = true;
 		return 0;
+	case Opt_mbm_soft_rmid:
+		if (!supports_mbm_soft_rmid())
+			return -EINVAL;
+		ctx->enable_mbm_soft_rmid = true;
+		return 0;
 	}
 
 	return -EINVAL;
@@ -2767,6 +2812,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
+	set_mbm_soft_rmid(false);
 	set_mba_sc(false);
 
 	/*Put everything back to default values. */
@@ -2861,6 +2907,8 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 	priv.u.rid = r->rid;
 	priv.u.domid = d->id;
 	list_for_each_entry(mevt, &r->evt_list, list) {
+		if (mevt->disabled)
+			continue;
 		priv.u.evtid = mevt->evtid;
 		ret = mon_addfile(kn, mevt->name, priv.priv);
 		if (ret)
@@ -3517,6 +3565,9 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
 		seq_puts(seq, ",mba_MBps");
 
+	if (static_branch_likely(&rdt_soft_rmid_enable_key))
+		seq_puts(seq, ",mbm_soft_rmid");
+
 	return 0;
 }
 
-- 
2.40.0.634.g4ca3ef3211-goog

