Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C9069298E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 22:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjBJVu7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 16:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjBJVu5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 16:50:57 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB786BABF
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 13:50:55 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 72D2E6BFC2CB; Fri, 10 Feb 2023 13:50:33 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: [RFC PATCH v2 04/19] mm: invoke madvise for all vmas in scan_get_next_rmap_item
Date:   Fri, 10 Feb 2023 13:50:08 -0800
Message-Id: <20230210215023.2740545-5-shr@devkernel.io>
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

If the new flag MMF_VM_MERGE_ANY has been set for a process, iterate
over all the vmas and enable ksm if possible. For the vmas that can be
ksm enabled this is only done once.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/ksm.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 3597ae52fe7b..efd8d3804de3 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1063,6 +1063,7 @@ static int unmerge_and_remove_all_rmap_items(void)
=20
 			mm_slot_free(mm_slot_cache, mm_slot);
 			clear_bit(MMF_VM_MERGEABLE, &mm->flags);
+			clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
 			mmdrop(mm);
 		} else
 			spin_unlock(&ksm_mmlist_lock);
@@ -2329,6 +2330,17 @@ static struct ksm_rmap_item *get_next_rmap_item(st=
ruct ksm_mm_slot *mm_slot,
 	return rmap_item;
 }
=20
+static bool vma_ksm_mergeable(struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_MERGEABLE)
+		return true;
+
+	if (test_bit(MMF_VM_MERGE_ANY, &vma->vm_mm->flags))
+		return true;
+
+	return false;
+}
+
 static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 {
 	struct mm_struct *mm;
@@ -2405,8 +2417,20 @@ static struct ksm_rmap_item *scan_get_next_rmap_it=
em(struct page **page)
 		goto no_vmas;
=20
 	for_each_vma(vmi, vma) {
-		if (!(vma->vm_flags & VM_MERGEABLE))
+		if (!vma_ksm_mergeable(vma))
 			continue;
+		if (!(vma->vm_flags & VM_MERGEABLE)) {
+			unsigned long flags =3D vma->vm_flags;
+
+			/* madvise failed, use next vma */
+			if (ksm_madvise(vma, vma->vm_start, vma->vm_end, MADV_MERGEABLE, &fla=
gs))
+				continue;
+			/* vma, not supported as being mergeable */
+			if (!(flags & VM_MERGEABLE))
+				continue;
+
+			vm_flags_set(vma, VM_MERGEABLE);
+		}
 		if (ksm_scan.address < vma->vm_start)
 			ksm_scan.address =3D vma->vm_start;
 		if (!vma->anon_vma)
@@ -2491,6 +2515,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_ite=
m(struct page **page)
=20
 		mm_slot_free(mm_slot_cache, mm_slot);
 		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
+		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
 		mmap_read_unlock(mm);
 		mmdrop(mm);
 	} else {
--=20
2.30.2

