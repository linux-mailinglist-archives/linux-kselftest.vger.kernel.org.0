Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DA061549D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 23:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiKAWDk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 18:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiKAWDj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 18:03:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BDE617A;
        Tue,  1 Nov 2022 15:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8241161733;
        Tue,  1 Nov 2022 22:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7192BC433B5;
        Tue,  1 Nov 2022 22:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667340216;
        bh=vHgDcIM2X6HC9Xa44Y3Kmnj3zbAk0A48a3qye0uZNww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BB9iuPFmaCYxUJ2icGWtplwAv9fDjQQP8tssoMnF+QYSch4jkG2Gs9jcRHdDg0eLl
         UN8aSiWrnsriBYDwmlGxbAstIhanC5uEyC9Jlpqz+62z/zkh9J/rPvtRkVkQri7HTz
         vkQAMOPJG2EgQrODDLra5lazx51qMuIpWcddNcp2JSkKyg7YxGFaX6ZC+fU5aX61rP
         h6OeWNswACf+ieCA59Ivg5Jl6tF9P/qMwigIaQUxIlmwgrN5LNFsHwmCU8PibAHpaI
         lDTn7q6EgOXaDMN+LyyE4By4/ykc4vfJZ1mMCKzxY5Pf/etnSIXTU2t3JeollfAF/d
         JkLl+MMlB1/Mg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 6/8] tools/selftets/damon/sysfs: test tried_regions directory existence
Date:   Tue,  1 Nov 2022 22:03:26 +0000
Message-Id: <20221101220328.95765-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101220328.95765-1-sj@kernel.org>
References: <20221101220328.95765-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a simple test case for ensuring tried_regions directory existence.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 89592c64462f..db4942383a50 100644
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -80,6 +80,12 @@ test_range()
 	ensure_file "$range_dir/max" "exist" 600
 }
 
+test_tried_regions()
+{
+	tried_regions_dir=$1
+	ensure_dir "$tried_regions_dir" "exist"
+}
+
 test_stats()
 {
 	stats_dir=$1
@@ -138,6 +144,7 @@ test_scheme()
 	test_quotas "$scheme_dir/quotas"
 	test_watermarks "$scheme_dir/watermarks"
 	test_stats "$scheme_dir/stats"
+	test_tried_regions "$scheme_dir/tried_regions"
 }
 
 test_schemes()
-- 
2.25.1

