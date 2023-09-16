Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2847A2D51
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Sep 2023 04:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbjIPCKO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 22:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbjIPCKN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 22:10:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EDD173C;
        Fri, 15 Sep 2023 19:10:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3E2C433C9;
        Sat, 16 Sep 2023 02:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694830207;
        bh=I2fvF7L5MWw0Xd6X92VF2iHBCnxT4grJu/1S+mVZwhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SKhM4RCiPW/WTsWk5JRgIEMREqf3W6POSXpmuWjX+pNtpbUKhf9uSSUSCfWwTyVmt
         O0IjP4qBbo7CWUTv7afVCGvVFZEuytTab+a9LlQKW78/utBW81O3uDztR6cOx5ev64
         pIX82Gd/olQdHoBt8QLIc80rPpTTZd16EGrkeI9BkD0T3iFbc0tiYmCH/AFuqA2fFY
         j4s2acBog/OIGBGeyBvNG+xzEImkvBvcF83HnXH9ajYft0z5YG6VdlyQ3G190oTika
         y4PWdtiibt/78XrDsqhUy3bsC2YFWGbyhY1zo9tv79mChFaA9yJPIfOFqFoQTp8xQD
         H4lwh2LfGuiTQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] selftests/damon/sysfs: test DAMOS apply intervals
Date:   Sat, 16 Sep 2023 02:09:43 +0000
Message-Id: <20230916020945.47296-8-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230916020945.47296-1-sj@kernel.org>
References: <20230916020945.47296-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update DAMON selftests to test existence of the file for reading/writing
DAMOS apply interval under each scheme directory.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 60a9a305aef0..56f0230a8b92 100644
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -175,6 +175,7 @@ test_scheme()
 	ensure_dir "$scheme_dir" "exist"
 	ensure_file "$scheme_dir/action" "exist" "600"
 	test_access_pattern "$scheme_dir/access_pattern"
+	ensure_file "$scheme_dir/apply_interval_us" "exist" "600"
 	test_quotas "$scheme_dir/quotas"
 	test_watermarks "$scheme_dir/watermarks"
 	test_filters "$scheme_dir/filters"
-- 
2.25.1

