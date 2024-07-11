Return-Path: <linux-kselftest+bounces-13619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CC992EFD2
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 21:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91471C22D42
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 19:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54F7186E25;
	Thu, 11 Jul 2024 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rbrbjbZ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC8717CA01
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726765; cv=none; b=kb4CQRg5ykKVvvJDKEOrsMt+T9FBO0jxeeuzClIEbkR7xGerlevmPKF+q/DPvvvsYF0KVQNGKsthSzPIXZFWR0ChXMtPsZTcfCFwEIfvUiZDWLjyRMd13IbaqoLK3MM8it1OgsD7FbhYE3OJv0XRFJzKiyIDpYhr4ZKMZt5Q+A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726765; c=relaxed/simple;
	bh=77Fle0UxEK6EwAcqoaNanQHiVkg19YWm2CKEwPFrX+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SiYGTWKckDNyYg7Sunuqt/6OVSJr4rDAwYMxnz7P0VDh7PGBU9yr6sIyqCAtktil6TL0XXCKOIYzSRA+V1ic2MWvi8EVJHXod9HEZxrpZtRxaEqeRe9tn7OTH6+a4x3nP4Cut/BXXA8dvVj+UJ1ViWbG1RBYhO9MzEf1UhyZoYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rbrbjbZ7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-654c14abdcfso22868557b3.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720726763; x=1721331563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jOuOZKjw/4Tx33ZawZRx4a+P5bBTfvgvLFnSHZM5EMU=;
        b=rbrbjbZ7GU6ThAd4loYZpzf9T5nChFt8bqFP0XYg7qzHgdI1xs9WtsMkJZ6/hKEyCa
         bQIhHAP3YVhrA5Owg10JSfhBpwVwvx4FN8xLjZmnhMIRdYGWJyagypxmdGeMb1W/7Vw2
         7K23EZSa5oLFweeEJZJ98qspTQpzmma9L+IWxGuWY+LD+O2pzv43y0rNMBoMTbEmXIHK
         yXXMcYgZej05kU7zLTbU6ixC4ORLOrR4LuwptVRnrOgMzOb+UWi7KsGgGjcdf09J0X8o
         99Eti/RCK8gm0yVluuqbACd2q2i6yhRFkQOSy1NOwM2T87EhueKudOoZPFlIxMY+JMT0
         X2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720726763; x=1721331563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOuOZKjw/4Tx33ZawZRx4a+P5bBTfvgvLFnSHZM5EMU=;
        b=EvleNDy2PSGHxD+SXjDKA21VFWnJuQ4M8gu3ZPwKMjqZCpiwVR59LUnMXHEomcORdF
         MO1URXXJjngQbe5kvebJhKL329EDg+7Z4yEFUJ1cSfHJKypn2sDFtPKmnrTD/t6xDmPE
         W4m2uAIQm5oHp1noqHd7249ROJ2cDXQR/Wf//YRLoVASXYpq/4nayxCnZgk4c8Gvn2J7
         b9iMpdeofGzHbE1zh945c4zz6WrHK05C2YmypmSm6RlPd1iZ1y2Xc+SRJYYBkcz69yrH
         x6TvVGyV61fRfY328H63wa1Xyim8PHcjbrGETNVL+UIzBEqCoFtXGfmKKxU1b24ZM5SU
         ktEQ==
X-Gm-Message-State: AOJu0YyJhm5Nh1xx2WKbHPLgpsVDI1LI6Uav4ssNQ39mK294cCm4WeL9
	FI0r/NrQqIx1sz8JssamoSq5R9jkAqYiJw88BC5e/aZEtUtiyg2hjt9yrzRSVSIlKJCTbYNqAbV
	643wIgu4qjk3Is/exlg==
X-Google-Smtp-Source: AGHT+IH6KHs598qSeIBPsOGu8UPNk+DERfUoNF6Ncsl21ateD2j5KJKs5jvjqp/cn3t/zbMtdixdYO8tAx/HfDEZ
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a25:8447:0:b0:e03:5e58:489b with SMTP
 id 3f1490d57ef6-e058a62eb69mr2360276.3.1720726763466; Thu, 11 Jul 2024
 12:39:23 -0700 (PDT)
Date: Thu, 11 Jul 2024 19:39:17 +0000
In-Reply-To: <20240711193729.108720-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711193729.108720-1-ericchancf@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711193917.109380-1-ericchancf@google.com>
Subject: [PATCH v2 1/3] kunit: Fix the comment of KUNIT_ASSERT_STRNEQ as assertion
From: Eric Chan <ericchancf@google.com>
To: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

The current comment for KUNIT_ASSERT_STRNEQ incorrectly describes it as
an expectation. Since KUNIT_ASSERT_STRNEQ is an assertion, updates the
comment to correctly refer to it as such.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
 include/kunit/test.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 61637ef32302..87a232421089 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1420,12 +1420,12 @@ do {									       \
 				   ##__VA_ARGS__)
 
 /**
- * KUNIT_ASSERT_STRNEQ() - Expects that strings @left and @right are not equal.
+ * KUNIT_ASSERT_STRNEQ() - An assertion that strings @left and @right are not equal.
  * @test: The test context object.
  * @left: an arbitrary expression that evaluates to a null terminated string.
  * @right: an arbitrary expression that evaluates to a null terminated string.
  *
- * Sets an expectation that the values that @left and @right evaluate to are
+ * Sets an assertion that the values that @left and @right evaluate to are
  * not equal. This is semantically equivalent to
  * KUNIT_ASSERT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_ASSERT_TRUE()
  * for more information.
-- 
2.45.2.993.g49e7a77208-goog


