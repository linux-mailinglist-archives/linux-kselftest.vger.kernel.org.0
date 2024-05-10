Return-Path: <linux-kselftest+bounces-9917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FC98C1A62
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5A65B216E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DBF37169;
	Fri, 10 May 2024 00:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YGhA3OJ+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A37346BA
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299767; cv=none; b=rYxSu7p8sVsZ9kY2BkcKIkoQg8RPOqFAdxN+CO28hII1ZQT2Ut2bjk5DQkpbouUdKzYDVSsWqqEYo968Bjy5lDCPr60pfMC2XtoAb2YzkmTdriBHoKcbx9l2UO6j48Obhew+QX+B8sHBnvc51DeeSB9DqXIURVes5+zxe7Bw7Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299767; c=relaxed/simple;
	bh=GBCHtpCNZgGcVzsMNRMUoXk8ZNVoZVPhM2UaZwCtJ0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GqcYh9CnpzCJU9WKGbLDzYw3m3l2+IVkMsFqWC4Xkr9IpvUnjpkLtg8a6g428rbKvml6Kt8Nkp5LZUKje3/grtXLDvgV/YBzC1EU/z9Brv/AC3cy51B4kLskLlLhPvU8RyMe/p/WJfweMJ1KQnqmeSBWHjt5dWnCJWEkFgnbOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YGhA3OJ+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de54ccab44aso2633178276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299765; x=1715904565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=320iwINBDe+YZC8kG822TZZWXwM0JV4KQ67hb3vAZyo=;
        b=YGhA3OJ+f1k/Hy3oTUJ+h+wqoX8rf63C7mTjhTi+W917EBcIi2lzxHQvKyPK4nFN+X
         RbFix2c4omSxLF/4WEQouTEfV9McpUedMQiGTF4Cp+38BUbpQjUK4A30EjVpfgHAxvaM
         eZIoK9P+Hq+mbRbB4ZwOaGhbc/cHcWFr+ZS+rHzniGOCff2wLA2QZpjaIVvI/RMnr29M
         OHboW9AdZfQL7ult0VQdr2q3wF/fHl8T6gVRCwY/UPNbDG6oswT/9D6LEc9ju77SeWy8
         LOmThA7iWDAK6DGDd/+slFJ7xYc5zsbRAVYefo2sxHvlKvCXpjrtNpJvWF41BJ5Tloan
         DCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299765; x=1715904565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=320iwINBDe+YZC8kG822TZZWXwM0JV4KQ67hb3vAZyo=;
        b=rln4xhDjQdagkW/6lmSvZObcaUUyZ1gQZZ5rfed4O3UsjQX7XOnUN7wEAhkxTfQizt
         IwyqIpIcfJTi7nwuLgAs5TTQ0+qdfIfV0CGTEgGw+t6r+XjzfWNq/z5oFG59/ubIeJOM
         0dr01/mLQo4WiJU9d6boRsplGXq/iyty1zmernh5AaG8VTw3McSR2oZnvE2Qp9nuNV97
         I9Ujw5CfOBiDeyjRgFfxJ14hec1sqAng/etDuHCCAiQG3umokbLafb+TxVhiGwbcaABM
         qwLHVHTR+Es67MmNUIjlBc/qQs2UgBPboeseiiGufLLS9UW5WSVu4A9ht8eeWIaRsePS
         p/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzYXOXESEfCUvmPdSoD6zropzKwgJl7h03TI8RT8dWXqdsSyNFePAJf8axUyfCOPAKzYqmlJ+a9kfWfFO3S3IO/btthnPWCaEaH4e2NnXf
X-Gm-Message-State: AOJu0Ywl62AhrY/w//47XPUysWn6ff1GGWk0tUccaFXxS0XBbCUI118z
	XbIITgukBpjLkeIfKfB1lQBt9TGUT2jvpTJ8IpuEAGl3EWXZk0MG8K+gDq6mBiGP87mklY/MnWV
	c3w==
X-Google-Smtp-Source: AGHT+IHhdRVjLPgT9pC+WY2EF++s/VK65ryEcaU+G/FrBzkZfRWKSkfQV4/cEEpi+Hrs8H/1X2Pp5ybXSbw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:20c7:b0:dda:c59c:3953 with SMTP id
 3f1490d57ef6-dee4ef7b783mr307444276.0.1715299765371; Thu, 09 May 2024
 17:09:25 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:23 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-7-edliaw@google.com>
Subject: [PATCH v4 06/66] selftests/cachestat: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

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


