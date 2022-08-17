Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68795597927
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 23:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242421AbiHQVsR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 17:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242349AbiHQVrx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 17:47:53 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58023AB4E6
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Aug 2022 14:47:45 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 92-20020a17090a09e500b001d917022847so5888136pjo.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Aug 2022 14:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=jnCzi2soCjCrdoYyE26okeRANWMjNTuMb/vBG8/63Ug=;
        b=KZ0P1170IwcAUTv8uQbp9z7pte5r8kbVvoL+qqtlH3QccUqJDgZWrT/GJqfAKRnvAK
         CzZLov1dutB82SgbWPPzafLbe4YaRt7nlqDWzpwzjvXJ1vIbUcBzRXJWjlaGaSLqYEns
         FoLMoKN+UHsLMa1XItGd8jNF2ArKMQZhcmw+3Q+Hjpr0JdoQ0gVe+/+Ls57ppTFJ3zEk
         9ReRy0BgHOs/xGg2zwKIF/plGC6NvWST4LGC8hdXiPFxmbd0zWTPsdGp73UpgXt7/Jo5
         Y7sx0Ehv6+9al+cCFThmxBBXb5blmspH061tjTD7GYZLCKIaVqXu2A93PxXnKLVAnpIi
         hnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=jnCzi2soCjCrdoYyE26okeRANWMjNTuMb/vBG8/63Ug=;
        b=W4erWJ5bhiJD534WCx9HpFbOti22xTH2diVOE+/xcqZS9hGGHDP2IYHn76Z5+fCDmv
         f/1HyGCNe8jZ0QKkCY7ZEGs0px7GRODktO2uNYU7t88wA0NMGGvZGhbE1vIT8hfWQO/o
         ZSyqUwI1o2cgZHc5GmAnlvziH8wR/0mJ5O30yTIrdWg0WOIrFiC8cc/MuPkoFIrpyr1a
         7uDVoLzgvEcLmX8r0l6kvljnX4GeymAmDqO0ClStTnkVbr0cmMensVmjbPh0e5ce6O6e
         /qu+FjLtOUItI9zKJtXBlHgwu7pokmh2sZ+H0Z3HoJ+cxk3yg7JZN63c0V6Rk6ZjSjNz
         76qQ==
X-Gm-Message-State: ACgBeo1t2uCfMnLsWw00bpn02rUm0eKOKIH0DQcWm7PTHyLDA8ln8l51
        IDIWXtkEtaE2h44kEpMO6063O6cUMbA0Aqi47A18
X-Google-Smtp-Source: AA6agR5jERdtN3diOuEm1pmrj1QHlYiMHvWG8qI727CmuqPey4kLQo+pfMvxcFs9I8HGucRMJxmUfmrjgGwpfsKtL631
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:2f41:f176:4bac:b729])
 (user=axelrasmussen job=sendgmr) by 2002:a17:90b:1b48:b0:1f4:f4e5:c189 with
 SMTP id nv8-20020a17090b1b4800b001f4f4e5c189mr5408096pjb.226.1660772864770;
 Wed, 17 Aug 2022 14:47:44 -0700 (PDT)
Date:   Wed, 17 Aug 2022 14:47:28 -0700
In-Reply-To: <20220817214728.489904-1-axelrasmussen@google.com>
Message-Id: <20220817214728.489904-6-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220817214728.489904-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v6 5/5] selftests: vm: add /dev/userfaultfd test cases to run_vmtests.sh
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This new mode was recently added to the userfaultfd selftest. We want to
exercise both userfaultfd(2) as well as /dev/userfaultfd, so add both
test cases to the script.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index b8e7f6f38d64..e780e76c26b8 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -120,13 +120,16 @@ run_test ./gup_test -a
 # Dump pages 0, 19, and 4096, using pin_user_pages:
 run_test ./gup_test -ct -F 0x1 0 19 0x1000
 
-run_test ./userfaultfd anon 20 16
-# Hugetlb tests require source and destination huge pages. Pass in half the
-# size ($half_ufd_size_MB), which is used for *each*.
-run_test ./userfaultfd hugetlb "$half_ufd_size_MB" 32
-run_test ./userfaultfd hugetlb_shared "$half_ufd_size_MB" 32 "$mnt"/uffd-test
-rm -f "$mnt"/uffd-test
-run_test ./userfaultfd shmem 20 16
+uffd_mods=("" ":dev")
+for mod in "${uffd_mods[@]}"; do
+	run_test ./userfaultfd anon${mod} 20 16
+	# Hugetlb tests require source and destination huge pages. Pass in half
+	# the size ($half_ufd_size_MB), which is used for *each*.
+	run_test ./userfaultfd hugetlb${mod} "$half_ufd_size_MB" 32
+	run_test ./userfaultfd hugetlb_shared${mod} "$half_ufd_size_MB" 32 "$mnt"/uffd-test
+	rm -f "$mnt"/uffd-test
+	run_test ./userfaultfd shmem${mod} 20 16
+done
 
 #cleanup
 umount "$mnt"
-- 
2.37.1.595.g718a3a8f04-goog

