Return-Path: <linux-kselftest+bounces-6881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FC98923C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 19:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32281C21DB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 18:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0013886130;
	Fri, 29 Mar 2024 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzPkf6Bd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DE42D603
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738708; cv=none; b=MhL/CMODZwtHfCoXr+vrP3ttbhNQJ6rjKt2lvrJDhzwkuNGSuC99xRld90qoGUyXvHAVxKW7QJrneIJsXDb51pvlJarZekDiVqOFsfKM4aEJJN1REAf6/PGILsYBxgmO5hu44R6tUEHX4kDOzoy9cu+2BZ8HMTYhvozhGU3OAg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738708; c=relaxed/simple;
	bh=TZwuVTutyuYWS/hRX6g2t+0lQdgDJNCLshkGhJvNRDI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SXRMOpyg8NyP+kYyQ6H+e3/gydbpfg03TnN/h5+fg1260b4Q+F2daBi804px4oVYbMo2bXmaCTPrRXXcSh+FEGHUg+1zBTsVcZ7H3DXNCOwomv12GNdVeRWK9aLo+LEysemVvP4iN2w+K8LjoDFME9OvG2AoEwVz97NtbOaEgd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pzPkf6Bd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a2386e932so41761127b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 11:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711738706; x=1712343506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W6jpWkrIAWPntOGVPlX+CoN3n1daGIwh5z3zUFqEtOY=;
        b=pzPkf6Bd/rWxHq5Sx+3e83J/Zdiz7d1Xpu6dnPZLiV8heO9xvkT+HngGsN8fLhD1TB
         J8D08vys+drn07VbjDhN5Lt/g/fs3IPWJSnKUZ0yYRNfoCrvIZE+yKrrsvVlGSOJxz1A
         1E9ze4HlzHSGOHpZE9hA19KV78QLk+GHMUrOW08ydBUwW9n8D2WriBMk6Kj60lzaaY1J
         m88pi+fYdVwaaajU6Gjune7ArvhGHzGlH5PAjrh+9lh4JD8mZl2FWJj8PtOsp+J6jJWU
         /zswaDdrUvh4PtxsHeUfWH00K8AjQ5HKpmt5PGtB8wLPVCChHedDWX+ixQvJRCRbjupE
         TuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711738706; x=1712343506;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6jpWkrIAWPntOGVPlX+CoN3n1daGIwh5z3zUFqEtOY=;
        b=dTjlM+3u0qwhrB4wYQ+vdP5UY+QQOrzTN905P3HwDbRMVkrI6p4HMwh4+DoVT8wRCT
         CY4yIB8xTqpNkUMl5wZ9O9qgz16Eib+uXLFLDHZ/1ZtG7Kui9vvpF+c7j28EPpcfh6xM
         QS9Y0bXW4teN9r8UrGasQmM/J3ED+dFYr+T5VCMOre9PVQeHFc+MV+jWaVaAVjyJykZK
         8Ihq2WEdRZ/UXWgPb8lxEKbUUm+2GL0428fp8XZdk0ME5D8fsQDTNsQUqfZJbEruO2MU
         3uZQWRkG7YTJKPiuhl2WUSFQnp6J72xUywHXTrQRRqQN9pFAyfpdAarbUmtYbRluIpfV
         j76Q==
X-Gm-Message-State: AOJu0Yyj+hJJvCDLXIf+1xm5s4uwWxiXQnnYEBn3K1xkevDqikZcPGd+
	f3nwhPmF1bgh0yAMHIMOEpIqQzCteJ7LIilpI6ttdEncim7AcXfX0Ae25yhvMnzHdU3uy0AClaN
	FRg==
X-Google-Smtp-Source: AGHT+IFFFQ81uVFMy2JFSqiJ92NRr3e2zklngl/rFoikve1UjEUR1bAtgZavAMWyXRRu2Nmkm6XBrFE1SoM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:e28e:0:b0:611:9f44:3d40 with SMTP id
 l136-20020a0de28e000000b006119f443d40mr811961ywe.1.1711738706411; Fri, 29 Mar
 2024 11:58:26 -0700 (PDT)
Date: Fri, 29 Mar 2024 18:58:10 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329185814.16304-1-edliaw@google.com>
Subject: [PATCH v2] selftests/mm: include strings.h for ffsl
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@redhat.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Got a compilation error on Android for ffsl after 91b80cc5b39f
("selftests: mm: fix map_hugetlb failure on 64K page size systems")
included vm_util.h.

Fixes: af605d26a8f2 ("selftests/mm: merge util.h into vm_util.h")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
v2: s/import/include and clarified that compilation error was on Android

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


