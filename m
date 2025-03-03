Return-Path: <linux-kselftest+bounces-28044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9575BA4C0DD
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 13:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C357C3AB5EA
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037062147FD;
	Mon,  3 Mar 2025 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoxMQhRI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7CD210F71
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005868; cv=none; b=caIQrAVcbwk6joQX5J+L2JGs3176pgAxjObYl8bzatqDxGLeXcvY5OfeSFx13W9Gb0xKkom2HVT4vYA9DxQqDDTe+BvbeVs1KJT0Y+BqiTzFUzoYWmAXfFaXsUKfMIAzEtv9QpknYdkZn4eUbMJaxQKpz1oL0khksiIwYWhY72k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005868; c=relaxed/simple;
	bh=0C4JkgXQtgeQhzwqubMe5Df6hevktRFvQ5zMLbbFak4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mG7C08zhpd/u5oZIFn3cEN7oD5fJWsMVDueP6aZerhpxg9K4aMSQ2FK6p3rs5Ecc/0/fG5zPPKv+ORVvgxYwSxRb2zKwVXoqe1U0NneDAql94kjs051sCUyk+pkpFDYv6MmdIQy8reKlTPdva5K+NntYbCCWM1P5sN8IHdquhFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YoxMQhRI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741005866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9d+oOheGf64mOyEFfcHgMgXsNl0DuQhJwDS4FGt+uBk=;
	b=YoxMQhRIKqXd97r1b15/O7Oxm6eLMzDvzdS8DKA0h499ImLBLk1WS3NWfxX2f2xmy4h1gL
	ddRGSwK4Wnaqk+Jv01GJ6QFGKpCZw2nFuT0SGlx0guqpAobgZPz5myG9b1l8s6nBoK3SlR
	mQnyB1iv9lRQq6bGdJL4lWUvtlcI0DY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-fL6fEFKPMf6neXXldNwNMw-1; Mon,
 03 Mar 2025 07:44:13 -0500
X-MC-Unique: fL6fEFKPMf6neXXldNwNMw-1
X-Mimecast-MFC-AGG-ID: fL6fEFKPMf6neXXldNwNMw_1741005852
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EBD71800877;
	Mon,  3 Mar 2025 12:44:12 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 112691800359;
	Mon,  3 Mar 2025 12:44:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 07/11] selftests: ublk: move zero copy feature check into _add_ublk_dev()
Date: Mon,  3 Mar 2025 20:43:17 +0800
Message-ID: <20250303124324.3563605-8-ming.lei@redhat.com>
In-Reply-To: <20250303124324.3563605-1-ming.lei@redhat.com>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Move zero copy feature check into _add_ublk_dev() since we will have
more tests which requires to cover zero copy.

Then one check function of _check_add_dev() has to be added for dealing
with cleanup since '_add_ublk_dev()' is run in sub-shell, and we can't
exit from it to terminal shell.

Meantime always return error code from _add_ublk_dev().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh  | 56 ++++++++++++++++----
 tools/testing/selftests/ublk/test_loop_01.sh |  1 +
 tools/testing/selftests/ublk/test_loop_02.sh |  2 +-
 tools/testing/selftests/ublk/test_loop_03.sh |  4 +-
 tools/testing/selftests/ublk/test_loop_04.sh |  2 +-
 tools/testing/selftests/ublk/test_null_01.sh |  1 +
 6 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index d70690281d14..40bf42f1bed2 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+UBLK_SKIP_CODE=4
+
 _create_backfile() {
 	local my_size=$1
 	local my_file
@@ -79,12 +81,37 @@ _prep_test() {
 	echo "ublk $type: $*"
 }
 
+_remove_test_files()
+{
+	local files=$*
+
+	for file in ${files}; do
+		[ -f "${file}" ] && rm -f "${file}"
+	done
+}
+
 _show_result()
 {
-	if [ "$2" -ne 0 ]; then
-		echo "$1 : [FAIL]"
-	else
+	if [ "$2" -eq 0 ]; then
 		echo "$1 : [PASS]"
+	elif [ "$2" -eq 4 ]; then
+		echo "$1 : [SKIP]"
+	else
+		echo "$1 : [FAIL]"
+	fi
+	[ "$2" -ne 0 ] && exit "$2"
+	return 0
+}
+
+# don't call from sub-shell, otherwise can't exit
+_check_add_dev()
+{
+	local tid=$1
+	local code=$2
+	shift 2
+	if [ "${code}" -ne 0 ]; then
+		_remove_test_files "$@"
+		_show_result "${tid}" "${code}"
 	fi
 }
 
@@ -92,13 +119,28 @@ _cleanup_test() {
 	"${UBLK_PROG}" del -a
 }
 
+_have_feature()
+{
+	if  $UBLK_PROG "features" | grep "$1" > /dev/null 2>&1; then
+		return 0
+	fi
+	return 1
+}
+
 _add_ublk_dev() {
 	local kublk_temp;
 	local dev_id;
 
+	if echo "$@" | grep -q "\-z"; then
+		if ! _have_feature "ZERO_COPY"; then
+			return ${UBLK_SKIP_CODE}
+		fi
+	fi
+
 	kublk_temp=$(mktemp /tmp/kublk-XXXXXX)
 	if ! "${UBLK_PROG}" add "$@" > "${kublk_temp}" 2>&1; then
 		echo "fail to add ublk dev $*"
+		rm -f "${kublk_temp}"
 		return 255
 	fi
 
@@ -108,13 +150,5 @@ _add_ublk_dev() {
 	echo "${dev_id}"
 }
 
-_have_feature()
-{
-	if  "$UBLK_PROG" "features" | grep "$1" > /dev/null 2>&1; then
-		return 0
-	fi
-	return 1
-}
-
 UBLK_PROG=$(pwd)/kublk
 export UBLK_PROG
diff --git a/tools/testing/selftests/ublk/test_loop_01.sh b/tools/testing/selftests/ublk/test_loop_01.sh
index 48a85796ca43..12bba9e5daa5 100755
--- a/tools/testing/selftests/ublk/test_loop_01.sh
+++ b/tools/testing/selftests/ublk/test_loop_01.sh
@@ -11,6 +11,7 @@ _prep_test "loop" "write and verify test"
 backfile_0=$(_create_backfile 256M)
 
 dev_id=$(_add_ublk_dev -t loop "$backfile_0")
+_check_add_dev $TID $? "${backfile_0}"
 
 # run fio over the ublk disk
 fio --name=write_and_verify \
diff --git a/tools/testing/selftests/ublk/test_loop_02.sh b/tools/testing/selftests/ublk/test_loop_02.sh
index 0a4b5fadbc73..9a163296ac83 100755
--- a/tools/testing/selftests/ublk/test_loop_02.sh
+++ b/tools/testing/selftests/ublk/test_loop_02.sh
@@ -9,8 +9,8 @@ ERR_CODE=0
 _prep_test "loop" "mkfs & mount & umount"
 
 backfile_0=$(_create_backfile 256M)
-
 dev_id=$(_add_ublk_dev -t loop "$backfile_0")
+_check_add_dev $TID $? "$backfile_0"
 
 _mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
diff --git a/tools/testing/selftests/ublk/test_loop_03.sh b/tools/testing/selftests/ublk/test_loop_03.sh
index 5a11356e502c..72a1d072cfbd 100755
--- a/tools/testing/selftests/ublk/test_loop_03.sh
+++ b/tools/testing/selftests/ublk/test_loop_03.sh
@@ -6,13 +6,11 @@
 TID="loop_03"
 ERR_CODE=0
 
-_have_feature "ZERO_COPY" || exit 4
-
 _prep_test "loop" "write and verify over zero copy"
 
 backfile_0=$(_create_backfile 256M)
-
 dev_id=$(_add_ublk_dev -t loop -z "$backfile_0")
+_check_add_dev $TID $? "$backfile_0"
 
 # run fio over the ublk disk
 fio --name=write_and_verify \
diff --git a/tools/testing/selftests/ublk/test_loop_04.sh b/tools/testing/selftests/ublk/test_loop_04.sh
index 7e0d4dd8127e..676c4652d758 100755
--- a/tools/testing/selftests/ublk/test_loop_04.sh
+++ b/tools/testing/selftests/ublk/test_loop_04.sh
@@ -9,8 +9,8 @@ ERR_CODE=0
 _prep_test "loop" "mkfs & mount & umount with zero copy"
 
 backfile_0=$(_create_backfile 256M)
-
 dev_id=$(_add_ublk_dev -t loop -z "$backfile_0")
+_check_add_dev $TID $? "$backfile_0"
 
 _mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
diff --git a/tools/testing/selftests/ublk/test_null_01.sh b/tools/testing/selftests/ublk/test_null_01.sh
index af11e73b7df6..e2847a50823a 100755
--- a/tools/testing/selftests/ublk/test_null_01.sh
+++ b/tools/testing/selftests/ublk/test_null_01.sh
@@ -9,6 +9,7 @@ ERR_CODE=0
 _prep_test "null" "basic IO test"
 
 dev_id=$(_add_ublk_dev -t null)
+_check_add_dev $TID $?
 
 # run fio over the two disks
 fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
-- 
2.47.0


