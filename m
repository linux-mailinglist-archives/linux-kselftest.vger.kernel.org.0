Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C55A58CD1B
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Aug 2022 19:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244055AbiHHR41 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Aug 2022 13:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244006AbiHHR4Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Aug 2022 13:56:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E851262F8
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Aug 2022 10:56:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-329a474c437so32738107b3.18
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Aug 2022 10:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=Jwq0jXWhpPKY4rjZycF0kBtXykpSsmq4jMCb4fxEPCM=;
        b=Yyk9ueBMp+D30ALuCCr4oQg4v0Phj71m9ZUNFotBmxh5WUoEer1fIKUM0YNI8t36m/
         LAKC/p9D6Ibbok4i3QPJuOcLeLuIZtfZz5hWpJ2SamU/0IqIgKUcq5tdx+B0lyBwjzWU
         6rlAg4BqXREsBkDISimbX7tf6KbTpVyl8Sp7EURabchFN3gbwsiNGVRrvf2Dz2vV+YiO
         3CyjWXzxMSiuTFLOXfXCyEX3jlVt/8lgkhEOc6o2d2ADrfwgq5hAGBW01/v+pi4V5E9Q
         Y0xIlwhyNQFlXTgiXIJE1rXkVz/ykc6WHPLIvdfzBC4Sd+2KaItcnCFA+eFXdTaHMTth
         ajfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Jwq0jXWhpPKY4rjZycF0kBtXykpSsmq4jMCb4fxEPCM=;
        b=UhNi+vZhWEPWY4cbFsBEM01oJSIMii1+vl8w27FCjp5abLB3vD91dWRVCz3ataHP+y
         q1ZsZjUL4RDpVIZvTieMFFWc8y2NjAA2ybfKjiB0BDWB1N3q67kPFCMdkh5AlkxjT5L+
         y+BYSMUE/bmUVSbJnWWvyP/aPWIRHzoJl83ay35rpoqrVA2tKsFb8YfwzVLPCr6THTJf
         CQF+wJeeLpyFOui8T4kyu2/MEogigBszRnapda3PAdceDMzNRD/XQu1DJDYgul2ohS2V
         iGbZ3QfhHy5n12Fc+HpZZEySbtGPrAtXzTvd2ln37s8JjhkdONzhAfNPURbtj5WEe+9y
         MyZg==
X-Gm-Message-State: ACgBeo0lZCFgBvOQsTz0N/ImyVcl9muCTrmCH2pALid76+/tOI5eDfOv
        VCOllAz+ZeuOXp+WswqLKfH8xV4cS90ornLtOqVs
X-Google-Smtp-Source: AA6agR43R4xY0r1/MvCjyc43MmcPqeFzuRXsCNk0/nJZn8G74hDr1u1wkNE8kXISlycKU+NX0kObB9Nbsmb3XfCgX24r
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:7a2a:3bb5:f3a0:3bbc])
 (user=axelrasmussen job=sendgmr) by 2002:a25:41cb:0:b0:671:80ac:bb4c with
 SMTP id o194-20020a2541cb000000b0067180acbb4cmr16114083yba.24.1659981383209;
 Mon, 08 Aug 2022 10:56:23 -0700 (PDT)
Date:   Mon,  8 Aug 2022 10:56:10 -0700
In-Reply-To: <20220808175614.3885028-1-axelrasmussen@google.com>
Message-Id: <20220808175614.3885028-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220808175614.3885028-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v5 1/5] selftests: vm: add hugetlb_shared userfaultfd test to run_vmtests.sh
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index de86983b8a0f..b8e7f6f38d64 100755
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
2.37.1.559.g78731f0fdb-goog

