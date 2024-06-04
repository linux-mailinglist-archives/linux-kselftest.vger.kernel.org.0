Return-Path: <linux-kselftest+bounces-11178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526FA8FB250
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 14:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82AD21C2271E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 12:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6257146D43;
	Tue,  4 Jun 2024 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzOJGGcA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430F114600B;
	Tue,  4 Jun 2024 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504369; cv=none; b=IGEMsb1hrakPcHheal4iSuz6lxgiWm5hP4Ap98oeDtuGaSHuEabb1pc5PDWwZKV5JUqxAkGKhpq8paaIJqlEayPTjaANNRQRd2xxZ4fAy7/77nl18Culrvq1vuamfTX9IolyZxF6kafDZUuksxNNnCO8EqALDGyvGj4XkY0elJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504369; c=relaxed/simple;
	bh=jQXLM/OZsp6NPzJIuBkmEeVMHOkt2MPWrpv1c8YmrYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=enXMO80G6OCuCwa+H/jUu7WrgtCQaTHM8AdPa3BlaXAtzNgQfhYcozq4kf8DDkrcCW+Jbgj9Z+Gc4ePsijwGFh+n+BKS1ztotpkdBq8Z5cVU7xOtADMTVAz+/geexWzpBOHCSUJeYVCCyvdQYlnU2aEVNVsemQZW8FrJuNm/z8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzOJGGcA; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35dcab59861so446998f8f.0;
        Tue, 04 Jun 2024 05:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717504366; x=1718109166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQpw5Hn3XFDc4MrZP52/zmwrZKk0HYvt557YaBSEnE4=;
        b=GzOJGGcA6z+QfkfhJ1pRUDcN0VJp9VNkll5lb605Wi/gd3M/d8y681NG8zUJ4wBDHa
         YwWyeOqo2pq1OagJ+Rwa0ITDR22tba/koxz+cN3HrV1motxPgBqofPHc88rNriGVr/HV
         qq7ykfXck24Fedik0/KstlHeDgLhYla1LHCZ4zVQdxmdy83xdycIkCl0JrZ/duXQbXT3
         Eccwro7WZlOT59Yzf8dARONa19/W6R8/dVHWX9o6Rkg0BLrM1F2mVOMr7U616594bHLP
         fwgMon6qEbL3GHbuXQiCDAqK3C9iyMRTWTZlR2y/vLTLQ6g9nNNOUSMPVkmKXKRohYBF
         73EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717504366; x=1718109166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQpw5Hn3XFDc4MrZP52/zmwrZKk0HYvt557YaBSEnE4=;
        b=RbcEDdayNcIOF3KdS+elAcp20F32xSFQmSmnNLWCDdV8IHlzEKybAqur3BJEcXfarD
         X20wPoNninNoB1OsPFhXTYXM5L9V7yPK7ha1p1jkPvWLFZKkQgdFg25WeSF0urX9NB9t
         cuPy5UT6FU08bznVd2KYH6B2wtrzQVRNuOA0q25n6oPH1eRuVoh/yQGO8yYIR1S2j1Ln
         PLbZ8Voc62/XPOzGvsj7nDCTFLqdhsOriCjRVxopGQh6WThBCAZpROjU9ryO3cUk35bh
         Ls3W3VeyReuACSiGTzTWLN+534bqn2sX9UuH872HBbekQHmE25TM6QoRFhx1tLbYke2P
         o90Q==
X-Forwarded-Encrypted: i=1; AJvYcCVd0SYx1m+pg8M0ETc79YiaolpuxnaMca3edbzfQeeARoiHE+9Exusw/vrv7rc+9BH7CYSn4+48qdobdvU5KLPv/EhgJH539h2SKPm1m1JqhggRFtAqss/fGt/PTQSVAN99hKx1sGS09EVQWMO4
X-Gm-Message-State: AOJu0Yyj7ZlZFFfMlsN9H6wHHAt4rdNpcLOwPrI9xtchFwQWxev25dc5
	8y8aJBAfKhr0quPQRWhdQxAXO9bkxaBYgBh6Ywxf81AVzgHv0HX4
X-Google-Smtp-Source: AGHT+IH6kCQ/afrSv2P1zdqwSAqmKioeInirBef7NABKAQCUXGexCMX14ujoXkpOyE8WFuPrZVPy5Q==
X-Received: by 2002:a05:6000:400a:b0:35e:51cf:6908 with SMTP id ffacd0b85a97d-35e51cf6a65mr6569549f8f.0.1717504366396;
        Tue, 04 Jun 2024 05:32:46 -0700 (PDT)
Received: from ivan-HLYL-WXX9.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e535567e9sm7209179f8f.21.2024.06.04.05.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:32:46 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Reorganize string-stream and assert tests
Date: Tue,  4 Jun 2024 13:31:59 +0100
Message-Id: <20240604123204.10412-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we can run string-stream and assertion tests only when they
are built into the kernel (with config options = y), since some of the
symbols (string-stream functions and functions from assert.c) are not
exported into any of the namespaces, therefore they are not accessible
for the modules.

This patch series exports the required symbols into the KUnit namespace.
Also, it makes the string-stream test a separate module and removes the
log test stub from kunit-test since now we can access the string-stream
symbols even if the test which uses it is built as a module.

Additionally, this patch series merges the assertion test suite into the
kunit-test, since assert.c (and all of the assertion formatting
functions in it) is a part of the KUnit core.

Ivan Orlov (5):
  kunit: string-stream: export non-static functions
  kunit: kunit-test: Remove stub for log tests
  kunit: string-stream-test: Make it a separate module
  kunit: assert: export non-static functions
  kunit: Merge assertion test into kunit-test.c

 lib/kunit/Kconfig              |   8 +
 lib/kunit/Makefile             |   7 +-
 lib/kunit/assert.c             |   4 +
 lib/kunit/assert_test.c        | 388 --------------------------------
 lib/kunit/kunit-test.c         | 397 +++++++++++++++++++++++++++++++--
 lib/kunit/string-stream-test.c |   2 +
 lib/kunit/string-stream.c      |  12 +-
 7 files changed, 405 insertions(+), 413 deletions(-)
 delete mode 100644 lib/kunit/assert_test.c

-- 
2.34.1


