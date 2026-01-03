Return-Path: <linux-kselftest+bounces-48101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BEDCEF97A
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 01:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB51E3032109
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 00:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23275261B98;
	Sat,  3 Jan 2026 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Qn6JJXtt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462DB252292
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Jan 2026 00:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401143; cv=none; b=V70uJXBCPn4rmQlqc87AhYZ3QFSDcXV1TB6nz6D7M4v8r0ZBzDjwtQmZhdSG9rJArXptAUndOx5ePD0uD6aNt+jZ9jrOFZsyWURe7vhFHSssZ1DtFlGMUqz8pLYbVCyLp6oyZFSjXurpKDD/LefUFE84DGRDhMqqojummebiyHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401143; c=relaxed/simple;
	bh=Z1UdenNqomW1Gdmx86hqjdPqAqBfGOKQ/CBxjOYJH6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkR8pwbor+O+jx413CxeJTk27N7UagGw/WJ4G1c8KzswyhZW/PExRWsgF5yATt6RDFJcRCWPuDQXyBbPY295795VDZjET/tv7w5Ipcz6wzzoXN48glJaLZXNw86EVYdhA65Dksrc8l4FyupYF88RkL//NM8EAmFk64S5yK0Sfjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Qn6JJXtt; arc=none smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-4ee1b13a0a5so8138191cf.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 16:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401136; x=1768005936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWgbGYobkvaFSQnhmymI3uWpc8/0KXyANTacEmbRQf4=;
        b=Qn6JJXttt4FJUNy446H4bvpPPLsg8ZOD8PE/kfjZZNzws6AUd0AMN5XUyaSau6FGam
         CW31MudoRMD3Fuls1h//9ekl3/4/iW2M2mIsMHAg0r5Zfm7pLCiQYpu//plOxroM+zLy
         kKN9dMkWAVz50pRgSH+oFctkZ4+tiwylEaVH45XWC6U3Wn3NC5W6UTYsCFDUYgoHb3Pi
         PkBeLe/v1yj7SGfbOU7Fdnd/7Sw9pamtVq1MrnKKdwfB5mh/FQSQv1yS1oWwWbYyH0n5
         fbls95vzKGLi+0ql1bi4QoQrtpIHgAUK9YiX84X7in7sfWOQIULFD5iHaw0EYLnI+eRI
         CaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401136; x=1768005936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iWgbGYobkvaFSQnhmymI3uWpc8/0KXyANTacEmbRQf4=;
        b=VbaNA++bHYAqyqNea37L+ZyXnculGKQUdRyntjnEDFC8wJshirWIDi/tbpiMDPyaZh
         +qEvfmAdmploRM9v5uUfNRjo0uyHj2ohVp0Aoxb1ucRmft/NOUsn64v+ke08pkszW+kb
         7rxjvOJCnoA1/veMds6+Bbks5lS+wg6yQYFxmOdD+al1o4h+kI//hOyvL1UmmNfKvryA
         C4zsxKKCjGcgY1efls1eLbG/HY11/hBszx4XjzPaBox1EQwFzrmHgON2ao3+EnC9vLlV
         OaAw7hHhE2mLExP+Q8zPrL0r//PSVF7HofOiyPZ9XGWHV7B6rkyGlI35SzxTACNznRXe
         498g==
X-Forwarded-Encrypted: i=1; AJvYcCWce02/+UoAKKH4mFD2Joi/WMm98lqE1FN7XSNGR1tWBxjf4nQPexoJ5NjTwKQAm2EwUsu6QakZ2Dd1LLwvmAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWSCxLsu0diRe0BOnukU2B2sCTKjVn5h3/4KoWaJ1o+AdvZ47l
	y+LQpvDTdJ/qwJWnUkUwy3vJeyH66vCKYd3H09TJfJMZRIS6HLTiUV1Mh+82lbzehzN5syYefak
	jPUnwnrBuZEreRe9mhuyVSjidrzhvqEHy9W+W
X-Gm-Gg: AY/fxX78z76TsnTQiA79yD4AylvLvc/LHa00LdK0t1hgukV6ZsqnBT3mJp/EOrN5npE
	MsLCAxWBSP2UuFNbVDSP6fWf7lzblAR0snowNPE1Nu4sk7F39EAz/XBlteKo2h8dlB+EDWUCN5F
	2LSW/7k7B/aXY4eMBaeYm/QvY8ZtdHxnhSBvxvfcU+Et4HgsRMqfNIhrFGQE765ZkAYAGhYYJol
	ZhrzOojR+ocd0xjm7QcHZVAWG5r7qUEuazaQRKRCBqEkIf98SDIegnRXNwam2/u3qiQ8DY9GM4K
	r996DySoPyjEEGsupJGhCrvPCPYeG098wsTYjq4kPWmBeNzuIWtzWhs1nQEX8r5tvbSEquisXSA
	zWf5wjKpaF6xoOgt6J7za35UfSqA2CDlyFWQTGbDG7g==
X-Google-Smtp-Source: AGHT+IHZAEUm+/KeaPlAJWYHKmwK/cOEr0PXHOPV39yt/7DICLsrzO1LLXoP+OqMGQtK5PSI2eAnQ5E7NUpW
X-Received: by 2002:a05:6214:2685:b0:88a:51ff:6054 with SMTP id 6a1803df08f44-88d82718069mr532303876d6.0.1767401135942;
        Fri, 02 Jan 2026 16:45:35 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88d94fcba36sm56013476d6.4.2026.01.02.16.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:35 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1AF84341C73;
	Fri,  2 Jan 2026 17:45:35 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 198D3E4426F; Fri,  2 Jan 2026 17:45:35 -0700 (MST)
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
Subject: [PATCH v2 19/19] selftests: ublk: add end-to-end integrity test
Date: Fri,  2 Jan 2026 17:45:29 -0700
Message-ID: <20260103004529.1582405-20-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
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


