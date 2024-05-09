Return-Path: <linux-kselftest+bounces-9839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E858C162A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6CD286AE0
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8BB1350E8;
	Thu,  9 May 2024 20:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSSPdzZd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C3A84E18
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284895; cv=none; b=iEkD1J2JcBJCWJ+AZthczVkKnqPQsD5rkReJY3orhRAT6Rw4k4UaVMpgyzOKHDmhL2Ow3cZXWc6WbtY3jZkg3lwYHa+YaBcprIrQvpLSC4YRCtd9gOhyTQ9Ympj+rG1TZSHBx11ijZS7C0aJdeTQdrU1715P5bWcARkVbbdwfZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284895; c=relaxed/simple;
	bh=j9J8Ny80zd5awmyYLYsG3wA6uJqzudyOon3dmH1xqB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a4H1nQHvniVSQ+xD03qMernA3MvBgCC3x+ve1dxbMVPivFtiOWRN8c7Yy7C0CWwB7fn7F/Xr98WdQUdUu4RiPc+S3eTVdgn0EKOhVun7TpaXY3X/+Uv58zCxc8HOHwkNS9odolod1w2RGdJhQZDi2RI461CHIPjd2zSrNm9vsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSSPdzZd; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-61b7d7c292aso1163383a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284893; x=1715889693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vtxr2t6roGVtMPcMM1FHknLFjStzalAWugiF4GXwZ4c=;
        b=rSSPdzZdKV2Gvi6QHoZTRkMXSwT7DXApC/KzU6NTFi5n/qSgq3LfTu/7NJlgfCCh+h
         eb1JN9zwRg1cu6FoswNDAt5Cd5EcRfhdhfxSS02vzTb3ASSIephb/b9S/tVFBrofGtH3
         pAgy/pAPwPcgJTC9KnqiO5/43cPDfyum1R0Nz7KXztwd4ZFiq4KoFVSa7D+PdOaE5/NG
         t0hu5HN1D41xDpiiyW2KBNdy59+imImJsNaQz4reP0S1kA/Merdi99qKprIzZc2KtFve
         x65XTsvzYO9zI20Vho6yk6JeEBTh7i2ZosRETImp1M+cjrY66A/m15Vs9ZJGSSz+8YUp
         thbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284893; x=1715889693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vtxr2t6roGVtMPcMM1FHknLFjStzalAWugiF4GXwZ4c=;
        b=QiK7i6oujM2WT1v1K9Vj/5N/R9KmgUT1Ft+1aQgBpNiWJaKdwiqTsXEOMmA5s3cBMT
         /NCCujF6vJ9fbVULtgXFFZJfAnFD7twfXcxl24mDz0LXjtNfFC35T041grQpHTsg0NTQ
         qEo3oZUBMZux7Ubf8jcluFLsleZ7KEsq9Hc4oD5Zmz3kKToSi8vebjzmTwAyj97EEzvY
         AWq1VLCfoDm8QoXBD3qDUR7QL9SXSiNG3z4ucLvobxLx3nzBbhtMxy/ynYtDrunztpkM
         +e/xYUN8WJJiEOcYB2r2RSdJ9YMx9VEPtPLOVxsTnb8Yv8YZQ35VqGJG+h3i8EKqCx1r
         cuzw==
X-Forwarded-Encrypted: i=1; AJvYcCU7npTmHqGO4iickwY4FZXn0tFnLsiJ/0BmEbKek9v9b+I5WwW3DrI/ARcOeWy6Idzu52gUytzEaXbCmIes+qQWdJBb/CwixXKt4dNY4s4k
X-Gm-Message-State: AOJu0YyAt1M8P9GhpSSkQta3CC9fllJvUazECHkRSQUbpjTSStG9cuGh
	RDI7GHueVjZr3tAA7PaxlC7OwiY8vus7hBeD+sUF5pUFAsu7qfPAyfAQW/MS03Nx0RFReghhEVF
	+9w==
X-Google-Smtp-Source: AGHT+IHIksrHrGn8eq4W8gitB8+Uf1HhXtNiM7HWOCkx8VENlM1U+C2QAulign2PdjmMYVbRpNVkm5nBmSw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:745a:0:b0:635:534f:2090 with SMTP id
 41be03b00d2f7-6373c3b52aamr995a12.2.1715284893020; Thu, 09 May 2024 13:01:33
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:08 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-17-edliaw@google.com>
Subject: [PATCH v3 16/68] selftests/fchmodat2: Drop define _GNU_SOURCE
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
 tools/testing/selftests/fchmodat2/fchmodat2_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/fchmodat2/fchmodat2_test.c b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
index e0319417124d..6b411859c2cd 100644
--- a/tools/testing/selftests/fchmodat2/fchmodat2_test.c
+++ b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-- 
2.45.0.118.g7fe29c98d7-goog


