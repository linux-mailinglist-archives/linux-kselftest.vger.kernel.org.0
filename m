Return-Path: <linux-kselftest+bounces-6880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A61A8922ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 18:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AAE288FE4
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 17:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55227136666;
	Fri, 29 Mar 2024 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0CsAUCur"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D0013473B
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734198; cv=none; b=jwtzRsDqNtIf98T1IhAOPkFi8ZOcQWDufofqTq2sJtjHBXGjBF3ReGRPFAVsFncdawxZmFs8Ij5ATpGi5j+kmEq5dm9amVC+qUEVPA4e17Y8C6V0JgEacx8aLfXsl30UY2G62zVeqLeQvy192r0WOhPrxbGCfm6bVFno2p9oMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734198; c=relaxed/simple;
	bh=Db+baHi+o4t0sQoTiWsOVnUn4il6QNvBEK0IZXfUirU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kPzz7jJrLM+vXihFmCu0vCEUyAVV4uRJvah2OGw27DeFi3RlGmsGJVcWlmo+mXFLgiJd2MXnUPJVlo1z8fh4w35OhWOgW2DBEbDsofZmdece9oies0ejcFr51MMRPzVZ9MO2FTtrsjfVO3wN7aWPEObNXsWHvrjVGdHWMNBWVp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0CsAUCur; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cf35636346so1316673a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711734196; x=1712338996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y4P2FVE0GZuV8xN0/OHVBz5dTMWkMVwFfht6IsCHyUY=;
        b=0CsAUCurp4t7G1JkcThQ79Z4+C7JaHoT92iljz51HTJBfdkCrScFUvSHSB3XGeLO47
         8Nxfp/+e4OlfbyoLXyj2g7XGoT58gUFoTETo6cCFjkmNREP6W9qBdjaOCrYQ23F2fPhb
         TwihifiRlJYxzHYZjUs6jr9x8OOW0BSYwxplZZhehmvay0AO8mxGgxfZ02RhjzuhmS2w
         qmQ1IvY+OrNdg8z/GwKwSRfel8Yst+/yasFqcgrjNBRWzI3LAddPrBBaqn5ErihEZZUi
         S+WQk4deHCYZcnSFHhj3VwIKvbGU0kaLpx6J8/ukfrycrzR29ZzShCnxwcTs1fJEdZyP
         +i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711734196; x=1712338996;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y4P2FVE0GZuV8xN0/OHVBz5dTMWkMVwFfht6IsCHyUY=;
        b=iotaKIc7w8R2LUKmcrbu+z64ZRVm7nM2JFp955BzeNYN4mH9dodJDl8MsTlN0MauWt
         SJJKwK4tqo0bYpcGGYt7OV9btWqMDbcqci76kdjeeugFmlTHaZO84NS2cWTQv9sNqIi/
         gWQmqVRykNEFtlmd3KD9R1duk3qRm+wmlMjVDwKSuU/vCRLvsUt1cMksysQOUn4gVsGE
         SdMzck81jpEE4dLktbW6RkaWG0BtsJAyjShst4F2uNnqfCpso7pnN756qbqwu1DyoILc
         /vc5jh5qCVP+/YtYK5+8YjBwRCZfOciktXUNaIO+R19s+wxwGGFA6qmq1RNpR1EhqaHA
         BndA==
X-Gm-Message-State: AOJu0YwMG2qtu4mE7MFj6rUsT1xo6jyAjS8RbKAtEbHAQz+Glh0pz6eL
	NxOf9D/Gclw8r/yYdGJ6iCFx70jcanzd3aLrT/eo7u5yzHrCr6tDsxKiZ97T2d31ZPMAIYJ2j5U
	zWQ==
X-Google-Smtp-Source: AGHT+IEk3daVAOxTw6ZxgVuNe0bbBjzztiCGBF5zYuViJhnrfrxtU4S3QA/1YszNBdzc0L46hiha467222c=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a65:4388:0:b0:5dc:8af0:ca81 with SMTP id
 m8-20020a654388000000b005dc8af0ca81mr7467pgp.7.1711734195797; Fri, 29 Mar
 2024 10:43:15 -0700 (PDT)
Date: Fri, 29 Mar 2024 17:42:34 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329174236.2278217-1-edliaw@google.com>
Subject: [PATCH] selftests/mm: import strings.h for ffsl
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@redhat.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, linux-mm@kvack.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Got a compilation error for ffsl after 91b80cc5b39f ("selftests: mm: fix
map_hugetlb failure on 64K page size systems") imported vm_util.h.

Fixes: af605d26a8f2 ("selftests/mm: merge util.h into vm_util.h")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/vm_util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index c02990bbd56f..9007c420d52c 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -3,7 +3,7 @@
 #include <stdbool.h>
 #include <sys/mman.h>
 #include <err.h>
-#include <string.h> /* ffsl() */
+#include <strings.h> /* ffsl() */
 #include <unistd.h> /* _SC_PAGESIZE */
 
 #define BIT_ULL(nr)                   (1ULL << (nr))
-- 
2.44.0.478.gd926399ef9-goog


