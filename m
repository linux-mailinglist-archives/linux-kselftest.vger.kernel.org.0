Return-Path: <linux-kselftest+bounces-9845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103018C164A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B5ADB23797
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790A513776D;
	Thu,  9 May 2024 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ILO5DlI0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF16313777A
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284912; cv=none; b=jns3ljE5eqtX+jQ1kbrtiuGXXB2gwMjJttUDFT8O6RjKkfl01WgQjtCDaSreWZjr+Cesr21TiXBp+GNo+oLuguguS+kP2WGyH63ORzNm7HdICuO4BcUFfbruiZp6akyIC4WLE50zMGXWxOtJIF5EHviJ/egeOFGGMoi2tYgCkjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284912; c=relaxed/simple;
	bh=qbmkyF0+P08/z/Fp9ZayOXH0wErOspB3sKr8OqJ3zqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DXxLcYJgcNpIjIwU3y5KC7ksLuBd5AQymQOehb6V64ZHeOehAxmqoJgcA2+i14LBrRepdZTG7imIwsUjRequ5q087o0Tuvzu/s4qvKRHONbGJLjrVeVsLhxqU1nwn1fHnJcXTDL0syzf+PvV3WWA/VNFQ7lG4aAS2YACeN4hf3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ILO5DlI0; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b413f9999eso979481a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284910; x=1715889710; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7gmE/+1tJ7Ep2oqmr2taMm5VZCwXrcQv9eKCkUAc/7U=;
        b=ILO5DlI0jHo11RJEV1jUBlMw6NjsfU1gUR2zLuPOc9x4CaGpBT7LMLF6Yi4CS4xaGA
         PHLdHBbsi9u0CGsYKfKYS2DDxwvXME6WWy5KXqRXebLiOFJ6DVBz2On+fnDh+gR8KaX0
         QMhoBi+HFjI5luhHtGwhHzmnsronYEWvNnl1U0xAdQTZ4qH7kqVe5N0Hq7haPBgOnZDH
         ptQTmC00rByMG0oHAbrHcXMiwNeOEKLPHN5A8F8qcMckrzRrBm5uIksPfBnjrCPYauON
         HpkUrTRWhxOpnpdyUChzMHJLnHj1cccIbtDc8bK6s8RUuctTyBz7SaAD1phXucjvZi2f
         aLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284910; x=1715889710;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gmE/+1tJ7Ep2oqmr2taMm5VZCwXrcQv9eKCkUAc/7U=;
        b=oBr50EyswMbcIQ5uuBSc8IK+855yEDwdlixQuDVU4Nm8zus0jTKC2XGIP04ZdHJMDR
         iBCgBa0dIyC/X/0b3lu9OxisOur1qPsxTKURQ3QUgb5yzUzQFNkQwnwjKimHMx/9ywiL
         +L6PDB8MNJPvUaW7uYnaq77JTIiEttunCoJnTPyPxaLxqDihZdlvzExlTiVusSt6UUVX
         w/i3GG0RMYWhVJV9x9rAEdkX5dXHADezTZrF7xQl5PujOnPjb8o7ouho0ubwOMfJ4LDq
         +X9L/zPJu9vrGpSKgFQe0fNX6LD2lgfP9XwAqg4GhvvvFExIlsJjt6AvNp0dU7+RUkOV
         d/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH94pDgzX9YGQvbcthlSY5WIPSVgEefXXtx2n7nZPoRdLZbJGYHw7TD1dtVlDz0ZvFxy1P0d3PD1j8D/2EBhFZESfDzfOw2GdTrEykdlH6
X-Gm-Message-State: AOJu0Yz7zZVcdYIo8rHzzN1QAN0vToISdZr9l/EF3j0708JcW86gd+Xn
	XjPothQqsUgx1ASJglDr4ulcuIN/kJlS5BaN3klBiB566Ub3a+FmnNoPhoOW5f1HXXK1YKC/6Uj
	7aQ==
X-Google-Smtp-Source: AGHT+IF3buvEsw9DOzXJjxkw3k3YqiITNaAs3ILFq1pbZpyM91Xc9NI+NKd7Vfc3Nbg4dEut1dVjyl+bk+Q=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:ac12:b0:2b6:4220:159d with SMTP id
 98e67ed59e1d1-2b6c748112amr23447a91.3.1715284910169; Thu, 09 May 2024
 13:01:50 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:14 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-23-edliaw@google.com>
Subject: [PATCH v3 22/68] selftests/futex: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/futex/functional/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index a392d0917b4e..f79f9bac7918 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS := -lpthread -lrt
 
 LOCAL_HDRS := \
-- 
2.45.0.118.g7fe29c98d7-goog


