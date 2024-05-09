Return-Path: <linux-kselftest+bounces-9881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A308C1707
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB271F213F4
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E561B145B22;
	Thu,  9 May 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJVqKCP2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3D9145B07
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285017; cv=none; b=abto8+NQDJta96TUCyP+vzAz0HwdG0z2xOpKGze3WksNjxZaehtIl+cleIx3J4sCJOoxCXjyOqdboubo1ajZl0uleCQd/RzYYn8Bai92gWfMNuYr27DsLUKMavbWE0OmLRjcsgXUf/BR5HB5WVD09Wogp0Hn7owkCZ2SpopLqLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285017; c=relaxed/simple;
	bh=I8yGuW/KXCCT2ylL6gzPoz665BMtEAWkOpPaq+pMnm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uuqtofcC02eTGLd34pLM6A73/+yjmV9uCFvASLcIWTc+l/ym2kVbjlqdqL4W6l5HKqlehl1rxlP/KHvgM6fugOkKQNOra3jP0fOvGuGACN8a4uB5WNW7Afto9zSDqitOQs8y1qnx8nOe1FWL03r4aqa13geHA0/j9mhE6sraDKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dJVqKCP2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-61c3d0d13d3so1640701a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285016; x=1715889816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xEcgXmlghWsxQT9HZckvmES1mnfU4TIKjOLdePjkrYM=;
        b=dJVqKCP2vwIH/vfv1rqkZGJqYyq2706ApG7kGGU3RJBtCkco7mG+D/uy6HATBz+5Po
         kK3SDuuATALAZIbBAeqmfnTTltqr13OP/r3CLyQ+zpGgz60HNc1XTVcnju2yXQ7N+WX3
         8N+HCuQYdYPE5Bg6YoQyp+goa1R89rA9xrCXaV+quJe85Y9tFWtjxyQ3mpziHYZIWkaT
         vBWFlb/Vq9o0UGbpRFJ1gypBQr7FQwqSOHgHWE4w0VwppzJ6QTBkfFwnQi/iPh2rAPT9
         QM9jr+wOvrNfyWD4yLvivqMqmh4bdwaqM8eazvKlbFfXGelnhmNVhbDCY0WhFe2LFv/T
         1TYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285016; x=1715889816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEcgXmlghWsxQT9HZckvmES1mnfU4TIKjOLdePjkrYM=;
        b=wJyknF1jVBHzM0rBV0GhEmSsYI/sBqFx3ceYPNc4aPe9NqxTZyZMhBj1hUeGTDQ/rE
         bqtFqf2pHJOFJuwntpW8G2E/3jViJ+8nwxxWQuA98vT7HqssoOZWIOoKP/Hev1YmH7v9
         CpsbceT5gco2+b8xsD8sviePq+eY6eNijw6x0DKY9uAulFfmOtJ78iizDOgb9kAXTV8e
         ifdulr9FhmOpWWR4M8OShdKYiMtpNQeh2GYYLY5c5hCBn44CIzMMoOW6EFsv6qtRxUOO
         2kB+sCFx5z+JbThm0iE6FSvkSPJLifbA24JHO3KutTjZN9KE+8fK2bjm46DOqSMjfj3J
         iO/A==
X-Forwarded-Encrypted: i=1; AJvYcCUZEAS8xDBJFJNt24m0HkacXrKCo5mrYGJK4L+8Y7odinEugP+o4slu3lEVTqEBwkfhl75ESISV9tQI0irc7I8wqvQsxqxNsDIBNOQI7m54
X-Gm-Message-State: AOJu0YxKAeY2nKVFk9q5PhkoH2s0JXbuLE7MjQ/MmfY6I387HD63js4i
	o16t/pQII2281HOlDecJ7VrUiDbhiIHPelYrIUlPc3UkLioCOvLpqUmP9ne52QaPG0iFceFvOEX
	UMA==
X-Google-Smtp-Source: AGHT+IHTECOTBaYQhqNZfIW+fB7Q9TJWNGlGeyv6Oslt4KegdwxZAJ9Uq25W0NLahxVsi9SF18hcwHJJfh4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:11d2:b0:1e6:624c:f1b8 with SMTP id
 d9443c01a7336-1ef425511a6mr278815ad.0.1715285015792; Thu, 09 May 2024
 13:03:35 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:50 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-59-edliaw@google.com>
Subject: [PATCH v3 58/68] selftests/sigaltstack: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/sigaltstack/sas.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index 07227fab1cc9..36b510de0195 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -6,8 +6,6 @@
  * If that succeeds, then swapcontext() can be used inside sighandler safely.
  *
  */
-
-#define _GNU_SOURCE
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.45.0.118.g7fe29c98d7-goog


