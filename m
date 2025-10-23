Return-Path: <linux-kselftest+bounces-43831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C91BFEC96
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 03:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA6294EAC02
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB077252292;
	Thu, 23 Oct 2025 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El1/f/6/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B88F228CB0
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181234; cv=none; b=r3F+KxZuV51ZwCAAfOwKbb/n0OjOesBM6/oeIIQ3jA+adcO8CKAyLdFzQ1hAKaLQFkVWQE6khKag2SEkyBww+G1nB4MsMkB6vc0rKaVweZaUfTnokvTgvfo3dBeK6LQ9rEcEUurZOYyJlUh/0eNVdjjKgzQqPysCZDFp0WkkLnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181234; c=relaxed/simple;
	bh=2VNGM+ga5+4lCYxn8srmIsIAGhhW4pu5Ux2Lzg8IB3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XRTNoeBo/wP2fUHuAcRs/MN4GnmEDIgpTfvg2QLcGjqTQYTJ9AqXNwIwBP6M9E5G81NT4BJMT+xPGNVyiJNVQRIAg1B7CN7tmkPB+Kzmcv8QWYA8LZ1CXzMHEy5HBS+fcvtRgMKBWUcW/67T94l6k3qdlk2r5tmivkTih6vIak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El1/f/6/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33be037cf73so256089a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 18:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181231; x=1761786031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vj6nuzkY1lA64LuLbEa1jW/rmfdvccJ8fRwNCahhULY=;
        b=El1/f/6/OI3b5aTOLrzoZ4iyO1kqu94o5MvF253BFVSKNjd5v5NWlktZcORp5ZsQv2
         XrTgGSE+WXiRbi4fGGlhG+j7W7Mn7EXn9oGg1WVsn/pd9OmycV3AGOrWZbhjT7ewamRd
         Wziek7GAGgQu488ac+3J/c1ruAfUDjPTOT6F8pmKGssir1yx7TG3NxAZpn+TRFajasR8
         HyIqbVbRIQ5Fj2nlL7KcL3K55fOwUykkki78gwMF70tFqPEi2tsr34G08kIKrId9pfcg
         fIIjM80w8I7POvnPxee82O20tUk759gGHOvDJ9zCeFb4viA031FqQUrfvzgr91AFaaOF
         SaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181231; x=1761786031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj6nuzkY1lA64LuLbEa1jW/rmfdvccJ8fRwNCahhULY=;
        b=fD7cwNkMvklMFIOTVVjnrJ86z2yJG3T2Rax8UCvxdoXRmStCW4nMaKJ+WdANWocz9G
         ySq8rnGXVJLBbbRsJnn+rjib9sNasnqbLf9SpxMCfuRJ8eUkXT5CtlYpcLvs5v6YThRK
         A+Alrzz1teUheILVmThptBsmt4jk0O+FMbwd6Z/eQ5V+GpEYEzTArx/AZ2rbsJMV86H2
         xNNeIfVFKIQbZtf2egRxTzoL0q7n/1kagTz7qwRdaSnwR/W3aBkOeaKyCqh7L4ePjvMi
         88TVLhzVBv+rFspB4al+I8rTr2fwOEclLrMRzLA1e+FY/5tsfNEbAav4Tg7thXLoxGmV
         AU2w==
X-Forwarded-Encrypted: i=1; AJvYcCVDzvFEcBOUB8UYEusfwKR9dEp01J26ShHZzAMVYz1PEkjS2Drv7q2VxXygRdIwBGpoTTQVb8X9YaDbY/rjAIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPIK93jZXuIl868XDSnlSj6CymqWJV+JP3nbA8DpyPIqEVqCRk
	CDwW0uVYTDB5G0NdJ5+DNCjY9bBlgvUVATpBIvMUQvasgphVn2Iwu2AW
X-Gm-Gg: ASbGnctv2IUS37afEzqHL3jAqfg914F2dgEA9dydURSCfEAt7sjMajtGo4tFw1qqk6W
	GHh/dxF9yXtUaGnFCh80tSA2faH+RhqUuesl7H2dfhUA3ItEthgpdW61SkHJle11mjx9UZiWi9S
	ik+f+gmKw4GxMaKz3kdwdQ5JLvE2+gjfr6vtYHlvsApiVFbaLTomulclBHMeFOSxL+gbEHPSc7T
	lmOlHxIch653JtCRSXpculDlgkFYbnemyDQGbCJGBHXCiV2zLlnLJcTV+RGkrA2cyDTa2WHJlBV
	u3/eLUBDuR5nxK6I6w5irks/B/X6Tml8rLrO+J5noxhC4GdV2IDt4OBk1WKXpzWd6FuUe2QSp6R
	KBvd1LPfQOGSNCLpxay37xxEvQVLLOYVmOlpYoCYselO9opnTSHYax/nlqbqegpE33zk5+VSi1L
	3UiyxLg9oy
X-Google-Smtp-Source: AGHT+IGKtTFJtpQ24tkehAeG1F60BvFty13fIYOS2AypXorCFytbWHehPyoCNC+kjaMOPOaFRHtOew==
X-Received: by 2002:a17:90b:2d8f:b0:335:2eee:19dc with SMTP id 98e67ed59e1d1-33bcf8f94b6mr28354305a91.28.1761181231262;
        Wed, 22 Oct 2025 18:00:31 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8adc8sm552212b3a.39.2025.10.22.18.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:30 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:11 -0700
Subject: [PATCH net-next 07/12] selftests/vsock: add check_result() for
 pass/fail counting
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-7-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add check_result() function to reuse logic for incrementing the
pass/fail counters. This function will get used by different callers as
we add different types of tests in future patches (namely, namespace and
non-namespace tests will be called at different places, and re-use this
function).

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 99db2e415253..0957d6a41d08 100755
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
@@ -521,17 +541,7 @@ cnt_total=0
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


