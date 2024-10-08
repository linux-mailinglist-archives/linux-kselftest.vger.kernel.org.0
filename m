Return-Path: <linux-kselftest+bounces-19201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EA2993F79
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 09:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F3D1F250FE
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 07:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627401E200A;
	Tue,  8 Oct 2024 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1/FNkLR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E311BAEEA;
	Tue,  8 Oct 2024 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370291; cv=none; b=ii/pt6hh0vRROUGMgs/q4B9+GeJvG6/AyZxhzF7fUb++paFRr43mrXBSPA7BQ1jlYzyaaCcwuPvw0oGcx/iiYlHgBbOlZN6BB0mfop+TK62lrEf8yvy/dlqT439UH4v/2h5mJ72ECwGHAWy8c9lIYk108ADRCEXARtTaMINFXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370291; c=relaxed/simple;
	bh=lexfwVnDZVssfjVYfwTVRMRxeQRhaBQ0w1vfGb7qmPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I6Hmj5r7LlzJbjtcCwnRK5/ArvU2SzINI175PFQBm6BYvc/aycilQTxRiv+6yvWW8oQxro2yCkAOHON6kzyAGAhkj+8jtKYcusKmZw+Y3k/cir854zSs1EoszcMZtNyoC7Kv+Hr5xYQdRQMbwRDvge5RZS+xLOC505Sc7VwbHgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1/FNkLR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e029efecdso1546203b3a.3;
        Mon, 07 Oct 2024 23:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728370289; x=1728975089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/iDZ3SvOl3CrdkULOiCZ3Uq0vTxXmhtlMel3bASz8p4=;
        b=g1/FNkLRaxs9fr5AKd4UXkPwtHKjgypQ889JNAnzHG7fpfRL3X47dsQvIvgBg+7GNl
         1rQAg718Fn9MAaLoTEN7N7zPt65Q9wjGJxVNvYr/GV2Q4PzMwf9C15ubB9pWHQ85oZzU
         MYzujR2/arkxtoWZ76wFg0WaMIz3/OUpdc2Ze4/KnZHc9VoTrxvmUArEEA4yKEEg+Syq
         i97GQNIJ44EihJJiTHLQkWjgQEEyZkoxYo3nKJC/O2oIljwtON5CCjBhDDTSV2G4xtJL
         wOmM9tmLLI+y5Y1J4tTLqxtVsa2zlBOibI7daGynRdEJ6+IMQ6o5MdkbtdwK1N9mNfle
         LKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370289; x=1728975089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iDZ3SvOl3CrdkULOiCZ3Uq0vTxXmhtlMel3bASz8p4=;
        b=NKJieI0ODAXCDlnCRIL/oCZU4iKsvGG7529CTVfis1OSewhyOVbdgXyCSjFFqb/fy7
         vEmhqkBEU6fYghJ6/XKa6isWJU09xuy+yh+Dx1eS2feCDe/1+uhZM/Vejkjxo9lRpv8e
         RUHmtb3gBRIZQEeJXYjX/6Vp3T+VDO1k+KN44yfw2AA2D94ccBkwXAqWQL0RCObY0bfo
         k/cACpFamnxQ4DHUEgbiOOoaF/9LnomPcm8eHf0SBj6kvgSGvZLAcHRr5C4RzY3M2ePW
         uzeYugDq4rWxdy8gSywoxOseq6CWHwFHrR00Xlne4yzy9NwnD4OYb9QwEz0QNOJTJwdm
         cWGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuThyH3tBSHgnKm3KXBB2uHqyA5AOfSYaYo60zLrSvg3WOyJgQPxAfsrj7fuNWoqAHGSfCzv9/sckKjPA=@vger.kernel.org, AJvYcCXSWIAzNOSr8wfYAHcDp28KZ4xb9XhSMOCErneIvvOqyiYpK1LJCFwM7PewjUHNsvFApfVikuifZXVmnS64H9Sg@vger.kernel.org
X-Gm-Message-State: AOJu0YwMpprzX23X6r0c61VtOJRec2ULJ7jU7oDErvU8I4J80GzglgUh
	g22yY68B58udVID6ThhquK3Hb4Zqs98EfmIRId/udNrTUYp9j/dg
X-Google-Smtp-Source: AGHT+IEZzh0p236ArM2w2xpgq1EmvjA39f2MJfAM0GAqmkJ1z9HtxbqC41AVx1fH+CZw6MmtH1MZQQ==
X-Received: by 2002:a05:6a20:c998:b0:1ce:d418:a45c with SMTP id adf61e73a8af0-1d6dfb2ac3bmr15780279637.50.1728370289209;
        Mon, 07 Oct 2024 23:51:29 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:bb25:5583:9ce3:ab6b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f682fe56sm6064033a12.51.2024.10.07.23.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 23:51:28 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: davidgow@google.com
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [RESEND PATCH v4] list: test: Check the size of every lists for list_cut_position*()
Date: Tue,  8 Oct 2024 14:51:23 +0800
Message-ID: <20241008065123.26422-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the total number of elements in both resultant lists are correct
within list_cut_position*(). Previously, only the first list's size was
checked. wo additional elements in the second list would not have been
caught.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
change in v4:
	Amend the description of commit message, make it less confusing
	and focus on the correct check which is performed now.

 lib/list-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index 37cbc33e9fdb..b4b3810c71d0 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -408,6 +408,8 @@ static void list_test_list_cut_position(struct kunit *test)
 		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
 		i++;
 	}
+
+	KUNIT_EXPECT_EQ(test, i, 3);
 }
 
 static void list_test_list_cut_before(struct kunit *test)
@@ -436,6 +438,8 @@ static void list_test_list_cut_before(struct kunit *test)
 		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
 		i++;
 	}
+
+	KUNIT_EXPECT_EQ(test, i, 3);
 }
 
 static void list_test_list_splice(struct kunit *test)
-- 
2.43.0


