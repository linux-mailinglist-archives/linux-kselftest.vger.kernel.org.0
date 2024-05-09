Return-Path: <linux-kselftest+bounces-9864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7228C16AF
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5561F21A5F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A251313DDCB;
	Thu,  9 May 2024 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z4A0AYDC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1C13DDAD
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284970; cv=none; b=XymlVNt6ruF75rwNL3/Nx7QapMVwtTF/khaFuM1lejcXfrhDtWyJXb7cSpxU2fxQOzbbQau415IeEJT0lIB1o/z+jFflmuc3uadGCUatHnNyqzCYebSiPFHDdWV9A9s4JBOH9rwYGG144n8J5mAqltwrCa9wZ3yERWzGv1mxkg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284970; c=relaxed/simple;
	bh=k1/mENn4Mu/LdxPYs//P/acCJ954uWxS0ZTmsgOp6eI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qr7kLaf4hYrmUhnxgen5Jffe80YQCyfo7RHKdSjdMuVL9bXgpPj4wwOY9M0qe1LSA/NIwZ/W8liZpKDI4ShcNusXTAdUjuvkNexpgG697yTB6IqGaBcI6eC9yVGuFEoSH4tjbflsewEiVUMQNo+IfRe0BUS08GrWvjBnssv6U74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z4A0AYDC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de603db5d6aso2162658276.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284968; x=1715889768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DejFIYPZQZTsM/+LO58ySZeQn2kJiejmAm2sMCMuO7w=;
        b=z4A0AYDC0LnIy3XoINyCEtndclk6osJg4NeOEk2a81jEY8BJq1Ajhyyz7l2O2COYyo
         TbIDg012XP90WVDfIoe2ymoCKEicwla1EJNSmM7+u+V6gjXt0CfcKPOn3mA2+Csrq74J
         2eQR9khBkbBkrnACLrpMqcP/Gg5dl8bgsNRpqQQu8GtGVMsDDAM3c+cxosBbH4F1SVGe
         /WmK8eoxPy1oPXX/BMplvmAcietrH7T6OFRSNFvFFESUiEsGN+wHv+8V0vxBo8voRYop
         7LVJPJDJLAbYjnrzj4TGFR8G49eLm+e+Gu5qXDeOAd7H3JErOFKKXWFgEp5lX+iQtylP
         ER5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284968; x=1715889768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DejFIYPZQZTsM/+LO58ySZeQn2kJiejmAm2sMCMuO7w=;
        b=rpL6PArurfoCjgsO4bKB9IHoJp6V55cc1UA4uVVkyuoe5JPIjt6e7Gls6+Zs2C7kOX
         3QYTZHk5TEyZPXAF2E4kpDpinCDjzR8eFITRbRpwWVQUZkTs2fU6bW6HuRKvFDW7gDV3
         rKhC/gPiBT+YrpjVkfKMzPpn33M7VrNNQEzCdlf4ekLJNRAK/0PwRMGEPMvn10ONdiOM
         T05BVABBtkEWASmZPy0s270pt0su2eXgQUcp+MVw6GMLGWDxnDs3qPdANGeEzYg+dwPG
         p61ydCi3hw2QhPemSyCsjEZt7fepfGLYruO+gcncdlZ+UwM86eSBTj9dgQARr0pm/H6E
         HAgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV10/5m/JlEm0xkEH/fKVKg0R+pnZn3pobLDrst/2qQXxMnhczmbQT+E3t6Oj2kdW1gU5hGUTx0muFdPIT+y4AGrdhwKFBKuBTOW1Pzla4x
X-Gm-Message-State: AOJu0YyITlJSea8MpHJYrRV4gwG/PFqfAad50/iSHhvDnVAtsFY40EdK
	2J1eip8WJxsD9PAuVKB0lr+mXanMwD8Y7KcSzzSEySEWK2z8HEMazSBFQjbd+PaipYlXDTKu8L1
	+9A==
X-Google-Smtp-Source: AGHT+IEdLp2VxpSy+gBCP+tFT6yMYHSt804gceq7vlOW/cOE2J14dukRIxLzbVA95cAChpE8hv9KqkAbp2k=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1546:b0:de4:77ab:5fea with SMTP id
 3f1490d57ef6-dee4f2d1110mr162718276.2.1715284968047; Thu, 09 May 2024
 13:02:48 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:33 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-42-edliaw@google.com>
Subject: [PATCH v3 41/68] selftests/openat2: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/openat2/helpers.c            | 2 --
 tools/testing/selftests/openat2/helpers.h            | 1 -
 tools/testing/selftests/openat2/openat2_test.c       | 2 --
 tools/testing/selftests/openat2/rename_attack_test.c | 2 --
 tools/testing/selftests/openat2/resolve_test.c       | 2 --
 5 files changed, 9 deletions(-)

diff --git a/tools/testing/selftests/openat2/helpers.c b/tools/testing/selftests/openat2/helpers.c
index 5074681ffdc9..3658722c889c 100644
--- a/tools/testing/selftests/openat2/helpers.c
+++ b/tools/testing/selftests/openat2/helpers.c
@@ -3,8 +3,6 @@
  * Author: Aleksa Sarai <cyphar@cyphar.com>
  * Copyright (C) 2018-2019 SUSE LLC.
  */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
index 7056340b9339..ecd20a3d47ee 100644
--- a/tools/testing/selftests/openat2/helpers.h
+++ b/tools/testing/selftests/openat2/helpers.h
@@ -7,7 +7,6 @@
 #ifndef __RESOLVEAT_H__
 #define __RESOLVEAT_H__
 
-#define _GNU_SOURCE
 #include <stdint.h>
 #include <stdbool.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 9024754530b2..51f1a7d16cc9 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -3,8 +3,6 @@
  * Author: Aleksa Sarai <cyphar@cyphar.com>
  * Copyright (C) 2018-2019 SUSE LLC.
  */
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <sched.h>
 #include <sys/stat.h>
diff --git a/tools/testing/selftests/openat2/rename_attack_test.c b/tools/testing/selftests/openat2/rename_attack_test.c
index 0a770728b436..477125eb64e2 100644
--- a/tools/testing/selftests/openat2/rename_attack_test.c
+++ b/tools/testing/selftests/openat2/rename_attack_test.c
@@ -3,8 +3,6 @@
  * Author: Aleksa Sarai <cyphar@cyphar.com>
  * Copyright (C) 2018-2019 SUSE LLC.
  */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/openat2/resolve_test.c
index bbafad440893..48fa772de13e 100644
--- a/tools/testing/selftests/openat2/resolve_test.c
+++ b/tools/testing/selftests/openat2/resolve_test.c
@@ -3,8 +3,6 @@
  * Author: Aleksa Sarai <cyphar@cyphar.com>
  * Copyright (C) 2018-2019 SUSE LLC.
  */
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <sched.h>
 #include <sys/stat.h>
-- 
2.45.0.118.g7fe29c98d7-goog


