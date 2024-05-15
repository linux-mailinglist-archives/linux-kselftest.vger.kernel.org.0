Return-Path: <linux-kselftest+bounces-10213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D917F8C5EAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 03:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED432B21D8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 01:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2943DA21;
	Wed, 15 May 2024 01:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho6QgxQT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B780D748A;
	Wed, 15 May 2024 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715735310; cv=none; b=QH5LMz5kuWoR1KtC5ug3OQtP5sgDc5JL5n0ikwLMSB7Q7DMDKwGVD4htLNv3GmOyxKP0puV1KFc6LLqs4G1j7y3KnIfM5bFk+zo4O3JtctvP1hcA/hISZ2ngzuOYYzi0wQWtakQtim/cCWA4BTdBEuaAo2w4aL3gOoEkxx2vv5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715735310; c=relaxed/simple;
	bh=O4pErUei5BcDdY6rSN5JCE4HW0/7Ee1oOOLQEFOtl8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YCrcfFBcQ6dEvYwOst/dl9igKXlARptyRqxb8JqyxPhnk649G5kiwypYh6oEVRe3rbkbCT/3x46OsIbIzgWbj22ldI5bm5matdU9fJB7I0c/rEc7AMGfK9EAFhZnFKcTZip2x6s7xFtQaivnxHvcgS50heS+izeNw1OSHSZvRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho6QgxQT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f45f1179c3so5905002b3a.3;
        Tue, 14 May 2024 18:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715735307; x=1716340107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+ayVbf+QMN56CDy4orfOWD3cBOJ6aQix+a9D8vn66o=;
        b=ho6QgxQTsIUBD3zGGSjmBeTo4y6B3d2Ty3y1S24ostSGABSoo6ekj7fFgZNP+Qw1hn
         EkD4YagvOBhukRanzL30SmnOJ/7mfhyeRB8+T6QLcBjxJVVzR84nqmsWjJkqd+PugR7N
         FQLNttg4Zstj0GolBjpFYjWfrt/9K7QGAzmugfHA/rq39Srxk8fQrreGkN9vBZ5+cpS6
         duO9/niRzTSMAbBx8A0Lp0PliRcBDVojPWXZDo74jW3Bhv9ziwuB94Sb18FQEVvFsP/o
         OZMcbfIebsQJP08xodfHPtQiMWxv22N60mLtgpwTjboZoFOoYgelUu7mKEQTK6j53y58
         igPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715735307; x=1716340107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+ayVbf+QMN56CDy4orfOWD3cBOJ6aQix+a9D8vn66o=;
        b=QLUt3HIgEB9UQqBXsgM9ODDhXoa8TQl2C3H6sOq64c2ieDZZuNprcXu9HmIQZSx7m0
         THRa12HEcRq16n0osao0MiCsmefS4mLsDVPXVlT/2Ib6ohcPCfRWiiEqwCPVZtjSV8+F
         atxC1+2hEYsG9iWIjHDu1tNVdI35UtPI4uYmgjjCgJVKKY226UI1sv31aXLcZ2qLQSfc
         1Obvbmy5aLnxVjjby+pfWDRZ+PpP+qLe/pjVvkR2fxMvQPWSVCkiqDpbwbMQ/YltdMl2
         XB8vyiJnIYadsNAMyHeArEyCFIeB/D/cK2bxvQgqD6Ctj/BHZV/ToXkI0Y43uJ82sJqk
         bhNw==
X-Forwarded-Encrypted: i=1; AJvYcCU341DFvOPc8nKQAeU6UBxMhiJ5kOw7nTfkjGc353tNGZ2OceLPzJnCII8t8tQbwQcQKnQZQ/zTwFtQEt5m5tFDHqSotagmfmzQS4qy
X-Gm-Message-State: AOJu0YxO3y+ATG7sSMjpQn1VBg7eEKnkAa81uaMja+DJwb1U+EDFpA6z
	vYjBuZ8hBU1BV8jhORUzxy3rauSLhfcKdPMnVg+Mx/6zEjfknz2uWYT4Vnb2F/g=
X-Google-Smtp-Source: AGHT+IH1JPc60P9dzDmwpW3nnKjvovvZmskyzzCFDMuzEZRQdR4tEyhx2/zrtE8LudcXR3vUP4MJGQ==
X-Received: by 2002:a05:6a20:c909:b0:1ad:999b:de47 with SMTP id adf61e73a8af0-1afde1d7b38mr15188336637.51.1715735307307;
        Tue, 14 May 2024 18:08:27 -0700 (PDT)
Received: from server.ucalgary.ca (S0106f85e42401d5e.cg.shawcable.net. [174.0.240.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d16cfsm104973325ad.18.2024.05.14.18.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 18:08:26 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Abhinav Saxena <xandfury@gmail.com>
Subject: [RFC PATCH 4/4] selftests/binderfs: Add missing a blank line after declarations
Date: Wed, 15 May 2024 01:08:05 +0000
Message-Id: <20240515010805.605511-5-xandfury@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515010805.605511-1-xandfury@gmail.com>
References: <20240515010805.605511-1-xandfury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a blank line after declarations and fixes some more formatting
issues.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 .../testing/selftests/filesystems/binderfs/binderfs_test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index d5dba6c1e07f..d8a22b62dd89 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -433,6 +433,7 @@ TEST(binderfs_stress)
 		int i, j, k, nthreads;
 		pthread_attr_t attr;
 		pthread_t threads[DEFAULT_THREADS];
+
 		change_userns(_metadata, syncfds);
 		change_mountns(_metadata);

@@ -536,11 +537,11 @@ TEST(binderfs_test_privileged)
 {
 	if (geteuid() != 0)
 		SKIP(return,
-			   "Tests are not run as root. Skipping privileged tests");
+		     "Tests are not run as root. Skipping privileged tests");

 	if (__do_binderfs_test(_metadata))
 		SKIP(return,
-			   "The Android binderfs filesystem is not available");
+		     "The Android binderfs filesystem is not available");
 }

 TEST(binderfs_test_unprivileged)
@@ -576,7 +577,7 @@ TEST(binderfs_test_unprivileged)
 	if (ret) {
 		if (ret == 2)
 			SKIP(return,
-				   "The Android binderfs filesystem is not available");
+			     "The Android binderfs filesystem is not available");
 		ASSERT_EQ(ret, 0)
 		{
 			TH_LOG("wait_for_pid() failed");
--
2.34.1


