Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526A069298C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 22:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjBJVu6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 16:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbjBJVu5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 16:50:57 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF57A635A0
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 13:50:55 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 776656BFC2CF; Fri, 10 Feb 2023 13:50:33 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: [RFC PATCH v2 05/19] mm: support disabling of ksm for a process
Date:   Fri, 10 Feb 2023 13:50:09 -0800
Message-Id: <20230210215023.2740545-6-shr@devkernel.io>
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

This adds the ability to disable ksm for a process if ksm has been
enabled for the process.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/ksm.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index efd8d3804de3..23d6944f78ad 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2690,6 +2690,27 @@ int __ksm_enter(struct mm_struct *mm, int flag)
 	return 0;
 }
=20
+static void unmerge_vmas(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+	struct vma_iterator vmi;
+
+	vma_iter_init(&vmi, mm, 0);
+
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
+		if (vma->vm_flags & VM_MERGEABLE) {
+			unsigned long flags =3D vma->vm_flags;
+
+			if (ksm_madvise(vma, vma->vm_start, vma->vm_end, MADV_UNMERGEABLE, &f=
lags))
+				continue;
+
+			vm_flags_clear(vma, VM_MERGEABLE);
+		}
+	}
+	mmap_read_unlock(mm);
+}
+
 void __ksm_exit(struct mm_struct *mm, int flag)
 {
 	struct ksm_mm_slot *mm_slot;
@@ -2697,8 +2718,10 @@ void __ksm_exit(struct mm_struct *mm, int flag)
 	int easy_to_free =3D 0;
=20
 	if (!(current->flags & PF_EXITING) && flag =3D=3D MMF_VM_MERGE_ANY &&
-	    test_bit(MMF_VM_MERGE_ANY, &mm->flags))
+		test_bit(MMF_VM_MERGE_ANY, &mm->flags)) {
 		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
+		unmerge_vmas(mm);
+	}
=20
 	/*
 	 * This process is exiting: if it's straightforward (as is the
--=20
2.30.2

