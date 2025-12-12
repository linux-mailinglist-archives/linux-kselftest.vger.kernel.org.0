Return-Path: <linux-kselftest+bounces-47486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53261CB7ECD
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 06:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A59F3061EB8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 05:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A1C30E820;
	Fri, 12 Dec 2025 05:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Jk4PtFN3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com [209.85.167.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE1B275870
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 05:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516630; cv=none; b=ozHzXV5B8F2pKBJgX4YKV3b0rSjQ9Qippbz8730LmFFszsViR0GhG8PkLSyVUedrh9S1IB2ppVXv4sXs2E6+ON/6YODKcNhcj1daC9qUs17bPqCH3fwKO/Gmm0Vz9HmwDbDCpWfi/PFXJv5SmQxPQ4B53iRPwDQ7gcKqWnmSkOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516630; c=relaxed/simple;
	bh=FKbZngLfGMe4F0ejdKJ0fZ6ILmuYiVZnIW21hOqoFMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdV5QSIVNEu8yIamNeWDetWaaU4+z33HW+pydpEQQr8as9/JoOexapH0lUV8xPqJ/6UFVsNf1ZMjE94Z8BMd12ewME+9kNR/ezIAvL/wtlknnFUr297rooD8xrrnEtdPvN0/CTWX1MX8PZtcqKSrYf/nrFUDTMwPMA1lSjDIHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Jk4PtFN3; arc=none smtp.client-ip=209.85.167.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lf1-f100.google.com with SMTP id 2adb3069b0e04-597c366f2feso52999e87.3
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 21:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765516625; x=1766121425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYMmhxte6MTatk0mD4pdp1WR7i9P7+V+tQDFdQu1wO4=;
        b=Jk4PtFN3GvnPuzWi8qP9AoU2rQyqhyOyf906j1oe4pSifzdFm76c7ffZXWw3W+uaQM
         O4QzqFJNuh1177inOF9opDLSkNQ1xkDzeizPRuC2fZ4R52CnDADOR4XKIJmIMzE39v18
         hLLtCa56f1uqGUL77SAxYl64Wo8yCgzmONh5mLZNMI5Zelqc+Oo7rPmDIt+KD9hm0LZb
         PuZkjzUp7sA/PKaLKDyGARS1g3xkdKPqmalVf+8DCkEDj1H+/dEq6l1NVmOhKwFgmvkC
         1LBzxdSPnCmWFmEO9QjxCTwihchuZ8u8pQCKY1AGNFXlLpRwFLO3ekGioKr16hPyXx7r
         EXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516625; x=1766121425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYMmhxte6MTatk0mD4pdp1WR7i9P7+V+tQDFdQu1wO4=;
        b=JLA5plQssapHQwdkNfQcgWiBde26aOaDasCSSmwGlrFjaDfphTFFF2qyOzU8/HC8Qs
         dZXS6K90Kdz18FFo7NO8hGLXd5ZzBXnZt3zvg5GOQ7Crhil+QtMwZwiZ/x4XP1eEcn+L
         JQrw3RYAQOURzHWSIaK/mdBTh4E7Vli+hT0/owRhSjNkYTg4QqYk5iSxMiInU0tJ7eXe
         YWQuXrV197I5qYA7+zFLXvqXEZSoeaf6Od9WTOrR+ZlmkpBhEK/q1EnwU0V2CdtAjUCL
         WLVqVk7oTESJNKSI9GswhdNk8ASiokgTAE8JFxHCyPVlub77Iuo0KrrTDeC6u72yw6ig
         jxaA==
X-Forwarded-Encrypted: i=1; AJvYcCXlaLoy3yKLFqKz2YYlfc7vtBi6e2p/qniiNBBbX4li79YUqsshIBuh75K8bLc83QF2l9ICXBqbY9mJFEUAqy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEbjZAl0O+3+DcR0XpAXQlrD2bUcQmvZVC1nlGFBgnmPEnPM8o
	yoOlkCJOCyCMJZ6rS3SV7Kt9yBFO/whK5FsXwjEJ9fPNu4uJ2awkdG7Pmap1WOd5SJIQ6dhCIAm
	UiQCeVn2P4ktQq26UnU0SQfUb+P8Q1Oq3MT8lH/+hKwtcfnR0gQoS
X-Gm-Gg: AY/fxX5HwqNfXcePlQQP4owPXcNPC+HSN1DtVT+uvOxVqqzdFs/htfcwVP2aTVwhniu
	e1yk8G07P9o/m59oVDo7Px8/pHyzVNJRBjIiFQVpKuB+s1hKpVZ0ynWglxKNOLLwjl90LUoTq3X
	JRfwps8bhKgPdDbwm8PF9932Vinou0Izp43+eihlK5lYXr9GqH0Ru77/bh1kZ0L2z9vCDtLUf0V
	Ss/Pty6OpIwekRlj7hJkZkFm38gw0s18J+rWt4UyBOgmAoFuqEbrIwNDqszO+jHuFjDxUgKmI1I
	LzECvtTHQH0WwxJv/DHUMbeBSHGmuLkJOboBXycsUHrqCFITPG4MreAjwDaqIMgBCMTKJuHDS2N
	Z+YGQbfs516e+IbL4tuNVXchLmos=
X-Google-Smtp-Source: AGHT+IHED7+rpkRtlBxZO9p+36KWOh4E+ddumxvqZJI9AqcJZ3H9gbQi4l8+a8BmFg25VzAg2XnOgm+Pi/q+
X-Received: by 2002:ac2:4c49:0:b0:594:3a08:162f with SMTP id 2adb3069b0e04-598faa018e2mr135201e87.1.1765516624931;
        Thu, 11 Dec 2025 21:17:04 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-598f81d098asm529311e87.24.2025.12.11.21.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:17:04 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 445CC3420A1;
	Thu, 11 Dec 2025 22:17:03 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 41BE3E41A2E; Thu, 11 Dec 2025 22:17:03 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 4/8] selftests: ublk: use auto_zc for PER_IO_DAEMON tests in stress_04
Date: Thu, 11 Dec 2025 22:16:54 -0700
Message-ID: <20251212051658.1618543-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212051658.1618543-1-csander@purestorage.com>
References: <20251212051658.1618543-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stress_04 is described as "run IO and kill ublk server(zero copy)" but
the --per_io_tasks tests cases don't use zero copy. Plus, one of the
test cases is duplicated. Add --auto_zc to these test cases and
--auto_zc_fallback to one of the duplicated ones. This matches the test
cases in stress_03.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/test_stress_04.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index 3f901db4d09d..965befcee830 100755
--- a/tools/testing/selftests/ublk/test_stress_04.sh
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -38,14 +38,14 @@ if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
 fi
 
 if _have_feature "PER_IO_DAEMON"; then
-	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
-	ublk_io_and_kill_daemon 256M -t loop -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
-	ublk_io_and_kill_daemon 256M -t stripe -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
+	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
+	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
+	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
 fi
 wait
 
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
-- 
2.45.2


