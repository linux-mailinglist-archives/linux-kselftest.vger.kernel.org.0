Return-Path: <linux-kselftest+bounces-44008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6A8C07430
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C47E1C284A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6499525D546;
	Fri, 24 Oct 2025 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoAtx5Wq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74771E9B37
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322763; cv=none; b=IMd5H4pYNxPpQ4pHMZMt1C7oUD4NLEjpUpfDw9/W2RwHBItpHkWFsTE8r9LAlANNZm/pBc1de4PnQ3YnfoKn3WcmMCOsRTUM1vzCcKsI68YDu6+NJqsuiWKdaA7RAnoLwN27/mbNSkwkIgwtieH6acVrenFU1OoRkZLAbaCJMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322763; c=relaxed/simple;
	bh=9dAY0L+/fvVVmeV7rFvMJHXnGU8TyAN8gQ32/HzNzLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AHnKIoBnF7jDYhnqvdwik1sPdFQihVlsXrW4MwI8y/bQadV7ZiNLAoiTp3s1fXF+Q/4Q+kyI73yKQVdr7Gndk2exZmyaMz46E50NTggdm6dU9E7801YzyV7b1laQLJOU82jBc5rReWIyC2xKeRvPA3Piuq7yOmzd5ZQVKce3rI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoAtx5Wq; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b679450ecb6so1650234a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761322761; x=1761927561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n8lMVMj1fovkZ+i7h1zKI+sBPWqmX8HhUJdjB0oD3U4=;
        b=WoAtx5Wqpeci6kw+NwvYkiuKphWXGOyyEOXVAAYGbNQVytzLi5p6Xa1vyp8GeIFdjF
         Cd3sKS/xiZkR8GzPEnD6Q7f0Sx3WbGT1Uo+2UljViPbpgaEjmbGMy5HVufA3Ki9P6xhV
         +I7l1pv9vnUZVwjHzWvpjG/Ckcj04cgzAIbeKmyoeemvL8HDWOK/sC98IpVRXTHj40Jj
         wwh82tLRALu/XUOoefhl5S1w/cx/E59cVBkiVrhixD/Hr5ZkHNRYxf2haLPddwj8Qodl
         suZQCIcSwZVj3EInwXTLBRvSVCPURheTo3ZmRtU9Wyem83VZlFFhzeZxnDH8u3+hFwQQ
         xugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322761; x=1761927561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8lMVMj1fovkZ+i7h1zKI+sBPWqmX8HhUJdjB0oD3U4=;
        b=jCSBpof4+RTA6LQ3jNGeHVqh9+KB1rASFqoXL9lvdGss27MyDJqH3DjBjzotUR8bd/
         zyrUqz3GkN7zshnI21/IW03nUEIP92hf7J2u0lNFcSzD412pCHtQIdCXcGjHO48gOftb
         uzCLlO4PEFGvOvwpUoWeF5HOlpbWKEzDqwQmWvGcw0dTFWLw0OyiTJp71fXyo+q9YItH
         FAr3/uEZOYx2tx6oH0z2c4Y5878PvVs0i2qtsfrV1OMdzgEyWm/FnlEg/NP4/ceOtlRJ
         HsORzwmBN3NrPIZFay3A72JbmdpySbrnSX3dmmZ7cKaxFibQ/xXjjgCfpwGFwBiFcPw8
         lyMw==
X-Forwarded-Encrypted: i=1; AJvYcCUEj04GpH4R90NoLGu5yahMMZFikZHx4GLiTStHwHpUqwQK5oaiSyKkjCWKvRaIsSLTJJQoRbepn8jnRta/CSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE6teGhdQm0IJxRR1VanB2G6C3h/E3Nkbs5NQPmayccoMu2NBZ
	ro0ZnvTS6tg93j0kJaiLoB/WkJPtgbrFB7/BDuUApbHw9lN6j6uQ8eAbn8xQZeTz43Y=
X-Gm-Gg: ASbGncs5eaApecKohMdlkvDlxS/mH46BZqkkY+vZb/7BNGiDWvg3QcDVkAnPZLh4S1m
	ge7WN32KJwyOsgoZXLM2/N6pzSMQbymImTTXipvP0DVl2k48maQ7GB1wUiqd1zVESr6RpLEhQM9
	88MuuMtyg+tn8ywotrlWGi3ksJ5tkjPKAf8xpF6AfWPJYtcjjXtIHUZ+i4Y8L9DT4ULtQ0b8ZKo
	syifTa+2DqFuVde97nXwkPqwAbAnZfPT92vSTZ8eNJP442fkS9CfG8HU3cy0PXXiyyT+D16vhYo
	JdSWj1ChbsJBD6rsExOkq2JqEcW3jIJYSiWyNUL3meyZgz4d6GLiWzQsSwTM+HFOmE/z3tNIfb1
	+O/QFIM1X+yBi3Og24Orh5DGGPuqntf+3Mg9ssejV8fN+vFocwYnWemcPkLRmCNdJJJeBmUgU2w
	heTgJ0nvXvaCLsdvuAhvQ=
X-Google-Smtp-Source: AGHT+IFNPsmsAl8NXf9o2YdrRIqhrCZlIqmrcjiRIz6/XHVLK6f87asKaFnRaec7IkTrDjOv4+L8dw==
X-Received: by 2002:a17:903:1a70:b0:272:dee1:c137 with SMTP id d9443c01a7336-2946de62ec8mr81593755ad.13.1761322761029;
        Fri, 24 Oct 2025 09:19:21 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274abf6d5sm6277685b3a.33.2025.10.24.09.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 09:19:20 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: shuah@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	khalid@kernel.org
Subject: [PATCH] selftests: tty: add tty_tiocsti_test to .gitignore
Date: Fri, 24 Oct 2025 21:49:07 +0530
Message-ID: <20251024161909.327158-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the tty_tiocsti_test binary to .gitignore to avoid accidentally
staging the build artifact.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 tools/testing/selftests/tty/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tty/.gitignore b/tools/testing/selftests/tty/.gitignore
index fe70462a4aad..2453685d2493 100644
--- a/tools/testing/selftests/tty/.gitignore
+++ b/tools/testing/selftests/tty/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+tty_tiocsti_test
 tty_tstamp_update
-- 
2.43.0


