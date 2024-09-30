Return-Path: <linux-kselftest+bounces-18639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127F898A32B
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B84F1C2031E
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6024B19AA63;
	Mon, 30 Sep 2024 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez9amYMP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC02199FCD;
	Mon, 30 Sep 2024 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699854; cv=none; b=oNe6/lL0DSTRdq4wYqt/z+jSOxN4sdMSGJEPY2YQ0hYHfZHnH8zVp4/CXGL8yXgVJVP9IFuARd6OftDr3gGVwiooGGMHYj2HaRs6yvFgc0dHCkFRsz7minu28zVH8ldidPjlc+DdM6KrwNA36sbndMT8t9IpmKckyCMfqva/1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699854; c=relaxed/simple;
	bh=+BDqnGHD09RuaugbPzQ239Wjw/NJoxYY3IVfJ7iKzk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLV16C57uS1NfjDdbq8XmwED3/9ydo0qkeY0Ejp5IBVhuUQX7BYKb6bSiutRlKnrftMZBt/wSfRwgnAphDfYiiPNcOKMjb+HpwwUzWmn+l96IRZIte956RTDhlWVqzNwTKx3udUBTdLxCtGAnnL0LgtseftPfFX8CrbcTnnC/cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez9amYMP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so25669315e9.1;
        Mon, 30 Sep 2024 05:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699850; x=1728304650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lz4qKU/YFIFXfB/NpuI+EYoLGmKb2OxmH0ULGfS7UQs=;
        b=ez9amYMPHbN1M8RtQ4sXL7QufLQoHp/WHC+Xc8bQI0hRt42yRBZfcznVF2IpGrMZm4
         z5JRLAj/RKOyT7TlDn0z3Q28tydAfWcjdhn1mYxO9z79gl4qA88MN/FCVZvr9RrRng6x
         AQjRilfsyE+SFUdvEDrpYWmX0mwPsXke6aQ8c6zKPwM0NXTYP+oMeRrVPIly+cozBQeo
         Jm+UDMf+8fY4yoPURgz4YDuJekrdp89nnueXU8tb6U2mT2AnIRMiERTHU00JHcefTUjV
         uWTIK7JzGrRvoHmZKyHDAbQcTiNhe8Il/jRgMnIPne1CS0TojxqGcZijHSLDX/AlnsRw
         zfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699850; x=1728304650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lz4qKU/YFIFXfB/NpuI+EYoLGmKb2OxmH0ULGfS7UQs=;
        b=rQCXMJVx4p92k9TT7vazoViGfGt58zd9e6S6PmeQFJIZ/wvWXlNPz4fh8fpg4WKIUn
         e+kfZo8rxKCsyDgAOCLb/HmYsXh5BMEHqb18oQGZbnTdJiBHWjxfFDBYK3XjU8XL3YIR
         ZMsUYbdVVSSvShPCL59TcgCEtVR9by5EJ0gYMnrgXaBZzw4jjnNveC0YZDRV7uCTMxNs
         2Mp3A7v1BihxYPI9hkd9ATaxZ0TeWD5wdwhBwhgaHpxTJeed6YrWtJe+1PafYhyp+43c
         A83aQCKXAb8SSAYl6S6jWVo+zFQIkcqAQeeCMOiq0igKXpQCa0KupTX2VmDvY4JCvqFk
         OIzA==
X-Forwarded-Encrypted: i=1; AJvYcCU+U+TIDJau3ECwus8cRkxIyM5by11QAHG58JW8qamnWUoA84ku7HkBiArDq6cE6l3728xO0qrRohH5aJZs@vger.kernel.org, AJvYcCUWyiIdL8bgkmI89JciKuw+H17Wuo6U9ZWJuEzfGiG9wBx8OVZlAtj6nKyeEQDxwqYxjy8rNl1Rls41mjSSKdQV@vger.kernel.org, AJvYcCV0u5hsElse2e4dJbPRL+RU4I3O6q1tAsQuBqDw5N0wBmX00CWoth+GyqFq2dMfj2XPChQ=@vger.kernel.org, AJvYcCVDDJJebPO+crx4vvvW5WJK6x9B0d0aDGxaDAYes0simVUCq+3sXpfALhnb46XiXU6bDSf/BSLiv0iWrdb5oQ==@vger.kernel.org, AJvYcCVMmf4W2W09EIStrxjfy1NIfiY2SThR2E5nllr6CpRyVnH2k/gC5j25vCQrQlx4ehJGGLldaW+khGUdJg==@vger.kernel.org, AJvYcCWN/jKVjyaXNeOLx/GtmN9d3JHcfLhbKI+okZ7IkM5bTUOg33Uhwjr3pYObdd6xLCks9l90Krbv1s2rnG7X@vger.kernel.org, AJvYcCX+EygaQx5dSwF/6I+DPsD1/GvPR9Cis6a5k266RbZkyRNl792V7g/vX9qImPw4kd1OkRw/Os1vAI0rlbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZHh7GiwVn7m5LMYif83upu3Jg6VGE9uU6Vr7hJELVZ7iQmf9Y
	C5vJ/dNOseAQ9UEPk28jix6bsh3iamOOgttdvcEhO9FmuEWeDOH7
X-Google-Smtp-Source: AGHT+IEHFojSqPP2AgQGoeK6Tsjuir7GTcIP+p3ReuPc4+U3eJkS8TX9JsgxlIhdOuf0uw7wfeRCPA==
X-Received: by 2002:a05:600c:4592:b0:42c:b377:3f55 with SMTP id 5b1f17b1804b1-42f521c6035mr89879815e9.3.1727699849850;
        Mon, 30 Sep 2024 05:37:29 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:29 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 16/19] lib/test_scanf: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon, 30 Sep 2024 14:33:27 +0200
Message-ID: <20240930123702.803617-17-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930123702.803617-1-ubizjak@gmail.com>
References: <20240930123702.803617-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/test_scanf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_scanf.c b/lib/test_scanf.c
index 7257b1768545..44f8508c9d88 100644
--- a/lib/test_scanf.c
+++ b/lib/test_scanf.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/printk.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 
-- 
2.46.2


