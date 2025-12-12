Return-Path: <linux-kselftest+bounces-47515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE316CB96A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 18:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BDB83035A51
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 17:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C62C2D7DFE;
	Fri, 12 Dec 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="B3bH8foP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27FE2D6E53
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765559832; cv=none; b=BfkoTcbnde9x2CeXzm5m7pGkejg3ywlGWJxI+LNeJ0UUppdH+IfSqOAF5B1S/fl8xsrpqqvn6KIZsr18amODKTAvnWZRxNkgGmOrcyyNlJU6Fy3/75/b1JRXiZf6g8K/iIq1zOMxJV+cl35GgRlkCEclEu7HBaNJYx6L3lShm94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765559832; c=relaxed/simple;
	bh=+cVia0YqFLhrPDWq9CwKaca7IitMDAWFURSGq1uOQdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGSlEzeVZ0T3muhizrqHdSUoBcnJ5f183d9FFyyFjLuG+r74ITPl6TZFHJ3jw/7zGW8duhhxomWmv5TtVGY+E9HYJ+f38Kz3WxFYzi4uPmOCVdiSTmAoKX19R8wlodWghl8UqpupIN9pwst5U/r64UdwNr/iLpeaqQ+l8G9ZETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=B3bH8foP; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-7c32c6eb79dso74469b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 09:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765559830; x=1766164630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NOEIyKTQ4B6JXoSeSWaOQfr++6G02m3bohInlhRqug=;
        b=B3bH8foPO+ABH5T9yflbvxpzwPNzv9sx0BXlHcMGxjexlzLql/byvG6zMYrwbVo40E
         bP/g5xEF3EhHeeR6jdU9FLxzmIs0ZjJuUoemdKiE8qaU1+IssDeDY3fNHCp5I4vhabgs
         6UCVOC6/Mila12ivRHLmev+9CvDoRFHnImQz7nmpcyWoK6MTyXjhfBi+jNesHcGlP/3W
         HKjkzQMmFA5/BGjnJ3oU19qbuL+DEOY9EqgO6UFMyDFZi6MfG3fmQ/1Iet2N03AXYZCF
         XWkB/7596UJYyhZwuCTqTRVu1J9h5kx1G4+S3wVVGglXUkjzUD10NF46+uTfD1sqmp0o
         o31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765559830; x=1766164630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NOEIyKTQ4B6JXoSeSWaOQfr++6G02m3bohInlhRqug=;
        b=RurwguRiULXAgqC74iK14C99dcy8MChdbnqooTAqKKb6pz7kiAMhWst7wCaratmgQU
         s6tiHa6DxCXeTaFORnY+zCRtC3R3H7/cMdoW/aqOHeGs8vFEKdija73ZBrH+34gowyG5
         lQolMTbQWvvPRkzmxuxUVjIsAdl6Jqy0kgtY0MlHeg5aB2xsDrWnx7YcNRhDySQ4SUQI
         ph/rSmk7NFwKNUMEwWfEXvWZyRVstVKe9EMrr7xrMnr3HM7K4mY3I+pw7EfZqVkIygmg
         XORI4ioOPZ8S4FerC9l4UbKA9SWvB6Waw5frTUiBlXRSG7h4+sZ6UK74Gq9Kw/M9JNpv
         BS0A==
X-Forwarded-Encrypted: i=1; AJvYcCUbD2dRS6eFtjgF8cSLeQ9y0lg9BqW/pl+8uQ86zFA0rBH43uOycpRLTrSBihbJqqd+QmoGhrpaUbultCWIdTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdJW/r1m9ExM7WLxbKeP/Fq8ursBz5nY1FwkAEXGJWq9ZHE5zp
	30LMSm1PSOvuxj3LamhR+gsZZcvolMhvwq5DRi+MKtL9NKnMNVdu8ftfflev/exk9uu0Vk9bJat
	W//PTywp9AmhlgST3sCX91K4rzUsnpklaviCv
X-Gm-Gg: AY/fxX7YvJ00PTFu5YnZ7gHHrifqVsdw5aCePYNUKpMEcctIWMRYJLa5cW/gmpD5Uz3
	UahiRWIAc2q7WSbWRTPrPMF2hrgzRBkH7UOVwcqE9xHqXC6HVmYz5DxbBHMbEtDC8Uo8Mv3yjyA
	remYhBfCgYP7jEIxL5BSRMtcvvQ0g7WWecPjpCX89Y6CODobbeoS6WbUPDVri50laFJCKrKLIxU
	4wDGjhBdu0+PqHYe++u34x+dV4iDpkNHi4ckdC4Qp0aN8dcVK7QN3VB6xaNyBaKzOhueL88/0XM
	DD1F+RtR8FFAYEt/4tK7DEqSu64qffAizrTOwsyPA0NXCSOq2sIhIahWmI5Uyw8tSA4PDzWFUM2
	bLQAmvbpKBNfmiUxdZ/XjK8z/ZY8xy5enrfoNzUFbYQ==
X-Google-Smtp-Source: AGHT+IHpDdHBoJHEFtsw5G8Q+oXhxmWs0OnZKWDZwJIWo8p+KqoHWDCCol6UB04IZ7qsvhQ8mmu9137r4gnv
X-Received: by 2002:a05:6a00:234c:b0:7a2:855f:f88b with SMTP id d2e1a72fcca58-7f668dc54a6mr2346324b3a.3.1765559830118;
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7f4c276f23csm831520b3a.3.2025.12.12.09.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8532A3407A6;
	Fri, 12 Dec 2025 10:17:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8337FE4232B; Fri, 12 Dec 2025 10:17:09 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 4/9] selftests: ublk: fix fio arguments in run_io_and_recover()
Date: Fri, 12 Dec 2025 10:17:02 -0700
Message-ID: <20251212171707.1876250-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212171707.1876250-1-csander@purestorage.com>
References: <20251212171707.1876250-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

run_io_and_recover() invokes fio with --size="${size}", but the variable
size doesn't exist. Thus, the argument expands to --size=, which causes
fio to exit immediately with an error without issuing any I/O. Pass the
value for size as the first argument to the function.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh     | 5 +++--
 tools/testing/selftests/ublk/test_generic_04.sh | 2 +-
 tools/testing/selftests/ublk/test_generic_05.sh | 2 +-
 tools/testing/selftests/ublk/test_generic_11.sh | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 8a4dbd09feb0..6f1c042de40e 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -331,15 +331,16 @@ run_io_and_kill_daemon()
 	fi
 }
 
 run_io_and_recover()
 {
-	local action=$1
+	local size=$1
+	local action=$2
 	local state
 	local dev_id
 
-	shift 1
+	shift 2
 	dev_id=$(_add_ublk_dev "$@")
 	_check_add_dev "$TID" $?
 
 	fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio \
 		--rw=randread --iodepth=256 --size="${size}" --numjobs=4 \
diff --git a/tools/testing/selftests/ublk/test_generic_04.sh b/tools/testing/selftests/ublk/test_generic_04.sh
index 8b533217d4a1..baf5b156193d 100755
--- a/tools/testing/selftests/ublk/test_generic_04.sh
+++ b/tools/testing/selftests/ublk/test_generic_04.sh
@@ -6,11 +6,11 @@
 TID="generic_04"
 ERR_CODE=0
 
 ublk_run_recover_test()
 {
-	run_io_and_recover "kill_daemon" "$@"
+	run_io_and_recover 256M "kill_daemon" "$@"
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
 		_show_result $TID $ERR_CODE
 	fi
diff --git a/tools/testing/selftests/ublk/test_generic_05.sh b/tools/testing/selftests/ublk/test_generic_05.sh
index 398e9e2b58e1..7b5083afc02a 100755
--- a/tools/testing/selftests/ublk/test_generic_05.sh
+++ b/tools/testing/selftests/ublk/test_generic_05.sh
@@ -6,11 +6,11 @@
 TID="generic_05"
 ERR_CODE=0
 
 ublk_run_recover_test()
 {
-	run_io_and_recover "kill_daemon" "$@"
+	run_io_and_recover 256M "kill_daemon" "$@"
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
 		_show_result $TID $ERR_CODE
 	fi
diff --git a/tools/testing/selftests/ublk/test_generic_11.sh b/tools/testing/selftests/ublk/test_generic_11.sh
index a00357a5ec6b..d1f973c8c645 100755
--- a/tools/testing/selftests/ublk/test_generic_11.sh
+++ b/tools/testing/selftests/ublk/test_generic_11.sh
@@ -6,11 +6,11 @@
 TID="generic_11"
 ERR_CODE=0
 
 ublk_run_quiesce_recover()
 {
-	run_io_and_recover "quiesce_dev" "$@"
+	run_io_and_recover 256M "quiesce_dev" "$@"
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
 		_show_result $TID $ERR_CODE
 	fi
-- 
2.45.2


