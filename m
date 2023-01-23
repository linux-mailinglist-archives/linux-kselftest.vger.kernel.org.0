Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4007678421
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 19:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjAWSGi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 13:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjAWSGc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 13:06:32 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5DF31E01
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jan 2023 10:06:13 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 6F5EE5616BE9; Mon, 23 Jan 2023 09:37:56 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     linux-mm@kvack.org
Cc:     shr@devkernel.io, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v1 12/20] mm: add ksm_merge_type() function
Date:   Mon, 23 Jan 2023 09:37:40 -0800
Message-Id: <20230123173748.1734238-13-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123173748.1734238-1-shr@devkernel.io>
References: <20230123173748.1734238-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_NEUTRAL,SUSPICIOUS_RECIPS,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds the ksm_merge_type function. The function returns the merge
type for the process. For madvise it returns "madvise", for prctl it
returns "process" and otherwise it returns "none".

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/ksm.h |  1 +
 mm/ksm.c            | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index a18cd03efcfb..d5f69f18ee5a 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -57,6 +57,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct f=
olio *folio);
=20
 #ifdef CONFIG_PROC_FS
 long ksm_process_profit(struct mm_struct *);
+const char *ksm_merge_type(struct mm_struct *mm);
 #endif /* CONFIG_PROC_FS */
=20
 #else  /* !CONFIG_KSM */
diff --git a/mm/ksm.c b/mm/ksm.c
index 288689b59527..57183deaf529 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2941,6 +2941,17 @@ long ksm_process_profit(struct mm_struct *mm)
 	return (long)mm->ksm_merging_pages * PAGE_SIZE -
 		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
 }
+
+/* Return merge type name as string. */
+const char *ksm_merge_type(struct mm_struct *mm)
+{
+	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
+		return "process";
+	else if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
+		return "madvise";
+	else
+		return "none";
+}
 #endif /* CONFIG_PROC_FS */
=20
 #ifdef CONFIG_SYSFS
--=20
2.30.2

