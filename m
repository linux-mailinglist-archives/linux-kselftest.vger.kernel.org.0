Return-Path: <linux-kselftest+bounces-18982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F6098F8C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 23:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01DC1F22521
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 21:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DED1C1753;
	Thu,  3 Oct 2024 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DlCJy3/U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B2B1BFE05
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 21:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990255; cv=none; b=qUx0d+kcbD1eIR3HfN7/dNnSyDaJOW/cf8d/UbrSxHhKBAzkrSQ51LlPCGfmy9hKOEfH2HMWtbViXhH2ZUvRwjcO/zsWBZcOseAx8hOizOdtJ0XVVXxEZC9ElJ+Znu+SosL04MJPC7kuOnB9qAAvssZNdpMfaDQ0Esbe0VMaV+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990255; c=relaxed/simple;
	bh=IROd3VJkoeniPwTUOiMyty21qBg2Z2tb1n98wFzPBTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mrFRgq2jPsFFGEoIAurDdIeh/RtAEqr0ruZ59+mC7GDIQOzk9F8XJErVYWLP7SdGBWgtXw0aJ9fd3RAgXQizgglFmzeCzUzGWqvzep9OJX+HgCWMGZhM/8E0Lq1HT6bxh9b4j+q1ivVQcevXub/rkfcMxL4iqv6jAP7jqDoFszk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DlCJy3/U; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-718d873b1e8so1742587b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Oct 2024 14:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727990254; x=1728595054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVeNglwTN7akCXDmRlldGSc/rW6sZdc88WuvUouG7/c=;
        b=DlCJy3/USFmcGT+ymHz2vaJ68JOvLLmIZApoFh0PFsTwqGRBvYxNq0zRFWTlVXe+wx
         GTDik1PDc3+a7z5P3hud3VAWuLSOpkcV5Bh0MyOLBaunUvSyHEZOWZ0nnGPoWWtKFNM8
         kBfKb2NHtWhq+IrY7lpJMr0x7mFSllQf/9QZgI+pDn1M/Ahm/SJ66p2QIEoWsVc0SHz1
         RqWBuwm0UmBNko2ilLR0QXz3pQRDlToXiZAzCEJhM1Flec5XeKnCYFliqgi96C4BqGHd
         TztGIWmtpi91GKu2FmpnBfNj5aB2oFboJxr8iGOC2RWoD4mS0htP+xPSYH3/gZEdAk9W
         B/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727990254; x=1728595054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVeNglwTN7akCXDmRlldGSc/rW6sZdc88WuvUouG7/c=;
        b=dHh12ya4Q6rvGsKCsn+uZxsdSXxteHdHKJIfPw5Q42y4fAkssgQEt+03aKLLfMs9HA
         8UBIjXnHPhU/g2gmNFjeIKsIRyIQ+gK52yV7xoVqooGhU+OAPRRMaBlXLDgZpR1gLXQm
         gw3b1MP3ZcGxFtTjtafAxsjpfs5BpmnOMSRlIX3cL/SOs5a+u0xA7LEmKNN8FhRpBXEs
         C2x+x5kSCaU1eeexkNFkk6HBG7LdCkqx4kJXPVay+Y5kLFTB2y3KJPW1Bwx+gmEU1Jv+
         Q4EwU+UrmT3NAD5Ys/+P2uXaCco1bHd/euOwZ2LRdzGKELBZUFPBKU6ig9wRfqu9iKpk
         +RIQ==
X-Gm-Message-State: AOJu0YxD+NmbMwKmdMTJpOlRoumpsmIh3uJk+I3AtalC6G+OxMSJZHmv
	nGau6aHn+lTbWAdrCnffXif4JCbU2IhyeEyw1HhluVrxLKZo4pEpCG9PP+tqAT8Py6GzcgEeSlD
	ap4rhQbstXk/SaxfwYmbW8j8NHBHFpFYGCezPZbPhlnOugGd477zq5CpIjwapp4izpofvhm8P9Z
	z0/i4sUrF0R1XT59coRmxm29Ewv+TcXFgLBA8WjfNq614T
X-Google-Smtp-Source: AGHT+IF1wAIWxriS35+1+9s9R25YDFII/xuSGjwNB1DYXJzZFTeclXhMlYEUs67ru5vh0bxduTAAmrtUyuM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:858b:b0:717:8e0f:3e5c with SMTP id
 d2e1a72fcca58-71de24930e7mr686b3a.5.1727990253229; Thu, 03 Oct 2024 14:17:33
 -0700 (PDT)
Date: Thu,  3 Oct 2024 21:17:11 +0000
In-Reply-To: <20241003211716.371786-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003211716.371786-1-edliaw@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003211716.371786-3-edliaw@google.com>
Subject: [PATCH 2/2] selftests/mm: fix deadlock for fork after pthread_create
 on ARM
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	Edward Liaw <edliaw@google.com>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Android with arm, there is some synchronization needed to avoid a
deadlock when forking after pthread_create.

Fixes: cff294582798 ("selftests/mm: extend and rename uffd pagemap test")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 3db2296ac631..c8a3b1c7edff 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -241,6 +241,9 @@ static void *fork_event_consumer(void *data)
 	fork_event_args *args = data;
 	struct uffd_msg msg = { 0 };
 
+	/* Ready for parent thread to fork */
+	pthread_barrier_wait(&ready_for_fork);
+
 	/* Read until a full msg received */
 	while (uffd_read_msg(args->parent_uffd, &msg));
 
@@ -308,8 +311,12 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
 
 	/* Prepare a thread to resolve EVENT_FORK */
 	if (with_event) {
+		pthread_barrier_init(&ready_for_fork, NULL, 2);
 		if (pthread_create(&thread, NULL, fork_event_consumer, &args))
 			err("pthread_create()");
+		/* Wait for child thread to start before forking */
+		pthread_barrier_wait(&ready_for_fork);
+		pthread_barrier_destroy(&ready_for_fork);
 	}
 
 	child = fork();
-- 
2.46.1.824.gd892dcdcdd-goog


