Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F34A76D990
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 23:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjHBVcc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 17:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjHBVcb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 17:32:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9782819AA;
        Wed,  2 Aug 2023 14:32:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 354D961B54;
        Wed,  2 Aug 2023 21:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C40C433CB;
        Wed,  2 Aug 2023 21:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691011949;
        bh=T0fZGypLM6vPpWaOxwTR4DXjjDDCiOe0tcjb/Q7FYeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B8eKOqA044Ky8Eh09y4gIXYN9t2lUUZCL9kmmIy/8/wVup+Fz9JompcEKnQSE4jKf
         rNdmcJT9xd0IfodlTlcndLvX2Na6sPx1JbT9RuOE/wx2KM4b7YbEGyLkffuSceZ+Bc
         /l2rcKJrVQGxQRjm7e7wQ/sOIx8A2X90cgjvwQ9FEMNRdzU9EZEC7larfDkW0RmVUa
         EFomDu/3WBUrWr6v4wEUKLbqIRHSxfQoDfMG2TqcAFphcofllNeSdaHPsefS/bArI+
         SqYi4oXNcrkHbCEbhjQOaUDlg/0qyd4dBsqQHZEM9pIX8GCakb9VXQJvvEx/nNj81F
         BQ+3vr2RfZiuw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] selftests/damon/sysfs: test tried_regions/total_bytes file
Date:   Wed,  2 Aug 2023 21:32:19 +0000
Message-Id: <20230802213222.109841-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802213222.109841-1-sj@kernel.org>
References: <20230802213222.109841-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update sysfs.sh DAMON selftest for checking existence of 'total_bytes'
file under the 'tried_regions' directory of DAMON sysfs interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index bcd4734ca094..967e27267549 100644
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -84,6 +84,7 @@ test_tried_regions()
 {
 	tried_regions_dir=$1
 	ensure_dir "$tried_regions_dir" "exist"
+	ensure_file "$tried_regions_dir/total_bytes" "exist" "400"
 }
 
 test_stats()
-- 
2.25.1

