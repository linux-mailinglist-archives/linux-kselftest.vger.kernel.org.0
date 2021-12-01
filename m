Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F424650D4
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 16:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350349AbhLAPIb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 10:08:31 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52764 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350364AbhLAPIa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 10:08:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D9DCACE1DBB;
        Wed,  1 Dec 2021 15:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAF0C53FCD;
        Wed,  1 Dec 2021 15:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638371106;
        bh=0vdcMyUQGuwcxJbQPs8RdnvesQ4Ampc8D6OYRBEjNxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l9McXxE2OjcxknwERNHehKK7ECaWNllnE7932jLxeibsb31zhE65+Tl9aj+OXo+bv
         WPw3jvfYhvR9YFcE5dPmI773d7/FUihCflK2pBmVDyGXlksIqH0nuxUxMK2FPOf44W
         i35T0zWst3ZdBJh8sp18kjmPwt58qaw6pEBN/7+S80qNcS4ReKCM+rjQi6TRag08d7
         /VR74cDuiM4JNkCaTGCrufgd3poEaboNw3bVNsBrhdJMYoIOVb7x//kwM+BbSQ/JAB
         z1nWF9xI6P4gYRNFHhTRAvYTxNFchr+2O9zyflzUltgwsRdIbQHqOCjoO+M1Acudnf
         WoOSX5zPF6olg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, brendanhiggins@google.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 09/11] selftests/damon: Test wrong DAMOS condition ranges input
Date:   Wed,  1 Dec 2021 15:04:38 +0000
Message-Id: <20211201150440.1088-10-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201150440.1088-1-sj@kernel.org>
References: <20211201150440.1088-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A patch titled "mm/damon/schemes: add the validity judgment of
thresholds"[1] makes DAMON debugfs interface to validate DAMON scheme
inputs.  This commit adds a test case for the validation logic in DAMON
selftests.

[1] https://lore.kernel.org/linux-mm/d78360e52158d786fcbf20bc62c96785742e76d3.1637239568.git.xhao@linux.alibaba.com/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/debugfs_attrs.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
index d0916373f310..1ef118617167 100644
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -77,6 +77,8 @@ test_write_succ "$file" "1 2 3 4 5 6 4 0 0 0 1 2 3 1 100 3 2 1" \
 test_write_fail "$file" "1 2
 3 4 5 6 3 0 0 0 1 2 3 1 100 3 2 1" "$orig_content" "multi lines"
 test_write_succ "$file" "" "$orig_content" "disabling"
+test_write_fail "$file" "2 1 2 1 10 1 3 10 1 1 1 1 1 1 1 1 2 3" \
+	"$orig_content" "wrong condition ranges"
 echo "$orig_content" > "$file"
 
 # Test target_ids file
-- 
2.17.1

