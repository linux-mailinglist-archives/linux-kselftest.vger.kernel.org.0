Return-Path: <linux-kselftest+bounces-48255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC44CF62A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DCC73082EAF
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68F42594BD;
	Tue,  6 Jan 2026 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Erk8dslH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B982A2222B6
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661099; cv=none; b=jFlFh7J/+gYxKDaiu7nzT2uFZkT6f8s1cviR7b7VK51wD8FBV+JWRWAY4VUZclzATLi2qJmgLE+3bgfyh402Dzo11UQkQcG05v5kqOBnuydwJVUF/KMVOlseXM92qUEJlA9/ArbCyerS6VZGUoNETLyK5cK5kNzzWnXSBOYodyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661099; c=relaxed/simple;
	bh=T6I6wJ3K0zbZovsFhPHvXVOw2B2xHcL5y1GMqwzvtJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=av66zZnhNcagqfzDeDfkZ9JEuwuJ46AGoiIkArti6YSqr0VOAVClsNn2Usa4MyZQIqPVtQ4AdtpHsRAdDRxGExs/d43GDxC0rvYg9dP1fJDaOGvZtR0Xwr3wjxlIsF1j2GkZZRw0iFbL4YaVSXeS6NQwa4mK61uJ8LIvcfDauNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Erk8dslH; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-7baa5787440so51400b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661092; x=1768265892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMHoFk6qxgkVzaDa4BWjqhlQdF6TcBBx1Xc90nS+iKc=;
        b=Erk8dslHtEk+VVmVQZ1JOOh9a60x9QvHCP/seV3ipf76gMCL7+YWMQPq7mPOKIBrl1
         LGl1XZgNOdGhj81VxCqDB6IaoquF+xCNveqs35ZPo2gUCa07dG95TfyddZFiDYybbaT0
         k5Y5ZNZBSJ4hDJC3SN9A/ZS8KlC33G2Q+4ZyM3f6VZaHXXD2m5GPwhII7fvzwlmSWlMB
         tKnoIJjEE+cxR45q5jSS74qPOiEGtbl7ciP9L9DuyJHAAl+569tKmu+3vh21fvaP7/mc
         2HBuInQmX1WUxOBmMA/qSnIbKXY4bgeVP30bIHqHbe4keSXDO5J7848r+0sqJYry5sJg
         z95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661092; x=1768265892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iMHoFk6qxgkVzaDa4BWjqhlQdF6TcBBx1Xc90nS+iKc=;
        b=vImCqH/4+s9/4KNs+IFsxmu6bLhGFsPeIfCpoXsgMt4OdFGzGjvZIlS7HGfu++tlYY
         crZJYb3VbfYuVEJT3P50/qMNOdK8M8J1XlnelMpOCwpIG5btYHMmbnyB6yfbmwuuDHBA
         GjDnHtSQnZZAGPEysa9I7aNcLaUysSqAXNLfQpB+2DXskCtStG5r+WOn3JpGA3nu0h5e
         ZmKsB8D1kvLFabKQ8fiaQK4ut+H92SM/Ow/sHxsd0GOuLlJ6B7VbnTl7o714zNTC98FL
         +W1xg6dmkCN0Ew6fYixSflzRYZzYTlBXKYPKw5YiqeQ8QueHPfbT16LBU3/VbMllGKev
         xfkA==
X-Forwarded-Encrypted: i=1; AJvYcCVgR4wMZisKNLGGmFr3BuH1yXpXLqF0z110gNOJ0vPaY+ea4BVmxOd43JhcUHTSpn/gCA8C+V2dvdgLc3tMUyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuXdD0VA22EWqsJMPMDyNvJuXPNnLgSPnbDwYbFYb/iI8ZqAgh
	a/RhGI5PYhn/gk22aqfmn8SZMRQcUwkpWkOowFHHxFAtf5lafHg8/SRnUSsfeNqTeIt1BOatK4v
	KzjadmEKIuKlirY0KrsvbF6r68hiNJf/6ymzl
X-Gm-Gg: AY/fxX4H3cQh7xikJ3ao1UZLOxwinOGHe1ymkWyJl8cSoAT9IfbqVHWCh/coH7IAdCv
	NY9ozQevkc3tCTiDKhArboP9x8hGyXnmpTnrM0ZVxvS0yzZpvxgEZ3otxEvHV0I4mlqInL8TDFC
	wL6kdJOk2c4OEk+k+/D8V+WBlYeI55gRuSe+MIUy8F8w9mkGk9WYU29Tj+QTAsZRytVegGy3ubr
	JBcS+jYdZYiU1WAlY1hTHoGIRMQSaxUGcRy2mTvyODt2fVUEbJMrPCTBsxNDVvs0dOPTMSmrz5r
	V4CDpBke7/Zy2wtfuqMl2jwOA9PuL+SCGUTiDgBWc7E3ga0Tm0tzsOehlUZ5UVvHx3D+Y3n9VsK
	5hyO2D3Xg+q1QmPaiHG2ZO2kVf1ycl6FcjXQXceIm3A==
X-Google-Smtp-Source: AGHT+IGbX14HlpT+oEMhN3SMTerXZI/+I63Gxe2TLTXkzaU4YX0ZcucMBqs6stDwHIRKLTgGgb15nM6tG3At
X-Received: by 2002:a05:7022:e0b:b0:119:e55a:95a0 with SMTP id a92af1059eb24-121f188a665mr592876c88.2.1767661091850;
        Mon, 05 Jan 2026 16:58:11 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-121f243aca8sm115872c88.2.2026.01.05.16.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:11 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 73B3F340DAB;
	Mon,  5 Jan 2026 17:58:11 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 659E6E44554; Mon,  5 Jan 2026 17:58:11 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 18/19] selftests: ublk: add integrity params test
Date: Mon,  5 Jan 2026 17:57:50 -0700
Message-ID: <20260106005752.3784925-19-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260106005752.3784925-1-csander@purestorage.com>
References: <20260106005752.3784925-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test case null_04 to exercise all the different integrity params. It
creates 4 different ublk devices with different combinations of
integrity arguments and verifies their integrity limits via sysfs and
the metadata_size utility.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile        |   1 +
 tools/testing/selftests/ublk/test_common.sh  |  10 ++
 tools/testing/selftests/ublk/test_null_04.sh | 166 +++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_null_04.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 41f776bb86a6..bfd68ae64142 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -25,10 +25,11 @@ TEST_PROGS += test_generic_14.sh
 TEST_PROGS += test_generic_15.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
 TEST_PROGS += test_null_03.sh
+TEST_PROGS += test_null_04.sh
 TEST_PROGS += test_loop_01.sh
 TEST_PROGS += test_loop_02.sh
 TEST_PROGS += test_loop_03.sh
 TEST_PROGS += test_loop_04.sh
 TEST_PROGS += test_loop_05.sh
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index ea9a5f3eb70a..7ff6ce79d62c 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -382,10 +382,20 @@ run_io_and_recover()
 _ublk_test_top_dir()
 {
 	cd "$(dirname "$0")" && pwd
 }
 
+METADATA_SIZE_PROG="$(_ublk_test_top_dir)/metadata_size"
+
+_get_metadata_size()
+{
+	local dev_id=$1
+	local field=$2
+
+	"$METADATA_SIZE_PROG" "/dev/ublkb$dev_id" | grep "$field" | grep -o "[0-9]*"
+}
+
 UBLK_PROG=$(_ublk_test_top_dir)/kublk
 UBLK_TEST_QUIET=1
 UBLK_TEST_SHOW_RESULT=1
 UBLK_BACKFILES=()
 export UBLK_PROG
diff --git a/tools/testing/selftests/ublk/test_null_04.sh b/tools/testing/selftests/ublk/test_null_04.sh
new file mode 100755
index 000000000000..0b0719ea33a3
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_null_04.sh
@@ -0,0 +1,166 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID=null_04
+
+_prep_test "null" "integrity params"
+
+dev_id=$(_add_ublk_dev -t null -u --metadata_size 8)
+_check_add_dev $TID $?
+metadata_size=$(_get_metadata_size "$dev_id" metadata_size)
+if [ "$metadata_size" != 8 ]; then
+	echo "metadata_size $metadata_size != 8"
+	_show_result $TID 255
+fi
+pi_offset=$(_get_metadata_size "$dev_id" pi_offset)
+if [ "$pi_offset" != 0 ]; then
+	echo "pi_offset $pi_offset != 0"
+	_show_result $TID 255
+fi
+pi_tuple_size=$(_get_metadata_size "$dev_id" pi_tuple_size)
+if [ "$pi_tuple_size" != 0 ]; then
+	echo "pi_tuple_size $pi_tuple_size != 0"
+	_show_result $TID 255
+fi
+capable=$(cat "/sys/block/ublkb$dev_id/integrity/device_is_integrity_capable")
+if [ "$capable" != 0 ]; then
+	echo "device_is_integrity_capable $capable != 0"
+	_show_result $TID 255
+fi
+format=$(cat "/sys/block/ublkb$dev_id/integrity/format")
+if [ "$format" != nop ]; then
+	echo "format $format != nop"
+	_show_result $TID 255
+fi
+protection_interval_bytes=$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")
+if [ "$protection_interval_bytes" != 512 ]; then
+	echo "protection_interval_bytes $protection_interval_bytes != 512"
+	_show_result $TID 255
+fi
+tag_size=$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")
+if [ "$tag_size" != 0 ]; then
+	echo "tag_size $tag_size != 0"
+	_show_result $TID 255
+fi
+_cleanup_test
+
+dev_id=$(_add_ublk_dev -t null -u --integrity_capable --metadata_size 64 --pi_offset 56 --csum_type ip)
+_check_add_dev $TID $?
+metadata_size=$(_get_metadata_size "$dev_id" metadata_size)
+if [ "$metadata_size" != 64 ]; then
+	echo "metadata_size $metadata_size != 64"
+	_show_result $TID 255
+fi
+pi_offset=$(_get_metadata_size "$dev_id" pi_offset)
+if [ "$pi_offset" != 56 ]; then
+	echo "pi_offset $pi_offset != 56"
+	_show_result $TID 255
+fi
+pi_tuple_size=$(_get_metadata_size "$dev_id" pi_tuple_size)
+if [ "$pi_tuple_size" != 8 ]; then
+	echo "pi_tuple_size $pi_tuple_size != 8"
+	_show_result $TID 255
+fi
+capable=$(cat "/sys/block/ublkb$dev_id/integrity/device_is_integrity_capable")
+if [ "$capable" != 1 ]; then
+	echo "device_is_integrity_capable $capable != 1"
+	_show_result $TID 255
+fi
+format=$(cat "/sys/block/ublkb$dev_id/integrity/format")
+if [ "$format" != T10-DIF-TYPE3-IP ]; then
+	echo "format $format != T10-DIF-TYPE3-IP"
+	_show_result $TID 255
+fi
+protection_interval_bytes=$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")
+if [ "$protection_interval_bytes" != 512 ]; then
+	echo "protection_interval_bytes $protection_interval_bytes != 512"
+	_show_result $TID 255
+fi
+tag_size=$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")
+if [ "$tag_size" != 0 ]; then
+	echo "tag_size $tag_size != 0"
+	_show_result $TID 255
+fi
+_cleanup_test
+
+dev_id=$(_add_ublk_dev -t null -u --integrity_reftag --metadata_size 8 --csum_type t10dif)
+_check_add_dev $TID $?
+metadata_size=$(_get_metadata_size "$dev_id" metadata_size)
+if [ "$metadata_size" != 8 ]; then
+	echo "metadata_size $metadata_size != 8"
+	_show_result $TID 255
+fi
+pi_offset=$(_get_metadata_size "$dev_id" pi_offset)
+if [ "$pi_offset" != 0 ]; then
+	echo "pi_offset $pi_offset != 0"
+	_show_result $TID 255
+fi
+pi_tuple_size=$(_get_metadata_size "$dev_id" pi_tuple_size)
+if [ "$pi_tuple_size" != 8 ]; then
+	echo "pi_tuple_size $pi_tuple_size != 8"
+	_show_result $TID 255
+fi
+capable=$(cat "/sys/block/ublkb$dev_id/integrity/device_is_integrity_capable")
+if [ "$capable" != 0 ]; then
+	echo "device_is_integrity_capable $capable != 0"
+	_show_result $TID 255
+fi
+format=$(cat "/sys/block/ublkb$dev_id/integrity/format")
+if [ "$format" != T10-DIF-TYPE1-CRC ]; then
+	echo "format $format != T10-DIF-TYPE1-CRC"
+	_show_result $TID 255
+fi
+protection_interval_bytes=$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")
+if [ "$protection_interval_bytes" != 512 ]; then
+	echo "protection_interval_bytes $protection_interval_bytes != 512"
+	_show_result $TID 255
+fi
+tag_size=$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")
+if [ "$tag_size" != 0 ]; then
+	echo "tag_size $tag_size != 0"
+	_show_result $TID 255
+fi
+_cleanup_test
+
+dev_id=$(_add_ublk_dev -t null -u --metadata_size 16 --csum_type nvme --tag_size 8)
+_check_add_dev $TID $?
+metadata_size=$(_get_metadata_size "$dev_id" metadata_size)
+if [ "$metadata_size" != 16 ]; then
+	echo "metadata_size $metadata_size != 16"
+	_show_result $TID 255
+fi
+pi_offset=$(_get_metadata_size "$dev_id" pi_offset)
+if [ "$pi_offset" != 0 ]; then
+	echo "pi_offset $pi_offset != 0"
+	_show_result $TID 255
+fi
+pi_tuple_size=$(_get_metadata_size "$dev_id" pi_tuple_size)
+if [ "$pi_tuple_size" != 16 ]; then
+	echo "pi_tuple_size $pi_tuple_size != 16"
+	_show_result $TID 255
+fi
+capable=$(cat "/sys/block/ublkb$dev_id/integrity/device_is_integrity_capable")
+if [ "$capable" != 0 ]; then
+	echo "device_is_integrity_capable $capable != 0"
+	_show_result $TID 255
+fi
+format=$(cat "/sys/block/ublkb$dev_id/integrity/format")
+if [ "$format" != EXT-DIF-TYPE3-CRC64 ]; then
+	echo "format $format != EXT-DIF-TYPE3-CRC64"
+	_show_result $TID 255
+fi
+protection_interval_bytes=$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")
+if [ "$protection_interval_bytes" != 512 ]; then
+	echo "protection_interval_bytes $protection_interval_bytes != 512"
+	_show_result $TID 255
+fi
+tag_size=$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")
+if [ "$tag_size" != 8 ]; then
+	echo "tag_size $tag_size != 8"
+	_show_result $TID 255
+fi
+_cleanup_test
+
+_show_result $TID 0
-- 
2.45.2


