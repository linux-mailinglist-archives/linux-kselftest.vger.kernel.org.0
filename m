Return-Path: <linux-kselftest+bounces-47646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ABBCC612D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 06:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6411D3061283
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 05:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C682D3ECA;
	Wed, 17 Dec 2025 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SNxVTOz3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f225.google.com (mail-oi1-f225.google.com [209.85.167.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF821772A
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949722; cv=none; b=bnMs9u4aR18ekKvjPBRsS5cA4h23lHbXb0DP/ZmEVZ0xEM15/FU2y6lC2WesewFuEEYSbY3S7jSXV8neiCwe5EWEhhmKz8Temfs1hBXcu1aV/BJzWtGviNPQ0iV9B6wutK6uXpSKM84YPhKjh7E/ckXLkAa6oPDkqveBNrpCTQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949722; c=relaxed/simple;
	bh=tNS2wrfRbubpl2FKYaIvxyO2cy+QowCqwPCVDfS/LJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0InwsqmnzMBvaSHfm7/6nw9w80Jwv+8CZiAy55sl+fh3sAHCz5QAPRLpZZJlFpeNUbKtZbmunVwzKU+Q00qm0ClMY/zeYo1IpCUHkCSi4HtmtS3R+fUsPThoE4TBbqRbLi1aGs38Lt0TLUbcXVVs+vVcEBYUN4+36zFjSKIL/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SNxVTOz3; arc=none smtp.client-ip=209.85.167.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oi1-f225.google.com with SMTP id 5614622812f47-450ae3d15faso208380b6e.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 21:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949715; x=1766554515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlHrt31dSzsMCqKtBJiCTlOW1Fegip2uQ4N5CLB4TZY=;
        b=SNxVTOz3b75is+WidNjLZ5dAT0iTbqHaJbQxtyBniJ2AhNxb5CQl379dAZZtW42dOg
         4yyrnb51Dd3MRi+aT+BDlX7g4P1/yq7lG1SHwlv5pMUtaySVQTK3fC2UGvNZsh8XWpNR
         ZBSWKmSKVoTir/AcAgNOfQKY+cpMyRVntdpfNqbZZG3MOLdRrkVsKldYjml+P5oBEukL
         l0nEIf6O/XNyTa6DzjHvjP7GjJOPxrFZ3Uc6bICVXuIqN1qddx1qYqT01k3pl1nI95o5
         mbSx85BjwOx5fi1VqTklipOU88mqUwRxr255KpOE5Z1Z3tz6nowLr51W80zdgbKuWn5f
         RJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949715; x=1766554515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vlHrt31dSzsMCqKtBJiCTlOW1Fegip2uQ4N5CLB4TZY=;
        b=iRERT9FSB8LwKe3NnOa5k5rBSgO8yyjUqf//4XKLQ3DQdSa8Pg8lmnEXwTTMXf4Cg1
         F+bxyjMQcPAHXrBj0T+KD4Y4P+ZZ2iS+n91x5tgvhdNXqaDdqUwuruPDswPt53fDiVPF
         pGePxGrprddM6mVQsw7BGfcMtWxXa1ti9XfDSIaFmwLP9A0XUZt4+Cov6Nqapj2c85j3
         BPhzGGqSsBqy8+yplETL9MKNEJMWxxw5qcnI/NrFtwc5Fmuzw2L8Pvnq5t02xPBjcVln
         u1E7XEdoFJa8AhamP/BcotFy/6rREg6V9wvBg60PRr3K9I4ECURX7Gw4J1aGTGTc/azz
         ANjg==
X-Forwarded-Encrypted: i=1; AJvYcCXa2wYszgp1+RZDIp5f5rzEjG1Bah6NcXJ8BEYqOtNmoEcRQ6m5rQ7URddkaTSdLke0IYl3WlGySkMLp9kfvZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc58A0x0AavxyssQDJXHFnzyOxSXbEexNHTG5zBE/nWBFdyJJP
	BGhnyGhKcNKcCGEIiptGuaoP9q8a7mDzmmVX/1GkqHLe1YHf/bPtuS7yU/9m/iWFWxpS8kyC2wW
	i1O4Dnb9RYAy4M6IgHTZAvnTpA8/keWl59252Nan/L1TlB21zWpyQ
X-Gm-Gg: AY/fxX48KLkTZIEeBS1+mP3sEMtaa2lJtUbcwLunwhrSt9luKdXBHJXtXtzVAryJBgW
	VQ5SmlG74FWnfLPA9+3iqqph9sN9ABd/0gOIIXQ8WBZubODpUQzvuuzwrahOxP/VkSesbrr+D5r
	o+XJragBD4a6a+Yf3WGJ3qX0/Mm92itK7aEU0gxl2Sn2LhZb3ThqGha8Y+fAB//bXbv1nAoS/12
	MOyY0TV99TUer5YMxIMMVC6hJJ0TlXdgSCvYIYW7qjPHjvGi0KsiyTkgWknxAwjTrzYU3W6CfTZ
	9a8isspNS9zN11b5l00fmzVAmiU4IlUaXwgaUrIO21XsC2R6OmLDowvjc4bzC5BslqEpWqDayUT
	k0GCYGepQqFRtIRfCPvdttYU4OSU=
X-Google-Smtp-Source: AGHT+IFmg7UFWWMtPg9z6BqUt2g1F1zPH+pOkUttTKRwp+eStSdZRSo6zkGL63PLfLuD5BP2o3UTB1a4nGUw
X-Received: by 2002:a05:6871:3416:b0:3ea:d0e3:9696 with SMTP id 586e51a60fabf-3f5f8989e9fmr6393090fac.9.1765949714710;
        Tue, 16 Dec 2025 21:35:14 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3f614e29004sm1368934fac.13.2025.12.16.21.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:14 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C7CF33401D2;
	Tue, 16 Dec 2025 22:35:13 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C2E38E41AC4; Tue, 16 Dec 2025 22:35:13 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 20/20] selftests: ublk: add end-to-end integrity test
Date: Tue, 16 Dec 2025 22:34:54 -0700
Message-ID: <20251217053455.281509-21-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
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
index d567f90d30b3..e04922085fd5 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -32,10 +32,11 @@ TEST_PROGS += test_loop_02.sh
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


