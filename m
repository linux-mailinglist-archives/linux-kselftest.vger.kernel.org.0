Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3966A53AF65
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jun 2022 00:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiFAVK2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Jun 2022 17:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiFAVJ7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Jun 2022 17:09:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEF1396B8
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Jun 2022 14:09:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 84-20020a250557000000b0065bb92955a2so2468225ybf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Jun 2022 14:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kk1kl2p/g3Lg3sGUGGyiVv3dYTdsKPpPMBPxg1a8NQs=;
        b=fCqYWeX5V2UAR6CwDd1WwVkx3nRbWoxq+i5xyuQYRpLuf0Idp6IKcChFZX/d1mGPZa
         wZJhNzo1ICxiw03yrG17zNvxeU/gt4XldskATEVn3qYus+EBAdrY62rsfcD40sYP7ZrX
         igXgB45R6xlblsq1J3+7HLWq0D7FHjeEccdGgPATYEG27fmiy5xS6olETvuNNrcqmkET
         CeeuEs1LWViL+Kl2RWA6FUcmNKliAcGPMy3chE3EZPK2ANXrTqk3lk3J9/9XTb5021lB
         diS31DsFxp7coKuQWeAxr68utYOwsJ9ksZ4/IluHlLeghUUS59fRs6MgqNyQ+1D8i2L/
         j7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kk1kl2p/g3Lg3sGUGGyiVv3dYTdsKPpPMBPxg1a8NQs=;
        b=PzEx4Vh22f5GyD3kAHF9QEJNOuHEngoY0pYF9qbcnTTN6TtclJfVLmXQuegsS3M25R
         xKugbWPncdceLgMc06iowEd7erZ5pOMwgmSz2JUbThXd2XUuUw0sEjNatgsu0X3XGVS5
         OWJfjCXFlitozDvqEzbNRtw2cKOOr7T2pszDc80edL+AxbzDrat8X7JCeHihku8NKzKC
         w0jPW8P1x8g9mInXILAzCHLbuJLJR1YgsGoYD1JiT4vVoobNSrgrofHq6lqSyj8dKGPt
         Crt/P601udXq7Tv3t7iECFhM55yGv3bm8WaCLKsR2pFGAmb0GSXAtTacc36EsLoIlyVB
         BOWg==
X-Gm-Message-State: AOAM532es6N7fhsZrpgHs0j24/l5iarQKASxqnhxGqw3V79FaPjGE40Q
        cjmvuD9V2hQGCCWt7B/DfHb02Ptq9OTMXlcOdhJ/
X-Google-Smtp-Source: ABdhPJy7KiJc6d2+d7s0OkiwmpYfryNL4lT4rDOmPy5rS9SoXCCHdlUkPE20eNU2mwq5x8ofn4egdPxMllMcAtmZ8mur
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:aaec:e358:9f0e:2b26])
 (user=axelrasmussen job=sendgmr) by 2002:a81:47d4:0:b0:2ff:c3d1:c158 with
 SMTP id u203-20020a8147d4000000b002ffc3d1c158mr1702500ywa.388.1654117797191;
 Wed, 01 Jun 2022 14:09:57 -0700 (PDT)
Date:   Wed,  1 Jun 2022 14:09:46 -0700
In-Reply-To: <20220601210951.3916598-1-axelrasmussen@google.com>
Message-Id: <20220601210951.3916598-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220601210951.3916598-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v3 1/6] selftests: vm: add hugetlb_shared userfaultfd test to run_vmtests.sh
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
index 54a0c28f810c..7e102246dd9f 100755
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
2.36.1.255.ge46751e96f-goog

