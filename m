Return-Path: <linux-kselftest+bounces-9884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91E58C1716
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796EA1F2195C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF49146A95;
	Thu,  9 May 2024 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCn3Vs9E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5C01465BB
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285025; cv=none; b=GsWTJsiztAWfDSiS42Veys4qN0aWLrmKtP/3U1FZWTXvKIEcVWY4pljsPDJqOMObofo6019+A2fGJ+Rkc6q+7kXdvbsRltDf/dHDDEGZgxYPzJQAvgmSbGvqauxzPgAUv9oCnVF7sm+Q2VR6k+iWch4DQDM5TCsWLpO35Kg+OJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285025; c=relaxed/simple;
	bh=8WAV55RFZFHdUQBb7CMCCAzXoHxBizUl8h5SsYxKlRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=REGFgh//qvIcXl2l3PVeVcXENyL3MYOKj3g+TppSOMJxwzowSL6XmpZ1PJudQV5HONKdLyq1CVN1eaY50JwWT42osBcfNK1NOr/VfvEnnfSrcbdKh3AYgR9TgXWt7DdRDj7UioLifNh3WcV4qMF4vuUwDgQnzqtH3DhBL6tAX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eCn3Vs9E; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f446a1ec59so1127149b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285023; x=1715889823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cBjkXNzK2r5lGJvUOfu3vMHyc5JfgO83lVLsEeYmChI=;
        b=eCn3Vs9EcF7qvCD6FSaFA6vYWDD0VBTaZwUwDp4AbYHaVILh5icLp4DbXI7T/AZz46
         xnDD568mGFamBHoaVFC3EeKI9cO4NT/87bheVeOHpIcIGSjBuaLzfh7k/WTjLMKQSZ78
         t2a6Lm7rimFVXQ1eaGbdgFCJz681UbPPbwkhEuqWght3+sSaT1oB33gHfvGYKm4rqMvP
         cjUNN0xe0NfcgWo2cuDp6TcZ2A3J1pziFXnqoQ0T6jfeQp9HTlsb3db7tdj4ZrrXamnl
         8dk2nPF0RVdYzPHT5eWmENBEaHvJ7H529tShmyDJB8gljo6orFc4ga6PUt4j4HpF1h67
         nZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285023; x=1715889823;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBjkXNzK2r5lGJvUOfu3vMHyc5JfgO83lVLsEeYmChI=;
        b=ewuMe3yswfB7AP7PuWqfRQM9N7wAo57vr489jVm4oKTDw99KcGWR8wBE3upvgrfCdH
         H/MqMP3ZdtUQBbGLDm2+fjjLsNblzJZXK53Odw1yvIx1/P6/LyaeZya2GV5K7YIeu8SL
         GE4ktOlcwYmfcmX8IkkJwEIY83XRgh5dNdPtlcOI+VM0DHVG8hkKUDckmfnnYwEYBL7P
         PT2K8ETSxWUuK7ykkrehktjUdxtgpIMd9LpNBT83OVXqbXRThbTowjrt++N3hXYciSrt
         2ab4KeB6tmQEfp6f6fBAhGQC+tPgDRSFimOb6CnLzxPTAabSt5aGH5+Anh/4EkUqL+lB
         TxvA==
X-Forwarded-Encrypted: i=1; AJvYcCVsH8xtfDxKbFkQZEAG9oqOkVMzB2adhLRq4s2waO4fovpBke38jNuzcuIYwODBVwcO0OZSrBzSBJWkHhY/jOyObcRafvQ/OFkA53BZeHnu
X-Gm-Message-State: AOJu0YwUQZsJQJnSgsNQJWQwQSq5ODUm0lA1YU9nLvKvbeXFKwSBTRfS
	5tOrL7IRjyV+pRsJZ+4VyOrAYPtmP4DmQnXs1fkRXlbRpr66srsz82IOSC31/neqTLIxtvUXIrR
	Pfg==
X-Google-Smtp-Source: AGHT+IFZHqmGcMmIyQ8Ew9M5MvOLSCaa/rYeCHYejX3W6r2kpgzCJiC7K7sEuCco6nJD6eLOUsvfi+zaNnE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:a17:b0:6ec:ceb4:d9e2 with SMTP id
 d2e1a72fcca58-6f4e01b9126mr37287b3a.0.1715285023604; Thu, 09 May 2024
 13:03:43 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:53 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-62-edliaw@google.com>
Subject: [PATCH v3 61/68] selftests/thermal: Drop define _GNU_SOURCE
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


