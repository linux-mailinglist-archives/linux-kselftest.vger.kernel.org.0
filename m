Return-Path: <linux-kselftest+bounces-27628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EC2A46645
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 17:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE95719C7141
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 16:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484AD21D3FE;
	Wed, 26 Feb 2025 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euWQ8A8T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C1C221D96
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585553; cv=none; b=pgAR69ZM8P2Jt+xYYceJeQGd8IHaoGWYiPpbnPvcVTgf/c25yTpRlqpZWNpn3jB72Lo3y52f39zrkXm/WC9eExGS9CV2bbyUl4cj40s615KCG3BkWueiZmydJN9effhoXoJsmkGbaaTHIHuRhi6I8bHbt9FHYfRhivNEZUeYZ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585553; c=relaxed/simple;
	bh=UMjXXD1KROu+VNUYfBsB/VDVFdrLKoFAYO+eiHxhBeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3MHTl417SZuAEjzKRFs/rZmzOhnwHQKY5n29EEBFqaA5t3neuZUE5CDRTjRaD0a3tQ9sQ25J/aaCYa9Ul1/FOC/6dASJgODozdR11cTWWhUOo+14tW1IqZ51zpGmHH76j7UuWDsZcIAj22kNaOKu6lvpV21W0GTAOUjQgkxNzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=euWQ8A8T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740585550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sx2udGpqZZB8T8g8WZVWtRoKu1WyRExwSJSYfvAhvPQ=;
	b=euWQ8A8T4Yhj4lhzYDXrnAcjb15kWRapv3+FwGhBa+4eIKzlT/LGahjbquQ47BouhG3+gU
	JabFtMqkqoTwCHwL+UCSXeobC9VEIOl6u7gVn7Oqp/EmJDOrtND1Vn/L6w20et6ooReM//
	hBk+6bvreYf51uvixN3G0PitE4xXWeI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-crPropTNM0mvG-Nqf1UhTg-1; Wed,
 26 Feb 2025 10:59:03 -0500
X-MC-Unique: crPropTNM0mvG-Nqf1UhTg-1
X-Mimecast-MFC-AGG-ID: crPropTNM0mvG-Nqf1UhTg_1740585542
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E98E918EAAA7;
	Wed, 26 Feb 2025 15:59:01 +0000 (UTC)
Received: from localhost (unknown [10.72.116.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A90281955BD4;
	Wed, 26 Feb 2025 15:58:59 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/3] selftests: ublk: add file backed ublk
Date: Wed, 26 Feb 2025 23:58:37 +0800
Message-ID: <20250226155841.2489284-3-ming.lei@redhat.com>
In-Reply-To: <20250226155841.2489284-1-ming.lei@redhat.com>
References: <20250226155841.2489284-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add file backed ublk and IO verify test.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile        |   2 +
 tools/testing/selftests/ublk/kublk.c         | 172 ++++++++++++++++++-
 tools/testing/selftests/ublk/test_common.sh  |  47 +++++
 tools/testing/selftests/ublk/test_loop_01.sh |  30 ++++
 tools/testing/selftests/ublk/test_loop_02.sh |  21 +++
 5 files changed, 268 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_loop_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_02.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index e1fb6c804c90..270d2bbe232b 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -4,6 +4,8 @@ CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)
 LDLIBS += -lpthread -lm -luring
 
 TEST_PROGS := test_null_01.sh
+TEST_PROGS += test_loop_01.sh
+TEST_PROGS += test_loop_02.sh
 
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS_EXTENDED = kublk
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index bbf648889022..b876752f0e11 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -105,7 +105,10 @@ struct ublk_tgt {
 	unsigned int  cq_depth;
 	const struct ublk_tgt_ops *ops;
 	struct ublk_params params;
-	char backing_file[1024 - 8 - sizeof(struct ublk_params)];
+
+	int nr_backing_files;
+	unsigned long backing_file_size[MAX_BACK_FILES];
+	char backing_file[MAX_BACK_FILES][PATH_MAX];
 };
 
 struct ublk_queue {
@@ -131,7 +134,7 @@ struct ublk_dev {
 	struct ublksrv_ctrl_dev_info  dev_info;
 	struct ublk_queue q[UBLK_MAX_QUEUES];
 
-	int fds[2];	/* fds[0] points to /dev/ublkcN */
+	int fds[MAX_BACK_FILES + 1];	/* fds[0] points to /dev/ublkcN */
 	int nr_fds;
 	int ctrl_fd;
 	struct io_uring ring;
@@ -1003,7 +1006,7 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 	struct ublksrv_ctrl_dev_info *info;
 	struct ublk_dev *dev;
 	int dev_id = ctx->dev_id;
-	int ret;
+	int ret, i;
 
 	ops = ublk_find_tgt(tgt_type);
 	if (!ops) {
@@ -1042,6 +1045,13 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 	dev->tgt.sq_depth = depth;
 	dev->tgt.cq_depth = depth;
 
+	for (i = 0; i < MAX_BACK_FILES; i++) {
+		if (ctx->files[i]) {
+			strcpy(dev->tgt.backing_file[i], ctx->files[i]);
+			dev->tgt.nr_backing_files++;
+		}
+	}
+
 	ret = ublk_ctrl_add_dev(dev);
 	if (ret < 0) {
 		ublk_err("%s: can't add dev id %d, type %s ret %d\n",
@@ -1223,7 +1233,7 @@ static int cmd_dev_get_features(void)
 
 static int cmd_dev_help(char *exe)
 {
-	printf("%s add -t [null] [-q nr_queues] [-d depth] [-n dev_id]\n", exe);
+	printf("%s add -t [null|loop] [-q nr_queues] [-d depth] [-n dev_id] [backfile1] [backfile2] ...\n", exe);
 	printf("\t default: nr_queues=2(max 4), depth=128(max 128), dev_id=-1(auto allocation)\n");
 	printf("%s del [-n dev_id] -a \n", exe);
 	printf("\t -a delete all devices -n delete specified device\n");
@@ -1264,12 +1274,166 @@ static int ublk_null_queue_io(struct ublk_queue *q, int tag)
 	return 0;
 }
 
+static void backing_file_tgt_deinit(struct ublk_dev *dev)
+{
+	int i;
+
+	for (i = 1; i < dev->nr_fds; i++) {
+		fsync(dev->fds[i]);
+		close(dev->fds[i]);
+	}
+}
+
+static int backing_file_tgt_init(struct ublk_dev *dev)
+{
+	int fd, i;
+
+	assert(dev->nr_fds == 1);
+
+	for (i = 0; i < dev->tgt.nr_backing_files; i++) {
+		char *file = dev->tgt.backing_file[i];
+		unsigned long bytes;
+		struct stat st;
+
+		ublk_dbg(UBLK_DBG_DEV, "%s: file %d: %s\n", __func__, i, file);
+
+		fd = open(file, O_RDWR | O_DIRECT);
+		if (fd < 0) {
+			ublk_err("%s: backing file %s can't be opened: %s\n",
+					__func__, file, strerror(errno));
+			return -EBADF;
+		}
+
+		if (fstat(fd, &st) < 0) {
+			close(fd);
+			return -EBADF;
+		}
+
+		if (S_ISREG(st.st_mode))
+			bytes = st.st_size;
+		else if (S_ISBLK(st.st_mode)) {
+			if (ioctl(fd, BLKGETSIZE64, &bytes) != 0)
+				return -1;
+		} else {
+			return -EINVAL;
+		}
+
+		dev->tgt.backing_file_size[i] = bytes;
+		dev->fds[dev->nr_fds] = fd;
+		dev->nr_fds += 1;
+	}
+
+	return 0;
+}
+
+static int loop_queue_tgt_io(struct ublk_queue *q, int tag)
+{
+	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
+	struct io_uring_sqe *sqe = ublk_queue_alloc_sqe(q);
+	unsigned ublk_op = ublksrv_get_op(iod);
+
+	if (!sqe)
+		return -ENOMEM;
+
+	switch (ublk_op) {
+	case UBLK_IO_OP_FLUSH:
+		io_uring_prep_sync_file_range(sqe, 1 /*fds[1]*/,
+				iod->nr_sectors << 9,
+				iod->start_sector << 9,
+				IORING_FSYNC_DATASYNC);
+		io_uring_sqe_set_flags(sqe, IOSQE_FIXED_FILE);
+		break;
+	case UBLK_IO_OP_WRITE_ZEROES:
+	case UBLK_IO_OP_DISCARD:
+		return -ENOTSUP;
+	case UBLK_IO_OP_READ:
+		io_uring_prep_read(sqe, 1 /*fds[1]*/,
+				(void *)iod->addr,
+				iod->nr_sectors << 9,
+				iod->start_sector << 9);
+		io_uring_sqe_set_flags(sqe, IOSQE_FIXED_FILE);
+		break;
+	case UBLK_IO_OP_WRITE:
+		io_uring_prep_write(sqe, 1 /*fds[1]*/,
+				(void *)iod->addr,
+				iod->nr_sectors << 9,
+				iod->start_sector << 9);
+		io_uring_sqe_set_flags(sqe, IOSQE_FIXED_FILE);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	q->io_inflight++;
+	/* bit63 marks us as tgt io */
+	sqe->user_data = build_user_data(tag, ublk_op, 0, 1);
+
+	ublk_dbg(UBLK_DBG_IO, "%s: tag %d ublk io %x %llx %u\n", __func__, tag,
+			iod->op_flags, iod->start_sector, iod->nr_sectors << 9);
+	return 1;
+}
+
+static int ublk_loop_queue_io(struct ublk_queue *q, int tag)
+{
+	int queued = loop_queue_tgt_io(q, tag);
+
+	if (queued < 0)
+		ublk_complete_io(q, tag, queued);
+
+	return 0;
+}
+
+static void ublk_loop_io_done(struct ublk_queue *q, int tag,
+		const struct io_uring_cqe *cqe)
+{
+	int cqe_tag = user_data_to_tag(cqe->user_data);
+
+	assert(tag == cqe_tag);
+	ublk_complete_io(q, tag, cqe->res);
+	q->io_inflight--;
+}
+
+static int ublk_loop_tgt_init(struct ublk_dev *dev)
+{
+	unsigned long long bytes;
+	int ret;
+	struct ublk_params p = {
+		.types = UBLK_PARAM_TYPE_BASIC,
+		.basic = {
+			.logical_bs_shift	= 9,
+			.physical_bs_shift	= 12,
+			.io_opt_shift	= 12,
+			.io_min_shift	= 9,
+			.max_sectors = dev->dev_info.max_io_buf_bytes >> 9,
+		},
+	};
+
+	assert(dev->tgt.nr_backing_files == 1);
+	ret = backing_file_tgt_init(dev);
+	if (ret)
+		return ret;
+
+	bytes = dev->tgt.backing_file_size[0];
+	dev->tgt.dev_size = bytes;
+	p.basic.dev_sectors = bytes >> 9;
+	dev->tgt.params = p;
+
+	return 0;
+}
+
 static const struct ublk_tgt_ops tgt_ops_list[] = {
 	{
 		.name = "null",
 		.init_tgt = ublk_null_tgt_init,
 		.queue_io = ublk_null_queue_io,
 	},
+	{
+		.name = "loop",
+		.init_tgt = ublk_loop_tgt_init,
+		.deinit_tgt = backing_file_tgt_deinit,
+		.queue_io = ublk_loop_queue_io,
+		.tgt_io_done = ublk_loop_io_done,
+	},
 };
 
 static const struct ublk_tgt_ops *ublk_find_tgt(const char *name)
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 959775c0dd7a..2b894c7a8e2e 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -1,5 +1,52 @@
 #!/bin/bash
 
+_create_backfile() {
+	local my_size=$1
+	local my_file=`mktemp ublk_bpf_${my_size}_XXXXX`
+
+	truncate -s ${my_size} ${my_file}
+	echo $my_file
+}
+
+_remove_backfile() {
+	local file=$1
+
+	[ -f "$file" ] && rm -f $file
+}
+
+_create_tmp_dir() {
+	local my_file=`mktemp -d ublk_bpf_dir_XXXXX`
+
+	echo $my_file
+}
+
+_remove_tmp_dir() {
+	local dir=$1
+
+	[ -d "$dir" ] && rmdir $dir
+}
+
+_mkfs_mount_test()
+{
+	local dev=$1
+	local err_code=0
+	local mnt_dir=`_create_tmp_dir`
+
+	mkfs.ext4 -F $dev > /dev/null 2>&1
+	err_code=$?
+	if [ $err_code -ne 0 ]; then
+		return $err_code
+	fi
+
+	mount -t ext4 $dev $mnt_dir > /dev/null 2>&1
+	umount $dev
+	err_code=$?
+	_remove_tmp_dir $mnt_dir
+	if [ $err_code -ne 0 ]; then
+		return $err_code
+	fi
+}
+
 _check_root() {
 	local ksft_skip=4
 
diff --git a/tools/testing/selftests/ublk/test_loop_01.sh b/tools/testing/selftests/ublk/test_loop_01.sh
new file mode 100755
index 000000000000..d65424c8a0d3
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_loop_01.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+
+. test_common.sh
+
+TID="loop_01"
+ERR_CODE=0
+
+_prep_test "loop" "write and verify test"
+
+backfile_0=`_create_backfile 256M`
+
+dev_id=`_add_ublk_dev -t loop $backfile_0`
+
+# run fio over the ublk disk
+fio --name=write_and_verify \
+    --filename=/dev/ublkb${dev_id} \
+    --ioengine=libaio --iodepth=16 \
+    --rw=write \
+    --size=256M \
+    --direct=1 \
+    --verify=crc32c \
+    --do_verify=1 \
+    --bs=4k > /dev/null 2>&1
+ERR_CODE=$?
+
+_cleanup_test ${dev_id} "loop"
+
+_remove_backfile $backfile_0
+
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_02.sh b/tools/testing/selftests/ublk/test_loop_02.sh
new file mode 100755
index 000000000000..f2e375670c53
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_loop_02.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+
+. test_common.sh
+
+TID="loop_02"
+ERR_CODE=0
+
+_prep_test "loop" "mkfs & mount & umount"
+
+backfile_0=`_create_backfile 256M`
+
+dev_id=`_add_ublk_dev -t loop $backfile_0`
+
+_mkfs_mount_test /dev/ublkb${dev_id}
+ERR_CODE=$?
+
+_cleanup_test ${dev_id} "loop"
+
+_remove_backfile $backfile_0
+
+_show_result $TID $ERR_CODE
-- 
2.47.0


