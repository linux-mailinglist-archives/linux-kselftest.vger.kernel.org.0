Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F186929B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 22:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjBJV54 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 16:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbjBJV5z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 16:57:55 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5387DD1F
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 13:57:54 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 9EAD76BFC2E3; Fri, 10 Feb 2023 13:50:33 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [RFC PATCH v2 14/19] docs: document new procfs ksm knobs
Date:   Fri, 10 Feb 2023 13:50:18 -0800
Message-Id: <20230210215023.2740545-15-shr@devkernel.io>
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

Document both ksm_process_profit and ksm_merge_type proc settings.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
Reviewed-By: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/mm/ksm.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-g=
uide/mm/ksm.rst
index 5c4daf44d79d..34f1d0396eee 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -218,7 +218,8 @@ several times, which are unprofitable memory consumed=
.
 			  ksm_rmap_items * sizeof(rmap_item).
=20
    where ksm_merging_pages is shown under the directory ``/proc/<pid>/``=
,
-   and ksm_rmap_items is shown in ``/proc/<pid>/ksm_stat``.
+   and ksm_rmap_items is shown in ``/proc/<pid>/ksm_stat``. The process =
profit
+   is also shown in ``/proc/<pid>/ksm_stat`` as ksm_process_profit.
=20
 From the perspective of application, a high ratio of ``ksm_rmap_items`` =
to
 ``ksm_merging_pages`` means a bad madvise-applied policy, so developers =
or
@@ -229,6 +230,9 @@ so if the ``ksm_rmap_items/ksm_merging_pages`` ratio =
exceeds 64 on 64-bit CPU
 or exceeds 128 on 32-bit CPU, then the app's madvise policy should be dr=
opped,
 because the ksm profit is approximately zero or negative.
=20
+The ksm_merge_type in ``/proc/<pid>/ksm_stat`` shows the merge type of t=
he
+process. Valid values are ``none``, ``madvise`` and ``process``.
+
 Monitoring KSM events
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
--=20
2.30.2

