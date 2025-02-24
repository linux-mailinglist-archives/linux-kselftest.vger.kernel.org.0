Return-Path: <linux-kselftest+bounces-27351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FE9A4247A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 15:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECAF17152B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 14:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8D024EF7C;
	Mon, 24 Feb 2025 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UG2p7037"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C09118C01D
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408452; cv=none; b=R1WKSMfOP6/7Nf0rcPERNh9IQwRHxecjUyvHokxRQjPUq/KzqnpALCewS9zD37Ob4IO5mZwcRHkUHohMs0bTt1TidvYelihI74jdrEIuWuMjFxL288enytOY2H+pRGbgKwTDFSoPf4JxPKSaS5no9gzYh2uqzkwtcCO2ykD8Et4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408452; c=relaxed/simple;
	bh=P68516FL20Q73MKJrvoy+KUUJ1cdsXSffNv5b3x6YAY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eQpEuHfOtLBLyk3du/tqf88JVzhZwjpho8DFu5IBlSs7UZCbiGtrCnm1ghMr9BZcChJ2Kcmx3rrSObx1jqSfeGWM9Pnt1TRoCf8CESfyacPQd23SrbPnw4rIm1HQlIjBlwNdKzqDc9eOsAKmoC5CwbBLNrgwvHhZcO9usbTekV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UG2p7037; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43aafafe6b7so2200805e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 06:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740408449; x=1741013249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx79yAQvvtOreEIgXQgmWnaukRcNTY0vcbEckVNMqhA=;
        b=UG2p7037ZKGP2jLzBbvtmbmH6p+4QeJjtUD4CwALbDjCWxx1i6TYevWluhCA7bI2p9
         VnpJ4aeHW8v0s7cnmFB7ExgktkL4WxmiGuwwEZObJ/ONYiwofOA8xjFmokhmwxgEpu87
         /56lF4wTnyJoF3meowETV4e1h9NcgB+xRaQI60F0rexuizMmKLkuy7NYK1bbNw4L20DB
         sZgRdc4K3CLaK0AbSeW6BBNr89sjI9FN7bhaWSMfln8kqp/mAnSDgg90gHmonG0lKME/
         ShRxz90G9wMdjqLXXbZCkuyB9m0JBwgVaoX0DpPwwc2+4FKJbSM91jIKPCzGJwTfx5iR
         ZntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740408449; x=1741013249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx79yAQvvtOreEIgXQgmWnaukRcNTY0vcbEckVNMqhA=;
        b=agSQBtfYriWo4v23Dw+N7sIY5339HHkgHG2C/nt5QanVcBgrhHbpUjPQheQpQe7MSC
         t6uWpnUsRDzF2pL4J9aqvTNAWsi81OAYQQG2XYZg3Dmk0oVd40VOQTWzOuyiRvhiFJDk
         XkGFdE13dKMJQmGW3uq1GFgG8U/rNyG5/rtpuzY6Dpx99gt2tpq3z5xwJK0EGgMbZANH
         LXhEM065JPyG0RWpCaW8rmd9UH9BiCTvA9COWPM2Lx/X2qxlmPY5Zoonz3J5Jxz+ZOB6
         8wZ3+p9CN5gny0vXTeuB3Am3Kb91XNAgDlZrPM6pqZr8/ICqKg9MpooJrE+6tHjJkxiy
         /tYw==
X-Forwarded-Encrypted: i=1; AJvYcCVkM/B5Ezgd8Kai4HRZFdg/gwSltUceoS4QK+960b+NKGq9ZDqWIpMklI02DBFHUyTQ/np7QJM1wAKZ57XmW8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YynNSlpGtL8j3nMK+zMXBOTuSH1HpSdVbkJMIYNpUeGMEp87NUX
	ypoZqcen38wr7GxgY4gsTfVl8zquK/9wwetAWlp/CUJmI+ae6AMTXUMG0xBitjYNiRoMRp45/dC
	Vd9SSKSw4xQ==
X-Google-Smtp-Source: AGHT+IFgzCZS8e4eXhzZ0Xu7b9rwIWCAcRNX6T6m7WXpW/BUkn6CvzEZFi5nDx4xFkLSY1Sid/xnIUacfnELow==
X-Received: from wmqd6.prod.google.com ([2002:a05:600c:34c6:b0:439:98eb:28cd])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:b9b:b0:439:8ef6:5782 with SMTP id 5b1f17b1804b1-439ae1e8be4mr121933775e9.10.1740408449496;
 Mon, 24 Feb 2025 06:47:29 -0800 (PST)
Date: Mon, 24 Feb 2025 14:47:11 +0000
In-Reply-To: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250224-page-alloc-kunit-v1-1-d337bb440889@google.com>
Subject: [PATCH RFC 1/4] kunit: Allocate assertion data with GFP_ATOMIC
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Brendan Jackman <jackmanb@google.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

At present KUnit doesn't handle assertions happening in atomic contexts.
A later commit will add tests that make assertions with spinlocks held.

In preparation, switch to GFP_ATOMIC.

"Just use GFP_ATOMIC" is not generally a solution to this kind of
problem: since it uses up memory reserves, instead it should be only
used when truly needed.

However, for test code that should not be expected to run in production
systems it seems tolerable, given that it avoids creating more complex
APIs.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 lib/kunit/assert.c   | 2 +-
 lib/kunit/resource.c | 2 +-
 lib/kunit/test.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 867aa5c4bccf764757e190948b8e3a2439116786..f08656c5fb247b510c4215445cc307ed1205a96c 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -101,7 +101,7 @@ VISIBLE_IF_KUNIT bool is_literal(const char *text, long long value)
 	if (strlen(text) != len)
 		return false;
 
-	buffer = kmalloc(len+1, GFP_KERNEL);
+	buffer = kmalloc(len+1, GFP_ATOMIC);
 	if (!buffer)
 		return false;
 
diff --git a/lib/kunit/resource.c b/lib/kunit/resource.c
index f0209252b179f8b48d47ecc244c468ed80e23bdc..eac511af4f8d7843d58c4e3976c77a9c4def86a7 100644
--- a/lib/kunit/resource.c
+++ b/lib/kunit/resource.c
@@ -98,7 +98,7 @@ int kunit_add_action(struct kunit *test, void (*action)(void *), void *ctx)
 
 	KUNIT_ASSERT_NOT_NULL_MSG(test, action, "Tried to action a NULL function!");
 
-	action_ctx = kzalloc(sizeof(*action_ctx), GFP_KERNEL);
+	action_ctx = kzalloc(sizeof(*action_ctx), GFP_ATOMIC);
 	if (!action_ctx)
 		return -ENOMEM;
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 146d1b48a0965e8aaddb6162928f408bbb542645..08d0ff51bd85845a08b40cd3933dd588bd10bddf 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -279,7 +279,7 @@ static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
 
 	kunit_set_failure(test);
 
-	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
+	stream = kunit_alloc_string_stream(test, GFP_ATOMIC);
 	if (IS_ERR(stream)) {
 		WARN(true,
 		     "Could not allocate stream to print failed assertion in %s:%d\n",

-- 
2.48.1.601.g30ceb7b040-goog


