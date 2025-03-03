Return-Path: <linux-kselftest+bounces-28040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1350CA4C0A0
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 13:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87775172340
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 12:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB17D20F095;
	Mon,  3 Mar 2025 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/zFxdsk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD5D21127E
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005847; cv=none; b=da77qbja6erCqK/YjXPa12wN+Y7q12k6TfQcWPhCGfpIIIKv6LT2y4xBLdimQOFRDgEMP4GI40ME5dNRrKZJ7kc0O/rW07D9hkZB8QAGQ2LP2dQ0oQJpMGiMMq1es5QRL2lICmA0/qS2ltx5VqZEHT+YqEEFypXfYTeA/9XPkD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005847; c=relaxed/simple;
	bh=+L7g5LVGLGO8UFwoz4/X5nTzXoTux7jDxGJmh4Nm13c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNcCilLZxQ+vaFXle9gXpcybXfeig20BMtINiW80LmhdSX/sjil+vQ/WsghjHbtAIcYdmOKEFOklL8FgFbUBPJpx7lE354Gd6reDmp1s7raRxRs0wGWqwFy8DUuNylaC4PEXpqixmSV5kPAXlxB0rB95Y9nu6UbKEdXm5hy/pCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/zFxdsk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741005845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OnHBK1HYK0ZFpwRyuFhNqPfICJsUezdxJ+0g7/+cX+w=;
	b=h/zFxdsk36LcoyRVa1y0ndzl9ED+iHdU3WZv7DnvdM2TojLIYN0mGsXNrFVmc0tjb6NulD
	sYfcjDoC1rFnrdevZrzL5ndgZeDInsuxp/c1DxxqEGRj4TTqpym5M2xjC0WWUAGviha9ou
	jnP8Ijc/ILmx7x8g4hLizmgHlMpQVF4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-GYSUIPjRNS2QIqcklsuBuw-1; Mon,
 03 Mar 2025 07:44:03 -0500
X-MC-Unique: GYSUIPjRNS2QIqcklsuBuw-1
X-Mimecast-MFC-AGG-ID: GYSUIPjRNS2QIqcklsuBuw_1741005842
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B59081954204;
	Mon,  3 Mar 2025 12:44:02 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BAD9D180087D;
	Mon,  3 Mar 2025 12:44:00 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 05/11] selftests: ublk: support shellcheck and fix all warning
Date: Mon,  3 Mar 2025 20:43:15 +0800
Message-ID: <20250303124324.3563605-6-ming.lei@redhat.com>
In-Reply-To: <20250303124324.3563605-1-ming.lei@redhat.com>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add shellcheck, meantime fixes all warnings.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile        |  3 ++
 tools/testing/selftests/ublk/test_common.sh  | 57 +++++++++++---------
 tools/testing/selftests/ublk/test_loop_01.sh | 10 ++--
 tools/testing/selftests/ublk/test_loop_02.sh | 10 ++--
 tools/testing/selftests/ublk/test_loop_03.sh | 10 ++--
 tools/testing/selftests/ublk/test_loop_04.sh | 10 ++--
 tools/testing/selftests/ublk/test_null_01.sh |  6 +--
 7 files changed, 58 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 555a3ba5b481..9415f6f6df48 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -14,3 +14,6 @@ TEST_GEN_PROGS_EXTENDED = kublk
 include ../lib.mk
 
 $(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c
+
+check:
+	shellcheck -x -f gcc *.sh
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 304f22ffda58..61044cb58138 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -3,46 +3,49 @@
 
 _create_backfile() {
 	local my_size=$1
-	local my_file=`mktemp ublk_bpf_${my_size}_XXXXX`
+	local my_file
 
-	truncate -s ${my_size} ${my_file}
-	echo $my_file
+	my_file=$(mktemp ublk_file_"${my_size}"_XXXXX)
+	truncate -s "${my_size}" "${my_file}"
+	echo "$my_file"
 }
 
 _remove_backfile() {
 	local file=$1
 
-	[ -f "$file" ] && rm -f $file
+	[ -f "$file" ] && rm -f "$file"
 }
 
 _create_tmp_dir() {
-	local my_file=`mktemp -d ublk_bpf_dir_XXXXX`
+	local my_file;
 
-	echo $my_file
+	my_file=$(mktemp -d ublk_dir_XXXXX)
+	echo "$my_file"
 }
 
 _remove_tmp_dir() {
 	local dir=$1
 
-	[ -d "$dir" ] && rmdir $dir
+	[ -d "$dir" ] && rmdir "$dir"
 }
 
 _mkfs_mount_test()
 {
 	local dev=$1
 	local err_code=0
-	local mnt_dir=`_create_tmp_dir`
+	local mnt_dir;
 
-	mkfs.ext4 -F $dev > /dev/null 2>&1
+	mnt_dir=$(_create_tmp_dir)
+	mkfs.ext4 -F "$dev" > /dev/null 2>&1
 	err_code=$?
 	if [ $err_code -ne 0 ]; then
 		return $err_code
 	fi
 
-	mount -t ext4 $dev $mnt_dir > /dev/null 2>&1
-	umount $dev
+	mount -t ext4 "$dev" "$mnt_dir" > /dev/null 2>&1
+	umount "$dev"
 	err_code=$?
-	_remove_tmp_dir $mnt_dir
+	_remove_tmp_dir "$mnt_dir"
 	if [ $err_code -ne 0 ]; then
 		return $err_code
 	fi
@@ -73,12 +76,12 @@ _prep_test() {
 	_check_root
 	local type=$1
 	shift 1
-	echo "ublk $type: $@"
+	echo "ublk $type: $*"
 }
 
 _show_result()
 {
-	if [ $2 -ne 0 ]; then
+	if [ "$2" -ne 0 ]; then
 		echo "$1 : [FAIL]"
 	else
 		echo "$1 : [PASS]"
@@ -86,28 +89,32 @@ _show_result()
 }
 
 _cleanup_test() {
-	${UBLK_PROG} del -n $1
+	"${UBLK_PROG}" del -n "$1"
 }
 
 _add_ublk_dev() {
-	local kublk_temp=`mktemp /tmp/kublk-XXXXXX`
-	${UBLK_PROG} add $@ > ${kublk_temp} 2>&1
-	if [ $? -ne 0 ]; then
-		echo "fail to add ublk dev $@"
-		exit -1
+	local kublk_temp;
+	local dev_id;
+
+	kublk_temp=$(mktemp /tmp/kublk-XXXXXX)
+	if ! "${UBLK_PROG}" add "$@" > "${kublk_temp}" 2>&1; then
+		echo "fail to add ublk dev $*"
+		return 255
 	fi
-	local dev_id=`grep "dev id" ${kublk_temp} | awk -F '[ :]' '{print $3}'`
+
+	dev_id=$(grep "dev id" "${kublk_temp}" | awk -F '[ :]' '{print $3}')
 	udevadm settle
-	rm -f ${kublk_temp}
-	echo ${dev_id}
+	rm -f "${kublk_temp}"
+	echo "${dev_id}"
 }
 
 _have_feature()
 {
-	if  $UBLK_PROG "features" | grep $1 > /dev/null 2>&1; then
+	if  "$UBLK_PROG" "features" | grep "$1" > /dev/null 2>&1; then
 		return 0
 	fi
 	return 1
 }
 
-export UBLK_PROG=$(pwd)/kublk
+UBLK_PROG=$(pwd)/kublk
+export UBLK_PROG
diff --git a/tools/testing/selftests/ublk/test_loop_01.sh b/tools/testing/selftests/ublk/test_loop_01.sh
index 829e8df05942..1d3f934dca4c 100755
--- a/tools/testing/selftests/ublk/test_loop_01.sh
+++ b/tools/testing/selftests/ublk/test_loop_01.sh
@@ -8,13 +8,13 @@ ERR_CODE=0
 
 _prep_test "loop" "write and verify test"
 
-backfile_0=`_create_backfile 256M`
+backfile_0=$(_create_backfile 256M)
 
-dev_id=`_add_ublk_dev -t loop $backfile_0`
+dev_id=$(_add_ublk_dev -t loop "$backfile_0")
 
 # run fio over the ublk disk
 fio --name=write_and_verify \
-    --filename=/dev/ublkb${dev_id} \
+    --filename=/dev/ublkb"${dev_id}" \
     --ioengine=libaio --iodepth=16 \
     --rw=write \
     --size=256M \
@@ -24,8 +24,8 @@ fio --name=write_and_verify \
     --bs=4k > /dev/null 2>&1
 ERR_CODE=$?
 
-_cleanup_test ${dev_id} "loop"
+_cleanup_test "${dev_id}" "loop"
 
-_remove_backfile $backfile_0
+_remove_backfile "$backfile_0"
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_02.sh b/tools/testing/selftests/ublk/test_loop_02.sh
index c71ae63059b8..df06b7804881 100755
--- a/tools/testing/selftests/ublk/test_loop_02.sh
+++ b/tools/testing/selftests/ublk/test_loop_02.sh
@@ -8,15 +8,15 @@ ERR_CODE=0
 
 _prep_test "loop" "mkfs & mount & umount"
 
-backfile_0=`_create_backfile 256M`
+backfile_0=$(_create_backfile 256M)
 
-dev_id=`_add_ublk_dev -t loop $backfile_0`
+dev_id=$(_add_ublk_dev -t loop "$backfile_0")
 
-_mkfs_mount_test /dev/ublkb${dev_id}
+_mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
 
-_cleanup_test ${dev_id} "loop"
+_cleanup_test "${dev_id}" "loop"
 
-_remove_backfile $backfile_0
+_remove_backfile "$backfile_0"
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_03.sh b/tools/testing/selftests/ublk/test_loop_03.sh
index e781ac6db6b4..2255b4296590 100755
--- a/tools/testing/selftests/ublk/test_loop_03.sh
+++ b/tools/testing/selftests/ublk/test_loop_03.sh
@@ -10,13 +10,13 @@ _have_feature "ZERO_COPY" || exit 4
 
 _prep_test "loop" "write and verify over zero copy"
 
-backfile_0=`_create_backfile 256M`
+backfile_0=$(_create_backfile 256M)
 
-dev_id=`_add_ublk_dev -t loop $backfile_0 -z`
+dev_id=$(_add_ublk_dev -t loop -z "$backfile_0")
 
 # run fio over the ublk disk
 fio --name=write_and_verify \
-    --filename=/dev/ublkb${dev_id} \
+    --filename=/dev/ublkb"${dev_id}" \
     --ioengine=libaio --iodepth=64 \
     --rw=write \
     --size=256M \
@@ -26,8 +26,8 @@ fio --name=write_and_verify \
     --bs=4k > /dev/null 2>&1
 ERR_CODE=$?
 
-_cleanup_test ${dev_id} "loop"
+_cleanup_test "${dev_id}" "loop"
 
-_remove_backfile $backfile_0
+_remove_backfile "$backfile_0"
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_04.sh b/tools/testing/selftests/ublk/test_loop_04.sh
index 6ab67247c809..a797b25213ec 100755
--- a/tools/testing/selftests/ublk/test_loop_04.sh
+++ b/tools/testing/selftests/ublk/test_loop_04.sh
@@ -8,15 +8,15 @@ ERR_CODE=0
 
 _prep_test "loop" "mkfs & mount & umount with zero copy"
 
-backfile_0=`_create_backfile 256M`
+backfile_0=$(_create_backfile 256M)
 
-dev_id=`_add_ublk_dev -t loop -z $backfile_0`
+dev_id=$(_add_ublk_dev -t loop -z "$backfile_0")
 
-_mkfs_mount_test /dev/ublkb${dev_id}
+_mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
 
-_cleanup_test ${dev_id} "loop"
+_cleanup_test "${dev_id}" "loop"
 
-_remove_backfile $backfile_0
+_remove_backfile "$backfile_0"
 
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_null_01.sh b/tools/testing/selftests/ublk/test_null_01.sh
index 04fc3ac7c716..b048ddc4ae6f 100755
--- a/tools/testing/selftests/ublk/test_null_01.sh
+++ b/tools/testing/selftests/ublk/test_null_01.sh
@@ -8,12 +8,12 @@ ERR_CODE=0
 
 _prep_test "null" "basic IO test"
 
-dev_id=`_add_ublk_dev -t null`
+dev_id=$(_add_ublk_dev -t null)
 
 # run fio over the two disks
-fio --name=job1 --filename=/dev/ublkb${dev_id} --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
+fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
 ERR_CODE=$?
 
-_cleanup_test ${dev_id} "null"
+_cleanup_test "${dev_id}" "null"
 
 _show_result $TID $ERR_CODE
-- 
2.47.0


