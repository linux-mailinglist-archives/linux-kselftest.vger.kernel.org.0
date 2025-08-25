Return-Path: <linux-kselftest+bounces-39835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D13B344BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 16:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5201893F81
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 14:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395562FC864;
	Mon, 25 Aug 2025 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="U45/bRS6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E42FC87E
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133856; cv=none; b=H/mr9y1oCe/WUQjs0/9+oSlYn8cN1qp+2R8/Wk/Lb1l3tHEl8jP+EUzoxi7UQq9vBsYThSY9//8v5TE19DKwaM4wlYIAdlwpddCP7Ycoq8j3Y4h+pA6H9jExdti+nOqMMYoRQaLsqOCvWJrXOj6AxKumnCSsUSpZhxmwtXdF47I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133856; c=relaxed/simple;
	bh=5SQHOFh1sUDEoQa/LsWjRDqFRqBAtXV8PziERqMxVJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OEpI+PxCu35c9j9ljBxjHFJlCGmEl6aRtOWYUJFQCFJ5aurV4J+4Cyrs7MbVmZLv7JRXj3jr1fufTL4J/LW6hVNQtxeKh0cQ/kUQa2cnHFNUl6kMXtyCV07Dtme7i/NlPRYK5wEzMUP+rmnMYjYgfDmBAUoowkAEQ3fVTL1yJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=U45/bRS6; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so3981218b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133854; x=1756738654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SS8UElWYPBKNDeTRQOyijx7AjeTpgm/xr/2yY07TeYU=;
        b=U45/bRS6mtIk0S7Xl3Gc5ye+V/U6c5SiuMFFrUaS2fykbmQTPOMAj7wnH1653Akm1s
         PHxJd8ZBJPxFepuJFiaDjCSndeB4XiBEMsD5Tm7egNHI6hnY/lxVT8UQ0ssCzDffX29o
         esg8vb2bmKBxdWXBvKpXY0VKB/ANW80ZADXlJ52ANC76FjfgJFQP4hmmZEIlUEN1iGGQ
         ywpk658DjXNJTutBsl3HW2vIt224H2aan54En+nFMQPDDUqRd8OpJ5H1nW/LCLtouzez
         6jHyKsGMI+vJVCWvmjKTrHK6cz3pg9fFo34CHcyQxICw/zb5FyvB5qEoPQSQjVhFcEjN
         nGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133854; x=1756738654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SS8UElWYPBKNDeTRQOyijx7AjeTpgm/xr/2yY07TeYU=;
        b=IJzv48uC3q2/NJq0fwMOjYNt35Hfzu7wj+jbSaK1Q7Y/YWZj/95IpMgavCfancN/El
         SsOTUhs2Z3WRT0AdbelXJN2A59t3HsW5qz/InA8WmhLoVy3rPHQDFiCBS23XzpALh+04
         VyukmpQ+6P12Wc0hdOsNmbCkM5NKqrW2Y1eXAt0/l3zKhcUYbIr2m4LHCiFBD2iI/O61
         i4fAZrkkpxGSKH+4gAxlTcucLqOpnT24KalmCQhGikL2UAdfU0Py7uo9CYXtyQaKeqLx
         rqHYeGVTORFRw46bRfOUUpgYkGxd2fOr6amfOFFHZMqCJf+qzAY24rUoLJaCDiiRk1pp
         NmsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo0dMYkkGDKCmjE8R8NpqpkB4weQfqAPG/XDCTfpJbYR3lvVPI9hJqtYAJfotmHrwfm40j4dIDADNuOkbfZSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/wsKIqZJzWYxi+VH5HqPDYzGw41gHXs6FWcNpnGpbB2aTG2K
	P4acqYNoVYw+nob5f1EnmzpAjoFjPOrYcRnQVT2w9zdl/FxFyZWT35OqxSUETLaM2zM=
X-Gm-Gg: ASbGnctFDUCvGJDOoZEwhIGCw+zbcp9VrR5W1IkxCUG8VutV2buSB95+Ydbtv+feTMh
	JJh+AWvUbK+NZ2DbSs8SGLJ1ZY1DU20mYBB+ush6mmPW/cZgIYVZ6ZxVsFuaZc4U1vy7dE8407D
	GfGBojYha8xZiEkK4o/cK2bNeTc2AD2nEyXgQTNUwxnRC0NlQmDRKU0AUfHmoA7WmUA8jUPA5zQ
	11TmVUQBxyUalOJMQD+OMwXeHbEMSCOupn5Ayo3488WkikbUpKiUEp9vXmVyKbp3nAaMeugteJC
	Ji6Ib4YuB7Tl/ndJBwfVAgC+b/ssmKhkGwnMAfQf5ySUP5nPf0fbwwVQKC67aDyk9dHYorDetBZ
	Qhg3KMyWzBsIXZD5Q6Cs2Ls6KPz4w+XgEMC586N6Gn83wKaKAq+yb+jYezPLZ
X-Google-Smtp-Source: AGHT+IHz+meFfe4e38cUw2IZHOaqrwBamHHnHRSOwdnH4MJHnCKcgOHroPbVyCsbXw3Co2hLg9rpTQ==
X-Received: by 2002:a05:6a00:3e01:b0:76e:885a:c33a with SMTP id d2e1a72fcca58-7702fc28b0cmr17435058b3a.32.1756133853573;
        Mon, 25 Aug 2025 07:57:33 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.57.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:57:33 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 1/8] mshare: Add selftests
Date: Mon, 25 Aug 2025 22:57:04 +0800
Message-Id: <20250825145719.29455-2-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch sets up the selftests project for mshare and add a
'hello world' to project.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/.gitignore |  3 +++
 tools/testing/selftests/mshare/Makefile   |  7 +++++++
 tools/testing/selftests/mshare/basic.c    | 10 ++++++++++
 3 files changed, 20 insertions(+)
 create mode 100644 tools/testing/selftests/mshare/.gitignore
 create mode 100644 tools/testing/selftests/mshare/Makefile
 create mode 100644 tools/testing/selftests/mshare/basic.c

diff --git a/tools/testing/selftests/mshare/.gitignore b/tools/testing/selftests/mshare/.gitignore
new file mode 100644
index 000000000000..406f31bd432c
--- /dev/null
+++ b/tools/testing/selftests/mshare/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+basic
diff --git a/tools/testing/selftests/mshare/Makefile b/tools/testing/selftests/mshare/Makefile
new file mode 100644
index 000000000000..651658d091c5
--- /dev/null
+++ b/tools/testing/selftests/mshare/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS = $(KHDR_INCLUDES) -Wall -g -O2
+
+TEST_GEN_PROGS := basic
+
+include ../lib.mk
diff --git a/tools/testing/selftests/mshare/basic.c b/tools/testing/selftests/mshare/basic.c
new file mode 100644
index 000000000000..482af948878d
--- /dev/null
+++ b/tools/testing/selftests/mshare/basic.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "../kselftest_harness.h"
+
+TEST(basic)
+{
+	printf("Hello mshare\n");
+}
+
+TEST_HARNESS_MAIN
-- 
2.20.1


