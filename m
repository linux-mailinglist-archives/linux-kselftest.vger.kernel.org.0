Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB345269E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 May 2022 21:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383579AbiEMTJm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 May 2022 15:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383574AbiEMTJk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 May 2022 15:09:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C98363BBF9
        for <linux-kselftest@vger.kernel.org>; Fri, 13 May 2022 12:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652468977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=g2ByD6HON5FpzuaYZbt0zPasNhNKA4nJl1y1oOF2k0Q=;
        b=JtqRStM6zY+pnF9jxhXYemAeimXeuvD7HeDi2t4qiBTZgmd5mjWhxBD1XbbEYuAQXu3OlW
        YTf4K8PN4aNHynC9qDAQ2yEOztDSEdSvBz7+5NZe9cEghEyMdL/eZE2tBGhwXw2isXjBL0
        7wO29c7rt6TVvUBBb/PDk7Hej2cfkHo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-4FyVxrVrNKuZWrNOyJ2djQ-1; Fri, 13 May 2022 15:09:36 -0400
X-MC-Unique: 4FyVxrVrNKuZWrNOyJ2djQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0523680B71A;
        Fri, 13 May 2022 19:09:36 +0000 (UTC)
Received: from llong.com (unknown [10.22.11.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A28AF407E1C0;
        Fri, 13 May 2022 19:09:35 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] kseltest/cgroup: Make test_stress.sh work if run interactively
Date:   Fri, 13 May 2022 15:09:28 -0400
Message-Id: <20220513190928.676841-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 54de76c01239 ("kselftest/cgroup: fix test_stress.sh to use OUTPUT
dir") changes the test_core command path from . to $OUTPUT. However,
variable OUTPUT may not be defined if the command is run interactively.
Fix that by using ${OUTPUT:-.} to cover both cases.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/cgroup/test_stress.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_stress.sh b/tools/testing/selftests/cgroup/test_stress.sh
index 109c044f715f..3c9c4554d5f6 100755
--- a/tools/testing/selftests/cgroup/test_stress.sh
+++ b/tools/testing/selftests/cgroup/test_stress.sh
@@ -1,4 +1,4 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-./with_stress.sh -s subsys -s fork ${OUTPUT}/test_core
+./with_stress.sh -s subsys -s fork ${OUTPUT:-.}/test_core
-- 
2.27.0

