Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0C1664BE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 20:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbjAJTEl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 14:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbjAJTEO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 14:04:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AAAC2C;
        Tue, 10 Jan 2023 11:04:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B4C0BCE18D7;
        Tue, 10 Jan 2023 19:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBFCC433F0;
        Tue, 10 Jan 2023 19:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673377449;
        bh=CjhxKTgVu+lPp4HMYYUYnXVejaSmINVAMJdDe1Xu9yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9iw2rZ6IgCzqVQBdYfz7/bh7pKhBy1FK+wxTqUl4jmsut3RCJjFMQ1iXDcc3yG3g
         ubQRNrcDKuML+gAAHhG/o2oIDoU0TNhHHsHQytYLNAHxwWHfHNvbtBi9ytfESI4MnH
         jphspOWxy3DGuZw7GJ9uRW1Vge4F5VWvuzH2dw3zS4uPT/Qm6JaveOZol+/Qmximra
         z0bItMD2PlFtwfc92SGvmZTfoLuPUjMbiUV5pdVgi64g2QU+GBFxkDLhZH8tCZZn/u
         55l2ZlUFIEAZtEMyfMhDiv4kJAus9+cQjzHXnbUXQoiiYsN4VQZjLPdrXhoaGy9nkw
         puw4xPVZ3JB6Q==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] selftests/damon/debugfs_rm_non_contexts: hide expected write error messages
Date:   Tue, 10 Jan 2023 19:04:00 +0000
Message-Id: <20230110190400.119388-9-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110190400.119388-1-sj@kernel.org>
References: <20230110190400.119388-1-sj@kernel.org>
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

A selftest case for DAMON debugfs interface has a test for expected
failure.  To make the test output clean, hide the expected failure error
message.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh b/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
index 48b7af6b022c..f3ffeb1343cf 100644
--- a/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
+++ b/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
@@ -10,7 +10,7 @@ dmesg -C
 
 for file in "$DBGFS/"*
 do
-	echo "$(basename "$f")" > "$DBGFS/rm_contexts"
+	(echo "$(basename "$f")" > "$DBGFS/rm_contexts") &> /dev/null
 	if dmesg | grep -q BUG
 	then
 		dmesg
-- 
2.25.1

