Return-Path: <linux-kselftest+bounces-9967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C3B8C1B6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCA01F21B3A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5210A13E033;
	Fri, 10 May 2024 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMrb/fZw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653C13DDA7
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299909; cv=none; b=GfWRLTZa82ONukbAlQ9MeA1IC5ZQJudtXPw5wfmZelmhxiAZ0C3S2Cl5jErF82xvuR8VhYu6uWo7ukyTnaFCImv1WL8awS13fHo/ZrzBVSBpjwtx4Uyt25lT/qS6I9up/tJJ27lDz9Lajp36z/iuC4AIZWtqF1QwK0pTMcG4QDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299909; c=relaxed/simple;
	bh=ePampeVNrBlZKDN+0BSw41zefNA0MNugUHscvuEKTwc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BLyC9gvsROKKvdACEk4RGL8C0FfWDRWwlAcbYsBGetmtZuH7RrcHM29XihlPaOZrX7Pa5HA8erWw6NqM0QO6dYTwk4we59tBJ43VZl9JEMaXg6SvuTyDBJ0EVHbcQaEZV3T8ckXQlZO1o+tIq06OY9sw/UEa5a9rKXFbpgC4JZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EMrb/fZw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b413f9999eso1102931a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299906; x=1715904706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm4mQmUfjR+WgpaOe5aEacZBA1kgFDY/sgKTjpP98e4=;
        b=EMrb/fZwcD55D5cFaUrWtFupfB19CKLb10vUjZEUOF93zz3lCAv7BsGYS2sjE6nNn6
         hZuoq1LT8U6L5ZucLHv5xZhL/1qv0kErwSxfolpu3w6kG+LGjLMYEyhx5YYGrfLj8NvU
         59whe+okJaZfHSubpaaa6X4M7JQAx9asb1nVuKwoGKtoth+dMecAMc4RGXPZtJJy/SYH
         KhMDfFoG4T+l0BvRGmt/RuwVOjcPG1I8Tzw5QbzE9mWqvhV/hVnieLm8vBRqYZ4ECx38
         mhLt22bj/WmZ28uhC+s1IW7+v/q7nO2Nl55efKuZWZ/xntx/I4UulCer5IrhE+Fq+Ama
         +uzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299906; x=1715904706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm4mQmUfjR+WgpaOe5aEacZBA1kgFDY/sgKTjpP98e4=;
        b=jUl6hfMKpY1KKBiLRcX9r1csZ0DeXJTtrQsWKkoFukpI/2JuAR1jHSAT3iY+J5/4GA
         FG/hjGXtJwHv7cz6ZxejjDU6xvaYYQBrnVXKRVxWAAIYotipmWTufKTuD/gO8M1cDBs4
         S/8zLMsnnaPbKIKbHqzDOYYu2u7uFHlv8ys5I6K4xHPsZFVMLDZq1TqJkz15tV1unySo
         jVuBmrENX0B9KbGziiHt0fQ6G7uO4ZdphvjZnzOangCvIRFEPEL5TXhJn/8bb6DogqSj
         yFNJPXbpf3kR8nRbmIHr8JxfNdFf7VZS/gED0m4d9pgmHM9vxuHlqk5rCV/lSqslM0zs
         kYsg==
X-Forwarded-Encrypted: i=1; AJvYcCWusPgRYy0Bt63Ha8n5JtieierzFd0Iw4eeTp/eCjyJ3GnLOPO9kc8AseiyLzz1ZOWMmdm5sG6iZo2t/31+iCmMWamD3sUSTIPAmQklJysl
X-Gm-Message-State: AOJu0Yz41egLW8jz1FW6rprrBOmECzPjHSirmrhzUBCnjf7rBl8ymyMR
	T15MV1MNpjRINmxG72iuUjEXvRzTTTQm+oTWzPSXRQXx9fjPOeUxrCYf6JutoQuQoi5/xnFdGgT
	ChQ==
X-Google-Smtp-Source: AGHT+IGGq3KFPEwa7lhjHSB9rjlQ5hpVHZZ8faELDrI+h0bXPf/lmpDE5vCfaX29bPFEVhT8vg9UMGQRxfE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:1f8f:b0:2af:499a:fc9b with SMTP id
 98e67ed59e1d1-2b65fe1f31bmr26724a91.2.1715299905725; Thu, 09 May 2024
 17:11:45 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:13 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-57-edliaw@google.com>
Subject: [PATCH v4 56/66] selftests/sigaltstack: Drop define _GNU_SOURCE
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
 tools/testing/selftests/sigaltstack/sas.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index 07227fab1cc9..36b510de0195 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -6,8 +6,6 @@
  * If that succeeds, then swapcontext() can be used inside sighandler safely.
  *
  */
-
-#define _GNU_SOURCE
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.45.0.118.g7fe29c98d7-goog


