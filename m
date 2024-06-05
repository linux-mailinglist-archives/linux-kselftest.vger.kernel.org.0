Return-Path: <linux-kselftest+bounces-11267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CED8FD9EF
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 00:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A330B1C23699
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 22:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D07160887;
	Wed,  5 Jun 2024 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4lbkGThx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520DC1607BC
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Jun 2024 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627015; cv=none; b=KqyRTslXy2kpsRY63FX4ZeVqUrsv8Kqh+Ihk4iQQo/G1cEQr0ISUNM1jcMD02xuV/HGyHg4NvjZ4hAuyFkmMaiK7NuKWfiJebOAAsPZ+QjkTN54EpMYk+EGgGOsvrkjFpAz1eFOwK1JhBx2ZC/l6NWraHqdaDWbhANfBfrJecRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627015; c=relaxed/simple;
	bh=9eIW5Nk9I4U8j48RPo1MRyDNbVsR5OYHwY3uM3dehXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FsGPH6qAHBGvwDmxnfu0B4O973MWbeLOlflN+WD5U2AD5SGZA7lkUnLKlZdIh4n7WKD/QBrWGuX/PSWM7xGWj0+TDgbA+pGdn4dvM9VyOg1jBWuigL74dDcK2xeVfn0INnktO3ufzvgK2YXPRzrj/0hnuxbwHKz8ZzFyvRGPo7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4lbkGThx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a3dec382eso3617897b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Jun 2024 15:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717627013; x=1718231813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvR2KzRbeN2y+kQBsoY3woptqhul8uQMwsNjpEueFQI=;
        b=4lbkGThxkiUpMN/0jwXCXsnJX3PCW4UQENIqDyWnmGotw02/rp5TiIapCC7+pqP/nn
         EaNCX+m6x1uIQ1OS0qB9q+1feW16DiFlasAh6Yu+A1t143SClI5OL+mny+4YHSZDm/Qz
         iDlpVVG4c9LjVKyRSX8Zphr352aFBj7rfg9tgukQ50EF97uPyMceZnjz+foFGoMjZsCV
         65EqqkxAgsg8GyhAlTSNfYY5t4NuHkuuOQEd9Dil8SBn0FUZctsUuoYXr6Y1GTN/9Nyb
         lmWmhL5eAfB/QsQKpjWkGQ0m2DlZoz7AeNn6QJTjdAVael8nbB5fSWsr0DThu56v1Y0+
         WW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717627013; x=1718231813;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HvR2KzRbeN2y+kQBsoY3woptqhul8uQMwsNjpEueFQI=;
        b=dhQlL6kY3VNu3751vZJGOglrZeMKFLASKMwMuCEiXml/8/WJ/U8/GjQZXwfbGAxlof
         DphsE2Cx1xiDX39E7odVHmsUmlMPRSyvABQ+MczDdFflhHODwNJDjbfpDcwG7DZWzvw/
         7GbfYQHmgkX+/yB952Bkqe5I3D8IQnoXsl8lfyO9OdpGHz8g1rGxAS0K2p/XAYX4sEPn
         E0Edt0ArU1pCruD+LWnIJWNsxVHbAQuDCSfdoZ3rXxAWllkQos7r4QIirzcUMBtYmeqL
         Btk2oSFrn/yCY7HE4SxRFbnZT1eoZhQmjetisAI6CznN44vvdIwHgQrJf8YwKZB/4UNP
         yAOA==
X-Forwarded-Encrypted: i=1; AJvYcCX2QvPXhUgiUA3LQ2XYvEBttZi6z+TreNCb+WD2GGyqtbW86eGyuwUWPGftL6QE+qgJCtEP/9gLDhzo6Dz644u9hz9xlLxES4na22+MK0an
X-Gm-Message-State: AOJu0YxIxdNArU9QVtlj3JpnZl1vkfZZIRSAOcthls6OpncVq9a6iyD1
	ITxG2CJD5h9SnYzYBJXwSBUNRvXswUGxhwTl5wxTF8ZlZXqZbu9L9dbxkhZvbmQql6wd4GjKgpe
	4XQ==
X-Google-Smtp-Source: AGHT+IHQMSg3BZwEdpTjqj45BkSGSDIqDJ5xpSLfVCjXGbqd16zv34TQGDGB9Qio8PSsr4E5OLx/pSf4zjw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:6413:b0:620:32ea:e1d4 with SMTP id
 00721157ae682-62cc6f92037mr2991207b3.0.1717627013381; Wed, 05 Jun 2024
 15:36:53 -0700 (PDT)
Date: Wed,  5 Jun 2024 22:36:35 +0000
In-Reply-To: <20240605223637.1374969-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605223637.1374969-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605223637.1374969-3-edliaw@google.com>
Subject: [PATCH v1 2/2] selftests/mm: Guard defines from shm
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: cmllamas@google.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

thuge-gen.c defines SHM_HUGE_* macros that are provided by the uapi
since 4.14. These macros get redefined when compiling with Android's
bionic because its sys/shm.h will import the uapi definitions.

However if linux/shm.h is included, with glibc, sys/shm.h will clash on
some struct definitions:

  /usr/include/linux/shm.h:26:8: error: redefinition of =E2=80=98struct shm=
id_ds=E2=80=99
     26 | struct shmid_ds {
        |        ^~~~~~~~
  In file included from /usr/include/x86_64-linux-gnu/bits/shm.h:45,
                   from /usr/include/x86_64-linux-gnu/sys/shm.h:30:
  /usr/include/x86_64-linux-gnu/bits/types/struct_shmid_ds.h:24:8: note: or=
iginally defined here
     24 | struct shmid_ds
        |        ^~~~~~~~

For now, guard the SHM_HUGE_* defines with ifndef to prevent
redefinition warnings on Android bionic.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/thuge-gen.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftes=
ts/mm/thuge-gen.c
index 034635317935..d50dc71cac32 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -34,10 +34,18 @@
 #endif
=20
 #define SHM_HUGETLB     04000   /* segment will use huge TLB pages */
+#ifndef SHM_HUGE_SHIFT
 #define SHM_HUGE_SHIFT  26
+#endif
+#ifndef SHM_HUGE_MASK
 #define SHM_HUGE_MASK   0x3f
+#endif
+#ifndef SHM_HUGE_2MB
 #define SHM_HUGE_2MB    (21 << SHM_HUGE_SHIFT)
+#endif
+#ifndef SHM_HUGE_1GB
 #define SHM_HUGE_1GB    (30 << SHM_HUGE_SHIFT)
+#endif
=20
 #define NUM_PAGESIZES   5
 #define NUM_PAGES 4
--=20
2.45.1.467.gbab1589fc0-goog


