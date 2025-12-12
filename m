Return-Path: <linux-kselftest+bounces-47520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BADD9CB96AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 18:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8FF230177B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 17:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FEA2E54B2;
	Fri, 12 Dec 2025 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="K6Raha8E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A92D7DF4
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765559835; cv=none; b=LP9UEiE1rMnbUnzD9Mad5eD2nuc7LnzgPO01txqtKSFJh9QdKaz2bsQx9qPt5wEStA5/TS8p9dxkysTRfUI4mAXIqWPdQexWJrhToLACfwe+vrOCGdxGFRpGIycm7FU0/zlYsTo+Edhh7lbs/6jrP8sRVFS0i1B0Mphbw14KvPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765559835; c=relaxed/simple;
	bh=YPuVcHbnYS22d6hiURGBWQR+n+8hL0om5JxsTfAyHEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adG6nzI1khZktLUQ1Pz3l60kY9+uT/j9Iv8CxBbWDjyX94PKXoxn+9ocHPmVbQAZoZkde1aw/GH5H8r3tjC1mgzFA6eyMwnX+Dn7JOGFI3ADoDpBwlkwLhWait/qwT/gu47WI/baXQs/19Ya6cxgIaICKgfMvVSuPEDwXcTD+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=K6Raha8E; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7cad1c329e1so98475a34.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 09:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765559831; x=1766164631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N5v+Qnf2iY02nSmpCLdO2pcb5orICXH1PEBjkRChjU=;
        b=K6Raha8E3H6nbXlSquauYF9TLp5zzyc7PVPuiq7LbOalWe89nvNAzW1CEPjveCFftu
         zsqf2vwKZ+0C7ht5yzv4LhhliV+LVI/K3TxGfSjan0xB+wY/VKlJx9dsz5ixKmg9I2nl
         xPgXf+0BG9NMJjTHVyW9oU4GQKPVZ+UVmVfhN2t/tRnmrvbwxOjgzTAEscGThLdRcmrz
         v+ZVTFKLsdCIl6Tv/06qqS990ppNY3EQLT9M9opgAsE7SrFMkwDr8oF4BRjBUNzJrVXT
         M6Ls/bcGBFYISVAWyL1L34e+m16ZgRM1Oot0vC3IHc3TvWRwZn/FeWIN7TLhJEIxBXmY
         ry5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765559831; x=1766164631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0N5v+Qnf2iY02nSmpCLdO2pcb5orICXH1PEBjkRChjU=;
        b=t7eXiVAF1wIgMkc8+EruZKNL9Szq0+DSyFMrg2RyxrzC1OSB4kjtSSUqKxIPv6kLRJ
         xXt5vdCPHr94X+XDYcMRVLLEav/fCkx4WFiJfNC3sL3CnjoYQfijadF1MXhRhMw8FZba
         Hzv1TqcEsZXs/8CxRcmQfoqg33UuEqhIs6dBgRVbJF9xJIdZrDeShNlzQcXJVHGmwz+q
         4Bph7v5bidHbjR+O/p7rcTKiO/sm2EF/Ix4VKITfSXmXEgEWOXeqDx9vCOULh5f9nUvV
         MDx8XIbkOiGu/zSUpV2iSyuHT3a/sEQlpstlLyECVPoQyCWJAzQuob0b+DJVXlXQrwUB
         /kNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOYzi5/K/NcQLhHpNo1EL1C5zxihMyIfUZtix9rJAkdMUHnqjScNh1QanXXIxiThDqYrbbmozecgSOCzQceq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykO3moq0ShszGUg7oZDMzeJ8Idxz2OUBt0YXHU2fTBhoXswc6q
	9YyYZW7tfjydaRIRgXWO35FCBDm77iE3okvVMsOvZfn3jUVdsuHVVcSWLXo2uVLur2xELxWDez7
	/aICDHFezz+vpyFWyLHBOJ7H6nELUf/amgd7v
X-Gm-Gg: AY/fxX67BKhThAs/dSiiBn2UEGRaMej+y4xRPvMssbSh8QV2BN17r+TgLRfy8DiXjJN
	uj5FNQ2q0BnMZZF0/kvpScpJPfmR2DfB86Yl3GCnEOEfJR1vpa8sCtlfhyEx+z1cFCsG/TwCQHf
	XwXJx4++6eZsa5tOdZtg5k6Q1sN/XiarEaX1s6eXgFpry8PalWKgdLQAQjG6cF4944mjpez1/WM
	pfDcc1d7GLzLPGUE/skC9cu8gSlxcVNJkI/kro1+FSxBLwwp6qxaWSCbPJRxaN/Hq4Mi8rDuS+9
	LCHk0DlPmZBYrsNmPp62djyrOHRVqiHUUAjeNmo16WmafR3iBuS4YJKvomz4d2/3zh1knCQ69a/
	6kn4o7+lGqUhUpvq6ZW9ZkFeMEzK4EjkJmp2DI1ODQA==
X-Google-Smtp-Source: AGHT+IEBD6jX7Ww+IQHxxqsewOUV0b+S5G2Tpohbpjk+hc1S1mfL5EZowmGcc1H0jPBMIqA1EEmegMce+Lv4
X-Received: by 2002:a05:6870:9a1c:b0:3ec:323e:b5e8 with SMTP id 586e51a60fabf-3f5f8371574mr1362511fac.0.1765559830613;
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3f5fe30cae5sm289656fac.7.2025.12.12.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CA552341BBA;
	Fri, 12 Dec 2025 10:17:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C81ABE4232B; Fri, 12 Dec 2025 10:17:09 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 6/9] selftests: ublk: don't share backing files between ublk servers
Date: Fri, 12 Dec 2025 10:17:04 -0700
Message-ID: <20251212171707.1876250-7-csander@purestorage.com>
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

stress_04 is missing a wait between blocks of tests, meaning multiple
ublk servers will be running in parallel using the same backing files.
Add a wait after each section to ensure each backing file is in use by a
single ublk server at a time.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_stress_04.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index c0c926ce0539..efa8dc33234b 100755
--- a/tools/testing/selftests/ublk/test_stress_04.sh
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -29,23 +29,25 @@ _create_backfile 1 128M
 _create_backfile 2 128M
 
 ublk_io_and_kill_daemon 8G -t null -q 4 -z --no_ublk_fixed_fd &
 ublk_io_and_kill_daemon 256M -t loop -q 4 -z --no_ublk_fixed_fd "${UBLK_BACKFILES[0]}" &
 ublk_io_and_kill_daemon 256M -t stripe -q 4 -z "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
 
 if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc &
 	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
+	wait
 fi
 
 if _have_feature "PER_IO_DAEMON"; then
 	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
 	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
+	wait
 fi
-wait
 
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
-- 
2.45.2


