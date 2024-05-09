Return-Path: <linux-kselftest+bounces-9866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA75D8C16BC
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9318F28C9FC
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5585613E412;
	Thu,  9 May 2024 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eRedCCVQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC0813E057
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284976; cv=none; b=JZfeAg6ieu5AEwemN6kVfmI9oF1jxksLhRMWlcrdvneRD36YxuUEkVMeF76FIWj4L+2IH7LrYwpD08iTSOJuaEfujxN/2XChBntOAZD1QU+eaaU8o1msnPNxyL6hOo2IZDkZCIFTsSGOMF8CDu6nUKNRmTvhzySyHxA28JTsoCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284976; c=relaxed/simple;
	bh=UfAo//kQqUK9+HsAvQuH76Z/Ww9en9hZzqfCF87sxjE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JcN9rmH415JNZuQVVZXNqLILTpi9a0f8uZ6LoiiqqsUubFHzBLC1d6Ishjw10vFoFYX4BBPBdlO5LT4x0w3cXLm7bqj1Lw9oZSxUqt6trZm8OhX0YBeICg78s8uyxeib6c9UYDGtF5J/stpckx5fictSNv4vWnEb8agMjgeanWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eRedCCVQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de51daf900cso2046054276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284973; x=1715889773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/4YtNx2ds/btNjRumtpOC1sPQ1T7EDCPNUgbL6GhZJk=;
        b=eRedCCVQPZl1KOUbxZ95OUl70EF1rX06XqFV8lQqMTTlVOyTqj51cEb5KvBzZ3Hzb1
         hthxAJGRE304FYwQXUk7ovvTnVA/eA5h/tRLekQz2Fr72FIhiNyESeaj7wFvq6gfJvSP
         DNjSbLAZwXKpiOA8c2aFE76BV+Q3cXr8m3u/bdJgAzRuWL61XQ1fc480Ka8QFzpqqsiz
         tH608v2Kl0sUc6wMlMKtgUmB5QBJqFFYKw6a70eod3X0sM0hRxG0l5dEz6QdjZKlmwDb
         zFl9OFRRp/JU5pPcNgdiZ8OjYwA83eHfvWGZykIAumFzvVLOMtledaL7juum/ABVdD+3
         3GGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284973; x=1715889773;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/4YtNx2ds/btNjRumtpOC1sPQ1T7EDCPNUgbL6GhZJk=;
        b=O4C0R4hrS4sotyIEkwwLShf+aorQvxy9VuQ6jur+j/R6+0ppcTqQwsdlEquC/xVhmt
         0pdcW2kozXfQtH4CUF5zlup/5YKgq6Zz9MeGIf1wh+pux1h5T2hTGvxbdrwUj1LkWxKI
         YYw+PvnEko7aye5oJVjymPrnG7DMYwloOn4I1yQBM68VoGcodI7wtjS+kb2yg9On7X4j
         gHUfaDjxDrthwW0EYEbZcUyG2nH3ri4qkq0JSzC8YAL5z2RXa+vRDnHP64ROeA/B5bzo
         PrUNraCoeOlXbjA0O2QwZDdVsZYcc78vEtSpP20m2CraEHklZ6F8CkBjwQFWhRNyjDDw
         z+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRZWcS80xZMQqVFhjgciATZ6mpmqo+EZ5BSQXo+NOJpntcUgPdR4VvhE5GEemHT4Ee8i7MOZqmPGmo1kLcCDNThmVAL4sqJCxXBl2vV2Yc
X-Gm-Message-State: AOJu0YwfTXaFQ1qBGx1XQNqvXmhnVsv0/HqK4MQoVhI0dpJ1Jrk69iPL
	v3lQro3E3n5Wre8T2bghRAu5Cx0dpx3xAz+bZ9Lr5lBNS26SRjQq6xwhS30Y/41xgDO17DF1O8e
	nnw==
X-Google-Smtp-Source: AGHT+IEhjwAEZ9srmk6nd+nHtbruz7CGwS3heWa3ViPqupsQl0bknuytB51bhWsROyhFvq739JBd1odb8+0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:149:b0:de5:5225:c3a4 with SMTP id
 3f1490d57ef6-dee4f304cb7mr138986276.7.1715284973168; Thu, 09 May 2024
 13:02:53 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:35 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-44-edliaw@google.com>
Subject: [PATCH v3 43/68] selftests/pid_namespace: Drop define _GNU_SOURCE
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
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/pid_namespace/regression_enomem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/pid_namespace/regression_enomem.c b/tools/testing/selftests/pid_namespace/regression_enomem.c
index 7d84097ad45c..54dc8f16d92a 100644
--- a/tools/testing/selftests/pid_namespace/regression_enomem.c
+++ b/tools/testing/selftests/pid_namespace/regression_enomem.c
@@ -1,4 +1,3 @@
-#define _GNU_SOURCE
 #include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
-- 
2.45.0.118.g7fe29c98d7-goog


