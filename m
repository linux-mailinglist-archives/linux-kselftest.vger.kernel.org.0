Return-Path: <linux-kselftest+bounces-9949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AFA8C1B0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590411C208E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C070B137C35;
	Fri, 10 May 2024 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t368pgfm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39657137750
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299856; cv=none; b=KPUOq30yoiPlypY86aG0DXON+d+7c/6g0QWQ3ObyiMTwneHW6U/7xoZ35zMoy/0LB2PtCrwx0e1hU9PrNPbNrACJDnMLhPDeQAMi6bSw7+7ixWMvY8zPMcdS/QnVo5e9q6wHxQip3Nm6PGzfh0r4sb6Sbj5EqajUY29Wq+JxCO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299856; c=relaxed/simple;
	bh=ZxYHMzsoZPBhe6wVFpFAsxN6ce0FvlmZwe4nciTKWPA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PpvoXGNZvkhqEy1DwLQxBswIg4A2W124EB0joCofI4AVOWuEHqp4v0GxKZpRUI2tCctlwHjxVJcRTPwWN4amgRVoOjSqMI/mkWFHoFi0Jxr8dSA08EOETiqQbz3gYgNGRLAMmsHiwtAdWN0R7XV6Cozhyx66AUkekicpiT0O1xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t368pgfm; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b58c1d014bso1242722a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299855; x=1715904655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6lzqQHkZ7UbUp5/JYGP0dVw4+7EC0TjPo8a/HimOnA=;
        b=t368pgfmKjCxpaMmRHP4my+9zi1D+prd7r4/+33K64PptxivpePZZ/l4BUC7TtxpBw
         ot2LoGcxng80p/+jH7FWRfziW1BrmmeGQmdcPihgBV9Mm3nLqDgJitytxx8NbcXL92IP
         EyAbgZQ6QZSPcHg/Gg8/IISqPGupyAas1YOxodalU2/GQdGh0xo7KlupCpv/LxneCbpe
         8pw9tYlSQrtGk/DAr0WLeEWDZ0d31qjlq7NMg6AqXmklBbCgO8Z0banoFqW8xtdRJsMV
         lS7/2vEYpBtS/dqXu8BQhY9T3ZIgstTl9meyzu9YhldlgtRsx/kvr4F7iCmS2wXr9wRi
         eEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299855; x=1715904655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6lzqQHkZ7UbUp5/JYGP0dVw4+7EC0TjPo8a/HimOnA=;
        b=vMrkzLv87FKi+WGgLp54u6wefyLaRwNQ4ltYnITwdYezXVfnn3qK5Yen89StQ2hsFj
         YvPPPxvB5/xxLO8DLj8599cxvMVUKV6bi1tJYJ+fLv5SM0rqzpckl7bQEwtzVM0tOFE6
         g88N4vJOcSFf1pNuW47LD2kkJ2RrjKBABA8TCJiQhpifN+gvIAmg5JH565U3F0KkYTGB
         cJW26YoYNeagDEKizNsyR1og2UukDDJgYwM5JdtLY4QWzOA8KNn+19nrfk9j8tQKhCse
         Fw0vB6Roou/D2AUs43Ytx0ujRCFIA2emIZRjxWbkgpOajIj7rvzCpNSHu8zpzVsBmL0k
         egaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo3Iy9CNqlt7UqtImmgcuR61dBjpZLZQnErVtVub8qRaEBP0ufrljlDjFSXo463gvFKCYiaR6F4xWu4cVoX/0ZKrVwYsqNCMi2/fcuwpWy
X-Gm-Message-State: AOJu0YyKvy+xWgCvTFhdMFHOOzdRI8eY5vb0v0u2AEEisUoUCVJDb14w
	AXALPgIzDyducX7yS99Ym3jZq2Lq0EXNoAc8DL7NTRZ2ZdBdvnoYYcFrNfGDX2FZmJ3qwNSKI11
	knA==
X-Google-Smtp-Source: AGHT+IGokXaNqHaQn0wyeCEFxco9kASIMpRDbXzSiKoqfVYj6R76IzJ3Q+GLkCCJqqtGWT7c22jE7sXj/cQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90b:4f89:b0:2b3:5eb5:6a76 with SMTP id
 98e67ed59e1d1-2b6cc450277mr3687a91.3.1715299854746; Thu, 09 May 2024 17:10:54
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:55 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-39-edliaw@google.com>
Subject: [PATCH v4 38/66] selftests/nsfs: Drop define _GNU_SOURCE
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
 tools/testing/selftests/nsfs/owner.c | 1 -
 tools/testing/selftests/nsfs/pidns.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/nsfs/owner.c b/tools/testing/selftests/nsfs/owner.c
index 96a976c74550..975834ef42aa 100644
--- a/tools/testing/selftests/nsfs/owner.c
+++ b/tools/testing/selftests/nsfs/owner.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <unistd.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/nsfs/pidns.c b/tools/testing/selftests/nsfs/pidns.c
index e3c772c6a7c7..9136fcaf3f40 100644
--- a/tools/testing/selftests/nsfs/pidns.c
+++ b/tools/testing/selftests/nsfs/pidns.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <unistd.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


