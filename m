Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DB1706965
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 15:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjEQNON (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 09:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjEQNNt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 09:13:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F309383EC;
        Wed, 17 May 2023 06:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58182614CC;
        Wed, 17 May 2023 13:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82ACBC433A1;
        Wed, 17 May 2023 13:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329190;
        bh=d19FT2UXzed3oRWIfJJFjSTk/2JiLUfj9No4RlO7/6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1+6zXZHFnxnG+wOAs+I7Jk3ZmwjP67pJgzP0uRLk1KweQErWDtrD6kcCaiJbOcnT
         FeyForINJFNNHVR7SlZDLxBqXsy6U1Q8QSU2g7HzT+HDxANY+2tRRB/juS7IWqHnN0
         R7uJEX9uIR2BJ1iVGwpgqVvJxOimPbuxDH8nVE33oigOLH+a2C6WGLVT5O2FBvlKz1
         1cchN4Ol9FfjcJdHRvb6NG6ME/EGUJBb5JSRXXIOYIHDL60v7knAjAptFgq2qEdzKr
         kBNHvdOcis7Z2szvD6pixKpaEvKxiNP2G0OykAdHnW8HCBkYh+jiZUMYx1rLc8DsBc
         EwxZhq5xDzb7g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        audit@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH 12/14] init: move cifs_root_data() prototype into linux/mount.h
Date:   Wed, 17 May 2023 15:11:00 +0200
Message-Id: <20230517131102.934196-13-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517131102.934196-1-arnd@kernel.org>
References: <20230517131102.934196-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

cifs_root_data() is defined in cifs and called from early init
code, but lacks a global prototype:

fs/cifs/cifsroot.c:83:12: error: no previous prototype for 'cifs_root_data'

Move the declaration from do_mounts.c into an appropriate header.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/mount.h | 2 ++
 init/do_mounts.c      | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mount.h b/include/linux/mount.h
index 1ea326c368f7..f381eb44b24c 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -124,4 +124,6 @@ extern int iterate_mounts(int (*)(struct vfsmount *, void *), void *,
 			  struct vfsmount *);
 extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int num);
 
+extern int cifs_root_data(char **dev, char **opts);
+
 #endif /* _LINUX_MOUNT_H */
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 811e94daf0a8..83447c46ad6d 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -489,8 +489,6 @@ static int __init mount_nfs_root(void)
 
 #ifdef CONFIG_CIFS_ROOT
 
-extern int cifs_root_data(char **dev, char **opts);
-
 #define CIFSROOT_TIMEOUT_MIN	5
 #define CIFSROOT_TIMEOUT_MAX	30
 #define CIFSROOT_RETRY_MAX	5
-- 
2.39.2

