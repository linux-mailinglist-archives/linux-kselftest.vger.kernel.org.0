Return-Path: <linux-kselftest+bounces-10512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8FE8CB77A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3E51F21230
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7FB14A4E9;
	Wed, 22 May 2024 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3OkDTAN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9D214A093
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339642; cv=none; b=hMJcl6TxNZswtv/QiQT60PNSb6CNdaqab5dmlGvlwgaB+o5NfN+MwBecmo2rZGTv1BqCEEYbj+ley4EFwSU8lbRjHzp/Hbhzp2NwsWyeVTpXmWei/HwnrRkZ0CEXH/a72CfVZzw2Vx2jK+hSWe6PTpHBHKIPAdxQdXzAVkciGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339642; c=relaxed/simple;
	bh=tVPDCN3nve/NDstBQKdFHgPixwYMad5HmQi2CbHH6x0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dE+6IjZlpSP3wu/qYgeMuYyYLMBFwI1Z5FmFnyabxLeLXgm6N8oVq8STNVppYppunVGgVcMBNguoOZZxbr+WcipgBZGieajGeiALMfOlnEujfBCrWVrar3q3oXa7Tp5ONI/SUKYVRrSt1SmptUALxTU9zJtetqAK+EDcwRq3zWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3OkDTAN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de0b4063e59so11932934276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339639; x=1716944439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8mMLRxOyMxZ1YbjHsp9Gtp1tVJ7YpTB/MrMb4PdfarM=;
        b=p3OkDTAN7UQb+smfYs+2KwdmtSlxl+TjRvwi9iZe/fq3K2wqne15MS/esn0+TOAKra
         3ngV6715hJHSHdn9I0Y0rQ2Th2fqNly93X6iBAkhx6QWz+CgomqOFZ/w6oQNRO9y9ihN
         3htvKw/jq9CSYoHLJKyjIdjPXQP/HIQzDRpFBB9jmWTEb4sOl8cfWAZqVa82B0RIbsul
         tcV1vg667zhlDYACpNtY4MwzYr0vZH5fUGgmynMZQEwoUZITxYKuHVlv7IaLrvfFnEOo
         dp9ljTSA7Q23VLmjIyXLCI8hkNwGLpLjTpRCcFc32ZWxFoZXOZpVOE0i37Sy33huuyAA
         byAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339639; x=1716944439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8mMLRxOyMxZ1YbjHsp9Gtp1tVJ7YpTB/MrMb4PdfarM=;
        b=SPG9TPxF3RZuG+MOM8J8EySjLek8/Y8UnRKekGO+1gL2fTAff/nFKln3npnx+/pXzz
         zAiz3PIiCJtZfFZ72WHSDPZ8xw+Ymg2hvxXLZc6NsdPqIjJZxvjOP+jEwPBZqnTxBkCP
         Pwp209NfXrwKnBVRnaWVMQhJPHuIXco+zSg/dHm5JX7vO9xW1DdCorko3aGfO2X6qvgY
         G+GxtVlbfK/SMEFGYU7Uwhr0XIJFX/j5tzvFHI4/uc0Skmz7y/E7DGDFOpbVsYQNp4Ai
         CBk1ouAENLyt/U3lTDG5wUEOEUorcrY+k73bgK+9zEw6Dz8vjY0Y3NgpaKurko/ZGUcw
         Wu4g==
X-Forwarded-Encrypted: i=1; AJvYcCXI0e9LfpuvIp7sObUxMIEsqXrXbCwso8K/Yn+ka1/AZNSWmePQyRwkEznsOxYTa/2q488zBqaQLATVugOYNbRwZMoyAW1EFo7mcCw5Cwno
X-Gm-Message-State: AOJu0YzQKnq6WgG7ebGsKurMWwxpUBZM7v3L7tbmwBPx/gWL5vGP8yNz
	uDAiRFBlH7KLGyt4O+tnYflL895eHtDKmzGoJ++L6tESt3Fe6BEf8TZs+ed61IrflHdBch+njLm
	5aQ==
X-Google-Smtp-Source: AGHT+IGJ/NmC5MVevhEcAlb8Vh5DFH7n/e0XuYCFPdZ/GMGUx8MMz7Y1Uyzaqxg9/3KNaRheKGfY5j48R7o=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:b86:0:b0:dcb:e4a2:1ab1 with SMTP id
 3f1490d57ef6-df4e0db5b86mr217160276.11.1716339639505; Tue, 21 May 2024
 18:00:39 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:11 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-26-edliaw@google.com>
Subject: [PATCH v5 25/68] selftests/kcmp: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/kcmp/kcmp_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index d7a8e321bb16..f0e356139e1f 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <signal.h>
-- 
2.45.1.288.g0e0cd299f1-goog


