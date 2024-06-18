Return-Path: <linux-kselftest+bounces-12160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C265290DA32
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 19:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7B828642C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 17:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDBE13A3F6;
	Tue, 18 Jun 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NROQGvax"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9326639AEC;
	Tue, 18 Jun 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730224; cv=none; b=dZeylnjtlX4bZJv4KEd7AHllzvA44nRB0nWk1YK7JLSBFAoIlEE7Szc0UIdD42We4IKdV0yTdVN4foLf1JvdidYqdow+0TyRlFgm3nrUUG5nLf5U7r5HYvbsr/RL83PNRL5uAxNoyyGy+nfTbJKpGa8kHvB6qp/+Ef4GlfBG8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730224; c=relaxed/simple;
	bh=p2wufiZNrVBW4UBdBE+9ycI+njGvJmetlpf0L2kwHAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TGTX8EtRkuMjyQnjGlNA79Gqxiocn5ItbeeI8LMNryAVhjw8aur0+zTPSoWAFFKa2hFunx0ZV7Ws86njlQ174j31n6NPhaRxpR+vDbds4mEmIzicu4sh1jY4JpXCRhFsbb7FhjXPXmmUZUxBU6g8bmVEB+ShZTUjj/qQurcxKNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NROQGvax; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eb1cd51e05so6490931fa.3;
        Tue, 18 Jun 2024 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718730220; x=1719335020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q8X8olqetFNtH5+0shLs2PfAqP+dmyukjgs6WMoxaUM=;
        b=NROQGvaxv0gJHTdBC3BmAt6TU4yvGpZu3z6+q2NsfWjr4lze6UPqOWW/EnzBvwMCep
         85DsJhHOqVzbrW/cqDYpEGJ5q9RCkfk0WVN9TTTQG0wh5QJERCa3UKzM4kju2gKFPm0d
         fPK8alN+yvsr0lElSlQwyTjVqQnKTjCp7urYN5TAUVUmRF4IDvRNvvV2brQ34LdZnPsC
         or4B9ImZTXX5/ZlR0Qvy0/sqWmm72Ra4/Mwti5CTmxXLa1m52d8DqBxStLVLQvr9mp1b
         RoXMcfbXUXthQYAXSePiqr6GM+b7WLQKJZJZ6ocq5pf5bmceWIBWv6qQ5HSrU05UMi72
         soHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718730220; x=1719335020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8X8olqetFNtH5+0shLs2PfAqP+dmyukjgs6WMoxaUM=;
        b=oBAU816XBr8XvvmMim0Yjt28cJmyGRUTab7LVSAlFn1NS+WQZFEnlhAHDMTnK2eZMC
         OapVQPOghzzZgyTPAW6fWrOBsKAWLay6MR+RXOtZwpGHRKT5z0tTc/esncqQq0WrI6Tv
         pKXRGwQCM9+kSjBDtodoemzerOlRl+reiZP5HSn5dj7jN2jsJBIR1UDdEId2OC5jVYJc
         djQ9YcKOvFQtr9G5WkEeuVYzuUagidwsM+FESkqJSj3prk/r9fmnlQeL07AJEx9SOYsA
         vbB2eY6u2XBEiWY2euMhFp93r4lpaJ1ldc+axfEHJs81KJ4buMT9naYByru76F1Zt+xL
         Dj/g==
X-Forwarded-Encrypted: i=1; AJvYcCUiE+qRtOobQMtDVJNi3itUohTskDJ4CekvmCVt/2npfp51hqnLdOdjLCjym7REengMYTM/uzgnKQziu5Jr833PGkYQ2ErlZS0aXPBEpD7ORvLphJvd0JfKcugw8boWBtwH1ixlidvQzWmJQXYK
X-Gm-Message-State: AOJu0YxPIkaQza/PIq9o9zg3rREydHrtmqm+QLxOg3A1i61DJmFPYN7K
	283DFs/3nDlWVjUMtwNxF50S868GNLkUGo4JjH8Y87X49M4UJpIS
X-Google-Smtp-Source: AGHT+IGbvPj28E3ZZARSNmgslCvbD5Fwv8FaC0DmeAOIaOkRhrlIhIZNGaZYNO8pd8ekutqKDt29xg==
X-Received: by 2002:a19:5f45:0:b0:52b:c09f:2a27 with SMTP id 2adb3069b0e04-52ccaab1028mr120177e87.4.1718730220427;
        Tue, 18 Jun 2024 10:03:40 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:9a30:967d:12af:741a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075114dcfsm14526163f8f.114.2024.06.18.10.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 10:03:40 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2 0/5] Reorganize string-stream and assert tests
Date: Tue, 18 Jun 2024 18:03:26 +0100
Message-Id: <20240618170331.264851-1-ivan.orlov0322@gmail.com>
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

V1 -> V2:
- Patch which exports the non-static assert.c functions is replaced with
the patch which prepares assert_test.c to be merged into kunit-test.c
- Also, David Gow <davidgow@google.com> suggested merging 4th and 5th
patches together, but since now the 4th patch does more than it used to
do, I send it separately

Ivan Orlov (5):
  kunit: string-stream: export non-static functions
  kunit: kunit-test: Remove stub for log tests
  kunit: string-stream-test: Make it a separate module
  kunit: assert_test: Prepare to be merged into kunit-test.c
  kunit: Merge assertion test into kunit-test.c

 include/kunit/assert.h         |   4 +-
 lib/kunit/Kconfig              |   8 +
 lib/kunit/Makefile             |   7 +-
 lib/kunit/assert.c             |  19 +-
 lib/kunit/assert_test.c        | 388 --------------------------------
 lib/kunit/kunit-test.c         | 397 +++++++++++++++++++++++++++++++--
 lib/kunit/string-stream-test.c |   2 +
 lib/kunit/string-stream.c      |  12 +-
 8 files changed, 416 insertions(+), 421 deletions(-)
 delete mode 100644 lib/kunit/assert_test.c

-- 
2.34.1


