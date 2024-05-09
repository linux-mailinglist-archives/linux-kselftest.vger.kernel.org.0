Return-Path: <linux-kselftest+bounces-9831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFDD8C15FA
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691852856F7
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274841292E5;
	Thu,  9 May 2024 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQrTTZ65"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FA21292C4
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284874; cv=none; b=pYBx7zTJhZonrQ4NfRe2pXPob38hGajTP6tt4DQkNnTWe5zwdfuMlk+gS3Bjeg3jpMxQh5J8OA9DspWWRz21B27oHY1N1G0Xzh3MqUj8vXuIZy5wnbHfI6pUGYZDlsZ9CqcsuTXCKF0Acxv2pQBDTPT9KF5Cf1EunQ6V4SFOwMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284874; c=relaxed/simple;
	bh=2/8sIPk27FSvTOSAq/0YADaOvQGisOhNEwKoHVOrwoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lCe82y241ryyAKVIOXhXC0oFcGWAy8HUSI+ywSdiG1oMHUhT8J3iu4x+fNEnhuaeceE8O2x5xw1OIscwQjoqVX8q0c8nf6eXcRWgahfboVcdZSSYzfKai04AzU5GsW1F40coFYIZlV2LgP2WvVclVtMN/ZzowFA+a2m2F2enLc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQrTTZ65; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ee13ebef37so12037225ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284872; x=1715889672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5dDkrD0dZYNeak58b9GqqXeIHUFk691mZ1uMk+mW0Xo=;
        b=bQrTTZ654PKwJYwymZ0RyY5x+qfOA31YaKC6jhQa17s9os3Py1XzVuKFLytTD1kkpH
         B97yslXeGW3wQBFRRryQOWSYu8jkVZq8mP+CXPA7FzgMCMJZrpOIdbEsvtaXpERtpurh
         0agaPOsG+X9ht8rFOgDQXjFWLqRaAPY0LD4erEK01habuaGK2WryZ6zfP3NfV4RpF5ST
         ASZZThuJuLPRV0TQA0upOPa66kZV0AvLMQQ03wNEt1pPxRfU9WziC5hUce8MIsjmMYKy
         HUs7sx0EkR29oQ+rkfDet7tW1d2013kWuQSS/m6Cv3rpAvTrAFSpjxaHj4fNghWwGxvG
         41Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284872; x=1715889672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dDkrD0dZYNeak58b9GqqXeIHUFk691mZ1uMk+mW0Xo=;
        b=Bs64qZFDkCCm420BxQBSb2I+BkNyLmg3MLFIo/S0yLkx8+D1ik6vmD20dihoC0+9WQ
         3ynm1yu/livN91Y/nIoXrsaa4V/t2B1h7RBqiS+RQ5yUl+QQ3Tuan2aWSiMxyrfAa5ch
         wD2sk3DJokeO7qajG1HuWJkI7mM3wWxy8IygjZm2NQ5oqXC/0L1A9f1+cGKIjDXQG2AH
         kGzTYmAoH+F4Y+ofs668FWN+uWf9S5lP2QIINVKOLdpWHRBCTTAAz/NjN2tMHZcKRZSf
         GdnaJpVRqgPBnquscbIP8ncSoeeLwra6qwSFuh6Zrbl3LuDNO4RiVjfD0y1rue2kSwMh
         EtYw==
X-Forwarded-Encrypted: i=1; AJvYcCVxVD8hhmZvfyT3tLBOSVRCafOuC2Tk8rwnIJGigkBAv8cWYfTgLHzYia4CFp2dgAbjILri372cz1+rIQOMBdC7lJ2J/HW5ZAKwCp0cs4VI
X-Gm-Message-State: AOJu0YzFLO4MIcUPJD+tOBNBECOjx56DH5eag0GOYsansIF1Li+CAwjU
	gDUZSbxDxtsuLmbo5D51XtjSHyp/T5BbUfP1b/idc16wV7IS5mo59/q5pJxMcfLB4CIFJB3Sjkh
	3DQ==
X-Google-Smtp-Source: AGHT+IGN4HNDJxeluOcEKuz7md9IZhJw8i2iBFbn3kCKVQqvAuS4nKMSdcwPm/QUnrOgNSxeyjub3Y+yA1A=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:d488:b0:1e4:7bf1:52b with SMTP id
 d9443c01a7336-1ef43d2df8bmr270375ad.7.1715284871880; Thu, 09 May 2024
 13:01:11 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:00 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-9-edliaw@google.com>
Subject: [PATCH v3 08/68] selftests/cachestat: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/cachestat/test_cachestat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index b171fd53b004..c1a6ce7b0912 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <stdbool.h>
 #include <linux/kernel.h>
-- 
2.45.0.118.g7fe29c98d7-goog


