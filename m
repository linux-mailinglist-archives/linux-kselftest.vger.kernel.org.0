Return-Path: <linux-kselftest+bounces-22133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C049CFCA8
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 05:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA13B27AA1
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 04:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164541547C3;
	Sat, 16 Nov 2024 04:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lB7923GG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CE763D;
	Sat, 16 Nov 2024 04:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731731007; cv=none; b=ehmoryhe9VnOWib1UNhiowIRATAe+NQrGfyx1/V5/qAfiQVcQ8E+2SM/jjFIPne/MH/42gu6agnBkwt8cS/y7a3JobGi0jRRvQuQ4+8wrDwx6ta0uSDbYVoe/8tbDpqKY2Xca/tLuVJkaMVfSX28D0UT+H23cZIMICXPEZ1SXgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731731007; c=relaxed/simple;
	bh=7akGrFdoTBszm7z6Sgnh3qmpKCzmsjEGYVpGlkRszXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LDccBxynpro1SbCq8lSrUY8Px6A8LvwaACFL2qv/RxPxXneHB+bZKsq4Bmt3hRHtGq+qLnDvAzqzYyFRhTUyyIcUnHQN2qXbU0/VimMkZGTTFXnXZ+g0NeMkjs4rlSuSQw7ruj8Hrv4B/1mHy341qPURElevwLtBjMi5OzeL528=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lB7923GG; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-720d01caa66so1298126b3a.2;
        Fri, 15 Nov 2024 20:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731731005; x=1732335805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0tlot2yyxrWqW9V2Ak2ioTy4DOmvr1gmx7I7YMSC6PA=;
        b=lB7923GGUtMU41RYocfNam38x5rN+yf73//9FMbzXpMOnswWMZP2sRl6xsiiH6qQsB
         JKtzUKWNo8KSFnU76LBKJr8rkzjGFN8UYJHRmos5Wvuft3oGCih345VC/26k0618ht2Q
         VxEKzENDd6uZW5a2jYkwNMSqGszYPj2EQcic1/iZ9rslu4WVxSiHx1UTg6LN0yUVNdI5
         sO4kQq8pDJtpN+PZIgkAkTT0l7hz/BsTBeftJNxF+8NcaID2cavkyznsW2OAad5aGlds
         xa6J07jbD+MZWrNhqpFMJQ5tYSOclhLoaxchzKq0uvRC+w4VlIWGTGxk6wv604D2H6Jy
         8Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731731005; x=1732335805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tlot2yyxrWqW9V2Ak2ioTy4DOmvr1gmx7I7YMSC6PA=;
        b=dnG+agM2JiyQI5OgljZDqa8FXx3f1jmnn4qNTKAwjppsIwrEBzUksW1vKJrPRQkr2B
         2Tq8+XaeDAF4Zmr0AlfiApQyqfLYFmfoOAeNceamtrcKRuPgJ8h/km7RrziBjeyruOBW
         6SMY/w26xiTLKAGxmRSOH2e5GDZvUzP5L3wj+R8rJ+OZtn4hdlpiwzaG6y9wvqH7fEmq
         vybxrOtNf7HXqmh8995tMk7IXyA2vhSlOspULEEKOZZDwC4odyGBJfNav6Qk9MseM9LV
         Zct/uG+xmWDTkanziQW3wrJIM1qEABgHPU3O+IwHL1SCcPdy/xnER9fMMbQEmDLFfe58
         Q9bw==
X-Forwarded-Encrypted: i=1; AJvYcCV7v+bYPPXro9M8EMV5D2BzMU8u5nHK68354OMJfEQt1XhWUqaWHgDgT/MI3uFQrqj1d+R4GDUuzKw5ZNw=@vger.kernel.org, AJvYcCXgZG10c3MbYqeP4Nx6c0FDW08HkjcZTEoDq6oDHk9jd+/+pdPkVHaenw3E33j8uvXDw1doF6A7KfCL9NZre8vQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxD15FWjOQ5PfpJhYdmUw0+MCH9dmEtlXDOhv9Jk3I+WDV1AJ
	cdW3lDwRTZqfZdFdAy4gIwjzyajpvl/Hw1rcdbi2wBiQc5sA20Uk
X-Google-Smtp-Source: AGHT+IFqmHhJ4EFwbN79Fl4Ln4i3wfDKo61jt/nCvg3uspSgZWP+RUb2V1i0kq5UvFV7azfzpJRs0Q==
X-Received: by 2002:a05:6a00:140f:b0:71e:795f:92f0 with SMTP id d2e1a72fcca58-72476b672dfmr6851952b3a.3.1731731004607;
        Fri, 15 Nov 2024 20:23:24 -0800 (PST)
Received: from yunshenglin-MS-7549.. ([2409:8a55:301b:e120:69f1:c187:3b69:acf9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770eefe7sm2175394b3a.31.2024.11.15.20.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 20:23:24 -0800 (PST)
From: Yunsheng Lin <yunshenglin0825@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linyunsheng@huawei.com,
	Yunsheng Lin <yunshenglin0825@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Linux-MM <linux-mm@kvack.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] mm: page_frag: fix a compile error when kernel is not compiled
Date: Sat, 16 Nov 2024 12:23:13 +0800
Message-Id: <20241116042314.100400-1-yunshenglin0825@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

page_frag test module is an out of tree module, but built
using KDIR as the main kernel tree, the mm test suite is
just getting skipped if newly added page_frag test module
fails to compile due to kernel not yet compiled.

Fix the above problem by ensuring both kernel is built first
and a newer kernel which has page_frag_cache.h is used.

CC: Andrew Morton <akpm@linux-foundation.org>
CC: Alexander Duyck <alexanderduyck@fb.com>
CC: Linux-MM <linux-mm@kvack.org>
Fixes: 7fef0dec415c ("mm: page_frag: add a test module for page_frag")
Fixes: 65941f10caf2 ("mm: move the page fragment allocator from page_alloc into its own file")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Yunsheng Lin <yunshenglin0825@gmail.com>
---
Mote, page_frag test module is only in the net-next tree for now,
so target the net-next tree.
---
 tools/testing/selftests/mm/Makefile           | 18 ++++++++++++++++++
 tools/testing/selftests/mm/page_frag/Makefile |  2 +-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index acec529baaca..04e04733fc8a 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -36,7 +36,16 @@ MAKEFLAGS += --no-builtin-rules
 CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS = -lrt -lpthread -lm
 
+KDIR ?= /lib/modules/$(shell uname -r)/build
+ifneq (,$(wildcard $(KDIR)/Module.symvers))
+ifneq (,$(wildcard $(KDIR)/include/linux/page_frag_cache.h))
 TEST_GEN_MODS_DIR := page_frag
+else
+PAGE_FRAG_WARNING = "missing page_frag_cache.h, please use a newer kernel"
+endif
+else
+PAGE_FRAG_WARNING = "missing Module.symvers, please have the kernel built first"
+endif
 
 TEST_GEN_FILES = cow
 TEST_GEN_FILES += compaction_test
@@ -214,3 +223,12 @@ warn_missing_liburing:
 	echo "Warning: missing liburing support. Some tests will be skipped." ; \
 	echo
 endif
+
+ifneq ($(PAGE_FRAG_WARNING),)
+all: warn_missing_page_frag
+
+warn_missing_page_frag:
+	@echo ; \
+	echo "Warning: $(PAGE_FRAG_WARNING). page_frag test will be skipped." ; \
+	echo
+endif
diff --git a/tools/testing/selftests/mm/page_frag/Makefile b/tools/testing/selftests/mm/page_frag/Makefile
index 58dda74d50a3..8c8bb39ffa28 100644
--- a/tools/testing/selftests/mm/page_frag/Makefile
+++ b/tools/testing/selftests/mm/page_frag/Makefile
@@ -1,5 +1,5 @@
 PAGE_FRAG_TEST_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
-KDIR ?= $(abspath $(PAGE_FRAG_TEST_DIR)/../../../../..)
+KDIR ?= /lib/modules/$(shell uname -r)/build
 
 ifeq ($(V),1)
 Q =
-- 
2.34.1


