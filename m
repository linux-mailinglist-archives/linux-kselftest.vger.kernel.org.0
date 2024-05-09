Return-Path: <linux-kselftest+bounces-9826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B318C15DF
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFB01C23026
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589DB85270;
	Thu,  9 May 2024 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YbxhrzLJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BA184D0D
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284851; cv=none; b=aCR4qUn7ouxUE21Lx4KbB1hxJL4T3fjN5JtwKr77Y4jqCSxdxE3VZ1MV5oPUcXBhrNVomwzim+jjxJYubPfsmCQE2iiKWNpHuZYDRP5FDBYbPhjDXMl1sXGSS/DzVcd9ZueBswPIlUxKfIk8k+bg1Hw3C5v8ZiulGpoQT4xvHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284851; c=relaxed/simple;
	bh=olG+XfDL3xDdohtjq5mUHNgjYfinvarWZWSY+TyFh0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wc3wRkLYW6J4oQW8aEzbE6g5GpJOqPJp4w4rKmI2hi4PSJqJZMlKmF5q1ojPPJdi6hOemLrrRkgyHb+95U+OrlLgOiXJxMl31t/zCxDyUhbXlqblKR5nkcnIVVnP7NdQdtodCgkUEwmbTbg0U/AgWaA2mFhFH3dDVPEMWp4iFgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YbxhrzLJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de59e612376so1748925276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284849; x=1715889649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8CLdotFEq8j908dUbT6RbcvFD+YTCI0iXOlq7nFkwSk=;
        b=YbxhrzLJHfALsYA/PUh3m3WC4pHJpa3lO7g+ECbMiaUbh/ATox7Wt71ok3O00i9peh
         sIJDw27zFF36Waua/LrOBQtMWzpBxcu5PDn5wnk4RGSlAc+IpSqvmIZ6PPLHTONDuMu4
         bCFKATO65omrW3g9qKAAhwtosIW6+IlalFJiw5YfP+yH7fINC6/sXa7358MgqbGaw8XG
         PQqbNKxjfuu+SF62l7ABcnpm/5IHBZhJAfsc8vuWH0b00Znf/908z4QLf3SUdtDn0dqg
         5AOdTORHvH0K3RrY/2NaJSHidUh89a/tNXPo5sAKJK3VRncTfKq3FGwjH4NOq6A93aCC
         UE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284849; x=1715889649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CLdotFEq8j908dUbT6RbcvFD+YTCI0iXOlq7nFkwSk=;
        b=Cw6djmFc7Egm6u5PkJbh+INU+n2/jLyuzBKk0YF1YA1/03fDGkGMNfyMwZyd5kecIk
         e8xmNenZMINgk60er7+48aJDQ87hLFXBRcgATkNxdTbjmjDE97CvgBxYVwFgDD9QwOCm
         QBWtY/ZDpgfUjhBe0TKwLFUwgYu0mqEKmaa/Dt7RFKmKZMV42mw4TS1fLfaOWGw9ham6
         dAzv2QZ57XvRjI1sd/NkBpV8eh8HbbY28HVLwK8e8A605IZMVj58Xr2WkYr6iruVUJgA
         XiXnGh6AiYithorSPlM094toeZOjvP3yasgktuOQaHfTBo0l6fGs2RJb6WchQf4n9Ao4
         DZuA==
X-Forwarded-Encrypted: i=1; AJvYcCUrhHw9ALEDR6uHOZTUNUT6gMrx3BXEt8aqi7ZtIpEP1+tmfGThKQbxPK/3wHGqFt5m+4eGZE21tj4ir4kfbmg7iCrDPWdocrJ5MgZIx+8C
X-Gm-Message-State: AOJu0YxfWjp5rxR965ggcvu6DUY0g865wvYeKQGziepO7gkSVlMppOc2
	kdW75UecudbEP9293LhJgEj5S3iBuRzbYfU+m0cyTz7Cksjv7hGVNaU55f0rbFUUUUyrPKIVNh3
	RZw==
X-Google-Smtp-Source: AGHT+IGZb1++ccVRLEMIHpSPN2qAQJXid7wFD4piJoYbkIu2XX8BrfoTxjJ3q5NtoiGCFIfHJDyo+fBfXww=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:705:b0:de4:5ce5:2656 with SMTP id
 3f1490d57ef6-dee4f301355mr46992276.8.1715284848710; Thu, 09 May 2024 13:00:48
 -0700 (PDT)
Date: Thu,  9 May 2024 19:57:55 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-4-edliaw@google.com>
Subject: [PATCH v3 03/68] selftests: Compile with -D_GNU_SOURCE when including lib.mk
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

lib.mk will add -D_GNU_SOURCE to CFLAGS by default.  This will make it
unnecessary to add #define _GNU_SOURCE in the source code.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Suggested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/Makefile | 4 ++--
 tools/testing/selftests/lib.mk   | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f0431e6cb67e..9039f3709aff 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -170,11 +170,11 @@ ifneq ($(KBUILD_OUTPUT),)
   # $(realpath ...) resolves symlinks
   abs_objtree := $(realpath $(abs_objtree))
   BUILD := $(abs_objtree)/kselftest
-  KHDR_INCLUDES := -D_GNU_SOURCE -isystem ${abs_objtree}/usr/include
+  KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
 else
   BUILD := $(CURDIR)
   abs_srctree := $(shell cd $(top_srcdir) && pwd)
-  KHDR_INCLUDES := -D_GNU_SOURCE -isystem ${abs_srctree}/usr/include
+  KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
   DEFAULT_INSTALL_HDR_PATH := 1
 endif
 
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 3023e0e2f58f..e782f4c96aee 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -67,7 +67,7 @@ MAKEFLAGS += --no-print-directory
 endif
 
 ifeq ($(KHDR_INCLUDES),)
-KHDR_INCLUDES := -D_GNU_SOURCE -isystem $(top_srcdir)/usr/include
+KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
 endif
 
 # In order to use newer items that haven't yet been added to the user's system
@@ -188,6 +188,9 @@ endef
 clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 	$(CLEAN)
 
+# Build with _GNU_SOURCE by default
+CFLAGS += -D_GNU_SOURCE
+
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
 # make USERCFLAGS=-Werror USERLDFLAGS=-static
 CFLAGS += $(USERCFLAGS)
-- 
2.45.0.118.g7fe29c98d7-goog


