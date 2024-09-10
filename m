Return-Path: <linux-kselftest+bounces-17567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE659727CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 06:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8895B226C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 04:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713C61552FD;
	Tue, 10 Sep 2024 04:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDUNmDkj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA01CF8B;
	Tue, 10 Sep 2024 04:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941306; cv=none; b=NtDmxWnauggjVaUtmsKOQl9tC1ijEGXTaSLBu7CaSYR90RjNx9sxrHu3/7R8l/lFLDxGb1RNtAUha031/3ALufpBz4gvaT7vFII8iikvI9fdOxdpIRBvfKwl5QhDlvF18cPmhLWNG63CTO95+00TIneFonYv1CGySOCZyBFA17M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941306; c=relaxed/simple;
	bh=FqANpbOT5Um4r8iPM6kxTnJJW/x8nceJ1wqhFAytDW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQD0+N5ln9aRVMTxmObl02y35GAVxQB2WgwiTvsmUZZ+R0i1SuY2kGK8X7krVZm7X25PGNYit8K9yx259hOZuTLGKJTWTVzD2FVCYwqGgeSBDcLaNhmX5mP7BVTgKcmjSyYO8CIwuJ4fcGktOybXL0RL1u0NZHnOtYakyd48ccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDUNmDkj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2068bee21d8so49889665ad.2;
        Mon, 09 Sep 2024 21:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725941304; x=1726546104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vSUYVBZ9f218+RRN/cLDTQz2eMi/kbUHaX+3xxn5Xyw=;
        b=BDUNmDkjpNkswJV+PIaKWu+q+5FSw5GHomgn5pYr3g5hHvpvodAxvDo2QN6WVHOddF
         ddf1TSiEjCpu8VJ4QxjJymql5xa9I0ZlQuU1upHB4jLUdNh5vsaewto78Nc2jHYdsXmv
         rHPvDEkCR+tzWLBexMpF+mRiN+5HqYUtkxKvroMD+0Y9KU0NbtY9vB7JtgUsKBzCG+qe
         cymcxdMz1hEkCY2OkHABJgOf9SBw/yCIgNSEkCdsYrcjlFT3o6GVy8nQQHEhXyQoFVN3
         8OB/TUGNLsNQLdqyFlBlQDPHPNZKyL8fwJUqVv6Hzo40hm7NSxwnSKbubbaRB+d0WGra
         4tRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725941304; x=1726546104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSUYVBZ9f218+RRN/cLDTQz2eMi/kbUHaX+3xxn5Xyw=;
        b=MP2+TtuZnbVR74Hpjx8dqSUHpj5DQUuDh2DZKoPtVAhPXWKK4Ih0iXTuA9AfY7SbCW
         xAY3z9ByvMwaB9x/yJWF3PCiTvR6AHMttxSQ9bM/8lGrnzUBanbmvudnZ00C3J9NlcnR
         JSspLGlIKMTizVfn+QyvnhdTWgY9VcWC60ve0RFMIMgtUxzXmpaNpc1VO3FDbRU/LqaK
         43rEJ3Gc+5qOH0j2jF23vkHLIp1zltUTizvBQzYsfvODGRCUNIUkLARo60sgck9e8yF4
         +DONli+xN5RY8kp6Qml+7Zb/OWSAQLVQps8+tEXw0wZlMB8q7Eo+PqG1G8+cItFXddlN
         E+DA==
X-Forwarded-Encrypted: i=1; AJvYcCVyEha2QSQjiVj+9kP5sQwTf7R8u5gUkmACqzqu4HfgGXZ9NlGfCdmvqNoLjehPl9bDTqtjlIjWjQYjx5rHNCsA@vger.kernel.org, AJvYcCWIfTNsrDjJF308EHYwEMX9csSHXGFKPC3y5Gw8s50w1ZkcQQ8rraOXDzK2J5um5W6MSTr3e0mcv+VNl0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz9GG7uO7Tx8S/OnvmUPFKYYzR1fuZx5Wz+eCRysM1zQ8deo4W
	n5tGPZ/d8aCKc0DwJyQqa6m/fB6/A6f1/sQnPWjyjmsHeaBoUZ1b
X-Google-Smtp-Source: AGHT+IEO341rIgLrziIr2ocfxQbGpgKw40Kn6XGk5M964DpX3kykdw64ac/zx47iY7lKuu30f7lt7Q==
X-Received: by 2002:a17:902:d491:b0:206:ca91:1df8 with SMTP id d9443c01a7336-2070c1c7184mr120939625ad.53.1725941304154;
        Mon, 09 Sep 2024 21:08:24 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:8527:dba1:3ddd:e486])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f3195dsm40644585ad.263.2024.09.09.21.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:08:23 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: davidgow@google.com
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] list: test: Increasing coverage of list_test_list_replace*()
Date: Tue, 10 Sep 2024 12:08:18 +0800
Message-ID: <20240910040818.65723-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increase the test coverage of list_test_list_replace*() by adding the
checks to compare the pointer of "a_new.next" and "a_new.prev" to make
sure a perfect circular doubly linked list is formed after the
replacement.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 lib/list-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index 37cbc33e9fdb..e207c4c98d70 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -102,6 +102,8 @@ static void list_test_list_replace(struct kunit *test)
 	/* now: [list] -> a_new -> b */
 	KUNIT_EXPECT_PTR_EQ(test, list.next, &a_new);
 	KUNIT_EXPECT_PTR_EQ(test, b.prev, &a_new);
+	KUNIT_EXPECT_PTR_EQ(test, a_new.next, &b);
+	KUNIT_EXPECT_PTR_EQ(test, a_new.prev, &list);
 }
 
 static void list_test_list_replace_init(struct kunit *test)
@@ -118,6 +120,8 @@ static void list_test_list_replace_init(struct kunit *test)
 	/* now: [list] -> a_new -> b */
 	KUNIT_EXPECT_PTR_EQ(test, list.next, &a_new);
 	KUNIT_EXPECT_PTR_EQ(test, b.prev, &a_new);
+	KUNIT_EXPECT_PTR_EQ(test, a_new.next, &b);
+	KUNIT_EXPECT_PTR_EQ(test, a_new.prev, &list);
 
 	/* check a_old is empty (initialized) */
 	KUNIT_EXPECT_TRUE(test, list_empty_careful(&a_old));
-- 
2.43.0


