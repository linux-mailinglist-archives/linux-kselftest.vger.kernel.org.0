Return-Path: <linux-kselftest+bounces-33423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AA9ABE41C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 21:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1660F4C5B95
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 19:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F882820CC;
	Tue, 20 May 2025 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eymqlKOO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335AA284666
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747770780; cv=none; b=IOgy3B6hv5n6RhXPJ+/rR3eXeUrN8qQu4PVpt51cUCMDWD0P+WoeyaoCQI4umkaXktPSkTvVaAvULdwLafVHA0hTFXnolJyCYqikS7pjxDbPInn7hbv1auD+WyMHjZxBIjSAmWjUlqyILMYne+Y1AXljxTEkpVIwZHv+QxZd8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747770780; c=relaxed/simple;
	bh=2JkxPTkRCF2ZFpW2d9Eif34bSfjAooXPglJI4C8IIgg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kEcsZzVnYha0UqEWi1JxZuC1x3NA/FCeotI4ai1iarRzQQ7I4fasTdLzhNEqwYvAeDnUGK6iwRLSwxO+qlXSqMK7tRXGz20w6q3Is7Lik8K7l0XTMuzZV5C3EJjlqfvZv7ijrmZL+t+Eh2Pk2jDt7FNQtpy9cs50cEikMAEONO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eymqlKOO; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c5d608e6f5so1476640285a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 12:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747770778; x=1748375578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SXpn/WaKau4zA3cRgecqqkvTjBRhcHkLh1EPrEXBv6w=;
        b=eymqlKOO+siVXXvklcmDD0ZVGl92JDJn4oYVPfitIsURCXv0VpD25caCPZsqoZdy72
         Vl33zNkbPnsMmyU+wonEFV1jfddBKZ2QwbkkK4s8vN2qDAnxg7pbaImMivfdO1aOt9KH
         mfqtKPEX+2XbvFsQFdzIMS03YVYv6sZlMO9HnVHrGgitNoBhXRA5L96kTfDNcXJesjdr
         uiC/lW4Aetq+xWuHz8Ji//uPJ7prQLYJjKgnvRZFNBNf6xtXTIA+GgBR3aOkXcanPzBz
         4neLltEND29ZlhHESOyDh870/7cKzNdhAtLnj88tcEFlwlUuRRkXc5yYA89C6599i+Pn
         8tpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747770778; x=1748375578;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXpn/WaKau4zA3cRgecqqkvTjBRhcHkLh1EPrEXBv6w=;
        b=PcrBaZEKc471hLtM+4b+7H4k3O/93I0VPtflJ58VgwKDKadQnUSzGj8741xDI+w5+h
         6S1XM1qFnyk22J3x4vZaho02MXmg09x/GMxWfZc5TwWLYxLt5FzKk4OxIdBhLsemBEf0
         azgls51NaRO6mYhtk1+pGrlmm/Hq/M4wO+vur1IJ966t8m4W2CU1a0fNaPcktrLqN8ET
         rdj22exYsucvKCoTlardlKAF65ByzAGWKMiOYgGiqDZR67IxYECvrXMVwtWgtPhuKDUs
         IA8BfLLNo9pdNGHRMlFvLJeAj1BQRRloGA93WIv+3njuP1UPFQKJ7QkdEKEGGppa1Ay6
         OVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZSI712xPIkQBUJL94KbMzE7CktTbrGN2oY4PUik61O20737xoKsFrDzQr6PygY0xetEA8gGRoi3k7a0edeMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQ/iuJBl/BXDsMmQpmOlHZkTm9HdKRaZM8f06gQoiMmpSUWRb
	3/V6SPudZA/mn8zoaqgZJyQS3OM8pj+YaWPsVvc7ES/2M9XcSokB7yca9PsrcW1c/HAX4F5543v
	BrA==
X-Google-Smtp-Source: AGHT+IGMDiv33WBWbSNW1H6Xv/IdXq/dfRT9Dy0t/jTHyqfUZS7qemkc9kBCYcIkb4w/Wkju9zwFy4xIsA==
X-Received: from qkpn19.prod.google.com ([2002:a05:620a:2953:b0:7ce:becb:f27d])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:372b:b0:7c5:a2f8:e6e4
 with SMTP id af79cd13be357-7cd47f46587mr2375350485a.29.1747770778122; Tue, 20
 May 2025 12:52:58 -0700 (PDT)
Date: Tue, 20 May 2025 19:52:52 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250520195252.2235050-1-rmoar@google.com>
Subject: [PATCH v2] Documentation: kunit: improve example on testing static functions
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
"MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");" line. Both of which
were missing from the original example and key to exposing static
functions.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---
Changes from v1 to v2:
- Add quotes around EXPORTED_FOR_KUNIT_TESTING to change it to be a
  string

 Documentation/dev-tools/kunit/usage.rst | 38 +++++++++++++++++++------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 22955d56b379..066ecda1dd98 100644
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
+	MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
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
2.49.0.1112.g889b7c5bd8-goog


