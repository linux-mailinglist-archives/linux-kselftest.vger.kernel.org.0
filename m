Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110D56929B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 22:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjBJV5z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 16:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjBJV5y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 16:57:54 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67B77DD3C
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 13:57:51 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 9A29F6BFC2E1; Fri, 10 Feb 2023 13:50:33 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: [RFC PATCH v2 13/19] mm: expose ksm merge type in ksm_stat
Date:   Fri, 10 Feb 2023 13:50:17 -0800
Message-Id: <20230210215023.2740545-14-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230210215023.2740545-1-shr@devkernel.io>
References: <20230210215023.2740545-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_NEUTRAL,TVD_RCVD_IP autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This exposes the ksm process type in /proc/<pid>/ksm_stat. The name of
the value is ksm_merge_type.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 fs/proc/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index fb9567bc42a4..45749051e53b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3200,6 +3200,7 @@ static int proc_pid_ksm_merging_pages(struct seq_fi=
le *m, struct pid_namespace *
=20
 	return 0;
 }
+
 static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *n=
s,
 				struct pid *pid, struct task_struct *task)
 {
@@ -3210,6 +3211,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, st=
ruct pid_namespace *ns,
 		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
 		seq_printf(m, "zero_pages_sharing %lu\n", mm->ksm_zero_pages_sharing);
 		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
+		seq_printf(m, "ksm_merge_type %s\n", ksm_merge_type(mm));
 		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
 		mmput(mm);
 	}
--=20
2.30.2

