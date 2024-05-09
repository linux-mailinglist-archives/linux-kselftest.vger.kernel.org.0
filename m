Return-Path: <linux-kselftest+bounces-9861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EF38C169C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DC71C20958
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EB013D509;
	Thu,  9 May 2024 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VP9NXZHO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5FA13D51B
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284962; cv=none; b=AGOXqys5YO4AvGtJHjBRdAsMdy184SC5yZQ4XS7AJeODEHY/hlNO6nlpT+3ESC03Mz89cD5xml1CuYuHgi6CJP7pEwkw+MI5CM1XEAaGg1FcbhhIRATDd2A4M+XjNEzJD6lfWaeTpjCm8JnlsRbKjQMqFFWk2G/foJN8BzwzYvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284962; c=relaxed/simple;
	bh=3599aDO6WJ8pRytY2emWkuJQ2LbOev5tgOUVnN1o3YU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s/Yxue1xj3TOH4XaXMihHA71iJfqPbk02H3amXBCJsYzBQDU7xZfDfkjPfgV3ZIpxcGdJbdTN6aEcI4aoW1BiZm09mcnjD4WW23ENi28fCscwi4Xu060ZkOH9c0MCtfZifmleNf1XRFOGSS1EhrO8ELvS3o3/3QcKEO/4ugpnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VP9NXZHO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de617c7649dso1877625276.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284960; x=1715889760; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bektZwrY6X7Dpw89yPQbwlH2LMGiwkQluDbu3J3hz3c=;
        b=VP9NXZHOn4RE5Mu2gsDIWp6kxBYsJvV9xB9KBtPK7AmWtCmHkqK5OIHzDRolFQyp+L
         OQMzXGvg04+dPiMYx7yTfs9NSEwSA/rlNkZEuSoD842nES54GAjhsGxQK9RrIqa4+MLG
         QNJstqKmsNRKNy5zz+kqzoJG4tQfOgozlMgU9Z04RCa4nVAGNU51OJumyoEJOgdxHh9/
         xdxgU6Lbjpb5UTEGPcKJP+g4qJeTCcWRhvabaaLgZinDFZ2XgoSGspFjBUb9LMlhrN12
         epI68ShXT6/8IfnYitLdNhZXy4fLNJDVqq0+qOIpxfMOOuEcGDBmw4IraM2kuf1ZV1v+
         D2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284960; x=1715889760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bektZwrY6X7Dpw89yPQbwlH2LMGiwkQluDbu3J3hz3c=;
        b=oSSNU30PLBqIa5E4i96FGxnsWvtvN3EDnG1ZTg021Zi/iYBs/iMoqUPJs1B/7kEpt0
         a3Lht6jYu+uRSalkGSq2Uz8bbYtby9vIpv4ZAQCCqxN1gxb5QDxpkr+FiVeKFzyNUdpb
         EHuivCqWQw5lKxvUhOgXjQ7TUPgij0lScnxdm/S6J9tg3uaVjFqdgRYQI5ZZ56OKEKOh
         Omo07hk+caDBuENdQr9fo3fQbj/xMsAlyZawqxZAau4gWg+vl5neDs3C9+L2S2QGTNze
         34fu5aJ7BRmaAb9omBA5RU2+YT+uJddoUgc6TYGDYizI+PuAxeV2MIkxTL0tRQudHKAN
         d68w==
X-Forwarded-Encrypted: i=1; AJvYcCXcRrJUUuOyr3JEoCjTfQ9vqUidDYEmJLjq+bLCfddsa4WTTTFlTMfz8mQN0tJtCgQTgU6O1tAMzHACjiwyoOtpMafNrXQymmwzBTIhnQTQ
X-Gm-Message-State: AOJu0Yxxw8QsQsMLrn3aXqAxKCnYJm/sI7TwGgFoismug5BaZYrTm8/9
	qCvBpimk4iDK6Ki2bQnNRjSgCmJM3zaWLmn9e9u0CXm6k7/ZoWAPoGIGLKDYoBSZa6mxa5QcwiP
	2xg==
X-Google-Smtp-Source: AGHT+IHEPIgVySZLbvq9qgme/sMXplcMjKtrRTfWsK6m+jYlUbK8Q8RcqLUbNvwspV02hcVRppHAU40NpqM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:db81:0:b0:deb:88f1:7d3b with SMTP id
 3f1490d57ef6-dee4f32dbd2mr64276276.4.1715284959917; Thu, 09 May 2024 13:02:39
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:30 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-39-edliaw@google.com>
Subject: [PATCH v3 38/68] selftests/net: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
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
 tools/testing/selftests/net/tcp_ao/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index 522d991e310e..c608b1ec02e6 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -26,7 +26,7 @@ LIB	:= $(LIBDIR)/libaotst.a
 LDLIBS	+= $(LIB) -pthread
 LIBDEPS	:= lib/aolib.h Makefile
 
-CFLAGS	:= -Wall -O2 -g -D_GNU_SOURCE -fno-strict-aliasing
+CFLAGS	:= -Wall -O2 -g -fno-strict-aliasing
 CFLAGS	+= $(KHDR_INCLUDES)
 CFLAGS	+= -iquote ./lib/ -I ../../../../include/
 
-- 
2.45.0.118.g7fe29c98d7-goog


