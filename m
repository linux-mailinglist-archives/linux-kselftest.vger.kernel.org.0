Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082DB57A7A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 21:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbiGST4o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 15:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbiGST4h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 15:56:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9315A2C9
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 12:56:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31e55518830so33527977b3.23
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 12:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2lmji2pJwQUUP3R6t1yXuXRPrPh1yDx0i1mGLg8CxXk=;
        b=rRPjfzCfRNd5lQiZ67VG1PsIVIYjPwFy08N1NgXwZEdmOj6JA+coqAzVWkDJIlNRY5
         YYf3Y/bM+zhmKkRWAsQ2bjiJrwYdl3VnbCcCZGMRHF6ew7w4EywM1I3/QseVs1Mn1HXX
         tpRbi7PWHIGlDIpJweXOzNMEFyij2g2rnpJrMrBPd0i5ICMUSiInyP+w3GQ4/Jk2pCQB
         aC/ZpgWXZ+1KmqHJq0wUclsGmDY8ho2QpLzY95UOiGq0A0G8UHc0v+qIJPIQ9/n6efPf
         iewCSIjs66UnweZpc/EznMh9zB+4mPI7OoyNXC/osApBENIUmF4qtOi2XbW2DpSB5wMJ
         zUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2lmji2pJwQUUP3R6t1yXuXRPrPh1yDx0i1mGLg8CxXk=;
        b=uqCBq0acYEx6OL/BGSpN0dHXoyrIl87FMSdd6ImkWYp6w0QuaQDLXyw6a+ByCfuBUd
         0NrO0vN30rbP9pL3UPr9uqFEzgHIfjgzC2zTuXAZD5mobk9xD+QfeV8gWluxKKHUc3yv
         UDXCuuE7J25FxTQHATzevnaBH8qkfb/xoYxXlpps3OlxK2J/JTATHUpqTBT0QC+ct8Y9
         pA7qtDSVoFtKX+O7cHem+6iXckGnWpjv3UWaRNMLEaKKBegNsN89YALVVjpbl2jKvZ5i
         /eVl8Ls6MKd3SOQ9xvLQYZX4oyM52hNLwHrVFG8nJW5apZ6E4sUqpN48N8uCOlLAj9X2
         16fA==
X-Gm-Message-State: AJIora+zxp6IlvKGdq22uXoavHI2PbNaTb3zSvnS/qCydGdsvSkWFFkJ
        esSpvYKW6PgMxHFplFsR3BDpYYVbvaXgaRm3Dad2
X-Google-Smtp-Source: AGRyM1uCcb2pDVTpDDsVUiZd0J0+WEjtbbgh4jqcG3bGfivbKRKkUwVy3Wnb/o8tyjKhhIKWZ30sg4m4oT0+s0fm0h3m
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:a065:9221:e40d:4fbe])
 (user=axelrasmussen job=sendgmr) by 2002:a25:7c41:0:b0:670:7de8:1d4b with
 SMTP id x62-20020a257c41000000b006707de81d4bmr5955132ybc.488.1658260595015;
 Tue, 19 Jul 2022 12:56:35 -0700 (PDT)
Date:   Tue, 19 Jul 2022 12:56:24 -0700
In-Reply-To: <20220719195628.3415852-1-axelrasmussen@google.com>
Message-Id: <20220719195628.3415852-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220719195628.3415852-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 1/5] selftests: vm: add hugetlb_shared userfaultfd test to run_vmtests.sh
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, zhangyi <yi.zhang@huawei.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This not being included was just a simple oversight. There are certain
features (like minor fault support) which are only enabled on shared
mappings, so without including hugetlb_shared we actually lose a
significant amount of test coverage.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index 41fce8bea929..e70ae0f3aaf6 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -121,9 +121,11 @@ run_test ./gup_test -a
 run_test ./gup_test -ct -F 0x1 0 19 0x1000
 
 run_test ./userfaultfd anon 20 16
-# Test requires source and destination huge pages.  Size of source
-# (half_ufd_size_MB) is passed as argument to test.
+# Hugetlb tests require source and destination huge pages. Pass in half the
+# size ($half_ufd_size_MB), which is used for *each*.
 run_test ./userfaultfd hugetlb "$half_ufd_size_MB" 32
+run_test ./userfaultfd hugetlb_shared "$half_ufd_size_MB" 32 "$mnt"/uffd-test
+rm -f "$mnt"/uffd-test
 run_test ./userfaultfd shmem 20 16
 
 #cleanup
-- 
2.37.0.170.g444d1eabd0-goog

