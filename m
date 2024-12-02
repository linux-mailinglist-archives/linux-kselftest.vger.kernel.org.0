Return-Path: <linux-kselftest+bounces-22663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBCE9DFB87
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 08:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6354F281D48
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 07:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA471FA27C;
	Mon,  2 Dec 2024 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYuT5Omx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8921F9F44
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126182; cv=none; b=WHJYqkC+FiMm1XtDpmrkKfs3YOERK9sfTEDYE3RoC+c6hEDaBcercDqWRhxU+dQgm2scjl6PRjDTo6eu5KYRkiiVVHQx7HBRNim9Q/hO8TePRCKwJ2SCGUp+yx7hKND9N6J18WRr8P1L9EKBaJxSKPn4IE0o2VeUbjNPDfhaSVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126182; c=relaxed/simple;
	bh=dYBmGjG7TB2Z2VTBpBo4NiT/h3qkUXZhtiO29o0GA0s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hUMcEeyBq7qOvaqv4cTVYMOd/jW6rl7f+EdHSUkRu1G3Yg7egKPHatTfekI814ECPXMjW7VwHB1l+7W97e9IVPjhl54KplUzRtpdZVQAlgmx0t4lwfsFhMf8c8I/EeGJccYMFuf5QbZlYhetiEplqO5ueVHcEW+Y6XE08rIb/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UYuT5Omx; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-72513206509so3257148b3a.1
        for <linux-kselftest@vger.kernel.org>; Sun, 01 Dec 2024 23:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733126180; x=1733730980; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n/Fu3FFqzv02/EfRgjAc3Ov0VLZBVqY8Qq+UC5wZkhA=;
        b=UYuT5OmxC2n+QOygsL/0E/GCqYrKMtkLoW+3y5EJOdt5PzyhQpOPknh0j3AsLzzgOn
         fPfGOC6NagPxmbTy9NzDTZ+UIUD+7Lv6ucWP2V+hbAyakkXryZtJL1zwZa8x+N+0ZLfL
         +ljBAX7MA/Q1VCqCcvSv777jY1wm1oNwUwkFJIF9kMLs4jrEZGScZEL47YEBp5uHdh3g
         /VjaGBQHYdJmuf2JbJ5LnN88Mda9M7AbylADSJ1IJlcTadaSnoyDR1U4kDVdesut1h19
         EA1o2QebRkol/d1THYET7MBg+x5G+QUkkjZhDLYlMwKQqfNVtW+0CMo+DxiB/HX3fA9A
         WwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733126180; x=1733730980;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/Fu3FFqzv02/EfRgjAc3Ov0VLZBVqY8Qq+UC5wZkhA=;
        b=a6BnX5qnv1TGgzi2jnmoc7TjpuL0V1+dqc529UW5816dWEiBqrLjo5//ZoGXdZFLur
         KcVI0cz+xG0+NEDm+71jXbHkTygDP4s4J4ut4XHAEbHwrnuByvySurYhrQkIVZYRzluF
         2GoYfoWmi7axSsWB5DrOda03/YNatPXFgb5gwhsr186vAOvWbRQD1dGbE8tl30m4t/O1
         JQQkzrcGimfDXvOuAuqxhbx++LyUAhhgbLVnFzn9OyHrrDjQ9D07dqCxiQzDviWlzdbb
         lRIZsAKjJGRt/KKqzfy0VwuapU0ffrFD213NGTzAqQwCk1frCAd08m1r2n+SECc4t7vf
         rOtA==
X-Forwarded-Encrypted: i=1; AJvYcCV8GaXznw8r8maNVVmvioJqcoR/XqThTrE+OTR0z57OFAiOfmmT353UV+RWNCnlEaW02MLnPKtVvs0wky7fltg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzI0+LmpTOdFckUyitTaOouB4d2aci3jqDgWt8Z6knTLYlrI05
	34JznPnOFIe07xzxDQA5viWKWBbIRSmgdk6JZdvl3dhJLd+QuqkaQMcKqiryzfby2PzlxK2QsiJ
	IL06mTDbTXw==
X-Google-Smtp-Source: AGHT+IF1WZ6Fbz8ZiSSZi2gGcjDGpwxFUu7RJNqMBynLmZMg0QQlHpZzp9a7a3eKlZn/KYL6wsr317d6AQNeHw==
X-Received: from pjbtb14.prod.google.com ([2002:a17:90b:53ce:b0:2ea:7174:2101])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7898:b0:1db:e3f6:55f with SMTP id adf61e73a8af0-1e0e0ac4090mr34409102637.18.1733126180307;
 Sun, 01 Dec 2024 23:56:20 -0800 (PST)
Date: Mon,  2 Dec 2024 15:55:43 +0800
In-Reply-To: <20241202075545.3648096-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241202075545.3648096-1-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202075545.3648096-7-davidgow@google.com>
Subject: [PATCH v2 6/6] unicode: kunit: change tests filename and path
From: David Gow <davidgow@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Rae Moar <rmoar@google.com>, Kees Cook <kees@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Gabriela Bittencourt <gbittencourt@lkcamp.dev>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Andy Shevchenko <andy@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Pedro Orlando <porlando@lkcamp.dev>, 
	Danilo Pereira <dpereira@lkcamp.dev>, David Gow <davidgow@google.com>, 
	Gabriel Krisman Bertazi <krisman@suse.de>
Content-Type: text/plain; charset="UTF-8"

From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>

Change utf8 kunit test filename and path to follow the style
convention on Documentation/dev-tools/kunit/style.rst

Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
Reviewed-by: David Gow <davidgow@google.com>
Acked-by: Gabriel Krisman Bertazi <krisman@suse.de>
[Rebased, fixed module build (Gabriel Krisman Bertazi)]
Signed-off-by: David Gow <davidgow@google.com>
---
 fs/unicode/Makefile                                | 2 +-
 fs/unicode/{ => tests}/.kunitconfig                | 0
 fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename fs/unicode/{ => tests}/.kunitconfig (100%)
 rename fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} (100%)

diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index 37bbcbc628a1..d95be7fb9f6b 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
 obj-y			+= unicode.o
 endif
 obj-$(CONFIG_UNICODE)	+= utf8data.o
-obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
+obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += tests/utf8_kunit.o
 
 unicode-y := utf8-norm.o utf8-core.o
 
diff --git a/fs/unicode/.kunitconfig b/fs/unicode/tests/.kunitconfig
similarity index 100%
rename from fs/unicode/.kunitconfig
rename to fs/unicode/tests/.kunitconfig
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/tests/utf8_kunit.c
similarity index 100%
rename from fs/unicode/utf8-selftest.c
rename to fs/unicode/tests/utf8_kunit.c
-- 
2.47.0.338.g60cca15819-goog


