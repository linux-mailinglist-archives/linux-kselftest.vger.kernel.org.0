Return-Path: <linux-kselftest+bounces-9950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02448C1B10
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653E3286B20
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122FD1386A6;
	Fri, 10 May 2024 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRNlLLG1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B11384AB
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299860; cv=none; b=l/mCO4HmSmWkOMAjn15LhbOatEHMfUz1TqLkKRq00AfU28dxvJLntf5iScLimAwRLP0jKX/OuK0fLbVDLn2PCT3E5Xl0h/g57zfQVrKiXyU6NfsNjGQfRHLaB+N+DMrhhLk4qikas56SxhiQYQ5l9sSUpiJzVOH8R/U0s0XroqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299860; c=relaxed/simple;
	bh=PlH2ryvPza3XbatvZGTYKmksy4ISV5hABhu+UnwWsg8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HRIVJ6d4VebmiX9waAMhIaJ+zsUmp8oe3EKCnEuLm2TPq/ffpbwd/uqYpzoQTZAiXXy2I+xgc5TCGLg9uD5k6n7YB7s3R/nW4gmuh+alxABTbTzmJ6voEvqhciLwhwLPvZF+/jrBc3SnGiyP6Hjn6QwJ/bi87unG+kvlpYhBOPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRNlLLG1; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-635f5006685so606676a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299858; x=1715904658; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kMcDSSxWXBrY3fYB5DMyoDoFJQzub0IzoWq/+JBZ+ak=;
        b=SRNlLLG1rLsx7c+soEyyP5hu/oiiUg9+ibCJz6sYafAJqdO2JGoLYLbd+Ji+d8uKYP
         7rXbcTvDIJ0GCQKGct+Qm+HtYYdp4Zf2G2eAjz/f9fTYIqjpXvC2oHfvjhLC6SSzG0Zi
         NOEMd0EgWsAM+npOYUdQPe61YgQIuM9R12qEb32EjQ3m0xcguLvSZOsNm4o/I3jhEmoU
         wgi/rP832ciASZsrwhXet2vuAWSX1POseA19+ogxrg14i7KoZSN1oyDXQ3QcPEXyUhJi
         HtMB4y+7gq3cDY8mEc/Gsj5t9Yz+HnACUUtZaGlR4qE3TGl3VzPvWMbSRpB3TPWedlnF
         nrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299858; x=1715904658;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMcDSSxWXBrY3fYB5DMyoDoFJQzub0IzoWq/+JBZ+ak=;
        b=kgAuJIb7kmQWdtPFGwAmTdtA1+KJvQrGKKjLJMX9M5lYHWjmmmYUsf4deUMQt75Uyw
         uKHIQpO8E/V84C+tPEYjz9RWvclMd7b92FbNlX1anKFbhwyYDXsiPqR0Sr4JzdRbanbD
         FOyUncJ7seYnkQ9+UVGabftsCBlzfiHw35Z4WiW/oEOhMV6ucTGRWej7V7jrVtUW+gf1
         sMv0gW8xPYgtta62BG3yh44lvMXaIsa1lAdPbVVyTNbHZYBnaFBAwbvniJMaTZd0tOlb
         i1FylKcQvWWjs3HWE+czLaSShpLc5Avu7AxqxpiMl8roTEKs0TYdg/PzguWp/Wu5EtOh
         BBKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCaU82qAqGKkrs2qG81KzY87mjrYk88A+h19+rR0ypCLqNK9eXy7+zoGVwu7xTUiFBjLp7IuYIFuP3PaJLsugk5Ri6DhDhg+rSSxwiTQEy
X-Gm-Message-State: AOJu0YxneTRi2EPd8wzhmmWBrR8hSRkU9/bxiE7px2nCcNWxyts0xtLB
	wORzxypDM4SAtLnBHdJXmH/EcfC+O5Et5AFjFgj3Gz4f+9hbF+9NLOnBn8skmUGjKsvVLfLcxdK
	B/A==
X-Google-Smtp-Source: AGHT+IFTfIR9ZNxLhki0C2wWWB4797X2daDkkkc7DqzRvRAIH+7XYQIOmm1yx/VgJ+AcV1OpnXiFGoc/jNE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a65:5185:0:b0:5dc:877c:cef6 with SMTP id
 41be03b00d2f7-6373c976894mr2360a12.2.1715299857838; Thu, 09 May 2024 17:10:57
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:56 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-40-edliaw@google.com>
Subject: [PATCH v4 39/66] selftests/openat2: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

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


