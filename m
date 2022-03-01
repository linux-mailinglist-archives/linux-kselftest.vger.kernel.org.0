Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4AA4C9686
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Mar 2022 21:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbiCAUYx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Mar 2022 15:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239257AbiCAUYh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Mar 2022 15:24:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC56F427F1;
        Tue,  1 Mar 2022 12:22:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8848360AE2;
        Tue,  1 Mar 2022 20:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62451C340EE;
        Tue,  1 Mar 2022 20:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646166166;
        bh=ykPzFqII9JhxFvpT1iK7FFBwhs+Pt/E9JaOCth/cxsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hDKQUifiMXi1lBSXdMYyl2xM6gMpWd24Ii0/Zpa2d95G7tg3MEEq4xRvrV9auSUx4
         FY3q7IUJAskD80qL4yZkwmTClwusTXHbx6esL/8PBm8NlOniWV7JuVca+LFBGnh7oU
         4trwIFRVcM7qiI96DfvRVpANC786qzgMkhREVl8gfLd6xdnjHjmy8RpzobQUfTkV1x
         pKc9gw1hSHYDFvqpAOhM6ix3TqmMVWfCfmF6V0Gs6xt6TyZSrhNfe7RQ6g/VVrzN0G
         h8ccAUHZv9yiIJJvzntQtti0R7sRp8Grfp+x62WUt2j2HL1+rVR4lzuleYRLjEOZKa
         NKmhy8tNCQSqg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, gthelen@google.com,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 6/6] selftests/memfd: clean up mapping in mfd_fail_write
Date:   Tue,  1 Mar 2022 15:22:10 -0500
Message-Id: <20220301202212.19419-6-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220301202212.19419-1-sashal@kernel.org>
References: <20220301202212.19419-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mike Kravetz <mike.kravetz@oracle.com>

[ Upstream commit fda153c89af344d21df281009a9d046cf587ea0f ]

Running the memfd script ./run_hugetlbfs_test.sh will often end in error
as follows:

    memfd-hugetlb: CREATE
    memfd-hugetlb: BASIC
    memfd-hugetlb: SEAL-WRITE
    memfd-hugetlb: SEAL-FUTURE-WRITE
    memfd-hugetlb: SEAL-SHRINK
    fallocate(ALLOC) failed: No space left on device
    ./run_hugetlbfs_test.sh: line 60: 166855 Aborted                 (core dumped) ./memfd_test hugetlbfs
    opening: ./mnt/memfd
    fuse: DONE

If no hugetlb pages have been preallocated, run_hugetlbfs_test.sh will
allocate 'just enough' pages to run the test.  In the SEAL-FUTURE-WRITE
test the mfd_fail_write routine maps the file, but does not unmap.  As a
result, two hugetlb pages remain reserved for the mapping.  When the
fallocate call in the SEAL-SHRINK test attempts allocate all hugetlb
pages, it is short by the two reserved pages.

Fix by making sure to unmap in mfd_fail_write.

Link: https://lkml.kernel.org/r/20220219004340.56478-1-mike.kravetz@oracle.com
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 26546892cd545..faab09215c88b 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -373,6 +373,7 @@ static void mfd_fail_write(int fd)
 			printf("mmap()+mprotect() didn't fail as expected\n");
 			abort();
 		}
+		munmap(p, mfd_def_size);
 	}
 
 	/* verify PUNCH_HOLE fails */
-- 
2.34.1

