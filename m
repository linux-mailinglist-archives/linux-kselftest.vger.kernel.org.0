Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0276112B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 15:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiJ1N17 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 09:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ1N1z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 09:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880DE1CCCD9
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 06:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666963618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nMEqJ+SJX81wA4F4D8VcQ1oWVGj7/HJA80MojM8MPSQ=;
        b=CFSdZ2opJf4ryyuNDY8cLJzZ4oEBYkoqer1sRCux6RKCEUyqX34w3HE16BPpxqqWSAHJcy
        ztZt2RcJdId68vmL3iUMyi5wy/qvDiHGDdjTUS8Qa65WoUJJO5K09zNjApj3bSXWczjaNa
        Q1EK79tuhFBEkHe9yO4ULYEzR/H+9Zg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-eXGXvRW4NzCQ6fMIzMAqUA-1; Fri, 28 Oct 2022 09:26:56 -0400
X-MC-Unique: eXGXvRW4NzCQ6fMIzMAqUA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDD8484ACA0;
        Fri, 28 Oct 2022 13:26:55 +0000 (UTC)
Received: from jsavitz-csb.redhat.com (unknown [10.22.16.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F9CE492B06;
        Fri, 28 Oct 2022 13:26:53 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <dhildenb@redhat.com>,
        Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH linux-next] selftests/vm: calculate variables in correct order
Date:   Fri, 28 Oct 2022 09:26:40 -0400
Message-Id: <20221028132640.2791026-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

commit b5ba705c2608 ("selftests/vm: enable running select groups of tests")
unintentionally reversed the ordering of some of the lines of
run_vmtests.sh that calculate values based on system configuration.
Importantly, $hpgsize_MB is determined from $hpgsize_KB, but this later
value is not read from /proc/meminfo until later, causing userfaultfd
tests to incorrectly fail since $half_ufd_size_MB will always be 0.

Switch these statements around into proper order to fix the invocation
of the userfaultfd tests that use $half_ufd_size_MB.

Suggested-by: Nico Pache <npache@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index fff00bb77086..ce52e4f5ff21 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -82,16 +82,6 @@ test_selected() {
 	fi
 }
 
-# Simple hugetlbfs tests have a hardcoded minimum requirement of
-# huge pages totaling 256MB (262144KB) in size.  The userfaultfd
-# hugetlb test requires a minimum of 2 * nr_cpus huge pages.  Take
-# both of these requirements into account and attempt to increase
-# number of huge pages available.
-nr_cpus=$(nproc)
-hpgsize_MB=$((hpgsize_KB / 1024))
-half_ufd_size_MB=$((((nr_cpus * hpgsize_MB + 127) / 128) * 128))
-needmem_KB=$((half_ufd_size_MB * 2 * 1024))
-
 # get huge pagesize and freepages from /proc/meminfo
 while read -r name size unit; do
 	if [ "$name" = "HugePages_Free:" ]; then
@@ -102,6 +92,16 @@ while read -r name size unit; do
 	fi
 done < /proc/meminfo
 
+# Simple hugetlbfs tests have a hardcoded minimum requirement of
+# huge pages totaling 256MB (262144KB) in size.  The userfaultfd
+# hugetlb test requires a minimum of 2 * nr_cpus huge pages.  Take
+# both of these requirements into account and attempt to increase
+# number of huge pages available.
+nr_cpus=$(nproc)
+hpgsize_MB=$((hpgsize_KB / 1024))
+half_ufd_size_MB=$((((nr_cpus * hpgsize_MB + 127) / 128) * 128))
+needmem_KB=$((half_ufd_size_MB * 2 * 1024))
+
 # set proper nr_hugepages
 if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
 	nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
-- 
2.31.1

