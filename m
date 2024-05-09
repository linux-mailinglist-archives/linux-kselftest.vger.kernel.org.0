Return-Path: <linux-kselftest+bounces-9883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 300EE8C1711
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD792287D8E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36912146595;
	Thu,  9 May 2024 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="paD0SECV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA548145FEC
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285023; cv=none; b=T/WoXxZOJDI41+4/Et9QbK3FjyO8StixayLkAaCWXl5UuUyDp6lm94HdL490OSZTffnYwun6EZmgRidtk9NYsLExgBro021W7UEfze9hL6F+F5L+E8ZdWOXaPdENfc/8QYu2+I3vk6mWlpD9FLlyBBeH5Ei8aeCmUU5BYeSt7Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285023; c=relaxed/simple;
	bh=drfJBkOcI3OrfjhbOo/yaR3wt6nXvItHyB4hpcflWKU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L7nNLKKfAyn9Jy6nfOZ+3brAjv45Vsh9Xadns+PJ7sIO0FPtdH6JwiBvjWmbC6b5wAj59b8qd0hX2gXv2X1YXRKnty4tzA8aU10LESxRb7cVhrln0hfMmTRorsH8swGGAP58DbWn9NT8F2wwrXqVS6d4EClpFX+wGe152aNiZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=paD0SECV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b402090778so1224738a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285021; x=1715889821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pXOoN3MSopkhNhuWJaS5P2NJD/isy/FaXh09ek6Y/hA=;
        b=paD0SECVOLGOmUVCj7EJzkVe8JyGb010RdLXEzoteksVmoNQ7pAj8GEKp68Z2ruwqw
         TNfw41T8HeZFffhgpV+A5qBp+Q2Lcuu4DrPDx6P1YFW/fcm16aHmDJIvfiM4auLpC71U
         /YJIzyMbxVZt1qS9m4BfSQ+u8O70N5XpiTyp4fu2j+aGgyG8twVhn7Fs62qxtsw+EBI9
         X2/BNvQDqPYd5VY53+4MnLPFpcM4lIt830tMoH42+AjZYRe7g4oPYqomkUBkXMvLHnRl
         N32Uv9TyEDUFhvDhU7t+HwRaIL45ZTDq7AGhIQccJZSpqiQ5E3vc/GFpqTroR6UKic4k
         5K4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285021; x=1715889821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXOoN3MSopkhNhuWJaS5P2NJD/isy/FaXh09ek6Y/hA=;
        b=sHe63QmXeK3UihYyVcaVYNmYFMe3n2RgPK7mJ3ua1N5pwJpvby8JAiBrx03MNG7Rz3
         r+pvgIjMYIsFiObAhRaV60em9luOLIEIzxIu48FXq1pDaUUTEUOf781tECn4VtA68SAr
         lV/MxsSZJB0BxlEgq25oZvRP3cFyvhZWtEJ04PGBwobCvI1uz5gFQoy73fJfpR4ez3v4
         5qKDcpD7GiK9lBI14o55YasXL5ndh4KwavMaPWg7+jSER11mlBc8vP2NOs2R6pOyTe8t
         RLCVxuPDdsK5o+BGnuUdWeWojq/dNAza0znDJSeHUP6xeFodisEEQQfkwW67knEuU6ZK
         +9Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWvTf7YzCPSbLfl8yVzJRMsnyyzd2Wt/6FyvN5KyFrHV4TknKgCYysd7upHFxkrCQphMHuAkHPepq/uZkWZJNOFnkl7NnlXkZEu+yzU5Zat
X-Gm-Message-State: AOJu0YyzIqSb6lEqc+o64haWKsbGWfhSKpogKV98PKeO4H+h6EWqyosI
	iTndflR8hQHJSVaRAU9lVmUhZWgj9BHKPjPO3W6A1YqZFKNHLSdPqwX6dYgHfVATqhxNIv1yfXc
	8dw==
X-Google-Smtp-Source: AGHT+IHPDy2B7Q+CjwoKpf02gMQPBsDoEpRJNvucXRSlw3SxwotoMHdoDISdyRaYdWERd49mLg9MawqJFz0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90b:190e:b0:2b5:af18:5f98 with SMTP id
 98e67ed59e1d1-2b6cc76d3efmr1225a91.3.1715285021038; Thu, 09 May 2024 13:03:41
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:52 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-61-edliaw@google.com>
Subject: [PATCH v3 60/68] selftests/syscall_user_dispatch: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c | 2 --
 tools/testing/selftests/syscall_user_dispatch/sud_test.c      | 2 --
 2 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
index 073a03702ff5..758fa910e510 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
@@ -4,8 +4,6 @@
  *
  * Benchmark and test syscall user dispatch
  */
-
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index d975a6767329..76e8f3d91537 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -4,8 +4,6 @@
  *
  * Test code for syscall user dispatch
  */
-
-#define _GNU_SOURCE
 #include <sys/prctl.h>
 #include <sys/sysinfo.h>
 #include <sys/syscall.h>
-- 
2.45.0.118.g7fe29c98d7-goog


