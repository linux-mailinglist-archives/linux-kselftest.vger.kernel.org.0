Return-Path: <linux-kselftest+bounces-9890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4628C1734
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B2A2818AC
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A81E14A4DE;
	Thu,  9 May 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zlKbabrt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DF3149E12
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285041; cv=none; b=IDrZOtbpGDME6zlWmxdMB8urHhNFExH0czz332RXeFg4U1B0izCh787fyYD5nF0nH0wB1z19XGPMHl8tdwqhvqAyZXM8eR+glL6k3msAtK1apKNnKtfcmWaLlsMEUyr49Y8mZKl56/A8vyYccmQnsQWNb68YsYPGQxYggtVl5IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285041; c=relaxed/simple;
	bh=hpXwRj8PmsHLP9pVcjGSKT04NzDcN++/f0/62HSOBzI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K1JvZI00Uf80uR+4Hxh9T94eWVRcwTYLGRyghv6jdYuE1snxgRAEBfT7NfndApbgS5+2rK9mryRGtD9t3/aM42QNLNp8tYQFHJ2upt7TQjUMasERK8R4iPsyaYK3VeZbqdINyUsHXBjB3aRrHnKHyOzCuNZQkK9Wdy2uVOVpsK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zlKbabrt; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ef9edf9910so1235032b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285039; x=1715889839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QQBoWhnW3eSJL5OjfxzO0lzEIXAyAkfzlFMU1Ex8yOg=;
        b=zlKbabrtJoqeIp8fggTL2YfHq9Ra2BMTSv6I2WhJCc6SSIddYUjs9/BLjdpqOK9GYA
         fnpqkT+m25PnuTDgD0a+c/T50aueGu8/vqRXrvYB3/J+6QdymfNGltWdrNdlSu02Piio
         K9MY4kemFuKHeNu0LfxGtxJsLu90AFjPOqzGC8+CZ0Qv+vh0FbAdKR9ePRDe01OcvY0c
         u+aeuwJX18UOj+to649hnZ4PmohTHNI0qS53yNkq07uABtXFLTbLcxbHci2qtGO6jw5S
         p6izLbE6UUMeiXqUi68xCFWuCoqwVt5dyEXrh+iM7hgiMKY1AhlDxZP5JudAvvUKQrKy
         hE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285039; x=1715889839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQBoWhnW3eSJL5OjfxzO0lzEIXAyAkfzlFMU1Ex8yOg=;
        b=A2tc8dft7YHdgLFMImk+pwEaDCL/GMnwQrEFmEXQ6rWFri+1Hx7lzMSFPahd+2LtEv
         PEmKuXX4sVzriqWBWIRzyWTLdAPviLYDNEL6p1U8CJ7MPK4Bkt+xdTLWdjI9CooSoRuX
         Nchaj2BFyRY1mhSdIsZjZLtjOs05UxzVgWAK/QG1wIioOFFKWxnUjrblcfn9z0elRzCd
         /QCIzHaRhrZO9mho1xlCO3hqvtJB6fKAp6wSsahwMbLgzBrqwGpFvnonOrUG4MMLamGF
         5e1SnALVDcRGnUxlsWh8p6JjZrZ8ZS9Pq3sv1U/MMGanVJz0T9ICpy/G6Frv9zP2RdEt
         SEcw==
X-Forwarded-Encrypted: i=1; AJvYcCW9DcX7N+jmPVH9M7SiG/prLnHPMcarRuo7d+7QdcIscdvSx3pqN+PWdnGJ4/dQlVy+/bpbo6gnGhQOFHP1az6BO5zeh7ot2DB8nHcg5+0E
X-Gm-Message-State: AOJu0YzkafWo71LdSxrMTqP0pwXSSHfBBx+s947/7O3B0pGUitY1x41P
	uJ0p7F3I8ZDnggK54ArlKglR2pRz29hTXNA5l4BWiZXD8W0qusr8xNurW1vbFQlzv1QURi1+9OM
	oHw==
X-Google-Smtp-Source: AGHT+IHMhChQUGH3o/y/Xjd523PA1kFSsocfDFneSTYQRZIsze/kEjlVNH96NGo8Y5vnkXmCBqnyZyOLRsw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:a91:b0:6f4:d079:bb24 with SMTP id
 d2e1a72fcca58-6f4e0296acamr10866b3a.1.1715285039543; Thu, 09 May 2024
 13:03:59 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:59 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-68-edliaw@google.com>
Subject: [PATCH v3 67/68] selftests/wireguard: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/wireguard/qemu/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/wireguard/qemu/init.c b/tools/testing/selftests/wireguard/qemu/init.c
index 3e49924dd77e..08113f3c6189 100644
--- a/tools/testing/selftests/wireguard/qemu/init.c
+++ b/tools/testing/selftests/wireguard/qemu/init.c
@@ -2,8 +2,6 @@
 /*
  * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
-
-#define _GNU_SOURCE
 #include <unistd.h>
 #include <errno.h>
 #include <string.h>
-- 
2.45.0.118.g7fe29c98d7-goog


