Return-Path: <linux-kselftest+bounces-9840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ACD8C162F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8ED286F5C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C4F135A53;
	Thu,  9 May 2024 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mjzgm3TO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B0F13541A
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284897; cv=none; b=lSU4FO0dhInyjZhLfcZYRpY4RcMcEnS175XL7djRR7PBqsxyDyGvn42LrZ9KQUaO2BsV8FfoN/8WZ1DMzijV9hz4urPmTl2TvZ+mS3ChKtLCYbU2KWdFTjLech0y4dnIXdvItdcADFDp1+YKaE0rL2U3BEVzYtt5dUtGPbPFci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284897; c=relaxed/simple;
	bh=C3bR+kpQ/pwvE2T/NJgOdT8P13gcI63yQCJySRf7IgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X2QPnSsKVcZzK3BAahCjS8WanpPHJgvThdFOVOyQH9C0jLKVL9+HWIIIApocli8PkwInYorGiMYkNrl3MQkHrPBAa95wVq0sblkqrf6aUZnFfrL2WKfVB7oRtv5k5TOjf/MWkh/rmSvtkZf35Be4rcmD3wp/1lL475RW5ocQ5HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mjzgm3TO; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de59e612376so1750240276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284895; x=1715889695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G57nowh4j3zc6dZ0oWotSbgcBjSXunvHMbYgrgfrS5s=;
        b=Mjzgm3TOINzFdHhbrwACivH+nHRKigNcSDM/W5emIwk5hFZng5JqVxMukE9UJNyIHS
         UIfysBaSrRE+oR3Yrhdb+Pn0gVptaVI9ut75QJcSgH4o28o5wIYQHuB3t0sSQ9BhY4Ws
         bxV3TTZcp2egKigvfuT4jr943PYV4KExGZDOdKuJ0Ni1iKYWszINgwbwTeA+gHyxnIcw
         UROpmOQvoMWPzeiuwQV7aPlOVgDhzM9vvaUGsS4yirS7ITy0gd1JmUvdDFNL6oYQDH2l
         4nFPZ1fX6Bx3WB/w9Joc4HA5toouLN3CGi0yb5dHXRcmd7Sn5ZOn/4wfDtvwG9kiiR05
         MDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284895; x=1715889695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G57nowh4j3zc6dZ0oWotSbgcBjSXunvHMbYgrgfrS5s=;
        b=ZciLuG19rKQ2GVI/X5o27XdO9uySpT0C8q4T7Nt/T7Xq0JcjMnFPjAFqZGAydPGyQ8
         cnua54JpII1oE89uCdwifJE1uvw9EJ64wIstbGjFlHzVQHfa8W1I8V0O66MMR8oI8oFW
         876cjwOEhoVhRrIjgCPhQ9DHRvrCG5TwA0wwbShTKbsdPa3fGnYBKgO4vIUmkzSMbO3u
         FWni5sgolNh7eo1t2frCh/khpjNLiNFf3GVgzBpf4ihNwvVHZUD38gb5f2g51LQrwOV8
         HZhOVv0vB5JdEhDByRdbG/ajK1aT++TO9Bp1RCYuE7PG72GdLb1STg7LejnvwQ+h0Ij3
         0vqA==
X-Forwarded-Encrypted: i=1; AJvYcCW9R4VEzyC58Jkyh6YrU89tJn9c7KapG7p2OFQ8h0t5X3K48zpjn6T1YwJC5r9VTrRAPmepZ+QVB1nQ5JVOc7MNB0Trv1r/38aOo1GSLNyE
X-Gm-Message-State: AOJu0Yw9O/skRHQtQZLHWrKiSDvooylaZfR3UtzAyU0w2YELtEB1gPPU
	fGYWcQZEPSCUVAHvqOEOBWoNntEzJULQEHffTaijKz+eUy/4QGtYGJ5c9HXt+BjqDaI3LhugO5D
	zEw==
X-Google-Smtp-Source: AGHT+IHoch+jGmejTUt/KWjoMuZe6CHm+ujySJjPOe4GFGCIUbS8DO634gokWfmQQFi6/Nyn5DWYlXv4Q1Q=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:c11:b0:dd9:2a64:e98a with SMTP id
 3f1490d57ef6-dee4f30134amr46466276.9.1715284895465; Thu, 09 May 2024 13:01:35
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:09 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-18-edliaw@google.com>
Subject: [PATCH v3 17/68] selftests/filelock: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/filelock/ofdlocks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/filelock/ofdlocks.c b/tools/testing/selftests/filelock/ofdlocks.c
index a55b79810ab2..301c63ddcceb 100644
--- a/tools/testing/selftests/filelock/ofdlocks.c
+++ b/tools/testing/selftests/filelock/ofdlocks.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <assert.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


