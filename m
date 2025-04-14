Return-Path: <linux-kselftest+bounces-30715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7796BA8836E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4679F5806A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F95165EFC;
	Mon, 14 Apr 2025 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiYb3rS7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748DE2C10B3;
	Mon, 14 Apr 2025 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637408; cv=none; b=rf+f6GmcvWvPSKdX/P5f05VjCu9yPLFo8vzw6BsxguvFsZnGDzQQWjqVpIsufINr2ZhpTKIvOtik+rpKpA1lXWk2vHedU4kmYkSYuXXdd0UUzUgOejte/tVYBkuG3+vo2D/JyVmJ4yDOGzhY8HU1Z27aPpufycigO0FFqG70BrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637408; c=relaxed/simple;
	bh=Skw2haJGpIZiFYqO2n3E1IxwuSukQmD1H2oxwPBWPho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tMg9zUKR5gKGbKyMrsIFy3xZT6yIegv+L6tqNb8k9maVtPPO8lVWSbD4GhH0bICF7EChsp1SXAHdtGO64xVIhzu2/KtucmDcVj/9MLy1t13VeV0MZbm/KjCTx5+QFyiDzdTkufgzcdYCiNVXVq/QlLxO2U/fO5vX1ICiNXd6Y80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiYb3rS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84D3C4CEE2;
	Mon, 14 Apr 2025 13:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637408;
	bh=Skw2haJGpIZiFYqO2n3E1IxwuSukQmD1H2oxwPBWPho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fiYb3rS7Y8c39sJhThdbb+mDbU2iehDjMzYY6drcv7hojTlEfBqnXT2xE582jGZPy
	 JIg3dzBn7hhcECaKHl9wqpmLSbx0uMEtNybQVVUpGmaC+wUZK0OqpZF4PrIwYYtlOg
	 w601WCxfPo0TahHISBcADVz1JfxdkCjFFsZarg4Ror+Vc2u8LAmVU+ZUQhZyF/V6q4
	 4b8aehDF13qTHG+nXglcvsR9GiAzaFbe2uffCXNFyPakP0/z0QDmPg1sFwnRZWldiC
	 bVhM1f4eAaqDdBICM1AFqBpwxIjXQmvioFrtEMVybi/EJbOEe3eJIuYSJChum8FIWm
	 rN4jFz0V3zdfQ==
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
Subject: [PATCH AUTOSEL 6.6 04/24] selftests: ublk: fix test_stripe_04
Date: Mon, 14 Apr 2025 09:29:37 -0400
Message-Id: <20250414132957.680250-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132957.680250-1-sashal@kernel.org>
References: <20250414132957.680250-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
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


