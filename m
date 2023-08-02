Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D3976D9D1
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 23:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjHBVnZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 17:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjHBVnY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 17:43:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530CFE7D;
        Wed,  2 Aug 2023 14:43:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3320061B3B;
        Wed,  2 Aug 2023 21:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C740C433CB;
        Wed,  2 Aug 2023 21:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691012602;
        bh=MiKQzUem1fzoQJpnZETahxS4bhAx7AKf5JO3KUUBnl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KNpNnySGcLwwD9KynrkvcNXQaBRN2V1X98Grk3mr3pGzY865PxRj0dR3+DzNO+I8w
         hHZqYL0RWX3o6cMHKlY52OMbqe/PwKTQf9K1he85PgX4Ig5eyxoKnhKINzRLDWc2qL
         c8AI/p7rQnIUnRc0f3gWXf8qhLlPWJgZWRQFlDUpg8b4HwYKp/bXNLjWHBMHceg1HF
         eQwQPwGIOaDkkp4rfC4gyN4uKtsW0FW1oIMg/ImKkJNj9cNfIImyaYUs2S3ofFaBqm
         wcAefhDChku+yGHFBeObxNq15C5S2UX6piTUqZRuEoBQWjgEL2GG8msiTo028SJJuP
         epEhbvqJedrjQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] selftests/damon/sysfs: test damon_target filter
Date:   Wed,  2 Aug 2023 21:43:09 +0000
Message-Id: <20230802214312.110532-11-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802214312.110532-1-sj@kernel.org>
References: <20230802214312.110532-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test existence of files and validity of input keyword for DAMON
monitoring target based DAMOS filter on DAMON sysfs interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 5677cfd342fc..60a9a305aef0 100644
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -104,11 +104,13 @@ test_filter()
 	ensure_write_succ "$filter_dir/type" "anon" "valid input"
 	ensure_write_succ "$filter_dir/type" "memcg" "valid input"
 	ensure_write_succ "$filter_dir/type" "addr" "valid input"
+	ensure_write_succ "$filter_dir/type" "target" "valid input"
 	ensure_write_fail "$filter_dir/type" "foo" "invalid input"
 	ensure_file "$filter_dir/matching" "exist" "600"
 	ensure_file "$filter_dir/memcg_path" "exist" "600"
 	ensure_file "$filter_dir/addr_start" "exist" "600"
 	ensure_file "$filter_dir/addr_end" "exist" "600"
+	ensure_file "$filter_dir/damon_target_idx" "exist" "600"
 }
 
 test_filters()
-- 
2.25.1

