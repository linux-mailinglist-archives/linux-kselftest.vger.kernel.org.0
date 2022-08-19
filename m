Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD41759A764
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 23:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352000AbiHSUwp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 16:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352119AbiHSUw3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 16:52:29 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791CD10EEE2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 13:52:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3359a55dcb6so95108257b3.21
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 13:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=cU7/6qINBgFAfTXfLa178LOY1yjmrSCVESmZNe7FU4M=;
        b=bC4lMI8huw1uRRzwGbHtFYE2tB88na003CekKY0ACebDw98OX4FLPryvf3oIjLvbpT
         2Z94mnqJPrWYcjP3lmF0GohedIfZnStwZI38zjxUUxQx48j9wG65sUDiEbDITVLYRKcL
         mVtlRswKM70g0APD+T61jU6cKtU63dY0BC21ebFhGj0hneMmEysLC4lYHb5oDAVNIzpp
         mb1WTwMI3YxYE/fxX+RjWDwy8EJG82QrF3wHtWjI0Yh4kNcN3PEFdFExtn3hpGXpQYOj
         rmZcPvO+scdHRyaPD9DDquqWTzT/hefOPdLuGFDA0SzUJxmBxqB86WHfSQvwRiAOGOM6
         arxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=cU7/6qINBgFAfTXfLa178LOY1yjmrSCVESmZNe7FU4M=;
        b=fEw1vH5pCPmXrq1226DF8Oz2AhtNOEdGOws/VB4aUUGN8xB7d+jeEi5JAQeOI0pEYr
         hWh+nnWFffEFct7TZ0DGBqJzurxxzG8ewKeVApj+GcFNbiiUOdbxI36/RhsF6jq+bMcr
         v7d4c5r51z/qyomajloBEea4uRA6UFO5Z6QzCShNRblDNp3m2zK2kSkqVV5trOf3YV5k
         Ve5Qvbmeti5gBkvWn1AyBe9J3TtrwD5uoBymqjKXSJM96ZY9qRoBQ2YsHI5jsxBEMbMB
         kMLB2jkZjUVVlTgdHsw6PNr+nJJqgx5gZumpQfz3E3XSBt8G82TZ1hqh+uHT1HNBd3F3
         6Y1w==
X-Gm-Message-State: ACgBeo3UpErjyQIrH/hkOAEGJKSrz1iR77VC0lQuJqh4riZnUElurnnC
        WvzofmwADkTeOmPo+BFLkSXfC3tLuY+1koUen13j
X-Google-Smtp-Source: AA6agR597bmial/03bil7OFmDdc43FwP1zL4eJRRyQeIFMDrkuV6ElwIhtWPrgaR/KqOaLYWWlpmihWtAUKx254JQc//
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:baf:4c5:18b:2c4b])
 (user=axelrasmussen job=sendgmr) by 2002:a25:dcd4:0:b0:690:6ce9:7bb5 with
 SMTP id y203-20020a25dcd4000000b006906ce97bb5mr9476909ybe.516.1660942332708;
 Fri, 19 Aug 2022 13:52:12 -0700 (PDT)
Date:   Fri, 19 Aug 2022 13:51:57 -0700
In-Reply-To: <20220819205201.658693-1-axelrasmussen@google.com>
Message-Id: <20220819205201.658693-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220819205201.658693-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v7 1/5] selftests: vm: add hugetlb_shared userfaultfd test to run_vmtests.sh
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
2.37.1.595.g718a3a8f04-goog

