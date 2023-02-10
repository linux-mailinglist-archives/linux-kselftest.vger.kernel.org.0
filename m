Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E7769299A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 22:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjBJVyM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 16:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjBJVxu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 16:53:50 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2492D5AB1E
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 13:53:49 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 7BD896BFC2D1; Fri, 10 Feb 2023 13:50:33 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: [RFC PATCH v2 06/19] mm: add new prctl option to get and set ksm for a process
Date:   Fri, 10 Feb 2023 13:50:10 -0800
Message-Id: <20230210215023.2740545-7-shr@devkernel.io>
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

This adds two new options to the prctl system call
- enable ksm for all vmas of a process (if the vmas support it).
- query if ksm has been enabled for a process.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/uapi/linux/prctl.h |  2 ++
 kernel/sys.c               | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 1312a137f7fb..759b3f53e53f 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -290,4 +290,6 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
=20
+#define PR_SET_MEMORY_MERGE		67
+#define PR_GET_MEMORY_MERGE		68
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index b3cab94545ed..495bab3ed2ad 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -15,6 +15,7 @@
 #include <linux/highuid.h>
 #include <linux/fs.h>
 #include <linux/kmod.h>
+#include <linux/ksm.h>
 #include <linux/perf_event.h>
 #include <linux/resource.h>
 #include <linux/kernel.h>
@@ -2659,6 +2660,34 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long,=
 arg2, unsigned long, arg3,
 	case PR_SET_VMA:
 		error =3D prctl_set_vma(arg2, arg3, arg4, arg5);
 		break;
+#ifdef CONFIG_KSM
+	case PR_SET_MEMORY_MERGE:
+		if (!capable(CAP_SYS_RESOURCE))
+			return -EPERM;
+
+		if (arg2) {
+			if (mmap_write_lock_killable(me->mm))
+				return -EINTR;
+
+			if (test_bit(MMF_VM_MERGEABLE, &me->mm->flags))
+				error =3D -EINVAL;
+			else if (!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags))
+				error =3D __ksm_enter(me->mm, MMF_VM_MERGE_ANY);
+			mmap_write_unlock(me->mm);
+		} else {
+			__ksm_exit(me->mm, MMF_VM_MERGE_ANY);
+		}
+		break;
+	case PR_GET_MEMORY_MERGE:
+		if (!capable(CAP_SYS_RESOURCE))
+			return -EPERM;
+
+		if (arg2 || arg3 || arg4 || arg5)
+			return -EINVAL;
+
+		error =3D !!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
+		break;
+#endif
 	default:
 		error =3D -EINVAL;
 		break;
--=20
2.30.2

