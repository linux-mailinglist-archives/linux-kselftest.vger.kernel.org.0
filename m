Return-Path: <linux-kselftest+bounces-47117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 724B5CA8807
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F38C302D2CC
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3055E348457;
	Fri,  5 Dec 2025 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPlv8YPY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADBE346A1B
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954748; cv=none; b=IeRzJgzedXZy09BSSjwYKaNs25S0C70ZRMQ1hwcUFAxwOJXeDVYCqLe2WlPlTzrd9b2+kG5vTIspHUmdyneP3FcVO2AYATSknlB5XpfYTJHwMJ3d7KPo/bsXUd6sfjr9TdWv06nrzrfIqCemKd8krgI0x8tB7Hb7/+4Sc95gmrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954748; c=relaxed/simple;
	bh=IxOhZQlEd/Qy+CepjX8AS60bi75DFljz0EePvluZ/lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3rGEXJEfAGCq4natXWIezZh/dxTmmt6KdRFbQtYXsTo1WkPUL2Vs3I/BZ/a4zgl3SBQJu379Wco9wVe6AMZ1HPvoSGt3eAaqhqqC9jAarKCGY/+7552ypTxAqWRctyhuI7mlbBq2wtgerfckS8X8aBSXpV3nagTlS0VvW893b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPlv8YPY; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-11beb0a7bd6so4118807c88.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 09:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954736; x=1765559536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4IdV8qLxCXpcZvIrzxwaz1yCq/7QPM0MNgJTT3yV/c=;
        b=VPlv8YPYEfO7w8MO9RAkz9CUM0VsJEckg/+CMpdCFwxKyk4QYo7JaR2dY9SRwvIsqH
         Oe0bdXebvMAi2Q6TKgcFa8sfg7zR8FLCuvTWH4EadyIuMHcWfDxEGwF7Maxc9fPjGb1Z
         KeKNJ/CbG9zRlmBpr0K62GFO3l9L2n6G5BYjk4BB6TBXRaD8ANhntTpvFBlDIcj29tNL
         wk9a+SrD5rHQ6r7QgT8srfuowJic48rHP26yFS7NoWGxTJQ6Tav8bndTFUnqfnM29OWj
         jSq4tN8MSf2clwr7crYZYD2VRcQfMKMDbKj1gELuwYBdWF9ATJCmzu2Qr/sfdA8FPXcM
         zuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954736; x=1765559536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4IdV8qLxCXpcZvIrzxwaz1yCq/7QPM0MNgJTT3yV/c=;
        b=gxJNhKF+FxGF1rdLRzZNqTqmlvlrvnXhxK4NThl72mC3mdtgxA905r6f1hxnUqD5IE
         br8eDqrUFqYs3GmXsr74KBpls2MZhIrTTgRZEYrp9hiG+KYzRKF//f3zi840NDyMrmtS
         qByJWM5f4MpjRVz9WHAsdXbiBw706MILlx0Kdw8hAD2TT2D9f6rllx0NFnA8THNy1D7T
         hu+uqiIQcjLjTkIacTsQJGRIY62R95wAUofoM98p1fOsbcUMB2CXzEjl2SGxhFyA543I
         xW4NQuxGd2S+VzIvomSTGFibdmGEOYFtwdSSlamPFYJFBbEmI2Dqrg72aQ6zEX5GHQJ/
         2rvg==
X-Forwarded-Encrypted: i=1; AJvYcCWQX0NuS+qLwhKukbD+Ns9EHIvej+CpQ1r39SY4oQiRuN4VnZt84FnKHV/FRRJGE3Ivb6TU9fXhvXMGzY3XXKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzec0gzDCDwkCSmFCi3+ZW/E6NAD+MnkuI+BkMoSkv0MBxn+6r0
	5/uUQK3yjn8U5lSJTCn84MePZ786QjzAHr6gZOoWClkAKpfKxixAM/1S
X-Gm-Gg: ASbGncvC5WQ2POSxwtFDD8my/BCu/WxwHtl7k5YfJFptJxXJBe22SerEll0dtzSYvbF
	mLOVWDhQhjElmamGY+MrntJpblvBx4kOG4fkpuzkbx/ycAgVTd/aKVijGrHcHATsco0NqZBW0eZ
	iBzou5hnX+uCnaKloy5OdsmGS8esvzS9K5zFV/tx0gABo8JYjtbS68ANzqthaN4khusxAw6nq2P
	S5QPi0fsk8in6GB3mBKrLwmp6Awda2e0ox+TPfaAFGl/VvEhTsi60qHNENyi29rIGepancPJqeU
	XCtuTMEwruP2/rdqJrgDSlJIl0r2rTiZRicSOgn8xlTkf42d5FXM3JH3Fbauf2XikstTWj7YoTC
	bMAfg8NDxSBSNwgFPj5HP4pejrJLfwwMR1N2FZdr//xf2YuavIha0naagBrENnUb5WqEWh+bI9C
	3sSmhnai9p500Y3addXhfH/bHielayqokSjw==
X-Google-Smtp-Source: AGHT+IFIrrXmeRELseDoVSjhKR65g42A+CBh3uKmPIej8MyEU1H63Ol/p4iC5ibACsKwkEY6LwYTPQ==
X-Received: by 2002:a05:7022:43a4:b0:11b:ade6:45c7 with SMTP id a92af1059eb24-11df5fdadc6mr6650958c88.3.1764954736002;
        Fri, 05 Dec 2025 09:12:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm19408894c88.6.2025.12.05.09.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 05/13] selftests/filesystems: anon_inode_test: Fix build warning
Date: Fri,  5 Dec 2025 09:09:59 -0800
Message-ID: <20251205171010.515236-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix

anon_inode_test.c:45:12: warning: call to undeclared function 'execveat'

by adding the missing include file.

Fixes: f8ca403ae77cb ("selftests/filesystems: add exec() test for anonymous inodes")
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning.
    This patch does not fix:
	anon_inode_test.c: In function ‘anon_inode_no_exec’:
	anon_inode_test.c:46:19: warning: argument 3 null where non-null expected
    because I have no idea how to do avoid that warning.

 tools/testing/selftests/filesystems/anon_inode_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
index 73e0a4d4fb2f..5ddcfd2927f9 100644
--- a/tools/testing/selftests/filesystems/anon_inode_test.c
+++ b/tools/testing/selftests/filesystems/anon_inode_test.c
@@ -4,6 +4,7 @@
 
 #include <fcntl.h>
 #include <stdio.h>
+#include <unistd.h>
 #include <sys/stat.h>
 
 #include "../kselftest_harness.h"
-- 
2.45.2


