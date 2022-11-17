Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF60362CF55
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 01:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiKQAHs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 19:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiKQAHr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 19:07:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8329F110C
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 16:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668643610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZLAErkYkAURoUFblE/LNyl2bM120+OvwzIhnkvyLL0o=;
        b=ZAgze1dcnaaJPFGoYYWvJOlGrH+iC6TrUNOWWtxKdfUOj6iJ4j2G8NRQeV0FQkMpT2ow4p
        WzJQT6LZybzj+aHWmEiLxLv4vLItIC8zvmV3bRhbkTflQ4H0bLo9asPouqpiODgR/6srkZ
        VtMJhyK4Nxg7w1pnnjr9fCRR9Eypzho=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-KnUxh2kMNYSddgZkusLsPg-1; Wed, 16 Nov 2022 19:06:46 -0500
X-MC-Unique: KnUxh2kMNYSddgZkusLsPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A94E3C01DF4;
        Thu, 17 Nov 2022 00:06:46 +0000 (UTC)
Received: from jsavitz-csb.redhat.com (unknown [10.22.18.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26B20140EBF3;
        Thu, 17 Nov 2022 00:06:45 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-next@vger.kernel.org,
        Nico Pache <npache@redhat.com>
Subject: [PATCH mm-everything] selftests/vm: remove extraneous echo
Date:   Wed, 16 Nov 2022 20:06:32 -0400
Message-Id: <20221117000632.254027-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is an extra echo statement in run_test(). Remove it.

Fixes: 98b3add737b4 ("selftests/vm: enable running select groups of tests")

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index ce52e4f5ff21..9236010faaaa 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -142,7 +142,6 @@ echo "$ARCH64STR" | grep "$ARCH" &>/dev/null && VADDR64=1
 # Usage: run_test [test binary] [arbitrary test arguments...]
 run_test() {
 	if test_selected ${CATEGORY}; then
-		echo "running: $1"
 		local title="running $*"
 		local sep=$(echo -n "$title" | tr "[:graph:][:space:]" -)
 		printf "%s\n%s\n%s\n" "$sep" "$title" "$sep"
-- 
2.38.1


