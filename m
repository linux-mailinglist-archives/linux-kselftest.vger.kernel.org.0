Return-Path: <linux-kselftest+bounces-9878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75A68C16FA
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFFD1C21F5C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD75B145340;
	Thu,  9 May 2024 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8UZtc+A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB1145323
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285011; cv=none; b=Tq6KCFkby2ljKdKF2SxdSs+HvIJmiivR9j9ovOs9Rb9NdfSmb1dKuX2E5KQ1tecuJ1PMBJBlmothG37y0NdWXZU9eaVeXI+wRB2F4pCB0wGWWJLBhsW/B6/H2q7M8fAAtdEep4dWwmEuEtT46ThXQDv0EWMdYLBXivrn1KmkvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285011; c=relaxed/simple;
	bh=Y8SFAJF8jQkO7mNCEqRJH0HVbnxlIXsW26AJJDoR4VQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G8HA+Sv3M77PZd+C/l6PW591KWZ6Nmzln/qLefIR7NYoXKmXv9oQIs41JN/wRRofJlcEp406JiH3VJllz+SrXmKPeYIVyycnexp/EShk8pKtGtPnW/EO4iLHft9vyIB52gnFEa9UXRaalmb7DLTvsryheKoJxxniiWqP4lpxMBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h8UZtc+A; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-620a2321b0fso14058977b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285009; x=1715889809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfT8qWvNcb63HQewAHiwqXaD9aYY1/jM+kGh6QEdnYY=;
        b=h8UZtc+AzzCY12XZM/j1jdu7sC+TPus2DsyfSR9CJzPtwLdg0RZHorzCoEr8IgXLp0
         3SqCsNmOtlzPhP7iLqHjoSCxHkYXyOxwi7ppsBlZH4C04IChGvSXxb82szRFQfNXqkTS
         scBemKx88t0zf9jOlT1H8gQAKnQbYd5EO20XCXVONKX71xyGkyyZTCQU/sslP7nj7sfo
         mNvGTx4gFQjf8bFXlrMFBDLXslpLaXeM3NeymP+XYQp77RJNcF/pwgd86InQJpd6mv1P
         EOKMI5rz+RSYzpPBL0bSdVNUOGXrax4HNO/+btuH8snhMUvxBAc+OYSx+skdpifzckmB
         3CTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285009; x=1715889809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfT8qWvNcb63HQewAHiwqXaD9aYY1/jM+kGh6QEdnYY=;
        b=aAnmUzE5KyYViXZfh8YcFzSaEK+0+367HsBvC3AabLz+XuMg7N4Zy6APvG9FGIH1WA
         ngj3EHckxNEZ0zjxyR6cXZPgq/KF/KKJbPqvSbqd/Tx7ToYAsEt8qBgDd/F0se4HSwen
         Yh3QddjK4mQ2OkYNOfU0iKXNjjgTDGCY4OOjwDUmhcIyPT13jk0dZTgoIZB5wMular1l
         2P8hLcaxqI+l3XYvq/FbCxta7ommdcVCCdAYijmYHHRqFh00Cm0vK/eZ1pLRkYjBxP/r
         cKdQxfxEuoQYl6n+qlC2vpyY+RkZWKyONBWdqPH0RE0rSL+Ap2zU+bGsH21R/5PU3pOi
         VQsA==
X-Forwarded-Encrypted: i=1; AJvYcCXBH+u5O7JU5BcZuOmjpEnJCwCPEFKulCQf+IlLFIrHxaU5MRRr5NGSPfHFVMIhsAdrFLgXO1ndtypvKg/VxfPvJt9VLo1ipJ2q2vN51peR
X-Gm-Message-State: AOJu0YxE91qWItA33amKAIX0kKgs6u5iO5OB3uIsfSZrVSVlJU2iJFgH
	btj9zY5PoZNEylWi4RBQVBEwkG0rwf2qw1XAdJH/fnl4uRrW5g4r5WOK+eYJh64u48zUaCAG5yc
	aLg==
X-Google-Smtp-Source: AGHT+IHB9tkCXkbQWJCekpHx7CFvQJIi03So2EwcHyZ97laLqO9YTdxhTKI/29nDkVJsDfnAEGuoDne26cQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:6d0b:b0:61b:ed85:5d3f with SMTP id
 00721157ae682-622b014b981mr1366387b3.10.1715285009033; Thu, 09 May 2024
 13:03:29 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:47 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-56-edliaw@google.com>
Subject: [PATCH v3 55/68] selftests/safesetid: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/safesetid/safesetid-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index eb9bf0aee951..89b9d83b76f6 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <pwd.h>
-- 
2.45.0.118.g7fe29c98d7-goog


