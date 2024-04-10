Return-Path: <linux-kselftest+bounces-7616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D897B8A0402
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056991C208E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 23:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36B91CA80;
	Wed, 10 Apr 2024 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xQC5MJhR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177B9383B5
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 23:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791604; cv=none; b=kTZiXcxM0V/SZnhewQ9K0PeS0jA3sigkBUIBk3fjRMWnQVzlEvyou1aWXhoDWSHMWMmw0Qiaq83vCUGn6A33XxqqE3kupCOUQWfj6ZWh4U2WtD0Xtmm38VT+lvWSnz9Tt6UPdRvC7b26a5Or8tVKNVtKLxkdOvVG9AVUkKH7uOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791604; c=relaxed/simple;
	bh=5Uh22vIKOPqTl08nz2cIcEKFa+Ku5iV4cUKiaiK6UwA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kaDpiHYERJcNBhUE81XFOons5vCPaUAYAqktaoONkNg3Z7I0pg5U8xMNJR+XGR5fmC3OkMHZGGPvwL0OIkVZm6p87MqDs709D3h0Aih9qVakCJskICZq7jfpniouoGV1ggiM1KkyswX2fg5En3Hg2ORk0sgcIsQKzHMJU/mSopI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xQC5MJhR; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so9782645276.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 16:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712791602; x=1713396402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7JUe0tFRaoQ0RUO8nlo0bS/Trq4cm4/yvOCnk0PY7Tw=;
        b=xQC5MJhR8h16ucTxDkSCS0kzlCzvIGb4c/lM4x7/hgiNv6msb6mBXrxe3ZnHBB+U1u
         dvHKh132tWkCey+vRuwgAjQhTrM7FP+Sz51ZFvv+5pZ+KHRnO6Fum9SD7CU/EnugHNpX
         p6vc2VNhd/iDFrS5J2ePxqVfBzQU4LJEU3To13fBjQa7vdwVNW0tgNcGCdY/RKM8DycF
         eJjjS+npP5fAMAeCTsGqwSpacmS0jSJ5AuBvAP6e9yZkNcFH0b4KfPwQGpjVn6ztKH97
         y8Iq8d/rZI/ZxoH9U8Jjp54/MNbZc62rXXCIBNF3zf9j/0exPwKotDSOEGV1lJTKG3TG
         n+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712791602; x=1713396402;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7JUe0tFRaoQ0RUO8nlo0bS/Trq4cm4/yvOCnk0PY7Tw=;
        b=HYbRvvbB7JT49Y0tgpAesTkeuw2YY9Ttp864x//EMUNiIBycSp4PIJHDMZxM6HEEHw
         FpAVlmiAsqa7kDo7CRL0vjK+8alvpCteZsrHnjPRMR5vmf4NHPUuX1JYccZoniy4S6R6
         LComDTpfvXm4RLbR7T0flPiS3d8QzVcibGZqMu+giJUo3+CEz9lHWPCrtx6wMqdY/AnT
         HH6bxSO+MeEUbLAket1m+ZkEFVqv0eiT67hJ5WV9kt9rz2SsHEgFVr/oZg1lc+h/4wKn
         WsLU2h2diPKucmWwdXH21AIhJWoRCZa5H6Rh5j556l75ItAHgptgxaBOoTXo/+iUSp2w
         mO9A==
X-Forwarded-Encrypted: i=1; AJvYcCXxXo/+gov1WJe+PabWhJLCqNz0uGwhxfa5p5U2ast3AEX0QevrVMMd71SALhAlhavhU/qLoiwc6kR0bssHLDJ3TFLX82iFVMLgRP6E3DZY
X-Gm-Message-State: AOJu0YwQ4AkMHDNJjI+kf+cnqoBfDvaTY+6BYqMFcxTV8P/pKvX/Yc9b
	wrulczNE87dBKMIfc9DbKmzvj5YQ6pcdv6g1aKflI9KqeYexOvehL9a5y8o0QcNZffHfT+SnGDj
	6S6VC
X-Google-Smtp-Source: AGHT+IHn3qElAk799zrmqQpVWrjI3Xobk90HnjvS6MfZsB7fQ82snexs+qbkA8nn2poKmRJTuL3bOeMuPJfp
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:18ca:b0:dc6:b813:5813 with SMTP
 id ck10-20020a05690218ca00b00dc6b8135813mr358269ybb.9.1712791601994; Wed, 10
 Apr 2024 16:26:41 -0700 (PDT)
Date: Wed, 10 Apr 2024 16:26:28 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240410232637.4135564-1-jstultz@google.com>
Subject: [PATCH 1/3] selftests: timers: Fix posix_timers ksft_print_msg warning
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Shuah Khan <shuah@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, kernel-team@android.com, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

After commit 6d029c25b71f ("selftests/timers/posix_timers:
Reimplement check_timer_distribution()") I started seeing the
following warning building with an older gcc:

posix_timers.c:250:2: warning: format not a string literal and no format arguments [-Wformat-security]
  250 |  ksft_print_msg(errmsg);
      |  ^~~~~~~~~~~~~~

Fix this up by changing it to ksft_print_msg("%s", errmsg)

Cc: Shuah Khan <shuah@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Edward Liaw <edliaw@google.com>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: kernel-team@android.com
Cc: linux-kselftest@vger.kernel.org
Fixes: 6d029c25b71f ("selftests/timers/posix_timers: Reimplement check_timer_distribution()")
Signed-off-by: John Stultz <jstultz@google.com>
---
 tools/testing/selftests/timers/posix_timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index d86a0e00711e..348f47176e0a 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -247,7 +247,7 @@ static int check_timer_distribution(void)
 		ksft_test_result_skip("check signal distribution (old kernel)\n");
 	return 0;
 err:
-	ksft_print_msg(errmsg);
+	ksft_print_msg("%s", errmsg);
 	return -1;
 }
 
-- 
2.44.0.478.gd926399ef9-goog


