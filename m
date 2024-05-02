Return-Path: <linux-kselftest+bounces-9298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C91D8BA382
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 00:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027CD1F24781
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 22:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABF61C6A7;
	Thu,  2 May 2024 22:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GXlHVmV3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E117D1BC43
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690421; cv=none; b=LivPxkhg3CdUV5UzFiJFfY3kDTvHv2QMiNPCvx5aDfriFsXvQqo+x+tdQ6zYYMj1rBNcy9r2hbJgYUYZjWK06pozpMWETIdaj5fimWAfYn31DoecxdzwjjT3g2XrimnMMVDRHMaCLQo4YtU332uldMKw2zUUyaPaHJywR3SPy2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690421; c=relaxed/simple;
	bh=9EIDvlKn8H06U3Ns7X4JkY7FQixrkq70JScwUwcT+Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWBZrlyn+fBqXH3DeBsx98IDiIm5qE/M+A2h85IwAvqAlF3PNArziE139FGuRmWnQTwY3KNBYH2C3t33oxEFrqp/MekfCoHPM6Ze4XwYaFrDodNOvwAvQmplxajgAQcc4HYzqMk7xLJCbYRHWXkU6b5z5WNv6/wiZ+19RTEnYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GXlHVmV3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso14423545ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 15:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714690419; x=1715295219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+CbTYcuXhAHq3pBgBZF2uLGBq5IUxFnRXQZTgCCuoI=;
        b=GXlHVmV32OySEyfV2tzM7/Zcoi9qf2XbShd3IE5te99M4XGjmb8J3ysGDFySvO7HIv
         vrNel25xbPgx7HNUQiV2speMTI9EWLue/TrCaIBTqLOi+XZfgihfJIeWAAVy08HbJfqL
         YprL+VAkMM6uFaXU5wbt/9fBVGbkGwuZE2tLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714690419; x=1715295219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+CbTYcuXhAHq3pBgBZF2uLGBq5IUxFnRXQZTgCCuoI=;
        b=qUt4ZVI6Gf6f9qqjEle4waGkMLcbgXBN1UgFooiEoy3DN1G4H9uQ+O/Zi2X/9Lq/MD
         Ao8/+syjoPcwSWsPBZhy97++EZ0/eAse51yYkrtneGGaIFPfjfwUL1PXFE5gn6qffSvh
         IbwlAGkmsyqrdfGSG8ID1vMTZUKWlDyo6x/oiuoscahP6UY5IYV7AzXaAyebQYkN1mh6
         wZ+qB16Qu3f53Zdi1Mrp72xw4yQuu9xIWn516iI8V3ITqEGx3+AriyqXEO5aaRN8xWT1
         Z2adikgNM/kPPQQyXbxCcRukxdpt7hwMFFz6RbQdjLanbnyJxfJNVFC5qJtO5WP/LMxB
         tZjw==
X-Forwarded-Encrypted: i=1; AJvYcCXMem4r+LQAhSxGrpteldbisjxEr9y9Ddn/35XQfpWb9iAeeXyATxJyxZ0nhmRQRe6vmC/C+pUHQvMGHUIi7w1AIzokTUmXNCwxpeaf0TqA
X-Gm-Message-State: AOJu0YzhSBxQVzyL51cr1APq7pc4usUDt3mlGjG1mHpOsTRqZxCbopeB
	0LSl9dWpm01QJ1GabgnJ0fi0IGdRcguIeHnZnRNQklkh9YokY639xULlLuPDtQ==
X-Google-Smtp-Source: AGHT+IE828cNgqxiTXs3gOeTLsF+43jhO+3qFfjtUspZftTwhCEXBNu2gvO6RoHEZi05oN6gZOpuIA==
X-Received: by 2002:a17:903:264f:b0:1eb:bc78:1ef5 with SMTP id je15-20020a170903264f00b001ebbc781ef5mr950791plb.17.1714690419185;
        Thu, 02 May 2024 15:53:39 -0700 (PDT)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id q8-20020a170902dac800b001eb3f705ddasm1861884plx.255.2024.05.02.15.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 15:53:38 -0700 (PDT)
From: jeffxu@chromium.org
To: ryan.roberts@arm.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	dave.hansen@intel.com,
	deraadt@openbsd.org,
	gregkh@linuxfoundation.org,
	groeck@chromium.org,
	jannh@google.com,
	jeffxu@chromium.org,
	jeffxu@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	merimus@google.com,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	sroettger@google.com,
	surenb@google.com,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	willy@infradead.org
Subject: [PATCH v1 1/1] selftest mm/mseal: fix arm build
Date: Thu,  2 May 2024 22:53:31 +0000
Message-ID: <20240502225331.3806279-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240502225331.3806279-1-jeffxu@chromium.org>
References: <20240502225331.3806279-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

add include linux/mman.h to fix arm build
fix a typo

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/mseal_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index ca8dbee0c612..41998cf1dcf5 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
+#include <linux/mman.h>
 #include <sys/mman.h>
 #include <stdint.h>
 #include <unistd.h>
@@ -29,7 +30,7 @@
 # define PKEY_DISABLE_WRITE     0x2
 #endif
 
-#ifndef PKEY_BITS_PER_KEY
+#ifndef PKEY_BITS_PER_PKEY
 #define PKEY_BITS_PER_PKEY      2
 #endif
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


