Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEBD6EACA7
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 16:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjDUOSj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 10:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjDUOSG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 10:18:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEDB974A
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:18:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b98d97c8130so1167372276.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682086682; x=1684678682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eG+d82X49QK4SbPD8xART0pPpkKrWLwG04cl9OQ+l3E=;
        b=Wd+O3j54Skqqn0pDaOa4Mjhf66LdJYTTj9EXOkDn/rwzAbg0BNewxKMK2fmMK8iG98
         PicL46080hpLDBhfW/fTzkNo0EtVBh5MW6t23IZuu1RN6M338Hjbb0qD9I7z5KZ1n6QO
         t1cYVANMd85R44HbBJnjZausS2fw39/88Myh/hUlRcAU44GrbT8jfDhuYCOrhyj4MRYK
         WjHWGraOdx84TsWCjTu5s9cG6f4hnFQ/BeIhldOpzYVeBs4+iwLMdNanU9uFoitxwZAs
         4OJ9cE65XStC7x334oAqiaoPQt5KUOL7kSzkZ3ntdiTUox5Fmt7osx4w5LeXwpEmOJoP
         U8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086682; x=1684678682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eG+d82X49QK4SbPD8xART0pPpkKrWLwG04cl9OQ+l3E=;
        b=ktYeui0f9QulXvT13JGlQ2FzPgMGxdtIJQRq7OvSbZeeXVfrTxjFNmSH8DE+XJxImz
         9EQf2eHhEQOJtJsJ3Sa5WI1tFUTEKbG8TVFWZVr1GjthwC3zx47DQqW6D0Y4xbbE+h/4
         w8GZOSMOwlCbkZV5nqh0lYI8qvMTFIhYK5XHs+imOX07N5fbZ1d8PbNqJIcB+7qgAKE7
         jxS5NQwGnLALwjhjqFKJjbCgAezaHL2JkOJdgRckXuaJbVm1Cscgh0dKvhJgBYOarkPI
         m8nRldDh/l+/uCy1LpuSXYJoh0BSijZMkKsIEVLpFc6ioK6Pq4ldTSq/8zMurNx9r88i
         Vw4A==
X-Gm-Message-State: AAQBX9cRQJ6Kc04gArJSQN/YBAuw1NeQOedlEbiP+IZ5JsUYS1xNs6Co
        CvYOtfMSfBxHX8LlczGiX1lSylCzADbHLQpK5g==
X-Google-Smtp-Source: AKy350Y7AKukcnsH8485FXzjDHmrAYQuKfedUSn3WuV6xXVT8plxC+N4U7Ap5J23/mNoQobBP9sepBiAuDXaC0lvzQ==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:c801:daa2:428c:d3fc])
 (user=peternewman job=sendgmr) by 2002:a25:cc93:0:b0:b92:570c:57a1 with SMTP
 id l141-20020a25cc93000000b00b92570c57a1mr1764698ybf.2.1682086682008; Fri, 21
 Apr 2023 07:18:02 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:17:20 +0200
In-Reply-To: <20230421141723.2405942-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421141723.2405942-7-peternewman@google.com>
Subject: [PATCH v1 6/9] x86/resctrl: Create soft RMID version of __mon_event_count()
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

When RMIDs are soft, __mon_event_count() only needs to report the
current byte count in memory and should not touch the hardware RMIDs.

Create a parallel version for the soft RMID configuration and update
__mon_event_count() to choose between it and the original depending on
whether the soft RMID static key is enabled.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 33 ++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index bb857eefa3b0..3d54a634471a 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -487,7 +487,30 @@ void resctrl_mbm_flush_cpu(void)
 		__mbm_flush(QOS_L3_MBM_TOTAL_EVENT_ID, r, d);
 }
 
-static int __mon_event_count(u32 rmid, struct rmid_read *rr)
+static int __mon_event_count_soft_rmid(u32 rmid, struct rmid_read *rr)
+{
+	struct mbm_state *m;
+
+	WARN_ON(!is_mbm_event(rr->evtid));
+	m = get_mbm_state(rr->d, rmid, rr->evtid);
+	if (!m)
+		/* implies !is_mbm_event(...) */
+		return -1;
+
+	rr->val += atomic64_read(&m->soft_rmid_bytes);
+
+	if (rr->first) {
+		/*
+		 * Discard any bandwidth resulting from the initial HW counter
+		 * reads.
+		 */
+		atomic64_set(&m->soft_rmid_bytes, 0);
+	}
+
+	return 0;
+}
+
+static int __mon_event_count_default(u32 rmid, struct rmid_read *rr)
 {
 	struct mbm_state *m;
 	u64 tval = 0;
@@ -509,6 +532,14 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 	return 0;
 }
 
+static int __mon_event_count(u32 rmid, struct rmid_read *rr)
+{
+	if (rdt_mon_soft_rmid)
+		return __mon_event_count_soft_rmid(rmid, rr);
+	else
+		return __mon_event_count_default(rmid, rr);
+}
+
 /*
  * mbm_bw_count() - Update bw count from values previously read by
  *		    __mon_event_count().
-- 
2.40.0.634.g4ca3ef3211-goog

