Return-Path: <linux-kselftest+bounces-44023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5337C07D50
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 21:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C851894FDC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 19:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFBC3375DD;
	Fri, 24 Oct 2025 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="byFivHe7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB32229B2E
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761332473; cv=none; b=bYW3+q7mDitr0i4Q35Zy5zBcLD1QSkqm2h0lOBGGf+VubK0BfxPucdS1YlJMzY5qMZg9htA8qt+dYg7y+Zl+12KXb1DJicSNzvF6V15HpO1TymFORLq4JZ+Ol+nnP5XAE0S6YN31ig+esXg3n1NdrNWUhUb36CSTUyzN+552tpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761332473; c=relaxed/simple;
	bh=HX6EQnKcolO/j1E2XrmMEXhrxKNhp5wrM2JfBRBCHIY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=X1vxMoiaukVwJIzTPpfb5Edp6hl7c91iOOEAiUxicgeSe5DGDnbjpNJhfoVnFy3ntG4YkBwWRbztqTRuNm+WUxfGbZJ6YiKGfXlO66s+9KAjqJPSaBiaI5gNOiygMPQl9WyMWk6KjHdQS78eHtO5IvXDWuGUJAE+mHLG6C55MjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=byFivHe7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29085106b99so24968475ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761332471; x=1761937271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y8waxpIQ8zGohuhfEK0FchG05acb+4DM6iQ/kzGyRAg=;
        b=byFivHe7514XbAHoCk6HePP2jOMeQQIk1Lhz4CtZnQjeRXZe866qfJysmj93QNJ85/
         uz6Ld3wS4gVBbXMEIqK2AmGouE5AazHG6TjWjNw+5PFEu4HBs/7BEF5SPnTtkp6Mnajp
         RvQHiOReNZ8P+vAhd6Kmo1V/uxEc8bhPwGAx4ai/+KdMR0+1s7KsKWQXJlw5yDUrYfZc
         xIHyu5rtMRTqbmpu0eyOXDf2yldSDpN1Fho748bdYLi81acY/vPkM0o00aSA9iSG+SSq
         7Dau4EMcEShsvkin25XD9/jVn/ByAV+0nxXrUs8Nlbf05L6ZeyHFz1k9RoKoJlduDn3/
         nWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761332471; x=1761937271;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8waxpIQ8zGohuhfEK0FchG05acb+4DM6iQ/kzGyRAg=;
        b=GsVcPEBEKKA2ULqsBBH0F1q6pVOMQCY2eknmI+hjeNdjwYSm1Sj2c85uzjlPX7GIzM
         mH1Bvr+ln5i0hC2VhKBfCnnH0v3GguUr7Xhr6hjoN4A9QHR1fuxILFuWRVgtL91ZqHy4
         3n1XlflHQGlHIEl3i86IalNUOgfTmeNOtwX9NU7g2hK6I+BxziH4j7ocTpnmNNZKZ5vT
         2V0JsiHDj4HRS/Q933oX/96/dyEklaNS4MYmpx2tkDTYM2V6g5b1cjZcyY9E/6yUT4oo
         S6Q2U3hgle+QfIDrNGGgwKG1kK7EL7gGwKnso63pOeXHz5UEtn8mB10RNLjjM2OmatgL
         BaPA==
X-Forwarded-Encrypted: i=1; AJvYcCXEduwDzpEZBAT3LigoFqbCWcl4oxtTUmmnk4Y2qxYjk2SjbAkcz3NtONiC3ww+FgOKriIlAw+ARhQpLbl7iLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0GtK4WTz/DpiIi2tvq+HEb3nVsgWiguolTZjI7vM5XmqEZGBU
	CK/JYURgm9MJdQSxkbwVLMudO3AUT/KQV7uJO+CgZ+ZKilallkz7tUa+NdHYko2AVjovedRcVuh
	v/+kKzRwcQBGlbg==
X-Google-Smtp-Source: AGHT+IECkyz7QjtjqlIBCYpDRH8zhYEB/CRZQefpS4FJrV2eHd9B6iamp/NEmX8Y64PJXUVBOg33HFcIUmVKiA==
X-Received: from plbjh6.prod.google.com ([2002:a17:903:3286:b0:290:b136:4f08])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ceca:b0:292:fe19:8896 with SMTP id d9443c01a7336-2946e25e038mr94802595ad.52.1761332470917;
 Fri, 24 Oct 2025 12:01:10 -0700 (PDT)
Date: Fri, 24 Oct 2025 19:01:00 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024190101.2091549-1-cmllamas@google.com>
Subject: [PATCH] kunit: prevent log overwrite in param_tests
From: Carlos Llamas <cmllamas@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Marie Zhussupova <marievic@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Tiffany Yang <ynaffit@google.com>, Carlos Llamas <cmllamas@google.com>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

When running parameterized tests, each test case is initialized with
kunit_init_test(). This function takes the test_case->log as a parameter
but it clears it via string_stream_clear() on each iteration.

This results in only the log from the last parameter being preserved in
the test_case->log and the results from the previous parameters are lost
from the debugfs entry.

Fix this by manually setting the param_test.log to the test_case->log
after it has been initialized. This prevents kunit_init_test() from
clearing the log on each iteration.

Fixes: 4b59300ba4d2 ("kunit: Add parent kunit for parameterized test context")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 lib/kunit/test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index bb66ea1a3eac..62eb529824c6 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -745,7 +745,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 					.param_index = ++test.param_index,
 					.parent = &test,
 				};
-				kunit_init_test(&param_test, test_case->name, test_case->log);
+				kunit_init_test(&param_test, test_case->name, NULL);
+				param_test.log = test_case->log;
 				kunit_run_case_catch_errors(suite, test_case, &param_test);
 
 				if (param_desc[0] == '\0') {
-- 
2.51.1.821.gb6fe4d2222-goog


