Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C811458B269
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Aug 2022 00:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241688AbiHEWWA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Aug 2022 18:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241813AbiHEWV7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Aug 2022 18:21:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BDA1BEB9
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Aug 2022 15:21:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k13-20020a056902024d00b0066fa7f50b97so3103125ybs.6
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Aug 2022 15:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p3xudRLR9dNuWUK9U/ylm6O3b8FVaNLRrb9pQqFzR0w=;
        b=tEC+w7ZCMSi41gOV32xpW1cs0vFZd0pjxoK1AeJyyH01noSX4dLvRhywvBcccI9kdU
         JKFh83XKg1Si8IMewvVtmvDTWjRKjw3vuzZtx6w3xA2KeuXUxoU/6vRz//098kabUzjE
         eFwl26ps6MG+nYqCcCI1foMbFHepHOTyrxI0z85iwM8dIVVGbzs366K/ASaVu+V0zPT/
         uJ/lsElcVWzYS8YYewDpoOAwFTi+w1gRSdsGaOWMYHEI+AEzCyag0hQVzUs3cU93g+T8
         p0Ut/ZVPUs8LdBcNe3+7UfinveQxYxEtWF7YFesMt+DabZUIKwIYMEaR3aoNOvIbKV0C
         8E5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p3xudRLR9dNuWUK9U/ylm6O3b8FVaNLRrb9pQqFzR0w=;
        b=mwISkIe/97Sy6/c1xmVJjiBWdRt4clOSCZZjPi0NrxNK7WtG1Re7yud6GFBVpRPMWo
         AKhnH1Bratp0xyAWKfXZyuhABy9wWfnouq0oxZf3bkjQPelZ9bDNWRkNzQdHYdj7OZET
         +hXOTMYl+scG04CqTkvOXuiBix4D8pSeJVrBSVcdjj2YVgUJKj8Z8LEV86X+UdV0+JTw
         UNQzX2G5bziIeKaEXPk28qNHUU2j1NZb8K/ljm4ZZTD0BqDeiJfJVBMT2XexCzhU8NK4
         mlusOhaAurMwy6he4g4YFwjrtCGKSGYBnCWYY4rG7nrmif+p8Pj7t4twnoL7HODBGmdY
         WCSg==
X-Gm-Message-State: ACgBeo1nYiBt4KG1ppOjFmFzJKkoH5kx86aRgKEVIv3kdbYRyYvBKF7x
        oml8esnDI55/5SZ1vuySqI1xRws5Oy8=
X-Google-Smtp-Source: AA6agR7Pdt67CAVIWF/fYp+P3xXpceR93JSbt9+i7cJEfvpa+CoelR+6dqwVhJxpBe3viA/07hQjowUu1E0=
X-Received: from jeffxud.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:e37])
 (user=jeffxu job=sendgmr) by 2002:a25:33c5:0:b0:67a:6950:c188 with SMTP id
 z188-20020a2533c5000000b0067a6950c188mr7334020ybz.175.1659738117501; Fri, 05
 Aug 2022 15:21:57 -0700 (PDT)
Date:   Fri,  5 Aug 2022 22:21:26 +0000
In-Reply-To: <20220805222126.142525-1-jeffxu@google.com>
Message-Id: <20220805222126.142525-6-jeffxu@google.com>
Mime-Version: 1.0
References: <20220805222126.142525-1-jeffxu@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v2 5/5] sysctl: add support for mfd_noexec
From:   <jeffxu@google.com>
To:     skhan@linuxfoundation.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        Jeff Xu <jeffxu@chromium.org>
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

From: Jeff Xu <jeffxu@chromium.org>

Add vm.mfd_noexec.  When the value is 1 (enabled),
memfd_create syscall will created non-executable memfd.

The default value is 0 (disabled), admin can change the
setting from 0 => 1, however 1 => 0 is not allowed,
unless reboot.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/linux/mm.h |  4 ++++
 kernel/sysctl.c    |  9 +++++++++
 mm/memfd.c         | 27 +++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7898e29bcfb5..1c66cf4aca11 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -203,6 +203,10 @@ extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
 extern unsigned long sysctl_overcommit_kbytes;
 
+extern int sysctl_mfd_noexec_scope;
+extern int mfd_noexec_dointvec_minmax(struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos);
+
 int overcommit_ratio_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
 int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b233714a1c78..54510da007ff 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2362,6 +2362,15 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= mmap_min_addr_handler,
 	},
+	{
+		.procname       = "mfd_noexec",
+		.data           = &sysctl_mfd_noexec_scope,
+		.maxlen         = sizeof(sysctl_mfd_noexec_scope),
+		.mode           = 0644,
+		.proc_handler   = mfd_noexec_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
 #endif
 #ifdef CONFIG_NUMA
 	{
diff --git a/mm/memfd.c b/mm/memfd.c
index b841514eb0fd..c6ccb8481ed2 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -20,6 +20,11 @@
 #include <linux/memfd.h>
 #include <uapi/linux/memfd.h>
 
+#define MFD_NOEXEC_SCOPE_DISABLED	0
+#define MFD_NOEXEC_SCOPE_ENABLED	1
+
+int sysctl_mfd_noexec_scope __read_mostly = MFD_NOEXEC_SCOPE_DISABLED;
+
 /*
  * We need a tag: a new tag would expand every xa_node by 8 bytes,
  * so reuse a tag which we firmly believe is never set or cleared on tmpfs
@@ -275,6 +280,10 @@ SYSCALL_DEFINE2(memfd_create,
 	char *name;
 	long len;
 
+	if (sysctl_mfd_noexec_scope == MFD_NOEXEC_SCOPE_ENABLED) {
+		flags |= MFD_NOEXEC;
+	}
+
 	if (!(flags & MFD_HUGETLB)) {
 		if (flags & ~(unsigned int)MFD_ALL_FLAGS)
 			return -EINVAL;
@@ -351,3 +360,21 @@ SYSCALL_DEFINE2(memfd_create,
 	kfree(name);
 	return error;
 }
+
+#ifdef CONFIG_SYSCTL
+int mfd_noexec_dointvec_minmax(struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table table_copy;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/* Lock the max value if it ever gets set. */
+	table_copy = *table;
+	if (*(int *)table_copy.data == *(int *)table_copy.extra2)
+		table_copy.extra1 = table_copy.extra2;
+
+	return proc_dointvec_minmax(&table_copy, write, buffer, lenp, ppos);
+}
+#endif
-- 
2.37.1.559.g78731f0fdb-goog

