Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA1969299B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 22:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjBJVyM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 16:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjBJVxx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 16:53:53 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696975ACF2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 13:53:51 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 849216BFC2D5; Fri, 10 Feb 2023 13:50:33 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: [RFC PATCH v2 08/19] mm: expose general_profit metric
Date:   Fri, 10 Feb 2023 13:50:12 -0800
Message-Id: <20230210215023.2740545-9-shr@devkernel.io>
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

The documentation mentions a general profit metric, however this metric
is not calculated. In addition the formula depends on the size of
internal structures, which makes it more difficult for an administrator
to make the calculation. Adding the metric for a better user experience.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/ksm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 7f3b28b7536e..a0b4611112c0 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3301,6 +3301,21 @@ static ssize_t zero_pages_sharing_show(struct kobj=
ect *kobj,
 }
 KSM_ATTR_RO(zero_pages_sharing);
=20
+static ssize_t general_profit_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	long general_profit;
+	long all_rmap_items;
+
+	all_rmap_items =3D ksm_max_page_sharing + ksm_pages_shared +
+				ksm_pages_unshared + pages_volatile();
+	general_profit =3D ksm_pages_sharing * PAGE_SIZE -
+				all_rmap_items * sizeof(struct ksm_rmap_item);
+
+	return sysfs_emit(buf, "%ld\n", general_profit);
+}
+KSM_ATTR_RO(general_profit);
+
 static ssize_t stable_node_dups_show(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *buf)
 {
@@ -3366,6 +3381,7 @@ static struct attribute *ksm_attrs[] =3D {
 	&stable_node_dups_attr.attr,
 	&stable_node_chains_prune_millisecs_attr.attr,
 	&use_zero_pages_attr.attr,
+	&general_profit_attr.attr,
 	NULL,
 };
=20
--=20
2.30.2

