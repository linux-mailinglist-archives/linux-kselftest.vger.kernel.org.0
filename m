Return-Path: <linux-kselftest+bounces-28046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E427FA4C0E4
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 13:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4654A1896FF3
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 12:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482282116E1;
	Mon,  3 Mar 2025 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EI0HdMya"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FF210F71
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005889; cv=none; b=XsLhWWufjKyOtYJ5vmt/nC2XOcxHLZhyQmAF1sumpeXgCgF8HpSX+b6BlyWax9XYrVk2hs3BLZrKZSOYq/jf9myZQrsuvlOwohmMHkSbf99vrDx5JU+OZZmwe83fzlfIdWBDrneopHV0SWjLNMep9KcX+lCzpWMUsCO/w5OrRh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005889; c=relaxed/simple;
	bh=FGAah+nZFfve3WCpEi0Ybu1HjWrSfpCAz+yiiAE7w9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAmJM8gifNzPhFu82ZpW5/ASUlZn8nR76z0YPfTmC8BogGlQ1YYC3831nm5RZVsWjchV4TJIbIqj+2X5tGoWWdj1rKqh/LujITlG6wYzqzU9G7S6n/m6a4yapzDZweHU+YEXo9cc5LHMukcgswbIUWKzxIB52PnSxXgJX2qn8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EI0HdMya; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741005886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Quo9GFqH1Xb63xK1C4YcntZoNhBsXEt5C3tvQgLnKJE=;
	b=EI0HdMya3S81BCLSlia7bnaOtmVpOZgmH3R3QMub8ZegEG/dSV3LQp4972hh3koCSPoo2O
	1kpgGtEbZn8PuhJu/qm5XHCvuM8cvM7OPQvO7DGQIKRQljPlPdpkH+odmaO932y42qS5kg
	HE+7JYYTL/kPJR66kCaDL/O1NOi/Nr0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-YU6gR_67OaKZj4tz8IcTrg-1; Mon,
 03 Mar 2025 07:44:33 -0500
X-MC-Unique: YU6gR_67OaKZj4tz8IcTrg-1
X-Mimecast-MFC-AGG-ID: YU6gR_67OaKZj4tz8IcTrg_1741005872
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E2CD19540EE;
	Mon,  3 Mar 2025 12:44:32 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67B66300019F;
	Mon,  3 Mar 2025 12:44:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 11/11] selftests: ublk: improve test usability
Date: Mon,  3 Mar 2025 20:43:21 +0800
Message-ID: <20250303124324.3563605-12-ming.lei@redhat.com>
In-Reply-To: <20250303124324.3563605-1-ming.lei@redhat.com>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add UBLK_TEST_QUIET, so we can print test result(PASS/SKIP/FAIL) only.

Also always run from test script's current directory, then the same test
script can be started from other work directory.

This way helps a lot to reuse this test source code and scripts for
other projects(liburing, blktests, ...)

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh    | 10 ++++++++--
 tools/testing/selftests/ublk/test_loop_01.sh   |  2 +-
 tools/testing/selftests/ublk/test_loop_02.sh   |  2 +-
 tools/testing/selftests/ublk/test_loop_03.sh   |  2 +-
 tools/testing/selftests/ublk/test_loop_04.sh   |  2 +-
 tools/testing/selftests/ublk/test_null_01.sh   |  2 +-
 tools/testing/selftests/ublk/test_stress_01.sh |  4 ++--
 tools/testing/selftests/ublk/test_stress_02.sh |  4 ++--
 8 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 92596d0d0013..350380facd9f 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -80,7 +80,7 @@ _prep_test() {
 	local type=$1
 	shift 1
 	modprobe ublk_drv
-	echo "ublk $type: $*"
+	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
 }
 
 _remove_test_files()
@@ -209,6 +209,12 @@ __run_io_and_remove()
 	wait
 }
 
+_ublk_test_top_dir()
+{
+	cd "$(dirname "$0")" && pwd
+}
 
-UBLK_PROG=$(pwd)/kublk
+UBLK_PROG=$(_ublk_test_top_dir)/kublk
+UBLK_TEST_QUIET=1
 export UBLK_PROG
+export UBLK_TEST_QUIET
diff --git a/tools/testing/selftests/ublk/test_loop_01.sh b/tools/testing/selftests/ublk/test_loop_01.sh
index 12bba9e5daa5..c882d2a08e13 100755
--- a/tools/testing/selftests/ublk/test_loop_01.sh
+++ b/tools/testing/selftests/ublk/test_loop_01.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-. test_common.sh
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
 TID="loop_01"
 ERR_CODE=0
diff --git a/tools/testing/selftests/ublk/test_loop_02.sh b/tools/testing/selftests/ublk/test_loop_02.sh
index 9a163296ac83..03863d825e07 100755
--- a/tools/testing/selftests/ublk/test_loop_02.sh
+++ b/tools/testing/selftests/ublk/test_loop_02.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-. test_common.sh
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
 TID="loop_02"
 ERR_CODE=0
diff --git a/tools/testing/selftests/ublk/test_loop_03.sh b/tools/testing/selftests/ublk/test_loop_03.sh
index 72a1d072cfbd..269c96787d7d 100755
--- a/tools/testing/selftests/ublk/test_loop_03.sh
+++ b/tools/testing/selftests/ublk/test_loop_03.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-. test_common.sh
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
 TID="loop_03"
 ERR_CODE=0
diff --git a/tools/testing/selftests/ublk/test_loop_04.sh b/tools/testing/selftests/ublk/test_loop_04.sh
index 676c4652d758..1435422c38ec 100755
--- a/tools/testing/selftests/ublk/test_loop_04.sh
+++ b/tools/testing/selftests/ublk/test_loop_04.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-. test_common.sh
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
 TID="loop_04"
 ERR_CODE=0
diff --git a/tools/testing/selftests/ublk/test_null_01.sh b/tools/testing/selftests/ublk/test_null_01.sh
index e2847a50823a..a34203f72668 100755
--- a/tools/testing/selftests/ublk/test_null_01.sh
+++ b/tools/testing/selftests/ublk/test_null_01.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-. test_common.sh
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
 TID="null_01"
 ERR_CODE=0
diff --git a/tools/testing/selftests/ublk/test_stress_01.sh b/tools/testing/selftests/ublk/test_stress_01.sh
index c1cdde3e79f7..7177f6c57bc5 100755
--- a/tools/testing/selftests/ublk/test_stress_01.sh
+++ b/tools/testing/selftests/ublk/test_stress_01.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-. test_common.sh
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 TID="stress_01"
 ERR_CODE=0
 DEV_ID=-1
@@ -17,7 +17,7 @@ ublk_io_and_remove()
 	DEV_ID=$(_add_ublk_dev "$@")
 	_check_add_dev $TID $? "${backfile}"
 
-	echo "run ublk IO vs. remove device(ublk add $*)"
+	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "run ublk IO vs. remove device(ublk add $*)"
 	if ! __run_io_and_remove "${DEV_ID}" "${size}" "no"; then
 		echo "/dev/ublkc${DEV_ID} isn't removed"
 		_remove_backfile "${backfile}"
diff --git a/tools/testing/selftests/ublk/test_stress_02.sh b/tools/testing/selftests/ublk/test_stress_02.sh
index ec758f649a97..2a8e60579a06 100755
--- a/tools/testing/selftests/ublk/test_stress_02.sh
+++ b/tools/testing/selftests/ublk/test_stress_02.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-. test_common.sh
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 TID="stress_02"
 ERR_CODE=0
 DEV_ID=-1
@@ -17,7 +17,7 @@ ublk_io_and_kill_daemon()
 	DEV_ID=$(_add_ublk_dev "$@")
 	_check_add_dev $TID $? "${backfile}"
 
-	echo "run ublk IO vs kill ublk server(ublk add $*)"
+	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "run ublk IO vs kill ublk server(ublk add $*)"
 	if ! __run_io_and_remove "${DEV_ID}" "${size}" "yes"; then
 		echo "/dev/ublkc${DEV_ID} isn't removed res ${res}"
 		_remove_backfile "${backfile}"
-- 
2.47.0


