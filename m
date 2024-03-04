Return-Path: <linux-kselftest+bounces-5847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F666870934
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 19:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91DA81C23BEC
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 18:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADB7626D5;
	Mon,  4 Mar 2024 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iD/WO5Y8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A558626C7
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Mar 2024 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575919; cv=none; b=lXO8MSgafTYz51yV/Du2Sh64qZQHh1Szt3K25kLC8yglEoC7XUs1vBx0XIXMbYjEMH9QHiS5eMbddzYLacQScm7oi1/SDbUWmCHWlX4mPIYfMjDgQdtuR1/5Hc627HruiQyPNgzIel+LaAf56BgAY9fgkBUFS5TqKhoLByqTKRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575919; c=relaxed/simple;
	bh=FqLV9lNiSU7gSVzmh0RUNwWYr0jxygkZHnJe2yCKIHk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EnY+e2Np1EepXK2W+IAcl4DnQENcd/gVFBe0l9DNvXQj8xUmF2P9ysvFCoQk0oxRSYe8lfd8eQ0Dpzdl+0WDeDQj7pEfmGVI18QRPWkgEN3EGgthLRJ00NMpHSXsoWVyggeUbWB2Ot2k+cNn1oomFB0Mt35hlKmLx1ItiQB0Msg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iD/WO5Y8; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e4867c8ea5so4741842b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Mar 2024 10:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709575917; x=1710180717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+K8qGGJZU0dVFlAnq42rJW59Laz5svfdA3lu6VKJprE=;
        b=iD/WO5Y8KkmuAscQ9e4EZbwDgCDT9i4D9nGIF0YtbxoP7oW8KvKsLvxBMqkE++Y65Y
         5XsHf0AwxpAcwakxfWmtNn82Umw/Zsc9cVo6rlDrf5e3twXtnZA/ssoaSulfpSnROXfO
         uTy0aUCEFi7L0UlINx5ILgOyJFlOSKlS1IQGbBLt4Up8xI0sQGERCb27i6odUYEoiWkB
         HAaRlXQ/yHC4Fh+9DCSyIkZEDmhE0emyPQs9QFFKT7W0hfrp/X7cW2xRf+JOgl2vmKC8
         BBYxSY48k+LjHTnyRAsy8h1a0jnOKP+rb/OW+zUBgm5N5H17SRy4dV6HE925MFd3tsBT
         Awvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709575917; x=1710180717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+K8qGGJZU0dVFlAnq42rJW59Laz5svfdA3lu6VKJprE=;
        b=UOmx/zErVgYnPns0/FBAODkFhl0agEwqCzujwnhhAF8/DX0qqTfZ0sfay9RgPAJeCu
         gsS1bezw4uo2KhzrM94GDOdVwONLPOrxRRhKr1EM3kDsXhcBvdcmwbJs/cILIAAIR5wQ
         xYfG03NtcCFdgqRxN8E62psP5tsF9eSsvxmakhvcjcZQwSTvpeITZvQ/zdMucx3+zSQC
         Vse+H5jvPEN/iyfxUaFJGjZs0ctA+kfEelaYEmodD99wAEOV1/xvhGnCkrY3LqIGPwuz
         tjy6Ptp6fXZaQ2FIwKz5LT1hhpHpmayUK42nnsswao8yE3RLpnMsIaFEjjSj45HZV/Y7
         62kw==
X-Gm-Message-State: AOJu0YwiUqB7IXTyEjxujXEYsbH8Btwr5g1CudjJ7/zy4KTNwpsgo74T
	rDmXUIyqxkurVXxwpzcascLpbeEDN1o/WzQs3V4xTYBGeQMI3LAA9BayBobkYkOnwULwqK+owNK
	thQ==
X-Google-Smtp-Source: AGHT+IEBwRfcpn5x9AGNzJLGA/hp7XJkS1FIgFGPUMaa1opevJ7wVveO9HifQjBfzJMQbCakv4yNwPEcBGY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:27a0:b0:6e5:8053:af92 with SMTP id
 bd32-20020a056a0027a000b006e58053af92mr788006pfb.4.1709575917445; Mon, 04 Mar
 2024 10:11:57 -0800 (PST)
Date: Mon,  4 Mar 2024 18:11:34 +0000
In-Reply-To: <20240304181140.644212-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304181140.644212-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240304181140.644212-4-edliaw@google.com>
Subject: [PATCH v1 3/3] selftests/timers/posix_timers: Use llabs for long long
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fixes clang warning: absolute value function 'abs' given an argument of
type 'long long' but has parameter of type 'int' which may cause
truncation of value.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/timers/posix_timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 0f550fc9e879..78b4b2d3dc44 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -82,7 +82,7 @@ static int check_diff(struct timeval start, struct timeval end)
 	diff = end.tv_usec - start.tv_usec;
 	diff += (end.tv_sec - start.tv_sec) * USECS_PER_SEC;
 
-	if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2)
+	if (llabs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2)
 		return -1;
 
 	return 0;
-- 
2.44.0.rc1.240.g4c46232300-goog


