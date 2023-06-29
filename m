Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506A07422F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 11:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjF2JL7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 05:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjF2JL4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 05:11:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D1F1FE8;
        Thu, 29 Jun 2023 02:11:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 196521F8CD;
        Thu, 29 Jun 2023 09:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688029913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rVojEtuYagGizr3yOGYD8YaQfsrGlsFwyzHuPXma3hE=;
        b=ugtZ80eyRtri7lltfb1GdP7NUGyS3mL8m4KGwhqsepHiDIi40YmHj8mOuYrb6/FAleP5ZI
        aEAvafObNr5a+n0pR/lOObP+oOJmWQ3vDOvPF4AP+GjNY7/+tgN7kC+hMZU1CUSTFuskgT
        fx7lnKLSExwrqgZQ1CH5/wG3R0QC/xg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E68F913A43;
        Thu, 29 Jun 2023 09:11:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AHRtN9hKnWSMdQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 29 Jun 2023 09:11:52 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH 1/3] cpuset: Allow setscheduler regardless of manipulated task
Date:   Thu, 29 Jun 2023 11:11:44 +0200
Message-ID: <20230629091146.28801-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629091146.28801-1-mkoutny@suse.com>
References: <20230629091146.28801-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When we migrate a task between two cgroups, one of the checks is a
verification whether we can modify task's scheduler settings
(cap_task_setscheduler()).

An implicit migration occurs also when enabling a controller on the
unified hierarchy (think of parent to child migration). The
aforementioned check may be problematic if the caller of the migration
(enabling a controller) has no permissions over migrated tasks.
For instance, a user's cgroup that ends up running a process of a
different user. Although cgroup permissions are configured favorably,
the enablement fails due to the foreign process [1].

Change the behavior by relaxing the permissions check on the unified
hierarchy (or in v2 mode). This is in accordance with unified hierarchy
attachment behavior when permissions of the source to target cgroups are
decisive whereas the migrated task is opaque (as opposed to more
restrictive check in __cgroup1_procs_write()).

[1] https://github.com/systemd/systemd/issues/18293#issuecomment-831205649

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e4ca2dd2b764..3b5f87a9a150 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2495,6 +2495,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		ret = task_can_attach(task, cs->effective_cpus);
 		if (ret)
 			goto out_unlock;
+
+		/*
+		 * Skip rights over task check in v2, migration permission derives
+		 * from hierarchy ownership in cgroup_procs_write_permission()).
+		 */
+		if (is_in_v2_mode())
+			continue;
 		ret = security_task_setscheduler(task);
 		if (ret)
 			goto out_unlock;
-- 
2.41.0

