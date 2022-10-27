Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C492560FDF5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 19:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbiJ0RAu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 13:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiJ0RAt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 13:00:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D919A9DE
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Oct 2022 10:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666890048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OLxo65GqqyDAg4pQmkoaDcyRjV3222s+5rEKoJQtb20=;
        b=J+2TlVmfzJtlVpfc0vOODnqd/4Q4gMJmERctniPnm5cQs2VDYZqQP0l1iKUcXNLLo7feXk
        r2Kke2Pho4DlyhlWCPOCx2A7uk0iId6+JjWWQEVejuEDk6RNi1aLHKrYXmCFg1+N8ox97y
        Q212etztbNgvSmkA7k/lRGvWjB/TnHE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-DzEm0zyWOb6egDRYU4pQAA-1; Thu, 27 Oct 2022 13:00:45 -0400
X-MC-Unique: DzEm0zyWOb6egDRYU4pQAA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEBC9858F13;
        Thu, 27 Oct 2022 17:00:44 +0000 (UTC)
Received: from jsavitz-csb.redhat.com (unknown [10.22.17.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 666491121320;
        Thu, 27 Oct 2022 17:00:44 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <dhildenb@redhat.com>,
        Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH linux-next] selftests/vm: add CATEGORY for ksm_functional_tests
Date:   Thu, 27 Oct 2022 13:00:43 -0400
Message-Id: <20221027170043.2363797-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

commit e080ceaa69c1 ("selftests/vm: add KSM unmerge tests") in
linux-next adds an entry to run_vmtests.sh. I recently submitted
commit b5ba705c2608 ("selftests/vm: enable running select groups of tests")
to linux-next which categorizes tests by functionality in order to
allow more precise selection of which tests are to be run.

Since this newest test targets ksm and does not require more than one
numa node, add 'CATEGORY="ksm"' to the invocation to group this test
with the other ksm tests.

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index af35dd3bc589..fff00bb77086 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -252,7 +252,7 @@ CATEGORY="ksm_numa" run_test ./ksm_tests -N -m 1
 # KSM test with 2 NUMA nodes and merge_across_nodes = 0
 CATEGORY="ksm_numa" run_test ./ksm_tests -N -m 0
 
-run_test ./ksm_functional_tests
+CATEGORY="ksm" run_test ./ksm_functional_tests
 
 # protection_keys tests
 if [ -x ./protection_keys_32 ]
-- 
2.31.1

