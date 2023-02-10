Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEBB692987
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 22:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjBJVuw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 16:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjBJVuv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 16:50:51 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E274A60D4D
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 13:50:50 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 6E3806BFC2C9; Fri, 10 Feb 2023 13:50:33 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: [RFC PATCH v2 03/19] mm: add flag to __ksm_exit call
Date:   Fri, 10 Feb 2023 13:50:07 -0800
Message-Id: <20230210215023.2740545-4-shr@devkernel.io>
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

This adds the flag parameter to the __ksm_exit() call. This allows to
distinguish if this call is for an prctl or madvise invocation.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/ksm.h | 8 +++++---
 mm/ksm.c            | 8 ++++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 50e6b56092f3..d38a05a36298 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -18,8 +18,8 @@
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
-void __ksm_exit(struct mm_struct *mm);
 int __ksm_enter(struct mm_struct *mm, int flag);
+void __ksm_exit(struct mm_struct *mm, int flag);
=20
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm=
)
 {
@@ -32,8 +32,10 @@ static inline int ksm_fork(struct mm_struct *mm, struc=
t mm_struct *oldmm)
=20
 static inline void ksm_exit(struct mm_struct *mm)
 {
-	if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
-		__ksm_exit(mm);
+	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
+		__ksm_exit(mm, MMF_VM_MERGE_ANY);
+	else if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
+		__ksm_exit(mm, MMF_VM_MERGEABLE);
 }
=20
 /*
diff --git a/mm/ksm.c b/mm/ksm.c
index afc0980592af..3597ae52fe7b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2665,12 +2665,16 @@ int __ksm_enter(struct mm_struct *mm, int flag)
 	return 0;
 }
=20
-void __ksm_exit(struct mm_struct *mm)
+void __ksm_exit(struct mm_struct *mm, int flag)
 {
 	struct ksm_mm_slot *mm_slot;
 	struct mm_slot *slot;
 	int easy_to_free =3D 0;
=20
+	if (!(current->flags & PF_EXITING) && flag =3D=3D MMF_VM_MERGE_ANY &&
+	    test_bit(MMF_VM_MERGE_ANY, &mm->flags))
+		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
+
 	/*
 	 * This process is exiting: if it's straightforward (as is the
 	 * case when ksmd was never running), free mm_slot immediately.
@@ -2697,7 +2701,7 @@ void __ksm_exit(struct mm_struct *mm)
=20
 	if (easy_to_free) {
 		mm_slot_free(mm_slot_cache, mm_slot);
-		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
+		clear_bit(flag, &mm->flags);
 		mmdrop(mm);
 	} else if (mm_slot) {
 		mmap_write_lock(mm);
--=20
2.30.2

