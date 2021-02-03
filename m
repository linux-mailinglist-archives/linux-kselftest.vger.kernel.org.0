Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E130E23C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Feb 2021 19:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232863AbhBCSPH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Feb 2021 13:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbhBCSNg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Feb 2021 13:13:36 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F296AC061224
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Feb 2021 10:12:26 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id s24so285804iob.6
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Feb 2021 10:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t4wenknjZ2bs5eKNUbWK97l2NFAOkxWA8p4z0taSinQ=;
        b=bK/hwc7BdBaznbintn00c0zRwBKC2JVyZWt36DBGWZYS3p6BVpJeOJEEamHAM+6vyC
         PXMgKamY4JH2XBuWrtRG8FAQpXZ0SLZ28VkyLw2OPhYx4rxDJ1ScO65tUPG+qdprJ9XJ
         vV1RasCSNiAfnS8ol5pPlvaIVj8bQiMEHpw8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t4wenknjZ2bs5eKNUbWK97l2NFAOkxWA8p4z0taSinQ=;
        b=mkHWCMHkx5dp2ccPeOrR8TjqwXO/GkhAAdD+pdAerzpUsunIKX+7YwuA7wtCrnO7Yy
         E7VsRSA3fvqlZu/IEglLhmSQEwg/QSAthOk1PdMTnYrT9lrXvRuQQ9s4yTiiVakyAEFX
         eGSoDKkkU7eOhoUoP/Qu2keH4HiX91M/KFEh8lVwiQ+xzUyyL9yVKbwOfM0vqiYAqSdD
         BQY447plJh496hTZ7r3WQYl8jAdAOan00cBmPDU8qfXh90rOcHDGzsSlHKMF2yG06pY3
         55riygUoq0tfaxVoSSi4KUOCY2hB7ObzafX+MVz19L7SKif9ntBce4ShqRkdGlMO8nBe
         aQ4g==
X-Gm-Message-State: AOAM530hCQG6u/iAYq7+71iFbejCeaM2H/i6vREwu85tjn2Dg0NlOxan
        CypmSNpVcDc3Vo2ihw80xZNhGQ==
X-Google-Smtp-Source: ABdhPJzuni/KqIxziQLcVYre754B6JcsdqYKUpMJ3ElrpM0fP5ipHxD7+qBAafURTEbI1MVyvOBomg==
X-Received: by 2002:a5e:a911:: with SMTP id c17mr2982344iod.20.1612375946517;
        Wed, 03 Feb 2021 10:12:26 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h21sm399684iob.30.2021.02.03.10.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 10:12:26 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, gregkh@linuxfoundation.org, peterz@infradead.org,
        keescook@chromium.org, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v3 7/7] kobject: convert uevent_seqnum to seqnum_ops
Date:   Wed,  3 Feb 2021 11:12:03 -0700
Message-Id: <3ddd122c266e8cb460542d852e9b703c6eef2141.1612314468.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1612314468.git.skhan@linuxfoundation.org>
References: <cover.1612314468.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sequence Number api provides interfaces for unsigned atomic up counters
leveraging atomic_t and atomic64_t ops underneath.

Convert uevent_seqnum atomic counter to use seqnum_ops.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 include/linux/kobject.h | 3 ++-
 kernel/ksysfs.c         | 3 ++-
 lib/kobject_uevent.c    | 9 ++++++---
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index ea30529fba08..8990e40344a2 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -27,6 +27,7 @@
 #include <linux/atomic.h>
 #include <linux/workqueue.h>
 #include <linux/uidgid.h>
+#include <linux/seqnum_ops.h>
 
 #define UEVENT_HELPER_PATH_LEN		256
 #define UEVENT_NUM_ENVP			64	/* number of env pointers */
@@ -38,7 +39,7 @@ extern char uevent_helper[];
 #endif
 
 /* counter to tag the uevent, read only except for the kobject core */
-extern u64 uevent_seqnum;
+extern struct seqnum64 uevent_seqnum;
 
 /*
  * The actions here must match the index to the string array
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 35859da8bd4f..15836f6e5998 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/capability.h>
 #include <linux/compiler.h>
+#include <linux/seqnum_ops.h>
 
 #include <linux/rcupdate.h>	/* rcu_expedited and rcu_normal */
 
@@ -31,7 +32,7 @@ static struct kobj_attribute _name##_attr = \
 static ssize_t uevent_seqnum_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)uevent_seqnum);
+	return sprintf(buf, "%llu\n", seqnum64_get(&uevent_seqnum));
 }
 KERNEL_ATTR_RO(uevent_seqnum);
 
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 7998affa45d4..3a7b2648f084 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -28,9 +28,10 @@
 #include <net/sock.h>
 #include <net/netlink.h>
 #include <net/net_namespace.h>
+#include <linux/seqnum_ops.h>
 
 
-u64 uevent_seqnum;
+struct seqnum64  uevent_seqnum;
 #ifdef CONFIG_UEVENT_HELPER
 char uevent_helper[UEVENT_HELPER_PATH_LEN] = CONFIG_UEVENT_HELPER_PATH;
 #endif
@@ -584,7 +585,8 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 
 	mutex_lock(&uevent_sock_mutex);
 	/* we will send an event, so request a new sequence number */
-	retval = add_uevent_var(env, "SEQNUM=%llu", ++uevent_seqnum);
+	retval = add_uevent_var(env, "SEQNUM=%llu",
+				seqnum64_inc(&uevent_seqnum));
 	if (retval) {
 		mutex_unlock(&uevent_sock_mutex);
 		goto exit;
@@ -687,7 +689,8 @@ static int uevent_net_broadcast(struct sock *usk, struct sk_buff *skb,
 	int ret;
 
 	/* bump and prepare sequence number */
-	ret = snprintf(buf, sizeof(buf), "SEQNUM=%llu", ++uevent_seqnum);
+	ret = snprintf(buf, sizeof(buf), "SEQNUM=%llu",
+			seqnum64_inc(&uevent_seqnum));
 	if (ret < 0 || (size_t)ret >= sizeof(buf))
 		return -ENOMEM;
 	ret++;
-- 
2.27.0

