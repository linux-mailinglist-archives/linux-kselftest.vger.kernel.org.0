Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDDE63E12A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 21:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiK3UJv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 15:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiK3UJs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 15:09:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3706B9135D;
        Wed, 30 Nov 2022 12:09:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7CF361D9A;
        Wed, 30 Nov 2022 20:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DDBC43144;
        Wed, 30 Nov 2022 20:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669838987;
        bh=qgpIYxCoLxiSbmookPCEJSX95mijzZoDksXEWue5IhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ph1+PQPZYu6to+v4+E7MJsXG71DdCfottZMxf1eZpKiRNy4oCyTaMkgg7vIjsTWfd
         zMoWUqXoDWvNEBc0SXOkA4kCbcz8+t/yk+iMNwmT2Un1nhaDleVV8d+NV40r6ftxFj
         cxwH/mphoi9jaylPCjBmsFX3CMsKSYtVmfsXEzVqvsWNcpVFcrTW+ZEB67mk9YGLv3
         W3mh7bEz/PuxeV5DmQzgOSjK/tDXQOeP7Ga1mIlO5ES80sVZ8vV4i+f8DRDnA3LTnS
         EtP2kTMnYfhQeCLR8axup+u4wdlSNN+bgwsXC3Q71oVMYx0c/72Z8Ngh4GMbBzYA1Y
         JDRI5XE0qxaHQ==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 09/11] selftests/damon/sysfs: test filters directory
Date:   Wed, 30 Nov 2022 20:09:35 +0000
Message-Id: <20221130200937.118005-10-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130200937.118005-1-sj@kernel.org>
References: <20221130200937.118005-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add simple test cases for scheme filters of DAMON sysfs interface.  The
test cases check if the files are populated as expected, receives some
valid inputs, and refuses some invalid inputs.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index db4942383a50..a00336ffdcad 100644
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -96,6 +96,34 @@ test_stats()
 	done
 }
 
+test_filter()
+{
+	filter_dir=$1
+	ensure_file "$filter_dir/type" "exist" "600"
+	ensure_write_succ "$filter_dir/type" "anon" "valid input"
+	ensure_write_succ "$filter_dir/type" "memcg" "valid input"
+	ensure_write_fail "$filter_dir/type" "foo" "invalid input"
+	ensure_file "$filter_dir/matching" "exist" "600"
+	ensure_file "$filter_dir/memcg_path" "exist" "600"
+}
+
+test_filters()
+{
+	filters_dir=$1
+	ensure_dir "$filters_dir" "exist"
+	ensure_file "$filters_dir/nr_filters" "exist" "600"
+	ensure_write_succ  "$filters_dir/nr_filters" "1" "valid input"
+	test_filter "$filters_dir/0"
+
+	ensure_write_succ  "$filters_dir/nr_filters" "2" "valid input"
+	test_filter "$filters_dir/0"
+	test_filter "$filters_dir/1"
+
+	ensure_write_succ "$filters_dir/nr_filters" "0" "valid input"
+	ensure_dir "$filters_dir/0" "not_exist"
+	ensure_dir "$filters_dir/1" "not_exist"
+}
+
 test_watermarks()
 {
 	watermarks_dir=$1
@@ -143,6 +171,7 @@ test_scheme()
 	test_access_pattern "$scheme_dir/access_pattern"
 	test_quotas "$scheme_dir/quotas"
 	test_watermarks "$scheme_dir/watermarks"
+	test_filters "$scheme_dir/filters"
 	test_stats "$scheme_dir/stats"
 	test_tried_regions "$scheme_dir/tried_regions"
 }
-- 
2.25.1

