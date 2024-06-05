Return-Path: <linux-kselftest+bounces-11266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 155398FD9ED
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 00:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC091C22DB3
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 22:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8541607AD;
	Wed,  5 Jun 2024 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xl7hNSDy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA3215FD07
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Jun 2024 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627013; cv=none; b=mtz6mIsSviJeimEFF7SbetH+7MzOhwPSCKpQB1frOol4qcdYqxFdk3zJLAV+XWlBA5FkKNAZ+blvAHkAaZfwoc/pzrMTEFkBRLA9r0aNZQnsUK9O1PwOT+BJ/g7KjJRZN6Bibq2OIbOJcZJtVLR4GPER//D+sxKY4CWxTzk3gL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627013; c=relaxed/simple;
	bh=YoSBzgIyczq0SKCblGNBogA192bjVxhivYiaa+qfXhE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N/WfEXoArW345xoaYXifmAk1RmClKZLnxn4qplS44uaRcyPciKm4uYDoNZH8n9fwLUVMk4I8zMvNBUvDIL0iI00YKnFIre4z1AyG4Bjn5iQQXCn2xN6zS5OGmWf/Db+jgXpBqN3QgwokohWG2Dljg5+B1CEifmuDCLy18rrE++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xl7hNSDy; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-703f8e691faso264271b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Jun 2024 15:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717627011; x=1718231811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W09wuD4FxLrgIE1KeD5W+uP9/uZWU9NhM8LDAnFpogw=;
        b=Xl7hNSDypGwWWw7y2OzzILnVdo767cPxrMUU3eifTvp2UZ3o80tu07Gu/TKVVENXh1
         ugnLZfYxOKZ47qLSgxV+NozItwUaa5B7bHWw0lahtyhshXmvmMFKp90QHGBjnCIWnM3Y
         ij7TGvKlRcEKQ1B15FLm+1dromJw9cR55WmuzSRmVEXbf0YSa/UV7jgnBvgQi9idJf13
         3XtjYFocUe2EniX59pty2JL+zAOF5J5/ynR1zCUp6bCdVf3GKPrakHj4V6cXvKyOerkD
         mxxa4EDmgEC2bg48M1vDR8XsupB54kr67/KDLoTaZN7hKwq6rqafhZXEpDlY1DdkR0cJ
         eDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717627011; x=1718231811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W09wuD4FxLrgIE1KeD5W+uP9/uZWU9NhM8LDAnFpogw=;
        b=jU10WgxqNzjVHVNBtv3MjgR3NL05rysU6jpZCSXeL51lOT7KXyAf4HvLmYPYrzVnYd
         K59KbUNOLBAVfZLDTizmPVL9cPulfIUx2LyT3dpXXoxuwJeYn95zu1trPR/O0w1Anw4a
         ypU3RlSfmh1QeH91SrTq3MDOfL7W3xMUafA/SiU64rfXxKVUOiIEt447Bzwu+mDQ/g9d
         tyUU7y2n/NdVWC3TrvDPi49B4ScWoOuI32Q5TWx+49FL/dDyFHZDHB8Fam2Q9RTGy5KD
         cmDzR04zNEgOURclnNtIB2FHJV5S4xjSMyMcUV6Xvnt1Dkk2mJr07O8infGhHKjcpQH5
         VtMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCWw3c4fl0raN84IBN/bIsZwj8QH8HLSQHA2e2LW9PTT10skfR5ZKtbq/Ft6yJJfG/vKWnZ+T+KABnpCiO9caQItxzSm/1HX7QJkdqdXVl
X-Gm-Message-State: AOJu0Yyui8sfT073Q8ydSd/ZonvHKmMEaoW0CDJh9oF+N07Mtbm76H8F
	AwWbNXrJfeHpJ9KBXWWtqPholbFVcTX8/BeTlx+aknwUwA/h3oZoXpA3g4nEOK8sCp6s0AUNH6s
	HLg==
X-Google-Smtp-Source: AGHT+IFMIrLdQe45thJUN1W26E8IgQCgCg3jMfWtuEwXZZmX/GxigF7WD+0J3Zd+VqHvwqAm4zpgp44oOeM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:4f85:b0:6f0:b53c:dfa5 with SMTP id
 d2e1a72fcca58-703e5a7f7ecmr58171b3a.5.1717627011007; Wed, 05 Jun 2024
 15:36:51 -0700 (PDT)
Date: Wed,  5 Jun 2024 22:36:34 +0000
In-Reply-To: <20240605223637.1374969-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605223637.1374969-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605223637.1374969-2-edliaw@google.com>
Subject: [PATCH v1 1/2] selftests/mm: Include linux/mman.h
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: cmllamas@google.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

thuge-gen defines MAP_HUGE_* macros that are provided by linux/mman.h
since 4.15. Removes the macros and includes linux/mman.h instead.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/thuge-gen.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index ea7fd8fe2876..034635317935 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -15,6 +15,7 @@
 
 #define _GNU_SOURCE 1
 #include <sys/mman.h>
+#include <linux/mman.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <sys/ipc.h>
@@ -28,10 +29,6 @@
 #include "vm_util.h"
 #include "../kselftest.h"
 
-#define MAP_HUGE_2MB    (21 << MAP_HUGE_SHIFT)
-#define MAP_HUGE_1GB    (30 << MAP_HUGE_SHIFT)
-#define MAP_HUGE_SHIFT  26
-#define MAP_HUGE_MASK   0x3f
 #if !defined(MAP_HUGETLB)
 #define MAP_HUGETLB	0x40000
 #endif
-- 
2.45.1.467.gbab1589fc0-goog


