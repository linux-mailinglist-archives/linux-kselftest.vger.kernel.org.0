Return-Path: <linux-kselftest+bounces-31959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A42AA3BA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D7FB7A9479
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F3F2797A6;
	Tue, 29 Apr 2025 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="N2NuSz6v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705E827703B
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966474; cv=none; b=lBgCJXT8g1mTGjCfZZ1TV/qyZnq/9m6eLQZFR2Ky4XEcAoNjhX7W3AqxfbApxrOrQpBKxz5KoimggRTfCqwEUZaX1vLgT6hiTwISh07NSTCJbG4bdLYnnt5pWUWABeLajbnzBu4Ylh22hgIhePKi3C2SIAsn3Wkf/E3St3sZJJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966474; c=relaxed/simple;
	bh=ObuAsSl4WZHTMvFnPb6US5OeBMXHiIWBUHv3E4P+6ZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYE79cKVs57likwHYPt4YmBRpN+QWmvnNO/AF59wdvrAKPEmrq1UWiIVLoGroGXMKKof49YIBlriHadKZtUmJdOnd7ZJL37HecdzvFhAXV7uJU0FVE+W8EhRYazmjWNkeRyZx4E8pmrks9UmI3xuIkaSvq7o0dVj7Vdlo4b/UYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=N2NuSz6v; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-70821dba48eso51856757b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 15:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745966470; x=1746571270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5UBAAEMQRo7Cyw0R0b1FnwG+WPDkBuKLP1lc95VWmM=;
        b=N2NuSz6vDYXkot94vhK1O3n+L19mDGc0v7HKxKKWZrTpg/tAdQZnbIzn8RV1CxA24j
         WuQ6cbeKk0ROUFBxL3JyD6qARmTZ5n5DcZbHIaq3kdiM8JVNfrHafuRjWfgEVMG088Jz
         NYgaTEOCnMpqyP4znQz3lIuSKWglDu0N9pfM8cGvFLPihrQHknyYDma2INDwUHuMVUiX
         DYbNQ6TYvVrE9B+diMnlYYawe35uEKsPwryApNOwjoHBJsi+hui8XlbmuZ/t9Gwnne71
         xsOV+dirjfnykUK1Mt0Cwhf3skdEleiAEKyd3mQFbns3Sj9FinWd2WRoi2nRHwduZECB
         65hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745966470; x=1746571270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5UBAAEMQRo7Cyw0R0b1FnwG+WPDkBuKLP1lc95VWmM=;
        b=b47q+fJCwkRxdT/Tp7/Fq1X6WTGqJp5YOxNmComdfdlNm1oAulpp9g+c/CPlKr6d+v
         FLV1SDce0Y36G0/BvNYZqzj4VZDv3k2QeniAC7h62+FaQWA6mn+EN4pibUX/jHvTqsxa
         +EOzcb2+PAInk2W0Uj3HtyYO3ggEFpT0diMIHvJmENylSDCCkLJ+1lacLryAgliC0W6s
         h2Tit/EoM2fEZ+jyWZpi286XPAO5UBweUbco1VTsymYkumP35ucbxqVy2buO01LGGUbr
         Lf4JDAew6wz2emYcFmW3Tv2G4dzq00mHs9r2mauOgZjznCcLTSauCikiOF6HCpmOlPWb
         V5UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhZaQs8shhWBN5xl77VmbM4UxNNKJ7kuWEYF5Qx1Y9sj9rGQSQGcCE6rVlHVSqh+gScqGDHF1+oKWBeh1sAE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4yJDi4Wal7gfwT9H67odtw0oA0YbJwnzkHAjrZVuuwu29I0El
	CmQ36HWLWt7XLj2rYGHnnsIe46BJSWdpHn/G/+GdKr/cRjax5/oMa8+YQ/gbad8buNLP45FRmNt
	gJxZRv/d+Ni63p6UhlWpffoOZL+8W4Lxi
X-Gm-Gg: ASbGnctlhxogUFp8qYcuzhULd1WhooZqbO35EIuOdKuu8XhlpFgseYDQI5DBKR4FK3l
	y3c8Roqc+qisOVuBJrVU+B0g4Cg5L4RbCuO0hv+2E1oUXI7RFwlD/KmWjEOJAcWQTkQvTIEkAqL
	UaKCUfJ3QumNDAP4833+0Zm3ico+aTvu7JOiztS+szSEa29POfm8uauV6oS9PC4/hssOYWoBJRp
	Dh3AuRj/JTKxndO6IlnxeKxtxNdDv78ljmsl70zg4BhTiObPSrgwom0e1FuCbrvB0E1K3rbfGwv
	x4SruuBYlw7MYvfLIYXNgK4joYmIt25O61FExatBZ5sDsw==
X-Google-Smtp-Source: AGHT+IF0yMWC+jrX3o7QqODqh/qL4kwwrsmmLtw5gv1rlU/mBGIQgXBbEeZPRzdVsm0dUCh6BJkRhAghKdmH
X-Received: by 2002:a05:690c:6c0c:b0:708:a686:7f04 with SMTP id 00721157ae682-708ad5c00d5mr9177577b3.2.1745966470249;
        Tue, 29 Apr 2025 15:41:10 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-708ae0694a5sm75197b3.40.2025.04.29.15.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 15:41:10 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 030583403AE;
	Tue, 29 Apr 2025 16:41:09 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id EAB40E40ED5; Tue, 29 Apr 2025 16:41:08 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 29 Apr 2025 16:41:05 -0600
Subject: [PATCH v2 3/3] selftests: ublk: kublk: fix include path
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-ublk_selftests-v2-3-e970b6d9e4f4@purestorage.com>
References: <20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com>
In-Reply-To: <20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
X-Mailer: b4 0.14.2

Building kublk currently fails (with a "could not find linux/ublk_cmd.h"
error message) if kernel headers are not installed in a system-global
location (i.e. somewhere in the compiler's default include search path).
This failure is unnecessary, as make kselftest installs kernel headers
in the build tree - kublk's build just isn't looking for them properly.
There is an include path in kublk's CFLAGS which is probably intended to
find the kernel headers installed in the build tree; fix it so that it
can actually find them.

This introduces some macro redefinition issues between glibc-provided
headers and kernel headers; fix those by eliminating one include in
kublk.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile | 2 +-
 tools/testing/selftests/ublk/kublk.h  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 529ab98a2633a2278bc0df8b26500905d60d2bec..aaf011520040d3e96912c876bf74e488e774e473 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)
+CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)/usr/include
 ifneq ($(WERROR),0)
 	CFLAGS += -Werror
 endif
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 918db5cd633fc1041e1e0805142f00e7e4f28bf7..4b943e57a890e5f14fa11dd19d67c4c8684c4417 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -19,7 +19,6 @@
 #include <sys/inotify.h>
 #include <sys/wait.h>
 #include <sys/eventfd.h>
-#include <sys/uio.h>
 #include <sys/ipc.h>
 #include <sys/shm.h>
 #include <linux/io_uring.h>

-- 
2.34.1


