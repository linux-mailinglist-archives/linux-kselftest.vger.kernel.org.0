Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B5E4650D2
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 16:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350351AbhLAPIa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 10:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350345AbhLAPI2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 10:08:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DDFC061748;
        Wed,  1 Dec 2021 07:05:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5E804CE1F8B;
        Wed,  1 Dec 2021 15:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D460C53FCC;
        Wed,  1 Dec 2021 15:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638371104;
        bh=YjXMqJsAM3rfUd7mH+zkWhp7VeCDe+o7nOiWHutAaY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RiNuqg7NkzJI7j6wUZfGzHMLxdJiRLVTfD6TuCgWXcYT+Yhz2ZmTchyuPuVwBIn0L
         ymL7lMQhBx93dJPVyzKOkO2rwIstfeXp3MFozilY1Ukex5IlXRoO05OLJKAXtFvSQ4
         o+4FuxIiq3BZHsrk5q/LsC3qEFUIoI5p3ahoJ5PXGk2lRu/517QNSoSlPbTWcCXmym
         MG4FWogp/dJCpTzjymUs6ky/a0VJv/zPqJMb/8zogRzcB4UAkVvbSo98CcdSA5eXjo
         e2p/SqHr9xaHmEVOv1njjrlMj2dayI5XH/1aIpVytl5CgWHAhLgoR1NFkcUPRnBBO6
         Zkq6/fj+AN7fg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, brendanhiggins@google.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 07/11] selftests/damon: Skip test if DAMON is running
Date:   Wed,  1 Dec 2021 15:04:36 +0000
Message-Id: <20211201150440.1088-8-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201150440.1088-1-sj@kernel.org>
References: <20211201150440.1088-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Testing the DAMON debugfs files while DAMON is running makes no sense,
as any write to the debugfs files will fails.  This commit makes the
test be skipped in the case.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/debugfs_attrs.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
index 196b6640bf37..fc80380c59f0 100644
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -44,6 +44,15 @@ test_content() {
 
 source ./_chk_dependency.sh
 
+ksft_skip=4
+
+damon_onoff="$DBGFS/monitor_on"
+if [ $(cat "$damon_onoff") = "on" ]
+then
+	echo "monitoring is on"
+	exit $ksft_skip
+fi
+
 # Test attrs file
 # ===============
 
-- 
2.17.1

