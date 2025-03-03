Return-Path: <linux-kselftest+bounces-28045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A66A4C0DF
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 13:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D643AC0DA
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 12:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DBE214801;
	Mon,  3 Mar 2025 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/Ix4gT3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31EC2147E8
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005871; cv=none; b=pEdCfQvZ2LlyPl65v7Y24m2x5usizbZSDmHEhCbc3fE3m2EL/DA1tlnaWPOjJyjGJbR97P94YdOe0G2M+gFbWmAj7+SwHwJgFE+zKVEUYUKsIgWl0aq1lGcWPTum5lvYa+sDdv+No3LkNFoDllW8w6hvGaVbBOl9Nl168XxcfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005871; c=relaxed/simple;
	bh=RhgCzhGQmspDhwt6h7K2VsgtZAx/zYR/kyWLK77dikk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHjRShoNFUwe3dTuoWXqtiSW1MSDcSfEb8L1TPhqXXbC2xaPTKYTLeGKu3HOgBGYRNdS0RVAUIlw0pLzDdNgxb3y6JEI6NDcsHZhiH2TjdB3ooCpxAozrlG0u8LDKJnhhzQcVwF5e/vubnbL6nrrBP8ybzQqS6MAHfKCJbdGw+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/Ix4gT3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741005868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeME8YQChJWPab2nKPNhbBsN368ho/Xr+RmOIFOIMBs=;
	b=Z/Ix4gT3/32U5a6bThYqtdAIxOaEeiGMIm2/9j73jJ524rQ37elmna3lM2EBhpP0gHd6yX
	+nIa7d88cGlmRCewCSbwrH2ggm8DfjEdwgd6m4B+RGwlYFIyyoYjpTiTquEYO/6Sq4Wo+D
	dVriUMuQYsXzIx+TOEh3RtCRkjrjFRI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-WL-_RIHcPvSg1IJz3GslmQ-1; Mon,
 03 Mar 2025 07:44:27 -0500
X-MC-Unique: WL-_RIHcPvSg1IJz3GslmQ-1
X-Mimecast-MFC-AGG-ID: WL-_RIHcPvSg1IJz3GslmQ_1741005866
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A626D1944EB2;
	Mon,  3 Mar 2025 12:44:26 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B4F3180035F;
	Mon,  3 Mar 2025 12:44:24 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 10/11] selftests: ublk: add stress test for covering IO vs. killing ublk server
Date: Mon,  3 Mar 2025 20:43:20 +0800
Message-ID: <20250303124324.3563605-11-ming.lei@redhat.com>
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

Add stress_test_01 for running IO vs. killing ublk server, so io_uring exit &
cancel code path can be covered, same with ublk's cancel code path.

Especially IO buffer lifetime is one big thing for ublk zero copy, the added
test can verify if this area works as expected.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/test_common.sh   | 29 ++++++++++++
 .../testing/selftests/ublk/test_stress_01.sh  |  2 +-
 .../testing/selftests/ublk/test_stress_02.sh  | 47 +++++++++++++++++++
 4 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/ublk/test_stress_02.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 40af938cd277..5d8d5939f051 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -10,6 +10,7 @@ TEST_PROGS += test_loop_03.sh
 TEST_PROGS += test_loop_04.sh
 
 TEST_PROGS += test_stress_01.sh
+TEST_PROGS += test_stress_02.sh
 
 TEST_GEN_PROGS_EXTENDED = kublk
 
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 89244a7e275c..92596d0d0013 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -155,6 +155,26 @@ _add_ublk_dev() {
 	echo "${dev_id}"
 }
 
+# kill the ublk daemon and return ublk device state
+__ublk_kill_daemon()
+{
+	local dev_id=$1
+	local exp_state=$2
+	local daemon_pid
+	local state
+
+	daemon_pid=$(_get_ublk_daemon_pid "${dev_id}")
+	state=$(_get_ublk_dev_state "${dev_id}")
+
+	for ((j=0;j<50;j++)); do
+		[ "$state" == "$exp_state" ] && break
+		kill -9 "$daemon_pid" > /dev/null 2>&1
+		sleep 1
+		state=$(_get_ublk_dev_state "${dev_id}")
+	done
+	echo "$state"
+}
+
 __remove_ublk_dev_return() {
 	local dev_id=$1
 
@@ -168,11 +188,20 @@ __run_io_and_remove()
 {
 	local dev_id=$1
 	local size=$2
+	local kill_server=$3
 
 	fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio \
 		--rw=readwrite --iodepth=64 --size="${size}" --numjobs=4 \
 		--runtime=20 --time_based > /dev/null 2>&1 &
 	sleep 2
+	if [ "${kill_server}" = "yes" ]; then
+		local state
+		state=$(__ublk_kill_daemon "${dev_id}" "DEAD")
+		if [ "$state" != "DEAD" ]; then
+			echo "device isn't dead($state) after killing daemon"
+			return 255
+		fi
+	fi
 	if ! __remove_ublk_dev_return "${dev_id}"; then
 		echo "delete dev ${dev_id} failed"
 		return 255
diff --git a/tools/testing/selftests/ublk/test_stress_01.sh b/tools/testing/selftests/ublk/test_stress_01.sh
index 2dfd01cfd265..c1cdde3e79f7 100755
--- a/tools/testing/selftests/ublk/test_stress_01.sh
+++ b/tools/testing/selftests/ublk/test_stress_01.sh
@@ -18,7 +18,7 @@ ublk_io_and_remove()
 	_check_add_dev $TID $? "${backfile}"
 
 	echo "run ublk IO vs. remove device(ublk add $*)"
-	if ! __run_io_and_remove "${DEV_ID}" "${size}"; then
+	if ! __run_io_and_remove "${DEV_ID}" "${size}" "no"; then
 		echo "/dev/ublkc${DEV_ID} isn't removed"
 		_remove_backfile "${backfile}"
 		exit 255
diff --git a/tools/testing/selftests/ublk/test_stress_02.sh b/tools/testing/selftests/ublk/test_stress_02.sh
new file mode 100755
index 000000000000..ec758f649a97
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stress_02.sh
@@ -0,0 +1,47 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. test_common.sh
+TID="stress_02"
+ERR_CODE=0
+DEV_ID=-1
+
+ublk_io_and_kill_daemon()
+{
+	local size=$1
+	shift 1
+	local backfile=""
+	if echo "$@" | grep -q "loop"; then
+		backfile=${*: -1}
+	fi
+	DEV_ID=$(_add_ublk_dev "$@")
+	_check_add_dev $TID $? "${backfile}"
+
+	echo "run ublk IO vs kill ublk server(ublk add $*)"
+	if ! __run_io_and_remove "${DEV_ID}" "${size}" "yes"; then
+		echo "/dev/ublkc${DEV_ID} isn't removed res ${res}"
+		_remove_backfile "${backfile}"
+		exit 255
+	fi
+}
+
+_prep_test "stress" "run IO and kill ublk server"
+
+ublk_io_and_kill_daemon 8G -t null
+ERR_CODE=$?
+if [ ${ERR_CODE} -ne 0 ]; then
+	_show_result $TID $ERR_CODE
+fi
+
+BACK_FILE=$(_create_backfile 256M)
+ublk_io_and_kill_daemon 256M -t loop "${BACK_FILE}"
+ERR_CODE=$?
+if [ ${ERR_CODE} -ne 0 ]; then
+	_show_result $TID $ERR_CODE
+fi
+
+ublk_io_and_kill_daemon 256M -t loop -z "${BACK_FILE}"
+ERR_CODE=$?
+_cleanup_test "stress"
+_remove_backfile "${BACK_FILE}"
+_show_result $TID $ERR_CODE
-- 
2.47.0


