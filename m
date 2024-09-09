Return-Path: <linux-kselftest+bounces-17488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8264970F42
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09971C21F1D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A251B2507;
	Mon,  9 Sep 2024 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aH3g26Ml"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489001B1422;
	Mon,  9 Sep 2024 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865724; cv=none; b=CimxCHhLwv3PUo4QXL4izgpObDckOkXfgR7loOhQTKyJRVEXluPykpJAQBk3r/CpvNxWgZvAo+kl1UuEBnc52fM9pasmmQ5tcMzaF+VCFRitNsNUh2D/DDtZak3hJPXGzWuKmQNceKjNBYeoRE8fU065mNAOXNf7WGnpCSXznZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865724; c=relaxed/simple;
	bh=tUTrUjr+mTDfGr/qeQBEHWMqb3LqyK7HvLda+2w6s/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoSSzwmD5NiK9T58XH/s0Woktx1qf5OPn0cLJRpu5d3YC8oBiy8NicxHg+DM51RbrqE+5h+whYJzpv4VDVpL4cCXb7gEi48+O3HBi29D2MO1K+EtBMmmbpyIGD2wpu26rWaUBaEmXcBXKX1hNqdk4jXxXdv7OFq7wACOjxwgF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aH3g26Ml; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374bd0da617so2425785f8f.3;
        Mon, 09 Sep 2024 00:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865722; x=1726470522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3RXsBbJQS/hq9A6ZJhcwQoifydWEQ6ZfpZw1c9736o=;
        b=aH3g26Ml10s8C+gJTWl9T8gv3UTV5SAd+RSyreyYQiJmp6MnvxzzfWnqFngtU0baN7
         KgPfMqmYlOXc/bYbtydviXruyuhfB6CoapjqziRy1/+OBsp6I0eoGDbmOR0iOLWLzT9O
         nbi4Kf2uX5+YXJQzSnGZSDJpbYT6Vj7O2+X8/OTFkpNxUrB+N89H4V0JBb1R9zEZfk+S
         JB9bNa4omntOADQm9pXgFkqlW5xVULpFPu7W6UdvJCTEl5oIEvFL1mYZod+f/SWbm/Jv
         h/kubzJptTwwQ3dDFCAzIHk3aLI+P5Lio/1WiIfIpf/6cTZ7VwyuOa/XZgg7wGd9YuFP
         RjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865722; x=1726470522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3RXsBbJQS/hq9A6ZJhcwQoifydWEQ6ZfpZw1c9736o=;
        b=M9LR9pY5OHrqBEtBmo6ndWg3l1m9vYIjOo+578ertiVqWbTXJHPaoMORf4hISSKK+1
         veahGPIGXqpOh+bnWCC5juV+/bCkHO5dffnmss392MBVUO5Sg3pFUasQzLhJW5xUapWU
         tlXgM20sep1z6p/U044EZqfRXFw98Bl5UNCszolDfzemaoPLVP2KcCc3R+GK/fFr0f71
         k4XVe1JadxB3xlPSSz7NAMZJZrlqSE2aTVzDXS4G8oMKcsNai/Sj8+QvSIw3IhqfVhl9
         dBHY9btqGsDN+rIhg9TzZLOi7mp3UtEgIYc02sP6ii/H8P3myNA3qkf9R9LqdnGfyZiH
         ZKsg==
X-Forwarded-Encrypted: i=1; AJvYcCUBqG45DuZWLyNveZYRG8IMzlD7I4IS83ir0UMPTJJpGo10dENhB63oqfI/vNSk9o6lxcyiY+HVxmbst8Q=@vger.kernel.org, AJvYcCUmbUFWdtyvB3n8BOFgFZGFWspV9oTnr933QgMR/pJdWMedFBIF0g2x/Lf5ILw+6Ai3arikBDaHTbuaJrzG@vger.kernel.org, AJvYcCVCgjA8dViyseeTTShbsbVPf+t7+6kIovisoO0SloVAbVggTL95U8cNcUBDQh4pL3UlLZQRYcW6tf+E+EKVkkxp@vger.kernel.org, AJvYcCX/QNybtcyuqXZgnO7Bnqb7Gjrf79DHbs5BTkQ3Lh5mLKSoQON5z6sWd0u59SRsXxJjdlaKxjQl49wjkpxaCw==@vger.kernel.org, AJvYcCXGJdMTVZjMBuHQDe/Ay19FyWZUFAt6W5gqonQT65IgAgbv4BkRhce9D63AboNsbpZnvWeZ2FHP0VPjxQ==@vger.kernel.org, AJvYcCXXIn8nFHpG06lA3b9a8rvGcuxd26IPPB/DyAScckA7IGKpVlhF5Qf0YG5xLPreNVkeMWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqW74LBum/rwfbQvv9Eae9+4+iFUCjE36ZOGoSyw0Tl8dg7md5
	w2nPHa0obZ4c3p3tVSw9jfv0Egx2e5NCmnrHyzIfxtlr3+MjHYNaMurSn1NKI9g=
X-Google-Smtp-Source: AGHT+IF71nvV/JLA7tnaX8d4uBILZgafYRcREg9unRBuq1O83qltW6sgUb4J13+Gilii8joehF0k7g==
X-Received: by 2002:a05:6000:b92:b0:371:8dcc:7f9e with SMTP id ffacd0b85a97d-378895c6306mr6637459f8f.2.1725865721615;
        Mon, 09 Sep 2024 00:08:41 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:40 -0700 (PDT)
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
	kunit-dev@googlegroups.com
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 16/19] lib/test_scanf: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:05:30 +0200
Message-ID: <20240909070742.75425-17-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909070742.75425-1-ubizjak@gmail.com>
References: <20240909070742.75425-1-ubizjak@gmail.com>
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
Cc: Petr Mladek <pmladek@suse.com>
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
2.46.0


