Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46031692984
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 22:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjBJVuv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 16:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbjBJVuu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 16:50:50 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17DF4DE3D
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 13:50:49 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 69CB96BFC2C7; Fri, 10 Feb 2023 13:50:33 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: [RFC PATCH v2 02/19] mm: add flag to __ksm_enter
Date:   Fri, 10 Feb 2023 13:50:06 -0800
Message-Id: <20230210215023.2740545-3-shr@devkernel.io>
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

This change adds the flag parameter to __ksm_enter. This allows to
distinguish if ksm was called by prctl or madvise.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/ksm.h | 6 ++++--
 mm/ksm.c            | 9 +++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 7e232ba59b86..50e6b56092f3 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -18,13 +18,15 @@
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
-int __ksm_enter(struct mm_struct *mm);
 void __ksm_exit(struct mm_struct *mm);
+int __ksm_enter(struct mm_struct *mm, int flag);
=20
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm=
)
 {
+	if (test_bit(MMF_VM_MERGE_ANY, &oldmm->flags))
+		return __ksm_enter(mm, MMF_VM_MERGE_ANY);
 	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
-		return __ksm_enter(mm);
+		return __ksm_enter(mm, MMF_VM_MERGEABLE);
 	return 0;
 }
=20
diff --git a/mm/ksm.c b/mm/ksm.c
index 56808e3bfd19..afc0980592af 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2595,8 +2595,9 @@ int ksm_madvise(struct vm_area_struct *vma, unsigne=
d long start,
 			return 0;
 #endif
=20
-		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
-			err =3D __ksm_enter(mm);
+		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags) &&
+		    !test_bit(MMF_VM_MERGE_ANY, &mm->flags)) {
+			err =3D __ksm_enter(mm, MMF_VM_MERGEABLE);
 			if (err)
 				return err;
 		}
@@ -2622,7 +2623,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigne=
d long start,
 }
 EXPORT_SYMBOL_GPL(ksm_madvise);
=20
-int __ksm_enter(struct mm_struct *mm)
+int __ksm_enter(struct mm_struct *mm, int flag)
 {
 	struct ksm_mm_slot *mm_slot;
 	struct mm_slot *slot;
@@ -2655,7 +2656,7 @@ int __ksm_enter(struct mm_struct *mm)
 		list_add_tail(&slot->mm_node, &ksm_scan.mm_slot->slot.mm_node);
 	spin_unlock(&ksm_mmlist_lock);
=20
-	set_bit(MMF_VM_MERGEABLE, &mm->flags);
+	set_bit(flag, &mm->flags);
 	mmgrab(mm);
=20
 	if (needs_wakeup)
--=20
2.30.2

