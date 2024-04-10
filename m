Return-Path: <linux-kselftest+bounces-7617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC228A0404
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2302816A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 23:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6535A39FFB;
	Wed, 10 Apr 2024 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8nxfyCx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7183335DB
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791606; cv=none; b=SFuEUA/K45UwvXeePMGoBkJfJUehn4gD3P93iinhF33Jy/NJJn/ZirGZ8TdDB/2ywtr+FcVR7zZOVIl5oZrcnjcr3YThaq6+ZRT0tVnNkH3Ebb8QEa2KDOtOa1RrriBNaCCfonsj9dz/hO/xIZ4yDU7XlbM1Kgcn7CB2Sj+AuWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791606; c=relaxed/simple;
	bh=VoLCsCIDC0AKpRM6tLqdI9FChyNA7KdpvNzq3N9K8Qg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JTe3BtPhq7mGRYKZVF1bZFN/Yn0wkCvY6ndpRdoHZcpvjqLh69PhBTMEr238kgyUY+JEaVP9t46GR6yFcZFE6espwim1AHrfKv6pouDgxFOLwQyRNwSwzLXVFZxSWDzllU9n6BPuIHKKJH4N8C6aRO0PlRNvqglhgkUAdV+aV/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B8nxfyCx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so12026273276.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 16:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712791604; x=1713396404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zlurd5WmAU6KZdndMyIzN+3lsSewcbke/BSJIsyJm9I=;
        b=B8nxfyCxhDMThVF8zrt7SlovVFFHXvqnZ3GmzKuwzdPdWMG9HPNltDFwfxYkkCiRxU
         NNIK+zVM0AIDmui549+UA/PEgS801IW0MJlyVDye3dCdHUTd+o5R9SmDQ7LleNbATH8L
         EcQVo9AGQ59obMXD4eT8A1oRES0Rbuxd2pcvdW6Y/58tWuhnotdjrph3G++4ncTGYlg/
         J2hfQkGmQVImjSkEuamjDFFyNC36nEP0rscpSG9Og7COoOql5Ya0LvwusPsXAo4RFPUe
         dOqCXd0II4ZGmVtPMmz7v6cnFxvnBiwW09SZHxxSfZbV7vMmuKJOt8bnuflCyPAlsn8c
         vK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712791604; x=1713396404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zlurd5WmAU6KZdndMyIzN+3lsSewcbke/BSJIsyJm9I=;
        b=cLLII67Lt0iY2djlj3VK7Z4vY7NeEfi7Dxw1h2BQcmbdEtCYIUBa/QkyFNz6fDkre+
         8MLPMfCELvLbnC2Izdjpudik1+RngSCNBq/Px4FqhuPFmLQ8mpyhafgnqUhauzI+lxn6
         qnbiOwV2BmA38hzi+/XVs0Fur5vi/E7QRTF/7lcjvnR21/cRPJVSl5vMa+zKjdNZwKiz
         JgSP3Ji8mGPkBfn1MjYaBwTktDKsIfC3AegjxqmaPESE+HpUCLWpXcgixuowGJqyAHc+
         W+yaQ/pzdVvm6XQYreKLxAzK+9ysvGjZlV0x9zecXgM16iAT/sK+lhuepIZSnwvYHwvY
         143g==
X-Forwarded-Encrypted: i=1; AJvYcCVDR99+aZ2zHr1MkLJndmrRq7lawh+yvQi2uYbi97uND+OFC1dThgMoFolVEB0DYqGluRuhaJSdxIf+pZ32DssxuezYZfbXOxG9fW6+9Et2
X-Gm-Message-State: AOJu0YzPVOIA+ceG7+kWr2u5gsfeGsBSFBDbRDQcyIVbRcj5gSg4UquU
	29jmowB4taDzOZi2jEU/kCmvR/Nfsc4UvrvHsIfdi8eEvtmaYuR8AXXp0pFxHL9sCW/HTyEw8A6
	VFzRx
X-Google-Smtp-Source: AGHT+IHlbDC6ToGv1bXxA7Ao7B2WmThFk0HhdVs5BWSwsysizqGhpLzvpd+POKg06SuokF65H5Kbm0yuXOGl
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:a124:0:b0:dcc:54d0:85e0 with SMTP id
 z33-20020a25a124000000b00dcc54d085e0mr1134663ybh.11.1712791603824; Wed, 10
 Apr 2024 16:26:43 -0700 (PDT)
Date: Wed, 10 Apr 2024 16:26:29 -0700
In-Reply-To: <20240410232637.4135564-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410232637.4135564-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240410232637.4135564-2-jstultz@google.com>
Subject: [PATCH 2/3] selftests: timers: Fix uninitialized variable warning in ksft_min_kernel_version
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

Building with clang, I see the following warning:

In file included from posix_timers.c:17:
./../kselftest.h:398:6: warning: variable 'major' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
        if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
            ^~~~~~~~~~~~
./../kselftest.h:401:9: note: uninitialized use occurs here
        return major > min_major || (major == min_major && minor >= min_minor);
               ^~~~~

This is a bit of a red-herring as if the uname() call did fail,
we would hit ksft_exit_fail_msg() which should exit.

But to make clang happpy, lets initialize the major/minor values
to zero.

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
Fixes: 6d029c25b71f ("selftests/timers/posix_timers: Reimplement check_timer_distribution()")
Signed-off-by: John Stultz <jstultz@google.com>
---
 tools/testing/selftests/kselftest.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 973b18e156b2..12e2f3ab8b13 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -392,7 +392,7 @@ static inline __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
 static inline int ksft_min_kernel_version(unsigned int min_major,
 					  unsigned int min_minor)
 {
-	unsigned int major, minor;
+	unsigned int major = 0, minor = 0;
 	struct utsname info;
 
 	if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
-- 
2.44.0.478.gd926399ef9-goog


