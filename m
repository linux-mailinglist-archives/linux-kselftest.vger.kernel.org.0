Return-Path: <linux-kselftest+bounces-38625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB84B1F346
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 10:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 952227B394B
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 08:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C92E1F583D;
	Sat,  9 Aug 2025 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8McxVus"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A318BBB9
	for <linux-kselftest@vger.kernel.org>; Sat,  9 Aug 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754728357; cv=none; b=kknUa8WSZKG3PQNeW6lUGnQIu8mjpO05OHSrTY3AJAZka45bBgash2hjmO2yzBaWRLsQ5eNUt4wXIxDGJzV7wkjW978kHx9QXsmfF/nvGg4x+KIiE6H55ojV/YjoGbITOWg9wz5mZJkhRPe7I0Lq5F+vMOL0IEGMXGqdrrfMGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754728357; c=relaxed/simple;
	bh=k1DVeL1f1UhLNfkqO5ZKFormbjFilw7LsKOmGZEgmlI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K90iwbboObdD+VsMKagVhkksg659qKDDZYcpB9//qX7h1Dz3/5SEfKb7fvDCyuQ0CGQ2xWgcExrbDfRhpXju+4pGhuE99y3b6KhyCEwGCPUFReRwYpyAzFXUY+D1AWF62dUZuSK+s4PuYnwpWIFW2AFB95O4/UEPXgU+bOB06z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8McxVus; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bf30ca667so5472577b3a.1
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Aug 2025 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754728355; x=1755333155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bwjbob3BQMKF4UEPhqbfbZc9QrWDX+0Z77IxKZ5IcFY=;
        b=I8McxVusaHIVVksqQ02uA8HY3Od2oSUA//OY1RKHcRekiQchxARBxRC+cjmWaHEGmj
         yJM/zn0O82nZJppMABhlFgFkBIiPdyQYUo8IoPclCRBQPYRurW+cMaODO9wvyASJDyQi
         6R7tsbC7nv0c6eGGBWvhMYxu63WItIJk8PIYPaIGSnkhAgxwtQDQNxBt4h51NH+BX2iN
         YtQ1uSDjfMj74sh86umM6yoHXPZSEDDTF0optCwizLOEXCy0n0avu7m8tjQv82V00mmj
         0NIHNT1CUQ8iBRuuuGcFQgPtFu+QcdkRTpPJSH2iTvcMWrgmQwIwyG+YP85rFfVjKcxM
         4xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754728355; x=1755333155;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bwjbob3BQMKF4UEPhqbfbZc9QrWDX+0Z77IxKZ5IcFY=;
        b=lyUIKzB3fSPy525FgRV3/3WWnSIdL/nGhEUDt34W02X6la3atmTFEAVzFjNjd6hv/l
         2JXLiGgiEktJ1YYppq13ChQ/71mhCd0n8MIvxORTBQi4lxUb3j0b/1epLFiAV6kDCZ9f
         bkcIRapS9nWvfakRTHrUJgz36qdlkHj0ciJU5+xC9MN52xGywABlNSO7iuFqOjo9a/7R
         bB4Y1IW0nVd6jfZ+dMKzrYvklYT6YlcSnCGOOreX7D45KBNqCVXbjTWL8pbEjLX3f7cF
         1V3zMtSjFqZsZ/orl4Hm+HRnrO2UcqKXfoc9KY9bhZbMukmIFxWuHCBHwRU5/X7s+fE4
         AEDw==
X-Forwarded-Encrypted: i=1; AJvYcCW9aBSFId1LiOmyNba3Q+Q09116TrcHm516Dg1JG2LYjOztkgEGdAHMghRXBcMAVIbo2MNwcTV40c3FdxxgEz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0cKrGfg05ydUGWa42rz4e8yU0v97NjcNjkDz/Il9CJCsw/yJi
	44z89AKBCopvRYFxAhkMKZH6PZZm280zCN/qtaX7upYgExwlDWZCHzO1KQgOnYxEYf8Eki264T9
	Pvg==
X-Google-Smtp-Source: AGHT+IFHwJeuLroag34qeDXclC4fMzhy/RI0hddE38yCwL8myoAMsSukXfOcUVvtuHRq1vdM4L0yBnYYiQ==
X-Received: from pfhx41.prod.google.com ([2002:a05:6a00:18a9:b0:748:f4a1:ae2e])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:cd2:b0:76b:d791:42e5
 with SMTP id d2e1a72fcca58-76c46184b5amr8068166b3a.17.1754728354998; Sat, 09
 Aug 2025 01:32:34 -0700 (PDT)
Date: Sat,  9 Aug 2025 16:32:29 +0800
In-Reply-To: <11620764-a95a-40dc-97be-ba6a9a39e71c@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <11620764-a95a-40dc-97be-ba6a9a39e71c@igalia.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250809083229.2444507-1-wakel@google.com>
Subject: [PATCH v2] selftests/futex: Skip futex_waitv tests if ENOSYS
From: Wake Liu <wakel@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Shuah Khan <shuah@kernel.org>, Wake Liu <wakel@google.com>, 
	Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The futex_waitv() syscall was introduced in Linux 5.16. The existing
test in futex_wait_timeout.c will fail on kernels older than 5.16
due to the syscall not being implemented.

Modify the test_timeout() function to check if the error returned
is ENOSYS. If it is, skip the test and report it as such, rather than
failing. This ensures the selftests can be run on a wider range of
kernel versions without false negatives.

Signed-off-by: Wake Liu <wakel@google.com>
---
+V1 -> V2:
+- Addressed review comments from Andr=C3=A9 Almeida.
+- Applied ENOSYS check to futex_wait_wouldblock.c as well.
---
 .../selftests/futex/functional/futex_wait_timeout.c  | 10 +++++++---
 .../futex/functional/futex_wait_wouldblock.c         | 12 ++++++++----
 .../testing/selftests/futex/functional/futex_waitv.c |  8 ++++++++
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c =
b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index d183f878360b..8a48cf5d235f 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -64,9 +64,13 @@ void *get_pi_lock(void *arg)
 static void test_timeout(int res, int *ret, char *test_name, int err)
 {
 	if (!res || errno !=3D err) {
-		ksft_test_result_fail("%s returned %d\n", test_name,
-				      res < 0 ? errno : res);
-		*ret =3D RET_FAIL;
+		if (errno =3D=3D ENOSYS) {
+			ksft_test_result_skip("%s: %m\n", test_name);
+		} else {
+			ksft_test_result_fail("%s returned %d\n", test_name,
+					      res < 0 ? errno : res);
+			*ret =3D RET_FAIL;
+		}
 	} else {
 		ksft_test_result_pass("%s succeeds\n", test_name);
 	}
diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblock=
.c b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index 2d8230da9064..5e85ebb33e62 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -98,10 +98,14 @@ int main(int argc, char *argv[])
 	info("Calling futex_waitv on f1: %u @ %p with val=3D%u\n", f1, &f1, f1+1)=
;
 	res =3D futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
 	if (!res || errno !=3D EWOULDBLOCK) {
-		ksft_test_result_fail("futex_waitv returned: %d %s\n",
-				      res ? errno : res,
-				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
+		if (errno =3D=3D ENOSYS) {
+			ksft_test_result_skip("futex_waitv: %m\n");
+		} else {
+			ksft_test_result_fail("futex_waitv returned: %d %s\n",
+					      res ? errno : res,
+					      res ? strerror(errno) : "");
+			ret =3D RET_FAIL;
+		}
 	} else {
 		ksft_test_result_pass("futex_waitv\n");
 	}
diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools=
/testing/selftests/futex/functional/futex_waitv.c
index a94337f677e1..84eec26910bb 100644
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -59,6 +59,14 @@ void *waiterfn(void *arg)
=20
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
 	int res, ret =3D RET_PASS;
 	struct timespec to;
--=20
2.50.1.703.g449372360f-goog


