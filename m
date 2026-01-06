Return-Path: <linux-kselftest+bounces-48257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C59CF62B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E65053052EC6
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F73326FD9A;
	Tue,  6 Jan 2026 00:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Nvu4zP1A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B95E23185D
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661100; cv=none; b=fsByhTJRSGW/c+h+9DRWTg7U+EwJNHVwky24aqExYM+GkmDtybJqG9SA4FuRXSfwcJ0YlwdI49qCI0drp5fZwpKn4Lf3AFcejNr0o2RGJtzuElrTm7usIT5yNgOOJooryqu1ZeOOBly6JKJ1m88St29dRV/IKCuLuJ7+VVAR5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661100; c=relaxed/simple;
	bh=Z1UdenNqomW1Gdmx86hqjdPqAqBfGOKQ/CBxjOYJH6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoU+BaLSEYRv2ocavvy3sjJnL3UlRhu3GkRWV5MpZ5EkCJIUT7iJZGEiNtj3+Ehm4Zs3yriS7GZOTi5N426rSpWXNjBNLDHKlurDSxzsjTSpO6RMt9q3rF2VgLoCe94BNR66nFK699RHBu+XtQNwo/9bEj543lrSD/RO9uOrq6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Nvu4zP1A; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-29f08b909aeso1204335ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661092; x=1768265892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWgbGYobkvaFSQnhmymI3uWpc8/0KXyANTacEmbRQf4=;
        b=Nvu4zP1AUR1u2OTOlSMg1Gt/rqgn6E7TwHYkzScRZgn95dYdn5uIBZiZJYMROpju/0
         sHiWsiLHEE21xxGhXelaOufc79a1wWGWL/E/P4kl6sF/2zdQtRlwMQADZbcSsaxTBCiw
         5K4NvPnajm7HIcoSDGrHqR81S3F5LixvAFPa2xWAxIE61Khvw05UIHQp5sT3ohv97AB1
         qyefiE4TTxxsd4PMiZP4QOPUvfbMY+i556dIrsY9VvX45oETOWYjDYOu/JMlxCoezKbB
         DS8ZfqdYHZ0CpcUP3U4ACIDgKT/2DRMMooQqibn2xzDyxMBnyqYPn56JSv0b33vDz4Cv
         RBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661092; x=1768265892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iWgbGYobkvaFSQnhmymI3uWpc8/0KXyANTacEmbRQf4=;
        b=IM5lF6DAWuq1uB0lEB5bbvDzHcF1V/L1f5a0s3vWgBDKLDGn7IZ8EvSyreqKEdCXiP
         iw42caPL13uZeBDSJM1VjT4jU2IQJEDhLmIv4SPURyoAHWCvmd3uuJ6SogufGjLgCmOe
         eZeOhxfTAx2+LWGJqO0/JCRsHwnHTtnf+BwplgpjZCofErS3s9apvQBhbeBKJiJSlasF
         Nxvv5aNr/HuAfpYsZjNwzzgBuA86TUZSscHBSu7jNSfhdZN20xxcMar8udnnESyzJrDB
         7EgNr+xQWODNn1daxhQ31IjFvOKMVKFMs2RhTEtu+CPRnB9keaknUCQimbj4QeROlgEB
         OzRA==
X-Forwarded-Encrypted: i=1; AJvYcCU1vdG4IXC+HPBbxM7wwa2agUeauAL2KZ1yRmLKzsFtWwgNxxRBz5H6NQFTJMmQrrHCbHFdQCD3zYl/QqTxpWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9uxU3gdBR2hLSxncbbuRunMzEqi8wOOtKcQIa8hqLuiPOZqwg
	CV+ZBdjHZzDA978rw9KKQ38mUC50L6Pc5Wd8WORdFc/5PGb98Xivs2NJC+zuFyqFCvXY1Q0x9u+
	xqQrBtW/FntTvSKLcyiA4iEdkvZfsBW4rzoFI
X-Gm-Gg: AY/fxX5Fr9hSvK20VngSpYc14U+Kiw13XLhsK42CW97g//ToiYb744nbKeefhazRYFK
	YO+k4hekhP7ygUgP99areE4RAdZwuN1YTg+kxoSVb8fMap/40FRkxGjTRM2zQInVUZDhNXp3sDV
	9I2/ndpkSRlLqSe+MD0l9kbKHhxmCiE/0tBfFmkCxgzp56fnIHwj0muSVk48dVMkC/qOUFt35xV
	eSMd3Ds3iBlAJ2oCLcc4L0ucTX4MJw11YopqVhRuwykg2aWfo4MP6YvOELC8KOGLiJyeSSi6Gln
	isYB7H07kvNpRmGlh0uGSSWU2nzgMP4q7AXhAQY26blJaiVw9mMtm4ritP8LauWaBM/OHEEu5SN
	Jzp1fNwP0ZLOzoFyuFsAR/9yXiQi8B5NCtJp5aNDzyQ==
X-Google-Smtp-Source: AGHT+IGOfp+6bH84vad2EBQ2+Dwb3Z0fUV6/3dMYfGye5S2Vf4an6Zy5q/XCGn88/corDJ9YMoIic3ed4Enw
X-Received: by 2002:a17:90b:2884:b0:340:be2e:9884 with SMTP id 98e67ed59e1d1-34f5f284472mr709682a91.1.1767661092230;
        Mon, 05 Jan 2026 16:58:12 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34f5faf11e2sm107244a91.4.2026.01.05.16.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:12 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id AB19434173B;
	Mon,  5 Jan 2026 17:58:11 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9D880E44554; Mon,  5 Jan 2026 17:58:11 -0700 (MST)
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
Subject: [PATCH v3 19/19] selftests: ublk: add end-to-end integrity test
Date: Mon,  5 Jan 2026 17:57:51 -0700
Message-ID: <20260106005752.3784925-20-csander@purestorage.com>
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

Add test case loop_08 to verify the ublk integrity data flow. It uses
the kublk loop target to create a ublk device with integrity on top of
backing data and integrity files. It then writes to the whole device
with fio configured to generate integrity data. Then it reads back the
whole device with fio configured to verify the integrity data.
It also verifies that injected guard, reftag, and apptag corruptions are
correctly detected.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile        |   1 +
 tools/testing/selftests/ublk/test_loop_08.sh | 111 +++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_loop_08.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index bfd68ae64142..ab745443fd58 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -33,10 +33,11 @@ TEST_PROGS += test_loop_02.sh
 TEST_PROGS += test_loop_03.sh
 TEST_PROGS += test_loop_04.sh
 TEST_PROGS += test_loop_05.sh
 TEST_PROGS += test_loop_06.sh
 TEST_PROGS += test_loop_07.sh
+TEST_PROGS += test_loop_08.sh
 TEST_PROGS += test_stripe_01.sh
 TEST_PROGS += test_stripe_02.sh
 TEST_PROGS += test_stripe_03.sh
 TEST_PROGS += test_stripe_04.sh
 TEST_PROGS += test_stripe_05.sh
diff --git a/tools/testing/selftests/ublk/test_loop_08.sh b/tools/testing/selftests/ublk/test_loop_08.sh
new file mode 100755
index 000000000000..ca289cfb2ad4
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_loop_08.sh
@@ -0,0 +1,111 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+if ! _have_program fio; then
+	exit $UBLK_SKIP_CODE
+fi
+
+fio_version=$(fio --version)
+if [[ "$fio_version" =~ fio-[0-9]+\.[0-9]+$ ]]; then
+	echo "Requires development fio version with https://github.com/axboe/fio/pull/1992"
+	exit $UBLK_SKIP_CODE
+fi
+
+TID=loop_08
+
+_prep_test "loop" "end-to-end integrity"
+
+_create_backfile 0 256M
+_create_backfile 1 32M # 256M * (64 integrity bytes / 512 data bytes)
+integrity_params="--integrity_capable --integrity_reftag
+                  --metadata_size 64 --pi_offset 56 --csum_type t10dif"
+dev_id=$(_add_ublk_dev -t loop -u $integrity_params "${UBLK_BACKFILES[@]}")
+_check_add_dev $TID $?
+
+# 1M * (64 integrity bytes / 512 data bytes) = 128K
+fio_args="--ioengine io_uring --direct 1 --bsrange 512-1M --iodepth 32
+          --md_per_io_size 128K --pi_act 0 --pi_chk GUARD,REFTAG,APPTAG
+          --filename /dev/ublkb$dev_id"
+fio --name fill --rw randwrite $fio_args > /dev/null
+err=$?
+if [ $err != 0 ]; then
+	echo "fio fill failed"
+	_show_result $TID $err
+fi
+
+fio --name verify --rw randread $fio_args > /dev/null
+err=$?
+if [ $err != 0 ]; then
+	echo "fio verify failed"
+	_show_result $TID $err
+fi
+
+fio_err=$(mktemp fio_err_XXXXX)
+
+# Overwrite 4-byte reftag at offset 56 + 4 = 60
+dd_reftag_args="bs=1 seek=60 count=4 oflag=dsync conv=notrunc status=none"
+dd if=/dev/urandom "of=${UBLK_BACKFILES[1]}" $dd_reftag_args
+err=$?
+if [ $err != 0 ]; then
+	echo "dd corrupted_reftag failed"
+	rm -f "$fio_err"
+	_show_result $TID $err
+fi
+if fio --name corrupted_reftag --rw randread $fio_args > /dev/null 2> "$fio_err"; then
+	echo "fio corrupted_reftag unexpectedly succeeded"
+	rm -f "$fio_err"
+	_show_result $TID 255
+fi
+expected_err="REFTAG compare error: LBA: 0 Expected=0, Actual="
+if ! grep -q "$expected_err" "$fio_err"; then
+	echo "fio corrupted_reftag message not found: $expected_err"
+	rm -f "$fio_err"
+	_show_result $TID 255
+fi
+# Reset to 0
+dd if=/dev/zero "of=${UBLK_BACKFILES[1]}" $dd_reftag_args
+err=$?
+if [ $err != 0 ]; then
+	echo "dd restore corrupted_reftag failed"
+	rm -f "$fio_err"
+	_show_result $TID $err
+fi
+
+dd_data_args="bs=512 count=1 oflag=direct,dsync conv=notrunc status=none"
+dd if=/dev/zero "of=${UBLK_BACKFILES[0]}" $dd_data_args
+err=$?
+if [ $err != 0 ]; then
+	echo "dd corrupted_data failed"
+	rm -f "$fio_err"
+	_show_result $TID $err
+fi
+if fio --name corrupted_data --rw randread $fio_args > /dev/null 2> "$fio_err"; then
+	echo "fio corrupted_data unexpectedly succeeded"
+	rm -f "$fio_err"
+	_show_result $TID 255
+fi
+expected_err="Guard compare error: LBA: 0 Expected=0, Actual="
+if ! grep -q "$expected_err" "$fio_err"; then
+	echo "fio corrupted_data message not found: $expected_err"
+	rm -f "$fio_err"
+	_show_result $TID 255
+fi
+
+if fio --name bad_apptag --rw randread $fio_args --apptag 0x4321 > /dev/null 2> "$fio_err"; then
+	echo "fio bad_apptag unexpectedly succeeded"
+	rm -f "$fio_err"
+	_show_result $TID 255
+fi
+expected_err="APPTAG compare error: LBA: [0-9]* Expected=4321, Actual=1234"
+if ! grep -q "$expected_err" "$fio_err"; then
+	echo "fio bad_apptag message not found: $expected_err"
+	rm -f "$fio_err"
+	_show_result $TID 255
+fi
+
+rm -f "$fio_err"
+
+_cleanup_test
+_show_result $TID 0
-- 
2.45.2


