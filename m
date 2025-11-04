Return-Path: <linux-kselftest+bounces-44765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA915C33435
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 23:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF0818C4B0C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 22:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ABB347FFB;
	Tue,  4 Nov 2025 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boJMujHm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962133148BE
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295958; cv=none; b=Lf4BYKG63XXD+ByYYEZ8hnu7OafnYMHjzz6N8C59YPUKfCUlT1qgn8OlLQwOjaiXtbfVMeHBqc20yqSD9PCRWldQXPF60yB2wQgmhjeI+UrhsasXVXR1t5BZoUOsx2+Fsxz0KN3y1l7hqJJiA5lyr1UXe8LS0LtNwSKTCEFbpHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295958; c=relaxed/simple;
	bh=ZD+kE7Km9hitPWcu6/+QvjzHaUtwlQLzQuuF071Kneo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IIpeNp/bc8sAUiK8UflFZMpHe8AzFbHDBddbrN386n4tpjXdE0OkytCTdCb8Z7XvJl25lIEoJWrLhRNrDNUKDj7TQSYPpTOZM9f8VMH+jLAnKciutHZ+iHiTQ2JHpSzdukaLBgCSMDk6PQ6O+i8vR3Ij0f5j1YP72WPV1/ks76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boJMujHm; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b95cdcacd95so2502354a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 14:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295956; x=1762900756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FdVSUjHTikcWcPgapXwx/mSIY+mfI9o+bTGGuyPCvg=;
        b=boJMujHmu6Bt3LKiTEKgcbvVBfY7HcPy5K9KmLyUNkJUwTk265Cmn7PMMtaPVPgvPT
         LvofcFT5lMfzwyGMvdGbYom+GUft2Z5DycWraiGGqDmDXqcsmeG00ItEEmsi0YygeyUX
         wO9z3lMt/h+5S9P4xdTX7fRrmGLeJq3KSS2UdwC2Q2nVx3PcWMrHE9ujSEF0SeLSrX9H
         CeOx97xEPD5sgQOcqL3l0LT8SdNkf2nXZQihKdQRyTHAV7J8oRF/PIm2pXsGMBGtQgbX
         pIQiE1cuoIOxaIdqLsePaij/BsvjVbNTYLUZKaybC2v2zEiMoFTTUJ1qcyXVq8C+REU8
         jW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295956; x=1762900756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FdVSUjHTikcWcPgapXwx/mSIY+mfI9o+bTGGuyPCvg=;
        b=jj6DnqJFqgE7cgBTb4alw7GtUYzaPggh8takETaReJp2Qs0A8NosmP45/lTJH0C/rv
         qwULQE0CGeDbDH4NBioik2nE7CNMl79Rf+i1mDEsKZeof+HZL/4cTSatxqOzVd0yjN6b
         TyeR1h+b5GWh39LQQWa6bjTUYVsj0PtIWXk1i8q3svthN8C4WPQYU4vK/JoujpVCZsxh
         ld0uN2Nk1UzAj3e7d4XgNPUQ3fBnlnJgeT8hWh3VKXipg/n2YNlB1zwRu6fbFX1VQyeT
         ykKWifYQfpF/i7dp7d2k+5YI7/n3s2ydzr2+WiultNwNZ0qq5LUz9mwC2TNSOeVkEDu7
         QF3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVNfkre591qBQoVKn0gSf/KE5cVo886vcloK2wphWHRo5U6PJ00j0tNDquTcAPlq1DwV6q88RQsq1R/BH8O1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxc4W6SbbxV/MRZaoV9gTO85to13OCnOdRidKAVGI1bKe/xIe4
	/877dBHgVowktbnE6SdU68yCNeMU+itubKZCs5Jpzhot64nYRvtJySPU
X-Gm-Gg: ASbGncuY9OEJDicaSv996Vvnov8rVGf1N3N+1i/5tRdt5NMyWBYkCTh73oppY+CBzUG
	z5otQHf8gjE0z2FX0Zq+1UWpks6iIdErA+/6OQSRKIy1JFInkBFhwdJu76AG7VA4NxGbanXMLNW
	IUPjQn7OcPcS4Ui97xcxT5dstM8/jST07T2TD7OFf3Q0Uhvl8ZqEe4NFpaSeX0JZ1GVTRMFeOCj
	9KaICvfn6BSyRzgXrkRyj4OwPv8dJbR2av4NHLNbfd/QWzCBq95mPu5VVIpg9qEAfr26EvNAToL
	XWUdQHbvbOhgWghb3SaP36v4mBlFqLYzi8itewVOeYyoNhi62yjfdnhOmumOTXnt3e+w045HZt1
	d4zCx/sv2p/WEVDGAt9AQhGcGlsUbujy8SH1Wbt4HT7YMcxyCxnUAmzh6GlY7NuitPmrD6KtrnA
	==
X-Google-Smtp-Source: AGHT+IGE2AJdLQ3ih5rbl3nytu4JYVPoufSf2/AeWyCovMJpVIx4Pfkn2JQACMKcx394CGEglGnVnw==
X-Received: by 2002:a17:903:2447:b0:295:b490:94bb with SMTP id d9443c01a7336-2962ae75808mr13019465ad.50.1762295955674;
        Tue, 04 Nov 2025 14:39:15 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998893sm39091575ad.40.2025.11.04.14.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:15 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:57 -0800
Subject: [PATCH net-next v2 07/12] selftests/vsock: add check_result() for
 pass/fail counting
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-7-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add check_result() function to reuse logic for incrementing the
pass/fail counters. This function will get used by different callers as
we add different types of tests in future patches (namely, namespace and
non-namespace tests will be called at different places, and re-use this
function).

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 940e1260de28..4ce93cef32e9 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -78,6 +78,26 @@ die() {
 	exit "${KSFT_FAIL}"
 }
 
+check_result() {
+	local rc num
+
+	rc=$1
+	num=$(( cnt_total + 1 ))
+
+	if [[ ${rc} -eq $KSFT_PASS ]]; then
+		cnt_pass=$(( cnt_pass + 1 ))
+		echo "ok ${num} ${arg}"
+	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
+		cnt_skip=$(( cnt_skip + 1 ))
+		echo "ok ${num} ${arg} # SKIP"
+	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
+		cnt_fail=$(( cnt_fail + 1 ))
+		echo "not ok ${num} ${arg} # exit=$rc"
+	fi
+
+	cnt_total=$(( cnt_total + 1 ))
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -510,17 +530,7 @@ cnt_total=0
 for arg in "${ARGS[@]}"; do
 	run_test "${arg}"
 	rc=$?
-	if [[ ${rc} -eq $KSFT_PASS ]]; then
-		cnt_pass=$(( cnt_pass + 1 ))
-		echo "ok ${cnt_total} ${arg}"
-	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
-		cnt_skip=$(( cnt_skip + 1 ))
-		echo "ok ${cnt_total} ${arg} # SKIP"
-	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
-		cnt_fail=$(( cnt_fail + 1 ))
-		echo "not ok ${cnt_total} ${arg} # exit=$rc"
-	fi
-	cnt_total=$(( cnt_total + 1 ))
+	check_result ${rc}
 done
 
 terminate_pidfiles "${pidfile}"

-- 
2.47.3


