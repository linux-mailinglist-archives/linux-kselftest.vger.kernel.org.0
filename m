Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1875556AE97
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jul 2022 00:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbiGGWdT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Jul 2022 18:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237077AbiGGWcw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Jul 2022 18:32:52 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75E9675B5
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Jul 2022 15:32:45 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id by10-20020a056830608a00b0061c1ac80e1dso1941202otb.13
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Jul 2022 15:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gpnGP72y7AlRDZxLLIIKCxGjGB4QqIYx1EtuBERrAGY=;
        b=KfAsVex69jTCIdg5XmbRjXWWWy/S0Tca6CS8SwDAmazdBPIoDnrCREhbjrLFevHaGt
         6ufFk77dMvGWeRIVQPkT2IDgHAiRo2457GzNSRpAj0LvK9u6HolMJoALdrhWiSJY3cDP
         lupYF3+zn3pi6FeorsgnBUBjJN6/6EstmhD80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpnGP72y7AlRDZxLLIIKCxGjGB4QqIYx1EtuBERrAGY=;
        b=2QcfHYdWhMuJ5rGWV1YTL7ht5JgZldvsrzO4owx3erK/z8Ftcocd6mE7dzIvyWTRiP
         AZigJCo+Cz7E+Qiljw6iLe0DFkvo4joU3KLRJiTbsyzuX4vOoQzCdkKqERZJDXM+xyLd
         zPswTfLuyb6VMljQBd6MCyQxsarcUQFvlqeLgwVWnLxlBNhf1kvuX+jkZA29ub3uTmkZ
         m3pBthD2fgoHnx48zzu/4fFZ+GxHxdj+1hQdwjPrmWqvVsDiJ07NdOb7CHtUpU101Vnz
         X9v5IPc+KkA27S9g42E/24+0WSaa4OtkyH1GE6aUcUmCry/G2i7AI1Fz5n3VvQWl6pYs
         l1GA==
X-Gm-Message-State: AJIora+vAEYMyf3s+RwAUIbmThkzJ8mdvAlYnja0eidXmMCmmxmvsHH8
        GS/XefOL5Z8F2mfoUJhtKvE4Ww==
X-Google-Smtp-Source: AGRyM1sGIyzyI1rIE0sIpG00vgHQmsRFAehgN6hwD9szVgsHUkRW2ie4sEb+YtA6SNwdPP9ZDtc8qw==
X-Received: by 2002:a9d:4c0e:0:b0:616:dd87:cb91 with SMTP id l14-20020a9d4c0e000000b00616dd87cb91mr182367otf.185.1657233164958;
        Thu, 07 Jul 2022 15:32:44 -0700 (PDT)
Received: from localhost.localdomain ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id i16-20020a05683033f000b00616b835f5e7sm16246222otu.43.2022.07.07.15.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:32:43 -0700 (PDT)
From:   Frederick Lawler <fred@cloudflare.com>
To:     kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, shuah@kernel.org, brauner@kernel.org,
        casey@schaufler-ca.com, ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v2 4/4] selinux: Implement create_user_ns hook
Date:   Thu,  7 Jul 2022 17:32:28 -0500
Message-Id: <20220707223228.1940249-5-fred@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220707223228.1940249-1-fred@cloudflare.com>
References: <20220707223228.1940249-1-fred@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Unprivileged user namespace creation is an intended feature to enable
sandboxing, however this feature is often used to as an initial step to
perform a privilege escalation attack.

This patch implements a new namespace { userns_create } access control
permission to restrict which domains allow or deny user namespace
creation. This is necessary for system administrators to quickly protect
their systems while waiting for vulnerability patches to be applied.

This permission can be used in the following way:

        allow domA_t domB_t : namespace { userns_create };

Signed-off-by: Frederick Lawler <fred@cloudflare.com>

---
Changes since v1:
- Introduce this patch
---
 security/selinux/hooks.c            | 9 +++++++++
 security/selinux/include/classmap.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index beceb89f68d9..73fbcb434fe0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4227,6 +4227,14 @@ static void selinux_task_to_inode(struct task_struct *p,
 	spin_unlock(&isec->lock);
 }
 
+static int selinux_userns_create(const struct cred *cred)
+{
+	u32 sid = current_sid();
+
+	return avc_has_perm(&selinux_state, sid, sid, SECCLASS_NAMESPACE,
+						NAMESPACE__USERNS_CREATE, NULL);
+}
+
 /* Returns error only if unable to parse addresses */
 static int selinux_parse_skb_ipv4(struct sk_buff *skb,
 			struct common_audit_data *ad, u8 *proto)
@@ -7117,6 +7125,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_movememory, selinux_task_movememory),
 	LSM_HOOK_INIT(task_kill, selinux_task_kill),
 	LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
+	LSM_HOOK_INIT(create_user_ns, selinux_userns_create),
 
 	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
 	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index ff757ae5f253..9943e85c6b3e 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -254,6 +254,8 @@ const struct security_class_mapping secclass_map[] = {
 	  { COMMON_FILE_PERMS, NULL } },
 	{ "io_uring",
 	  { "override_creds", "sqpoll", NULL } },
+	{ "namespace",
+	  { "userns_create", NULL } },
 	{ NULL }
   };
 
-- 
2.30.2

