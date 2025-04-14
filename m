Return-Path: <linux-kselftest+bounces-30719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8D3A883BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 16:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99821696AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 14:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FA12DA8EA;
	Mon, 14 Apr 2025 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4tW+CUj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD42DA8E4;
	Mon, 14 Apr 2025 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637494; cv=none; b=M2qsUyy2zym5w/rLzA311kP01BUInogrXoAcbB1hud9+FCBpooX/AcEagyEbv7SM9ve6wKZ+Ns7u8eQbE9puO2Sr7rN8Pl1j8+QnhrAa1lwAh5fwN4ivBA3v9ymznzB997AXYD6xEosLK5FErQvmhX9haRZRvbRTKh+crnzYjhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637494; c=relaxed/simple;
	bh=Skw2haJGpIZiFYqO2n3E1IxwuSukQmD1H2oxwPBWPho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gozjBvdAGPG3X0fC8d7KIUUeqBlKHsPGAqAI/0zsO8bFGaRbUGGqrjiSS64Z6mmnAhatyVRodvfwLoNQYllfJmM0t4aa4yAz8ClfiYPPaPoYW4Ax4Oy6B8RlIx8NvXIDtrvxf0hPI96WUOKqmjpYVLhsSjslmAt2d+DFFxPmc6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4tW+CUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D86C4CEE2;
	Mon, 14 Apr 2025 13:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637494;
	bh=Skw2haJGpIZiFYqO2n3E1IxwuSukQmD1H2oxwPBWPho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b4tW+CUjN73BLx3DcBPJbKCL/Frqvwp+T4QPhn2jyWd9mhP+GJvHRrFU5dkddDopd
	 WZ67wxd2erptktlk+DZ0M/LCI4BQmJK4gkbif8OcAVUo1CHFCkkLJv9l6O3LcSq+7r
	 y9Co9d6qTlet87Qs5ADbXaYnN/gfHX5FTtlqD03tPv2uVqNzYFaBpTeQtGv1Hp9BOy
	 XCI9O/WrTPUJR0YajbeuN47nvOv6H9ziXNmR0+abOO43zMg3j40aJ0kpbkIjxwTumZ
	 WX9bSid4ELlDjVzfHVHEawmj7DoQruKWS1EQk1qETChYSWx916LNtuwlHQqOZYWm9c
	 r8J+hfpEoGIYw==
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
Subject: [PATCH AUTOSEL 5.15 03/15] selftests: ublk: fix test_stripe_04
Date: Mon, 14 Apr 2025 09:31:13 -0400
Message-Id: <20250414133126.680846-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133126.680846-1-sashal@kernel.org>
References: <20250414133126.680846-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.180
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


