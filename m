Return-Path: <linux-kselftest+bounces-20161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0FA9A447C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 19:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321931F22440
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 17:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7CF204926;
	Fri, 18 Oct 2024 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBgT7Qj8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F7B2040B1
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271897; cv=none; b=Mr5WnD2W5+jMhJuGp236Lr00fpZsUNUzhTveReLHmuc7o+pOqSRqK4Zt7AKaepQTV55bZ3d6TZJ7VKWBOe1K44eVzVXlA1QKfXcPv4qFCc7iLEjkjR7vfoFRfG/Ehm+hZU7gjqvPA3LA6ovFTmZa65pED4U6jiqxbwDCVjbiNMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271897; c=relaxed/simple;
	bh=hE7oRewSRIwjPXZwf3rEvS9LnJl6BbPZ+AoeFZLef0s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kKVpMdQwvyQu/bcCuI3Br/ThoO7C1pxTnq8YHUpBTAo6g8QIxjLejX31c2iEtT6i9XRcQ8k7JlhJbFm0kws+m8WRhdB7UKo6YItlPbr6R3SOLh4bDu8Yq5JFT4n9IVZsrioEopzG+z0JTTA0wV292IJCGjxzSFD/XLpplgztOSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBgT7Qj8; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e292dbfd834so3256615276.3
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729271893; x=1729876693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dqicHt23y2Txc3ltQfz9r7Ld+Ys6zd7l3ho/WLmRnAI=;
        b=WBgT7Qj8ZsqPbDiwgmq6YgD84bUCH3CGJAQCPU9cdEf/4ALsZTgVvsjVZK0k5fSQZG
         2MKuwjom24kcqrmIBDeNYQo06/lDL20BYyIxk4i1kyZVGTEQqcmU2SSWgJESYQVj4tNG
         kFpAjjIlOLqPpUStXyoVEw460gZ+0CynJt6HtTNbE7ApFtE2SBioj4mRQTmprKRsfzi8
         rf2jYrASH23IKupKaof6NY++2nrlZg8SJiRawtXdQuKK+9m4316zvM2Qah6CANao4wzW
         jmV9WIstskir3W4pez1nXtfLGdsdGsuSzC8SH5WmalQCwwgZk3KnQoX/8EpXRml/CYN+
         018A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729271893; x=1729876693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqicHt23y2Txc3ltQfz9r7Ld+Ys6zd7l3ho/WLmRnAI=;
        b=wIxSlspG0Jjx9KPIMo6UYXmv1BSRCMBwWhu6Drrzo3244BQ7kIUXEhrp4SYOnXAFWb
         PyNlj+uexxFyKKuMXUG8VCmcUxbYeqAg8w8zwnGQlxYVOI86aSQNzfA/WYyUFCbJARUp
         43+mjMCoCk2p9Knxe45T7VAVbrWoDKe+7tC60b2Yb/9geE3X7Y1HWW5U9etrgT7cemmt
         3Hfh0w1B5EkALzrlG9egFbVfmFaUaq24bd6YPvfQ0FZlQnKZmXtw0QSb945TpodpVS63
         X0mlToKudVdm4NfZBnE76ZZ1/uKOQC91Xp3LTj2lFJ5NJJZCGR149IfXwMrV7/vYSjDG
         fWUQ==
X-Gm-Message-State: AOJu0Yxi7q7PHjg5LNQAeT/5aCMjxhAFqICeKYQzEl8f0BxAmx5iHlm4
	rMEic5+Vwb4g6qMWzYgURdYdGR5Sg4bD+Q+btN4jE2vgIwWhy5FTHPXCmzAQp3caL4sw1YqX/IV
	XwnayfkAHUV7eKqH9UxSL020k6H70j27+Zj63NGvQVrjRQ3Qx08SyeH8uwms8cXw7cAYP/B8UtS
	FSG9W3xTlhAtBQ5vH0zGWqVLYIoZNsuLwTtMtiXFgyeZ3A
X-Google-Smtp-Source: AGHT+IETe8cpTBCpQKyA4kbFf3lNf2xFOaZ0iITih7uovjfurWUIEAi/snUf1XNhONUTm2/f6zAtyiP2pUI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:360c:0:b0:e22:3aea:6eb5 with SMTP id
 3f1490d57ef6-e2bb158a8cbmr4986276.7.1729271892276; Fri, 18 Oct 2024 10:18:12
 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:17:24 +0000
In-Reply-To: <20241018171734.2315053-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241018171734.2315053-1-edliaw@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241018171734.2315053-4-edliaw@google.com>
Subject: [PATCH 3/3] selftests/mm: fix deadlock for fork after pthread_create
 with atomic_bool
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Edward Liaw <edliaw@google.com>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org, 
	Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"

Some additional synchronization is needed on Android ARM64; we see a
deadlock with pthread_create when the parent thread races forward before
the child has a chance to start doing work.

Fixes: cff294582798 ("selftests/mm: extend and rename uffd pagemap test")
CC: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index b3d21eed203d..a2e71b1636e7 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -241,6 +241,8 @@ static void *fork_event_consumer(void *data)
 	fork_event_args *args = data;
 	struct uffd_msg msg = { 0 };
 
+	ready_for_fork = true;
+
 	/* Read until a full msg received */
 	while (uffd_read_msg(args->parent_uffd, &msg));
 
@@ -308,8 +310,11 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
 
 	/* Prepare a thread to resolve EVENT_FORK */
 	if (with_event) {
+		ready_for_fork = false;
 		if (pthread_create(&thread, NULL, fork_event_consumer, &args))
 			err("pthread_create()");
+		while (!ready_for_fork)
+			; /* Wait for the poll_thread to start executing before forking */
 	}
 
 	child = fork();
-- 
2.47.0.105.g07ac214952-goog


