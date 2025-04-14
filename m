Return-Path: <linux-kselftest+bounces-30721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEEDA883FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 16:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA44E1889422
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 14:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4072D92C7;
	Mon, 14 Apr 2025 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uehAm+C9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE092D92C0;
	Mon, 14 Apr 2025 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637527; cv=none; b=VFdszU1oI6Qh67nfU/UF4iZJGurJeiswccqjdmnun+QPqYeJBWtE/pIE0Fyyjs9eyR/ERX/XmlHvNv4+BB1fvnxsv9gTI18K+ClrdzX5obKPnB3rqHJIoT05RJ9xrk+kmIvEqyXH+hkDarg8MWNYBVbFPNHee0wV3uESYdL4svs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637527; c=relaxed/simple;
	bh=Skw2haJGpIZiFYqO2n3E1IxwuSukQmD1H2oxwPBWPho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NedKwVdeCjsc5789Wg8ya2500pCUPLOqfpg97/9Itek5g8DYG43By93VpQTimTIz7yBNnaH2oa4ShhMcKAp5+RN/pFwik9DodHAfoQWoXm+8xwTSY+hE3t6XUG7CvRD9ObGxWLyneKsO6t9IgdwbZ1uIRubEHFs1iGuobYC5fHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uehAm+C9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72E0C4CEE9;
	Mon, 14 Apr 2025 13:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637527;
	bh=Skw2haJGpIZiFYqO2n3E1IxwuSukQmD1H2oxwPBWPho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uehAm+C9muqZzmLNm4BcCBJtzPp94UrcLcoomAOjZL2W37ITBKb2yGfnfotZ2bPMM
	 6D3Qo3DORP4g2LE0tJQIOMwB/dCKGvl5tt2fJc6HCfh2XlBqsxWO9kstX6UilHVpge
	 VYupTp/eRCWAB5QRJyiq9SWMH0r4vUNP3sZ2kMGYQkFnqd+qJX/zwKzI0ZhOZ6s4fF
	 kFg6xyqMMFlT0h385wo7D86o4jM+tH3K1BaVoQQ5bPsB5o9NbEX56v0p8yrf6zdycL
	 a6qjU1LqP8xkxCtegWCfjwaEfgUQ1aF0Wdr1AvmWoKWUhQgx/hjs/ebZtXcbAEZyDa
	 9+ycKwXoVwwrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 03/11] selftests: ublk: fix test_stripe_04
Date: Mon, 14 Apr 2025 09:31:50 -0400
Message-Id: <20250414133158.681045-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133158.681045-1-sashal@kernel.org>
References: <20250414133158.681045-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.236
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 72070e57b0a518ec8e562a2b68fdfc796ef5c040 ]

Commit 57ed58c13256 ("selftests: ublk: enable zero copy for stripe target")
added test entry of test_stripe_04, but forgot to add the test script.

So fix the test by adding the script file.

Reported-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Uday Shankar <ushankar@purestorage.com>
Link: https://lore.kernel.org/r/20250404001849.1443064-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/ublk/test_stripe_04.sh  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_stripe_04.sh

diff --git a/tools/testing/selftests/ublk/test_stripe_04.sh b/tools/testing/selftests/ublk/test_stripe_04.sh
new file mode 100755
index 0000000000000..1f2b642381d17
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stripe_04.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="stripe_04"
+ERR_CODE=0
+
+_prep_test "stripe" "mkfs & mount & umount on zero copy"
+
+backfile_0=$(_create_backfile 256M)
+backfile_1=$(_create_backfile 256M)
+dev_id=$(_add_ublk_dev -t stripe -z -q 2 "$backfile_0" "$backfile_1")
+_check_add_dev $TID $? "$backfile_0" "$backfile_1"
+
+_mkfs_mount_test /dev/ublkb"${dev_id}"
+ERR_CODE=$?
+
+_cleanup_test "stripe"
+
+_remove_backfile "$backfile_0"
+_remove_backfile "$backfile_1"
+
+_show_result $TID $ERR_CODE
-- 
2.39.5


