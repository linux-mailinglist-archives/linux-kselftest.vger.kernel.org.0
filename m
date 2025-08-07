Return-Path: <linux-kselftest+bounces-38476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9645B1DA6F
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 16:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D7618C7912
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 14:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71976262FFC;
	Thu,  7 Aug 2025 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jG2J7x9K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C97248867
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754578557; cv=none; b=J5RolewD/97qFodVKHh+RzVluc2RHnguPyw2q65yfQc+AmBPcZt/CORuTkTZ3Nuo0aR6AYu6EwE8A/w8bMe4GTnznOxdSRWQ3lj9B3MhSwaOkms6ue6fpQNRff/lA2LxxDwDeDXTHoStRdbioitFmmEL3RIq3+RldO7QYY0RWTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754578557; c=relaxed/simple;
	bh=HzO32Yh60OHiGqCK0y0hof+JHxVfAYcSBiCl3jE4fTs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sGaZGNBbKCzWRwkc4Cd0Z5mFmdYuIZ0XGGRFEG8aOIeNVNzPmks5PvdWFJy+YPCVKKERUkUUjh1Km9U18GNeW9g3AR0SB7FVoQLaOWK1KulZNN75e09cewg1osmIBGztkmxnOTQjvfi++sRWwGGAW0MLTw8ybBC1fMrw+9gJwBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jG2J7x9K; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bca6c73f3so2294147b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754578555; x=1755183355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jcPUX/VYgPTff9JpxJ+KoCMkZRni9WiIzz7CwqMYyyM=;
        b=jG2J7x9Ko6Bl9VJUiMoAP0SksmlsYMO4W4VyqhRyUj8ENEwJNkNqjpDwQet3w1cWRF
         GM1/QyhJ6dYDBy5ISo11QnmLHVJmb4bLKRclnIxdFzQOCY/Pe2dW6fapoFv4yt7U3cxg
         Kpp/o9f2DD2ZNlh/bFvzFiaaygZyzjTvVMEdexEbpoNOC1EYlN8vqlbCgbx8+D4oZr/B
         aurA73yalP+3x+nn7F3cCmdYg7pws0NRAWAv1Qxl3JMY0o5IGIATV+qLD5q+btNLwX60
         FZwnDJD+SzdTyYS/NMC1QSZzn9Qo8uWvKq25RATlaZHh41dO3EsJq9u4sT5jN7SUmIVJ
         RT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754578555; x=1755183355;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jcPUX/VYgPTff9JpxJ+KoCMkZRni9WiIzz7CwqMYyyM=;
        b=l4vFQgpibRRV2hyHWuiAp7ybvi4ukz8V47quyP7a9fvgaEvqZ7PWIGdm9mJdRhbcoZ
         X/jB9RLRN26U3axidsq5A1i8PJqlPVBw7T8rgxUgUih7XzmYrsNposfGHnzRCjmQQQFJ
         kvAEZahtPfa/Lz2Y1aB4KLF43yaClrk5YMUcBhkTQ6oISOBf4uJgK+qSdoMn+JF+wTIv
         0tl7DaNTlzjXEB2bqnCPY6MC+fwjtHDrnbgKO4NHvDlDvbUFDC9bjVTQ1sfrsyMPnnJQ
         0RyRFcY8sROGStXu+MaL/EE618Jj8ZJyQiNdHJT+3H1y7nP9rPpv8h2IAzzJZI4/18rV
         ITwA==
X-Forwarded-Encrypted: i=1; AJvYcCUAZ2iYSFN+bVzFs5rw1cnKkkOdxaiWq4tdeYCsTubTEwssoMl/ThdfQJ+mFS4FE3at6uic4L9VwQBcmakKU9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNetL1S3/JWON+dfiMhr/xkl16OGapmwFkKWG9ufosuo5QSc1
	hSlddj5i1ZmwwBBLqdLgmkzIkDurDnqneN2Pw88NHBcTubv+20TpoPi9Ai1tsdmDJ8bgTbT29kk
	Csg==
X-Google-Smtp-Source: AGHT+IHc4dZo6OEZz4pfAIClf+43hYuDLq9SKAoDuZay4FDjK25R8yRQgDScapgc5Lz+rs0x/IGp+47yZw==
X-Received: from pgbcz7.prod.google.com ([2002:a05:6a02:2307:b0:b42:fe:62e2])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:328c:b0:234:8b24:108d
 with SMTP id adf61e73a8af0-240313b0ec0mr12184119637.22.1754578555276; Thu, 07
 Aug 2025 07:55:55 -0700 (PDT)
Date: Thu,  7 Aug 2025 22:55:50 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250807145550.1837846-1-wakel@google.com>
Subject: [PATCH] selftests/futex: Skip futex_waitv tests if ENOSYS
From: Wake Liu <wakel@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, wakel@google.com
Content-Type: text/plain; charset="UTF-8"

The futex_waitv() syscall was introduced in Linux 5.16. The existing
test in futex_wait_timeout.c will fail on kernels older than 5.16
due to the syscall not being implemented.

Modify the test_timeout() function to check if the error returned
is ENOSYS. If it is, skip the test and report it as such, rather than
failing. This ensures the selftests can be run on a wider range of
kernel versions without false negatives.

Signed-off-by: Wake Liu <wakel@google.com>
---
 .../selftests/futex/functional/futex_wait_timeout.c   | 11 ++++++++---
 .../testing/selftests/futex/functional/futex_waitv.c  |  8 ++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index d183f878360b..323cab339814 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -64,9 +64,14 @@ void *get_pi_lock(void *arg)
 static void test_timeout(int res, int *ret, char *test_name, int err)
 {
 	if (!res || errno != err) {
-		ksft_test_result_fail("%s returned %d\n", test_name,
-				      res < 0 ? errno : res);
-		*ret = RET_FAIL;
+		if (errno == ENOSYS) {
+			ksft_test_result_skip("%s: %s\n",
+					      test_name, strerror(errno));
+		} else {
+			ksft_test_result_fail("%s returned %d\n", test_name,
+					      res < 0 ? errno : res);
+			*ret = RET_FAIL;
+		}
 	} else {
 		ksft_test_result_pass("%s succeeds\n", test_name);
 	}
diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/testing/selftests/futex/functional/futex_waitv.c
index 034dbfef40cb..2a86fd3ea657 100644
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -59,6 +59,14 @@ void *waiterfn(void *arg)
 
 int main(int argc, char *argv[])
 {
+	if (!ksft_min_kernel_version(5, 16)) {
+		ksft_print_header();
+		ksft_set_plan(0);
+		ksft_print_msg("%s: FUTEX_WAITV not implemented until 5.16\n",
+			       basename(argv[0]));
+		ksft_print_cnts();
+		return KSFT_SKIP;
+	}
 	pthread_t waiter;
 	int res, ret = RET_PASS;
 	struct timespec to;
-- 
2.50.1.703.g449372360f-goog


