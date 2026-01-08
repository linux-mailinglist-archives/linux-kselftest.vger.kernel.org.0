Return-Path: <linux-kselftest+bounces-48492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF7DD01D5C
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 10:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A04C3305B1D4
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 09:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAEE42CD61;
	Thu,  8 Jan 2026 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cErvshYF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4B142A821
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864020; cv=none; b=CoIykkZB7Xa0/hNZVSqdkpMqoWZBAVaQ48B8RSaBBR1+VzRP3CCuYd2czg9IPK0jq9+4VrB80YNBGVOtRNHlne6afvQwn4CbHpMJMq36iFhDaNJfl5Rf+3F7pFhyGrUnQS1Vcca001nWPMAoCTQc2XTONjFNbVgq3X6Pt/h47+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864020; c=relaxed/simple;
	bh=eWMcbdJYhFxvXFqjbBRedUH0jQ5siz6lFXcZN8bMrmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i04zxGGTLVzFbU8X0EK61hIHIcjPVYmiad7rQq+jZD4pZ0PA84gSpTQn5GUEIjnrxBfNi7wUv//1DkCskVHlndNK1LszAM4O001T2v2+ClrOX1wQhX0X85P1cQR1SY12EamwB5dQMqhWj5FJwEe/+4E17FpcyyotQU3SsVUiQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cErvshYF; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-3f9fb53bea4so213363fac.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863999; x=1768468799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaU0XpTuR03wE6PGtvQP43RzD+KIxiTF9KOB8gOkl3o=;
        b=cErvshYFo0xrcjBV6YGmWCaja9qhrTTLAEIuF/f0RGtWxmnmG8SsynQ0kDHUqYWhwz
         yM4d/1RhdljDIOCu2y8CjgePkj18kenXtB6qEILqEfU7pYnWCqSTqQGF6+iik3PgPURs
         VUxdos4Zwm6p7M8QXngrrZtrYXdI6rpkf0K2Wr87n7/SjOj40iIR0gm7Vx1uBj8gKk4Z
         +FgUtIcqU2JxRNfwv+DXJJ9JFxk++u7yK/qB9o+DW6K1BFXqUTO0VC1m4pO4fUscfn7r
         lLK6nVzDMLhunQgbW/z2n6S6Nk/a9oLMjaiipMGuikQAaWTDwn1ubQ/FvZLFv151Mr8M
         Hx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863999; x=1768468799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eaU0XpTuR03wE6PGtvQP43RzD+KIxiTF9KOB8gOkl3o=;
        b=NMrNbiPXST7cendjyC7n4MzvhKU54KRYiyhoD9eMGPavoCwmqnMzs8k3xopt+FYsYa
         3g9InmRaMkHfq9lD4MYOsxbxC6yiaUm+V+For9eC9sHN79pUbZkw710KF6DYrLJERT+f
         +3v7zrh2JzERgvN0Uc2a52BU7B+G+8ylwySqdT2ZCeAcYoErVfAUqLX2DnFRGXSC8hyd
         qaZeXS9Wm2m7NwzCN/ORW5FO5Ph4Mcm0lHaTTJYdFf6Xdlob72rEUILoBXTDXYE5BM4H
         d7wW2jhee0Q+Sdg+v1urLecRca64btdvdr3UYkmstB2yyOgz9xJJYTPv8vMaR6H5gN8R
         8tjA==
X-Forwarded-Encrypted: i=1; AJvYcCXaOYhLZrPcbwd3oJj39DFfZONNDBgfRPokoXp4QWTGTSEdEJFXfn1A5SnMqHCSbsIPAHfjQDRub0UC1IUpgHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP1YJHr1OKhi5vzE+0yQlX4p87pVad2PPTx+JyzoEGgxVtz5Xp
	CpY0/lb2FHiEjaE0G7D1LGTvJDuVoqVCPFmxMMtGxix+kiRzs0YsKD8kZ5X1qt0NStRNAnwkZpT
	S/XfO9JX7pGXd3CpYRznBFiS12Q0PX6NYovvK
X-Gm-Gg: AY/fxX7rDYwrgOGcLDayGPwiRzDnixjyP7IzoIjFzIU6zMiipPB3iFcM9GRDuIottw6
	NOcdV8xwCMX629etRoDQIz/eRR3Wf2FNPZ5Lj7Lznp5LSRYp7WJrs2/De4lDZBxF5I+Y0H2SUKO
	jFW1+NPfqVhh6yQyWUUHTZ/MaF7iGwSaJ1BKckRqurjlbsx8FCRj3JVYmKZEdufqycDm1durnLz
	6Z7BV9rjkOALH4xdb9ipSdaXtw9MNFHG2duzJGIWg4rPpMAuFj5zvA1t8isY9YTuYa9mHssaCr0
	cJRp6PyA11R20yvnxXz+1kd7GVv/WXkLoaUhyyJRkv/S+hpVK2CIlB9xOB6Rl5bRBUtIIBmjn38
	aMs+Vnb3807SJw+tPutlBFRqLFPrMJRZZlONtT9X30w==
X-Google-Smtp-Source: AGHT+IFYvl6fYndMLF80xvEQYCcAZV09cJSN26yC4MLZIkfZxRKtsAzFauxuHLBWb6KYs55Z1KkAiyisPKVS
X-Received: by 2002:a05:6871:a003:b0:3d3:2fa6:e16e with SMTP id 586e51a60fabf-3ffc0c4ee00mr2082048fac.9.1767863998824;
        Thu, 08 Jan 2026 01:19:58 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ffa4e3e739sm837434fac.7.2026.01.08.01.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:58 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C4CC4341DAF;
	Thu,  8 Jan 2026 02:19:57 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BC4DFE42F2C; Thu,  8 Jan 2026 02:19:57 -0700 (MST)
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
Subject: [PATCH v4 19/19] selftests: ublk: add end-to-end integrity test
Date: Thu,  8 Jan 2026 02:19:47 -0700
Message-ID: <20260108091948.1099139-20-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
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
index 239ad1c741ef..036a9f01b464 100644
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


