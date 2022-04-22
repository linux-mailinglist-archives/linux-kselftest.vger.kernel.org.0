Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB3C50C2AC
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Apr 2022 01:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiDVWib (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Apr 2022 18:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiDVWha (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Apr 2022 18:37:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E509C1F6265
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Apr 2022 14:29:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso8206050ybs.20
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Apr 2022 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/z1dLT2VgPLiDImKUFQxfJeCLXLbaB4rbFSQTc8Z7xg=;
        b=T7Y5iN0BPf96fnzNK7ZHU6vX0fBe/A3dst2c12cELyfKQ79U/HOQor03zypmVLp1If
         uI8UFZO5MKdK3bq3HmTy6OycGmGbCr8KvVuboRoot8Dmc47nfO5+vN9qfcW9MqGlSZ7l
         PRJ2hmyct17qJuveqLhAfzJw5ps3ymAMGZ1k31aYcUwdb+GtUMEGkKPlOcqofEoBIlHp
         pwIx3/Q96ETwqhck8u3dbsamL8jS0omSGAoJtcg/cJqrzRfcOKdB4BklXofPQ4mG7YPR
         o6lZ1l3IUTdb5dxqkIIoZHbZ7xu4gYhZCpWvRRUJynxmAwAapUiyc6b3GBWS6hzsOm6Y
         30ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/z1dLT2VgPLiDImKUFQxfJeCLXLbaB4rbFSQTc8Z7xg=;
        b=0CkUSKEEi4ePZk8l0V0sS/4YyJi3Ae8VMAU/MgFli1qNGA2IAQaRgyrORLnp54fE8E
         bZCtl6WSqlOrt2Cq9DwN2qbAbHfY00ls19gug1DJe79BMbcUQ0mnvgr0tcL/+19Ett/F
         hkCGoeXrgYlF2uDHX//XfVbFWyCE1AXc6cAAYWawzWhH9ILrG3vzaaDPmEgB2RUK795E
         inLUDyDdteW/Isv0V3bI0cOCeHNp2A0wAqKuObSQsvvP2g81nJbzzQUrB+CHUfRVfOo9
         F1VWVAUvqlZePjrZqvecaTtt5KzKB0zjXrPl14kgZjt/5YsjMuv/GrmRrrorJuXF+1IQ
         Z8Yw==
X-Gm-Message-State: AOAM5331LOIsk9cvFAj4AJzcri2rOJdA01397U4zTklWaxHSA1xusbEs
        /pQUgfc9kjh9vlb3c8+J+GoICrWe97560L5A5zI6
X-Google-Smtp-Source: ABdhPJxdF3c0ToaXlnNGfx2U55uFir0mnBR1xoNncmXKoo64JVGSzaYeOVGtOAX0slR2R1/1i4hxxc2yi3eMNWQBn9Hr
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:7ba6:20ac:a8f7:1dbd])
 (user=axelrasmussen job=sendgmr) by 2002:a25:cad8:0:b0:645:7633:d179 with
 SMTP id a207-20020a25cad8000000b006457633d179mr6471821ybg.304.1650662993181;
 Fri, 22 Apr 2022 14:29:53 -0700 (PDT)
Date:   Fri, 22 Apr 2022 14:29:40 -0700
In-Reply-To: <20220422212945.2227722-1-axelrasmussen@google.com>
Message-Id: <20220422212945.2227722-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220422212945.2227722-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v2 1/6] selftests: vm: add hugetlb_shared userfaultfd test to run_vmtests.sh
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
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index a2302b5faaf2..5065dbd89bdb 100755
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
2.36.0.rc2.479.g8af0fa9b8e-goog

