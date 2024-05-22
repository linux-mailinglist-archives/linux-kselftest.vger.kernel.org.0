Return-Path: <linux-kselftest+bounces-10517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A4A8CB794
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5AA128196A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64DB14D2A0;
	Wed, 22 May 2024 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phSMDsef"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1BB14BFA2
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339656; cv=none; b=VJoXfxwzfuwne1dkWVA6W5mhNJpYH0W6wZM8jzm0L6wdgl08o7+A+N0P6BXQ7JQjF1C0UfF+HuuPSRJ0+g3Q/AbkZxdFTvMDWzymuyATpFqYpWRCZbxk3vP3h9hVlgFlyaa7H3CsHX234S0SVXXOQXByLlc2qnHFLbHg1j+gE0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339656; c=relaxed/simple;
	bh=GLz+NiSWIjggktWvXvCcxV3SQNfJgybR45MEAL0/SM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OQ//P/f0Cwo4B+A3h6GkhpEKAMzcc9lydBy9QY2uVEXGApo6q+GnOOO2F9kUEf68woWTSLXT22tUy1FR5J1/Aqym17L+8O1eCO0yI0GS1Xi+rPoYarwEkdyRbHdhx0MdCM76f4PO0hyx9AQTenO5/zQMjKF1QhlEQEdE2qGWrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=phSMDsef; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b265d41949so12213221a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339653; x=1716944453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oVf/OpY3d2Q/Mya51rq/+c3LTiKmdxaF1eraxGBViHY=;
        b=phSMDsefeA2sbkUfbGrtDhUbKgOqAmIJEDa6t6Ot3Sc9JJD2auaf2auLgw/fC7ghQ+
         d+wOIzPtrNJgIWdungvxRRm2x/vhlPlnA+3ka/FmZboN+kmZJQbwa5gw/TQwTzt01Rsc
         2B3zMcEIG9xSaUeeMj4Tm4ULLEnGlGGl7+1W7wicfbFGpb2U+hoM1SZDY3Ay9hWGeqbx
         2hd6iHS+UYSvWDw1dpm8zH+J7MPCUouQrMjZXHuGRf5RkMjcWaZpAQRi/rUcLo06NHr8
         iXqRJ5ONHnGdZcS/u5s0VgDqnjqBZFtZIL4dBAYZP2jlTRqaeCpe+lTUuUB0yCgFwNA1
         L5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339653; x=1716944453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVf/OpY3d2Q/Mya51rq/+c3LTiKmdxaF1eraxGBViHY=;
        b=dlyE7CCsmMC+UxSg7VqXg4wCexk2DjkJslv6ZJxFHBUHEWm8IaXmF6nFGySbtlTBd0
         /wZmjRo2JKRqV78fHd8w0uRLeupKo22JDGtFQDYKDfClDUtWHtZGp+YTUe6gdZpsfvZY
         8rxBt+qBc75cHkLDAq7CSzB8wcJt5elJBKhafETmXS5jtH5mB3d9PprQ/N/iTdk6iNvY
         qggrdQF0n/frhVI6KWI1es2aR49tKsgZZTQXJIsTPnjFR+gAYK89NJC5WA55/UymsapV
         yeRSJLIAfYp5NYSl2vhGmxOGM57k1j7GuWAluyLmFTEjExgKxSMtFuSJw9Se47Sorhst
         Y08w==
X-Forwarded-Encrypted: i=1; AJvYcCXS9LtXRRn4vT7s7O/2M710z1YURvtbNcwgsblMB11UEK5VAi7T9yD2/ZEDGYFT/tvnfcyEUtKHSy3mw0uwhNFr5+ePueREDL8xAnDcPKCB
X-Gm-Message-State: AOJu0Yz4j/QzIWG6I4kM+xJNfqQ8CKPtbzqEQ1GeANSTW/yMzJQcSUsz
	rKOOt2yrgdzHn6jFKZgh0qgB79LNIVpyfDtXlYffJXAWeoJHKgUggDOe9r7ZxvHty5ljyBZpSix
	3tg==
X-Google-Smtp-Source: AGHT+IERmvjUACU1dGq+usdhCn15n3wBhF0S7qzqPTxOiEhahwny+LRi4B/1JnjPnSFaHmLZJYt2JZRastY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90b:1195:b0:2ac:992c:4c71 with SMTP id
 98e67ed59e1d1-2bd9f5d9a10mr1843a91.9.1716339653260; Tue, 21 May 2024 18:00:53
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:16 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-31-edliaw@google.com>
Subject: [PATCH v5 30/68] selftests/mincore: Drop define _GNU_SOURCE
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
 tools/testing/selftests/mincore/mincore_selftest.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index e949a43a6145..e12398366523 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -4,9 +4,6 @@
  *
  * Copyright (C) 2020 Collabora, Ltd.
  */
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
-- 
2.45.1.288.g0e0cd299f1-goog


