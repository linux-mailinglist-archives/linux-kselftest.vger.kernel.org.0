Return-Path: <linux-kselftest+bounces-20159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303F99A4478
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 19:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98892B2320D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 17:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558CC204089;
	Fri, 18 Oct 2024 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zsRSApFu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E2E2022EC
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271889; cv=none; b=af+zmjle991pLohOfwB1UrFkrMmdxI2EwZQIQdESJnESK6XmTMGET4DCovX5BdbSv4rdFD08bq/BLP2iWC+5ULHJdMv0xwTTNKWH5CFbBpSLYM00ieqP+w+1BOWK7OXS9/OSv02jf8Xn6Op1X+gSG6ltZQugnSTIBnmKroLXdc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271889; c=relaxed/simple;
	bh=+ENvV6jp4xly72yGU6pYCi2Z9gHRmWJGCF79OSN5WJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YxStjVMU/DWAwi9S0q3I83azavnAgCrYUwX/614+PHiYXHuAaguvPwn8Isq0eii9hNfOghJawxSjJrxdumlvUOcmtH1SNgyMZX73TMrcoJeViLwqDMevIEQ8+bp3yeR52zCbfJ+OYRoj+A/gI5NBm3caUXGfwomVRVlcjblFmF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zsRSApFu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e2eba0efc6so2639658a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729271887; x=1729876687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=09rqkYzv1mj2i541CG3quDs2Oto4Z5t/2Gr1EPh2MJY=;
        b=zsRSApFusJfc8T2bVMP5agusEOMIYoh8NWMZu0SvbTVqmumYWcFcr6pFejLAx6NCwm
         pn2NX2K93Ig0exdwr+EfNVZNSd6GibN7lG1Y1vq3X+m0/FSROBh6xJKWqwO+7adyV7ng
         Xpi8rYvJPftmSKRRnJoxCZgZHR3e4OwVkJghCXtaGI2e4r+e8deUUAIljgg7ynY9UFnC
         7s7gBLVxF3Qy67Z4yhU7F1YuKRLQrGGULABqvym5NopToyWn/Q7r4jr4vkn2Ig/Sh/vn
         huSnt1YVivht8R5dC+SyAVF5lZx8MBG8Ky/GgZb1Ix5qLvV/c2BGJQO3xH5CDn2Fmw4e
         OFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729271887; x=1729876687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09rqkYzv1mj2i541CG3quDs2Oto4Z5t/2Gr1EPh2MJY=;
        b=qX91+8tzqCBeOgeMYZwmQnr2E/ZnrajQ7JSzYwo4OWwvBSahA21T4jLbdBG/IkwTOm
         cC5nlNFMhpIocFOu3ta66Zpjq++5Pt18lcQ7TK4HwTtht5a/uzbS5fupEkKPRSz9+jWp
         F7oMfQSwjVWzQTBe+eav9IIk++RHegT5LW1ujxT5Na3U6u9DQHgH8RFYAuIfBzLzkzI2
         5k6yq1G2ZPdBjvxnNwtL/+6o6H78UFCE1SlBI5Zbw3n9MBMC/R2fuLCeU+pZU6fpFRYZ
         ryB4ASx233atd7s3RKzSMrDvTB5GPAe0ubs6go8/Q23+I6eaZpxBpd81RglHSKr8EeYL
         PLGw==
X-Gm-Message-State: AOJu0Yw51Yo1x83LPjnZ71abUmqkWmXPS1dwVG9iiAr8N38a25YOh7zM
	5L5n7jzzPfWNeyZPRCBd8fMvPm6wMwyKhzLBJpfHh0sZMu65Raeuwy0HH40GXzfKcv/NYzgX0oS
	Jrtr6ZZDwxmdzM0pkiq5+FyEA8SaF6z99j4hyii0ChLCetoFUGEUEwhFmW16D7ycfeONGCrJULZ
	jGXZZklAR0Zku3nuKM9GGGUQOBISRSC3PJtQSswp04PLSV
X-Google-Smtp-Source: AGHT+IFCzoFKtcQsGl5HORvI+qdsZRNBp3NS1MD2ovvhIYOdGqZKLlvaQri87EIXebpvo+p31wOY+8NUM+A=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:dc02:b0:2e0:72ab:98e9 with SMTP id
 98e67ed59e1d1-2e561511115mr9463a91.0.1729271884764; Fri, 18 Oct 2024 10:18:04
 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:17:22 +0000
In-Reply-To: <20241018171734.2315053-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241018171734.2315053-1-edliaw@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241018171734.2315053-2-edliaw@google.com>
Subject: [PATCH 1/3] Revert "selftests/mm: fix deadlock for fork after
 pthread_create on ARM"
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Edward Liaw <edliaw@google.com>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org, 
	Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"

This reverts commit e142cc87ac4ec618f2ccf5f68aedcd6e28a59d9d.

fork_event_consumer may be called by other tests that do not initialize
the pthread_barrier, so this approach is not correct.  The subsequent
patch will revert to using atomic_bool instead.

Fixes: e142cc87ac4e ("fix deadlock for fork after pthread_create on ARM")
CC: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index c8a3b1c7edff..3db2296ac631 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -241,9 +241,6 @@ static void *fork_event_consumer(void *data)
 	fork_event_args *args = data;
 	struct uffd_msg msg = { 0 };
 
-	/* Ready for parent thread to fork */
-	pthread_barrier_wait(&ready_for_fork);
-
 	/* Read until a full msg received */
 	while (uffd_read_msg(args->parent_uffd, &msg));
 
@@ -311,12 +308,8 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
 
 	/* Prepare a thread to resolve EVENT_FORK */
 	if (with_event) {
-		pthread_barrier_init(&ready_for_fork, NULL, 2);
 		if (pthread_create(&thread, NULL, fork_event_consumer, &args))
 			err("pthread_create()");
-		/* Wait for child thread to start before forking */
-		pthread_barrier_wait(&ready_for_fork);
-		pthread_barrier_destroy(&ready_for_fork);
 	}
 
 	child = fork();
-- 
2.47.0.105.g07ac214952-goog


