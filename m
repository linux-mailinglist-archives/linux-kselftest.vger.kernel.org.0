Return-Path: <linux-kselftest+bounces-18199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FB197E224
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Sep 2024 17:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8CE2B20CBF
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Sep 2024 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D84B647;
	Sun, 22 Sep 2024 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9FPfOMG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2910633E1;
	Sun, 22 Sep 2024 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727017513; cv=none; b=KwH+ww2p+2jlYZvgcDdMKhM5TcHsPAPHSwFUoG4mHsnZNc02qCOo1V+uMOf8Jg+ZiJ5bG5gNctuF2kiAYLCP2/a1jZJ3e/oXmuO+RegY3O0crnCCnfg3iZZ2vza19qnF4xjDqPYP+rwvcg7uCdiThk3rQ/ymbwXbAEvC5jaEtl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727017513; c=relaxed/simple;
	bh=udfkU2rZFc87DErPc2zl+mRlTTmZa02H1Od8ymTqZ9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kx1qGXm0Ctl5kBxGl73PZdIjbIDoYm6jVNOzRncVGJRnYdFJDsDD3Jf0/yDKYXoOAwQAHgAbFclyIGjO+1WUaHVhcF2l5PI/lhjgl7SqwN2rN/JI2XLjYSOYm854HFAzqIRGNNOFukbjxG1blfCYT5Z26zsqt/wcRGq/MvvrX9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9FPfOMG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71798a15ce5so3176108b3a.0;
        Sun, 22 Sep 2024 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727017511; x=1727622311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SgC05laigZrc9YhdUETMJtepcdb1sic4eQ1AKtV1354=;
        b=G9FPfOMGtZnv2TpTF1rqjz4XUCohzXgoYx+lmmgolUacrDLqRHStEnOPHa/dZjTCM+
         b5mBP2Wsj5PBcLOfz220CjTju4EDEz4fl8O+2KJEV9ktAKiRsUG1OdXs73yzVACJKOFy
         GrvwOMvEbYTh8bH2VdTPiqEKZ3GAjZ2UNc7P2TEpqbZJCZLr8FcB9J4TKSq7GbzLUGQr
         F3x3XBaiDImz0JEE/XHVYQOZIXP4f3D6kY+K2HSktoDUtT1cHTPPcbF6z+D+2Gx7dW+7
         Vg4hFGOdYraIb4C2FXm1Qs3yJHr/MWmUOX2sk7HONuEmdhP567gcAmfXnZQERJILwTZ8
         BmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727017511; x=1727622311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgC05laigZrc9YhdUETMJtepcdb1sic4eQ1AKtV1354=;
        b=csw/wcSDAeBlkls3WJUKwUtpzjpf2XG+k+8G/EniaaRUsJPFTt1c72ZmAmCzoAQYY+
         u8PipuPNLP64e+fITTAOKBHyF0ZnXWtCtBorrBEXNuU3FNdgQmpxqMygjIfveJO5jW6J
         KlHtk2qA8qaUJ9wVbUhrzhUYgRc2JoCrbVVpdsdnS+0MEAANDaV4Q4DX7AkFLS4uQM09
         Apw/W0A7H0CS5YE8uwucqkq0Qb+aIw2IKemcO8Owh45zwCfiMrThLnV22bm8RVcsHlF7
         1qx7irIQPsgSlbwYsGtDq0iWBz572dJv/V+VE7vFkp4QjmrcL9iQVzk+MyM6lchswMGO
         ra6g==
X-Forwarded-Encrypted: i=1; AJvYcCVi0Svn7r57X8FOK4PP9vHbpqcbMLYZCoFQpzh6DDdZKigCLoYYVA6oJ7I+xKkkuf9eKUzewo8Xb0sYdws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfrKHlE4U5q6HlxJ+EVPEK6Q+2O8q4VxS92+XrY7PX7NsuD7wR
	FQTyeOFrh8BapIDfcekDyuMhJ3cLStCfoqC5K++1vVr6vDYLaBLpCSf76w==
X-Google-Smtp-Source: AGHT+IF0cJKDW57QxCia931Z/mbqBavpY7Cc9jHHL0OINn7+qqn2WUuqwsc3xhsFUa09Jbu5wWbcNg==
X-Received: by 2002:a05:6a21:6801:b0:1cc:d9dc:5637 with SMTP id adf61e73a8af0-1d30a9ccfa9mr14085967637.23.1727017511291;
        Sun, 22 Sep 2024 08:05:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4998ff14sm13831649a12.66.2024.09.22.08.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 08:05:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: David Gow <davidgow@google.com>
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	I Hsin Cheng <richard120310@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] Revert "list: test: fix tests for list_cut_position()"
Date: Sun, 22 Sep 2024 08:05:07 -0700
Message-ID: <20240922150507.553814-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit e620799c414a035dea1208bcb51c869744931dbb.

The commit introduces unit test failures.

     Expected cur == &entries[i], but
         cur == 0000037fffadfd80
         &entries[i] == 0000037fffadfd60
     # list_test_list_cut_position: pass:0 fail:1 skip:0 total:1
     not ok 21 list_test_list_cut_position
     # list_test_list_cut_before: EXPECTATION FAILED at lib/list-test.c:444
     Expected cur == &entries[i], but
         cur == 0000037fffa9fd70
         &entries[i] == 0000037fffa9fd60
     # list_test_list_cut_before: EXPECTATION FAILED at lib/list-test.c:444
     Expected cur == &entries[i], but
         cur == 0000037fffa9fd80
         &entries[i] == 0000037fffa9fd70

Revert it.

Fixes: e620799c414a ("list: test: fix tests for list_cut_position()")
Cc: I Hsin Cheng <richard120310@gmail.com>
Cc: David Gow <davidgow@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 lib/list-test.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/list-test.c b/lib/list-test.c
index 4f3dc75baec1..e207c4c98d70 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -408,13 +408,10 @@ static void list_test_list_cut_position(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, i, 2);
 
-	i = 0;
 	list_for_each(cur, &list1) {
 		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
 		i++;
 	}
-
-	KUNIT_EXPECT_EQ(test, i, 1);
 }
 
 static void list_test_list_cut_before(struct kunit *test)
@@ -439,13 +436,10 @@ static void list_test_list_cut_before(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, i, 1);
 
-	i = 0;
 	list_for_each(cur, &list1) {
 		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
 		i++;
 	}
-
-	KUNIT_EXPECT_EQ(test, i, 2);
 }
 
 static void list_test_list_splice(struct kunit *test)
-- 
2.45.2


