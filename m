Return-Path: <linux-kselftest+bounces-3830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8FF8440A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B4728C02E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 13:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EDB7C095;
	Wed, 31 Jan 2024 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ+TZXm8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D007BAF3;
	Wed, 31 Jan 2024 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708034; cv=none; b=FGoxK0FMzaqZO3HEWN5o56a7mVhHAgn9/+9nGn5IT5OZlQXeHBtGMMrZY/okGADEheUyDbaSGTVo5oPDDqrKrGom0wh6a2/5lSRai5D/J1CRcUn5BLoF/dN939RvPma1NhbPvo1bqwoo2wIIYW/fWxXZOa/Gx5VWvE+5MyFjssI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708034; c=relaxed/simple;
	bh=x7pDRdtnj1w7St6knLG86KC9J7zYvKmaTgXcKEEy/xU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k8asbr9vj1CuVB8dSvVGO17BNHx9MXVo/Jvt0Wj6d/UNXVc/zWuofra6NtdivHrU/nvTfJnXUpyXjchTDUbBAgA1ivPxAKRriv5yhIgEcjrWTi7JRHLNe7woH70TG3CwuxzIZ7GfBdyA/Lx12HDH7ftceytvYyGlml2tpUyOF9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQ+TZXm8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55c33773c0aso5534410a12.1;
        Wed, 31 Jan 2024 05:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706708031; x=1707312831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g2vX3j9pZB99MF+ul54pGfWjbJyQ2L+Maw8cOuYH98o=;
        b=AQ+TZXm8iCvlbK2HPg1/e/QgQc4qkVw8LyO1PcnvftZ5lqpoO6zDRqRcf4/WZ1IkGJ
         WY2CrimbWNo6EgveN0YrpSA++QJ1FCOYTV/p3Z0WlgbBIM+1Ok0yz/Gac3iMmLiKsN3m
         3xcbTKCwYOn93KAG6G7g6VdFHsrh1QMW5uF/792iCirboGZsauX5CKs8gbTeQ1oNmmDr
         6J2jUkCQPvmreDr4uODXdwcKpEOsxp1UHQjAuaIpjZhcXtGmudCvBEe8VWeJCH1LY+Fl
         n7hUiWPSc/GmkuMr47CV+WnErIBi5/YqrPqODwQQpEVfpmjU0gU4xdORqTQTHCSuYbDh
         4OgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706708031; x=1707312831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2vX3j9pZB99MF+ul54pGfWjbJyQ2L+Maw8cOuYH98o=;
        b=TrHRoZToMbtAHCfu85yqPKflAGWUbKE9NUD1t/rE9hlYRzwTxF0P29XRxzL3BVgbYh
         oCHAwNndgmDdAHlOZOhslBFhp5/CcGhKmxG+1HQ0iqi9ezelxahgj0h3UheYArcVEqDf
         PSkNA+kgLw9tAu1mhc8PcbNCjddjmYH/aM5yXGaX+Y8xZr572gRNftrnB81WzsdOF2ji
         3Rr3CYRPfqbB/hxOFW9GTh6/ViW1dgwiE4yg0GB0Q5duOe4ZVxvuBLCK6f0pKcRP4bHg
         eYuOTpneOY6S2gpEfR6s5UgFmpJnixhgyIryFt4sQkpIhc+GCyjH7lyeE+CuhFAw5DnR
         +kdw==
X-Gm-Message-State: AOJu0YydK4KBcPkV6MerceulSOOgC2mhcAMyt9oHFw2TUqwgMlDKpfeN
	frByNbjfX+c2Z9vPvj697WxjZMuAcRrxQbVf8ZScg57fCaZJkYhaVg3F3p8I
X-Google-Smtp-Source: AGHT+IHsKF1n9XLJxec1HD9HMXbUCbpxrOuB0WcplBS4PYu5bbUSEj6toKCDUOFEw1hW/o1CeKMgow==
X-Received: by 2002:aa7:c354:0:b0:55f:144f:4fe4 with SMTP id j20-20020aa7c354000000b0055f144f4fe4mr1215227edr.27.1706708030981;
        Wed, 31 Jan 2024 05:33:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUDDjDXbSp+3d4LcD8AzgYOe5pzNlbspew2zInXso8UidvVhJiQ2SBRl/jb3FU2N4E6TKtX4pXuQ6151wRYuLlWNa0y5Mn6Q0DDwyqbCY6HK4R/cLgu36NZzx6KXLbxPW7gAjIKkitQL9BNbet/PhZVbFSnR0RY//db2vQDD0J5AWWmDJvniUR7DLFG+jC2qy9UTHRgyMf4fxjvahyFptd6Tb9QfHEmC2/vriR2tJmaG2KsKRP8LmvvwarOGwv2wAefeYT2Z6K6VD1iuw2tUPY0TmQ8Oc1Oizc=
Received: from localhost.localdomain ([213.55.225.76])
        by smtp.gmail.com with ESMTPSA id fd12-20020a056402388c00b00557d839727esm5866201edb.7.2024.01.31.05.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:33:50 -0800 (PST)
From: Ali Zahraee <ahzahraee@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org
Cc: Ali Zahraee <ahzahraee@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: ftrace: fix typo in test description
Date: Wed, 31 Jan 2024 14:33:06 +0100
Message-Id: <20240131133306.7723-1-ahzahraee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The typo in the description shows up in test logs and output.
This patch submission is part of my application to the Linux Foundation
mentorship program: Linux kernel Bug Fixing Spring Unpaid 2024.

Signed-off-by: Ali Zahraee <ahzahraee@gmail.com>
---
 tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
index add7d5bf585d..c45094d1e1d2 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# description: Test file and directory owership changes for eventfs
+# description: Test file and directory ownership changes for eventfs
 
 original_group=`stat -c "%g" .`
 original_owner=`stat -c "%u" .`
-- 
2.34.1


