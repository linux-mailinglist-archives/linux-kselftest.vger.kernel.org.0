Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611156929CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 23:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjBJWEC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 17:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjBJWEB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 17:04:01 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FA17E024
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 14:04:00 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id A31F86BFC2E5; Fri, 10 Feb 2023 13:50:33 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: [RFC PATCH v2 15/19] tools: add new prctl flags to prctl in tools dir
Date:   Fri, 10 Feb 2023 13:50:19 -0800
Message-Id: <20230210215023.2740545-16-shr@devkernel.io>
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

This adds the new prctl flags to the include file prct.h in the tools
directory. This makes sure they are available for testing.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 tools/include/uapi/linux/prctl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/=
prctl.h
index a5e06dcbba13..e4c629c1f1b0 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -284,4 +284,6 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
=20
+#define PR_SET_MEMORY_MERGE		67
+#define PR_GET_MEMORY_MERGE		68
 #endif /* _LINUX_PRCTL_H */
--=20
2.30.2

