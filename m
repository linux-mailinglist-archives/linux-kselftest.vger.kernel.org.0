Return-Path: <linux-kselftest+bounces-48485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DBED01FE0
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 11:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E430304A13A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 09:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEF642E01E;
	Thu,  8 Jan 2026 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IBc6ctYd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11ED42A597
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864012; cv=none; b=fOmWhizhDpkdPl0G0BIJLhpepM8sO8mGlbDRzS30P4PXiQt2h7KWG6oZwiYMywM9+0chK6/r3hk11oBEZL082sJUlS7k+06VWZnk0zjhxQldf3dY7W+lDSvjLwJsqIMurR8kDJF3n2+16bHYyFO+mNxwNMhAOV8IhjdXncHnph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864012; c=relaxed/simple;
	bh=vOb11bygwdDnihLmz2hie0djJNC8zDTOQroLKsSmtiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbPQGj9qOlww+O6qdtIx3jM1S5MOyf/MWohzg52LZNLvLRYVZupWmIlrg13gYrRhLG22fS3LgD3ltUaP+9FmxvWVd8JK1z1V/KZ/1+IOTMIZLnZwy8zrSNGn515uKPVyIHGVeCrAiIpi3nfWkzC+VeBoGGApJv/83/sBu5Mqzf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IBc6ctYd; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a0f3d2e503so4832955ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863998; x=1768468798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuH+WT2G8DMpBK/C6txHhnJWirSb+AYnJG9ocyYmrqk=;
        b=IBc6ctYd8rGIX4CUjw6nO6JiTP4Ma4b781LErtFLo3UXVOleB4IFEgoeN8H4PrRM20
         tSSAo0/eNUi1S3Q9cYTdZZJSDhSvD9zm7knsjwSkIwAGCQgQjB1/XLqC0raKGOPTBvMO
         0Xdu01LtfgX1vXsC32zSIwrmLfvg9gCGj1pxqiAMuG39xRFxaavLuOXthjobiM7dD24e
         0S+RVGxwd4LNDm5zZ91LDHqf8FCJUy8/n0jwgBz2wkU/uVivb9htvRut9GQ/Qxvky7LX
         skEapTup1u4a19NXVcprEjqbLd1IqZOvdg37UHnZ1YuJVOQ2uQVMJdhgZZ+HCKTXI4BZ
         mZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863998; x=1768468798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RuH+WT2G8DMpBK/C6txHhnJWirSb+AYnJG9ocyYmrqk=;
        b=IkdF/W9Iz56oU89CxHYv11aOnAErgrWCyKZB3gALlmPRm135fl5tIJ4jou2L9dcfYm
         rXP08EFyY7cN313r6cZTDm0eWznenPE9zDqvPoJ/AoebgWHkp+6ljd3MEuJayqvrIIgy
         AsNyFIqPl1oqssrRaXm7msbHhuUpcnUv5i0aZ5P2E727RlH6zbOIAp3Rb5oF0PPaI5zD
         5EsKYByUIEVcMoVHlbzrhp3kuoDknPqpAnkNaIQm78z2OlUB2lYe23p0sxYju/FrecS4
         2pD65FkAV8yokEp4tvLOJQBautTC6F6JsMuzihNUVYxd8yB3AkMOKZR+cGWsQSApKpXN
         oIgg==
X-Forwarded-Encrypted: i=1; AJvYcCUyXYbrtU8J8W61hLzpet1URZNW7D/PFcBmbwQ5UTGhBLsr9/EuZ0Y+K6bDvjvHy/GTbK/k2bpxniUbgNZYYgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq4j1byqGw2ONoFsEaWN89K0z+7UCyJ3i9pcDCg4yvx1LtFBe9
	SgfoISG75/Tus78cJS+O8NUpBX7rer9RqMx6GbmycAVY70A+4N2jHfP0PP99LLhgwzBbcQaK0Hk
	bDkZLhYEUFP1ewEjDI46V/70Hcm8aL7xl5HN/
X-Gm-Gg: AY/fxX4qE8bT0AwrMJ/M6tRZHtiirARi/VXxPCr7EEu6Jzj7sdoB4M+HoX5p9CCW023
	1bK3HKcfiLbPnp0lbC5PjORem9tTx/8XCX6oDUjP3hwjbOjS8kYF4pSC0u50BzJ+oKR0dsZ6xza
	xjrCiesZZ9e2ELA/NegaVDP5zuDeiX9jRhyMYgQv/gTfkj1zvRa2UzYHMTy/nMNsevkBcCdDAz6
	omiohJY3tCeeP3q7rp98SvKxAu2ec0G4GkaVdNPdxS18m3ZqhDGw9MtjoxKJ4lI7idA0A1IT7zE
	sBQRendJgFpBC6srgzBdwdj+tRerqIPMIR1LyzleC/4ZRXQkrJO3yHggy3Itij0E0Q5UbWw8/qh
	VmY5Gl+28jkWnjr0wshdAo2uaFruYAGEgIHSQIkg/hQ==
X-Google-Smtp-Source: AGHT+IEOs/XOT44DOq1NFdbsydAaFizTaagYrcfoSn3FxRvh8uXLSCc6cYkvUq3oW7j65ZN/uciqSxH/t/me
X-Received: by 2002:a17:902:f54e:b0:295:70b1:edd6 with SMTP id d9443c01a7336-2a3ee437ee2mr37881225ad.3.1767863998203;
        Thu, 08 Jan 2026 01:19:58 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cae7f8sm8659355ad.38.2026.01.08.01.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:58 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A172B3400C1;
	Thu,  8 Jan 2026 02:19:57 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9BA4BE42F2C; Thu,  8 Jan 2026 02:19:57 -0700 (MST)
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
Subject: [PATCH v4 18/19] selftests: ublk: add integrity params test
Date: Thu,  8 Jan 2026 02:19:46 -0700
Message-ID: <20260108091948.1099139-19-csander@purestorage.com>
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
index 351ac6438561..239ad1c741ef 100644
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


