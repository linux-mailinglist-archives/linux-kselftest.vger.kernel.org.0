Return-Path: <linux-kselftest+bounces-9837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3448C1620
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DF5285FFD
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80011339AB;
	Thu,  9 May 2024 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxk876M4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4C9133414
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284890; cv=none; b=SbnRES3Bbst4fiFe0BSThTAv36zHeRdKVg/s39fWjvSgaYcGJI2P/esGwm9trDlai3nkcVxIFKU2fWGoeaUBQPoQmNInYobj8m/Qh3j5hIviMug8QK20vLlTm6lCUP1TnSR/KphaonQvScPVUyVrpE2bxH1/16hxjuAXvXCp2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284890; c=relaxed/simple;
	bh=NLfWchjBMnfj0uHgc+lZRCh3/hwhcn1C4pDxOTbEqG8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sJdfCBZezBt5/X0aqrsLZlHYnVLq/8vYdn2tfbpUeTGDCI30v1S2HDAJ3fo4/dbkNQdZcNe4U2Y9Za+5DQHxfDBSJe5bIFyCxuoobkGY1CLT0ielCR9kOMrrWKqmDhbUVvIV1vVZosCUM9a4EcMeZ6DIIPiqh/yM0BFbb+YZvwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nxk876M4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de59e612376so1750035276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284888; x=1715889688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C3wSVWuIBaY3YuCyJCESt9Kj/Ip4PjdWD4+MMXdzxtY=;
        b=nxk876M4d4a7uleVvTf5RtGdGgChoJfyTYNgKVRutTKLrwGPv6yIdH5v87Ml+5M8ZQ
         bxH1k6jxaPdIqFXxmFU8FSl+KF5EuABHYaoWqAyD/qw6/bwddWKQU/lN3K4s+6QK29NR
         Q9x4qbNpF+BsZkcUJKg6lit9J6G5g/FFh7WrxsQUYHjBDwZbifXo6G+2spLGhXWy604e
         AnM08jUI4vNZlxWvdl7pmI0TKQZrQ+uToSYVEX3jCrHrTPjhks3uL+i2N/RT7Z9dkXLR
         Ij8OY+vHiiaw7Eg8uZ+o6miOgyavCX7k7poZhiTFZcZHWKpgY1GOFYA2OC6crFzE3GCl
         p+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284888; x=1715889688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3wSVWuIBaY3YuCyJCESt9Kj/Ip4PjdWD4+MMXdzxtY=;
        b=ABeh8XA5tNXjimzmdkbIDjoEXq4SSDeFocQsjD492vrFxjGxsJq6hJh0gb2ui7ONzS
         jQHuyOy49+RpWMG1mmTBYNDfo3SpVdQhCnC7d9DQG/BnXOSmauQGoP9Z6TOFHKDdF7qX
         RF6r2b1tLxciN6f2st+Ih8Fp0eTf6XzuByVxVCO9uNjEKCwcLseOjEkIepwsa5qd6Cid
         xqasydxYHcEfUpAebdCNQTQunK5+QwnbfFzfVNCnoWbPFraMyidQA4EqK3wS3vtgfsYO
         XkkELBNX16an/NpqvDwkAomkmiBIKWMUzJMnet8lW/sTjpbhEbZD4nD4LqsdydYQHPKn
         J3/g==
X-Forwarded-Encrypted: i=1; AJvYcCXodRM1oM52JCPghxLIfOPkrxjXr5Xr+2Qw5dpKgqBQA8bmCTlCLO/7SC/IQmGILKrNz74YmRLQ3t4kP+t6v2qHkJW8+1AfnPpqaOpDYXwa
X-Gm-Message-State: AOJu0Yx7xAPrgEaq2Hz0XtEkHQf/2g8Thq+QZ5qrYM+L/Y48VKM4KZGD
	LYxx1/pfvas1/JAbDDl9OxkRlvhEIpHEEblPUFfRHU2ZCPZIKTbdDdSLjSyEAa8DnbGvua4l2mN
	jlQ==
X-Google-Smtp-Source: AGHT+IG3vixfOgsVRvWw8ba1GSc0WVoejlZw5UUOvsn+v5cimkQ1a21N59uv9KSFtZ774wjBAuCjwsx2Iew=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:d3c7:0:b0:de5:c2b:389b with SMTP id
 3f1490d57ef6-dee4f1924eamr46589276.5.1715284888528; Thu, 09 May 2024 13:01:28
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:06 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-15-edliaw@google.com>
Subject: [PATCH v3 14/68] selftests/drivers: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
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
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index c812080e304e..7c8dbab8ac44 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


