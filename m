Return-Path: <linux-kselftest+bounces-6521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E43F887F4C
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Mar 2024 22:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F98B1C210F4
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Mar 2024 21:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822721CD04;
	Sun, 24 Mar 2024 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDYrwCl/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE44C43ACC;
	Sun, 24 Mar 2024 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711316681; cv=none; b=WatpOjtVLEJNuqWx9qmunV1A8ao1Zt0NhIJhLKwVS20pcm39/tr+5/rTqutb9U354tOuhqRAR/76ty83vEnQ8iouMfnY3fgH/TyO1JJejFYMx8PVYdZBgozxH5jobEqKNjcjG3bbFQO+Hylf4S+0vOIWPD30IUcF80mCKOJpBBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711316681; c=relaxed/simple;
	bh=eDIrS0VVRPXkwD7aNTqBTZq2rIf5/MoBWbIEz2aA+yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nxT/3JO74xHB6BP2hA667T7+FPvj5K9GTQBQzt8imrbA8V9JpgUzQ/sr2zvp/5MkscbniwiOcfDOxQnYG5AzbjhOOmbSt/D87ARiMLi3MjxC6Bshu/o43mlzKSFQqeDNjXSb80QStYk6zlV6d4/aPxz2dNUmjuL94+IFn7ZxrXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDYrwCl/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513da1c1f26so4706492e87.3;
        Sun, 24 Mar 2024 14:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711316678; x=1711921478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwsAY/PMAecJs3xHSlcN58/6nhzeih7nuL6YHNk5t0c=;
        b=DDYrwCl/fs0wZq5zp36Lwwl/1zR+IRc/ivGK+EcHxnncoZ1Pu2qYywO1ebeDwQnuy0
         JGO0rwT+SMMKY2vcp54Pa1T58mPkf7f5cNtVHmZHNnJqOXYG+hd+JOqHIBghzQyVRRqw
         EdWYCPc/EGEDfl/Z3ueMubR8QsP9rbrH6dOqZCr9sGH6tO2C/8/lVx/sZgUnluIObR/j
         003gVgHPSRGBxWKqhIh77wxdF4VqN4rpbLFBdpUCWs4WpNfK2Mo/Jj5KBOUmUfTUYhqo
         pFqh2aw1+f69Ph1qHX++UIbtZ2wXJXQtIqv1Wc8h2Nm4KmBVv+yXeP+Sv03HLnGuUccw
         qfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711316678; x=1711921478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwsAY/PMAecJs3xHSlcN58/6nhzeih7nuL6YHNk5t0c=;
        b=l7mbYzi8jLdBy3XHnxqrHXsNJnYve38tQFdghlt19LA/KV0h7R0EePKdDmnx3W8MsQ
         4em5IUwk9XtT75b9vcWia4lzJ3L5pJ2JGqzVrN2dLInCJqcP8cWFLHwJE6ueesjv5Thy
         OXQazFDShD/gNfVZBwBuWldyzKaOgYGnHCzDeSLIp5m0TRX/Nbac7rKTp4Zk4tvX7N6k
         /2E4E8C8Z0DI/ZPZZYVm+gqEkuLisFg7i42kjsXUOwQaM+flB8Gpk722WygyBnKhZXQq
         M5c6RbzJJPyJwSyWy9Gh0ZNU487rbh3B5gDWOzdv7yY/X0ff5DOt95/vQGpBRU1tXE1Q
         yLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpYbMrI1Xf/DRag8+KxRYR6x6FCvgR+B/ySMSzxthzMXWyOU0y7dBP9zp5RMfASP+EwICYi8cwRpR4DNPUqJya8n6qy6BQYdDrxjTdVCfpRp+ZL46bHE9UyedO4YMgI72OasSImdR7YM0H1fwg
X-Gm-Message-State: AOJu0Yxxp7yAsTPQMssoudx5tQV3+6XXQI+BYwRDZEkuJ3LxGLtCOdgn
	4KiiqaCIRLpPsN712xwiKA5JNrx+WvUb815iTUYLtzF4JHkBzg==
X-Google-Smtp-Source: AGHT+IGOEQi+eBbD+bpy0qFtF3OGxEjdxQDibvlw/5l6mQkYc9NVxP8JdnHG8c8qlDi4w2WKEnOpHg==
X-Received: by 2002:a05:6512:44b:b0:513:d49a:7a0d with SMTP id y11-20020a056512044b00b00513d49a7a0dmr3373355lfk.42.1711316677479;
        Sun, 24 Mar 2024 14:44:37 -0700 (PDT)
Received: from localhost.localdomain ([85.89.127.166])
        by smtp.gmail.com with ESMTPSA id h22-20020a0565123c9600b00515a36f5735sm687609lfv.61.2024.03.24.14.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 14:44:36 -0700 (PDT)
From: Shengyu Li <shengyu.li.evgeny@gmail.com>
To: shuah@kernel.org
Cc: luto@amacapital.net,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wad@chromium.org,
	Shengyu Li <shengyu.li.evgeny@gmail.com>
Subject: [PATCH] selftests/harness: Prevent infinite loop due to Assert in FIXTURE_TEARDOWN
Date: Mon, 25 Mar 2024 05:44:19 +0800
Message-Id: <20240324214419.12577-1-shengyu.li.evgeny@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314224323.23201-1-shengyu.li.evgeny@gmail.com>
References: <20240314224323.23201-1-shengyu.li.evgeny@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses an issue in the selftests/harness where an assertion within FIXTURE_TEARDOWN could trigger an infinite loop. 
The problem arises because the teardown procedure is meant to execute once, 
but the presence of failing assertions (ASSERT_EQ(0, 1)) 
leads to repeated attempts to execute teardown due to the long jump mechanism used by the harness for handling assertions.

To resolve this, the patch ensures that the teardown process runs only once, regardless of assertion outcomes, 
preventing the infinite loop and allowing tests to fail.

A simple test demo, also this is related to the issue mentioned in this patch
https://patchwork.kernel.org/project/linux-kselftest/patch/e2ba3f8c-80e6-477d-9cea-1c9af820e0ed@alu.unizg.hr/

#include "kselftest_harness.h"

FIXTURE(f)
{
	int fd;
};

FIXTURE_SETUP(f)
{
	self->fd = 0;
}

FIXTURE_TEARDOWN(f)
{
	TH_LOG("TEARDOWN");
	ASSERT_EQ(0, 1);
	self->fd = -1;
}

TEST_F(f, open_close)
{
	ASSERT_NE(self->fd, 1);
}

TEST_HARNESS_MAIN


Signed-off-by: Shengyu Li <shengyu.li.evgeny@gmail.com>
---
 tools/testing/selftests/kselftest_harness.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 4fd735e48ee7..230d62884885 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -383,6 +383,7 @@
 		FIXTURE_DATA(fixture_name) self; \
 		pid_t child = 1; \
 		int status = 0; \
+		bool jmp = false; \
 		memset(&self, 0, sizeof(FIXTURE_DATA(fixture_name))); \
 		if (setjmp(_metadata->env) == 0) { \
 			/* Use the same _metadata. */ \
@@ -399,8 +400,10 @@
 				_metadata->exit_code = KSFT_FAIL; \
 			} \
 		} \
+		else \
+			jmp = true; \
 		if (child == 0) { \
-			if (_metadata->setup_completed && !_metadata->teardown_parent) \
+			if (_metadata->setup_completed && !_metadata->teardown_parent && !jmp) \
 				fixture_name##_teardown(_metadata, &self, variant->data); \
 			_exit(0); \
 		} \
-- 
2.25.1


