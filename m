Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BDE7676DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 22:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjG1USa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 16:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjG1US3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 16:18:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993C82D75;
        Fri, 28 Jul 2023 13:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37AA8621F3;
        Fri, 28 Jul 2023 20:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B70C433C8;
        Fri, 28 Jul 2023 20:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690575507;
        bh=T0fZGypLM6vPpWaOxwTR4DXjjDDCiOe0tcjb/Q7FYeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RX260k1ogVJVTYldpyL2MGeGBk3tczpbf55SpjRAVjT3q1MLI8Xd9HW7ZUgZsmtHH
         Cj0LUABIEdtOyJhlJgJA5+ddILF/b7B0oCVXSNLQfQOMSZv8Vl+GTamyICVRsZYGRx
         qNI7iYll5IOZ7YKkhn0Fjp4aa9TYYyUMcQtFPkI93XQ4g1zKrupkRLVpcsVtOj8Bpi
         7RgCEgKylHCjNMsAzUG3/JKObwfK68tEDIhlTB9zKKvqQYw4733MSpaHK1VOChBCtL
         w3r+CWSFwF/pvgYfNgmZh8Gd6cK6AkaI+6/VilRbS8fXBk8oV/m0Wk2SwDhShqnRa5
         tuBgaodKk3dtw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/5] selftests/damon/sysfs: test tried_regions/total_bytes file
Date:   Fri, 28 Jul 2023 20:18:15 +0000
Message-Id: <20230728201817.70602-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728201817.70602-1-sj@kernel.org>
References: <20230728201817.70602-1-sj@kernel.org>
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

