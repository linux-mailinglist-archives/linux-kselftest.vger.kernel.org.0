Return-Path: <linux-kselftest+bounces-38542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F08D9B1E327
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 09:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90F187A8EEA
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 07:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53370226D04;
	Fri,  8 Aug 2025 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oqxOMYz3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4FB221577
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637348; cv=none; b=J5nR7eY4oAmZlvsMd9RhOFFGSzE4QunYIDUhXdQ3q12BdsvuCijSigIGvq4RyDnr6mdYdXIa8zTKYWZFRtpu2qoPNV5vuu5vVWEg7jRVSPBUpnZ7isN15OZXPmcdMY+/aAYbQEZorhehxrtGGFhuONXDsvnjaUqA0+6b+YT/31U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637348; c=relaxed/simple;
	bh=ASmrmMaSkJvkmKNln9No2+QIjBIVmTkBBgLR/juMZCw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V4BJpUgq1fnPJ4RArHq3/3/mIXypRWpSt4GxPvjqqTM35pkDM7McLY77R9VT1ZxLev2PvPFxMWZX0h5EckBQsCj5iM2VMtQIYAGZj8r7HmWbxA4ZxfrBt1UEa1R28iwbk06ZikTl638fTbZgCGXeyJwJ9oTcQu1ShMVOjgZHhBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oqxOMYz3; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b42a54b7812so383635a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Aug 2025 00:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754637346; x=1755242146; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3F9gUOy2pnJ9oY/QGBIv1m9C3L0DkpYmKEr0a26plgw=;
        b=oqxOMYz3iCnVNOjpCKZPDKpRc/eflJKnoYELihe36uyVQ+mDBVgfCU6vKaZ/+ZYr3T
         rYHqJBsWPCblhY70fLrLyowiPPh59wBptOIFbaqEECbzKo0HrHfItc5e1BvIWqgpKhbz
         LNe5Pj9AoK0hV88iBaUPOyDhQIzE3GkuvLNMO8i3fZzU9IeHWJY6mrGbwdTsR1CmnDL3
         ZR2TuM8Yw6VAp6q/qK9yiujmRGqz11wFpC5VR9wxjB0jD+zQ1actAMKbbHq9YkHNBkx0
         ckO+rV70ll6yQFAPryqChDO8bvSK6XHVReY5z/oZrndwACJmEdlXEbjvlLimtxeP3X8i
         AsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754637346; x=1755242146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3F9gUOy2pnJ9oY/QGBIv1m9C3L0DkpYmKEr0a26plgw=;
        b=TYzrJ6yLHhFsK3lbHmIC74GH7+YLYf56ld3h/ag/EYnGde/wBjuxuwenElkbYsEjXX
         1QwypUT0PiEL75L1OJ8Dmi3avcQBZnBbgL1Cav94Mnt6h4nvS1nGVP/qfXQC1YZ7HXqW
         9jJlOzMpoY7O/FCZ7hO/RlrIW9OAZPAhhSmo1THQWrH+EnI1zjxBGQiepTLiPs/Uucc8
         fkkOvm9xqksN7ef+4/3wkGbsSWuXIlhpEq+0BuXMVwEsanBOm/0jsWacpwMIZfS1EqKg
         CtBxmSb11Pj7A0Zi8FykRCIsV9/5+DVyXlnDAFTkv+ohyHuAhiqX6Toz/B85mWe8SjRm
         GhpA==
X-Forwarded-Encrypted: i=1; AJvYcCUld9J/KPkSA+VIgolOcjZsAgM3YZN5HZViixS860vo8qtrmuc41NMxCUJpPCgrhYLAE7mdBPSAg24bResy07s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlvOVIJBagPXMAInNre/g66Zj3LqJIgTVaBCRiWuODxGf6CXoh
	lsKbE+JvyUGCjB54cR2kimU0OPspXZCmblVjuW5EeRfCACpUJL2b2YXr3IJ8Ym07fJPhMIifJaJ
	6ag==
X-Google-Smtp-Source: AGHT+IHQJ0qyd4BoPgvRMKVVHm80mILibnDe0FalsXDK6EDDsdXNkbWMCbSLvKpkWdgLewvq69rS+H25aQ==
X-Received: from pgbfq1.prod.google.com ([2002:a05:6a02:2981:b0:b42:87c7:df5b])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:258e:b0:240:1d4f:720b
 with SMTP id adf61e73a8af0-240551ad061mr2990006637.23.1754637345935; Fri, 08
 Aug 2025 00:15:45 -0700 (PDT)
Date: Fri,  8 Aug 2025 15:15:40 +0800
In-Reply-To: <20250807145550.1837846-1-wakel@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807145550.1837846-1-wakel@google.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250808071540.2122553-1-wakel@google.com>
Subject: [PATCH v2] selftests/futex: Skip futex_waitv tests if ENOSYS
From: Wake Liu <wakel@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Wake Liu <wakel@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
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
 .../selftests/futex/functional/futex_wait_timeout.c    | 10 +++++++---
 tools/testing/selftests/futex/functional/futex_waitv.c |  8 ++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index d183f878360b..8a48cf5d235f 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -64,9 +64,13 @@ void *get_pi_lock(void *arg)
 static void test_timeout(int res, int *ret, char *test_name, int err)
 {
 	if (!res || errno != err) {
-		ksft_test_result_fail("%s returned %d\n", test_name,
-				      res < 0 ? errno : res);
-		*ret = RET_FAIL;
+		if (errno == ENOSYS) {
+			ksft_test_result_skip("%s: %m\n", test_name);
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


