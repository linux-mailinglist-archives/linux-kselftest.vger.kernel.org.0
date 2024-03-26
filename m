Return-Path: <linux-kselftest+bounces-6673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CC388CFC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 22:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48691F63853
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 21:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBC013D538;
	Tue, 26 Mar 2024 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AV4DlzYS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F21E884;
	Tue, 26 Mar 2024 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487617; cv=none; b=PYHKkw95y54yWS+wvlcMKrmSiqKLMK13fEhBxBODF0aQ00iakonUh/5RPzg53GIrHt9JSjxpgZ3Ffc71FKlNP34i3Z9e8kjiMDFrWGUGLw/rBDZW4ZmJLJU8vTax7wL+R2nRm58uK0tJdbkOqnfV8JfLbV0XrrYS7c2fmncYzoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487617; c=relaxed/simple;
	bh=CjgU2Zcase8ih2FBgnxpr4WKeGIvt+Z25xPUl7MY2AU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=piQZtb4GK1O/iTW8IkhQmJYWIuWF00tTkkk/KYOtJPouAZ1jVEUqfWveP8+X4agFgr6dpepm4+4p+lBPftZcTUFvUBoq8PD0bk4rVRuqd7l0yUcmcJkWcKHbi9wX/51rz+bHA9/gOq2CsKJY+oj4dlVJOizJ7T7yRs0S3KWrauQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AV4DlzYS; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d49f7e5c2cso78386111fa.2;
        Tue, 26 Mar 2024 14:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711487613; x=1712092413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wS5BvhCh8jJ34UNysDXhdq+vL/xVvPFsat0KC1MAVZg=;
        b=AV4DlzYSmBfJRowt3MYK6Ygi2JYQlyTiaAcS4typOwMJ6XEjAHVqrQ7t7bG9mmYQL8
         V8G+KJBN4zfgR+ru4SNtHKBxgzCn2wAD0n/tLbZ6JWoXIGzfPIJdSZ3u0qTT6jzk9ZjO
         ZGauyRnomidYfeUoXwTREfLcTLR5XGr9MfNZ7DhTVCFeBWgkfvJgprLbVbmQau4tbk/b
         ahjK2bECA3cqztFDv4rTHeEqe/7ThJEEjJ4UJZYns+U+j8oKdVg4Dfx561RleskCFd/j
         y2Ss5ufS0vTE8K5xyZsapGs18C4q4pb9YtBUxnQkJimGQzCdfSPEx73f+6ylat1K6UKQ
         lygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711487613; x=1712092413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wS5BvhCh8jJ34UNysDXhdq+vL/xVvPFsat0KC1MAVZg=;
        b=Ior6IRqM2OgzB5u1nvCVMLKFm1TuEQRY95Fb/98sk+UeOtVXGyWYBQEv8V5OfTjF9R
         HTl5IP290ohGInRFNQaob2LtqhVGe8fjUHTDwP+qD34we9XpzFGUHSmruCXGixoJdrAW
         5Pzr6nF1QIgWlHtqjkLAESFH9Qgn1PxLBIrHPOe5RhjvVIqRag08o1at6ucd3JWTRt32
         QTx9QoLdiMnjh8jlFvAZVw6Fnbm/434KYWAbzyBNNO0JA8Xk+5+htWW9OUS7e4PljBCY
         VD959D/pHm4FAhjz5u+BRKTeHFxsS+hqBjflEgksPL86HxGto6ypxyfrD5W5WEqjitKZ
         UEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVew4tiW94p0jC40jQqn/L6gqINSx1r+HXWK2blR4d1wnLAWQ+ZdLuyQ3F5XfVEPLCBmVHQDeS5oEcrHfAcfOjzlsTRFya4dBuMnrV37jmL
X-Gm-Message-State: AOJu0YwhxFL2U6T6depwYicAT9DRAyaZW5+OQs4IoaPyrA83mkcAYzBM
	Rd5I9qMNSMGmlmoLg4qCGj8wvaiRzwzO5NP02Uc5RcVN9A+agA==
X-Google-Smtp-Source: AGHT+IF1HAGVKrBHI2aCdPcK5Hnbntc+IestQWx/RDl3mplSXPD4Qj8A8NNWeLfGtGCUQZ1uA0QOUQ==
X-Received: by 2002:a2e:964c:0:b0:2d3:f3fe:48ac with SMTP id z12-20020a2e964c000000b002d3f3fe48acmr586686ljh.27.1711487613288;
        Tue, 26 Mar 2024 14:13:33 -0700 (PDT)
Received: from localhost.localdomain ([85.89.127.166])
        by smtp.gmail.com with ESMTPSA id w26-20020a2e959a000000b002d6cb159bd2sm1260149ljh.19.2024.03.26.14.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 14:13:32 -0700 (PDT)
From: Shengyu Li <shengyu.li.evgeny@gmail.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	Shengyu Li <shengyu.li.evgeny@gmail.com>
Subject: [PATCH v2] selftests/harness: Prevent infinite loop due to Assert in FIXTURE_TEARDOWN
Date: Wed, 27 Mar 2024 05:13:15 +0800
Message-Id: <20240326211315.12201-1-shengyu.li.evgeny@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240324214419.12577-1-shengyu.li.evgeny@gmail.com>
References: <20240324214419.12577-1-shengyu.li.evgeny@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses an issue in the selftests/harness where an 
assertion within FIXTURE_TEARDOWN could trigger an infinite loop. 
The problem arises because the teardown procedure is meant to 
execute once, but the presence of failing assertions (ASSERT_EQ(0, 1)) 
leads to repeated attempts to execute teardown due to 
the long jump mechanism used by the harness for handling assertions.

To resolve this, the patch ensures that the teardown process 
runs only once, regardless of assertion outcomes, preventing 
the infinite loop and allowing tests to fail.

A simple test demo(test.c):
 #include "kselftest_harness.h"

FIXTURE(f)
{
	int fd;
};

FIXTURE_SETUP(f)
{
	self->fd = 0;
}

FIXTURE_TEARDOWN(f)
{
	TH_LOG("TEARDOWN");
	ASSERT_EQ(0, 1);
	self->fd = -1;
}

TEST_F(f, open_close)
{
	ASSERT_NE(self->fd, 1);
}

TEST_HARNESS_MAIN

will always output the following output due to a dead loop until timeout:
 # test.c:15:open_close:TEARDOWN
 # test.c:16:open_close:Expected 0 (0) == 1 (1)
 # test.c:15:open_close:TEARDOWN
 # test.c:16:open_close:Expected 0 (0) == 1 (1)
 ...

But here's what we should and expect to get:
 TAP version 13
 1..1
 # Starting 1 tests from 2 test cases.
 #  RUN           f.open_close ...
 # test.c:15:open_close:TEARDOWN
 # test.c:16:open_close:Expected 0 (0) == 1 (1)
 # open_close: Test terminated by assertion
 #          FAIL  f.open_close
 not ok 1 f.open_close
 # FAILED: 0 / 1 tests passed.
 # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0

also this is related to the issue mentioned in this patch
https://patchwork.kernel.org/project/linux-kselftest/patch/e2ba3f8c-80e6-477d-9cea-1c9af820e0ed@alu.unizg.hr/



Signed-off-by: Shengyu Li <shengyu.li.evgeny@gmail.com>
---
 tools/testing/selftests/kselftest_harness.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 4fd735e48ee7..230d62884885 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -383,6 +383,7 @@
 		FIXTURE_DATA(fixture_name) self; \
 		pid_t child = 1; \
 		int status = 0; \
+		bool jmp = false; \
 		memset(&self, 0, sizeof(FIXTURE_DATA(fixture_name))); \
 		if (setjmp(_metadata->env) == 0) { \
 			/* Use the same _metadata. */ \
@@ -399,8 +400,10 @@
 				_metadata->exit_code = KSFT_FAIL; \
 			} \
 		} \
+		else \
+			jmp = true; \
 		if (child == 0) { \
-			if (_metadata->setup_completed && !_metadata->teardown_parent) \
+			if (_metadata->setup_completed && !_metadata->teardown_parent && !jmp) \
 				fixture_name##_teardown(_metadata, &self, variant->data); \
 			_exit(0); \
 		} \
-- 
2.25.1


