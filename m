Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302E2587025
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Aug 2022 20:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiHASD0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Aug 2022 14:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbiHASCx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Aug 2022 14:02:53 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4D22613F
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Aug 2022 11:02:25 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w72so9597580oiw.6
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Aug 2022 11:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bttyVQI+o0yCdSSwfTGsmfJypexzzz/Ptc7wrcpVb94=;
        b=i4ToQg1x5/k2OuSwcs5fz8zHz6WBhwfxswzE6nWWdWaeEdPc6pv10CDx0N+HMBM9Yj
         apKtW+hsRPgAXYA0BTvzit4oSXA5q0fwJgMIOswGMI+7uQRvQtuNrIn2Q8ZTP+qQUF4U
         PXAMRMONfHRrue6t5Oi+zRbQrpqKUBZwty/Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bttyVQI+o0yCdSSwfTGsmfJypexzzz/Ptc7wrcpVb94=;
        b=R9JZ96YUjkZ67TtrxyoNp9MIBIhn+rvR7a+FT57IcIptMNK6u4Mbwg1S7K3SupTKo1
         lOXV5aj7djM4fN7yLUNcxaI1uKm8HcwAbX1lxhfd6oea/dOPkGJImI1G7yYPbCd6mdua
         01V8Y60futSOUbu9n/37miSsH/decWTTXFfANrkReF+0aC+4g5/1sLFg+z3CMUz+1tWw
         5wz+Ox97fhB40nqlKf3h74JwQuaIeCeDmoROt6o3WnNmYgDo2v3Tb8ffrKI+0JxFm/7+
         X0vCBDv1hMtYVuFNORa+K5M0qI0PbnD3KlMCdmJI9GAXo47TunpMVoiA+ZhnRZPHGv2x
         hERQ==
X-Gm-Message-State: AJIora/ZwPrg7u7Ru3xcLLv14L39soYuLiHo3GJEtMxFzkP9W2Alinbh
        yVdrbzH7X5MLtIXxhjJsAf3Clg==
X-Google-Smtp-Source: AGRyM1tirTjWfZIcvEpccIMwd00O49IfF8uA6bm3mVQLc9R6zclPg5zxqFpIZPvVpdHR1RhSA9mPug==
X-Received: by 2002:a05:6808:302b:b0:2f9:eeef:f03 with SMTP id ay43-20020a056808302b00b002f9eeef0f03mr6998147oib.128.1659376942519;
        Mon, 01 Aug 2022 11:02:22 -0700 (PDT)
Received: from localhost.localdomain ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id n14-20020a9d64ce000000b00618fa37308csm2881348otl.35.2022.08.01.11.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 11:02:22 -0700 (PDT)
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
        kernel-team@cloudflare.com, cgzones@googlemail.com,
        karl@bigbadwolfsecurity.com, Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v4 4/4] selinux: Implement userns_create hook
Date:   Mon,  1 Aug 2022 13:01:46 -0500
Message-Id: <20220801180146.1157914-5-fred@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220801180146.1157914-1-fred@cloudflare.com>
References: <20220801180146.1157914-1-fred@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Unprivileged user namespace creation is an intended feature to enable
sandboxing, however this feature is often used to as an initial step to
perform a privilege escalation attack.

This patch implements a new user_namespace { create } access control
permission to restrict which domains allow or deny user namespace
creation. This is necessary for system administrators to quickly protect
their systems while waiting for vulnerability patches to be applied.

This permission can be used in the following way:

        allow domA_t domA_t : user_namespace { create };

Signed-off-by: Frederick Lawler <fred@cloudflare.com>

---
Changes since v3:
- None
Changes since v2:
- Rename create_user_ns hook to userns_create
- Use user_namespace as an object opposed to a generic namespace object
- s/domB_t/domA_t in commit message
Changes since v1:
- Introduce this patch
---
 security/selinux/hooks.c            | 9 +++++++++
 security/selinux/include/classmap.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index beceb89f68d9..afc9da0249e7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4227,6 +4227,14 @@ static void selinux_task_to_inode(struct task_struct *p,
 	spin_unlock(&isec->lock);
 }
 
+static int selinux_userns_create(const struct cred *cred)
+{
+	u32 sid = current_sid();
+
+	return avc_has_perm(&selinux_state, sid, sid, SECCLASS_USER_NAMESPACE,
+						USER_NAMESPACE__CREATE, NULL);
+}
+
 /* Returns error only if unable to parse addresses */
 static int selinux_parse_skb_ipv4(struct sk_buff *skb,
 			struct common_audit_data *ad, u8 *proto)
@@ -7117,6 +7125,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_movememory, selinux_task_movememory),
 	LSM_HOOK_INIT(task_kill, selinux_task_kill),
 	LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
+	LSM_HOOK_INIT(userns_create, selinux_userns_create),
 
 	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
 	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index ff757ae5f253..0bff55bb9cde 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -254,6 +254,8 @@ const struct security_class_mapping secclass_map[] = {
 	  { COMMON_FILE_PERMS, NULL } },
 	{ "io_uring",
 	  { "override_creds", "sqpoll", NULL } },
+	{ "user_namespace",
+	  { "create", NULL } },
 	{ NULL }
   };
 
-- 
2.30.2

