Return-Path: <linux-kselftest+bounces-9970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B908C1B7A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227E61C221E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACF413EFE0;
	Fri, 10 May 2024 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9oz5zaY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D972D13E414
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299916; cv=none; b=F8SgTTY7JEVtz7QM61beYr/ulY3a3zzqep2Fii2zF/Fg6vOfe1GrSqPaEeVxR1Ma7FNdtYAWok48fxkMi3W56ubgJ3P2wU+oIvQ0p7s3X/M/DSoZglbLa/OQZgvdU/8NRrwe82o1oHpo09bTFyDrdVm1T8we7qctJQl/FNWuCTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299916; c=relaxed/simple;
	bh=rMNorx6Mlr6OQN4TSpHpbSA76EDTMc0K90CNZBa5pHc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lErSymGPIGZkDJyfOiScQ+qGu0u4wZkjEGsBllQWAB44t48qFzefu9SUmNqp6PQeF/t+Bi3EbJvq4HLgBn/QccptiQ7i/F3FPstgDMmLjIee2tP+gvGlbDj7Vq1RiwSxvqGWdPTFpFhlDsCjWT5lwwvpUq/mOqN1MlxYSJ1NWIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R9oz5zaY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b33fb417f3so1278311a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299913; x=1715904713; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jvPt4Tl0MuZvjLcVUnKyQWY6SnsFvSQcdBrwWAVVIiI=;
        b=R9oz5zaYIRG7wZFD0dyE/lqJWplTqmAyTtF2seDIAjqkgZ6TABy+n5/DkEqbYZKczp
         7Ko9b04Tcu54dOC+gVUl2p8P+K5O3lwzvU+Ri34m7BdFuaUjhBbKLr7jtoTDxwmUh/O+
         EKu/yP9/EekzcQGSgIkk6tRXdvUDnAwyLVR9H7N50UbXV0OoJY+l2XMVHAU2NCoKXs9D
         lPd06KRUOd0InkkXlKozbh9khFYdrLAC8neOou6d3YSVD/YFJEP/EaARjRrQ30IUMA+b
         r/DIgoxZfw4eukTlWz+m/GRvrMWGAWWkaL/EAPF8wF9YvN9/EP17yMzl4b28RC7WgLt5
         faTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299913; x=1715904713;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvPt4Tl0MuZvjLcVUnKyQWY6SnsFvSQcdBrwWAVVIiI=;
        b=l7ssw6WMyzfMEk6lYtjkhRJd7fI3WDCa4sHmhIYQVgbBFt396YLY9yiyk2aRAPg8zl
         sCu6Q2/YFLIr//nm2vQXiDvXh0C9Hs/xnbh+l3y6WtkzN9p/u7+XiQ3jmw0Wz03MEZUu
         SRvHbb8E6t+G0+InPZ83dshyrxLL5xzoBNYA8zjxDwwrHlJGzDA9RgcIne01q0PZz8sa
         /xNB9yrKGftoq7sOLhpXtOLntOTWWSRrLY4sh5UCYjWMP3NyQCwYoqeqfebDCb96M1dU
         fzUEI/sZlOTIQ5Uj3RDRzlhWcYjd1y6VpwLc8baaeM7fS7MlaJ/XLC7NxiR6wgGNqTRN
         gypA==
X-Forwarded-Encrypted: i=1; AJvYcCWzx5UQL9NgeHzmEN/hsW4RnU0Cf/ZvJ1ES3U1hgeRv/0npEpOBAvO7ufejNNQGFWM41iTSA7YiQnY9P6+6amY96cBk+EKIfOw3+lNGXsxI
X-Gm-Message-State: AOJu0Yy1Ri2HjEI+mc6QZ6Jn7TVlLLkBm7YSHGIDr3ZFPQcVvkFn36IP
	vupTEF0kEfKR5SpyTilinqKH+zJCmQ8KGKGqC+FB2XJAtQzOSWOa3Dkp/bH0D448guHBARXUBMy
	dgg==
X-Google-Smtp-Source: AGHT+IGZ2aOBDdexFnrNtN3LwFkzh8EwXSY2R5YkN1xQaKaoqKI0IvKyYvyqXpWGkRSifj5tD5YyyT57Tro=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:e00d:b0:2b4:346f:9a75 with SMTP id
 98e67ed59e1d1-2b6cceb662fmr2747a91.6.1715299913222; Thu, 09 May 2024 17:11:53
 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:16 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-60-edliaw@google.com>
Subject: [PATCH v4 59/66] selftests/thermal: Drop define _GNU_SOURCE
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
 .../selftests/thermal/intel/power_floor/power_floor_test.c     | 3 ---
 .../selftests/thermal/intel/workload_hint/workload_hint_test.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
index 0326b39a11b9..ce98ab045ae9 100644
--- a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
+++ b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
index 217c3a641c53..5153d42754d6 100644
--- a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
+++ b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
-- 
2.45.0.118.g7fe29c98d7-goog


