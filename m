Return-Path: <linux-kselftest+bounces-7618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6508A8A0406
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE851F2256E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 23:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0281C3F8F1;
	Wed, 10 Apr 2024 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2bAxsRGs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD663A1CF
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791607; cv=none; b=J7rehGTpzvzu2nKL0HGXDsy7LdqDMCm9le5rtyuHjcWRYZhwv6V4x+V+VQp3f6+dYq62PE3OG8lHwKu4bwtPsuxH/fjAfwp6eTAaznvE7P1Y6mCj5YuWmY/BJ6paM0xPXHRS1vRDPn/wvdaW+Q15Gr4PmlKFetcUeCB1GR6FaTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791607; c=relaxed/simple;
	bh=QVx11GFaCCb7N4Yio7fGICCAENUW3V/BWi5Vnx+PoZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cVSMhUISaT/aOvx2qQOA+lZfSl16ap9kGkOnNp118BWZTPBPinB0GIwoG/ja1N2+ugbv+UhY1KEVwX4vorIRXN42ntX9Kd5DuGZjkE/x/dR8fqYXMejWe0jEwEcBa03BhJaUMMaTUGRY7yoUbcETuQSG72RZ1Lg28meyTAtZ8F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2bAxsRGs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e41c665bb2so30671425ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 16:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712791606; x=1713396406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YqMlKesOrPLSfKThat23VwjdSe9gCiof2Hkve//abGE=;
        b=2bAxsRGs/vAdnVweQ+LLBJ6rSvemZw9Iv/VYWQij7estfWltypbn51JkVgHb1z30DK
         JBgx063VJ4PIkSTROBL5m2smau21aSUKqVbV5G+3mMO4K+U3YTPNcHFECyKGjC/RMKNP
         939UEp98XTzhXBqV5So7ZxkoEdsKeMRFYdYw6mDFYG/6+9T21ApLAL8TBuMKDOZrwif5
         fCsp0urUhTy9yIsz9u6lYmKf41xhWUYDASELO7KBeSA5mIpcOY+yoqA87mATeThAhn2R
         hX2Z/ARNtPrYrGAC31tdF4MdoNIHqxWqng8wC/8qhvual0Aadqnf40bSMgqcbq2C+Pya
         U7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712791606; x=1713396406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqMlKesOrPLSfKThat23VwjdSe9gCiof2Hkve//abGE=;
        b=Q8zDlcUzChSFlSuBFr6+T/9ssxvMLG+Nrcg+etCcoR3BaQ5W4t9TgqXiQvo+/hpDxY
         8qmMOtwylPmd/dF2p5umIhv5bkYheWr8pC8L0g4wS2BntTpx4ER9HybYgHH9sbey7F9O
         yY4mIkm6bAX/D5JZ8AO4Bxh09hi2b7Z+u0OwE68Ov4fNPQtuMncCQ1MRxp5HQqZ9nfaf
         36mXaZk4E4FW6j6prD9FEnUDzNvsn5vPBng2gj3SVqU64F0Oz4zV8GRvRUZYbrsUQWiE
         9am5gq0BkxuMw6vomuLhQuFfk8zsD5P4coBJyspwAv/xfL8mtySzcj//8Cucn5bzHoDa
         jMwA==
X-Forwarded-Encrypted: i=1; AJvYcCU4O7wn/wpHWkmF6X7xuS+3AVZIh4oGbpdIZTtAZEVlhGAgnypF1xBn0rO+Li7FFJA2JfpZYsJHxOigkqmPobdwVg57AUdqegyZ3CL70+Mj
X-Gm-Message-State: AOJu0YyCn9OGuWS0ULvYN0AUb6csKVykuQ5jz7TpVNjQICHkxDnVhvnK
	REvrdEvNxfvY7RuL6sKkv8xrozpwP5ZNpShaZxLKYbq4m2wRF/GLJFw9l9o2Ru8m+wjJS6wYeVA
	0w1e3
X-Google-Smtp-Source: AGHT+IHouF3P+iPzjB2QiKGl6ZZPLBEONmG9rrx+ed3xbWsI4elR12lweA0nFbIvZPSYd5HufyBuz5M+ZKmN
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:e80c:b0:1e0:feef:5c1d with SMTP id
 u12-20020a170902e80c00b001e0feef5c1dmr311262plg.10.1712791605672; Wed, 10 Apr
 2024 16:26:45 -0700 (PDT)
Date: Wed, 10 Apr 2024 16:26:30 -0700
In-Reply-To: <20240410232637.4135564-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410232637.4135564-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240410232637.4135564-3-jstultz@google.com>
Subject: [PATCH 3/3] selftests: timers: Fix abs() warning in posix_timers test
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Shuah Khan <shuah@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, kernel-team@android.com, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Building with clang, I'm seeing:
posix_timers.c:69:6: warning: absolute value function 'abs' given an
argument of type 'long long' but has parameter of type 'int' which may
cause truncation of value [-Wabsolute-value]
        if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
            ^

So switch to using llabs() instead.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Edward Liaw <edliaw@google.com>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: kernel-team@android.com
Cc: linux-kselftest@vger.kernel.org
Fixes: 0bc4b0cf1570 ("selftests: add basic posix timers selftests")
Signed-off-by: John Stultz <jstultz@google.com>
---
 tools/testing/selftests/timers/posix_timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 348f47176e0a..c001dd79179d 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -66,7 +66,7 @@ static int check_diff(struct timeval start, struct timeval end)
 	diff = end.tv_usec - start.tv_usec;
 	diff += (end.tv_sec - start.tv_sec) * USECS_PER_SEC;
 
-	if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
+	if (llabs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
 		printf("Diff too high: %lld..", diff);
 		return -1;
 	}
-- 
2.44.0.478.gd926399ef9-goog


