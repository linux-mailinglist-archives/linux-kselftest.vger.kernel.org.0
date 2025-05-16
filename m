Return-Path: <linux-kselftest+bounces-33208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D884ABA365
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 21:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292F83B4139
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 19:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1E927FB30;
	Fri, 16 May 2025 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="00Bl9u8A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA9327A12D
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422409; cv=none; b=iGw24JZ/x7uVZlxX55/vCcHK5ENDA+lkDn2g/yXFu8JQAP3SPJnK3FK1Z+aS1aCHyZ5+WSY4xUKhTpnWmGtRP7RQ1gTCBdXfHgEAtx5sDtZUZ66USmQedaxKHcn5S6LtUCaao2QMuk/TcFk2sGCphR3s29bt1XavZyavpEzfEb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422409; c=relaxed/simple;
	bh=/SLjNTUbM63R26k/UsXUlQlnoCKD2zOJwWHIFiGKmAY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=B9bOrChmobus5U1xYMiPcxXo1E2W4dUbgdTaYtKSHb4G2Em6Q6Hnsz8rQDk5E0vzhjHSndAK10q9TsdK59b2xr8iYp9UlxU2Xx9iViprsdL24IGrYPkcdDhUbzBZFgHxVBUpcc+A3Ak8E1tzrMplE1jXLVCjY3mbi5SNjO9e0JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=00Bl9u8A; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c5e28d0cc0so412990985a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747422407; x=1748027207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4gPgjbGOtp9/GSKJFp4SYCjxvoZAvNM0YP1ZbYCo9U4=;
        b=00Bl9u8Ay7iaaI6L5Bj93B+AZ0wGIUKRiu6uW5E+pGY9cLg4nWe98n/dALsXAmppZh
         m3KRg6h9e8KErSUa9iig8kE3FwWPlzpH5938lDzS1ZgDgzEQZgILO94rHnHH9siOfzeW
         uAvqj9zXBADJ4D28m/RjqvuqCpaTkA5ntqBHCEYknTTLMMc+Vxy9A3tKx+JrNxkoWexU
         K3Eo3mRCRaJeidTPh9T0HZlERxVOafvrpKKOn6EoYrS4HRyZh9pYN6TWXXdoDOpt1smQ
         mx7Q6cMTZ0VX4EdX4iebuN4Sw0UIWVGGFz6a+9MP2YMGbyYYSXg6v/D3sFyt+DwRwGPh
         DXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747422407; x=1748027207;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gPgjbGOtp9/GSKJFp4SYCjxvoZAvNM0YP1ZbYCo9U4=;
        b=DukcyH11PPMLdQM6pZer6klHrT++fZfFQ5W7iJLx3QVs4jvTDwrGO1Klry4yp3O3H4
         Ee957UFjJC+Z8JItPiE0JETBeq4R6tbfTEyvpuU59E3SswT/0uJYfMLdClGlJSoDNdEQ
         6CWqGYfwHrDnBhZ1xI+tbO9QJlJzq51omX6Cylclu+E+LE4/HxZA38khIWzG93gyPlBZ
         mDqG9VA0NB6Ly9bhseEB5eeXwCSFU7ynNkQfS1w+VhteuoMXJ0s1LEQREhmmsrI2zwjx
         IwcfEdUGy22L/12uE4pyaXD3qWyV48DrIo3cXFEYKSHOSrxD1VzDmswiHK8fzQwqjzfx
         bqwA==
X-Forwarded-Encrypted: i=1; AJvYcCV31RKBdJcbD5WwfrY7S4vIF0D8yqOLZZfoZTgLv/fUjJx7BZVTtT4btwYoefyBHAnLRHkdUSrmssXk5p2E6jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxev65osp6J3bieKofiG3xg6JrNjaWGdKXB5lTl47GCBFHB2mAh
	0EtpOAn0e/SUiYz0Gp9cZN+SAJqrM9V0oajEKPO5tvFRcQ3q+0egXYEluBi0TH3l8jCWOEKo1VX
	XCQ==
X-Google-Smtp-Source: AGHT+IEgPOuqk/3cE/2H7zq0b0LsLPaHlURhVDCFbXNlXfbY8uO9X5+SEluiCVEb+7gsQvjh7IayMq5ggg==
X-Received: from qkpf18.prod.google.com ([2002:a05:620a:2812:b0:7ca:da19:5cc1])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:4091:b0:7ca:eb5b:6b99
 with SMTP id af79cd13be357-7cd4671fd0dmr645557085a.15.1747422407087; Fri, 16
 May 2025 12:06:47 -0700 (PDT)
Date: Fri, 16 May 2025 19:06:31 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250516190631.1214081-1-rmoar@google.com>
Subject: [PATCH] Documentation: kunit: improve example on testing static functions
From: Rae Moar <rmoar@google.com>
To: davidgow@google.com, brendan.higgins@linux.dev, skhan@linuxfoundation.org
Cc: dlatypov@google.com, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

The documentation on testing static functions using the KUnit macros
VISIBLE_IF_KUNIT and EXPORT_SYMBOL_IF_KUNIT is lacking clarity and
missing key steps in the example. This has caused bugs and confusion
among developers.

Improve wording of description and add missing steps to the example.
This entails adding the "#include <kunit/visibility.h>" line and the
"MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);" line. Both of which were
missing from the original example and key to exposing static functions.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 38 +++++++++++++++++++------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 22955d56b379..038f480074fd 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -670,28 +670,50 @@ with ``kunit_remove_action``.
 Testing Static Functions
 ------------------------
 
-If we do not want to expose functions or variables for testing, one option is to
-conditionally export the used symbol. For example:
+If you want to test static functions without exposing those functions outside of
+testing, one option is conditionally export the symbol. When KUnit is enabled,
+the symbol is exposed but remains static otherwise. To use this method, follow
+the template below.
 
 .. code-block:: c
 
-	/* In my_file.c */
+	/* In the file containing functions to test "my_file.c" */
 
-	VISIBLE_IF_KUNIT int do_interesting_thing();
+	#include <kunit/visibility.h>
+	#include <my_file.h>
+	...
+	VISIBLE_IF_KUNIT int do_interesting_thing()
+	{
+	...
+	}
 	EXPORT_SYMBOL_IF_KUNIT(do_interesting_thing);
 
-	/* In my_file.h */
+	/* In the header file "my_file.h" */
 
 	#if IS_ENABLED(CONFIG_KUNIT)
 		int do_interesting_thing(void);
 	#endif
 
-Alternatively, you could conditionally ``#include`` the test file at the end of
-your .c file. For example:
+	/* In the KUnit test file "my_file_test.c" */
+
+	#include <kunit/visibility.h>
+	#include <my_file.h>
+	...
+	MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+	...
+	// Use do_interesting_thing() in tests
+
+For a full example, see this `patch <https://lore.kernel.org/all/20221207014024.340230-3-rmoar@google.com/>`_
+where a test is modified to conditionally expose static functions for testing
+using the macros above.
+
+As an **alternative** to the method above, you could conditionally ``#include``
+the test file at the end of your .c file. This is not recommended but works
+if needed. For example:
 
 .. code-block:: c
 
-	/* In my_file.c */
+	/* In "my_file.c" */
 
 	static int do_interesting_thing();
 

base-commit: c2493384e8110d5a4792fff4b9d46e47b78ea10a
-- 
2.49.0.1101.gccaa498523-goog


