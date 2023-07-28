Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE58A76770F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 22:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbjG1UfW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 16:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbjG1UfE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 16:35:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E3C449E;
        Fri, 28 Jul 2023 13:34:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9F6362203;
        Fri, 28 Jul 2023 20:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C1FC433C7;
        Fri, 28 Jul 2023 20:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690576495;
        bh=MiKQzUem1fzoQJpnZETahxS4bhAx7AKf5JO3KUUBnl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EECfAg33GG9SqqlWc+wrfsEImXkF6d6ycMp0inrJhToqWOJS5w+mziQY6qM1+VzOW
         yJAIbvcLzdspQMARFZjzy3AmCo6BqmfM3NWAvL0pkpWx7Yt6sRBXwoVkE5fusXqmub
         w5oLIoINT3xsuDNIolN8nJBcIRzbtGocgGMwepvXDhuG2FYfsA9T8hDMGzLkIvm22b
         FoyimEg865ElGcknEIKuhd5UsKo6vGoFtEtm1IFw/No6ZJIxShh4HmDL7Oe645TXVZ
         Lrkivg25m27CUtgTcmVblB1UPsAmTCbpO+ItKQ5IVNkZpQ7/X7HRuBHnbgzbf/ZajY
         NNTeUXrLf0J4w==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 10/13] selftests/damon/sysfs: test damon_target filter
Date:   Fri, 28 Jul 2023 20:34:41 +0000
Message-Id: <20230728203444.70703-11-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728203444.70703-1-sj@kernel.org>
References: <20230728203444.70703-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

