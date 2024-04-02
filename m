Return-Path: <linux-kselftest+bounces-6983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6035F8953DA
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 14:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160DE1F229EE
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 12:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667D17A15B;
	Tue,  2 Apr 2024 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WhPGom5Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D1335A7
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Apr 2024 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062280; cv=none; b=lVDxXw3naBaEaqoPcdiMWIda5ORMk062YQ5RybXhwJP6OUx9F9NYRgJ5/fdKrF65/OTWeWLf/VcElgqUlUwz8IQN68bYUOJaCXA/C/iOp4i/R6PRK16Qctjxf/iT6MTy/6MyUaaOlwx25GUGD4t+99xYpa7LTuz+aNFnQtOFbmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062280; c=relaxed/simple;
	bh=oElAllZ5P13j3PQNwwFCGQdwmNrFpD3NdwRGZk5W9/I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GqxeP+556Na+jNelgZdYN/3d/t0cWDT1/cleWJTtLYP6r+U7UMwYsOG4rgAQrlC+3AZ5pysDnLv6aKhdansSuFWb72wblc4GAOMaBMs91kMpV5pO4VJLMylgbvazDfLn0ZUCZcMwTiTUNfNM3W72Dn11HuexiVLqGEsX2OPDFiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WhPGom5Q; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-415610b70e5so12553465e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Apr 2024 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712062277; x=1712667077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OP/IorpMEPaYCSeI9noOVqFaOql+UUAA/5aBbuRUBgs=;
        b=WhPGom5Qr05vODwOwaTYza70q//55pTRbPI01HS8jbimMeTxtWmnoS+wa3UUP1vfxy
         yjcglvuj33MbRRaOQ4vNvnz+Ogdgo92XuhJnsVJusT6ja+5zZUo4ZKifDjzGq84KdFVg
         O5lYvddvGLi38WF6OGEoQUzipfE+p3CjRRlskuQUdur07wzgw2VBZxvN5pereZaO+kcX
         toOUvA3rvvXqMcBcW+UhWMvJ1Ae+EPNaAb7c8qFGwL927A9Dfe+K0iP6M0QdE+XWyPg+
         +/WpFfj5/Y1bgoRrRtYPdhD1WQukpLbEwyejUfDeCk3/T4GQaiE1izvbNZV9r1ytRtT7
         Ip9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712062277; x=1712667077;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OP/IorpMEPaYCSeI9noOVqFaOql+UUAA/5aBbuRUBgs=;
        b=F5nQ0STwOmNjdFw3Oqfnqk51lsUK1wluEjO+56Hc4cLRHcz9ODh3z76F+il3sYndag
         U8+N8ej76ZRvEDQWFzyXMgnzlUlgFUIw426giIMuB2AlV8SheZmtYyo8KX+yBeVAExe8
         AuBx2ZffNu7wNr1vk5Xgg14dzEdxr2s5r3L6G5W+g1/ExvzI+1TvefqsW4r3RMg4gmAl
         0SrgGU6L8UIAfYrQ72m/x4V7ssUYU30EDHVPdZxIXmahUVQm8f5A6ZaWdsK96omYfHlB
         ESIoF5rJsSsefjQnpqKXAy2ODU37UHyaitnfs2uB760Qw3Nxqt1jW1hvK0F27pw7Ud25
         aLTg==
X-Gm-Message-State: AOJu0Yy1oEI/MX6J2uhqkKCy8JSaOdsZq28sMTCHRAUtTxVwxwBC09lw
	Du9O/KIN0PYX2vjlIsHeL/DUGH7H7BCRztpTayk/vpeK6ZZlAsLlHuEK80N1KJBLR20r9cDY3xK
	uidO/Qw8XN9jKJ10bk4N+WMIMBxXOXpqjhQ3nLoxXfgsVrpSOSMfKFxQe5Iu3VMh0z+I5T0PGBV
	9+6KooWvVz+686rArO+0bjh3riF3X4SnoukqBQyMHo8qWHVp5TwP8UalI=
X-Google-Smtp-Source: AGHT+IEKQGJhcSfFP21Fqdj+QH/10fP9Zd12ZW+9WsU+VBFP3ePpDhwuu5yXNp94FAP98dcP14owPuAgMCR6Mg==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a5d:6608:0:b0:33e:d4b6:eac3 with SMTP id
 n8-20020a5d6608000000b0033ed4b6eac3mr28105wru.6.1712062276866; Tue, 02 Apr
 2024 05:51:16 -0700 (PDT)
Date: Tue,  2 Apr 2024 12:51:09 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240402125109.1251232-1-jackmanb@google.com>
Subject: [PATCH v2] Documentation: kunit: Clarify test filter format
From: Brendan Jackman <jackmanb@google.com>
To: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Latypov <dlatypov@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, davidgow@google.com, rmoar@google.com, 
	corbet@lwn.net, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"

It seems obvious once you know, but at first I didn't realise that the
suite name is part of this format. Document it and add some examples.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
v1->v2: Expanded to clarify that suite_glob and test_glob are two separate
	patterns. Also made some other trivial changes to formatting etc.

 Documentation/dev-tools/kunit/run_wrapper.rst | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index 19ddf5e07013..b07252d3fa9d 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -156,12 +156,39 @@ Filtering tests
 ===============
 
 By passing a bash style glob filter to the ``exec`` or ``run``
-commands, we can run a subset of the tests built into a kernel . For
-example: if we only want to run KUnit resource tests, use:
+commands, we can run a subset of the tests built into a kernel,
+identified by a string like ``<suite_glob>[.<test_glob>]``.
+
+For example, to run the ``kunit-resource-test`` suite:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py run kunit-resource-test
+
+To run a specific test from that suite:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py run kunit-resource-test.kunit_resource_test
+
+To run all tests from suites whose names start with ``kunit``:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py run 'kunit*'
+
+To run all tests whose name ends with ``remove_resource``:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py run '*.*remove_resource'
+
+To run all tests whose name ends with ``remove_resource``, from suites whose
+names start with ``kunit``:
 
 .. code-block::
 
-	./tools/testing/kunit/kunit.py run 'kunit-resource*'
+	./tools/testing/kunit/kunit.py run 'kunit*.*remove_resource'
 
 This uses the standard glob format with wildcard characters.
 
-- 
2.44.0.478.gd926399ef9-goog


