Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC246692986
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 22:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjBJVuv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 16:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjBJVuu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 16:50:50 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A2160E46
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 13:50:50 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 803B06BFC2D3; Fri, 10 Feb 2023 13:50:33 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: [RFC PATCH v2 07/19] mm: split off pages_volatile function
Date:   Fri, 10 Feb 2023 13:50:11 -0800
Message-Id: <20230210215023.2740545-8-shr@devkernel.io>
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

This splits off the pages_volatile function. The next patch will use
this function.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/ksm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 23d6944f78ad..7f3b28b7536e 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3271,8 +3271,7 @@ static ssize_t pages_unshared_show(struct kobject *=
kobj,
 }
 KSM_ATTR_RO(pages_unshared);
=20
-static ssize_t pages_volatile_show(struct kobject *kobj,
-				   struct kobj_attribute *attr, char *buf)
+static long pages_volatile(void)
 {
 	long ksm_pages_volatile;
=20
@@ -3284,7 +3283,14 @@ static ssize_t pages_volatile_show(struct kobject =
*kobj,
 	 */
 	if (ksm_pages_volatile < 0)
 		ksm_pages_volatile =3D 0;
-	return sysfs_emit(buf, "%ld\n", ksm_pages_volatile);
+
+	return ksm_pages_volatile;
+}
+
+static ssize_t pages_volatile_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%ld\n", pages_volatile());
 }
 KSM_ATTR_RO(pages_volatile);
=20
--=20
2.30.2

