Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0857E0774
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 18:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjKCRel (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 13:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbjKCReT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 13:34:19 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0506136
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Nov 2023 10:34:16 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9becde9ea7bso682066466b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Nov 2023 10:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699032855; x=1699637655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOsVzD5dPrBo4Rj12h5O/1Y3xsH9YzmJIcDBJLguEZw=;
        b=At7TUG4GDiBCzDdHUY3TMoJmAVUUyA14S3tpKm+qBs92p7Fp59iG/QFTnpTKUwDeLo
         3I8Y6c2oGug/KbjNXsoq6JoKP8AnJodfuzioUutSU0oZSULntJzxxkSgQQKnmy0EJjV4
         TwgHl4DK5FWOb8BevOzv4R9Uq4JrqBMs7vZXx4ILO8qSchWkDvmsPBGpT46G9fLF3YGm
         DmflNcDOB2MQGcJomYKmXgh942ojsDdIP/zHdCbLy8iWwHNzX5zIPG4lx8mSJLkgXpeg
         MfYKDLH/RwZ1u7ssB+LO3unvfa2rhk7FPIE4BRcCDJ+uGGwHwBnHrtcFAqfDlWCjmsRV
         poXQ==
X-Gm-Message-State: AOJu0YwEl23cqE2yNdqHAEcWvwnv91vWZcQCQQhqqGjA4s8oNEKFU0sF
        vvyvVIjgBzyYbR7ocGYuFXKNLZET1/E=
X-Google-Smtp-Source: AGHT+IHHPkQYqzAEsDCwOratzEap8eorWUATEJ6RjhGLcAazrn0o4umOSPCMJdDGBclfNs4nJoaWaw==
X-Received: by 2002:a17:907:8690:b0:9b2:b15b:383d with SMTP id qa16-20020a170907869000b009b2b15b383dmr3593576ejc.11.1699032854978;
        Fri, 03 Nov 2023 10:34:14 -0700 (PDT)
Received: from localhost (fwdproxy-cln-018.fbsv.net. [2a03:2880:31ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709067c8800b009dbe08bc793sm1137288ejo.18.2023.11.03.10.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 10:34:14 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     ryan.roberts@arm.com, akpm@linux-foundation.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-mm@kvack.org
Subject: [PATCH 1/2] selftests/mm: restore number of hugepages
Date:   Fri,  3 Nov 2023 10:33:59 -0700
Message-Id: <20231103173400.1608403-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test mm `hugetlb_fault_after_madv` selftest needs one and only one
huge page to run, thus it sets `/proc/sys/vm/nr_hugepages` to 1.

The problem is that further tests require the previous number of
hugepages allocated in order to succeed.

Save the number of huge pages before changing it, and restore it once the
test finishes, so, further tests could run successfully.

Fixes: 116d57303a05 ("selftests/mm: add a new test for madv and hugetlb")
Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Closes: https://lore.kernel.org/all/662df57e-47f1-4c15-9b84-f2f2d587fc5c@arm.com/
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/mm/run_vmtests.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index cc16f6ca8533..00757445278e 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -223,9 +223,12 @@ CATEGORY="hugetlb" run_test ./hugepage-mremap
 CATEGORY="hugetlb" run_test ./hugepage-vmemmap
 CATEGORY="hugetlb" run_test ./hugetlb-madvise
 
+nr_hugepages_tmp=$(cat /proc/sys/vm/nr_hugepages)
 # For this test, we need one and just one huge page
 echo 1 > /proc/sys/vm/nr_hugepages
 CATEGORY="hugetlb" run_test ./hugetlb_fault_after_madv
+# Restore the previous number of huge pages, since further tests rely on it
+echo "$nr_hugepages_tmp" > /proc/sys/vm/nr_hugepages
 
 if test_selected "hugetlb"; then
 	echo "NOTE: These hugetlb tests provide minimal coverage.  Use"
-- 
2.34.1

